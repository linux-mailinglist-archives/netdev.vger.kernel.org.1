Return-Path: <netdev+bounces-186870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BCAA3B09
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481574C4D4C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7426988C;
	Tue, 29 Apr 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbkcpsmW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350152459E7
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964640; cv=none; b=V9zFsSd+F7hDzM5zyawFLsXEn/nSnAiSIQCz2bA6DqhbHd9Uj16AKs4N0jziA/S6dD7FzBtKafxzonqtTMc+RCnoNcBU6VVuzgC6m4omx0e1Xys91psKciqa8SxSigPcYKqKR57+65UmgNJbnDpikElKK6Hi+D+eHI3g0L6RhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964640; c=relaxed/simple;
	bh=1fjod31MygIbrzpd7VRoLGTI62t/BR6FAKZrwmib4Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFdGIgf9/a+5tCap/IZveQA7eXW4QIYIRUPR1UlLk4FxXfpwllvrqG0KxEsrFpq7RPWJ3osQIokW50f1gk8hQxBisaXetzJrej0nWnsUYk5fBVOCRc3US5j6scvlN8Q0+gbdFC1yLh2FlfNo1JeR+ETCtiUOOVOLOgwOQdFnQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbkcpsmW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745964638; x=1777500638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1fjod31MygIbrzpd7VRoLGTI62t/BR6FAKZrwmib4Kg=;
  b=bbkcpsmWSwT8IuOTFD7f9qiqrpbytL+2xOW9RM/Pls6V0n08rwE2w59R
   DpRv+eDngP/diRU8qv2vqsvq/PcqzF1PD9y0bS/nbhqYVJczQIJP3PvlE
   WHtyyiZ/Hd+7gKVfnfgDZYBHdqOR6RZ2XTHmrCq3W7XECMRZHxVueJmmL
   v9DnVy2pCJGp23j0y7iFftyfSP0NM8+Ha7qptseTnvENnkTV1LXXDcohT
   HUXFmPjtW6Oiofgs/OwS859IR8D1ouO33ZShcngYbMhCVkBLSQqBkJ3My
   UNS2d303GDapQk+o0Tb9EvmP17lw7habSwUu62L24Rx4wW4IU9o4yvQUd
   g==;
X-CSE-ConnectionGUID: gIFDJxqLSWy6SrYQG8z/pQ==
X-CSE-MsgGUID: MLfhgxTuRImfq+ES104/VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47620115"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47620115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 15:10:37 -0700
X-CSE-ConnectionGUID: DcD3ZXKaQdCGdcYTJDy0ng==
X-CSE-MsgGUID: gMVF4ybXSq2/u0ogw/FSNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="138750754"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2025 15:10:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2025-04-29 (idpf, igc)
Date: Tue, 29 Apr 2025 15:10:30 -0700
Message-ID: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For idpf:
Michal fixes error path handling to remove memory leak.

Larysa prevents reset from being called during shutdown.

For igc:
Jake adjusts locking order to resolve sleeping in atomic context.

The following are changes since commit d4cb1ecc22908ef46f2885ee2978a4f22e90f365:
  Merge branch 'intel-net-queue-100GbE'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Jacob Keller (1):
  igc: fix lock order in igc_ptp_reset

Larysa Zaremba (1):
  idpf: protect shutdown from reset

Michal Swiatkowski (1):
  idpf: fix potential memory leak on kcalloc() failure

 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 19 +++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_main.c |  1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c    |  6 ++++--
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.47.1


