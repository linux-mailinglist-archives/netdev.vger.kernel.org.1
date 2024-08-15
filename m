Return-Path: <netdev+bounces-118877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149E95366F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DA31C25312
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF01AAE34;
	Thu, 15 Aug 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="VwXDwBnT"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B01AAE1F
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733929; cv=none; b=QXUiSDSOH0oqHw2I/xvWR7GUE1v6MB3v6bt0KCDhGfUADucAIXq942Dgjhzic2r8E5heJNgAzE+sNjM+hlqOVukGHhJls85gXcKWrTofD5OkF3+ARR62uyj9Z4i1j+w/UrJEDUkfhaeLMEAfBg/ksDmilloo2qapEqX8x2NzCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733929; c=relaxed/simple;
	bh=yvVO0QvdWcYAFtBy/YbNF+E0L38p9jPnzwSQU5oxBHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGk1eafA5CTYSPQWTsh8UEvTPY90xj3EaxngGOu/X5Gdp16VD6PYTkfEw0CuJSG5dLSco9XL/d9q8QvcS5HzJYJba7SHy1cq/mDICzaRF60oJzOxLNZXus+U9TGTxj2XejaJZaH2c/Zc4wqcZ8khY2DZIUtJ7LugKitEEvUeISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=VwXDwBnT; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723733928;
	bh=DrUrmHv0UoPw51ZXQ5s6DePgbIVDIOtNvbxuTR6F7Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=VwXDwBnTbW96xoubjySmJEqPDGvI8f3A7iHeEpJ/2FBRDmUtV9TNi4nJicQGzTVnR
	 KocOQEQhwFQygBm055WwG/p4902tiE4A3NNl9o74ojJPyB8Sd8Bn8bJPenHZt+aJXp
	 b5WhRVa+45ojn/5kbNde0Ksdr6VA1AKQzramxB0+wkRkmcnhGt2vJNirvxOHjBb1Mv
	 otK/6zQ3u11HcJx3q+ucKYF9vmpJahLGDITiOot9NXDrpJSx5kaYkIUa496/WOX8GZ
	 0xX3sqO88GEcebmE3RmG4wB+8hITen7IMq5kJWJ565b48IZOT5ddt6gnrAy/qYNKZo
	 U4wx+43bozEDA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 049EDDC0341;
	Thu, 15 Aug 2024 14:58:41 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 15 Aug 2024 22:58:05 +0800
Subject: [PATCH v2 4/4] net: qcom/emac: Prevent device_find_child() from
 modifying caller's match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-const_dfc_prepare-v2-4-8316b87b8ff9@quicinc.com>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
In-Reply-To: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
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
 linux-cxl@vger.kernel.org, linux1394-devel@lists.sourceforge.net, 
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: qdBgT0uEoUogARD1oGfQeX0cJKwj_4Uj
X-Proofpoint-GUID: qdBgT0uEoUogARD1oGfQeX0cJKwj_4Uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_07,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408150109
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

To prepare for constifying the following old driver core API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to new:
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

The new API does not allow its match function (*match)() to modify
caller's match data @*data, but emac_sgmii_acpi_match() as the old
API's match function indeed modifies relevant match data, so it is not
suitable for the new API any more, fixed by implementing a equivalent
emac_device_find_child() instead of the old API usage.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 36 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index e4bc18009d08..1c799be77d99 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -47,6 +47,38 @@
 
 #define SERDES_START_WAIT_TIMES			100
 
+struct emac_dfc_data {
+	int (*match)(struct device *dev, void *data);
+	void *data;
+	struct device *target_device;
+};
+
+static int emac_dfc_match_modify(struct device *dev, void *data)
+{
+	struct emac_dfc_data *dfc_data =  data;
+	int res;
+
+	res = dfc_data->match(dev, dfc_data->data);
+	if (res && get_device(dev)) {
+		dfc_data->target_device = dev;
+		return res;
+	}
+
+	return 0;
+}
+
+/* I have the same function as device_find_child() but allow to modify
+ * caller's match data @*data.
+ */
+static struct device *emac_device_find_child(struct device *parent, void *data,
+					     int (*match)(struct device *dev, void *data))
+{
+	struct emac_dfc_data dfc_data = {match, data, NULL};
+
+	device_for_each_child(parent, &dfc_data, emac_dfc_match_modify);
+	return dfc_data.target_device;
+}
+
 int emac_sgmii_init(struct emac_adapter *adpt)
 {
 	if (!(adpt->phy.sgmii_ops && adpt->phy.sgmii_ops->init))
@@ -358,8 +390,8 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 	if (has_acpi_companion(&pdev->dev)) {
 		struct device *dev;
 
-		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
-					emac_sgmii_acpi_match);
+		dev = emac_device_find_child(&pdev->dev, &phy->sgmii_ops,
+					     emac_sgmii_acpi_match);
 
 		if (!dev) {
 			dev_warn(&pdev->dev, "cannot find internal phy node\n");

-- 
2.34.1


