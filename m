Return-Path: <netdev+bounces-306682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uK2HBcpLUWo3CAMAu9opvQ
	(envelope-from <netdev+bounces-306682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:45:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28D73DE84
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:45:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=UHJqBX0N;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306682-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306682-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59AF2300C924
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BAB34B68C;
	Fri, 10 Jul 2026 19:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4438757B;
	Fri, 10 Jul 2026 19:44:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712701; cv=none; b=jMupsLHj4Z/WQzErQ9vBC66cbIJStHesWqif7KUMG8yeDOaTmhpTSpHxbAc2rjvsJYoiQN+C4Shx2jqix5AnNoGkSOOK/X9Spquob+WnmC1h3kN9cgj0FopknSy4rMy0R3WZq87ejExvNE2clFdDsoPr1tMb8leqbQJpUGDI/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712701; c=relaxed/simple;
	bh=MmHLgOZWD/DCvka42pERrn7Hnkq8hVSJmuccw4OV55g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rcwxFHEbo7seLS4vIVz1XfDrwch1FuhdzOGJMvzTxE8TXzuSg1HYFF0aU4IK5+8VGFF9q0RpclZj52ADA0VJR91PXMTOISz4Ter2Vif8x/sXNWWRgOzxgwfKTzZjc7u7Wdp4ZBHnP1c5+yrxNJ09isYSwLMCviGo6it3aH4IALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHJqBX0N; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783712696; x=1815248696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MmHLgOZWD/DCvka42pERrn7Hnkq8hVSJmuccw4OV55g=;
  b=UHJqBX0N/id/WeRfvUa0UjN5e9JpDtz+WGx9I5qSW2BmqpLKwQt+Z+Go
   yLKHq9YfREroVOieob/chq0/EZzmsnlb/uSJYi6cv6BohFeS7m6UxU8KJ
   O6td1YVa1z6GfYhvdJoG1abi/ji2iXldJdVZPY8KUzZ65p7Jt4DMwcmQH
   l0BAPJ0j2TA49JrEWUI4Qezyhv3jwjuuCZj6Ftp5QCAOhFgcdhOs0mvDm
   NyvWHfqnjZCYHyfxXWIRi3aPpx6ON7CYZHWIBtrkUdT6n9SAD1kp2xvvv
   gJEKlUVb9OQdZhIpbE61Ss9aLv3CTkxQFFqa3zOQvZzYNsvfpmSt+jTMf
   w==;
X-CSE-ConnectionGUID: wigbTOUPSEOt2n2TjgIpcA==
X-CSE-MsgGUID: iIL/m59pQ1OsQqE8wBU9iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101965193"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101965193"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:44:54 -0700
X-CSE-ConnectionGUID: bPspZNIVSYqjwce8SbNI4w==
X-CSE-MsgGUID: bFC4kL7SRWK6MMAYgNmAmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293157253"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2026 12:44:51 -0700
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
Subject: [PATCH v2 net 0/5] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
Date: Fri, 10 Jul 2026 21:44:19 +0200
Message-Id: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306682-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C28D73DE84

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

Maciej Fijalkowski (3):
  xsk: reclaim invalid multi-buffer Tx descs in ZC path
  selftests/xsk: fix too-many-frags multi-buffer Tx test
  selftests/xsk: account invalid multi-buffer Tx descriptors

 include/net/xdp_sock.h                        |   1 +
 include/net/xsk_buff_pool.h                   |   3 +
 net/xdp/xsk.c                                 | 239 ++++++++++++++++--
 net/xdp/xsk_buff_pool.c                       |   1 +
 net/xdp/xsk_queue.h                           |  76 ++++--
 .../selftests/bpf/prog_tests/test_xsk.c       |  48 ++--
 6 files changed, 313 insertions(+), 55 deletions(-)

-- 
2.43.0


