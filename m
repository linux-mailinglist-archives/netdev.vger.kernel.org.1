Return-Path: <netdev+bounces-203716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE09AF6E02
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE841C20F95
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EAF298CB7;
	Thu,  3 Jul 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JZoiMtpI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816E24A054;
	Thu,  3 Jul 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533287; cv=none; b=FDDudkzu/AaFyXrLvDz2jfWRkC9jsDarMxGjMV7YHI8GPYMSFvWSDjGNghvW2XCpmcIx8w5hEPOoBDPrhRU03Qgojn+pSJSx5DhivEdTlzVk0/QGCb1vAga/eGDs/D/ChlXwJXNVDzNbNZhAZnN9tGYY5OMm8HUBwatfYbRvKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533287; c=relaxed/simple;
	bh=It4Yzf/cq/OZHF/i74LdCyTJ52/QRKsGa2yNEZKCaP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=haCKmQnd+OKYHBVkiABtDHRhqIGqtBoViYA2aBFiGZ4Y2HMAjpS3K9VuGd4eTyxtthMLDEPPE/pv8H4/qAs5l020Y+eNPxz3ru1EqbKqKppaA860moKD8oEN0PPXj3SkjXvu+InQfvDNeJ2ilok+Nqt8pDJacc6ZvGs1elgxlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JZoiMtpI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5631xo9d024877;
	Thu, 3 Jul 2025 09:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=ywd6s1HBGy/xILoiidjOHLd2E+10hnFHI88SzQApckA=; b=JZ
	oiMtpII60AGhwlSiSEVjNqX84F5RPPXCWaocdJmPlejNOBG2iKLgX1TzuyXWgIZc
	/vUwxuD/scAv3zrqnupKQGLhkirgZyrjH6qypKiYxQZTdCBo2F+5+ioUPHTIjDq4
	mrPQ6NUEftCQxNHjqKW4Gv3wGQh2FLrYDOy6ecj++c7H5UnA++Ix+w53YjNApGxP
	v4NKWd4NqZBynmDkCbq8Ex2p1j6VzIL1kzM+IF2A7I0od5kvvQLGMxW1+DV1MAUJ
	Zo+Jg79oj+Vj67jmwzjnM96VoE/HlKlzEzHV2V9mTZA2MFyyAQF6M6KUyDi5qqpl
	D7wOU5fW4ocMqG0yjyow==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8027j9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 09:01:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 563910BX001271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Jul 2025 09:01:00 GMT
Received: from hu-sarohasa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 3 Jul 2025 02:00:55 -0700
From: Sarosh Hasan <quic_sarohasa@quicinc.com>
To: Wei Fang <wei.fang@nxp.com>, "andrew @ lunn . ch" <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli
	<f.fainelli@gmail.com>,
        "hkallweit1 @ gmail . com" <hkallweit1@gmail.com>,
        "davem @ davemloft . net" <davem@davemloft.net>,
        "edumazet @ google . com"
	<edumazet@google.com>,
        "kuba @ kernel . org" <kuba@kernel.org>,
        "pabeni @
 redhat . com" <pabeni@redhat.com>,
        "xiaolei . wang @ windriver . com"
	<xiaolei.wang@windriver.com>,
        "linux-kernel @ vger . kernel . org"
	<linux-kernel@vger.kernel.org>,
        "imx @ lists . linux . dev"
	<imx@lists.linux.dev>,
        "netdev @ vger . kernel . org"
	<netdev@vger.kernel.org>
CC: Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Abhishek Chauhan
	<quic_abchauha@quicinc.com>,
        Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
        Girish Potnuru <quic_gpotnuru@quicinc.com>, <kernel@oss.qualcomm.com>
Subject: [PATCH net v1] net: phy: Change flag to autoremove the consumer
Date: Thu, 3 Jul 2025 14:30:41 +0530
Message-ID: <20250703090041.23137-1-quic_sarohasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YiaMy12t1KuOcPz3axauiUzftVNYJc04
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=686646cd cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=8AirrxEcAAAA:8 a=m1-PlO-VolDZHzCB4_kA:9 a=TjNXssC_j7lpFel5tvFf:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: YiaMy12t1KuOcPz3axauiUzftVNYJc04
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA3MyBTYWx0ZWRfX2x62OZcuq18L
 IVSUNgpWqSYJ3CrWMdgOEtjg9l1Ml/Vv3hzJvOzA3B3hXKbYliMG07wSY+CfYlBP3xmVMYHGVlB
 xpYYdLwbJslpzSEIF4/kjLzjuOjMpgFnZpxtADRbFPV00lj4SabqF2muTUawbm/HIorI2WYaHZn
 ZLYZ924urdMRNzrvvHcbAGEKgpQn7G8igx2PQzHcCXdx0J5iTUdBceef0kPzVX2cLoTi551nHyM
 +MpL+HqwXE+DLj/oWXHi7+tD9TTnEpNgteb65SbKHEKgIB0d2J+7hIrsw7J28mYK9ke1olv405E
 fxS6AwF1AgNePs1Dxz2JxO9Hq2UFSMozSQX8zGz36CKHu6qhjwRqkwSFEvaFfXvcg8bG1hIPf3t
 +qufYk+awGw/QNZGil+Xs+yFXZ0nK8UvejDu6qHFcBPfjzHUCp6swHSNrL6dTFVQgcPDtvH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=845 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507030073

phy_detach() is not called when the MDIO controller driver is
removed. So phydev->devlink is not cleared, but actually the device
link has been removed by phy_device_remove()--> device_del().Therefore,
it will cause the crash when the MAC controller driver is removed.
In such case delete link between phy dev and mac dev. Change the 
DL_FLAG_STATELESS flag to DL_FLAG_AUTOREMOVE_SUPPLIER,so that the
consumer (MAC controller) driver will be automatically removed
when the link is removed.

Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
Link: https://lore.kernel.org/all/e6824f1a-c1a9-4c2e-9b46-6fe224877bfc@quicinc.com/
Suggested-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>
---
 drivers/net/phy/phy_device.c | 17 +++++++++--------
 include/linux/phy.h          |  4 ----
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 90951681523c..f3db3dd93c74 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1630,6 +1630,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
+	struct device_link *devlink;
 	int err;
 
 	/* For Ethernet device drivers that register their own MDIO bus, we
@@ -1760,9 +1761,14 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 * another mac interface, so we should create a device link between
 	 * phy dev and mac dev.
 	 */
-	if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
-		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
-						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent) {
+		devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
+					  DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+		if (!devlink) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
 
 	return err;
 
@@ -1834,11 +1840,6 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner = NULL;
 	struct mii_bus *bus;
 
-	if (phydev->devlink) {
-		device_link_del(phydev->devlink);
-		phydev->devlink = NULL;
-	}
-
 	if (phydev->sysfs_links) {
 		if (dev)
 			sysfs_remove_link(&dev->dev.kobj, "phydev");
diff --git a/include/linux/phy.h b/include/linux/phy.h
index b037aab7b71d..e20643fb6f41 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -507,8 +507,6 @@ struct macsec_ops;
  *
  * @mdio: MDIO bus this PHY is on
  * @drv: Pointer to the driver for this PHY instance
- * @devlink: Create a link between phy dev and mac dev, if the external phy
- *           used by current mac interface is managed by another mac interface.
  * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
  *	      from userspace, similar to ifindex. A zero index means the PHY
  *	      wasn't assigned an id yet.
@@ -613,8 +611,6 @@ struct phy_device {
 	/* And management functions */
 	const struct phy_driver *drv;
 
-	struct device_link *devlink;
-
 	u32 phyindex;
 	u32 phy_id;
 
-- 
2.17.1


