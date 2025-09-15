Return-Path: <netdev+bounces-223083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF14CB57D90
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DF03A5775
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4C31A071;
	Mon, 15 Sep 2025 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTI5+asb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0463191DA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943585; cv=none; b=sjuWPiaHY4HT61phiRJ3bEM9irsQ931M6su3WHVazsVBW5E8wUuI66o1IdnkRv4TRS/1AudRKEVGWYQ60VYiiwyaoACyEH5FFV/UZXp304eB67brm6h36UHc66Ac7Aw5x8q/FhBMMnLDlyz9LZcucGUGYcsds71F2mb6Kt0BJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943585; c=relaxed/simple;
	bh=HTg9QhjkoVKmQZduQnEhsCxpYzGKo02PCCSDeK7uETI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrnNDqS4a3Liw6OTaFJoUoITcDP6yvVIWtuO3lbM9CPp0CDTyR3LKBT+d6BwN8uYz5AOC6Wgj1jO1xT/qyUmsnX/96tbP1GtgjXz26k0FHfAGgdxMITtdep6iIGSDT3q87MwBS3DNBNQDGPvyhlYRhJkgDeTGXiYP5zJHN77wTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTI5+asb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757943583; x=1789479583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTg9QhjkoVKmQZduQnEhsCxpYzGKo02PCCSDeK7uETI=;
  b=WTI5+asb0YJgjoEwH0ajzHFDqcOCWKFR1hB0yQ8c+lGpm/34ovnyNFul
   WqUx8PXXqskRjNYammqeoEEESRarKluLORFBJiyd25NaGL9mIaS0SLSFr
   5b9eLF9KRcpIzhfQVq3weyzwUD9C2f9DpQNVa1d/ykyMX72M2V7sMBwst
   CmWhiyd9mo35l7HoL37PyAmW2l1Otg47xp/C+6J2j6v9ZxtfuBnwarGAi
   YSMKMuiPSOujtybpwqcnORqw0863+iB2L3AG3C+s62xtWah2AJettvf59
   NqwrAyjUCaW2iGyGKCaiIHhzZ7RgDp5GUMxt1aQDtn29LzjP0VKG0SL9z
   g==;
X-CSE-ConnectionGUID: Au6Q8q1iRZCmhT/VoogeKA==
X-CSE-MsgGUID: cdBr3ZFKRG6OunjWyZLROg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64008140"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64008140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 06:39:42 -0700
X-CSE-ConnectionGUID: otZkHaBqQRukKSJfEyifEg==
X-CSE-MsgGUID: kJHnWhEKQayKSDoRf6t9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="205421537"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 15 Sep 2025 06:39:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	mschmidt@redhat.com,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v5 4/5] ice: Extend PTYPE bitmap coverage for GTP encapsulated flows
Date: Mon, 15 Sep 2025 13:39:27 +0000
Message-ID: <20250915133928.3308335-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915133928.3308335-1-aleksandr.loktionov@intel.com>
References: <20250915133928.3308335-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
across multiple flow types in the Intel ICE driver to support GTP
(GPRS Tunneling Protocol) encapsulated traffic.

Enable improved Receive Side Scaling (RSS) configuration for both user
and control plane GTP flows.

Cover a wide range of protocol and encapsulation scenarios, including:
 - MAC OFOS and IL
 - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
 - TCP, SCTP, ICMP
 - GRE OF
 - GTPC (control plane)

Expand the PTYPE bitmap entries to improve classification and
distribution of GTP traffic across multiple queues, enhancing
performance and scalability in mobile network environments.

--
 ice_flow.c |   54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Co-developed-by: Jie Wang <jie1x.wang@intel.com>
Signed-off-by: Jie Wang <jie1x.wang@intel.com>
Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 52 +++++++++++------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 54e259b..10b9203 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -219,9 +219,9 @@ struct ice_flow_field_info ice_flds_info[ICE_FLOW_FIELD_IDX_MAX] = {
  */
 static const u32 ice_ptypes_mac_ofos[] = {
 	0xFDC00846, 0xBFBF7F7E, 0xF70001DF, 0xFEFDFDFB,
-	0x0000077E, 0x00000000, 0x00000000, 0x00000000,
-	0x00400000, 0x03FFF000, 0x7FFFFFE0, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0000077E, 0x000003FF, 0x00000000, 0x00000000,
+	0x00400000, 0x03FFF000, 0xFFFFFFE0, 0x00000707,
+	0xFFFFF000, 0x000003FF, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -244,10 +244,10 @@ static const u32 ice_ptypes_macvlan_il[] = {
  * include IPv4 other PTYPEs
  */
 static const u32 ice_ptypes_ipv4_ofos[] = {
-	0x1DC00000, 0x04000800, 0x00000000, 0x00000000,
+	0x1D800000, 0xBFBF7800, 0x000001DF, 0x00000000,
 	0x00000000, 0x00000155, 0x00000000, 0x00000000,
-	0x00000000, 0x000FC000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000FC000, 0x000002A0, 0x00000000,
+	0x00015000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -258,10 +258,10 @@ static const u32 ice_ptypes_ipv4_ofos[] = {
  * IPv4 other PTYPEs
  */
 static const u32 ice_ptypes_ipv4_ofos_all[] = {
-	0x1DC00000, 0x04000800, 0x00000000, 0x00000000,
+	0x1D800000, 0x27BF7800, 0x00000000, 0x00000000,
 	0x00000000, 0x00000155, 0x00000000, 0x00000000,
-	0x00000000, 0x000FC000, 0x83E0F800, 0x00000101,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000FC000, 0x83E0FAA0, 0x00000101,
+	0x3FFD5000, 0x00000000, 0x02FBEFBC, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -273,7 +273,7 @@ static const u32 ice_ptypes_ipv4_il[] = {
 	0xE0000000, 0xB807700E, 0x80000003, 0xE01DC03B,
 	0x0000000E, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x001FF800, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xC0FC0000, 0x0000000F, 0xBC0BC0BC, 0x00000BC0,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -284,10 +284,10 @@ static const u32 ice_ptypes_ipv4_il[] = {
  * include IPv6 other PTYPEs
  */
 static const u32 ice_ptypes_ipv6_ofos[] = {
-	0x00000000, 0x00000000, 0x77000000, 0x10002000,
+	0x00000000, 0x00000000, 0x76000000, 0x10002000,
 	0x00000000, 0x000002AA, 0x00000000, 0x00000000,
-	0x00000000, 0x03F00000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x03F00000, 0x00000540, 0x00000000,
+	0x0002A000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -298,10 +298,10 @@ static const u32 ice_ptypes_ipv6_ofos[] = {
  * IPv6 other PTYPEs
  */
 static const u32 ice_ptypes_ipv6_ofos_all[] = {
-	0x00000000, 0x00000000, 0x77000000, 0x10002000,
-	0x00000000, 0x000002AA, 0x00000000, 0x00000000,
-	0x00080F00, 0x03F00000, 0x7C1F0000, 0x00000206,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x76000000, 0xFEFDE000,
+	0x0000077E, 0x000002AA, 0x00000000, 0x00000000,
+	0x00000000, 0x03F00000, 0x7C1F0540, 0x00000206,
+	0xC002A000, 0x000003FF, 0xBC000000, 0x0002FBEF,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -313,7 +313,7 @@ static const u32 ice_ptypes_ipv6_il[] = {
 	0x00000000, 0x03B80770, 0x000001DC, 0x0EE00000,
 	0x00000770, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x7FE00000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x3F000000, 0x000003F0, 0x02F02F00, 0x0002F02F,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -386,8 +386,8 @@ static const u32 ice_ptypes_ipv6_il_no_l4[] = {
 static const u32 ice_ptypes_udp_il[] = {
 	0x81000000, 0x20204040, 0x04000010, 0x80810102,
 	0x00000040, 0x00000000, 0x00000000, 0x00000000,
-	0x00000000, 0x00410000, 0x90842000, 0x00000007,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00410000, 0x908427E0, 0x00000007,
+	0x0413F000, 0x00000041, 0x10410410, 0x00004104,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -399,7 +399,7 @@ static const u32 ice_ptypes_tcp_il[] = {
 	0x04000000, 0x80810102, 0x10000040, 0x02040408,
 	0x00000102, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00820000, 0x21084000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08200000, 0x00000082, 0x20820820, 0x00008208,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -411,7 +411,7 @@ static const u32 ice_ptypes_sctp_il[] = {
 	0x08000000, 0x01020204, 0x20000081, 0x04080810,
 	0x00000204, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x01040000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x10400000, 0x00000104, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -435,7 +435,7 @@ static const u32 ice_ptypes_icmp_il[] = {
 	0x00000000, 0x02040408, 0x40000102, 0x08101020,
 	0x00000408, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x42108000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x20800000, 0x00000208, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -447,7 +447,7 @@ static const u32 ice_ptypes_gre_of[] = {
 	0x00000000, 0xBFBF7800, 0x000001DF, 0xFEFDE000,
 	0x0000017E, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0xBEFBEFBC, 0x0002FBEF,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -456,7 +456,7 @@ static const u32 ice_ptypes_gre_of[] = {
 
 /* Packet types for packets with an Innermost/Last MAC header */
 static const u32 ice_ptypes_mac_il[] = {
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
@@ -470,7 +470,7 @@ static const u32 ice_ptypes_mac_il[] = {
 static const u32 ice_ptypes_gtpc[] = {
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000000, 0x00000180, 0x00000000,
+	0x00000000, 0x00000000, 0x000001E0, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
 	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-- 
2.47.1


