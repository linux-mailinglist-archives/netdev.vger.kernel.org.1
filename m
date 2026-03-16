Return-Path: <netdev+bounces-268230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEdbKflCuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:50:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F329E891
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B40303E757
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188181A23B9;
	Mon, 16 Mar 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRdwMTty"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077E27FB18;
	Mon, 16 Mar 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683194; cv=none; b=TPnUKVm51uIpL2biS/JM3HidEC75FzI8SVh74Agh05Rlh+Yvkh4/6ev4wk8be2RE/iM0hcUcQ+iKNmJ+fPG0U2F3wDuFJPrBjUK9J372AIO2ffCieQD8Rol1GjxmsgGPiMZBXXHJFV9ArGmDXZdqlAPD6l0713mxLGDdosPSgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683194; c=relaxed/simple;
	bh=HHt+7md6Fx6rdlb3tQPC+6q5XywRUOaIfdskyM4PRVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=InoxnIM0irCbWHczQ5L6RK8T7Rzy1aRtzpNz7ZReKR4DC5oHSHtmvrV/L4RHaHx1eiFWGVF8ilveXm6D8kDPN5wXZE7Gr0SvQApoJ/+puNDw+AJGI5LaOIYJ69f3NEYeH1omSj0Q06bWZXctj+7VQTaL9DMCbv3OmArxHUdhjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRdwMTty; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683192; x=1805219192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HHt+7md6Fx6rdlb3tQPC+6q5XywRUOaIfdskyM4PRVw=;
  b=bRdwMTtyaCINPEt62qUDOsKdpaT2Rljn3FqU6vrp4GJTg046aZ6o7J0v
   gJQc5jCPQQO+7EGbQymuW9DWYtuKFBiiUpTDaLh0yAKbVF59Kze2BIxpc
   jNkCEMCIITcnoAVuynmfTH9Ck2flk7CW1uCHjsp5Vx/hK96m9bcKKgMLS
   49WNKSDPROwDQ0G+wDrkk8kgjMhSTTM2uMi64RCHIUSueLuS3bepRpHh7
   3Crc5BC/wFOJ3mhh/Jp4NtmdFi0W2oH+pbmlpyvv5U0nwHgD2UpFlj5Un
   HQvuE6JkJh5xdHjaFo9YKhUnwgwJXRQYMgEFqlIxOFG0hkrwvfqx+8ktB
   g==;
X-CSE-ConnectionGUID: X43xwaevRSSIKVLOVudvGQ==
X-CSE-MsgGUID: 5iqjol4RQSOp+FkrOc5TIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62275686"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62275686"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:46:31 -0700
X-CSE-ConnectionGUID: cPkcxFLeQqaFq/X38Kre1A==
X-CSE-MsgGUID: 7qBWk4UtR2uiAx6p4r1V0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222075698"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 10:46:28 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 0/6] xsk: tailroom reservation and MTU validation
Date: Mon, 16 Mar 2026 18:45:44 +0100
Message-Id: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268230-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:url]
X-Rspamd-Queue-Id: 227F329E891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

here we fix a long-standing issue regarding multi-buffer scenario in ZC
mode - we have not been providing space at the end of the buffer where
multi-buffer XDP works on skb_shared_info. This has been brought to our
attention via [0].

Unaligned mode does not get any specific treatment, it is user's
responsibility to properly handle XSK addresses in queues.

With two adjustments included here in this set against xskxceiver I have
been able to pass the full test suite on ice.

Thanks,
Maciej

[0]: https://community.intel.com/t5/Ethernet-Products/X710-XDP-Packet-Corruption-Issue-DRV-MODE-Zero-Copy-Multi-Buffer/m-p/1724208


Maciej Fijalkowski (6):
  xsk: respect tailroom for ZC setups
  ice: do not round up result of dbuff calculation for xsk pool
  i40e: do not round up result of dbuff calculation for xsk pool
  xsk: validate MTU against usable frame size on bind
  selftests: bpf: fix pkt grow tests
  selftests: bpf: have a separate variable for drop test

 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 ++++---
 drivers/net/ethernet/intel/ice/ice_base.c     | 10 +++++++--
 include/net/xdp_sock_drv.h                    | 21 ++++++++++++++++++-
 net/xdp/xsk_buff_pool.c                       | 16 +++++++++++---
 .../selftests/bpf/prog_tests/test_xsk.c       | 21 ++++++++++++++++---
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  3 ++-
 6 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.43.0


