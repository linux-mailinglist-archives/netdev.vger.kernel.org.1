Return-Path: <netdev+bounces-118876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5579295366D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF9285DE3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFC1A76BC;
	Thu, 15 Aug 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CwzPlQUF"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE81AD9F5
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733923; cv=none; b=iUKCLJNak8GStuo8C6IaHOODlsSJ7Jvie6TYe5i4z+uwtuO801UFjcGFwGk6kQm3Cpdds0VIhJBxf1kWFZn2KEhvwtHRER8ppOGHpZulm3RbvsA83ELyhaYBBEPZ6kwKDi2+2YH0IRlOdNhfaGLkpYz07qvq7tnTku5QgXztoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733923; c=relaxed/simple;
	bh=3c7muOJco0XYRcBkqVaEVu5D1tl8bbCjKSw9/5bLDS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCZdebhnb4LEPI8/k2YWWI58KDgOTUK6W+RMx+G5aHMwaH+a5IGGkXSMiSKdUCOO/V2FCmXCEX4P3Z8Bu1VPENFB87WGQEK/GY5Bv6DZYvSdNsiwhcZd8/plkE5UvCl/nQkTqGRBaaEv9068YG3nwWDG/ahTWdZ6x4swfdQY8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CwzPlQUF; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723733921;
	bh=s4C9QAW99bVsLoaRILt/9k69aTTHnvsxsmd55qmj+Wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=CwzPlQUF6889iOqf3/nb3qRTEIYBrWvIdSjLpOOwO5xll9xOaRKhf6rIK5BSe/RWh
	 YSny7OP7EbZOJi+BWKkEDqZcgHjVXU+fUPAHPWgzvecFCX228ArNfCFcamDOMUx9Bq
	 rH69o3g96qVW1Fe5d4asfS6d2yFStVM+52x6+eFBgRgcZ/PqscthsIVYC9tGlUQPU4
	 vJdKc/WLoZYIoDf0U1A/oRQe8IrZRfRygKwm4vK1G2QGo2XSmnS7iOciOn+axgHKe2
	 O7dB1Wq8eYAvxnxzu0/mpPptpBXuKUwRnQiLWAUNSnKrhhZc/VHjDFb2TOFAqoFKdd
	 HzRwOoDc0mEDw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 73427DC0360;
	Thu, 15 Aug 2024 14:58:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 15 Aug 2024 22:58:04 +0800
Subject: [PATCH v2 3/4] firewire: core: Prevent device_find_child() from
 modifying caller's match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-const_dfc_prepare-v2-3-8316b87b8ff9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KnVKOxQuiErZzQhL2cWqcfypDdhY7jEe
X-Proofpoint-GUID: KnVKOxQuiErZzQhL2cWqcfypDdhY7jEe
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
caller's match data @*data, but lookup_existing_device() as the old
API's match function indeed modifies relevant match data, so it is not
suitable for the new API any more, fixed by implementing a equivalent
fw_device_find_child() instead of the old API usage.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/firewire/core-device.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 00e9a13e6c45..7fbccb113d54 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -33,6 +33,39 @@
 
 #define ROOT_DIR_OFFSET	5
 
+struct fw_dfc_data {
+	int (*match)(struct device *dev, void *data);
+	void *data;
+	struct device *target_device;
+};
+
+static int fw_dfc_match_modify(struct device *dev, void *data)
+{
+	struct fw_dfc_data *dfc_data =  data;
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
+/*
+ * I have the same function as device_find_child() but allow to modify
+ * caller's match data @*data.
+ */
+static struct device *fw_device_find_child(struct device *parent, void *data,
+					   int (*match)(struct device *dev, void *data))
+{
+	struct fw_dfc_data dfc_data = {match, data, NULL};
+
+	device_for_each_child(parent, &dfc_data, fw_dfc_match_modify);
+	return dfc_data.target_device;
+}
+
 void fw_csr_iterator_init(struct fw_csr_iterator *ci, const u32 *p)
 {
 	ci->p = p + 1;
@@ -1087,8 +1120,8 @@ static void fw_device_init(struct work_struct *work)
 		return;
 	}
 
-	revived_dev = device_find_child(card->device,
-					device, lookup_existing_device);
+	revived_dev = fw_device_find_child(card->device, device,
+					   lookup_existing_device);
 	if (revived_dev) {
 		put_device(revived_dev);
 		fw_device_release(&device->device);

-- 
2.34.1


