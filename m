Return-Path: <netdev+bounces-167483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE9A3A757
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817231769D3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000FB1E833B;
	Tue, 18 Feb 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXyTHyoE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972D1E8334
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906608; cv=none; b=um5N5Vmud+UbSlolOoeB2QzlALhujZYZGqatGO4gKeDHe8990//5YYCiwl2cOlUlEwLr5YfWQFYs/Xt0OSJdwj2Mfu4MLuE6TtrBdOIu+xEZTcf97Yd263Jf2bV/9bNDSHytMprleS3s1TeTMQzrZuLTB+dTkFURNYdOKWzGyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906608; c=relaxed/simple;
	bh=BDan6t7sUNAjsL4BMJ/2RecnjFLxoeh1C61ibdVABHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6JU2S/+fsstPFdmTLgJajL1lQfOAISnm/0G1uJjBtQ30l8pbysCsBeJvGqS8/ZWKrhhp36pUmh7l7FGhGLsOYfPCpJlGfiFt1usQKgxW2deo8WRVOGNxbtZoYvYB4GdqjGTCZLDKpaWCYrwANGu7fmKlJEClyHKbNZC90Y4KAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXyTHyoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okrkfbNtPlVLenidxm7PbU4b+F8KjsI3nogVcclO2WU=;
	b=AXyTHyoEQXh+5BPwXRq2H3s7SZbH2cMk8XcrkGgpLc5ePYPd9vcjbkJ5muDJOW7ddUyJbR
	WcvEsSTIbA9ViCtWzIZFEpMQxmqYPjN8w4iU1yqvAdF1qcpeGskI0YS1quxQ19clqCiNMg
	fME6XbJndB2+BYvdpMdpyYyVZR/L9zk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-O7dNXZgnOOy1UGFdDTvKLQ-1; Tue,
 18 Feb 2025 14:23:20 -0500
X-MC-Unique: O7dNXZgnOOy1UGFdDTvKLQ-1
X-Mimecast-MFC-AGG-ID: O7dNXZgnOOy1UGFdDTvKLQ_1739906599
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B556B180034A;
	Tue, 18 Feb 2025 19:23:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13230180035F;
	Tue, 18 Feb 2025 19:23:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 5/5] afs: Give an afs_server object a ref on the afs_cell object it points to
Date: Tue, 18 Feb 2025 19:22:48 +0000
Message-ID: <20250218192250.296870-6-dhowells@redhat.com>
In-Reply-To: <20250218192250.296870-1-dhowells@redhat.com>
References: <20250218192250.296870-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Give an afs_server object a ref on the afs_cell object it points to so that
the cell doesn't get deleted before the server record.

Whilst this is circular (cell -> vol -> server_list -> server -> cell), the
ref only pins the memory, not the lifetime as that's controlled by the
activity counter.  When the volume's activity counter reaches 0, it
detaches from the cell and discards its server list; when a cell's activity
counter reaches 0, it discards its root volume.  At that point, the
circularity is cut.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 fs/afs/server.c            | 3 +++
 include/trace/events/afs.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 038f9d0ae3af..4504e16b458c 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -163,6 +163,8 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 	rb_insert_color(&server->uuid_rb, &net->fs_servers);
 	hlist_add_head_rcu(&server->proc_link, &net->fs_proc);
 
+	afs_get_cell(cell, afs_cell_trace_get_server);
+
 added_dup:
 	write_seqlock(&net->fs_addr_lock);
 	estate = rcu_dereference_protected(server->endpoint_state,
@@ -442,6 +444,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 			 atomic_read(&server->active), afs_server_trace_free);
 	afs_put_endpoint_state(rcu_access_pointer(server->endpoint_state),
 			       afs_estate_trace_put_server);
+	afs_put_cell(server->cell, afs_cell_trace_put_server);
 	kfree(server);
 }
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index b0db89058c91..958a2460330c 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -174,6 +174,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_get_queue_dns,	"GET q-dns ") \
 	EM(afs_cell_trace_get_queue_manage,	"GET q-mng ") \
 	EM(afs_cell_trace_get_queue_new,	"GET q-new ") \
+	EM(afs_cell_trace_get_server,		"GET server") \
 	EM(afs_cell_trace_get_vol,		"GET vol   ") \
 	EM(afs_cell_trace_insert,		"INSERT    ") \
 	EM(afs_cell_trace_manage,		"MANAGE    ") \
@@ -182,6 +183,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_put_destroy,		"PUT destry") \
 	EM(afs_cell_trace_put_queue_work,	"PUT q-work") \
 	EM(afs_cell_trace_put_queue_fail,	"PUT q-fail") \
+	EM(afs_cell_trace_put_server,		"PUT server") \
 	EM(afs_cell_trace_put_vol,		"PUT vol   ") \
 	EM(afs_cell_trace_see_source,		"SEE source") \
 	EM(afs_cell_trace_see_ws,		"SEE ws    ") \


