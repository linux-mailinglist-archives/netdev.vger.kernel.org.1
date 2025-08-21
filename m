Return-Path: <netdev+bounces-215742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFDB301A3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968E51CE391D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE954343D87;
	Thu, 21 Aug 2025 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miU/VqSs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287D343D7B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799287; cv=none; b=QfHy5WgDxMYNELauygmTDLqreaN2rd9Ls05IhQIzf4ppk2+7DdwNwnUUr/IczdQ7OPLOIFDK6u5jB5WEU5UbOEJPcfX3c+RNR6GNdDG2gI5DCh3Xor88ahpZTLY/a5rwoOSQhqL4y8LKV4hC2RKrExDajRrRNZ9NfPNW4PDiMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799287; c=relaxed/simple;
	bh=X7jZzgiCAXfnNE/RIiJo1Tb7kRUZgkjfRALBH3KgU6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuaqKOydsraEGGHGhnXrlzUr6CrMGZ7nIxAGwIHntLUSD3ON9nOzfO3q/SQpoJgM+0uMZswBZ4vY3wa01CKAFMiv0km87XZO8ZOhFJFAoNgx/TBfFNe2VsJInvhCiaXS3syx3SBChPhTNVpWHNWpURdBTSl58mqgp9UTmdwTllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miU/VqSs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755799286; x=1787335286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X7jZzgiCAXfnNE/RIiJo1Tb7kRUZgkjfRALBH3KgU6Y=;
  b=miU/VqSsn+P8Mb1FcELI7tDwMvnm2xNGFsgiORtaSTj0AzRFfLfgAPWg
   0cDcUTeLB/aCvk8SyI3mqUqmpxCYhR66ApiiXzjMRDmMguVKkFVlItj6u
   kxZciUYgLBDUhODbCAsHmnerfQE/gr70cf+8lvL9tuAcuWEAiU2sc/Wfz
   JSaQE9LfT5hC4tQXecPnLp+TQOdIYBTzqspJBTawVSYzKhlgSUh0zOlfu
   k16jUEB+/ZnAxlIGZoqYa8g+fRWvqekwPBfOiFPNZExJNZsdq3cW3214s
   2InyUj6PCXtXt6CZLQzL+AA/kRh++7BqZ9xd2OS4JEv4hNT9iWTSeTr5+
   A==;
X-CSE-ConnectionGUID: z+5YGdCYSvKR8SAAEPgS6A==
X-CSE-MsgGUID: rrju1Nx6Q26V1OjOv/zlMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60727066"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60727066"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 11:01:10 -0700
X-CSE-ConnectionGUID: 8IN2v8eBRUy12+Ic3wah0w==
X-CSE-MsgGUID: rSM3N2o+ScKP4rEZC02wlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172738221"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2025 11:01:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	joshua.a.hay@intel.com,
	lrizzo@google.com,
	brianvv@google.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Subject: [PATCH net 0/6][pull request] idpf: replace Tx flow scheduling buffer ring with buffer pool
Date: Thu, 21 Aug 2025 11:00:53 -0700
Message-ID: <20250821180100.401955-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joshua Hay says:

This series fixes a stability issue in the flow scheduling Tx send/clean
path that results in a Tx timeout.

The existing guardrails in the Tx path were not sufficient to prevent
the driver from reusing completion tags that were still in flight (held
by the HW).  This collision would cause the driver to erroneously clean
the wrong packet thus leaving the descriptor ring in a bad state.

The main point of this fix is to replace the flow scheduling buffer ring
with a large pool/array of buffers.  The completion tag then simply is
the index into this array.  The driver tracks the free tags and pulls
the next free one from a refillq.  The cleaning routines simply use the
completion tag from the completion descriptor to index into the array to
quickly find the buffers to clean.

All of the code to support this is added first to ensure traffic still
passes with each patch.  The final patch then removes all of the
obsolete stashing code.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250725184223.4084821-1-joshua.a.hay@intel.com/

The following are changes since commit 1b78236a059310db58c22fe92ddd11dbf0552266:
  Merge branch 'mlx5-misx-fixes-2025-08-20'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Joshua Hay (6):
  idpf: add support for Tx refillqs in flow scheduling mode
  idpf: improve when to set RE bit logic
  idpf: simplify and fix splitq Tx packet rollback error path
  idpf: replace flow scheduling buffer ring with buffer pool
  idpf: stop Tx if there are insufficient buffer resources
  idpf: remove obsolete stashing code

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  61 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 723 +++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  87 +--
 3 files changed, 356 insertions(+), 515 deletions(-)

-- 
2.47.1


