Return-Path: <netdev+bounces-307480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oRrOOEpFVmpn2gAAu9opvQ
	(envelope-from <netdev+bounces-307480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:18:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17B755B2A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:18:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XWPrp0QO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307480-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 970A6309C04C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB48480DFF;
	Tue, 14 Jul 2026 14:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D747D952;
	Tue, 14 Jul 2026 14:08:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038105; cv=none; b=PYrUsMkJ7POP+zIpDMYFpLFQAu406ETLxiMyMMVMO2Su+EU479e9Y0fEC9QIzd9m/wNICMSQE0yNxmdBVtnSDp2ws5aQI+AyDWpK8TowusP7LgbA7TYcDlf7aQxJ8a7CEbBfInwPPWAdT3EiDgK20C5iB/g4j2O782G+VDrv8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038105; c=relaxed/simple;
	bh=EyHLAJfFo0MzMeMvQQspVA6hvbymiP7lG7Y+Z7qv2Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EE5MWdnK3uJFdeNlH9M3UHg71Wsuaga4/Kclt0K+4cKJWRf8zerclivSJoIs6ND3N3gSyaR2JuY5l7wGgZvND/kkKbtvllKXtsFZEG/dEuL9YHrYrA6sBWGvcAqAfuVC7ZysJY3jNeXU5NPWqlzaSdhA2wNRr+9xji0bEsBDwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWPrp0QO; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784038101; x=1815574101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EyHLAJfFo0MzMeMvQQspVA6hvbymiP7lG7Y+Z7qv2Ac=;
  b=XWPrp0QOuFVoO7cJHp8Ppuv2pw0u4x2cEXpULEqnFRVDZuuPxmmxpOpt
   XCPlG30TvOj6Ui3kknLAFGrK+N8LJa7iWhgjsktRQDvJVKLMmBTs6TGQt
   YsyX4q2CqtyugWEruKSR1x788YTY+HwcExMI8w0UwpI4mWKLzdhFc4Z56
   m9HBKldHNaTId94FWO6pElvgHajRnSnpxGxdgLNqttAnQ64rgtXAGE44y
   X250m2L1npPiZyaJQ3xs5rMpxoOhcJEuOPEO0wnEUWqwOtlkYmUUFMk45
   OVIj6je5XRs3gZVmPMIsklGGvTKspFIJ4POqqsMyHlvVeWSZNqWlwWVck
   w==;
X-CSE-ConnectionGUID: h8vVohtBQL2f8T33O+XpAQ==
X-CSE-MsgGUID: tcF/Q0h2TraqPYkh9O44Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="110207002"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="110207002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:07:32 -0700
X-CSE-ConnectionGUID: m9zqryGvRNmFcRex+3QoUw==
X-CSE-MsgGUID: ORyR0VznQHmGoUdgR+Zu4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254120937"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa006.jf.intel.com with ESMTP; 14 Jul 2026 07:07:28 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
Date: Tue, 14 Jul 2026 16:07:16 +0200
Message-Id: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307480-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,intel.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D17B755B2A

v2: https://lore.kernel.org/netdev/20260710194424.84844-1-maciej.fijalkowski@intel.com/
v2->v3:

* Added a preceding patch that sizes the pool-wide temporary Tx descriptor
  array to the larger of the first Tx ring and the device's
  xdp_zc_max_segs capability. This guarantees that the shared-UMEM path can
  inspect one maximum-sized valid packet even when the socket that creates
  the pool has a smaller Tx ring. Consequently, this patch now records the
  actual allocated size in pool->tx_descs_nentries rather than the first
  socket's Tx ring size.

* Fixed a possible infinite retry loop when a shared-UMEM socket contains
  an incomplete multi-buffer packet. Pass the original descriptor budget
  to xskq_cons_read_desc_batch() instead of the number of descriptors
  currently available, so the parser can distinguish producer exhaustion
  from actual budget exhaustion.

* Moved the completion-ring space check to the common batched Tx path, so
  it is performed exactly once for both singular and shared-SG pools. Keep
  the legacy shared non-SG fallback outside this handling, as it reserves
  completion entries one descriptor at a time.

* Reworked xsk_tx_peek_release_desc_batch() to use a common singular/shared
  batched flow. Resolve an empty Tx socket list before checking CQ space,
  select the shared-SG walker through an explicit shared-pool condition,
  and commit the resulting batch through one common path.

* Simplified xsk_tx_commit_batch() by moving the cached CQ producer
  snapshot into the helper instead of passing it from each caller.

v1: https://lore.kernel.org/netdev/20260623133240.1048434-1-maciej.fijalkowski@intel.com/
v1->v2:

* Reduced the series from seven to five patches by squashing the three
  generic Tx drain and reclaim changes into a single patch. The resulting
  patch handles overflow, invalid descriptors in the middle of a packet,
  and reclaim of the offending descriptor as one coherent change. This
  so it will be less likely to have things reported by Sashiko that are
  fixed in later commits;

* Reworked the zero-copy implementation substantially:
  * removed the bind-transition mechanism, including tx_share_pending,
    xp_prepare_xsk_tx_share(), xp_finish_xsk_tx_share(),
    synchronize_net(), and the transient bind() -EAGAIN behavior;
  * added packet-framed parsing for shared-UMEM SG pools, allowing
    per-socket drain state to be resumed by both singular and shared Tx
    paths;
  * retained the legacy one-descriptor fallback for shared non-SG pools;
  * preserved the existing per-socket fairness quota while allowing the
    shared walker to consume multiple complete packets and continue
    filling the requested batch across fairness rounds;
  * made the fairness quota large enough to process one maximum-sized
    valid multi-buffer packet;
  * extended the parser result with consumed-descriptor and
    budget-limited accounting needed by the shared walker;
  * recorded the size of the pool's temporary Tx descriptor array and
    capped batch processing at that size;
  * kept reclaim-only descriptors ordered after preceding driver-visible
    descriptors and protected the delayed-reclaim state with
    READ_ONCE()/WRITE_ONCE().

* Rewrote the zero-copy patch description to cover oversized packets,
  continuation draining across calls, shared-UMEM SG handling, and CQ
  publication ordering.

* Corrected the too-many-frags selftest description to state that the
  invalid packet contains max_frags + 1 fragments and terminates at an
  explicit packet boundary.


Hi,

This series fixes several AF_XDP multi-buffer Tx paths where descriptors
consumed from the Tx ring are not consistently returned to userspace
through the completion ring when the packet is later dropped as invalid.

The affected cases are invalid or oversized multi-buffer Tx packets in
both the generic and zero-copy paths. In these cases, the kernel can
consume one or more Tx descriptors while building or validating a
multi-buffer packet, then drop the packet before it reaches the device.
Userspace still owns the UMEM buffers only after the corresponding
addresses are returned through the CQ. Missing completions therefore
make userspace lose track of those buffers.

The generic path fixes cover following related cases:
* partially built multi-buffer skbs dropped by xsk_drop_skb();
  continuation descriptors left in the Tx ring after xsk_build_skb()
  reports overflow;
* invalid descriptors encountered in the middle of a multi-buffer
  packet, including the offending invalid descriptor itself.

The zero-copy path is handled separately. The batched Tx parser now
distinguishes descriptors that can be passed to the driver from
descriptors that are consumed only because they belong to an invalid
multi-buffer packet. Reclaim-only descriptors are written to the CQ
address area and published in completion order, after any earlier
driver-visible Tx descriptors.

The last two patches update xskxceiver so the tests account invalid
multi-buffer Tx packets as descriptors that must be reclaimed, while
still not expecting those invalid packets on the Rx side.

This is a follow-up to Jason's changes [0] which were addressing generic
xmit only and this set allows me to pass full xskxceiver test suite run
against ice driver.

Thanks,
Maciej

[0]: https://lore.kernel.org/netdev/20260520004244.55663-1-kerneljasonxing@gmail.com/


Jason Xing (2):
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()

Maciej Fijalkowski (4):
  xsk: provide sufficient space in pool->tx_descs
  xsk: reclaim invalid multi-buffer Tx descs in ZC path
  selftests/xsk: fix too-many-frags multi-buffer Tx test
  selftests/xsk: account invalid multi-buffer Tx descriptors

 include/net/xdp_sock.h                        |   1 +
 include/net/xsk_buff_pool.h                   |   9 +-
 net/xdp/xsk.c                                 | 254 ++++++++++++++++--
 net/xdp/xsk_buff_pool.c                       |  13 +-
 net/xdp/xsk_queue.h                           |  76 ++++--
 .../selftests/bpf/prog_tests/test_xsk.c       |  48 ++--
 6 files changed, 329 insertions(+), 72 deletions(-)

-- 
2.43.0


