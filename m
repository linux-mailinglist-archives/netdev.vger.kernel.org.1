Return-Path: <netdev+bounces-116625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA894B36D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328B3282D28
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB7155352;
	Wed,  7 Aug 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R27r+0X9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5E155333
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072415; cv=none; b=uLUSS0gHNj9TkUGbMRhvZUB3s4f2cfda6AvXQsjLF3Tb+Y/leRhzLkkC9dEiSVhnFfhVRh9Tzyg0A9p5LMXF5fDJnI0nrCT7h4gF9xGV/Q4AyWVRDUOHpZisXEfrOv8EQGflll5e1EyiLmnWo2CbaPU7PKkADoXWN8WaWcx7GRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072415; c=relaxed/simple;
	bh=HhnzU76tuaB06hf9r/QBxA0q6YiilDErfM57/qL/dM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYwpM5Yl+bLKoC3yFCWNaHx6WQZ6cztUcrMhA0HXWk6KVZZ3L/D0TFIp/KqFoFnLUlmTsQEg7NtTLG4aWLPkTtwhFfZIWQtWrNOz6RvZYZ8gmKaYLxv7iGH6Zk2lzoaxcGeDKYIKhva+pczY8Os+A3/my26vjReqpEBXKhwFdbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R27r+0X9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072414; x=1754608414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HhnzU76tuaB06hf9r/QBxA0q6YiilDErfM57/qL/dM4=;
  b=R27r+0X96eGXLFinqXt5J2OWtYJRymZ4Zv0sHqmUSNpxPJuR9T9o7oxf
   sgyjxB8MWkkpOEa8VCUb5A/TJS8SkojjZqChRm9067z4xRpBmukEls76v
   C7nfTFsdx0UPIvrG2tlO/KWgu17Snxzf/KZMAJaqLNe48+77Vk5JxRA7R
   8mFm3q6lW8mLU9BHFiWgueinfs0kjuyQvTiYts6hhkNL2Hy/ACUp5EibH
   5PHBWNS/HziYmp6s1ZEHfhWmTvv2P/mJEYCP0WPkajRXczbh7p0hmZBys
   +xCblgBeDA4afNDsDR7KtBoXbQyQ/hHNTJtE0d1rOoBTK2o7Kc2exJx8n
   w==;
X-CSE-ConnectionGUID: FuZNPfEgRi+R/dtz7/JJ+g==
X-CSE-MsgGUID: ndu7Q0PjTDW0U5Xn51hmYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577300"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577300"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:13:34 -0700
X-CSE-ConnectionGUID: 7H53JrMaRhqv3TNSuhpKew==
X-CSE-MsgGUID: Gv2GO4YMTXi04b58Gh5bnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61956617"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 16:13:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	faizal.abdul.rahim@linux.intel.com,
	vinicius.gomes@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-08-07 (igc)
Date: Wed,  7 Aug 2024 16:13:24 -0700
Message-ID: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to igc driver only.

Faizal adjusts the size of the MAC internal buffer on i226 devices to
resolve an errata for leaking packet transmits. He also corrects a
condition in which qbv_config_change_errors are incorrectly counted.
Lastly, he adjusts the conditions for resetting the adapter when
changing TSN Tx mode and corrects the conditions in which gtxoffset
register is set.

The following are changes since commit 1ca645a2f74a4290527ae27130c8611391b07dbf:
  net: usb: qmi_wwan: add MeiG Smart SRM825L
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Faizal Rahim (4):
  igc: Fix packet still tx after gate close by reducing i226 MAC retry
    buffer
  igc: Fix qbv_config_change_errors logics
  igc: Fix reset adapter logics when tx mode change
  igc: Fix qbv tx latency by setting gtxoffset

 drivers/net/ethernet/intel/igc/igc_defines.h |  6 ++
 drivers/net/ethernet/intel/igc/igc_main.c    |  8 ++-
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 76 ++++++++++++++++----
 drivers/net/ethernet/intel/igc/igc_tsn.h     |  1 +
 4 files changed, 75 insertions(+), 16 deletions(-)

-- 
2.42.0


