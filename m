Return-Path: <netdev+bounces-186858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF0AA1C93
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C717A99C1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50B2620FA;
	Tue, 29 Apr 2025 21:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED00253F2C
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960414; cv=none; b=fO3Zp1khENRyme9TgsqDjGVthsxN+PC3uDFBhjuf79zaPZt2yAFlTt+u+4dCww/x9mxTajRQBNIasKSlxCrqaY0eFA98H7KE1gcQfnJj/qC5pYhSWW+Ll1pdf91GTSIfcWU7nraWOIUGj4SQENDDi7UZgQbd/FUU2TW1wsRPjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960414; c=relaxed/simple;
	bh=sXo0fgS8TalrcfMC8zTyTPNoeowX0Qo4jX6/Af3oWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LG2LDKJ2g/wNHRvSIcwEqhvnoxXMn5jzgAVH2YLdScboupVGhTWxJNuN/3Tj7iqKbWBcVFXELGV3CAhWPo9Ulzfpv4SJHAC5UJ2cEQ0ae1B3RqwWuUItIeFyUXKqSQhvwunYlPsxHYBSl41Kfvm1DyLnqWa+2HntUWJCeoScVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=basealt.ru; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basealt.ru
Received: from localhost (broadband-46-242-4-129.ip.moscow.rt.ru [46.242.4.129])
	(Authenticated sender: gremlin)
	by air.basealt.ru (Postfix) with ESMTPSA id 4532B2336D;
	Wed, 30 Apr 2025 00:00:01 +0300 (MSK)
Date: Wed, 30 Apr 2025 00:00:00 +0300
From: "Alexey V. Vissarionov" <gremlin@altlinux.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "Alexey V. Vissarionov" <gremlin@altlinux.org>,
	"David S. Miller" <davem@davemloft.net>,
	Derek Chickles <derek.chickles@cavium.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Eric Dumazet <edumazet@google.com>,
	Felix Manlunas <felix.manlunas@cavium.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH net] liquidio: check other_oct before dereferencing
Message-ID: <20250429210000.GB1820@altlinux.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

get_other_octeon_device() may return NULL; avoid dereferencing the
other_oct pointer in that case.

Found by ALT Linux Team (altlinux.org) and Linux Verification Center
(linuxtesting.org).

Fixes: bb54be589c7a ("liquidio: fix Octeon core watchdog timeout false alarm")
Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 1d79f6eaa41f6cbf..7b255126289b9fcd 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -796,10 +796,11 @@ static int liquidio_watchdog(void *param)
 
 #ifdef CONFIG_MODULE_UNLOAD
 		vfs_mask1 = READ_ONCE(oct->sriov_info.vf_drv_loaded_mask);
-		vfs_mask2 = READ_ONCE(other_oct->sriov_info.vf_drv_loaded_mask);
-
-		vfs_referencing_pf  = hweight64(vfs_mask1);
-		vfs_referencing_pf += hweight64(vfs_mask2);
+		vfs_referencing_pf = hweight64(vfs_mask1);
+		if (other_oct) {
+			vfs_mask2 = READ_ONCE(other_oct->sriov_info.vf_drv_loaded_mask);
+			vfs_referencing_pf += hweight64(vfs_mask2);
+		}
 
 		refcount = module_refcount(THIS_MODULE);
 		if (refcount >= vfs_referencing_pf) {


-- 
Alexey V. Vissarionov
gremlin נעי altlinux פ‏כ org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net

