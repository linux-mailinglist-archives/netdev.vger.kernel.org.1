Return-Path: <netdev+bounces-121646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFE995DD1E
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD43A1C213A8
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BB16BE1E;
	Sat, 24 Aug 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="AUaQ7HoJ"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD8155A47
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724490517; cv=none; b=cOV5smTlVIUwF1Ea20v4k85Ui9LdZt9XpHsWjsxyQw8FghI1ME74wEkY8rpsKNBGuleuPha4BL7gZnG0w0u+QH4SsHFWZSMgikBfDz0cc18yrJXMoAi0gkuIi1e07dcKvM8IgYSBFDjjyTBR7upF7QfOKfxXv4Z0N33Isz6YPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724490517; c=relaxed/simple;
	bh=6N7PqK9xBFI6iYPFqZ/0q8L0Dbt2mFTNu//UuPHTsR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEskrUlhEHSXVoT5c+8LiVtkJlRTMM5OI0CPUz3ofA602OuJ4OkyZkwaQGVzs/chLk5dnsn5dSmXLWuW6mZXzPuSgAVufPWEQ2LKTU8v5pFu+wJ4IaLB2iI8se7ABXX7pIWjjxg8BAmkBU5JqBSZLZspxWHNnwvUken9z76lyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=AUaQ7HoJ; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724490515;
	bh=3ltOxJ7yzq2fygEXUJTTlGgiDR87fnykZ2qH+ljFSB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=AUaQ7HoJzdlsPS2x/9JZmg7KYdTDwfM2gYrICytEtesPk6ykj6HCgUsTFitc4mPhV
	 fCajqTSLbR/yUnbW7mwFm8sdS1UiI40v/PT1Qh13dtHdA+NZf/VBxUjmvfXWZN31YT
	 tQ42o5a6HZmUEr0GqBbAyKZO4cN3HHNk2dVw4yUef9zRxNHlPaWtSEAAUoK6i9ptx4
	 8yiGJr4jLvPZaDCZUIPO9oh0dh6zmTaopIVWFmU0OgC+2GmncpLluEfry/zvEBscVF
	 2giCaXz5mPQQxOrOOpGU9H9erIc512+OEsPVJ0Zevu5L4HSX+aCJf71Gayvc167SxB
	 JhmsjyqKJxJww==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id A7D1720102FF;
	Sat, 24 Aug 2024 09:08:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 24 Aug 2024 17:07:45 +0800
Subject: [PATCH v3 3/3] net: qcom/emac: Prevent device_find_child() from
 modifying caller's match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240824-const_dfc_prepare-v3-3-32127ea32bba@quicinc.com>
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
X-Proofpoint-GUID: V18wEW-gUmWrD26jVLEKnIiwehUGNeQt
X-Proofpoint-ORIG-GUID: V18wEW-gUmWrD26jVLEKnIiwehUGNeQt
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
caller's match data @*data, but emac_sgmii_acpi_match() as the old
API's match function indeed modifies relevant match data, so it is not
suitable for the new API any more, solved by using device_for_each_child()
to implement relevant functions.

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


