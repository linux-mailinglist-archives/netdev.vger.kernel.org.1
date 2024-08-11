Return-Path: <netdev+bounces-117439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82E94DF55
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 02:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9FF1F22303
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903174C62;
	Sun, 11 Aug 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gMSjexnO"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AC4A00
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335547; cv=none; b=sPHPh6HERIjn0YqovYHlz8/bxT2gvOjBj6fQqa17uHDFzbGvAHV6QLrg+nU2+LroXiCPMSs1FT9MgIDrSyuK/k1sRYB+ae4Hl88OGxi5r2mhpI4aI/XajjT8WNAH2uXcvbqKT2YltkhaIWRHZSr1Zv1W4U1nT8O/nJuZG+Ccgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335547; c=relaxed/simple;
	bh=/jVTmq9o3o0MWDoG2EpUvZebIjiBmxqTBVe+zvhWThY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQVzkkf7NfjtFe1cmXcjwfesiMN90Ody0WViXZnctHVgsz3RwxErDGDoH06q0Dd3lDIyTGFrVyUwL1jPQ6hyVx5yq7cSm6COzdnZilGYh5sfQtZ7gph2QG3ZmpP8xbuRHpugFV3v8tpEyDfPGzpYZk61MFIoIbrmEGvZdpJor8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gMSjexnO; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723335545;
	bh=8ACfFczv50hhSd0C+OEzjxc/3oNgPFKi42Hm5mF33zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=gMSjexnOEdW4l+6MTPntwI6HyUiWXsZq2JBHkxheRrZTySVN4qY3znsgN7+T444zm
	 pu9ZIn6ZP2t1M+F0Ns6kQMPg2aWBq8vIEEPloerypHRCJb7C70cYoXJWfTGjjXn70p
	 oboHjm/5/F7NRLUO+OWTcXPfzdBYp83ErkIiswVAa7MsN1uy3HMiEZdTuPilz1V1rJ
	 pBSjBfjmjLe1yQflmmvcZI5bqJJKKdPDI7SYkwD2BHn5DrgHfMI2nRmIySjTAhB/ab
	 BIl9zJalPvN0e3nwlJx5EKhyFaPlFOjazPwl7ZagiP3zOwWMJ6VAI4wPFaaJXJbzEp
	 hfCn7tZEFMfCg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id F391F680179;
	Sun, 11 Aug 2024 00:18:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 08:18:08 +0800
Subject: [PATCH 2/5] driver core: Introduce an API
 constify_device_find_child_helper()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_prepare-v1-2-d67cc416b3d3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: YUExqy0AGD5seRjb7nYKURCcmx4cVajI
X-Proofpoint-GUID: YUExqy0AGD5seRjb7nYKURCcmx4cVajI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110001
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Introduce constify_device_find_child_helper() to replace existing
device_find_child()'s usages whose match functions will modify
caller's match data.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c    | 35 +++++++++++++++++++++++++++++++++++
 include/linux/device.h |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b1dd8c5590dc..3f3ebdb5aa0b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4128,6 +4128,41 @@ struct device *device_find_any_child(struct device *parent)
 }
 EXPORT_SYMBOL_GPL(device_find_any_child);
 
+struct fn_data_struct {
+	int (*match)(struct device *dev, void *data);
+	void *data;
+	struct device *target_device;
+};
+
+static int constify_device_match_fn(struct device *dev, void *data)
+{
+	struct fn_data_struct *fn_data =  data;
+	int res;
+
+	res = fn_data->match(dev, fn_data->data);
+	if (res && get_device(dev)) {
+		fn_data->target_device = dev;
+		return res;
+	}
+
+	return 0;
+}
+
+/*
+ * My mission is to clean up existing match functions which will modify
+ * caller's match data for device_find_child(), so i do not introduce
+ * myself here to prevent that i am used for any other purpose.
+ */
+struct device *constify_device_find_child_helper(struct device *parent, void *data,
+						 int (*match)(struct device *dev, void *data))
+{
+	struct fn_data_struct fn_data = {match, data, NULL};
+
+	device_for_each_child(parent, &fn_data, constify_device_match_fn);
+	return fn_data.target_device;
+}
+EXPORT_SYMBOL_GPL(constify_device_find_child_helper);
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index 34eb20f5966f..b2423fca3d45 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1078,6 +1078,13 @@ struct device *device_find_child(struct device *dev, void *data,
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name);
 struct device *device_find_any_child(struct device *parent);
+/*
+ * My mission is to clean up existing match functions which will modify
+ * caller's match data for device_find_child(), so please DO NOT use me
+ * for any other purpose.
+ */
+struct device *constify_device_find_child_helper(struct device *parent, void *data,
+						 int (*match)(struct device *dev, void *data));
 
 int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,

-- 
2.34.1


