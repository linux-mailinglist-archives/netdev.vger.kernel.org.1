Return-Path: <netdev+bounces-150987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF89EC47C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC96167C0E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845331C3034;
	Wed, 11 Dec 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mz/lK8K7"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57D1C2443
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896608; cv=none; b=GO4EoBFXeNCXZTx8ICfGHglThd6+KL0ImgXQUK4qumBdUiptRpddf0BO9Hf7j1yzYLLblNebqTl5lV8hk7rc7CWH3lUwZTMcC/68bh4c0X2hqydbfv1nAnRpRzAHh1xtliKWDmrSRSCOQJjCTRhEKmYEk6op5rXgT87P5WHpXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896608; c=relaxed/simple;
	bh=zG4xYnlL5MZpjXQk8bFD2q7yVBFk76zqR2HIJ+/SnBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUn9zsOqqWK1zT4SrcQhCBMHqua5hAfpy2joIOleLdSdix9MOWe7iEmALPIafr0xpgz1D6cfMK9+M4N2ED2jOeOiqOyw9sOPsy8aeT6lR8J6Dtm3+S6HDxnQuSQFCPJ9I/JY5IllkC5tNxZLSYKFV/g/NarEeqXk2EILos02Tqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mz/lK8K7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733896599;
	bh=GZ3naxuerQVhPMSIil0y3o5CAa2XGiADEu0kAQrOeuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mz/lK8K78WLudGHR/3edlj5xxlYolF1N7yAcV2tqmI9BAHEvOoIsOMx7ufgc5N0Ae
	 uYmZxj8Wenx4McZ4CvkwrcQMrF5Qdmx88w5QLWftmlzxzBmp580pxIdeY30mtErzlX
	 hr/Rv2/aPxo3dHmd/m/KlzK5+PHvxm4WjGYLuJcB+t/jHmcZkbsvB470n1HJiDK3ct
	 goWd1c/ZkOX+kDI4Febf3ILJaEbmbmU1bq1PVXKViRn/5bg0kHMo2qD3zAxLWzKUPZ
	 2NB2WiU65SHVZPqSrExdMLooGvoQl6i5hWA+HSRHlYx81JGX3prjAunoDPwcnqffHq
	 EJznkd3lhGa3w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 419BE6E568; Wed, 11 Dec 2024 13:56:39 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Dec 2024 13:56:17 +0800
Subject: [PATCH net-next 2/3] net: mctp: Don't use MCTP_INITIAL_DEFAULT_NET
 for a fallback net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-mctp-next-v1-2-e392f3d6d154@codeconstruct.com.au>
References: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
In-Reply-To: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

INITIAL_DEFAULT_NET is only the *initial* default; we should be using
the current value from mctp_default_net() instead.

Nothing is currently setting the default_net away from its initial
value, so no functional change at present.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/af_mctp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index f6de136008f6f9b029e7dacc2e75dce1cd7fd075..87adb4b81ca3ee7d240c80a8a40c4a2e8a876075 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -353,7 +353,7 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 /* helpers for reading/writing the tag ioc, handling compatibility across the
  * two versions, and some basic API error checking
  */
-static int mctp_ioctl_tag_copy_from_user(unsigned long arg,
+static int mctp_ioctl_tag_copy_from_user(struct net *net, unsigned long arg,
 					 struct mctp_ioc_tag_ctl2 *ctl,
 					 bool tagv2)
 {
@@ -376,7 +376,7 @@ static int mctp_ioctl_tag_copy_from_user(unsigned long arg,
 
 	if (!tagv2) {
 		/* compat, using defaults for new fields */
-		ctl->net = MCTP_INITIAL_DEFAULT_NET;
+		ctl->net = mctp_default_net(net);
 		ctl->peer_addr = ctl_compat.peer_addr;
 		ctl->local_addr = MCTP_ADDR_ANY;
 		ctl->flags = ctl_compat.flags;
@@ -431,7 +431,7 @@ static int mctp_ioctl_alloctag(struct mctp_sock *msk, bool tagv2,
 	u8 tag;
 	int rc;
 
-	rc = mctp_ioctl_tag_copy_from_user(arg, &ctl, tagv2);
+	rc = mctp_ioctl_tag_copy_from_user(net, arg, &ctl, tagv2);
 	if (rc)
 		return rc;
 
@@ -475,7 +475,7 @@ static int mctp_ioctl_droptag(struct mctp_sock *msk, bool tagv2,
 	int rc;
 	u8 tag;
 
-	rc = mctp_ioctl_tag_copy_from_user(arg, &ctl, tagv2);
+	rc = mctp_ioctl_tag_copy_from_user(net, arg, &ctl, tagv2);
 	if (rc)
 		return rc;
 

-- 
2.39.2


