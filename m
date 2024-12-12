Return-Path: <netdev+bounces-151417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CB49EEA4E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB4518838E1
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1C215764;
	Thu, 12 Dec 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="TuqjvLds"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DE21171A
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016089; cv=none; b=B/sfni+AR3wpe2o3Ta3trQogumQwCAerKdJzr6p9oeADvfn4tTaDE6tR24AllJHC97lQ1+gKiHReVxfHZBXMmmhsy9cdjUpXgAT5/cchEpIQ4yXsPfAbERiMUgcF4O4cLLd3YyqAK24V5/3ob5l9J9U6qHZjl9ZxorvflrDQppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016089; c=relaxed/simple;
	bh=qvD1SoAblLpzjRD2YUa8GgI4p7IHUIwpfPHQKM/Nui0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JeyOqukYLuZ3xVNTh4wAM5sV0t6N/n2cnH8oD0h3HoOHmUFHfeAClkkzvth7nACFraMIorgR2KGFK98Wn2dwsiHmbpyYP9nSZHYBvOnThQxlYQ9acoS/68fHQqhmYojs51WO4n3qaeqcCF/Y9IyCzERZbt3ywbfwsNgG9xBlkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=TuqjvLds; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734016087;
	bh=6UFIt+j+FrsTdiTFypCca9qpBfAa/m4kVf/wnBkCmZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=TuqjvLdsfG43RQO8XaNkUHa/+NNbg1Wb2mLtbe00ec/KNBMQDB7aaKCLBGvVgQDmi
	 KWW3Rv6U+LqFBHz83ipKH31jR0qdnEwxlxcZ0GLDDyKtsy6J1Isu/OOboD6v14Ff+h
	 uHd02CDEu3RRj3giosNAZT6xDAiwHUFcNnXbGHP8URPgwQznep+UTLdH2YF5x7dr5v
	 KsPkwwwDHtCK6S2acnC/AmjxpaafcTEKTdf0lmhjIlq6lKRhce1o728DuOS6ZOcaqK
	 FbX7owVSy6Ho9VriKcL2zbLTyTYfGsvzmD9h4HuMtOrk4n8nH7XFvlTiDELYcvb28N
	 XWBibiAVYAMYQ==
Received: from [192.168.29.172] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id C790334BA9FE;
	Thu, 12 Dec 2024 15:07:58 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 23:06:54 +0800
Subject: [PATCH net 1/2] net: pse-pd: tps23881: Fix device node refcount
 leakage in tps23881_get_of_channels()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-drivers_fix-v1-1-a3fbb0bf6846@quicinc.com>
References: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
In-Reply-To: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Simon Horman <horms@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 5Dl0JFrI8wdMMT4gBrjRArTLjDKvvZ9F
X-Proofpoint-ORIG-GUID: 5Dl0JFrI8wdMMT4gBrjRArTLjDKvvZ9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120110
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

tps23881_get_of_channels() invokes of_find_node_by_name(@priv->np, ...)
and the callee will put OF device node @priv->np refcount, but the caller
does not compensate the refcount before the invocation, so causes the node
refcount leakage.

Fix by of_node_get(@priv->np) before the invocation.

Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/net/pse-pd/tps23881.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 5c4e88be46ee3316330e26a68d06540ff1db86ff..f5c04dd5be379f7b9697e067a32d59028f446088 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -216,6 +216,7 @@ tps23881_get_of_channels(struct tps23881_priv *priv,
 	if (!priv->np)
 		return -EINVAL;
 
+	of_node_get(priv->np);
 	channels_node = of_find_node_by_name(priv->np, "channels");
 	if (!channels_node)
 		return -EINVAL;

-- 
2.34.1


