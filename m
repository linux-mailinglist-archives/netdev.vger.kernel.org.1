Return-Path: <netdev+bounces-90544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516668AE708
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A9C1F25AE6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212B12F391;
	Tue, 23 Apr 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="j1qNN91P"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541C12DDAC
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876692; cv=none; b=nosWq2utIC07g7JGemDd8wYymBEihZ1QwdEs+O5y0EO6G+5xBHONcP/DfnAOQENG5+ys1F/N1qE3BTQe0snclIt8eUnX50NIy+5Yg/DzSPxFGbhHF+WFkKj+YFbtbfHYiBrcjTQdnG45dPFVl/+hnZkZDNY4eIjSxys7axR8KvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876692; c=relaxed/simple;
	bh=+qHZ8hKMsG2TCvpVNq3b3f5G4B+/z6iOLRClJQQxTkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMK+/NmcaY+J2DIUY0pF3RCDvwlCZxdFzIrGS/MsXZucitf4r74PAh6iVTmRV8KlXV7lfGA3ws/+cD0h8y6vPzUOfg8R27EWDHljHaAY2DxRTH5Xq9q5Fp1RWkKi4xFHuWj4kAIDEvSpSzwNliyO2uW/uh+lg1s/DKsL9Hz2oTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=j1qNN91P; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 204B32074F;
	Tue, 23 Apr 2024 14:51:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZnOhb3zi-sfZ; Tue, 23 Apr 2024 14:51:28 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8BABF20518;
	Tue, 23 Apr 2024 14:51:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8BABF20518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713876688;
	bh=PkOVy0Xg18j+qbliAAaPHXWfm6l1g+br2N1BH1POPZU=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=j1qNN91P9THgsjS+G5v542R13m6kDCp9HNyX0yAbS2EYAoxhY5eaFCrV+UFMymwbD
	 BaCdnrT18FoLL8eKHaKjKs3v/jWCzllknbs3Pun0FYlmmeImku/b71+fFzuoJksN0l
	 WH/Jhv68lOyuC86IKywU9nbImXY7S3SPixy84IV00zvhijl25vkksLXvkuSVZPFbEC
	 MlnfasX9Af2sT11cqq58Hpfz3U2VoKJc+uuxiDaGjjR9q7I1sgDX+Na7DRgVxZKJl8
	 mohHEX9Mcv3UJ4W3/G/SiySnWoUF7cI0qYAbkwzu7vQobT8y0pCt+Qzy1YCld/zPjn
	 gzOZF7xdrx8AQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 7F26380004A;
	Tue, 23 Apr 2024 14:51:28 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 23 Apr 2024 14:51:28 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 23 Apr
 2024 14:51:27 +0200
Date: Tue, 23 Apr 2024 14:51:21 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v12 4/4] xfrm: Restrict SA direction attribute to
 specific netlink message types
Message-ID: <718d3da5f5cd56c2444fb350516c7e5e022893c4.1713874887.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1713874887.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1713874887.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)

Reject the usage of the SA_DIR attribute in xfrm netlink messages when
it's not applicable. This ensures that SA_DIR is only accepted for
certain message types (NEWSA, UPDSA, and ALLOCSPI)

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v11 -> 12
     - fix spd look up. This broke xfrm_policy.sh tests
---
 net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d34ac467a219..5d8aac0e8a6f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3200,6 +3200,24 @@ static const struct xfrm_link {
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
 };

+static int xfrm_reject_unused(int type, struct nlattr **attrs,
+			      struct netlink_ext_ack *extack)
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
+		err = xfrm_reject_unused((type + XFRM_MSG_BASE), attrs, extack);
+		if (err < 0)
+			goto err;
+	}
+
 	if (link->doit == NULL) {
 		err = -EINVAL;
 		goto err;
--
2.30.2


