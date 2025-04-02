Return-Path: <netdev+bounces-178869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D132CA793E2
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7441894F13
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909D1A3156;
	Wed,  2 Apr 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlmO88Ft"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620B73176
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615551; cv=none; b=Ft7xr33MCL9b/Y9j0Ec7ipIjslcogN0SR1P6+omrIdN5PmXTVPyusQDf+zIuduUndMFc/ebp4ZAoUCMYYFq74ait7vPszKj5/jzrrw6Mc1+HYWQlTdxAXPFOnjHjZPXXDKWcMiofg1c1gcwoTr0CHX/vQ16AnEfPYleg4l3kXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615551; c=relaxed/simple;
	bh=iG7BDsB8D8gZm4+87JocWWJ3hcZsOhNVDNRr95gArzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuIXRsPtWZ62whGA5mSOzIbHpRhsOAs2HJzheXE9BPF3Go3NKTPTT5aKPdq8zieXBig8HLnDDjBoj9EPH/tNZ6bwM5TfOzQ6rYPihg/E3mbmBSIvcfWsmtyF1vRJ3A21I5XiM/zjS6xGCK8SHy63maDhEX0N4EotDra22ahKBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlmO88Ft; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743615549; x=1775151549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iG7BDsB8D8gZm4+87JocWWJ3hcZsOhNVDNRr95gArzE=;
  b=ZlmO88Ft11jL7EA072HFtpAJse62JvqTEw1npXih6poGKp5ROTSNWjUA
   sJmJpfk+C5lKDJ62lPOsdsGrCnYtsT4EZ3819c9Rfwu0vJ6e518oLK8Lp
   J42gjF3/dqkAZpobKMZUIiVnBd9fDXQx+dKlGc7HSsSvZFoSRS0cWdkpB
   Xvy5z5IdsNU4I/10xvuDGjjQtJgkaZw1eNAV7zVQ3SHECvKwvLYsVshW8
   bKilzW5KL9SM0BVzWbyHZhzWHx8PLsntermrG0U20eSkPM7UszcqUTWk2
   H2SYh+0ylwGMk1Zs7wUV5vBQJNdnbas/15AfW+wMimpo5FnpcuvDaf0xX
   w==;
X-CSE-ConnectionGUID: 7Me53r8TQXGGuYV7i/1lCg==
X-CSE-MsgGUID: VCWhYdZkTF+WWVoBK/3QvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44257251"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44257251"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:39:08 -0700
X-CSE-ConnectionGUID: MBRb/lG4S1q0c7CA25KxxQ==
X-CSE-MsgGUID: sjLSY+Q0RhulOFQu1djISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149968762"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2025 10:39:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2025-04-02 (igc, e1000e, ixgbe, idpf)
Date: Wed,  2 Apr 2025 10:38:52 -0700
Message-ID: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For igc:
Joe Damato removes unmapping of XSK queues from NAPI instance.

Zdenek Bouska swaps condition checks/call to prevent AF_XDP Tx drops
with low budget value.

For e1000e:
Vitaly adjusts Kumeran interface configuration to prevent MDI errors.

For ixgbe:
Piotr clears PHY high values on media type detection to ensure stale
values are not used.

For idpf:
Emil adjusts shutdown calls to prevent NULL pointer dereference.

The following are changes since commit acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1:
  Merge tag 'net-6.15-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Emil Tantilov (1):
  idpf: fix adapter NULL pointer dereference on reboot

Joe Damato (1):
  igc: Fix XSK queue NAPI ID mapping

Piotr Kwapulinski (1):
  ixgbe: fix media type detection for E610 device

Vitaly Lifshits (1):
  e1000e: change k1 configuration on MTP and later platforms

Zdenek Bouska (1):
  igc: Fix TX drops in XDP ZC

 drivers/net/ethernet/intel/e1000e/defines.h   |  3 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c   | 80 +++++++++++++++++--
 drivers/net/ethernet/intel/e1000e/ich8lan.h   |  4 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  6 +-
 drivers/net/ethernet/intel/igc/igc.h          |  2 -
 drivers/net/ethernet/intel/igc/igc_main.c     |  6 +-
 drivers/net/ethernet/intel/igc/igc_xdp.c      |  2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  4 +-
 8 files changed, 93 insertions(+), 14 deletions(-)

-- 
2.47.1


