Return-Path: <netdev+bounces-255872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNL8IbeygGn6AQMAu9opvQ
	(envelope-from <netdev+bounces-255872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:20:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BADCD415
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4970430028D6
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E92136C0D5;
	Mon,  2 Feb 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbH5KsYG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D978361641
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042034; cv=none; b=Brl6cm3pAyX7wiNS3ghv4V71yi0dqcyl2y1l0OJsRt7hprJEs8mWAAsk7oBqbmYSvtT5hcVQAYjLTua+ympRv7Kn3c4yoywAiPUQGVKbq6/peOikGWDOE/Nrbvf65F1fYMSD0O/NbVQ4B/cTUkmCNdPQArADnXOAkayx+hGGliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042034; c=relaxed/simple;
	bh=ZKAm3tQus3KowArO5n/k8LisyZADKBpkJ7oMYZlpx+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0T2gih0x1Wyv1wVpzTft07hETyJwlyAFFHdJ12KxHEY2VQ+/6G+5HuJyspW8Q2AbQyV6S3mtraC5i/ciSsvhKArf2n+07W/7faatG40e0Pb4AMGDQXQ0e+V8LzrFhFGlpVHmTitlSh1+7pRRfnDriWz+V0VirArWDq88PyhYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbH5KsYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770042031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XANPUPTj+WNiguFaWTW3AyGlIod5cvELUvRvkJ4TbtM=;
	b=XbH5KsYGL/3AW2bfjKqjO4eS05iqKADp2g/alRqKv0keItDdV0bEnD92ddCfIQX87HgOv5
	lRXEkBG9J4qm/BY8J7DDkieQhQP9u0v7AyPTt756CJZjhaokQrXfs7FW5NiHMEaiszoTO9
	HMZbkNyZ+lBjl7OL93a2y/DtTD7wi5k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-xKaQ08bWOEWsKJ-lT1IldA-1; Mon,
 02 Feb 2026 09:20:25 -0500
X-MC-Unique: xKaQ08bWOEWsKJ-lT1IldA-1
X-Mimecast-MFC-AGG-ID: xKaQ08bWOEWsKJ-lT1IldA_1770042023
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A076D1954B17;
	Mon,  2 Feb 2026 14:20:22 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.34.1])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD33E1800577;
	Mon,  2 Feb 2026 14:20:17 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@kernel.org,
	mingo@kernel.org,
	bigeasy@linutronix.de,
	matttbe@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net
Subject: [PATCH net-next v3 0/8] hsr: Implement more robust duplicate discard algorithm
Date: Mon,  2 Feb 2026 15:19:16 +0100
Message-ID: <cover.1770041682.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	TAGGED_FROM(0.00)[bounces-255872-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0BADCD415
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

Thanks,
   Felix

Signed-off-by: Felix Maurer <fmaurer@redhat.com>

---

Changes since v2:
  - link: https://lore.kernel.org/netdev/cover.1769093335.git.fmaurer@redhat.com/
  - Merge KUnit test changes into the algorithm change patches 4 and 6
    (Jakub, Simon)
  - Set time=0 when block insertion to xarray fails (Simon)
  - Use non-atomic test_and_set_bit (Sebastian)
  - Fix lock initialization in KUnit test (Sebastian)
  - Define the bitmap array directly in the block struct (Sebastian)
  - Add explanation for duplicate packets in test to patch 5 (Sebastian)
  - Add Reviewed-by (Sebastian, except patch 4 and 6) and Tested-by
    (Steffen) tags

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

Felix Maurer (8):
  selftests: hsr: Add ping test for PRP
  selftests: hsr: Check duplicates on HSR with VLAN
  selftests: hsr: Add tests for faulty links
  hsr: Implement more robust duplicate discard for PRP
  selftests: hsr: Add tests for more link faults with PRP
  hsr: Implement more robust duplicate discard for HSR
  selftests: hsr: Add more link fault tests for HSR
  MAINTAINERS: Assign hsr selftests to HSR

 MAINTAINERS                                   |   1 +
 net/hsr/hsr_framereg.c                        | 362 ++++++++++-------
 net/hsr/hsr_framereg.h                        |  39 +-
 net/hsr/prp_dup_discard_test.c                | 156 ++++----
 tools/testing/selftests/net/hsr/Makefile      |   2 +
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 207 +++-------
 .../testing/selftests/net/hsr/link_faults.sh  | 378 ++++++++++++++++++
 tools/testing/selftests/net/hsr/prp_ping.sh   | 147 +++++++
 tools/testing/selftests/net/hsr/settings      |   2 +-
 9 files changed, 913 insertions(+), 381 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/link_faults.sh
 create mode 100755 tools/testing/selftests/net/hsr/prp_ping.sh


base-commit: a22f57757f7e88c890499265c383ecb32900b645
-- 
2.52.0


