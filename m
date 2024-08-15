Return-Path: <netdev+bounces-118873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B9C953667
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83B4286160
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1601A0728;
	Thu, 15 Aug 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="UPve46qa"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BD1A00CF
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733910; cv=none; b=Qpo1gBZFw7J7nrc7qXulcO711oJAMrfBIjFKgPNr6IuchZdkPs4ExG5V3SW3Jdh4eWjlTTfe619nZtwso1Q+8C2/LNpAfc3ae3Sa4vhxvvBklzXI3oGRhdIacqo027R6/F34Og8ANPMy5UklXTCciAx3b2NhmGixSiDGwZxO18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733910; c=relaxed/simple;
	bh=B4x40oAtN3LNjRkWVAGnXINEU93Q9RDP/QrLRF5fUqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LR2XxsyqhhL4nuB7DVFv80QUUuOmaWfE8yVkTpn1wIAxTKAg6/q13Xw0DUOrJxihldMRGwxYhCiFkEwv9H6/ZID+ShP5IU9iF2O59RIJwiTiSbmNt/OlnNvXj555LoLdGZKzwdrj3lMcAIsH+TNCHpc/YTofNI1ET5bGuJ2Ge+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=UPve46qa; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723733908;
	bh=ZXU3cWDb11tHaaxZwCe9tTzxZAMgqOg1R8ukq9Z1Q2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=UPve46qam1EvWqmlAaywRYn/ARiWoMJXHxgopKDxRqMAtdkbGlYZY5non5TdYnIFH
	 olqNtCdlaYaEjeMjX5pfT7i3XMQ5lgIGabllr88HG0WR2G3hY3/B3yOsB2R59CvxtQ
	 njfeFvMtVj1mlhaQyg/991ZDdStSK9Mp1pwy11D93jcAd/jCcXrvk6xNWSSLuFmsK7
	 vNfp5Cnp5F6ZCMnmB8gXshnRbiU705cTm+3ulRSCIXSdzXQFMvOz80/vZRknNyKon3
	 tX33iAEHIJi33qnnzHnnFKKCBlyGheKIzA2MgHt3eJg3ui3rEfglDPOeoU0cm8TYmf
	 RkmG9MrmSzMRQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 55895DC00F3;
	Thu, 15 Aug 2024 14:58:22 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 15 Aug 2024 22:58:02 +0800
Subject: [PATCH v2 1/4] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VrYAmKVDJ4rTV2tMUm6A8awsDrCjVss8
X-Proofpoint-GUID: VrYAmKVDJ4rTV2tMUm6A8awsDrCjVss8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_07,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408150109
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The following API cluster takes the same type parameter list, but do not
have consistent parameter check as shown below.

device_for_each_child(struct device *parent, ...)  // check (!parent->p)
device_for_each_child_reverse(struct device *parent, ...) // same as above
device_find_child(struct device *parent, ...)      // check (!parent)

Fixed by using consistent check (!parent || !parent->p) for the cluster.

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


