Return-Path: <netdev+bounces-297934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gcBiCDFCKmozlQMAu9opvQ
	(envelope-from <netdev+bounces-297934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:05:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985AA66E5EF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:05:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=P07rqdzT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297934-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297934-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D583732151A8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DECD27380A;
	Thu, 11 Jun 2026 04:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B4309F1C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:58:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153917; cv=none; b=G/9y6o+gkmF6Wv+zJzMYQ3FyzN6zAV0VnQ0f5P97ocMzTwO0qf5eaNdEbbZCSV6Igv0ksfnfchpT1YMh/Wb57MocjQnNdmfqjOGpBwhjxI7AopxSXigymq940KtNTD7uaZCK28hq99dutNaOD/byUb+zwT70WhjDJFlO1UIeNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153917; c=relaxed/simple;
	bh=PAo20myxiURt/hUud9KFkMqwaz5b2uNwQnBXzVph8fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m574gal3bP4ageyma/MWkD8gkrB8Rs4jTUf1Efp/QpcEJB/aVhM1yoguAaTtUFmYYDK7IS/y6YAWG7G98zmbQxLPjd9YmkSKFK4NawWob4H4dxAktOakEWAC5owRw+iE35V1n8aFfe+Ia6INY6uSCkM3faQ/ieYQAWzTsP//LDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P07rqdzT; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781153905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ftQwVoy5Q3I9qrW/WGWb0EdYYRl87sRkax1frkSBYvI=;
	b=P07rqdzTvrIJ3R+NaZInYgBLWJzpKETkxOdvJhcpX10QZtWqB6yd3lHW0J7ogn9Ci8pqEf
	bdPMaG1QzjKix2xix4lcrv5AqLBiit5nPX7eeNmxC1tLXl0sYqpK1CD0nGlHLv8gGgqnXY
	7VdlTpftfvsyhHIzYecWskawdG/ZGRA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-POPEN8eIM3S7h6iYsqX5cg-1; Thu,
 11 Jun 2026 00:58:24 -0400
X-MC-Unique: POPEN8eIM3S7h6iYsqX5cg-1
X-Mimecast-MFC-AGG-ID: POPEN8eIM3S7h6iYsqX5cg_1781153903
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2435719560BB;
	Thu, 11 Jun 2026 04:58:23 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.48.149])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 690BD19541B0;
	Thu, 11 Jun 2026 04:58:20 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	pabeni@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list),
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 0/4] net: openvswitch: Decouple flow operations from RTNL
Date: Thu, 11 Jun 2026 06:58:07 +0200
Message-ID: <20260611045817.1302665-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297934-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:pabeni@redhat.com,m:amorenoz@redhat.com,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 985AA66E5EF

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

The following is an example of how concurrent datapath deletion and
flow modifcation would work.
Datapath deletion:

  ovs_lock();
  table = rcu_dereference_protected(dp->table, ...);
  rcu_assign_pointer(dp->table, NULL);
  ovs_flow_tbl_put(table);
  ovs_unlock();

Flow modification:

  rcu_read_lock();
  dp = get_dp(...);
  table = rcu_dereference(dp->table);
  ovs_flow_tbl_get(table);
  rcu_read_unlock();

  mutex_lock(&table->lock);
  /* Perform modifications on the flow_table */
  mutex_unlock(&table->lock);
  ovs_flow_tbl_put(table);

v4:
- Further split patches: move lockdep checks to an independent patch
  (Paolo)
- Add an additional patch to reduce the nested rcu callback scheduling
  (Paolo)
- consolidate flow_table_put after if/else (Paolo)

v3:
- Split in 2 patches (Paolo)
- Improve locking in get_dp_stats (Paolo and Sashiko)
- Use __always_unused in lockdep stubs (Paolo)
- Use READ_ONCE/WRITE_ONCE for table->count (Aaron)
- Take a reference in ovs_dp_masks_rebalance (Aaron) 

v2: Fix argument in ovs_flow_tbl_put (sparse)
    Remove rcu checks in ovs_dp_masks_rebalance


Adrian Moreno (4):
  net: openvswitch: make flow_table an rcu pointer
  net: openvswitch: add per-flow_table lockdep checks
  net: openvswitch: decouple flow_table from ovs_mutex
  net: openvswitch: avoid double-rcu wait period

 net/openvswitch/datapath.c   | 294 ++++++++++++++++++++++++-----------
 net/openvswitch/datapath.h   |   2 +-
 net/openvswitch/flow.c       |  13 +-
 net/openvswitch/flow.h       |   9 +-
 net/openvswitch/flow_table.c | 211 ++++++++++++++++---------
 net/openvswitch/flow_table.h |  56 ++++++-
 6 files changed, 406 insertions(+), 179 deletions(-)

-- 
2.54.0


