Return-Path: <netdev+bounces-89897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74758AC1EB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 00:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0241F21126
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3BC433B0;
	Sun, 21 Apr 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uMnPAaZS"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF247A58
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738609; cv=none; b=Nvksd3qIb+hLJ5jDgMeiSfrRRSIK3U/nNNA+3qBk3A7KjL5YUGzqi21R4OxIUYQNKqeCPm9QBx3y+8G5pTu7nNaAgLqq6zCDDUuT/lNLcafpD3kVAXMSnV1tpfYw5lOKvp0r/hhBp9DkeAFjE2iRt0sOHfu0P8FTceMFE67vt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738609; c=relaxed/simple;
	bh=4hIRaY6xmhlmxz0VG7lWJcTY48XXcrbW38D+5v4Eqrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTDdPsQl2DD9BYFljdcigQVr50KMa/L9Cg61sz+puyDs2D9QL5PsVHZVPk4g50TT8THoPMJTsu2n8VFuy8W+yrw62CJVr8KHqPi6QzhPUMl2zrzOiceICR7/wVmcZW6DIjYJsvkrP/qwxgXLT1iigMWyQ/bLnxkEC6Qud/nj3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uMnPAaZS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D25F220754;
	Mon, 22 Apr 2024 00:30:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vd6r9eAJoVN; Mon, 22 Apr 2024 00:30:03 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6B52120518;
	Mon, 22 Apr 2024 00:30:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6B52120518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713738603;
	bh=KNAxMsczrqZDsu/xlM7fSJIDMP2DP9TTYh7cXrt/ot8=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=uMnPAaZS/pEuF/+hG8hEGRtGiIsoJKLc53pZuJ28zp2aY446Mt5t4BFmSRCcbJpNx
	 AxfQvdY+4YNe4/V1C0SxfminUl6da+ksS/w2b3cM/N5QsBvzjQPiqdRnU/YrdTqmiO
	 ht4VHkqhlvR26wY8aNDBp+uG1oV6aCoRQTHSk5VzXlahLixh8dkHvwlzI+jfEZKw68
	 CW47yBN71iUg80ytWJyWIx24NVv//91b9LYadbcNExTjQTJgW6Wlrl5+cqpskYY6qZ
	 RAckAes+iRUgNazXkKuc4ZBKgkoPSTgZVEFFkhxkVvxNMcBp3vmakZ9/45a6fXOwrP
	 eaiZAVhsgKsOw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 5767880004A;
	Mon, 22 Apr 2024 00:30:03 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:30:03 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 00:30:02 +0200
Date: Mon, 22 Apr 2024 00:29:50 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v11 3/4] xfrm: Add dir validation to "in" data
 path lookup
Message-ID: <2472b2895678403d96059446e63b24a7e921e880.1713737786.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1713737786.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1713737786.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

Introduces validation for the x->dir attribute within the XFRM input
data lookup path. If the configured direction does not match the
expected direction, input, increment the XfrmInStateDirError counter 
and drop the packet to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmInStateDirError     	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>

v10->v11
- rename error s/XfrmInDirError/XfrmInStateDirError/
---
 include/uapi/linux/snmp.h |  1 +
 net/ipv6/xfrm6_input.c    |  7 +++++++
 net/xfrm/xfrm_input.c     | 11 +++++++++++
 net/xfrm/xfrm_proc.c      |  1 +
 4 files changed, 20 insertions(+)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 23792b8412bd..adf5fd78dd50 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -338,6 +338,7 @@ enum
 	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
 	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
 	LINUX_MIB_XFRMOUTSTATEDIRERROR,		/* XfrmOutStateDirError */
+	LINUX_MIB_XFRMINSTATEDIRERROR,		/* XfrmInStateDirError */
 	__LINUX_MIB_XFRMMAX
 };

diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index a17d783dc7c0..a3c50b00d6c1 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -279,6 +279,13 @@ int xfrm6_input_addr(struct sk_buff *skb, xfrm_address_t *daddr,
 		if (!x)
 			continue;

+		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
+			xfrm_state_put(x);
+			x = NULL;
+			continue;
+		}
+
 		spin_lock(&x->lock);

 		if ((!i || (x->props.flags & XFRM_STATE_WILDRECV)) &&
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 161f535c8b94..71b42de6e3c9 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -466,6 +466,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (encap_type < 0 || (xo && xo->flags & XFRM_GRO)) {
 		x = xfrm_input_state(skb);

+		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
+			goto drop;
+		}
+
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMACQUIREERROR);
@@ -571,6 +576,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}

+		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
+			xfrm_state_put(x);
+			goto drop;
+		}
+
 		skb->mark = xfrm_smark_get(skb->mark, x);

 		sp->xvec[sp->len++] = x;
diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index 98606f1078f7..eeb984be03a7 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -42,6 +42,7 @@ static const struct snmp_mib xfrm_mib_list[] = {
 	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
 	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
 	SNMP_MIB_ITEM("XfrmOutStateDirError", LINUX_MIB_XFRMOUTSTATEDIRERROR),
+	SNMP_MIB_ITEM("XfrmInStateDirError", LINUX_MIB_XFRMINSTATEDIRERROR),
 	SNMP_MIB_SENTINEL
 };

--
2.30.2


