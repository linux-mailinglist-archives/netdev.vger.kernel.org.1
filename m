Return-Path: <netdev+bounces-78450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CB875301
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B859B22E86
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6012F12EBE0;
	Thu,  7 Mar 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKh3M309"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3F3EA8A
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824739; cv=none; b=MeXxVldt0L/dLDODqe39rFmWgjwoLAtP9y/tDhQYXx4Zzj5eFtbYfXzJrB87lzCXc3g8LrnQJTsRdp5UhZX0LWWRX2TGyEW4yzX0a0fSFWbB78cF5wcYgtMQk1yOAJaMN6lrIy6F4vtSHO+DGv0zDzjUOr8pRgZgN3V8huSl8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824739; c=relaxed/simple;
	bh=Mt4C1C+cniKS6/Ys3xXoGDF/0d72evyN3wdOXo+RvH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeSp5Lb8LT/p5T8uD3Tgl1WV9B0CKsoNDz9GVMBx6qeWg+nsnNVKkj9oZc2np9s7tsRW/uZCwBDMMZL1lBCDvjdFQbw0gK/pDyI9Cs9U6xCXn7M09BWxQ50j5VPncKkK9ro+AFgNT+3ifalG5kADD3ooYeNnwV8kVqTGq/uzurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKh3M309; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709824736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0O4mtCGZglWTpIIXyB/w4rG5wVMIkjav10Yw4fgpp7E=;
	b=eKh3M309u98xRCOMBU1aPWm58NGAr9FVLtnJtB5hLs6vpOZX14a3G6ZZEkuySebfDvQs6L
	iEH8SlT6ntNENa5IYNawUL4DqvZX6X2O257RRXEiGyl53QKkqpenZAKp6In0PN/t1j+iGZ
	WDFVEvjvD7Pw9qXvMloXxk8e0v1oGkU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-SFuYo9SJMfipAb__9ufRaQ-1; Thu, 07 Mar 2024 10:18:53 -0500
X-MC-Unique: SFuYo9SJMfipAb__9ufRaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF6EB932D22;
	Thu,  7 Mar 2024 15:18:52 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D3E82166B33;
	Thu,  7 Mar 2024 15:18:51 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC PATCH 0/4] net: openvswitch: Add sample multicasting.
Date: Thu,  7 Mar 2024 16:18:44 +0100
Message-ID: <20240307151849.394962-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

** Background **
Currently, OVS supports several packet sampling mechanisms (sFlow,
per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
userspace action that needs to be handled by ovs-vswitchd's handler
threads only to be forwarded to some third party application that
will somehow process the sample and provide observability on the
datapath.

The fact that sampled traffic share netlink sockets and handler thread
time with upcalls, apart from being a performance bottleneck in the
sample extraction itself, can severely compromise the datapath,
yielding this solution unfit for highly loaded production systems.

Users are left with little options other than guessing what sampling
rate will be OK for their traffic pattern and system load and dealing
with the lost accuracy.

** Proposal **
In this RFC, I'd like to request feedback on an attempt to fix this
situation by adding a flag to the userspace action to indicate the
upcall should be sent to a netlink multicast group instead of unicasted
to ovs-vswitchd.

This would allow for other processes to read samples directly, freeing
the netlink sockets and handler threads to process packet upcalls.

** Notes on tc-offloading **
I am aware of the efforts being made to offload the sample action with
the help of psample.
I did consider using psample to multicast the samples. However, I
found a limitation that I'd like to discuss:
I would like to support OVN-driven per-flow (IPFIX) sampling because
it allows OVN to insert two 32-bit values (obs_domain_id and
ovs_point_id) that can be used to enrich the sample with "high level"
controller metadata (see debug_drop_domain_id NBDB option in ovn-nb(5)).

The existing fields in psample_metadata are not enough to carry this
information. Would it be possible to extend this struct to make room for
some extra "application-specific" metadata?

** Alternatives **
An alternative approach that I'm considering (apart from using psample
as explained above) is to use a brand-new action. This lead to a cleaner
separation of concerns with existing userspace action (used for slow
paths and OFP_CONTROLLER actions) and cleaner statistics.
Also, ovs-vswitchd could more easily make the layout of this
new userdata part of the public API, allowing third party sample
collectors to decode it.

I am currently exploring this alternative but wanted to send the RFC to
get some early feedback, guidance or ideas.

Adrian Moreno (4):
  net:openvswitch: Support multicasting userspace ...
  openvswitch:trace: Add ovs_dp_monitor tracepoint.
  net:openvswitch: Avoid extra copy if no listeners.
  net:openvswitch: Add multicasted packets to stats

 include/uapi/linux/openvswitch.h    |  8 +++-
 net/openvswitch/actions.c           |  5 ++
 net/openvswitch/datapath.c          | 33 ++++++++++++--
 net/openvswitch/datapath.h          |  1 +
 net/openvswitch/flow_netlink.c      |  6 ++-
 net/openvswitch/openvswitch_trace.h | 71 +++++++++++++++++++++++++++++
 net/openvswitch/vport.c             |  8 ++++
 net/openvswitch/vport.h             |  1 +
 8 files changed, 125 insertions(+), 8 deletions(-)

-- 
2.44.0


