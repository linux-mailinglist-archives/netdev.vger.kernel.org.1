Return-Path: <netdev+bounces-130670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7A198B0BF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EE21C21042
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2B11A2563;
	Mon, 30 Sep 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcEVGdP5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCD1A0BCB
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738399; cv=none; b=Zf7XNjnkMoklyQqcw2n89UsRL/2FlWlLkjzfEZJFom+ujPFsz6n0M3gCKsU1TZnsOD3aipbPLIf30Aj9V9ymaUO2shJrbpL6L7+5CL86OQQVVXmC1OZFt0cSqP9+33p2skCiET9+YeZmNk5aNGmkhdufHpx4Ukc3wxHvYok8npw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738399; c=relaxed/simple;
	bh=vy++shb5ncL/nVvgUxfjbJiY+nZ1X5a+bZhcxmIEiWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVT8RdV+AZe6Tk9+qefhq6ZnnjTYZKduLTSVdyKmNomEpe3ap5WO7mMhOjd1vCTtmfrHaA9J/cw0FmpwnAikjCH2mNcySwV/QLtvF1A3bdNKlgYc092ig/T4WJTP8K+vraBtqh7vOdSK1VGX6fcNjea6lO3Ul96j8fr+A0MLgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcEVGdP5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738399; x=1759274399;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vy++shb5ncL/nVvgUxfjbJiY+nZ1X5a+bZhcxmIEiWs=;
  b=HcEVGdP5GbLkSyDjah5QY1QxDuTePkjiXF93Hoick+LmEVohEdsNvPCJ
   fSUdbAMGcdMK64Lpr06sRclTA2mb8H9ZslEWu2//LcfJk/MPGzNneajHn
   ay5u0E/8VGQozAmYrWCJn6n+RNnoAIl72nxpog0wYVIZRKbYq3WxoMHm9
   ZOFlh6Ki7ZULkJUeajOE5ZcnKGWQyJaP7a85fjT7F/sCeJWMQbDacPfFb
   tlKAq/SMVXi35I961Ho8cq2H5bNyJWGToG+Al0uRDuOiqPbWeQvVJcKrX
   93oyolMS7Y4fIjbtoXmKQ3GDBQsgiTZvI09pZykk0q46a4dW3O1VWF7cq
   w==;
X-CSE-ConnectionGUID: IvPmn4PGRFyIfpI7Qw3VUQ==
X-CSE-MsgGUID: A1blTdYYSPGXn86xNFInHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660345"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660345"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: ecrhJjAZRXaiFRzWKOzH9Q==
X-CSE-MsgGUID: hEcBlJugQYCwDBoyOXGw6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356459"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Sep 2024 16:19:43 -0700
Subject: [PATCH net-next 10/10] lib: packing: use GENMASK() for box_mask
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-10-94b1f04aca85@intel.com>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
In-Reply-To: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is an u8, so using GENMASK_ULL() for unsigned long long is
unnecessary.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 lib/packing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index ac1f36c56a77..793942745e34 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -141,7 +141,7 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
 		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
-		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
+		box_mask = GENMASK(box_start_bit, box_end_bit);
 
 		/* Determine the offset of the u8 box inside the pbuf,
 		 * adjusted for quirks. The adjusted box_addr will be used for
@@ -249,7 +249,7 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
 		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
-		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
+		box_mask = GENMASK(box_start_bit, box_end_bit);
 
 		/* Determine the offset of the u8 box inside the pbuf,
 		 * adjusted for quirks. The adjusted box_addr will be used for

-- 
2.46.2.828.g9e56e24342b6


