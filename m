Return-Path: <netdev+bounces-281276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNF4Dpop72lE8AAAu9opvQ
	(envelope-from <netdev+bounces-281276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:17:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B246FB57
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74961306E5CF
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD43A1A50;
	Mon, 27 Apr 2026 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmlunCwL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC03AF65A
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281132; cv=none; b=i5BB3U8bVF1ySNuI12L5btLfaQQZbcvp5LSZQUlHnIDT51bvfpY6ps8LHdEDtxgBbrdncQWhwrbqFRJzCzEUJ+f58a9Nt78dwE0nDrcpVjemhEZnMf1P0Atjq3Pj7NtXJbMBUUpomLDXlKBjwEtSJvRlwCx/qLuKAhsfijJOOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281132; c=relaxed/simple;
	bh=rvvF+yzBzAxhDu5LH1UHGg3bCe4nQ0sXGgcT7zH03N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryHBYLlqrgCQ4VmusnZoH+vpb0LfxP7iivKyJBFVcFNzrcbX3TawXbS+8IKXUAR0bQPbvOQh4EcQn+LVzZDNOw1Z/hYfAOU4rENKbivPJ1TdFc0GeD3SeFpo5rLXmUYmGmIwHycze2/gd84T17x87gWo1HcNu99LZG+iKERsuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmlunCwL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777281128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxu8EEl/NSWtPFSsHpu2gcxuc2ncIwFUJimar90n8NA=;
	b=ZmlunCwL3XabfOsUXGV8hfFsDqmG/bVhfd9P1ho0oJ4YY7TOVReNytrvXAZraV6vCSJLTQ
	AZ2ML23P35gtpcQTIYlzKN/GBZtgcdwMdXYLM+14jnVs4VPuWR4WEKNprOwOtrba8vUp3U
	IA87od7HNlNJpR3gJ248RZr11/EALys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-8kmpqUAEPUmG_aAUQJJJGA-1; Mon,
 27 Apr 2026 05:12:04 -0400
X-MC-Unique: 8kmpqUAEPUmG_aAUQJJJGA-1
X-Mimecast-MFC-AGG-ID: 8kmpqUAEPUmG_aAUQJJJGA_1777281123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 724431800609;
	Mon, 27 Apr 2026 09:12:03 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.33.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3137E1800446;
	Mon, 27 Apr 2026 09:11:59 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	pabeni@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list),
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 0/2] Decouple flow operations from RTNL
Date: Mon, 27 Apr 2026 11:11:46 +0200
Message-ID: <20260427091153.3210301-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: CF9B246FB57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When RTNL is contended, network-related control-plane operations can be
delayed.

In such scenario, if OVS control-plane operations (such as vport
creation) take a bit longer, it's acceptable. However, flow installation
operations happen as part of upcall processing, executed in the context
of of handler threads. If they get delayed, it affects the data-plane
and can even result in packet drops.

Because flow operations also use ovs_mutex for concurrency protection and
given RTNL can nest under ovs_mutex, contention can be easily transferred
from RTNL to ovs_mutex, causing delay in flow operations.

In order to protect flow operations from RTNL delays, this series
decouples them from ovs_mutex. First, the flow_table is converted into an
rcu-protected pointer. Then two locking mechanisms are introduced: a
per-table mutex and a refcount.

The mutex protects the flow_table against concurrent modifications,
while the refcount is used to extend the lifetime of the flow_table
beyond the rcu read-protected region used to dereference it.

v3:
- Split in 2 patches (Paolo)
- Improve locking in get_dp_stats (Paolo and Sashiko)
- Use __always_unused in lockdep stubs (Paolo)
- Use READ_ONCE/WRITE_ONCE for table->count (Aaron)
- Take a reference in ovs_dp_masks_rebalance (Aaron) 

v2: Fix argument in ovs_flow_tbl_put (sparse)
    Remove rcu checks in ovs_dp_masks_rebalance

Adrian Moreno (2):
  net: openvswitch: make flow_table an rcu pointer
  net: openvswitch: decouple flow_table from ovs_mutex

 net/openvswitch/datapath.c   | 293 ++++++++++++++++++++++++-----------
 net/openvswitch/datapath.h   |   2 +-
 net/openvswitch/flow.c       |  13 +-
 net/openvswitch/flow.h       |   9 +-
 net/openvswitch/flow_table.c | 194 ++++++++++++++---------
 net/openvswitch/flow_table.h |  56 ++++++-
 6 files changed, 396 insertions(+), 171 deletions(-)

-- 
2.53.0


