Return-Path: <netdev+bounces-151092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780C39ECD2C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1389B167F05
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD56E22B598;
	Wed, 11 Dec 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="STMOBBGf"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA211F193D
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923730; cv=none; b=aktGSwIeJrzY8Z5zbq+NYfmc2YAcGqe1TTsLp//JcTjzxeVJTjgmwqwESV/RseIf/FBR/q4AtBWsQKQcuWPTqYR5tml1HJngk4c+uIyh48IuBwzwJrYMtH2GFb4Xkyys89z0NGWnmFK/woWRTGrAzHuRnI1zhLyP9svF8De+dJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923730; c=relaxed/simple;
	bh=ZFsQ/Yl09yslfuVdyMHQdWAuD3gRSgg/9/3ts7Xor7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rYddOS0UCuuVSmc9rsHiEyshh62WnGVlQTC9w5G/gOSp0FwgaVRK5f6TY0b5zOC/Nyl7liM71FtL9v8DB7IXF+8OZiHf9Gba72KBtlzkXG7v7PwJGpT1H79urdJIYNsmwV4Ngc4cFwEzAhqjH6WpIPkBI9fbawBpoPtFgAvydwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=STMOBBGf; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733923728;
	bh=9bORTwxvem/cxAMde0lch2hqlKWrg1rA5c+yjjwtwOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=STMOBBGfRXB6ttHZVSyi4OfxyPCtmLLYh9kNObcjT8ONHNM285FmsTIGtr8gd+0VU
	 eqHcefdzTN3onGpgkkqx0E1A0U+ckKMuViFnOzmE5URuCeGp4LTGg0P3BOygYZAKPf
	 NDUjiGTsIFu2O5OZ6RQ1PBA7fkRgu0svmevXF7kdtcZuN2T+vSS6L3EEl0oNtxH9O3
	 2Whxb3DPZhKPGlI08494AyYK8SIcS0vvG1rvnEKhdJLKDeEMNIMxJ2z/U/T2VaeRgA
	 +tn4Wh+4siK3S5AfnSFWdM+nrJA2EaaSDATG39XeXe+HNR+fnxifmorOXChA/013eB
	 7q1CdOg7Rl+4g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 836DF8E0623;
	Wed, 11 Dec 2024 13:28:43 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 11 Dec 2024 21:28:20 +0800
Subject: [PATCH net-next] net: wan: framer: Simplify API
 framer_provider_simple_of_xlate() implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-framer-core-fix-v1-1-0688c6905a0b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHOTWWcC/x2MMQqAMBAEvyJXe2BitPArYiHJRq8wykVEEP9us
 JyBmYcyVJBpqB5SXJJlTwVMXZFf57SAJRQm21hnjHUcdd6g7HcFR7m59yY2DqH1XaBSHYqi/+N
 ICScn3CdN7/sB3GVXqGsAAAA=
X-Change-ID: 20241124-framer-core-fix-6c1f04ed3c5d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: RMd5aDlmJfpakA4NYSTQg5X4adJwbU92
X-Proofpoint-ORIG-GUID: RMd5aDlmJfpakA4NYSTQg5X4adJwbU92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412110099
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify framer_provider_simple_of_xlate() implementation by API
class_find_device_by_of_node().

Also correct comments to mark its parameter @dev as unused instead of
@args in passing.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/net/wan/framer/framer-core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
index f547c22e26ac2b9986e48ed77143f12a0c8f62fb..7b369d9c41613314860753b7927b209e58f45a91 100644
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
@@ -743,20 +743,14 @@ EXPORT_SYMBOL_GPL(devm_framer_create);
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
+	target_dev = class_find_device_by_of_node(&framer_class, args->np);
+	if (target_dev) {
+		put_device(target_dev);
+		return dev_to_framer(target_dev);
 	}
 
-	class_dev_iter_exit(&iter);
 	return ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);

---
base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
change-id: 20241124-framer-core-fix-6c1f04ed3c5d

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


