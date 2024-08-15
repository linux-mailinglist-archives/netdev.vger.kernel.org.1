Return-Path: <netdev+bounces-118874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DE95366A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE5C286324
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B896A1A706F;
	Thu, 15 Aug 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="evObj0f9"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337031A2C35
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733917; cv=none; b=mAWVqCccNpgdlvui2HZAWx6nqgX5exUygRaAHLL89JJR/TxxYaF6Ik7SSYguiDbK446ZkHp/IYmtey166mY1VLkbJmSQj15dJ1MdAmYscsFLMUIqxbINak67tLuTCI9wOwFIGRXwvaCrdB6Bx3ozlLnl14Ldu5H7QK3/0XHJm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733917; c=relaxed/simple;
	bh=dT0ukvA+zU4wNtKsB/FiwQeJ/RGEty86CFCosBSgOh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIeb2xdivOOPOBrHikDptpaUfZx/mIxjmqNlApLHjG4zJM9H8E9y/t78rc2zkBNMaEIi/w0tqBGb63ntW5wov/GdLwKWMvvRuWX5XqsKvbOmG8hHrgdl7XG9FvcGidlvTcS9rXnw2vpR8TUb+y0dg8DLz4VGG6uMrqeJ0ZLBQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=evObj0f9; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723733914;
	bh=EzEGrFwK5bZRgf2GaqF4F9k0F8niO9ojTfM21NwUx3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=evObj0f9MvFRfRXcHTO7XpqOQXr3+0aE+miUy05aF/mSoLfQIwh4IXJBEvEyIZbpQ
	 lip8EWDEegSzDcNPGO43gyUZ39v/EAJJtXn0BB4esvXroQ4C/7fgWQ8IbOyaysO3lL
	 WxEN06/iBx3+JWkRj94r6jsS8LRH/wAdy5BDfYxfDYIgNeioFOBLQ1pXMezyFHkgwT
	 r+X/1HQeuSD+53wZLYYj8+czpTRba2W5wxDW01kzZ9FqTr29bFftoP1qt57QXQ3oq6
	 fj5FuPvrlz2aRh/0xdkJGSxF/A4TPb2WZDs/YMaWP+UUNDab6rfA0NIzSNO5VyRhWT
	 LQPlwLPaMDFUQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id DC009DC011F;
	Thu, 15 Aug 2024 14:58:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 15 Aug 2024 22:58:03 +0800
Subject: [PATCH v2 2/4] cxl/region: Prevent device_find_child() from
 modifying caller's match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rj4UkMdIoUGg833V9nlg1BBGYQroUINv
X-Proofpoint-GUID: rj4UkMdIoUGg833V9nlg1BBGYQroUINv
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
caller's match data @*data, but match_free_decoder() as the old API's
match function indeed modifies relevant match data, so it is not
suitable for the new API any more, fixed by implementing a equivalent
cxl_device_find_child() instead of the old API usage.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/region.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..8d8f0637f7ac 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -134,6 +134,39 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
 	return &cxl_region_access1_coordinate_group;
 }
 
+struct cxl_dfc_data {
+	int (*match)(struct device *dev, void *data);
+	void *data;
+	struct device *target_device;
+};
+
+static int cxl_dfc_match_modify(struct device *dev, void *data)
+{
+	struct cxl_dfc_data *dfc_data = data;
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
+static struct device *cxl_device_find_child(struct device *parent, void *data,
+					    int (*match)(struct device *dev, void *data))
+{
+	struct cxl_dfc_data dfc_data = {match, data, NULL};
+
+	device_for_each_child(parent, &dfc_data, cxl_dfc_match_modify);
+	return dfc_data.target_device;
+}
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -849,7 +882,8 @@ cxl_region_find_decoder(struct cxl_port *port,
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
 	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+		dev = cxl_device_find_child(&port->dev, &id,
+					    match_free_decoder);
 	if (!dev)
 		return NULL;
 	/*

-- 
2.34.1


