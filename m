Return-Path: <netdev+bounces-121644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4A95DD19
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 11:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E941283D7E
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D681552EE;
	Sat, 24 Aug 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vmSi6ZCk"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687381547F9
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724490502; cv=none; b=g9IRgEa4cs62pjoFwXTZSGsXts9m7yyWOM5kfd0d2p9fBww3XC64lDb17pvtOjWYQCGnSPUsRS3aavyaYk57ZDOYbdNDx9PwhRA97tBlXeWg9xkHoqDdh9fzS0Tt8Fs8sYKxOlqkhYcPYeJmfMXQd558aaWHCyRfoR3NjsRPWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724490502; c=relaxed/simple;
	bh=elvKHqhjjIwUWn9YVnt+Gk7VtKMJ0R61OwSPYTTdhv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnFdHnzgWPDdFpGHK9DqXiDoIE9fBDvoyHcnnMnB6ejLZl7rqS4qrS6rM4tjkpGm2eFO/t39uLmdDVyOdL9SsAaD/30SGE1B6m+Vn62fpzy8x/dA5kDwh2OujGtcZoGLUVHSz75o/k6hhIXs6Ppb1GceYKdEs3a0F46l8iuuiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vmSi6ZCk; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724490501;
	bh=dn8YXMiFaJOgyParJ8bF5Tx5o3Vd6MYrq5djv4110II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=vmSi6ZCk6p3vGXjXtLYBz2EX1xxO8oUhSZo+TpTYXmCG208m67QFMUDmw3jQA65Hx
	 KOo8dqm41XB02CVutYxI+A8b4mAoRH3vk8DurLLRwrS4ctbRSuaV/doUs6Dqr97G20
	 5Y+D4upbdUj7lzSDlgNNF3n/9NhWZ2c3uSmUpKN1ILscSsXRkpNmAM2khPdUjCIsda
	 iY3HJhGm6Q6jwHU5Yu/C79i8Nm74IoN21hBpwJM0tHU+3G+1x0pcxJGYsKrLMehuse
	 taV3N3uV1e11hJUjWHMsiHVJv8ViQHxEdIbf3XX3XObtiKBKj4nB2b/7MeZJ3cP2Gx
	 xGSxc7otJonnw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id A194C20102CE;
	Sat, 24 Aug 2024 09:08:14 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 24 Aug 2024 17:07:43 +0800
Subject: [PATCH v3 1/3] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240824-const_dfc_prepare-v3-1-32127ea32bba@quicinc.com>
References: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
In-Reply-To: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
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
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 8hSc9YrUZT0VX9KHJ1CCDRRyjKU4c3tX
X-Proofpoint-ORIG-GUID: 8hSc9YrUZT0VX9KHJ1CCDRRyjKU4c3tX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_08,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408240053
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

The following API cluster takes the same type parameter list, but do not
have consistent parameter check as shown below.

device_for_each_child(struct device *parent, ...)  // check (!parent->p)
device_for_each_child_reverse(struct device *parent, ...) // same as above
device_find_child(struct device *parent, ...)      // check (!parent)

Fixed by using consistent check (!parent || !parent->p) which covers
both existing checks for the cluster.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4bc8b88d697e..c066b581ce34 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3993,7 +3993,7 @@ int device_for_each_child(struct device *parent, void *data,
 	struct device *child;
 	int error = 0;
 
-	if (!parent->p)
+	if (!parent || !parent->p)
 		return 0;
 
 	klist_iter_init(&parent->p->klist_children, &i);
@@ -4023,7 +4023,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
 	struct device *child;
 	int error = 0;
 
-	if (!parent->p)
+	if (!parent || !parent->p)
 		return 0;
 
 	klist_iter_init(&parent->p->klist_children, &i);
@@ -4057,7 +4057,7 @@ struct device *device_find_child(struct device *parent, void *data,
 	struct klist_iter i;
 	struct device *child;
 
-	if (!parent)
+	if (!parent || !parent->p)
 		return NULL;
 
 	klist_iter_init(&parent->p->klist_children, &i);

-- 
2.34.1


