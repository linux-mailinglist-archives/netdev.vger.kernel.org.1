Return-Path: <netdev+bounces-117442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC994DF5B
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 02:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408821C20EDF
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 00:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EADDDAD;
	Sun, 11 Aug 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="qmYKKRLx"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29364DDA1
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335571; cv=none; b=C9kal8RYlhxLHod7AWJwy7nVJWq4N2LT/rnEeE2XIu+8hoiL8oK7fzecU1wggVsAotqE0GT6V+qptWX5yc1CXJpIPYbhpAyfQOnGqeLgXc/XsJZcJcmKKm0OLfJDjoDiWMZ8tHpAL3YBkvgeFiHulJMssPFQV3y2nl9/v80rlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335571; c=relaxed/simple;
	bh=KvOpYbmYWjV+rXzyCv7qf0TDxg/EynZxXUCOxIezkv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvTSQ7T4++IBjNuKPtLK6aASdoBF54uxyPMuGnPAIEoAYb2/rhR61i7iXrlgWrmoXbMo5RbP6PZBWmt03jG9/naJc1Cd69eJywHqf6lHh8WbKEVvSzCa02NOBek+FEXTfiyD7gJp+Uq+z93ryn1Kkh4I4LJFWZvNiCPV0GOaM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=qmYKKRLx; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723335569;
	bh=g0ifbuA5vAN4F2zvFBRG6+qhsDphBeYH944qW7z03P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=qmYKKRLx9Y82CbRQ5af60iWurvgbjfFFy1jHlL2/cDHM7exhNOdzRoXacrnKaVrq0
	 1GPSIZcgi4HderXO8iiaTSTmoF3eCUvwTgnIDuc1mWACn7xf+0noHRNEtBE+aa3QTp
	 yeoDztR5HIGyQUBmWZw4PppRM8o4GEldznvFNauP30lg7uBysSzlTOQzNPm2InqyMu
	 +egkE3WcX1oc5j012t/UVATl3PmYF1JG+Z8iWaZSYOqUdpQ8vCJ09BH8jQ9itxi5lk
	 1MzKTrnaMON87PrCpyXJsBE39O4pG0pxsQLi6/sEZmjm24fHWDzoKQkZB+7cTc4E6C
	 srV2ji0zC/vvg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 701106800FC;
	Sun, 11 Aug 2024 00:19:22 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 08:18:11 +0800
Subject: [PATCH 5/5] net: qcom/emac: Prevent device_find_child() from
 modifying caller's match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_prepare-v1-5-d67cc416b3d3@quicinc.com>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
In-Reply-To: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6F8FPtT7sCunyxHLCfRp5cxUElMTOGvd
X-Proofpoint-GUID: 6F8FPtT7sCunyxHLCfRp5cxUElMTOGvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110001
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It does not make sense for emac_sgmii_acpi_match() as device_find_child()'s
match function to modify caller's match data, fixed by using
constify_device_find_child_helper() instead of device_find_child().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index e4bc18009d08..e53065756a1d 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -358,8 +358,9 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 	if (has_acpi_companion(&pdev->dev)) {
 		struct device *dev;
 
-		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
-					emac_sgmii_acpi_match);
+		dev = constify_device_find_child_helper(&pdev->dev,
+							&phy->sgmii_ops,
+							emac_sgmii_acpi_match);
 
 		if (!dev) {
 			dev_warn(&pdev->dev, "cannot find internal phy node\n");

-- 
2.34.1


