Return-Path: <netdev+bounces-218233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F39B3B896
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C9E581785
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7930AD12;
	Fri, 29 Aug 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcBRx/kx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10733093A8
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462704; cv=none; b=WgZSIFROh6PvAtaJhHaPESi665IE/pyQW8et4KVd9MCrPKAeysup+uV9tD+Qi2MTGw1cj8tLeLmu2BRN+bscr8wwgkB7e1FCPcDPS7oCkpolj89gR8ETBsGJSeliBd4Z6ZgjFQrlG2+s0y/9D2E+EOtQAvdmSaDGZRI0h5RbCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462704; c=relaxed/simple;
	bh=iSdqhr8e0gpADBTa12VEAogWAlr9lLsQ9TqJm1xtOt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUIB3ub+3O1zfhy7CZ/UzKwhqYjHCBaOWJQkkTYbdn9whrIq+Pl8kcz4zkhtu0rNoSPjRHWU9k1QbYdSAlsC7vVtzdii5iokH/gR/Kx3VOpHWSFWS/OCeVLWpOpfPbciarCzBgdMzQX5lC3IGL+6N6cAf/729miD4X6ajE+/uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcBRx/kx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756462703; x=1787998703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSdqhr8e0gpADBTa12VEAogWAlr9lLsQ9TqJm1xtOt4=;
  b=CcBRx/kxZ+2ey5wjJj3zvlNMeQLotm9LjOKJXwLPG9BW4cBOPNUE8l9Q
   H4GGP5rcdPgdEAMSfm33ooTDtwAejFqCTWtKKE4yjdytPPIadM+U0MxhZ
   ch9VcG6G7AO/taeSXLU01/7OX15bG+RT0XFdNisXlyKQe2YdjF3/JtGt5
   uGSwN9BVKEqw02BuJPin896p7v95Xew7XXsDVKuIcBytPBn1S9OQH0D3v
   UkvdKYZheCUzU3J3DYmI//QOkaQCG01sIxLchT5fAecmBsClUBoVhw7Sg
   7qt94cBaw0Pq56+D1/D79Wg333epdZzcelgk6eC6kwC/MWRTL+VozMzBQ
   g==;
X-CSE-ConnectionGUID: 6SRxXxzpRcClorgELNKCUg==
X-CSE-MsgGUID: z7dr0pzTTjGT3gbNlfakmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76199492"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="76199492"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 03:18:23 -0700
X-CSE-ConnectionGUID: KSp282w2SFSsL07itVY2Og==
X-CSE-MsgGUID: OLtMHy/hS0G+45Pid+yMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="207489285"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 29 Aug 2025 03:18:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	mschmidt@redhat.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 4/5] ice: Extend PTYPE bitmap coverage for GTP encapsulated flows
Date: Fri, 29 Aug 2025 10:18:07 +0000
Message-ID: <20250829101809.1022945-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
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

Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Co-developed-by: Jie Wang <jie1x.wang@intel.com>
Signed-off-by: Jie Wang <jie1x.wang@intel.com>
Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
--
 ice_flow.c |   54 +++++++++++++++++++++++++++---------------------------
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


