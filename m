Return-Path: <netdev+bounces-85753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 819F189BFAB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED83C1F223BE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB374EB3D;
	Mon,  8 Apr 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfWx4KZj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8874438
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581102; cv=none; b=L9JNsWW6RROQXdnXI4x7l3PXsQTSvEgAhg2I2RQl4ey1mF8pR8vbivdZfKx91inZIPDvFxGa06Ynip1CSjTC2MloKz8+npZJE8gY73XFVy6R9LALdkgcXeK5c+KIbIVgj0dyfH3fSX5GecNks2pXojZLBac710DI8I7GCiRYsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581102; c=relaxed/simple;
	bh=a2d4C2Ez/0QTThgMCyQP2hSswIjc7FkVT88epSEiDSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtXgujnGPv0UMZXqYVWvdIUuQ0aV9i7p+YbIhVpEo4mI0Pbg2+5kbKN/oOP0GgU1h/84ubGRq7XbtL/AwEF6etiw4kadHtcHAn6Nh6kuCYMLaQzdFLvqnGrpnB+C7mgdVo5fGLd/pWzIMnjCNCMxItLiN4NPbQ61xIgDBHnEtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfWx4KZj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712581099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/VhA5chGGhjKqJayxacvnIJrMUoQSDyXVE6sX7pKdXE=;
	b=FfWx4KZjxNXjQcLfCmRh1ec+2Lc6JEjWV8R84JxPP88gELx4nc4XKcm+6T/z1Rc4k0TPCa
	dLnIzw1b1YVAY+fnywhkNkU44ocdzkkkKuS9lAkF0p9QVJ/kurGp0hf3tXBe9jukH8oHhN
	IoNtHye53eCYS6VYMsao7IfoeGEs/dM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-zrRAIKaJO8ylNub9xfa5WQ-1; Mon, 08 Apr 2024 08:58:18 -0400
X-MC-Unique: zrRAIKaJO8ylNub9xfa5WQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6091830E7A;
	Mon,  8 Apr 2024 12:58:17 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.170])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B2BC2DD51;
	Mon,  8 Apr 2024 12:58:15 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC net-next v2 0/5] net: openvswitch: Add sample multicasting.
Date: Mon,  8 Apr 2024 14:57:39 +0200
Message-ID: <20240408125753.470419-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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
In this RFC_v2, I'd like to request feedback on an attempt to fix this
situation by:

- Extending the existing psample infrastructure to carry a variable
length user-defined cookie.
- Extending the tc act_sample action to use the actions' cookie as
psample metadata.
- Extending the OVS sample action with an attribute
(OVS_SAMPLE_ATTR_PSAMPLE) that contains a u32 group_id and a variable
length cookie and use the the psample infrastructure to multicast
the sample.
- Extending psample to allow group_id filtering on listening sockets so
that users can only receive samples they are interested in.

--
rfc_v1 -> rfc_v2:
- Use psample instead of a new OVS-only multicast group.
- Extend psample and tc with a user-defined cookie.


Adrian Moreno (5):
  net: netlink: export genl private pointer getters
  net: psample: add multicast filtering on group_id
  net: psample: add user cookie
  net:sched:act_sample: add action cookie to sample
  net:openvswitch: add psample support

 include/net/psample.h            |   2 +
 include/uapi/linux/openvswitch.h |  22 ++++-
 include/uapi/linux/psample.h     |   2 +
 net/netlink/genetlink.c          |   2 +
 net/openvswitch/actions.c        |  52 ++++++++++--
 net/openvswitch/datapath.c       |   2 +-
 net/openvswitch/flow_netlink.c   |  78 +++++++++++++----
 net/psample/psample.c            | 139 +++++++++++++++++++++++++++++--
 net/sched/act_sample.c           |  12 +++
 9 files changed, 277 insertions(+), 34 deletions(-)

-- 
2.44.0


