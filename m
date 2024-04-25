Return-Path: <netdev+bounces-91261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBB8B1FA1
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48651C20A09
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A122625;
	Thu, 25 Apr 2024 10:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6C0208B0
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042310; cv=none; b=Als69cI09SgfPk+JDAfHpEgB+6rcTV1zpFUIWrJGYOx6P+7+GEzFGu0NFpMo1yqok6s6QJ5hWHv1v64DtWDKWuyEtYmne6l3+9k5fDxa7OAQh8opPmBLYwZxWfvh2ohSaSdu0xh2ei7SuaVx7Dp7yN9i1JLSdAlmYkYYR3ny8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042310; c=relaxed/simple;
	bh=0aAEOOQw/QRRYv4rzeP8/VnxLuD8cae+s5CYJAZR3ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6xjwwZ4aRt9R3+8Jy//EyDqTTupyqtwdf0pCQAb0UFQtar/xAp4tjihRpTOp/TMNtpnqN50fHjF/BzSxScjdbxv6JigjwfIPZAsZF0kGG/Dt0iWOHt/NZBLKNoRBgb/vO45qsAHjdOkQDBD50AG1kd08CzWWPpm6wVt06vFUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 01/12] gtp: remove useless initialization
Date: Thu, 25 Apr 2024 12:51:27 +0200
Message-Id: <20240425105138.1361098-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425105138.1361098-1-pablo@netfilter.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
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
index ba4704c2c640..4680cdf4fa70 100644
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


