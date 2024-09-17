Return-Path: <netdev+bounces-128644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525A97AA4D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BFD28345A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E1818C22;
	Tue, 17 Sep 2024 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eyybeMt8"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D9A31
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726538289; cv=none; b=heGsgZoDhQACQXofCRZa4aNUtYYA6R0u7QuHKhsEyn8iMFgWIC+b0o7Wg9nv8/QzO/X9pvMfAUw+/z5do/47I6GtNrf6UTf7CrX+MkFKzLdLN9dqMqurIH+JN2vTZ4jLN1O0SgzXEDI+FXUs8s7ZsT1Ohodv2nN0xwzb/FU7pLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726538289; c=relaxed/simple;
	bh=c7fNziHwoo25oWUPpnKnrXt/ZzVae/p9+e/bmJ0JZAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gKSFM5Cb4n86V+IlJYxxYK/HQz3plZLtRNeiz1D9hyrG6D92jOugAKKm/jgEjuZd4VyYoA/egsg/c2CsXvzjWS0kIHGzUTTWi7kIyb0Swz8qMiKrt0ryC61YwVLxmIjf4wpV4NEEbNSmn+G8cDoJljz1YR91ES2uWR4UYfNdeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eyybeMt8; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726538287;
	bh=JPgTiBxLD1V/+MPSc47gqMkd+S6dZzhiXWX8QgP35fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=eyybeMt8Y74Y7ELQnRvFjL4nwH/unAl1WF2114gmGRvToASBZUh6yMKVxr5E2C8Xz
	 GBsgybV4/Cw8kUTGiI+VrhMNAM4g7QXaLAok0l2Qb+hcZTlNyZNsBgaJjab9KZJoMl
	 AkZIcji5ftiHvFY2A8V7b04kVyGMsJMgM+0FfbpvlrYiu0WW4nL1RBd1ZOaW/1BJp+
	 I5AIw+c2z2YKqeYLvuGe3i0EsZlImaTi17uAoJ3tSXTgx4q7rLmcUOErZppIJYEtxX
	 xtG3pi/7AuR39WqCt3k8uAcMV+tBr4+oStOW+pRZY9VyCWN+Xp5c8yrMIRcmMdP5jd
	 Vhi3bTR8dSVYQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id EE1322010371;
	Tue, 17 Sep 2024 01:57:58 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Sep 2024 09:57:33 +0800
Subject: [PATCH net-next v5] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-qcom_emac_fix-v5-1-526bb2aa0034@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAzi6GYC/6WNQQ7CIBREr2JYiwEEU115D2MI/fxaFoUWkNQ0v
 bsEj+ByZvLebCRhdJjI7bCRiMUlF3wN6nggMBr/QupszUQwIdmVn+kCYdI4GdCDWynCRfbd0Hd
 gLanMHLHWzfcgHjP1uGbyrMvoUg7x044Kb/vPyRSF4FPWdgBd+dlEpEVSQSXvGHKrjJDyvrwdO
 A+net98Rf3p2Pf9C9yuppH+AAAA
To: Timur Tabi <timur@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: TT8PmOHS5L4qYtxrA7PrUfWtrQCYQtxf
X-Proofpoint-GUID: TT8PmOHS5L4qYtxrA7PrUfWtrQCYQtxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_15,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409170014
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

To prepare for constifying the following old driver core API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to new:
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

The new API does not allow its match function (*match)() to modify
caller's match data @*data, but emac_sgmii_acpi_match(), as the old
API's match function, indeed modifies relevant match data, so it is
not suitable for the new API any more, solved by implementing the same
finding sgmii_ops function by correcting the function and using it
as parameter of device_for_each_child() instead of device_find_child().

By the way, this commit does not change any existing logic.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
This patch is separated from the following patch series:
https://lore.kernel.org/all/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com/

This patch is to prepare for constifying the following driver API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

How to constify the API ?
There are total 30 usages of the API in current kernel tree:

For 2/30 usages, the API's match function (*match)() will modify
caller's match data @*data, and this patch will clean up one of both.

For remaining 28/30, the following patch series will simply change its
relevant parameter type to const void *.
https://lore.kernel.org/all/20240811-const_dfc_done-v1-1-9d85e3f943cb@quicinc.com/

Why to constify the API ?

(1) It normally does not make sense, also does not need to, for
such device finding operation to modify caller's match data which
is mainly used for comparison.

(2) It will make the API's match function and match data parameter
have the same type as all other APIs (bus|class|driver)_find_device().

(3) It will give driver author hints about choice between this API and
the following one:
int device_for_each_child(struct device *dev, void *data,
		int (*fn)(struct device *dev, void *data));
---
Changes in v5:
- Separate me for the series
- Correct commit message and remove the inline comment
- Link to v4: https://lore.kernel.org/r/20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com

Changes in v4:
- Correct title and commit message
- Link to v3: https://lore.kernel.org/r/20240824-const_dfc_prepare-v3-3-32127ea32bba@quicinc.com

Changes in v3:
- Make qcom/emac follow cxl/region solution suggested by Greg
- Link to v2: https://lore.kernel.org/r/20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com

Changes in v2:
- Give up introducing the API constify_device_find_child_helper()
- Implement a driver specific and equivalent one instead of device_find_child()
- Correct commit message
- Link to v1: https://lore.kernel.org/r/20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com
---
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index e4bc18009d08..e8265761c416 100644
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
@@ -356,10 +363,14 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
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
+		dev = match_data.target_device;
 
 		if (!dev) {
 			dev_warn(&pdev->dev, "cannot find internal phy node\n");

---
base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
change-id: 20240913-qcom_emac_fix-ec64b8fb8cdd

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


