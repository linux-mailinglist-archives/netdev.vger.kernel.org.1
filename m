Return-Path: <netdev+bounces-252388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNrSAi1EcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:37:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD506902E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CEEA5ECD90
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ABF319873;
	Thu, 22 Jan 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEkUgyqq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224F32B98F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093847; cv=none; b=idCBSiat8IAZXLJkDWm+8m1/HuwTzBLSGzxrO4RjMAsppz2b/QGnRY/a4hMtQVDKhvF9ErICssmY+5vuG7OGDv8pZVQAwjcKf6eJf2qGkSXdgJfq1Duv8CAgK6KJ6eTwYGJrGA3N5+uWjAWQYhdViZDJCPPE6O/BEFNsVjEbwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093847; c=relaxed/simple;
	bh=VHsbknpFnUjfZ9RHAYz/Yx5uM815LYpuS95eRmNUkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kN1oWKhT/BdSgq6hlr0GJc+wr7n05+8BZsigaB/qACicSK6mhTLS2/SGoOmsWUUzzAQSGH9OcomgcqDcS1j43AB2kL4v970nl2k10iBDD+lriWEMPRBp47jX6BYwlUmE19h1nwMgWTKoJt0q4WjyLY4a9I20w/KrbxMKBvHmTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEkUgyqq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8lbFRxIL1n7zy3dzRcYRJjqea0bv9zrfepdsKSQkR/4=;
	b=JEkUgyqqOXdGrAbWpuM7JgBYGNRrWUZhyzLExqqmJkM6PSA2iDBarEhk+X+HhGeGSMNHgX
	bzuT+J/eJYhnVQ/NbmyYq3iElz73IgL58B2nPWjhrzRj+1uE6PVmPp1mBWUgzsC64GfPGF
	S/LnX6nzxRpXPjJZfv4MwCStc2dB3s0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-urUUcg5qO1WjqwHp4Iob_Q-1; Thu,
 22 Jan 2026 09:57:21 -0500
X-MC-Unique: urUUcg5qO1WjqwHp4Iob_Q-1
X-Mimecast-MFC-AGG-ID: urUUcg5qO1WjqwHp4Iob_Q_1769093839
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C30D4193E8E2;
	Thu, 22 Jan 2026 14:57:18 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED18618004D8;
	Thu, 22 Jan 2026 14:57:14 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net,
	bigeasy@linutronix.de
Subject: [PATCH net-next v2 0/9] hsr: Implement more robust duplicate discard algorithm
Date: Thu, 22 Jan 2026 15:56:55 +0100
Message-ID: <cover.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-252388-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6FD506902E
X-Rspamd-Action: no action

The duplicate discard algorithms for PRP and HSR do not work reliably
with certain link faults. Especially with packet loss on one link, the
duplicate discard algorithms drop valid packets. For a more thorough
description see patches 4 (for PRP) and 6 (for HSR).

This patchset replaces the current algorithms (based on a drop window
for PRP and highest seen sequence number for HSR) with a single new one
that tracks the received sequence numbers individually (descriptions
again in patches 4 and 6).

The changes will lead to higher memory usage and more work to do for
each packet. But I argue that this is an acceptable trade-off to make
for a more robust PRP and HSR behavior with faulty links. After all,
both protocols are to be used in environments where redundancy is needed
and people are willing to setup special network topologies to achieve
that.

Some more reasoning on the overhead and expected scale of the deployment
from the RFC discussion:

> As for the expected scale, there are two dimensions: the number of nodes
> in the network and the data rate with which they send.
>
> The number of nodes in the network affect the memory usage because each
> node now has the block buffer. For PRP that's 64 blocks * 32 byte =
> 2kbyte for each node in the node table. A PRP network doesn't have an
> explicit limit for the number of nodes. However, the whole network is a
> single layer-2 segment which shouldn't grow too large anyways. Even if
> one really tries to put 1000 nodes into the PRP network, the memory
> overhead (2Mbyte) is acceptable in my opinion.
>
> For HSR, the blocks would be larger because we need to track the
> sequence numbers per port. I expect 64 blocks * 80 byte = 5kbyte per
> node in the node table. There is no explicit limit for the size of an
> HSR ring either. But I expect them to be of limited size because the
> forwarding delays add up throughout the ring. I've seen vendors limiting
> the ring size to 50 nodes with 100Mbit/s links and 300 with 1Gbit/s
> links. In both cases I consider the memory overhead acceptable.
>
> The data rates are harder to reason about. In general, the data rates
> for HSR and PRP are limited because too high packet rates would lead to
> very fast re-use of the 16bit sequence numbers. The IEC 62439-3:2021
> mentions 100Mbit/s links and 1Gbit/s links. I don't expect HSR or PRP
> networks to scale out to, e.g., 10Gbit/s links with the current
> specification as this would mean that sequence numbers could repeat as
> often as every ~4ms. The default constants in the IEC standard, which we
> also use, are oriented at a 100Mbit/s network.
>
> In my tests with veth pairs, the CPU overhead didn't lead to
> significantly lower data rates. The main factor limiting the data rate
> at the moment, I assume, is the per-node spinlock that is taken for each
> received packet. IMHO, there is a lot more to gain in terms of CPU
> overhead from making this lock smaller or getting rid of it, than we
> loose with the more accurate duplicate discard algorithm in this patchset.
>
> The CPU overhead of the algorithm benefits from the fact that in high
> packet rate scenarios (where it really matters) many packets will have
> sequence numbers in already initialized blocks. These packets just have
> additionally: one xarray lookup, one comparison, and one bit setting. If
> a block needs to be initialized (once every 128 packets plus their 128
> duplicates if all sequence numbers are seen), we will have: one
> xa_erase, a bunch of memory writes, and one xa_store.
>
> In theory, all packets could end up in the slow path if a node sends
> every 128th packet to us. If this is sent from a well behaving node, the
> packet rate wouldn't be an issue anymore, though.

A note about

Thanks,
   Felix

Signed-off-by: Felix Maurer <fmaurer@redhat.com>

---

Changes since v1:
  - link: https://lore.kernel.org/netdev/cover.1769001553.git.fmaurer@redhat.com/
  - Disable shellcheck for unassigned variables on the first use of each
    namespace from setup_ns (I thought this would be necessary for every
    use and therefore didn't do it in v1)
  - Address the netdev/ai-review remarks, they were all valid

Changes since the RFC:
  - link: https://lore.kernel.org/netdev/cover.1766433800.git.fmaurer@redhat.com/
  - Extended the new algorithm to HSR
  - shellcheck'ing and checkpatch'ing
  - Updated the KUnit test

Felix Maurer (9):
  selftests: hsr: Add ping test for PRP
  selftests: hsr: Check duplicates on HSR with VLAN
  selftests: hsr: Add tests for faulty links
  hsr: Implement more robust duplicate discard for PRP
  selftests: hsr: Add tests for more link faults with PRP
  hsr: Implement more robust duplicate discard for HSR
  selftests: hsr: Add more link fault tests for HSR
  hsr: Update PRP duplicate discard KUnit test for new algorithm
  MAINTAINERS: Assign hsr selftests to HSR

 MAINTAINERS                                   |   1 +
 net/hsr/hsr_framereg.c                        | 362 ++++++++++-------
 net/hsr/hsr_framereg.h                        |  39 +-
 net/hsr/prp_dup_discard_test.c                | 154 ++++---
 tools/testing/selftests/net/hsr/Makefile      |   2 +
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 207 +++-------
 .../testing/selftests/net/hsr/link_faults.sh  | 378 ++++++++++++++++++
 tools/testing/selftests/net/hsr/prp_ping.sh   | 147 +++++++
 tools/testing/selftests/net/hsr/settings      |   2 +-
 9 files changed, 910 insertions(+), 382 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/link_faults.sh
 create mode 100755 tools/testing/selftests/net/hsr/prp_ping.sh


base-commit: b6d5a62231acd628c4a989cad562fe37958b1218
-- 
2.52.0


