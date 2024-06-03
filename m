Return-Path: <netdev+bounces-100327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F68D8915
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16F71F2618E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8614139D0E;
	Mon,  3 Jun 2024 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUOwxN5K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF113A3E3
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441032; cv=none; b=CCLsXPPuwI+OZ3L83gNQ/GZABlGSwxaCuqcS4pHY7bpNimF82stURPz2UPBxJ+SByCrsyyukAUl8/dhdm/ltSZAvpBLX2fU5kW42osMMQbvbIkCbReX2M8U3b1PoHtv6LfshikcI7eD6KXtgD9Urk/bxlt9M4JpUrFpZ0cCTaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441032; c=relaxed/simple;
	bh=p01pWw/IarCEB5g4QJvobzIJOWm3ENSsVz+/MHOXG9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZqRQ+dzGGnn8MGJmI82N3vGWDeK9w2+E2cOYKIX4JBYMh2t8gO89FPlP5p/o/QU1Xa4KF0NUU9g+DQw7ucceZ2Y+ps2UfoqSRiieq76ns0SBnBtfLQ79EeVQGhBoole69Er3G7lR/O5TflDrSRHs6ZMARyNK07ftXrwKP/+ekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUOwxN5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GGrPbUHMPcMLdBUF0+MVpOrkGq3CB7+IkCgczqCk2r0=;
	b=hUOwxN5KVIt6TyJyTsn2gWoFIZfNwrTiuPVhSMt/rHHachYMy6CPKGRGgJEvfhLaTVvD9q
	3T9wQAPG6fb+RpXBY45MvIc9pMkC5TzDgwU7jDMD/N7TGrGDqT9WjISafgjCj/lZUax9XK
	5YUyS94bK2Q2DIDTBKo48YiKZ9tUpvE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-YmJwCTf4MZOH4EzCy34rKg-1; Mon,
 03 Jun 2024 14:57:06 -0400
X-MC-Unique: YmJwCTf4MZOH4EzCy34rKg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8808D18BC60F;
	Mon,  3 Jun 2024 18:56:52 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EA181943288;
	Mon,  3 Jun 2024 18:56:49 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH net-next v2 0/9] net: openvswitch: Add sample multicasting.
Date: Mon,  3 Jun 2024 20:56:34 +0200
Message-ID: <20240603185647.2310748-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

** Background **
Currently, OVS supports several packet sampling mechanisms (sFlow,
per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
userspace action that needs to be handled by ovs-vswitchd's handler
threads only to be forwarded to some third party application that
will somehow process the sample and provide observability on the
datapath.

A particularly interesting use-case is controller-driven
per-flow IPFIX sampling where the OpenFlow controller can add metadata
to samples (via two 32bit integers) and this metadata is then available
to the sample-collecting system for correlation.

** Problem **
The fact that sampled traffic share netlink sockets and handler thread
time with upcalls, apart from being a performance bottleneck in the
sample extraction itself, can severely compromise the datapath,
yielding this solution unfit for highly loaded production systems.

Users are left with little options other than guessing what sampling
rate will be OK for their traffic pattern and system load and dealing
with the lost accuracy.

Looking at available infrastructure, an obvious candidated would be
to use psample. However, it's current state does not help with the
use-case at stake because sampled packets do not contain user-defined
metadata.

** Proposal **
This series is an attempt to fix this situation by extending the
existing psample infrastructure to carry a variable length
user-defined cookie.

The main existing user of psample is tc's act_sample. It is also
extended to forward the action's cookie to psample.

Finally, a new OVS action (OVS_SAMPLE_ATTR_EMIT_SAMPLE) is created.
It accepts a group and an optional cookie and uses psample to
multicast the packet and the metadata.

--
v1 -> v2:
- Create a new action ("emit_sample") rather than reuse existing
  "sample" one.
- Add probability semantics to psample's sampling rate.
- Store sampling probability in skb's cb area and use it in emit_sample.
- Test combining "emit_sample" with "trunc"
- Drop group_id filtering and tracepoint in psample.

rfc_v2 -> v1:
- Accomodate Ilya's comments.
- Split OVS's attribute in two attributes and simplify internal
handling of psample arguments.
- Extend psample and tc with a user-defined cookie.
- Add a tracepoint to psample to facilitate troubleshooting.

rfc_v1 -> rfc_v2:
- Use psample instead of a new OVS-only multicast group.
- Extend psample and tc with a user-defined cookie.

Adrian Moreno (9):
  net: psample: add user cookie
  net: sched: act_sample: add action cookie to sample
  net: psample: skip packet copy if no listeners
  net: psample: allow using rate as probability
  net: openvswitch: add emit_sample action
  net: openvswitch: store sampling probability in cb.
  net: openvswitch: do not notify drops inside sample
  selftests: openvswitch: add emit_sample action
  selftests: openvswitch: add emit_sample test

 Documentation/netlink/specs/ovs_flow.yaml     |  17 ++
 include/net/psample.h                         |   5 +-
 include/uapi/linux/openvswitch.h              |  28 +-
 include/uapi/linux/psample.h                  |   5 +
 include/uapi/linux/tc_act/tc_sample.h         |   1 +
 net/openvswitch/actions.c                     |  86 +++++-
 net/openvswitch/datapath.h                    |   3 +
 net/openvswitch/flow_netlink.c                |  33 ++-
 net/openvswitch/vport.c                       |   1 +
 net/psample/psample.c                         |  16 +-
 net/sched/act_sample.c                        |  12 +
 .../selftests/net/openvswitch/openvswitch.sh  |  99 ++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 274 +++++++++++++++++-
 13 files changed, 564 insertions(+), 16 deletions(-)

-- 
2.45.1


