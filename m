Return-Path: <netdev+bounces-140453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DEC9B68EE
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82A51C210D7
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C37213150;
	Wed, 30 Oct 2024 16:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from james.theweblords.de (james.theweblords.de [217.11.55.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445E9433D5
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.55.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304835; cv=none; b=qFEYkzE2JOhAvgmzUQ/7DEbv3fjF1crHzZkx/5S2zbw9f4rVVk4/k+GemV57XuzqHKXGvOLzP+u8TkNvD3s4ZkkuLgaSvOAychnKMbDWSlPlw1kbfqvhRJlVL1Q/HkyXjp7YaDJUPiCWU24cvKJ8DQtrocbXhNvUZW5Arj3PEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304835; c=relaxed/simple;
	bh=+O8RJAxYSRuHty5z3Y6g1TE6UKAHeAqziQBuvddt7ho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CZ9CRMiWHzSCvqLaIAAQ7ocukq9iORQd7+SkSwyDJUqVRFgzG+BkleMuz8I2+T3VtkAuwonFL7a05295wo1xAdt8B9dwSYZ7menkCSovLac4EEejNkgjbT7TonewcgWjnY2tl0J7Fp906rrSM3+fvwl7XOJaeuOV9ydixMVuQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friiks.de; spf=pass smtp.mailfrom=friiks.de; arc=none smtp.client-ip=217.11.55.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friiks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friiks.de
Received: (qmail 17590 invoked by uid 210); 30 Oct 2024 16:07:09 -0000
X-Qmail-Scanner-Diagnostics: from 129.233.181.227 (petronios@theweblords.de@129.233.181.227) by james (envelope-from <pegro@friiks.de>, uid 201) with qmail-scanner-2.10st 
 (mhr: 1.0. spamassassin: 4.0.0. perlscan: 2.10st.  
 Clear:RC:1(129.233.181.227):. 
 Processed in 0.073649 secs); 30 Oct 2024 16:07:09 -0000
Received: from unknown (HELO james.theweblords.de) (petronios@theweblords.de@129.233.181.227)
  by james.theweblords.de with ESMTPA; 30 Oct 2024 16:07:09 -0000
From: pegro@friiks.de
To: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>
Subject: [PATCH iwl-net] i40e: Fix handling changed priv flags
Date: Wed, 30 Oct 2024 17:06:43 +0100
Message-Id: <20241030160643.9950-1-pegro@friiks.de>
X-Mailer: git-send-email 2.34.1
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
the changed flags uses the wrong bitmaps. Instead of xor-ing orig_flags with
new_flags, it uses the still unchanged pf->flags, thus changed_flags is always 0.

Fix it by using the corrent bitmaps.

The issue was discovered while debugging why disabling source pruning
stopped working with release 6.7. Although the new flags will be copied to
pf->flags later on in that function, source pruning requires a reset of the PF,
which was skipped due to this bug.

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


