Return-Path: <netdev+bounces-105627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5719121D4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC551C23730
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA7617166F;
	Fri, 21 Jun 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aD4j1xp2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B34F16E892
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964692; cv=none; b=l+TKQUdGyvzNgUzVorKId71wcxGZAsNMbs5qujVxMrLUtcT5oeQpcRFdc0ngnkiGrAOG7BAYcsqqyCHKH4f4hJKrVncAhADZeH3XnKQFU8AmING2bUY53PhhvaPznNdo/MfsoeofDbqT/A13yA8rnkSvVFfMjspvimOct2pMp00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964692; c=relaxed/simple;
	bh=7Adeg/UBJYRAj+dHtME7ixN43BSXJ7NdpwpZYlla8dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4M/uKZ32uuYNpbFZyhnqojvdEkQyNnFgJWF6nRnOX27PLz2UJywIaLQl068geFvWsD7c3F3i3x3NVUI6RtDZ3WBLpBZ8GzDMlXx4Qy0IfWSw8BMBq1LESo8xL+x+pVGEeuP8cCAVMa4xSyVcbgqpRFxr7up5l/CLcQ+d5Oak4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aD4j1xp2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BpA2BXv1BNxn6n4GleVGKaf94K5PkSCq1JBsKSzKaDA=;
	b=aD4j1xp2wRtMYtEab67EBUs950cZQ8tNwIxLyMUVfu14AygxfxeHy4Pp+DQSC/yLY45ydp
	ZS7qsDJJK1zwb4CTc1SZVxSwojxWw9OC79g+LXlHe2FRuuN2eln92HfdGct44EKsFR3bLy
	sqtcP+PgYTxk/I4fgmYElW9LtgHGZnk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-6uONFtqEObGEZ-0dBegTSw-1; Fri,
 21 Jun 2024 06:11:27 -0400
X-MC-Unique: 6uONFtqEObGEZ-0dBegTSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 739F31956080;
	Fri, 21 Jun 2024 10:11:26 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47F8F1956048;
	Fri, 21 Jun 2024 10:11:23 +0000 (UTC)
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
Subject: [PATCH net-next v4 00/10] net: openvswitch: Add sample multicasting.
Date: Fri, 21 Jun 2024 12:10:52 +0200
Message-ID: <20240621101113.2185308-1-amorenoz@redhat.com>
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
- Accomodate Ilya's comments.
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
  net: openvswitch: add emit_sample action
  net: openvswitch: store sampling probability in cb.
  selftests: openvswitch: add emit_sample action
  selftests: openvswitch: add userspace parsing
  selftests: openvswitch: parse trunc action
  selftests: openvswitch: add emit_sample test

 Documentation/netlink/specs/ovs_flow.yaml     |  17 ++
 include/net/psample.h                         |   5 +-
 include/uapi/linux/openvswitch.h              |  31 +-
 include/uapi/linux/psample.h                  |  11 +-
 include/uapi/linux/tc_act/tc_sample.h         |   1 +
 net/openvswitch/Kconfig                       |   1 +
 net/openvswitch/actions.c                     |  63 +++-
 net/openvswitch/datapath.h                    |   3 +
 net/openvswitch/flow_netlink.c                |  33 ++-
 net/openvswitch/vport.c                       |   1 +
 net/psample/psample.c                         |  16 +-
 net/sched/act_sample.c                        |  12 +
 .../selftests/net/openvswitch/openvswitch.sh  | 110 ++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 272 +++++++++++++++++-
 14 files changed, 560 insertions(+), 16 deletions(-)

-- 
2.45.1


