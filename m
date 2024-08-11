Return-Path: <netdev+bounces-117441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA394DF59
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 02:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A802820CE
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 00:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0918836;
	Sun, 11 Aug 2024 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OvTX1o3P"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819D1798F
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335563; cv=none; b=toEjTrkRB7jyfF+S+Tat9hCczICSxi1/ao6wYictUVAYOVOgl8f6EEglMDxxakKJGYqyU8W0Ff1llao2DJR53k8zsn4cQmyezc096g9PDyZVQcqrpr7zx9FQzXHCBbdoJ++iOROl3E3/Tob55fS5T0UiHSQmEO0Na4vGV5YV8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335563; c=relaxed/simple;
	bh=hYNvkRkIcW2oTdaAe1DL5t3Si3lhBCDEpXFBGD4nl4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HlyPK//nvS1rQbut7gMFTuTOvNugfrMMOH2f1f1X2t45z0NOvA6EouopkVPMLC2ees7fNUg9DbyXnk3zz/CJEIR+UklZeGwD8C4AMOdEDWkDGNmJjE6oM3NU5ijuNXubmI3dj4++FFtSZL+PVIJq/P6P4GQvuGJP6BUyl9Ohsak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OvTX1o3P; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723335561;
	bh=gWCJf+B9a9UHAx2h7q4TRGp4fm2U07ewbdekbtDQiZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=OvTX1o3Pure4JxwNEgLEi3OgFw02Ni3RcUc586kB9lCnzsSClPhETXHOQqsKvP6xT
	 hqdgHv/Rii1jUQCCj+oUYoS356PGwrHrGSW43ATPxXyHuw3q3K1mHANnbi1LMi/ycp
	 oAIreEnxP+gwAAPl4BXDRPYX/L0y+pfm86GRrympj2cArz1edH27OHZnuqsJ4kU+mw
	 xP+AecqEA6T9+5rmgbxJP/CY3YbTD64rdPAW+7LHSazM5zhRk1NYTAATNpnin9qqwU
	 JwPtX1kiC8A8lI/cFpf6x2e3CZpj3D+4DeJIbOLNkFFHHyQrb4NzvC42JCg2yvzIYB
	 Q3ySM4zzYkE6g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 6BF736801B0;
	Sun, 11 Aug 2024 00:19:14 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 08:18:10 +0800
Subject: [PATCH 4/5] firewire: core: Prevent device_find_child() from
 modifying caller's match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_prepare-v1-4-d67cc416b3d3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: iI2CTLznNMjORgoPu_DAX5efHY63bgD5
X-Proofpoint-GUID: iI2CTLznNMjORgoPu_DAX5efHY63bgD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110001
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It does not make sense for lookup_existing_device() as match function
of device_find_child() to modify caller's match data, fixed by using
constify_device_find_child_helper() instead of device_find_child().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/firewire/core-device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 00e9a13e6c45..04b150bc876d 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1087,8 +1087,9 @@ static void fw_device_init(struct work_struct *work)
 		return;
 	}
 
-	revived_dev = device_find_child(card->device,
-					device, lookup_existing_device);
+	revived_dev = constify_device_find_child_helper(card->device,
+							device,
+							lookup_existing_device);
 	if (revived_dev) {
 		put_device(revived_dev);
 		fw_device_release(&device->device);

-- 
2.34.1


