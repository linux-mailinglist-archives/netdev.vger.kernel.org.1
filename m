Return-Path: <netdev+bounces-117440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742394DF58
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 02:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BED7B217B9
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541D4A00;
	Sun, 11 Aug 2024 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="igoOmbtz"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8C125D5
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335555; cv=none; b=ZlRwz/3tTl4E0o0M9UPIhNuT1qKi/8AjhQ8wRbCi9ooAeD6omsIVVSPo56Dp38sNPtzJfGaLHlKFm9A2nIAkkq0VWK7yxIf37x2ByzmGMQ3RLAraSywAfh4ylL5dN3Lj+HmmTRpFu5GgCzYJES8YNbPQd8XxH3cqffYeN9hVdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335555; c=relaxed/simple;
	bh=oA3Js3ltLTQOz5GHCGYDw8dr7WcHDELikHbf0Vk8kXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxEbfYuImxVkb0tWFglXJDeA2QWF7A0Ymh9ca9QJBSEp4jlqLhasEGh1amI/mrCgneCPyqgkgwGzSDUWeKWqTlXdhEkqtXg8JEu+Jdecyo0OX2SMo/JxHx/d6mzkDhI3DfOmihhY9la+fZ9oRMtslCbCrYlhJVxSxhzVna2GjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=igoOmbtz; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723335553;
	bh=8iLjtO/2UXxucyitQe69VJHXy2XEjJ9kRumhC5PiJ+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=igoOmbtzbxQqSGdzywSmKnHik61FBl6kOxCh02CuA1XxWoehwFm6hNLEXYtZvz8XZ
	 ghRA8nGYpojJ7zA1x8vHMoAUSasvDBDXm+cm/tdHITL/bNcCDOIPlXlEEuXIigW80I
	 vm1kxlKIscRwetjdKa1jhRUTbr933dL88JekzFTks8HK1P2/LD6c4wkzAzP55wLIwV
	 Bt/eqD21xhF12XcCO4ajChsZm358EYdGsvxsdgiTs3jXpf/xkFtv40HiaSYaNWCHvt
	 DRL7ej9GYMuzwMBFwEcMSuLby3uRc9tAZ3V2pa1skYY/ithSQosa6dT/asKTiPQufO
	 gBeTsgWWIGDIQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 566576801C9;
	Sun, 11 Aug 2024 00:19:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 08:18:09 +0800
Subject: [PATCH 3/5] cxl/region: Prevent device_find_child() from modifying
 caller's match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_prepare-v1-3-d67cc416b3d3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xS6x43nsXihcVsLJkLkDbU8lkUP042gU
X-Proofpoint-GUID: xS6x43nsXihcVsLJkLkDbU8lkUP042gU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110001
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It does not make sense for match_free_decoder() as device_find_child()'s
match function to modify caller's match data, fixed by using
constify_device_find_child_helper() instead of device_find_child().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..266231d69dff 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -849,7 +849,8 @@ cxl_region_find_decoder(struct cxl_port *port,
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
 	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+		dev = constify_device_find_child_helper(&port->dev, &id,
+							match_free_decoder);
 	if (!dev)
 		return NULL;
 	/*

-- 
2.34.1


