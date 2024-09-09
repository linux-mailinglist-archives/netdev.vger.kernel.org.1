Return-Path: <netdev+bounces-126702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72609723F8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EDA1C21AD3
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A918A933;
	Mon,  9 Sep 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3xQpVwx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13917D34D
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915214; cv=none; b=Ctl0qfOyfglbJyJQBhrSNPT09fnnZK9ZfLCnjUDvwyts1zNpL0GQmHKa626Rn2ln1jbKaeaREJzph4o3cHok+hQSkJAEXea2uhmGFm9noyBZXy3EVGJrXFP4sa7Asi/4aDpN2NuC2E+j0S6UoC63BHeVi54uL5IoNPzgsOKFjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915214; c=relaxed/simple;
	bh=6lcm68sDzr6GzgLygcQJnyUuyavzxmCXSAQ8aAo6jN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=satDcED4ZImamYF+hIKJXKZEdERVygctif0AXKeSHHhr5QtL4/U8D7MYYXNwFyo4o0Jfs4KUbYATVFIlydeFwHLytLU8fUELFwdM3TdxEDc7dtnWhv929rQO9Nvj0YeC3VagjkQ0zpHoSze0wtD7dkTLb+uyy3IYvVcMQE/9fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3xQpVwx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725915212; x=1757451212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6lcm68sDzr6GzgLygcQJnyUuyavzxmCXSAQ8aAo6jN8=;
  b=b3xQpVwx8WW0oIrjds3/QVs/ka7YbGGFlRpgf+u4wK0QR/P3+p/JvO28
   ihWJPXHC1go7gwAM9TkMr8oWEEV1y3Gskd6NmGRRq3jOmRGN0a0nB4kjh
   XBPEx4aN909htG7Cib7UEYuuizmSNpjLKBTZabdBBBzt8qDMUy41J+ZNK
   F4oRExGqh6faC13gDzNc1atyHNT9AhpBirjwoLXMmD732pUTu1UNnu/HO
   fmXnU3sxIuhtraKCdBKvxuSKuPf5BE2L8g2bHHBsJjPwNWR/vGZt6OO/O
   rbYwiLWUgQUyws1uxKr4VmTsKUR+VajwonXHHPPrCgzmYRIAV9ki+KOtw
   A==;
X-CSE-ConnectionGUID: s/mJ6ItyTdiaWF0Tj5ZX6w==
X-CSE-MsgGUID: +qrSNMZUSZOtbK5y3G45rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="42151236"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="42151236"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:53:32 -0700
X-CSE-ConnectionGUID: pCNiPaKsQhmsbUT65kWvlg==
X-CSE-MsgGUID: rVZrYVeEQVqwsIaj1csAVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71194486"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Sep 2024 13:53:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	michal.kubiak@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	willemb@google.com
Subject: [PATCH net-next v3 0/6][pull request] idpf: XDP chapter II: convert Tx completion to libeth
Date: Mon,  9 Sep 2024 13:53:15 -0700
Message-ID: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

XDP for idpf is currently 5 chapters:
* convert Rx to libeth;
* convert Tx completion to libeth (this);
* generic XDP and XSk code changes;
* actual XDP for idpf via libeth_xdp;
* XSk for idpf (^).

Part II does the following:
* adds generic libeth Tx completion routines;
* converts idpf to use generic libeth Tx comp routines;
* fixes Tx queue timeouts and robustifies Tx completion in general;
* fixes Tx event/descriptor flushes (writebacks).

Most idpf patches again remove more lines than adds.
Generic Tx completion helpers and structs are needed as libeth_xdp
(Ch. III) makes use of them. WB_ON_ITR is needed since XDPSQs don't
want to work without it at all. Tx queue timeouts fixes are needed
since without them, it's way easier to catch a Tx timeout event when
WB_ON_ITR is enabled.
---
v3:
- drop the stats implementation. It's not generic, uses old Ethtool
  interfaces and is written using macro templates which made it barely
  readable (Kuba).
- replace `/* <multi-line comment>` with `/*\n * <multi-line comment>`
  since the special rule for netdev was removed.

v2: https://lore.kernel.org/netdev/20240819223442.48013-1-anthony.l.nguyen@intel.com
- Rebased

v1: https://lore.kernel.org/netdev/20240814173309.4166149-1-anthony.l.nguyen@intel.com/

iwl: https://lore.kernel.org/intel-wired-lan/20240904154748.2114199-1-aleksander.lobakin@intel.com/

This series contains updates to

The following are changes since commit bfba7bc8b7c2c100b76edb3a646fdce256392129:
  Merge branch 'unmask-dscp-part-four'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (3):
  libeth: add Tx buffer completion helpers
  idpf: convert to libeth Tx buffer completion
  netdevice: add netdev_tx_reset_subqueue() shorthand

Joshua Hay (2):
  idpf: refactor Tx completion routines
  idpf: enable WB_ON_ITR

Michal Kubiak (1):
  idpf: fix netdev Tx queue stop/wake

 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   2 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 110 +++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 395 ++++++++----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  92 ++--
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   2 +
 include/linux/netdevice.h                     |  13 +-
 include/net/libeth/tx.h                       | 129 ++++++
 include/net/libeth/types.h                    |  25 ++
 8 files changed, 442 insertions(+), 326 deletions(-)
 create mode 100644 include/net/libeth/tx.h
 create mode 100644 include/net/libeth/types.h

-- 
2.42.0


