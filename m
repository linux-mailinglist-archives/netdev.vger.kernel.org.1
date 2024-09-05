Return-Path: <netdev+bounces-125326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F096CBDA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6451F232F9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60EF4C76;
	Thu,  5 Sep 2024 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Fj8J7iJB"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23DDF59
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496620; cv=none; b=FNXVwbt3wymX+BLsymlU/KGZ6hNpw9BF+nPuhxjXDukujM5PbfGDpECjyv9YwxgSKhLQPTtR9irwh2Gh+GNrW31sHLOcvZ7Jn+uZZ6IcO1wtLXb4SLxZDEQxRjgeSt4WLKc3RX+ngO+4jvC6lLRjoXi1IzGfb+y7bmq+U1pUWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496620; c=relaxed/simple;
	bh=kYetPqvMLLx5+dJ9+boXwW1Wp7FG1sXnbJAiEqLwfio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iED0owz5eWk83UnD2glvVsQcTGBQTcndJJRADoHtwNaRrfymCdobXQON8u+WKg0qQcal8Sl23FESUAbL/+nWUdlZ/Eizi5sZ9h8LC42TWIzc/Pn4ExXb8vN9fKWYu3daf7HyWUceR3D7Rl1Z1x1xWrNtnOe+9URctgTG3Ej3V0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Fj8J7iJB; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725496618;
	bh=dwnwxkgqOlaxufbIkvbF6eAIvdX11aqbDyvutbqgdbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Fj8J7iJBZ/U9WYskP0XgZjPWicKKAaL6zZa7OaC5GQdOl1kBb2ExmjEx7TL/jQvYS
	 /HWUlcx7eCAnNM1yBskad2dYH43wOAtEhgBs8nQ/kP+yvIrsQKTEE4i+jTIcVkA1Rf
	 BUVW9RPbWTUMRiwYsjhxqnTb3jJRWvTUy27+gJd0tgPAr100K3LZ3Z/k8UKUxMKk98
	 enJ8SALc2g2NhasxSrLqh3vIwtMJJLB/HT9aHoEcfrCjkS+i5aPfRpiKqlX0knSJC2
	 NsWOuFGqKysVfpAk8G6vcQ4xB/D3f4ix2WuXj5P9wqUFubhGpjYTpLUeb9mSDbLz+L
	 W0Drg14PcYeAg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 1C7004A0351;
	Thu,  5 Sep 2024 00:36:50 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Sep 2024 08:36:09 +0800
Subject: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _rGsSFzOa5Bxjs8a0EDp2a0yhqgVB74p
X-Proofpoint-GUID: _rGsSFzOa5Bxjs8a0EDp2a0yhqgVB74p
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
caller's match data @*data, but match_free_decoder() as the old API's
match function indeed modifies relevant match data, so it is not suitable
for the new API any more, solved by using device_for_each_child() to
implement relevant finding free cxl decoder function.

By the way, this commit does not change any existing logic.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..c2068e90bf2f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
+struct cxld_match_data {
+	int id;
+	struct device *target_device;
+};
+
 static int match_free_decoder(struct device *dev, void *data)
 {
+	struct cxld_match_data *match_data = data;
 	struct cxl_decoder *cxld;
-	int *id = data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
 	cxld = to_cxl_decoder(dev);
 
 	/* enforce ordered allocation */
-	if (cxld->id != *id)
+	if (cxld->id != match_data->id)
 		return 0;
 
-	if (!cxld->region)
+	if (!cxld->region) {
+		match_data->target_device = get_device(dev);
 		return 1;
+	}
 
-	(*id)++;
+	match_data->id++;
 
 	return 0;
 }
 
+/* NOTE: need to drop the reference with put_device() after use. */
+static struct device *find_free_decoder(struct device *parent)
+{
+	struct cxld_match_data match_data = {
+		.id = 0,
+		.target_device = NULL,
+	};
+
+	device_for_each_child(parent, &match_data, match_free_decoder);
+	return match_data.target_device;
+}
+
 static int match_auto_decoder(struct device *dev, void *data)
 {
 	struct cxl_region_params *p = data;
@@ -840,7 +859,6 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_region *cxlr)
 {
 	struct device *dev;
-	int id = 0;
 
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
@@ -849,7 +867,7 @@ cxl_region_find_decoder(struct cxl_port *port,
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
 	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+		dev = find_free_decoder(&port->dev);
 	if (!dev)
 		return NULL;
 	/*

-- 
2.34.1


