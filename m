Return-Path: <netdev+bounces-117438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FB94DF53
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 02:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C81E2821A6
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 00:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41115B7;
	Sun, 11 Aug 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nrCig10r"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF188F48
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335538; cv=none; b=sjlnlrOZylc+cZ2JZCbvkuw0R3kcDK21xuX+ML+Q5/6Srcm1muiOPm1HUcgYg6CFBDpspLPq2km2AIuv2gDvVm7xsomTnRi939DohDq6v9oRWeWwIEOMwgIsTnlDeRm7EPm0t9eczC+R1Wf1T1Mi4g3a+k1rb2TBJXQn9rsJQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335538; c=relaxed/simple;
	bh=re8ejkZvR8FVYAGOwc9z54pZxgx5nHBnmfXZfJuIUdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3h9+EV60n1KaWVBaQm0yZKbfVM5oXsooOFLmsj0rD1xniCOQNKhK6G547S47D5c0QzTvYiNWpbgX73l0nwvtCFmCf4BX2WRr+MzkcIjHl4o6ZCvotjiMr6uSIHGzhGsKnXwBIS4F2EYCfKnraZOTMtO8+qDABqluAO7t4wAPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nrCig10r; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723335537;
	bh=3UDcyf0LKLJLPbT+GMinmsXhG9jmFzc5b/d5UWg4m2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=nrCig10rluhFXgdriAaxFLUOAf2AXOVXbz3G8nKxrxGQAJqnngo9/3BryP20A5C6C
	 isOKYIH1GiMwCzGrDeYQlLRSJmDBgPcq3WvOonS0K1naKtQKQVYmABXJB4f9+gnTuD
	 vDOraZ4PpWbWqt2mBqQUBPomPPX397sJefdu2XzCKgDjvG1gwuRLcQDgVMbr2TDWk0
	 7IyUEyUVGjyH9iL7NswUZORYp2PxW5HTmdOR2fBYDb+yAIDfuTdI54WygYtiIArVIS
	 7DXUDDRK2X+Ke1ohegY4WY1XimMgJ/HNoLEtP8vX9gChD/KOLhaaYdWb6G6kDCr7rD
	 LJFImnCKSN2KA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id E97626801A0;
	Sun, 11 Aug 2024 00:18:49 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 08:18:07 +0800
Subject: [PATCH 1/5] driver core: Add simple parameter checks for APIs
 device_(for_each|find)_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_prepare-v1-1-d67cc416b3d3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: W1Q-lleN0G8WMlC2eRQQv8yYNEw2v1JX
X-Proofpoint-GUID: W1Q-lleN0G8WMlC2eRQQv8yYNEw2v1JX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=888 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110001
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Add simple parameter checks for APIs device_(for_each|find)_child() and
device_for_each_child_reverse().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1688e76cb64b..b1dd8c5590dc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
 	struct device *child;
 	int error = 0;
 
-	if (!parent->p)
+	if (!parent || !parent->p)
 		return 0;
 
 	klist_iter_init(&parent->p->klist_children, &i);
@@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
 	struct device *child;
 	int error = 0;
 
-	if (!parent->p)
+	if (!parent || !parent->p)
 		return 0;
 
 	klist_iter_init(&parent->p->klist_children, &i);
@@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
 	struct klist_iter i;
 	struct device *child;
 
-	if (!parent)
+	if (!parent || !parent->p)
 		return NULL;
 
 	klist_iter_init(&parent->p->klist_children, &i);

-- 
2.34.1


