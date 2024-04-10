Return-Path: <netdev+bounces-86494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79189EFB0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BFB1C22A3F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C4158210;
	Wed, 10 Apr 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+j1QdiG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0515887C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744220; cv=none; b=bqXDQW2LWU1K7ZJnUF0K9p7uWtldtvo8fEXJqMDnQ3D0c6mNX8IN10QXeb+l9uABSAr6mFMtoeaECqVxgcY2M+cFfGIVINtYfqARzWjLdMoVn5To9xKsRF4TUUHI6THjaqugOl0x8DYgYp/lYzoBfTBUDUES5wryW6Fhz67HYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744220; c=relaxed/simple;
	bh=Emv197oZZubA8i7fvG/gSOa6wosW9h3Mu7jf+DBoOQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cF143+V9m/uc8CcO/iMaYUN/Iv+SI3wWfYhLN/PrC953ZeVMNKj9GrZ/6AnbqM0Yvk/vI2rl/nKzWDUC3TDcERaKrykc9EdVJibW+tGOUcPHT6EHVEAdon7FUpX3DfS0609mq92phS3zo1VSxcqTpPZEN3unCiF9kg4Uc4hsHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+j1QdiG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712744219; x=1744280219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Emv197oZZubA8i7fvG/gSOa6wosW9h3Mu7jf+DBoOQo=;
  b=W+j1QdiGqJhmbdTdkTfXauI6PtkWVZ26vlVnYhZaocnNXZ8vmQuzX8A7
   nOjnAaoYCfIRuFYnx8awyZtFZqhlfX/3xDY4df2VnW61ajcF3eJ8BjoSD
   Aj9ryBBy0Q4FmnTJP7M8a6eeVD5qz0EacAXC4nFhgKGCt0wGMaC/0IVcx
   0VeW3yEJXze18h6Ol5xnT0s/g7mBlDP4SoMBd6VVSOTInV8P4p1xpIxKK
   zZLbodha6T3ctZfOJxHPAAzJWiPDidyTLORSQ8zg16L3+MPnF20JSREPE
   C/KKWmxYJjDFpoCQvEKFA9ZjfFvwcwJmkrhERPugVppE4NxF21x4f/RHV
   A==;
X-CSE-ConnectionGUID: ngX8W8QZTIS450jI6MAbtw==
X-CSE-MsgGUID: yMfJCJecQ2ulbYyoFcuMzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19525388"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19525388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:16:57 -0700
X-CSE-ConnectionGUID: 7eSLwU16RMqlNWfO6r/Z1g==
X-CSE-MsgGUID: 6IXnU9BbRWKPBi50yicDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51737639"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2024 03:16:54 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 55C8728792;
	Wed, 10 Apr 2024 11:16:53 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next 1/2] ip: PFCP device support
Date: Wed, 10 Apr 2024 12:14:39 +0200
Message-Id: <20240410101440.9885-2-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410101440.9885-1-wojciech.drewek@intel.com>
References: <20240410101440.9885-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packet Forwarding Control Protocol is a 3GPP Protocol defined in
TS 29.244 [1]. Add support for PFCP device type in ip link.
It is capable of receiving PFCP messages and extracting its
metadata (session ID).

Its only purpose is to be used together with tc flower to create
SW/HW filters.

PFCP module does not take any netlink attributes so there is no
need to parse any args. Add new sections to the man to let the
user know about new device type.

[1] https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 ip/iplink.c           |  2 +-
 man/man8/ip-link.8.in | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 95314af5ab1c..73d4cd428047 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -44,7 +44,7 @@ void iplink_types_usage(void)
 		"          ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
 		"          ipip | ipoib | ipvlan | ipvtap |\n"
 		"          macsec | macvlan | macvtap | netdevsim |\n"
-		"          netkit | nlmon | rmnet | sit | team | team_slave |\n"
+		"          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |\n"
 		"          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |\n"
 		"          xfrm | virt_wifi }\n");
 }
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 31e2d7f0f5b8..2654f8c361ae 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -249,6 +249,7 @@ ip-link \- network device configuration
 .BR netdevsim " |"
 .BR netkit " |"
 .BR nlmon " |"
+.BR pfcp " |"
 .BR rmnet " |"
 .BR sit " |"
 .BR vcan " | "
@@ -391,6 +392,9 @@ Link types:
 .BR nlmon
 - Netlink monitoring device
 .sp
+.BR pfcp
+- Packet Forwarding Control Protocol device
+.sp
 .BR rmnet
 - Qualcomm rmnet device
 .sp
@@ -2124,6 +2128,12 @@ the following additional arguments are supported:
 .BI restart_count " RESTART_COUNT "
 - GTP instance restart counter
 
+.TP
+PFCP Type Support
+For a link of type
+.I PFCP
+no additional arguments are supported
+
 .in -8
 
 .SS ip link delete - delete virtual link
-- 
2.40.1


