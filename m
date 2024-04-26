Return-Path: <netdev+bounces-91589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145EC8B31F9
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CA31C21E91
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95FB13C8F0;
	Fri, 26 Apr 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SNGDCotE"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0513AD04
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118771; cv=none; b=BicnRbLv5tMwCi9Hb8ns+sYlg/q9Iy6sqB4ErfmRLryMXPwDxXUbHexPDLPjnqNwpHXxOTUoOapTs21GxewJtoPL0Fv53RncdJ/GTJ5VXXMimvN9g2qFX5MO5T5ZJnrGx69k42Yr4hH+10nyXZsGSyaLr6bo4ABuJsXrO+ZjJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118771; c=relaxed/simple;
	bh=gZE+yVvVHW18i8ArWkqNeZ9lEX82xV7jJguIo8KAnd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlb9b1sIhTSlgntn2HBBfQI863lnoIUANJFFGWw63LwztIpYTVvuBDcWCKNMD1TpHzEoQvwpZFeFFYd9xvhdoU0tCN0CetWvEKB3VQUSwSOwQGTJLP3JpNdg+c7nFmiLql+RIOlrX9SKm0Oxh+7LhQut2UgX51ovW7N64XxZMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SNGDCotE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7D9E820872;
	Fri, 26 Apr 2024 10:06:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6G1uwrbx40G7; Fri, 26 Apr 2024 10:06:04 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5187F201AA;
	Fri, 26 Apr 2024 10:06:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5187F201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714118764;
	bh=NNKR9vY+a44TzoX5MLLVq09DuILwSrwTt1FZmvhl2FA=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=SNGDCotEVu9XAre1OI3KYPRGoTu8Rrt0M3plkr4BIybzOQ8NclnBFWG7c9usCXXiT
	 vevTyeT1KqFt7vfa2NTFpczNpcooUf40S51IVZ9nOX08a0nDAIrXH0XloGat8kZSNo
	 3fsYed2W1eTJgywCcBRRCw7jmspUGhCvpGUk6d6KtuHK73+jDcGlgtD/JFXDkOad1h
	 jGZGZhoRs07qUkt6+KEYcoevEH/hgMQIQvdvxrSvcpJy0EiGYibZ7qbf0o6I1lae9+
	 163LYkevx51JLd+3g/SiO2zxP1Paj+13hKWEI/5QGJAHJi2cj/2/vVTPjpAolheRxm
	 GxQ+VL24NTbmQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 44CF080004A;
	Fri, 26 Apr 2024 10:06:04 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 26 Apr 2024 10:06:04 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 26 Apr
 2024 10:06:03 +0200
Date: Fri, 26 Apr 2024 10:05:56 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v13 4/4] xfrm: Restrict SA direction attribute to
 specific netlink message types
Message-ID: <8b3669fa6ddaed4b8ef5ee32bed76e2b8ab1f0a7.1714118266.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1714118266.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1714118266.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Reject the usage of the SA_DIR attribute in xfrm netlink messages when
it's not applicable. This ensures that SA_DIR is only accepted for
certain message types (NEWSA, UPDSA, and ALLOCSPI)

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v12 -> 13
 - renamed the function for clarity

v11 -> 12
  - fix spd look up. This broke xfrm_policy tests
---
 net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 65948598be0b..e606c3012471 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3200,6 +3200,24 @@ static const struct xfrm_link {
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
 };

+static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
+				   struct netlink_ext_ack *extack)
+{
+	if (attrs[XFRMA_SA_DIR]) {
+		switch (type) {
+		case XFRM_MSG_NEWSA:
+		case XFRM_MSG_UPDSA:
+		case XFRM_MSG_ALLOCSPI:
+			break;
+		default:
+			NL_SET_ERR_MSG(extack, "Invalid attribute SA_DIR");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
@@ -3259,6 +3277,12 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;

+	if (!link->nla_pol || link->nla_pol == xfrma_policy) {
+		err = xfrm_reject_unused_attr((type + XFRM_MSG_BASE), attrs, extack);
+		if (err < 0)
+			goto err;
+	}
+
 	if (link->doit == NULL) {
 		err = -EINVAL;
 		goto err;
--
2.30.2


