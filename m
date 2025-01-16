Return-Path: <netdev+bounces-158938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9DA13DE8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3BF1883A28
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52B22A80B;
	Thu, 16 Jan 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbXHWQN9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95B22A809
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041957; cv=none; b=b72Z9DonWLot2GmH1g4eO67dvz0mjj33jnrxLrLVAk7fgBLUE/KjCRNVIblvX9EMTbFr0izDcE6tJHHqFIc69ZvWTpJtKVEaMhXGVvNy/5NUT1pYpQa+gQaim3dsl5ShzHrznJO/iKDQL/a+QDr7YCzHqgdiEd57thaVnpVwc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041957; c=relaxed/simple;
	bh=15ABlglkjWdVDcYXhOjVsxKTozHEJVUe0W95l8VAFg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iQC+ztVgEjcJCKZqr023YK0ijDEmNVetepmNeGzE+EnxhKhpHRVY/WizFp1P1EjET5q3ohN3ABV/kjQDKIpPQhTpzhefMWC8g6DVaSSMx49mu7+23GNgIsjx6FO78GdqaIdm6WqPfTqvy56FrvpkPBcSDswUOhpSgkQyTnhtjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbXHWQN9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041956; x=1768577956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=15ABlglkjWdVDcYXhOjVsxKTozHEJVUe0W95l8VAFg4=;
  b=SbXHWQN9LUOsj/uPoUG7bC3QYtUkggtMM84JLou+W7flsN5VGntBpDxE
   Wz+kkDCxiv8BG/MtZf3vQRO+alqFjqHPjFquFxXb9P51b7k4ElyVLXvAJ
   HZxqVAACnPegXzhwnk00gwsrtWgZBWLdjrzWUPaKnEoUOb8uiPwO08amE
   aU5d8654ZumYWWzsiAGLdYaxHGehVnqeJsM6JTjT5mTOVviXodcnC7GD9
   hFGyF2Ue5b2qIGvXviab8tUeXEfTHOkEcfXAzNo2d/h9CGG/DHrRn7gyJ
   /kqAh7CIPH1MMQ66uMi37gaC64oGrNuxImH5nktVm+6j2WEjbHMxBC639
   g==;
X-CSE-ConnectionGUID: vBqqLk5QS6+vnRUY7tZahQ==
X-CSE-MsgGUID: mjMOL294TJe9LOzkl1HJdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="25037407"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="25037407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:39:15 -0800
X-CSE-ConnectionGUID: gCaoGKOOSBWVs3lBxF0FSw==
X-CSE-MsgGUID: ZTS/+uYETTejp1sk5qJ7Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="110540978"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 16 Jan 2025 07:39:12 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	xudu@redhat.com,
	mschmidt@redhat.com,
	jmaxwell@redhat.com,
	poros@redhat.com,
	przemyslaw.kitszel@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH intel-net 0/3] ice: fix Rx data path for heavy 9k MTU traffic
Date: Thu, 16 Jan 2025 16:39:05 +0100
Message-Id: <20250116153908.515848-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello in 2025,

this patchset fixes a pretty nasty issue that was reported by RedHat
folks which occured after ~30 minutes (this value varied, just trying
here to state that it was not observed immediately but rather after a
considerable longer amount of time) when ice driver was tortured with
jumbo frames via mix of iperf traffic executed simultaneously with
wrk/nginx on client/server sides (HTTP and TCP workloads basically).

The reported splats were spanning across all the bad things that can
happen to the state of page - refcount underflow, use-after-free, etc.
One of these looked as follows:

[ 2084.019891] BUG: Bad page state in process swapper/34  pfn:97fcd0
[ 2084.025990] page:00000000a60ee772 refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x97fcd0
[ 2084.035462] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[ 2084.041990] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[ 2084.049730] raw: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000000
[ 2084.057468] page dumped because: nonzero _refcount
[ 2084.062260] Modules linked in: bonding tls sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200 irqd
[ 2084.137829] CPU: 34 PID: 0 Comm: swapper/34 Kdump: loaded Not tainted 5.14.0-427.37.1.el9_4.x86_64 #1
[ 2084.147039] Hardware name: Dell Inc. PowerEdge R750/0216NK, BIOS 1.13.2 12/19/2023
[ 2084.154604] Call Trace:
[ 2084.157058]  <IRQ>
[ 2084.159080]  dump_stack_lvl+0x34/0x48
[ 2084.162752]  bad_page.cold+0x63/0x94
[ 2084.166333]  check_new_pages+0xb3/0xe0
[ 2084.170083]  rmqueue_bulk+0x2d2/0x9e0
[ 2084.173749]  ? ktime_get+0x35/0xa0
[ 2084.177159]  rmqueue_pcplist+0x13b/0x210
[ 2084.181081]  rmqueue+0x7d3/0xd40
[ 2084.184316]  ? xas_load+0x9/0xa0
[ 2084.187547]  ? xas_find+0x183/0x1d0
[ 2084.191041]  ? xa_find_after+0xd0/0x130
[ 2084.194879]  ? intel_iommu_iotlb_sync_map+0x89/0xe0
[ 2084.199759]  get_page_from_freelist+0x11f/0x530
[ 2084.204291]  __alloc_pages+0xf2/0x250
[ 2084.207958]  ice_alloc_rx_bufs+0xcc/0x1c0 [ice]
[ 2084.212543]  ice_clean_rx_irq+0x631/0xa20 [ice]
[ 2084.217111]  ice_napi_poll+0xdf/0x2a0 [ice]
[ 2084.221330]  __napi_poll+0x27/0x170
[ 2084.224824]  net_rx_action+0x233/0x2f0
[ 2084.228575]  __do_softirq+0xc7/0x2ac
[ 2084.232155]  __irq_exit_rcu+0xa1/0xc0
[ 2084.235821]  common_interrupt+0x80/0xa0
[ 2084.239662]  </IRQ>
[ 2084.241768]  <TASK>

The fix is mostly about reverting what was done in commit 1dc1a7e7f410
("ice: Centrallize Rx buffer recycling") followed by proper timing on
page_count() storage and then removing the ice_rx_buf::act related logic
(which was mostly introduced for purposes from cited commit).

Special thanks to Xu Du for providing reproducer and Jacob Keller for
initial extensive analysis.

Thanks,
Maciej

Maciej Fijalkowski (3):
  ice: put Rx buffers after being done with current frame
  ice: gather page_count()'s of each frag right before XDP prog call
  ice: stop storing XDP verdict within ice_rx_buf

 drivers/net/ethernet/intel/ice/ice_txrx.c     | 128 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  43 ------
 3 files changed, 82 insertions(+), 90 deletions(-)

-- 
2.43.0


