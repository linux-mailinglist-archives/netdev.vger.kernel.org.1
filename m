Return-Path: <netdev+bounces-93194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE628BA8B5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4D9B2238B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF0A14A08D;
	Fri,  3 May 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ubNx+Yve"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71F14A095
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724867; cv=none; b=V3PjeYmi1rRGKgbemOBwvNJ0rM5XpAZdn0UlicHuKlMKmGbMmiW9tearq2pZJJfkjoaiGlzRptgoCZ057a/un9B6Nen6WDndu/UDlvUhk+fpNhGXIcYzkd6QwtZMqJ1H/yqk/0R8cX2SWoJ5IDfXQyCxVLAkzXyhMefCTHc96GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724867; c=relaxed/simple;
	bh=3Gdc+niNhgYoHp+wQ10xCMEdRVCitA8vVC3Z7VxN/BM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgXUuIgzi7BTdD3v9mrGSHRbyjWjFzNL3dhtBingJttTDg2QYp2luisQWEDkWccxltVODJ4KueeADCJkP7nfSJhXxlMLm6/doTPQs+hERI/telxCX5FrhpqaO1N7Xu8+RIHjUMIn016SaQX/GCAmV3TwEl6wco9CyLFclHWxhjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ubNx+Yve; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 87E232083F;
	Fri,  3 May 2024 10:27:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRplDHGhE57y; Fri,  3 May 2024 10:27:38 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7AA6D2084A;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7AA6D2084A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714724857;
	bh=pCChTK2Nd7LQDvAulEZk7b0Th+ylMbvtNzAFLb0etrU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ubNx+YveT/USLYvO3zLBRiu2aAKcKkPodEpDNfQbA4wnuWLYDNQTGWUKpjunZOcZP
	 VnJREsccPqE6K1lZYy0q8YpnNNYPF68BeW8ava8WN+j90SE68m+x+kJRl9K0KxKXgn
	 vxOGvAZxDBIwZyYIRUbmHavK6XIuPl+0JYtEcLdw+7jfJKQifzhvqCTNprYJBngAed
	 RojQwnCtHl3LvWrHMu2b4Joi9nR3YP3/8TViY7zy1DFIABTSNSAqZpfyS1D06sW1S0
	 Vq9Yh482wfoUIrlS4Jukqpm3rXLG0j4vOzOPnGvC0m0lCx0gumT2NlkXUVTFXWNaDl
	 YuUv6+sKgyc0w==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 6E7C980004A;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 3 May 2024 10:27:37 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 May
 2024 10:27:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1E42B318456C; Fri,  3 May 2024 10:27:36 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/5] xfrm: Restrict SA direction attribute to specific netlink message types
Date: Fri, 3 May 2024 10:27:31 +0200
Message-ID: <20240503082732.2835810-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503082732.2835810-1-steffen.klassert@secunet.com>
References: <20240503082732.2835810-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Antony Antony <antony.antony@secunet.com>

Reject the usage of the SA_DIR attribute in xfrm netlink messages when
it's not applicable. This ensures that SA_DIR is only accepted for
certain message types (NEWSA, UPDSA, and ALLOCSPI)

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index f5eb3af4fb81..e83c687bd64e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3213,6 +3213,24 @@ static const struct xfrm_link {
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
@@ -3272,6 +3290,12 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.34.1


