Return-Path: <netdev+bounces-121645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B17FB95DD1B
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D595B22AF3
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E4155351;
	Sat, 24 Aug 2024 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zGHq7pkv"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CD155730
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724490509; cv=none; b=dPaRaj9Dp1ZzmSwQeGDHbEWsYWOveM5xCUdOLuqMa97qREB3Yhl7pPtKnMClOcscUtO/YMWfBmbDYToj/vkap2eBwJ2J/2p0yvXARGhceM+JRSLR6+qqjz4gdTVBJKhpnY6IszNCRSiIVa/T9bRR+Tb/q6oEpMsYClFTTm6sCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724490509; c=relaxed/simple;
	bh=JMVYOcTBf3S+dGruEFca6wb6SUUjWP2EiW1R1R7knF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpRhBjwOO/sicvU1JyUO6AEXyUu1ou+53gyleIx0J4PTOb7DHvQrrFfvJMX2ymX+mDqgaNj1vd6kQlTVAjzdVn7UFSxywn9sbItXiTswIHMjHpA3fOK07AHPc1ZBijbAkSWue6gm76vDSJUX3J7/i4KduBlpYBqLTaI9UNxxAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zGHq7pkv; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724490508;
	bh=TeTj/Z0lsNk9CHqVVxxeD5P3v0Apo80wz9kpmgkD4A8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=zGHq7pkvUR4mY/OLDzjTU4q742JStfW4I104YmJhQokZZHfEB4pB2b06dJY1Y6u63
	 laY0690RkqzlDLnpiSoP4tzO6VgJDsWWja6ctxTrubtsvpWS2yYjGNwhdQ+FZF17Di
	 muOkK9UcE2BejQA3UQ6dTxWKXuA0q8WJhC4q/57OnDoFGD+DjqENWvafSPg64HX6U5
	 h/li3Rk8Hrc0GZOV4lRJmhMsza/QL1VPiouRJDDUoNzVaopKpl16VYxxZfZhlzAKbb
	 KV4CXXTimsJk+aiywJPe1b2fz5PAH+IQJueflHyQrhR1zomh9BOFbNNRX+QH/vXQlU
	 OpiX2UepMKnDw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id B297A2010335;
	Sat, 24 Aug 2024 09:08:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 24 Aug 2024 17:07:44 +0800
Subject: [PATCH v3 2/3] cxl/region: Find free cxl decoder by
 device_for_each_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240824-const_dfc_prepare-v3-2-32127ea32bba@quicinc.com>
References: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
In-Reply-To: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: Jvzz9BJiTKOrXbETv76nzUoWpoGSiTW2
X-Proofpoint-ORIG-GUID: Jvzz9BJiTKOrXbETv76nzUoWpoGSiTW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_08,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408240053
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

To prepare for constifying the following old driver core API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to new:
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

The new API does not allow its match function (*match)() to modify
caller's match data @*data, but match_free_decoder() as the old API's
match function indeed modifies relevant match data, so it is not suitable
for the new API any more, solved by using device_for_each_child() to
implement relevant finding free cxl decoder function.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..c2068e90bf2f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
+struct cxld_match_data {
+	int id;
+	struct device *target_device;
+};
+
 static int match_free_decoder(struct device *dev, void *data)
 {
+	struct cxld_match_data *match_data = data;
 	struct cxl_decoder *cxld;
-	int *id = data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
 	cxld = to_cxl_decoder(dev);
 
 	/* enforce ordered allocation */
-	if (cxld->id != *id)
+	if (cxld->id != match_data->id)
 		return 0;
 
-	if (!cxld->region)
+	if (!cxld->region) {
+		match_data->target_device = get_device(dev);
 		return 1;
+	}
 
-	(*id)++;
+	match_data->id++;
 
 	return 0;
 }
 
+/* NOTE: need to drop the reference with put_device() after use. */
+static struct device *find_free_decoder(struct device *parent)
+{
+	struct cxld_match_data match_data = {
+		.id = 0,
+		.target_device = NULL,
+	};
+
+	device_for_each_child(parent, &match_data, match_free_decoder);
+	return match_data.target_device;
+}
+
 static int match_auto_decoder(struct device *dev, void *data)
 {
 	struct cxl_region_params *p = data;
@@ -840,7 +859,6 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_region *cxlr)
 {
 	struct device *dev;
-	int id = 0;
 
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
@@ -849,7 +867,7 @@ cxl_region_find_decoder(struct cxl_port *port,
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
 	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+		dev = find_free_decoder(&port->dev);
 	if (!dev)
 		return NULL;
 	/*

-- 
2.34.1


