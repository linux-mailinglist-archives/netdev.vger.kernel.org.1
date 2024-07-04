Return-Path: <netdev+bounces-109146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86BE92725E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9535D28CEEB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260F1AB53E;
	Thu,  4 Jul 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS+Vle86"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF21AB521
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083466; cv=none; b=doXJ+gFiRsns181SANZ61b/UWcxaIwjo0yc3arwMMuAhJLr5O4dG7mf1HnqPywnnnniN7jkyuMJpA2/0EFzi3ttX9yzPV84VBe0Ou8iBm3xn582FOPlWLUPjT0yDZWcl3NuTf0eKaUD3CVW+5Xt7MUWhQsNF08WLjJy8I4qt1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083466; c=relaxed/simple;
	bh=FsrZH/TGqzn1uJ/E0p4we1+jtwCZbTck+nRh4MWLjV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwizolG5aL6F7NyruBuDwM/Npm5ePLNCcRRP/NAMORiEkyaQojaWtgOpAEOPsN96Wf06CxiHgNq7cFAFWwUNWQvRWs2bJfjUKGr/F4G8k+Rn+yb1Lp2DoNOZr9e3oruKiEm1MvHtd/W58KW65wfBp7FRmNVeXi25SU3ZIsWoaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gS+Vle86; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720083463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pPHKz7rPW6hko1EvXLQWowHSNtp/6T1XMeDI5F+8Nq0=;
	b=gS+Vle86DHxg5v5jzrqOHAe4WZNfnQoafRLpA5EiAh6nm93tb/e+2tZLjIlRK3LP+fP0kN
	q3J6CdhjcVvSN7xfy/MWNDdME6qQhm+x6PLcAah89mILwFF7FWuc2vyeyie1EEp8z3yGTz
	cDXaLssqsLmkxYCuKF69MLP9QQKahI0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-lND8c3GfOrGZBJvH2WBt4A-1; Thu,
 04 Jul 2024 04:57:41 -0400
X-MC-Unique: lND8c3GfOrGZBJvH2WBt4A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17221195421E;
	Thu,  4 Jul 2024 08:57:40 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.59])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BCD6195605A;
	Thu,  4 Jul 2024 08:57:36 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v9 00/10] net: openvswitch: Add sample multicasting.
Date: Thu,  4 Jul 2024 10:56:51 +0200
Message-ID: <20240704085710.353845-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

Finally, a new OVS action (OVS_SAMPLE_ATTR_PSAMPLE) is created.
It accepts a group and an optional cookie and uses psample to
multicast the packet and the metadata.

--
v8 -> v9:
- Rebased.

v7 -> v8:
- Rebased
- Redirect flow insertion to /dev/null to avoid spat in test.
- Removed inline keyword in stub execute_psample_action function.

v6 -> v7:
- Rebased
- Fixed typo in comment.

v5 -> v6:
- Renamed emit_sample -> psample
- Addressed unused variable and conditionally compilation of function.

v4 -> v5:
- Rebased.
- Removed lefover enum value and wrapped some long lines in selftests.

v3 -> v4:
- Rebased.
- Addressed Jakub's comment on private and unused nla attributes.

v2 -> v3:
- Addressed comments from Simon, Aaron and Ilya.
- Dropped probability propagation in nested sample actions.
- Dropped patch v2's 7/9 in favor of a userspace implementation and
consume skb if emit_sample is the last action, same as we do with
userspace.
- Split ovs-dpctl.py features in independent patches.

v1 -> v2:
- Create a new action ("emit_sample") rather than reuse existing
  "sample" one.
- Add probability semantics to psample's sampling rate.
- Store sampling probability in skb's cb area and use it in emit_sample.
- Test combining "emit_sample" with "trunc"
- Drop group_id filtering and tracepoint in psample.

rfc_v2 -> v1:
- Accommodate Ilya's comments.
- Split OVS's attribute in two attributes and simplify internal
handling of psample arguments.
- Extend psample and tc with a user-defined cookie.
- Add a tracepoint to psample to facilitate troubleshooting.

rfc_v1 -> rfc_v2:
- Use psample instead of a new OVS-only multicast group.
- Extend psample and tc with a user-defined cookie.

Adrian Moreno (10):
  net: psample: add user cookie
  net: sched: act_sample: add action cookie to sample
  net: psample: skip packet copy if no listeners
  net: psample: allow using rate as probability
  net: openvswitch: add psample action
  net: openvswitch: store sampling probability in cb.
  selftests: openvswitch: add psample action
  selftests: openvswitch: add userspace parsing
  selftests: openvswitch: parse trunc action
  selftests: openvswitch: add psample test

 Documentation/netlink/specs/ovs_flow.yaml     |  17 ++
 include/net/psample.h                         |   5 +-
 include/uapi/linux/openvswitch.h              |  31 +-
 include/uapi/linux/psample.h                  |  11 +-
 net/openvswitch/Kconfig                       |   1 +
 net/openvswitch/actions.c                     |  66 ++++-
 net/openvswitch/datapath.h                    |   3 +
 net/openvswitch/flow_netlink.c                |  32 ++-
 net/openvswitch/vport.c                       |   1 +
 net/psample/psample.c                         |  16 +-
 net/sched/act_sample.c                        |  12 +
 .../selftests/net/openvswitch/openvswitch.sh  | 115 +++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 272 +++++++++++++++++-
 13 files changed, 566 insertions(+), 16 deletions(-)

-- 
2.45.2


