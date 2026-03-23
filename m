Return-Path: <netdev+bounces-270689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HlUFgOUwWnuTwQAu9opvQ
	(envelope-from <netdev+bounces-270689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:26:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4022FC36A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A19A130182AA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F035B63C;
	Mon, 23 Mar 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzGbp5Wf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171617A2FC;
	Mon, 23 Mar 2026 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293912; cv=none; b=ZPE9LcGDr54Pm3LhgIFfXdmSbjAUTnGwD1L0OV4O+wWqoGNqJms+6Xrxxyx2v/fa+gnH4DV0kW5yHv2m5/3g6idiRI7Wijd9xcvFb5Gr4VgHpJLEmjRzYKq5Dt0CTu+GRcQ0ZeHH+k5NwJmMUZJQw3ykCfEO57vDuY1R9Tj2LLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293912; c=relaxed/simple;
	bh=fYoFOC4iFo/HEGkk4RjExLhAphUZF4h7JJzt6fyyd9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lKVy0JA1sbtaWz8sO0n8DMlH4alM5ttA84HTHePxm+XQFT6LBTZIe3p//WCx7mxx5p+BDY4OTYpBFHnealDJ+BxQLS/nlQGEk0iVYxXScyd4gF5p8HqQzjE9jlE8y2ZoaiNaKssUXFT46XMZ2H2yY/pjnGP5m3fBYvql1Odq1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzGbp5Wf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774293910; x=1805829910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fYoFOC4iFo/HEGkk4RjExLhAphUZF4h7JJzt6fyyd9A=;
  b=IzGbp5WfnfY+YEX5dBchcfLV1CpRklm5qzkbzwqClvOkGdIR0vFiGCJv
   gEmJrURM2pdemczonYqiaSU7b4HYLVI8u0OPD+y9y9+ay5Ryc52XlaIn5
   UjigahMAck3Zy31FQScopyfRSv4ilVh8RYCbk6xxc4Xs8s0r7w4vZeoZj
   JfNzHQEXcs3wqP/xfftYPIg+lAZN2xzRVM1AGZPo9dGKj9IY1SqvYGXdW
   PTCKHmLyrjKfo/UUUu+laKXW2fG4X+GTMhfSeFXB+3w7zgG7o2uQ1alfE
   oJhq+/AJvDVkQg/Y0ak2hKB1QctbIH5nxyopEhObm7xA0dSpBe8rvzvYJ
   A==;
X-CSE-ConnectionGUID: p54DRIftQ9mo6id4gyWMsQ==
X-CSE-MsgGUID: 3lzsLP/wTe6HJ0NxRTD/6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75013298"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75013298"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 12:25:10 -0700
X-CSE-ConnectionGUID: Elgxh4dCSjWTNHfjIIRJaQ==
X-CSE-MsgGUID: hQBqPiMQRMaWHLqGH2lQhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228187860"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 12:25:07 -0700
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
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 0/8] xsk: tailroom reservation and MTU validation
Date: Mon, 23 Mar 2026 20:24:49 +0100
Message-Id: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270689-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA4022FC36A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2->v3:
- add tags from Bjorn/Stan
- provide at least 128 bytes instead ETH_ZLEN when validating frame
  headroom
  * this way we can get rid of i40e/ice changes
  * make sure xsk_pool_get_rx_frame_size() returns value 128b-aligned
  * and remove pre-check from idpf
- separate XDP_UMEM_SG_FLAG fixes from MTU validation in xsk_bind()
- make drop_idx a local variable in xsk's xdp drop prog
- adjust rx_dropped to new 128b related values
- move ugly placed define (Bjorn)
- remove READ_ONCE when fetching netdev->mtu (Bjorn)

v1->v2:
- remove xsk_pool_get_tailroom() definition for !CONFIG_XDP_SOCKETS
  (Stan)
- do not rely on pool->umem->zc when configuring tailroom (Stan, Bjorn)
- simplify dbuff setting in ZC drivers (Bjorn)
- use defines for {head,tail}room in tests (Bjorn)
- return EINVAL instead of EOPNOTSUPP when mtu setting is wrong (Bjorn)
- include vlan headers and fcs length when validating mtu (Olek)
- tighten umem headroom validation when registering umem (Sashiko AI)
- set XDP_USE_SG in xp_assign_dev_shared() (Sashiko AI)
- adjust rx dropped xskxceiver test

Hi,

here we fix a long-standing issue regarding multi-buffer scenario in ZC
mode - we have not been providing space at the end of the buffer where
multi-buffer XDP works on skb_shared_info. This has been brought to our
attention via [0].

Unaligned mode does not get any specific treatment, it is user's
responsibility to properly handle XSK addresses in queues.

With adjustments included here in this set against xskxceiver I have
been able to pass the full test suite on ice.

Thanks,
Maciej

[0]: https://community.intel.com/t5/Ethernet-Products/X710-XDP-Packet-Corruption-Issue-DRV-MODE-Zero-Copy-Multi-Buffer/m-p/1724208


Maciej Fijalkowski (8):
  xsk: tighten UMEM headroom validation to account for tailroom and min
    frame
  xsk: respect tailroom for ZC setups
  xsk: fix XDP_UMEM_SG_FLAG issues
  xsk: validate MTU against usable frame size on bind
  selftests: bpf: fix pkt grow tests
  selftests: bpf: have a separate variable for drop test
  selftests: bpf: adjust rx_dropped xskxceiver's test to respect
    tailroom
  idpf: remove xsk frame size check against alignment

 drivers/net/ethernet/intel/idpf/xsk.c         | 10 -------
 include/net/xdp_sock.h                        |  2 +-
 include/net/xdp_sock_drv.h                    | 17 ++++++++++-
 net/xdp/xdp_umem.c                            |  3 +-
 net/xdp/xsk_buff_pool.c                       | 18 ++++++++++--
 .../selftests/bpf/prog_tests/test_xsk.c       | 29 +++++++++++++++----
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  4 ++-
 7 files changed, 62 insertions(+), 21 deletions(-)

-- 
2.43.0


