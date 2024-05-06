Return-Path: <netdev+bounces-93883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157CF8BD846
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B0EB22076
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF115D5B2;
	Mon,  6 May 2024 23:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2315CD7D
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039587; cv=none; b=PT3WfwGeYWApQWAbgCTpK8zCVDY8zqvVNjFWdF5r4FtexkoO0uJGPRo9+YVPf4k6u1tdoxZ6HZWTOgYkLHqAoW5MFC5pdoOMbJgEwM0IP+xwmOtQtMxuxzBNpP1/oy3QSZoFeSN8P/Jm4C211FoLasRwUZL1SppYXFvq4gtE2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039587; c=relaxed/simple;
	bh=E8rECKVrF0LLgYahIg6B13VopTKRoZf0/8uNUvkXSWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ItKaZcbhGEJn3F2z47dutiupkGc004S+BfL+bWinMsEOiOIspqS+u7HtTlZab0DkUnt+Xok3UCx94Jv9+u2hy+DLvd1taeKhjXC1ITWQQnPsCFrZgNMfLwOJnV4W1CgH1XqBFAE8r+krOBp/xaOPW07qs2DwPu7Gz7XtTaSyeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	horms@kernel.org
Subject: [PATCH net-next,v3 01/12] gtp: remove useless initialization
Date: Tue,  7 May 2024 01:52:40 +0200
Message-Id: <20240506235251.3968262-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506235251.3968262-1-pablo@netfilter.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update b20dc3c68458 ("gtp: Allow to create GTP device without FDs") to
remove useless initialization to NULL, sockets are initialized to
non-NULL just a few lines of code after this.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index e62d6cbdf9bc..dffb99a97e0f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1009,8 +1009,8 @@ static struct sock *gtp_create_sock(int type, struct gtp_dev *gtp)
 
 static int gtp_create_sockets(struct gtp_dev *gtp, struct nlattr *data[])
 {
-	struct sock *sk1u = NULL;
-	struct sock *sk0 = NULL;
+	struct sock *sk1u;
+	struct sock *sk0;
 
 	sk0 = gtp_create_sock(UDP_ENCAP_GTP0, gtp);
 	if (IS_ERR(sk0))
-- 
2.30.2


