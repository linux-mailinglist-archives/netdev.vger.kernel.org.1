Return-Path: <netdev+bounces-169259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F4A43135
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A48917C9B3
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E320CCD3;
	Mon, 24 Feb 2025 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="K7R/wjOZ"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6120B814
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440650; cv=none; b=oCDa7AbDCUTF3ThSebT5I/8lye/s719nA0g+4ps3YYH2NsYVXW4azpHB4FJfjln4kHgeCdvTWh5HNXdv0gXKKDoIb64zA5I20oT0b9rMWFVnAKXCkFEU8PugbuCvK+nbLm6yCgX0gk9BQgmaGHuy0zDh+lGvA7QvlP2u+y5ry78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440650; c=relaxed/simple;
	bh=cqoXEVxPqmr2yNfVSpOLx85qE5vA0kB4BG9bD/yvlZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCxtMl4V9DhIKoJrnkUT8wjma23OQEG5BEA1uT8MWXhZtp3pMPF5xjijm64OJ/Iid2PNGDM1T295w8LSPYOrL0utFtJE5IFrXFi+J358Ci9PEi7W3bT8zCOB/fEzusK6u4blgMiiJSO5BgNxd+uVlGSGKUA6p7zQu/lus8CdJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=K7R/wjOZ; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=921; q=dns/txt;
  s=iport01; t=1740440648; x=1741650248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0gyIkrJyfkv0mHjGPTaFKbvhgDzthE6B5pwcNR36xOI=;
  b=K7R/wjOZclph7M4hfMQFN9oaBPZhKkKZCk4Pncg8xtzHXzLblN5Y4Dgn
   4zUbMCuhzZZUdlq2KWspMFVh6bc0rYr1leKddFqOTztPR70kqlzmddtC5
   4YN6Ahxs8oXqV/+5KwEV84bwvJ3R5/b7xJ3breQSZ2qdqH05RMqlYuO7c
   zvV3ab/uPhKtxUAFXwsYy2Hm3O2LC0v3Ikm3Q5O2jeoncu1+Ffp3ap3ER
   3+3mMd4EdJ6OYfa6jGblWSI9/aVqaXLTllT/ogD4RGZoWtndyCTyye5mO
   Rl9yAOqOdaHzrTp9gmmso8A/u3VLsltwSCFVqr01e2a8bXAb7B61nJEQN
   A==;
X-CSE-ConnectionGUID: dzvFPmvhTY2Jd+24bHuR+Q==
X-CSE-MsgGUID: y9rvEWbsSv+FX2PxI8o/MA==
X-IPAS-Result: =?us-ascii?q?A0AFAABcA71n/47/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgX8FAQEBAQsBgkp2WUNIBIxuX4h0nheBJQNWDwEBAQ87CQQBA?=
 =?us-ascii?q?YUHAosQAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE?=
 =?us-ascii?q?4V7DYZbAgEDMgFGEFErKwcSgwIBgmQDEa4XgiyBAd40gWgGgUgBhWuHX3CEd?=
 =?us-ascii?q?ycbgUlEgRWDaIUQhXcEh1uVGZIYSIEhA1ksAVUTDQoLBwWBOTgDIAoLDAsSH?=
 =?us-ascii?q?BUCFB0PBhAEakM3gkVpSToCDQI1gh4kWIIrhFaEQ4RCgj9RgkKCEXGBGokvg?=
 =?us-ascii?q?0hAAwsYDUgRLDcGDhsGPm4HoAsBPIQnDnsTLIIUHQylS6EEhCWBY4o1lTAaM?=
 =?us-ascii?q?6pVmH0ijWOWRYRmgWc8gVkzGggbFYMiEz8ZD5cuxmQlMgIBOQIHCwEBAwmRZ?=
 =?us-ascii?q?QEB?=
IronPort-Data: A9a23:Lr/OPK9c29BZbgrhW5DFDrUDs3+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 WFNWz+FPf2LZ2KhLt0gaInl8kIE65LSydVhS1Br/npEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qpyyHjEAX9gWMsaDhIs/7rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k6L5M2wuNpAV1/r
 94Ua2pRZDCevaGPlefTpulE3qzPLeHxN48Z/3UlxjbDALN+HNbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0cn1lQ/UPrSmM+qgXn5fzRcpXqepLE85C7YywkZPL3Fa4ONIoPSHJUJ9qqej
 nOX5XrUPRsBD8Lc5wrfymKN1uiIuAquDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0X9lIO+w89AyJjKHT5m6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5lHbK5g8PdBz792
 XaJoTI4irFVitQEv5hX5njdiD6q45yMRQkv60CPAySu7xhyY8iuYInABUXn0Mus5b2xFjGp1
 EXoUeDHhAzSJflhTBCwfdg=
IronPort-HdrOrdr: A9a23:NXD8qawLPACh1qtQhKm8KrPwK71zdoMgy1knxilNoNJuHfBw8P
 re+8jzuiWUtN98YhwdcJW7Scu9qBDnhPpICPcqXYtKNTOO0ADDEGgh1/qG/9SKIUPDH4BmuZ
 uIC5IOa+EZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: 9a23:y7IZsW1ofvCbtaRfpieGTbxfFtI7XEXY0nfsEhWaBSUzFLe1VGXTwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AUPxeiAxwrd4Vf6I35uPJvZ7U0c+aqLX/El4grp8?=
 =?us-ascii?q?dgNfHGxwqAye83DPwZ6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,312,1732579200"; 
   d="scan'208";a="310070184"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Feb 2025 23:44:00 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id 9589818000236;
	Mon, 24 Feb 2025 23:44:00 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 6072920F2004; Mon, 24 Feb 2025 15:44:00 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	kernel test robot <lkp@intel.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next 1/1] enic: add dependency on Page Pool
Date: Mon, 24 Feb 2025 15:43:50 -0800
Message-Id: <20250224234350.23157-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250224234350.23157-1-johndale@cisco.com>
References: <20250224234350.23157-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

Driver was not configured to select page_pool, causing a compile error
if page pool module was not already selected.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502211253.3XRosM9I-lkp@intel.com/
Fixes: d24cb52b2d8a ("enic: Use the Page Pool API for RX")
Reviewed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cisco/enic/Kconfig b/drivers/net/ethernet/cisco/enic/Kconfig
index ad80c0fa96a6..96709875fe4f 100644
--- a/drivers/net/ethernet/cisco/enic/Kconfig
+++ b/drivers/net/ethernet/cisco/enic/Kconfig
@@ -6,5 +6,6 @@
 config ENIC
 	tristate "Cisco VIC Ethernet NIC Support"
 	depends on PCI
+	select PAGE_POOL
 	help
 	  This enables the support for the Cisco VIC Ethernet card.
-- 
2.39.3


