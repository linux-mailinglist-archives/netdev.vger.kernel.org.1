Return-Path: <netdev+bounces-192112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8794ABE904
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC828A6EED
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E9165F13;
	Wed, 21 May 2025 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="jp9XMRWY"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC2145A18;
	Wed, 21 May 2025 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790461; cv=none; b=ni8Ideilrpd/FALVWLWyGN2WZTgk3WCOIu+qtcS0dymqki5GUnC5KJQ8jSRcNSMz+oIXkegX/ywqxADN712ZoXj+5yjzjfHZeL2W6HD/Mt84mCT8yB1t029xJPBKnmj27t7TZj9jOMJqsd6skzwDHwBUGCmsWmN97VO12NiApGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790461; c=relaxed/simple;
	bh=ZdFpzx5d3OudhHZXtSMNLgEaIS/5nAq30dYGget5Yyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D7GOnvWPlUubIkdAnitzOQYaQLHAmQkfgDLUTHGy5+TFg89/8GPlJw/SWpmwdmaU3lnKCYkUJHSKi88SKrWznnnGFg1Xq/xfwt2AG2VutkPEDmQrjniifHPaMe9s+WqjflrilTm8xBjeinmHWJAt59puK/JqDNYGbYggN2KBblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=jp9XMRWY; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2065; q=dns/txt;
  s=iport01; t=1747790459; x=1749000059;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=pfBkCC3DOvXPWdAIlgZQjqu1PjeONDUG9SSWLLC2Z2w=;
  b=jp9XMRWY+yBpIKXIy7dTHIK/PfO7TZIIj0fgdipZ8yb4hx+igp85BZnw
   ZV7voBTW9uaEwQszqbydmjfQsXndWNtttWjA+qumIykNomPvBcvPaAkwS
   juq6rna1oQXwlhuaA1KBZa5hwGCJoScl7sDn+HDuu7Hq0kKZ99C0acjkv
   arn5Bq+LRdkDy+whsjLscmMwu1F1F7iMAYutJK34bv5NoEdW2GIY02zQh
   +cjKL9rW4kb6VkN6OY7Yukz5oDWSitDw18QQRTGGLwnvUQYVZoxSbC5yr
   BUomO3GLqruXklztfdp919bUREBXHWHSFsKxqAoCV+oOT3eAaFYCD+/Yw
   Q==;
X-CSE-ConnectionGUID: cMqST7m/T4uu/NAM54jyQQ==
X-CSE-MsgGUID: k19YHlp9S7G/hxKGydvlJQ==
X-IPAS-Result: =?us-ascii?q?A0AFAABmKS1o/47/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJKgVFCSYRUiByHNI4YkiKBJQNWDwEBAQ9RB?=
 =?us-ascii?q?AEBhQeLUgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBD?=
 =?us-ascii?q?hOGCIZdJwRSKQwCJgItGxYBEoMCgiMBAQEBRgIBsTV6fzOBAYR82TqBboEbL?=
 =?us-ascii?q?gGITwGBbYN/O4Q8JxuBSUSBFIJ6b4QKhBSCaQSBDoIzjRiLIYcMCT+BBRwDW?=
 =?us-ascii?q?SwBVRMNCgsHBWRSMwMgCgsMCxIcFQIUHRIPBBYyHYINgi1Pgh2CD3CBF4kEh?=
 =?us-ascii?q?EorT4QnD2yBJoM2QAMLGA1IESw3Bg4bBj0BbgeWa4NsAYEPgTCBD5QPgzGNU?=
 =?us-ascii?q?qF1hCWhaTOqYJkBIqQshGmBaDyBWTMaCBsVgyJSGQ/aLUM1PAIHCwEBAwmGS?=
 =?us-ascii?q?IlggX0BAQ?=
IronPort-Data: A9a23:NGKj9qqG+qx/QvvmkSnLNEfHMfJeBmLYZBIvgKrLsJaIsI4StFCzt
 garIBmEOqrYZTTwe4h/Oonn8hsO75CHzNBmGws4/HpnQiNBouPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQLNNwJcaDpOtvre8ks35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0u1SGFpyq
 vlfFGwQc1elrsfrnLCqc9A506zPLOGzVG8ekmtrwTecCbMtRorOBv2Xo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LUvrSn8/w7pX7WztVpUmeoqA+y2PS1wd2lrPqNbI5f/TRGpwIxxzD+
 DuuE2LRAUhLBfyb0Wu+rV3rhv/ssjL3RoYwLejtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U59QuE4qnZ+QCUAi4DVDEpQNUguNU7Wn8s2
 0OFks3BASFptvueSRq17r6eoDWzETIYIW8LeWkPSg5ty93ippwjyxHCVNBuFIargdDvXzL92
 TaHqG45nbp7pcgGy6m243jZjD+24JvEVAg44kPQRG3N0+9iTJSua4rt7R3Q6uxNad7ECFKAp
 3MD3cOZ6YjiEK2wqcBEe81VdJnB2hpPGGS0bYJHd3X5ywmQxg==
IronPort-HdrOrdr: A9a23:ouKjt6CqY5udiWrlHelZ55DYdb4zR+YMi2TDGXoBLiC9Ffb5qy
 nOppUmPHDP5Ar5NEtMpTniAse9qA3nhP1ICOAqVN/INjUO01HGEGgN1/qH/xTQXwaistNH3a
 1jc69xYeeAb2RSvILR4QG+Hdpl4PTvytHMuc7ui1pgUg1ubbht9ENaBhbzKDwPeCB2Qbc0C5
 aY4NNKvH6beXoRZtmmHXVtZZm7mzSyruOBXfbDbCRXkjVnSliTmcXHLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AR076jGpaNaw3Immt5H89qojmUcsAa0bhk3KXHxO?=
 =?us-ascii?q?lFCFPYZjIFV2BwZoxxg=3D=3D?=
X-Talos-MUID: 9a23:FNtjTwg5eFL6UnGhsS2hEMMpN5450oSqEBE2zrpBu9mnGj18JTO/tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="371512361"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 May 2025 01:19:51 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id F406C18000233;
	Wed, 21 May 2025 01:19:50 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id 981C3CC1256; Wed, 21 May 2025 01:19:50 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 21 May 2025 01:19:29 +0000
Subject: [PATCH net-next] net/enic: Allow at least 8 RQs to always be used
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-enic_min_8rq-v1-1-691bd2353273@cisco.com>
X-B4-Tracking: v=1; b=H4sIACAqLWgC/x3MSwqAMAwA0atI1hZsVPxcRaRIGzULo7YigvTuF
 pdvMfNCIM8UoM9e8HRz4F0SdJ6BXSdZSLFLBiywLmpdKhK2ZmMxrT9VhXrGsu0aZxFScnia+fl
 3AwhdSui5YIzxA7LY3l5oAAAA
X-Change-ID: 20250513-enic_min_8rq-421f23897dc2
To: Christian Benvenuti <benve@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 John Daley <johndale@cisco.com>, Nelson Escobar <neescoba@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747790390; l=2099;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=ZdFpzx5d3OudhHZXtSMNLgEaIS/5nAq30dYGget5Yyg=;
 b=lUVRDdfBXIxOqXvqIi97xHS+gUK/M/qQW/n81Pd94k9UsQRTC2FhZcAEjzjMjHtFR55n5WVwj
 OwRiU9GYBdlD2BK6RyW05NM9LKvNLduB01SpMj7dfPmhApixiiqEhaS
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

Enic started using netif_get_num_default_rss_queues() to set the number
of RQs used in commit cc94d6c4d40c ("enic: Adjust used MSI-X
wq/rq/cq/interrupt resources in a more robust way")

This resulted in machines with less than 16 cpus using less than 8 RQs.
Allow enic to use at least 8 RQs no matter how many cpus are in the
machine to not impact existing enic workloads after a kernel upgrade.

Reviewed-by: John Daley <johndale@cisco.com>
Reviewed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      | 1 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 9c12e967e9f1299e1cf3e280a16fb9bf93ac607b..301b3f3114afa8f60c34c05661ee3cf67d4d6808 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -26,6 +26,7 @@
 
 #define ENIC_WQ_MAX		256
 #define ENIC_RQ_MAX		256
+#define ENIC_RQ_MIN_DEFAULT	8
 
 #define ENIC_WQ_NAPI_BUDGET	256
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index c753c35b26ebd12c500f2056b3eb583de8c6b076..6ef8a0d90bce38781d931f62518cf9bafb223288 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2296,7 +2296,8 @@ static int enic_adjust_resources(struct enic *enic)
 		 * used based on which resource is the most constrained
 		 */
 		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
-		rq_default = netif_get_num_default_rss_queues();
+		rq_default = max(netif_get_num_default_rss_queues(),
+				 ENIC_RQ_MIN_DEFAULT);
 		rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
 		max_queues = min(enic->cq_avail,
 				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);

---
base-commit: ae605349e1fa5a29cdeecf52f92aa76850900d90
change-id: 20250513-enic_min_8rq-421f23897dc2

Best regards,
-- 
Nelson Escobar <neescoba@cisco.com>


