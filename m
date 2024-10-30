Return-Path: <netdev+bounces-140516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CC9B6AF3
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC80C1C23AF1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592002144CA;
	Wed, 30 Oct 2024 17:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from james.theweblords.de (james.theweblords.de [217.11.55.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E51BD9EC
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.55.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308955; cv=none; b=UYVgi6+Qy2d/x0YvFV9kKu4VEJjr4Av86NY51r+9geYBD7ordhCrwd+yZxMZDT4kJ6CEy/KJKyyy95N9EdHB7YaRkyePuQ9cdcINx8BEU+uzHGmMXm1rF2a0VXOiWtP4woJH6Fqt1CGPxJBtB5CeX2NPTp5k22xIjyECp+Y8tHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308955; c=relaxed/simple;
	bh=WjvKj5wJzVXdeSW3KnKtyT6pe/JpIpkgKoJ3bYtIpGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hocwzhJbv0krShKfwAH3taNy1LD9S78+rTH3wA1CcTobY91fiI2s5sQv+z1YBtM7d1AvgA8Yj2wyanaXTWQ75RRmkDSt/NQXNkcLEbS7dhL/4L83otoXq0iBNtfJEHQiELHgNWXrS2QpT+EoGSmB9h7XOUbY8fkVA6awIG4tkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friiks.de; spf=pass smtp.mailfrom=friiks.de; arc=none smtp.client-ip=217.11.55.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friiks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friiks.de
Received: (qmail 21095 invoked by uid 210); 30 Oct 2024 17:22:29 -0000
X-Qmail-Scanner-Diagnostics: from 129.233.181.227 (petronios@theweblords.de@129.233.181.227) by james (envelope-from <pegro@friiks.de>, uid 201) with qmail-scanner-2.10st 
 (mhr: 1.0. spamassassin: 4.0.0. perlscan: 2.10st.  
 Clear:RC:1(129.233.181.227):. 
 Processed in 0.019699 secs); 30 Oct 2024 17:22:29 -0000
Received: from unknown (HELO james.theweblords.de) (petronios@theweblords.de@129.233.181.227)
  by james.theweblords.de with ESMTPA; 30 Oct 2024 17:22:29 -0000
From: pegro@friiks.de
To: intel-wired-lan@lists.osuosl.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>
Subject: [PATCH iwl-net v2] i40e: Fix handling changed priv flags
Date: Wed, 30 Oct 2024 18:22:24 +0100
Message-Id: <20241030172224.30548-1-pegro@friiks.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cf6dd743-759e-4db9-8811-fd1520262412@molgen.mpg.de>
References: <cf6dd743-759e-4db9-8811-fd1520262412@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Große <pegro@friiks.de>

After assembling the new private flags on a PF, the operation to determine
the changed flags uses the wrong bitmaps. Instead of xor-ing orig_flags
with new_flags, it uses the still unchanged pf->flags, thus changed_flags
is always 0.

Fix it by using the correct bitmaps.

The issue was discovered while debugging why disabling source pruning
stopped working with release 6.7. Although the new flags will be copied to
pf->flags later on in that function, disabling source pruning requires
a reset of the PF, which was skipped due to this bug.

Disabling source pruning:
$ sudo ethtool --set-priv-flags eno1 disable-source-pruning on
$ sudo ethtool --show-priv-flags eno1
Private flags for eno1:
MFP                   : off
total-port-shutdown   : off
LinkPolling           : off
flow-director-atr     : on
veb-stats             : off
hw-atr-eviction       : off
link-down-on-close    : off
legacy-rx             : off
disable-source-pruning: on
disable-fw-lldp       : off
rs-fec                : off
base-r-fec            : off
vf-vlan-pruning       : off

Regarding reproducing:

I observed the issue with a rather complicated lab setup, where
 * two VLAN interfaces are created on eno1
 * each with a different MAC address assigned
 * each moved into a separate namespace
 * both VLANs are bridged externally, so they form a single layer 2 network

The external bridge is done via a channel emulator adding packet loss and
delay and the application in the namespaces tries to send/receive traffic
and measure the performance. Sender and receiver are separated by
namespaces, yet the network card "sees its own traffic" send back to it.
To make that work, source pruning has to be disabled.

Fixes: 70756d0a4727 ("i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf")
Signed-off-by: Peter Große <pegro@friiks.de>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c841779713f6..016c0ae6b36f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5306,7 +5306,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	}
 
 flags_complete:
-	bitmap_xor(changed_flags, pf->flags, orig_flags, I40E_PF_FLAGS_NBITS);
+	bitmap_xor(changed_flags, new_flags, orig_flags, I40E_PF_FLAGS_NBITS);
 
 	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
 		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
-- 
2.34.1


