Return-Path: <netdev+bounces-73355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747685C0CD
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A13283FDA
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12F76405;
	Tue, 20 Feb 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2bJ9i37"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EFB763FE
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445479; cv=none; b=tAxwSyhuD7REQYiOM4N3t/ywxfiP8WPX62RELpTDqeOpnYy/nroRQVTZYZZUQYmcFf2Ww7NS3s8QTufExWKki0EMuKj2osLnMvC+Pr7K/t1IJXAaMRMLd2AlI6Ei74uU5QRe2jgkj8amFDiMoshV/btjzENTwLn5bBA7/VJPx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445479; c=relaxed/simple;
	bh=KVaDRMn8RBuzqzbMJ/irHhUoeaqF+eKRBP1Xpo+5kaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTO9TVxspdCNgs15whZoBusS2wMsHdPOJEyLa0m6QQKBwanriXgWXxjBvN8LWD18PmNwPZujbqVnru8ktQfPHyXH8VZHcc3h0Uh1j0jGN3ipC/osK0USdBqJZw7zviYmCtZHU+lVC3FMplsqT7KaZQf2i4ROAYksINPA1qjkKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2bJ9i37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBC1C433F1;
	Tue, 20 Feb 2024 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708445478;
	bh=KVaDRMn8RBuzqzbMJ/irHhUoeaqF+eKRBP1Xpo+5kaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2bJ9i37cmRJegXslsw0J3tfvgznVqPHvK5Kr7Rn/1yE+8rSodG4B7pifCGJeL7YP
	 A//XW0uKnwYZqtiwi5e7NVyXbsEcJs4K9dQu92sc+sOjTcID27ngv7WNMCdgu4IhOi
	 LHhAe7oob0p6+QSi5UAvPCCIQGLZfv+fevhUg0F2lh2k9/Tf1cVyPUMqR4sHjkF/mb
	 c/1Bwp+eZ64zdyRXdNUx1V8ZbyBcaHYYjyvOaBfsiUDJwBEGu/Ge5Neqasjbi6iNBo
	 R882bJ+XNJ2Lx0Jmfxe7Va6+PoHx3o0QuwoLQuZDHcGtP00DJnxwWxkFZSFCFXR98g
	 RMWsJF6BPIuCw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	chuck.lever@oracle.com,
	jiri@resnulli.us,
	nicolas.dichtel@6wind.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 2/2] tools: ynl: don't leak mcast_groups on init error
Date: Tue, 20 Feb 2024 08:11:12 -0800
Message-ID: <20240220161112.2735195-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220161112.2735195-1-kuba@kernel.org>
References: <20240220161112.2735195-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to free the already-parsed mcast_groups if
we don't get an ack from the kernel when reading family info.
This is part of the ynl_sock_create() error path, so we won't
get a call to ynl_sock_destroy() to free them later.

Fixes: 86878f14d71a ("tools: ynl: user space helpers")
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: nicolas.dichtel@6wind.com
CC: willemb@google.com
---
 tools/net/ynl/lib/ynl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 9e41c8c0cc99..6e6d474c8366 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -588,7 +588,13 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
 		return err;
 	}
 
-	return ynl_recv_ack(ys, err);
+	err = ynl_recv_ack(ys, err);
+	if (err < 0) {
+		free(ys->mcast_groups);
+		return err;
+	}
+
+	return 0;
 }
 
 struct ynl_sock *
-- 
2.43.0


