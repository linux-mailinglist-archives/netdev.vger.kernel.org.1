Return-Path: <netdev+bounces-88812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317D18A896D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633211C22F9C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658F17106C;
	Wed, 17 Apr 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3jiPdgn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802D16FF55
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373001; cv=none; b=exJ0aIgHRmPc0/kgxmnODawr60Pmc7kb/EN5rRzJzL26gvDuukz4wCqk1sg/ibZcc31ph+Pdk/GTAU9xLQAGd2P2xtpbomnjHtxFaG5xggBm9q6b+oIkxeVpLCGqLiefx1tBc2jHpiFwdfBrWU/qPI/mu0frLuO5fmgIvVOA+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373001; c=relaxed/simple;
	bh=fsH77JVhra1veGF0yWBwSsr1qgecnQ7NkeFTut+VIHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5piC+64ytuybxXJCeNV0/a42f46m5B4x/BQmf0IN5Ot98gCYupf56RKDOwWLoXhYHjsfu3O8xaCdWWtomQxHahLpiBTg9OqCEREe8x6welke40fwYkJHx7p2A4SvRXI546NbSZPcC0SrBdokpzLjDl6vazplfUlM/Dmt4R4ToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3jiPdgn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373000; x=1744909000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fsH77JVhra1veGF0yWBwSsr1qgecnQ7NkeFTut+VIHU=;
  b=b3jiPdgng316xSDEYqznH6qqULJ1bBVmmbJb1NehpWexjDTeJZKA8Nfr
   pbxYw8dLE64JnyHFNlWCzh1a86ysb/H9n+5Xx3PcCQlxE46gReylRKrGn
   P+DFQo9DraV33sWYS2pwM5jPNSZb8itl946/Dv7eVctsBHDMCxjC77N8I
   E17//8KjEgg84Eb2m9I+D2U+1CJxRefGYbHgY2xOaDJ+XSfU8WvCGjNLY
   Z6HBGt4ySzysjh5MBBa0mWn5SChYLUb+uPitA5p4t5qo/8UeFnopxYrte
   hl0CXfXBY9GnDU/G+ppsB3TALNUSo32TeM4/i7Ehr8pCA/uL20j0mtY1Z
   Q==;
X-CSE-ConnectionGUID: FdRmFF8VT3i+J09DWdNdeA==
X-CSE-MsgGUID: PeRz6OykTFar4Nn0VDZNAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9047281"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9047281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:56:39 -0700
X-CSE-ConnectionGUID: B0YXQpjeTb+ONzEL8UBM0Q==
X-CSE-MsgGUID: MqW68NYATJyuCIHmEylaKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27257610"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 17 Apr 2024 09:56:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/2][pull request] Intel Wired LAN Driver Updates 2024-04-17 (ice)
Date: Wed, 17 Apr 2024 09:56:31 -0700
Message-ID: <20240417165634.2081793-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Marcin adds Tx malicious driver detection (MDD) events to be included as
part of mdd-auto-reset-vf.

Dariusz removes unnecessary implementation of ndo_get_phys_port_name.

The following are changes since commit 2bd99aef1b19e6da09eff692bc0a09d61d785782:
  tcp: accept bare FIN packets under memory pressure
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Dariusz Aftanski (1):
  ice: Remove ndo_get_phys_port_name

Marcin Szycik (1):
  ice: Add automatic VF reset on Tx MDD events

 drivers/net/ethernet/intel/ice/ice_main.c  | 57 +++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_repr.c  | 34 -------------
 drivers/net/ethernet/intel/ice/ice_sriov.c | 25 +++++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h |  2 +
 4 files changed, 67 insertions(+), 51 deletions(-)

-- 
2.41.0


