Return-Path: <netdev+bounces-72594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05427858BCB
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941AC281F48
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6D1EB54;
	Sat, 17 Feb 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqlV2xOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D891E898
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129070; cv=none; b=pN9L85BwYwM2VTGZGDwsIIa0mvJfp5VcGGP2mkptjFQaJXPNoBHQKsCvTMvg90RXQrSP1uiQVza1JrWG5+lTUrE6KwUG/KpIYvMCPAvds91OUijZUyWNPPReiUqlzTzvSiwBLUBf8A7MPlXt6SgMJRlbyzG0jarrtA+98UkQ3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129070; c=relaxed/simple;
	bh=zv+JkjbVFI8WBMprrN/D+pF5xWCIhj3B1Sq7vqYrFsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyxwZ0P6hkVmi2JSjXjORuclNcoKS7HvOEOR5STUH/mCyxJrNYvzm97WgM2TQ9rfrwLKP8l+BY4WBVWmeu4itwwTzd50/XAM4DlNvjkKBgBqan2lkD+bvsUMO08lya3lvuaCH9+d7pex8UVmOoafkDgsYvF9jyDYhjw4ETesOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqlV2xOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBAEC433A6;
	Sat, 17 Feb 2024 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129070;
	bh=zv+JkjbVFI8WBMprrN/D+pF5xWCIhj3B1Sq7vqYrFsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqlV2xOOXax/PGdWOZnRpAD+tHLbQUoVskgQ4EfReqAvYuym/QTtcH6hFQ63yxWH+
	 FN4mMXkO3wx1NFpoLgJ3MHq8X3puOzZB9EeXnUEUnJMI3KYwF6jCqc8bpAOUv0SD/i
	 wC/YkCBY6XoVpSlnV6cUFx/QKBrubD7uWk1KHvXyqEsUGQNzDiNYGHTFcRIKc6JvLq
	 d6BJ5+SciuC3qNhnigz8BdfQepABDEBPY3URhCImfiytdxk8oMGfXqkgg/XCWJ4omc
	 N2JOzi91qbCAdcQ/kSTX5XGCDoZSaT8a7Cy2o+1xCviOqoj/8mvWPAfahN3kObHCxs
	 9Py1Lc3wL2Kkw==
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
Subject: [PATCH net 3/3] tools: ynl: don't leak mcast_groups on init error
Date: Fri, 16 Feb 2024 16:17:42 -0800
Message-ID: <20240217001742.2466993-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217001742.2466993-1-kuba@kernel.org>
References: <20240217001742.2466993-1-kuba@kernel.org>
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


