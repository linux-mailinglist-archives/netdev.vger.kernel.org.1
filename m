Return-Path: <netdev+bounces-151730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE09F0BE9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED818281D1C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343CB1DF276;
	Fri, 13 Dec 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bUiD43qv"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22721DE3D5
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091779; cv=none; b=Idq/PKq0agr53rnJYPa2ikIZqS2yhZroUlnr/nE8oPBQae+rCpnHh2F5/ZHtW+aSO4X0Vlkl8okdiOm8UbbDAeShzY0xqvqe6/zs7REyON2ahaka5Oy1v0OOgM1ufJJZqmeThDuvr3WSXAnxA6bAbT+1H0+D32ncTXrDl2OjPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091779; c=relaxed/simple;
	bh=4Ba6SOOBrOpPPQunBY+U5myV/+qDS967sigepBdSeJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M521p79pquY79AKgaDejkI2RIYWPR6hUDkp7T0YBgrATI2pxoHvddZo4+C8lQg8/ztnBTYzK/H6rmyRT5eVUKmJDulIQPNK1DiFNBey85/MqRnlSn0deGkExblr1lOQmVVHbZmIek4Tej2Bdrk2K7cj8JeljlGbAAskUk8xPvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bUiD43qv; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734091777;
	bh=AjI+/DTXa+YnhxEcnnMGi7yDmzlXx9tzQZ1oHmWbaWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=bUiD43qv5IYG8vkA5/n5B+nIGBMBW+55HSeSdrx2ftggIa1cVJy3M5BEni5yM6iYq
	 ucpKnIQiDFCU2IJP9gKkpDurvGRSe6nvcOyEwyjpzRJdN37fUWfAzkB+7NeoC4m5bW
	 gIcFcu19SpUcsJI3pEJCNrIt6AdeHoOi14jmKQKOzw51UMgnvOErjoB1sB/r2JOUgO
	 D2WnkKQ5nnXbi0ca7FVgazLiHdpU97Q5PYN6cGFb2NwwHLUQxLrL4M25KV0D786tpR
	 L/jMANEEZAnmi64pPyRFmXgfWagMZLKo6J6yoVwI1gOLv+n8aGlbaDnAPiXb5bCJMt
	 44L0DOyBInzWg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id A6AF94A00B4;
	Fri, 13 Dec 2024 12:09:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 13 Dec 2024 20:09:11 +0800
Subject: [PATCH net-next v2] net: wan: framer: Simplify API
 framer_provider_simple_of_xlate() implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-net_fix-v2-1-6d06130d630f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOYjXGcC/52Oyw6CMBBFf8V07Zi2PFJc+R+GmDoM0gWtTivBE
 P7dwsq1y3vn5NxZRCR2FMX5sAimyUUXfA76eBA4WP8gcF3OQktdKq0K8JRuvZuhwsrIrjRYNCg
 y/WTK9W66igxlcE6izZeewwhpYLK/JgU925EYMDDBZpwUKJC1MVg3srLyfnm9HTqPJwzjNjG4m
 AJ/9l8nvQ/9KWvXdf0C4Vs1MvsAAAA=
X-Change-ID: 20241213-net_fix-5c580d48c39c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: DCB3tQPqQN4UOu-MpxKdkch7RRpOoruw
X-Proofpoint-ORIG-GUID: DCB3tQPqQN4UOu-MpxKdkch7RRpOoruw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_04,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412130085
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify framer_provider_simple_of_xlate() implementation by API
class_find_device_by_of_node().

Also correct comments to mark its parameter @dev as unused instead of
@args in passing.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Use non-error path solution suggested by Simon Horman
- Link to v1: https://lore.kernel.org/r/20241211-framer-core-fix-v1-1-0688c6905a0b@quicinc.com
---
 drivers/net/wan/framer/framer-core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
index f547c22e26ac2b9986e48ed77143f12a0c8f62fb..58f5143359dfd715e63e6dd82d794cf74357a9ff 100644
--- a/drivers/net/wan/framer/framer-core.c
+++ b/drivers/net/wan/framer/framer-core.c
@@ -732,8 +732,8 @@ EXPORT_SYMBOL_GPL(devm_framer_create);
 
 /**
  * framer_provider_simple_of_xlate() - returns the framer instance from framer provider
- * @dev: the framer provider device
- * @args: of_phandle_args (not used here)
+ * @dev: the framer provider device (not used here)
+ * @args: of_phandle_args
  *
  * Intended to be used by framer provider for the common case where #framer-cells is
  * 0. For other cases where #framer-cells is greater than '0', the framer provider
@@ -743,21 +743,14 @@ EXPORT_SYMBOL_GPL(devm_framer_create);
 struct framer *framer_provider_simple_of_xlate(struct device *dev,
 					       const struct of_phandle_args *args)
 {
-	struct class_dev_iter iter;
-	struct framer *framer;
-
-	class_dev_iter_init(&iter, &framer_class, NULL, NULL);
-	while ((dev = class_dev_iter_next(&iter))) {
-		framer = dev_to_framer(dev);
-		if (args->np != framer->dev.of_node)
-			continue;
+	struct device *target_dev;
 
-		class_dev_iter_exit(&iter);
-		return framer;
-	}
+	target_dev = class_find_device_by_of_node(&framer_class, args->np);
+	if (!target_dev)
+		return ERR_PTR(-ENODEV);
 
-	class_dev_iter_exit(&iter);
-	return ERR_PTR(-ENODEV);
+	put_device(target_dev);
+	return dev_to_framer(target_dev);
 }
 EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);
 

---
base-commit: 2c27c7663390d28bc71e97500eb68e0ce2a7223f
change-id: 20241213-net_fix-5c580d48c39c

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


