Return-Path: <netdev+bounces-126832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FA9729DC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1577EB24791
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5017C9FB;
	Tue, 10 Sep 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="J2MMgUM+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B617C224
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951328; cv=none; b=AHY/GJIYo+QbC3C77Adb7W6TecM3BlCLhZuNt89g2Zktm0l2F+2uwxuVHmOvVLvo3NV5VB2bxf0bPrUJNpCqveMfGzgRv57BF1iuQ+apF9RE4oBUGT3q+WeCzePPfMWC1GjY1gl+OlBn2tnnIzdBDKVbrsop8aPo/pr0x0wDJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951328; c=relaxed/simple;
	bh=2SuLeyuFJWDHA7U8do1vJwuS3h5Z2OFpGils9N3eHWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y58MrYMbJ7m2pyM1ysQC/+2zdTY37GmDsz2qE+tTNrUevZ+0hhosZ3uRio5CbZ8OHf45/qautd5I36c6Xg0SBg2vYbg7vJCEYvIs4NITByk7aiWT0vERYhWN0UiSiix3cwWiId249sWU0KVLkSlvQPgZHVbYokgGsm4SLy2YiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=J2MMgUM+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E3F892074B;
	Tue, 10 Sep 2024 08:55:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FebjWKBDbsl4; Tue, 10 Sep 2024 08:55:23 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ACC1B2089F;
	Tue, 10 Sep 2024 08:55:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ACC1B2089F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951322;
	bh=8csKfYlaZqHzHjNFu6MP3D+sydLQSCMkZgGnTdb3vrU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=J2MMgUM+jTl5ZcjdH6zvWJP6/jPg+vYL4yiUUZ3eJc4/pYWTD1j7DzIQFwhg3B4U6
	 Ei43li5zpIjaDVhFLbvhVteYybroiHRj7iE7yYZHcv5NOIa3NHR6n/iJe4gY9KvIzQ
	 P50JwrdOp2dSKSs73OnIYP/zSG5d6z5dToge+JYFuQHgNgEPnUpTDXeFNusTcrzbWI
	 wkW69g2Dx1nmjGcbm2h84grtAQuvIeRNWyLRgYECDukWuxgHMqakjbaUf3Ii8C6gLm
	 9sbEdXbCb+0smzj/DLf0ssMCvFYzgeoAlK4N1bakRAnDVjF46c4LL/s5Iq5GZpq95+
	 laRyog8Bk6b6A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 69C1E31842E6; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/13] xfrm: add SA information to the offloaded packet
Date: Tue, 10 Sep 2024 08:55:02 +0200
Message-ID: <20240910065507.2436394-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065507.2436394-1-steffen.klassert@secunet.com>
References: <20240910065507.2436394-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: wangfe <wangfe@google.com>

In packet offload mode, append Security Association (SA) information
to each packet, replicating the crypto offload implementation.
The XFRM_XMIT flag is set to enable packet to be returned immediately
from the validate_xmit_xfrm function, thus aligning with the existing
code path for packet offload mode.

This SA info helps HW offload match packets to their correct security
policies. The XFRM interface ID is included, which is crucial in setups
with multiple XFRM interfaces where source/destination addresses alone
can't pinpoint the right policy.

Signed-off-by: wangfe <wangfe@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..a12588e7b060 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
 	int family;
 	int err;
+	struct xfrm_offload *xo;
+	struct sec_path *sp;
 
 	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
 		: skb_dst(skb)->ops->family;
@@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			kfree_skb(skb);
 			return -EHOSTUNREACH;
 		}
+		sp = secpath_set(skb);
+		if (!sp) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
+
+		sp->olen++;
+		sp->xvec[sp->len++] = x;
+		xfrm_state_hold(x);
+
+		xo = xfrm_offload(skb);
+		if (!xo) {
+			secpath_reset(skb);
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+		xo->flags |= XFRM_XMIT;
 
 		return xfrm_output_resume(sk, skb, 0);
 	}
-- 
2.34.1


