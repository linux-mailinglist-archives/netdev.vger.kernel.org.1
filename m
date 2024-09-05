Return-Path: <netdev+bounces-125327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F396CBDC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A9E28BA30
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734279DC;
	Thu,  5 Sep 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ubtsjbr5"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93EA23CE
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496630; cv=none; b=lLeYEKV4R2lU5USyFyY9hygLDK3BOMqgOhcDByVKlpduqbigWCvgMQ3lz9No2AQOQxgDHCf8kAlyAdgc6BZkx3oC5kRaebX/sSMfNLpJ9ehNDTV/kOz5w6BhLx54HewFQwB5qfnetl+isPbKPMOkxkLMM1MGbFykviWhG6ejCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496630; c=relaxed/simple;
	bh=drjG4ZOWXJdI+ivlJh21hmoDtwnILe4lYsXLEA47HkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PjS225u01Sy29gq5t0i7lS3MeqJwxAELmwAA2eQJGgeBws3wHTaG3Q6JYy/ADvnv8m5GpeIz6ZREvklzsnLpKPVOBN16J3QAlhYIadtKSrOA54j+ngw52+DetrC84NS7wVufdYM7tMkYg586+yALssqWmEAtN1VGkDvQPOapFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Ubtsjbr5; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725496628;
	bh=USB2vfc0jyMwYalYSpIdv6871aXzY1LF0xxOVZ5PeKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Ubtsjbr5bH+GbqvBLG23EcbIvl1jCr2cZEEd7blJwLnsbgoFwtPgq+vW2xWYqvrfb
	 R+MQ4vl+J7Vz8EI0KoMukz1o+YewelzjUu4yzB4IciPB3YlBAobSeOIi1TT6bKeScJ
	 NE/AIRnUpsejCHmkm6ievvmIowKVs+tThmRTWtSwnFOZVY0EQ6d4u2ND5LFQLo5N1d
	 wQVrkG3M818mvseClX9VrZRnFhxbw9X3G+tK5kd4xeW88xlWqCNs5nmOdej6QY2Qq5
	 uqCDrNJ7Go1mNNhkVkHwdrJVN42kjCkmmxeqVXFITAXNTyWwbPxAiazZwogVwvAgS2
	 0bhmF8hMmkLSw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 8CB104A017B;
	Thu,  5 Sep 2024 00:36:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Sep 2024 08:36:10 +0800
Subject: [PATCH v4 2/2] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
In-Reply-To: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Timur Tabi <timur@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: LdsecNXrHLlaiqKWlirkO2_BwraVm0vJ
X-Proofpoint-GUID: LdsecNXrHLlaiqKWlirkO2_BwraVm0vJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_22,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409050002
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
suitable for the new API any more, solved by using device_for_each_child()
to implement relevant finding sgmii_ops function.

By the way, this commit does not change any existing logic.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index e4bc18009d08..29392c63d115 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
 };
 #endif
 
+struct emac_match_data {
+	struct sgmii_ops **sgmii_ops;
+	struct device *target_device;
+};
+
 static int emac_sgmii_acpi_match(struct device *dev, void *data)
 {
 #ifdef CONFIG_ACPI
@@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 		{}
 	};
 	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
-	struct sgmii_ops **ops = data;
+	struct emac_match_data *match_data = data;
 
 	if (id) {
 		acpi_handle handle = ACPI_HANDLE(dev);
@@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 
 		switch (hrv) {
 		case 1:
-			*ops = &qdf2432_ops;
+			*match_data->sgmii_ops = &qdf2432_ops;
+			match_data->target_device = get_device(dev);
 			return 1;
 		case 2:
-			*ops = &qdf2400_ops;
+			*match_data->sgmii_ops = &qdf2400_ops;
+			match_data->target_device = get_device(dev);
 			return 1;
 		}
 	}
@@ -356,10 +363,15 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 	int ret;
 
 	if (has_acpi_companion(&pdev->dev)) {
+		struct emac_match_data match_data = {
+			.sgmii_ops = &phy->sgmii_ops,
+			.target_device = NULL,
+		};
 		struct device *dev;
 
-		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
-					emac_sgmii_acpi_match);
+		device_for_each_child(&pdev->dev, &match_data, emac_sgmii_acpi_match);
+		/* Need to put_device(@dev) after use */
+		dev = match_data.target_device;
 
 		if (!dev) {
 			dev_warn(&pdev->dev, "cannot find internal phy node\n");

-- 
2.34.1


