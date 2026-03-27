Return-Path: <netdev+bounces-272419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGSgOskzxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:37:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B464734084E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F53A30D1567
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480634DB72;
	Fri, 27 Mar 2026 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEWUVPm2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500A3CD8AB
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596679; cv=none; b=lp4GIx8HI1xnbEmkBwQntAixzQMWxGjxEuohgRxhDzuYpaoVdKW9losOjsoHliHOYLthSSSCbsU0QaS9b5hf5iNRTOG7qcW3nZJRDTba8XAZoZaUQhRzXGDGOVKvRIkbpG7G6fLFABYNQ97IvkysoAnTMwk1R2m4d0tfpAy2PXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596679; c=relaxed/simple;
	bh=8p/HtnBUPvGrSHRur7c8OxjrxPjk33dmg37K91oRb6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3/1UAYI7PaHKTkoheQZhrOxhVHMuWQx9F3MkYrU3aKBuBtdE7C97evL83kw35qixN5+9mv36AJVYpalKPWTCtONlF3+F2vHJ1wQ8qiCJxoLuKSyc2rU2i5yPy2WoHcPEURKp7u4cWf1AISKw/KkeMfqVNU02HA7GS17z32e3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEWUVPm2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596671; x=1806132671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8p/HtnBUPvGrSHRur7c8OxjrxPjk33dmg37K91oRb6I=;
  b=IEWUVPm2zXR3+ZfQ0SrdEAN1yrse3YGHe1/9LVOHb8MojSsYS3M/aOQ9
   bv3S9rAqvBj3flqdbTRYSThFA9WQGEXctqenG82+45JtjzNsANzpPt07W
   WWavK3Tzt1NuTwS4gTt5U32LmXPKDKhhA4gVvD0qt1yhYuz+u9Ax9UQIk
   ImboiVWCRcI8Jps+CaGYtYIu+CpZDmT7FY309/YnxtOBeyf6TGwcRZBkA
   ipdXoGNu3E5PjVSmd9543kDskm66ZupllZUHZOs5Y7pMWSOOL8tF99Wx8
   5CAVojb6p4ao4cE9sMfOkJAm6axWEnQzRZj1xXMWLuwzxpsgy7njkgrW5
   w==;
X-CSE-ConnectionGUID: iLAGKp7WQyG8rfjEFMXcgQ==
X-CSE-MsgGUID: LyL7eEfET86ccFPnigkL0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734328"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734328"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:31:00 -0700
X-CSE-ConnectionGUID: LN1ynwVCQrSlFleup1Cjgg==
X-CSE-MsgGUID: slsuElGSTNygE3LNi3aO6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740404"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:59 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: use int instead of u32 for error code variables
Date: Fri, 27 Mar 2026 08:30:43 +0100
Message-ID: <20260327073046.134085-9-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272419-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B464734084E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variables used to store return values of kernel and driver functions
throughout the ixgbe driver are declared as u32 in several places.  Such
functions return negative errno values on error (e.g. -EIO, -EFAULT),
which are sign-extended negative integers.  Storing them in an unsigned
u32 silently wraps the value: -EIO (0xFFFFFFF7) stored in u32 becomes a
large positive number, so any "if (status)" truthiness check still works
by accident, but comparisons against specific negative error codes or
propagation up the call stack would produce wrong results.

In the Linux kernel, u32 is reserved for fixed-width quantities used in
hardware interfaces or protocol structures.  Using it for generic error
codes misleads reviewers into thinking the value is hardware-constrained.

Change all such local variables from u32 to int driver-wide: one in
ixgbe_main.c (ixgbe_resume), three in ixgbe_phy.c
(ixgbe_identify_phy_generic, ixgbe_tn_check_overtemp,
ixgbe_set_copper_phy_power), and six in ixgbe_x550.c
(ixgbe_check_link_t_X550em, ixgbe_get_lasi_ext_t_x550em,
ixgbe_enable_lasi_ext_t_x550em, ixgbe_handle_lasi_ext_t_x550em,
ixgbe_ext_phy_t_x550em_get_link, ixgbe_setup_internal_phy_t_x550em).

No functional change.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  6 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..703451d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7518,6 +7518,6 @@ static int ixgbe_resume(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
-	u32 err;
+	int err;
 
 	adapter->hw.hw_addr = adapter->io_addr;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index a1b2c3d..b4c5d6e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -264,5 +264,5 @@ int ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 {
-	u32 status = -EFAULT;
+	int status = -EFAULT;
 	u32 phy_addr;
 
 	if (!hw->phy.phy_semaphore_mask) {
@@ -2812,6 +2812,6 @@ bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 {
 	u16 phy_data = 0;
-	u32 status;
+	int status;
 
 	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
 		return false;
@@ -2833,5 +2833,5 @@ int ixgbe_set_copper_phy_power(struct ixgbe_hw *hw, bool on)
 {
-	u32 status;
+	int status;
 	u16 reg;
 
 	/* Bail if we don't have copper phy */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index c1d2e3f..d4e5f6a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1912,6 +1912,6 @@ static int ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 				     bool link_up_wait_to_complete)
 {
-	u32 status;
+	int status;
 	u16 i, autoneg_status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
@@ -2331,6 +2331,6 @@ static int ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
 				       bool *is_overtemp)
 {
-	u32 status;
+	int status;
 	u16 reg;
 
 	*is_overtemp = false;
@@ -2419,6 +2419,6 @@ static int ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
 	bool lsc, overtemp;
-	u32 status;
+	int status;
 	u16 reg;
 
 	/* Clear interrupt flags */
@@ -2512,7 +2512,7 @@ static int ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
-	u32 status;
+	int status;
 
 	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
 	if (status)
@@ -2608,5 +2608,5 @@ static int ixgbe_ext_phy_t_x550em_get_link(struct ixgbe_hw *hw, bool *link_up)
 {
-	u32 ret;
+	int ret;
 	u16 autoneg_status;
 
 	*link_up = false;
@@ -2642,7 +2642,7 @@ static int ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 {
 	ixgbe_link_speed force_speed;
 	bool link_up;
-	u32 status;
+	int status;
 	u16 speed;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-- 
2.52.0

