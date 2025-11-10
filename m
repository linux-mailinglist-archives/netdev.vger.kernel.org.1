Return-Path: <netdev+bounces-237290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98903C48807
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585503AC93A
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A71A325734;
	Mon, 10 Nov 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMwIrbra"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B63254B0
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798523; cv=none; b=lC/FT0W/B/4bnsePrxLGsLPmiHerql4FxNFVC8JktSK9ig5nDAnelqdUcNgDb3pLo+OyHaQBv2PhMQDh66eL32E0XrYD0/PKA87fAD890wWuHioR8130mXgGYQfPRT1W4jGXgkuIok8e+W0HDURbUSMTsyrA+LmrJFuTQBsmEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798523; c=relaxed/simple;
	bh=Ei+dXbQkQZkM/XAmXN7PEMQ5Pe0gq7Nnvq8DCvj0OFg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QbqElY2Pngfri7SSm5Zy+pv4lGXJXz6DsNVeaw+rYGhDqyNYHcVBRAvkoWmfYbypfllPBj/bsUDk7ph4TyEI4/nEvaFXXNNMrWqFEGjJ7PC8h/lcWrb+aioq4G7focxe+5pN7FVOlF40O9KRyLzNlHmbJZvLz8QjZHt6oT0zJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMwIrbra; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762798521; x=1794334521;
  h=from:to:cc:subject:date:message-id;
  bh=Ei+dXbQkQZkM/XAmXN7PEMQ5Pe0gq7Nnvq8DCvj0OFg=;
  b=NMwIrbrafTrYa7x3O+IpbtLZaIsMuCVdA6URybCyA7OI7O9pG1vrLEsx
   oO4gKF0U3l3FNV7RKGXwHOjUXqyLACGfYuLi0itDKrq7MIVaJl5Dem0Xy
   229fn/vjB/sc860NB1cGZpPjvuzr5VdnBCOmWDdNvjFnO4KLI+eOxmd/R
   jG6qomMUCTeVwq7LEKxQlPyqps7GUiPe8117oUrpbxscAIOfNnbFyIfEM
   Vsm46Tgr6Ndlm5iRj6biEsl39siojMNlhr4t3xdtReQNeTo+0ttZymF5+
   eZL94GlFnp12FzVvUOSgdq16TTvVZ8Zb03zPR8wVx4qmqHVYG2AlhRZww
   w==;
X-CSE-ConnectionGUID: uhrMTlHdRS2Ikb9SQ2uV7g==
X-CSE-MsgGUID: GYFotGTCQlCuSOHl6xIm5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="87485206"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="87485206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:15:20 -0800
X-CSE-ConnectionGUID: tw9YI+ROTjqr1pSyETJvAg==
X-CSE-MsgGUID: P0ukl+KcQqynqAwoQ4zjaw==
X-ExtLoop1: 1
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2025 10:15:19 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net 0/4] idpf: fix issues in the reset handling path
Date: Mon, 10 Nov 2025 10:08:19 -0800
Message-Id: <20251110180823.18008-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Resolve multiple issues in the error path of reset handling of the IDPF
driver:
- Mailbox timeouts in the init task during a reset lead to the netdevs
  being unregistered.
- Reset times out and leaves the netdevs exposed to callbacks with the
  vport resources already freed.
- Simultaneous reset and soft reset calls will result in the loss of the
  vport state, leaving the netdev in DOWN state.
- Memory leak in idpf_vport_rel() where vport->rx_ptype_lkup was not
  freed during a reset.
- Memory leak in idpf_vc_core_deinit(), where kfree() was missing for
  hw->lan_regs.

Emil Tantilov (4):
  idpf: keep the netdev when a reset fails
  idpf: detach and close netdevs while handling a reset
  idpf: fix memory leak in idpf_vport_rel()
  idpf: fix memory leak in idpf_vc_core_deinit()

 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 139 ++++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   4 +
 2 files changed, 83 insertions(+), 60 deletions(-)

-- 
2.37.3


