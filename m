Return-Path: <netdev+bounces-152375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E239F3B72
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 21:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4951883347
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFE1E1A18;
	Mon, 16 Dec 2024 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhEepi5e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34301E1A17
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381781; cv=none; b=DM32As3lTiFHc18OxukKT3Elu7vCWBzq91xV6AsRkWtcF/yguZeo/DUZofh1NQOmMPW7DbG4IZuk/b2lSIWmL9OcO982+NY8EXNgY2NbVKBtSW5cprbewnCeLZ3mheS6gzG2InG/lLBNM4wUNYSlImP1Syfqw+ewTkNOBBHcZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381781; c=relaxed/simple;
	bh=TPib/jBc03UFvozatFPF3MMXl8SN6lFqc8ChVYwnJ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRC0t51NcEhqI+wkwGyQBUGamSxiIR/ye5Eun9s1khpuwJj4NImaCDqBU7lfB7wyMypUnQ0JuR4Rs5bjwmRqxQ1qrs1YNazuHjM5ajHDSkpfV7OFRmUopaO8jjFoO/87kfh/i1GxuTvyj9V2crI5rUYdJXhYdIt5SHYZ3BNhjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhEepi5e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1KN0H1DyrTJ9oId0tb+k5ruXvxmzXbOtML0jIjZVz8=;
	b=KhEepi5eWIms6QR/+HGFvpx8o7hz4bDwcLGlfeaIxjidMdYb49d9hd/WaL0ILcC2Xkr1Ye
	7hvvhNYU32VTxxUVwW6IgntphQwfI/DWi+PXBoy/W0Usjw9wf7VZTWjp45NdehmtWPoDAe
	zItNJkg/tRT7yzp2rmjhVvHB+KDOaaQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-dbBrdsInOVus8GFxw7tcpQ-1; Mon,
 16 Dec 2024 15:42:54 -0500
X-MC-Unique: dbBrdsInOVus8GFxw7tcpQ-1
X-Mimecast-MFC-AGG-ID: dbBrdsInOVus8GFxw7tcpQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 605751956059;
	Mon, 16 Dec 2024 20:42:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18CA519560AD;
	Mon, 16 Dec 2024 20:42:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [PATCH v5 10/32] netfs: Don't use bh spinlock
Date: Mon, 16 Dec 2024 20:41:00 +0000
Message-ID: <20241216204124.3752367-11-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

All the accessing of the subrequest lists is now done in process context,
possibly in a workqueue, but not now in a BH context, so we don't need the
lock against BH interference when taking the netfs_io_request::lock
spinlock.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c |  4 ++--
 fs/netfs/direct_read.c   |  4 ++--
 fs/netfs/read_collect.c  | 20 ++++++++++----------
 fs/netfs/read_retry.c    |  8 ++++----
 fs/netfs/write_collect.c |  4 ++--
 fs/netfs/write_issue.c   |  4 ++--
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index fa1013020ac9..4ff4b587dc4b 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -200,12 +200,12 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		subreq->len	= size;
 
 		atomic_inc(&rreq->nr_outstanding);
-		spin_lock_bh(&rreq->lock);
+		spin_lock(&rreq->lock);
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 		subreq->prev_donated = rreq->prev_donated;
 		rreq->prev_donated = 0;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 
 		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
 		subreq->source = source;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 54027fd14904..1a20cc3979c7 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -68,12 +68,12 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		subreq->len	= size;
 
 		atomic_inc(&rreq->nr_outstanding);
-		spin_lock_bh(&rreq->lock);
+		spin_lock(&rreq->lock);
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 		subreq->prev_donated = rreq->prev_donated;
 		rreq->prev_donated = 0;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 
 		netfs_stat(&netfs_n_rh_download);
 		if (rreq->netfs_ops->prepare_read) {
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 454a5bbdd6f8..26e430baeb5a 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -144,7 +144,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 	prev_donated = READ_ONCE(subreq->prev_donated);
 	next_donated =  READ_ONCE(subreq->next_donated);
 	if (prev_donated || next_donated) {
-		spin_lock_bh(&rreq->lock);
+		spin_lock(&rreq->lock);
 		prev_donated = subreq->prev_donated;
 		next_donated =  subreq->next_donated;
 		subreq->start -= prev_donated;
@@ -157,7 +157,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 			next_donated = subreq->next_donated = 0;
 		}
 		trace_netfs_sreq(subreq, netfs_sreq_trace_add_donations);
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 	}
 
 	avail = subreq->transferred;
@@ -186,18 +186,18 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 		} else if (fpos < start) {
 			excess = fend - subreq->start;
 
-			spin_lock_bh(&rreq->lock);
+			spin_lock(&rreq->lock);
 			/* If we complete first on a folio split with the
 			 * preceding subreq, donate to that subreq - otherwise
 			 * we get the responsibility.
 			 */
 			if (subreq->prev_donated != prev_donated) {
-				spin_unlock_bh(&rreq->lock);
+				spin_unlock(&rreq->lock);
 				goto donation_changed;
 			}
 
 			if (list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
-				spin_unlock_bh(&rreq->lock);
+				spin_unlock(&rreq->lock);
 				pr_err("Can't donate prior to front\n");
 				goto bad;
 			}
@@ -213,7 +213,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 
 			if (subreq->consumed >= subreq->len)
 				goto remove_subreq_locked;
-			spin_unlock_bh(&rreq->lock);
+			spin_unlock(&rreq->lock);
 		} else {
 			pr_err("fpos > start\n");
 			goto bad;
@@ -241,11 +241,11 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 	/* Donate the remaining downloaded data to one of the neighbouring
 	 * subrequests.  Note that we may race with them doing the same thing.
 	 */
-	spin_lock_bh(&rreq->lock);
+	spin_lock(&rreq->lock);
 
 	if (subreq->prev_donated != prev_donated ||
 	    subreq->next_donated != next_donated) {
-		spin_unlock_bh(&rreq->lock);
+		spin_unlock(&rreq->lock);
 		cond_resched();
 		goto donation_changed;
 	}
@@ -296,11 +296,11 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 	goto remove_subreq_locked;
 
 remove_subreq:
-	spin_lock_bh(&rreq->lock);
+	spin_lock(&rreq->lock);
 remove_subreq_locked:
 	subreq->consumed = subreq->len;
 	list_del(&subreq->rreq_link);
-	spin_unlock_bh(&rreq->lock);
+	spin_unlock(&rreq->lock);
 	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_consumed);
 	return true;
 
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index a2021efa44c0..a33bd06e80f8 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -142,12 +142,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 			subreq->retry_count++;
 
-			spin_lock_bh(&rreq->lock);
+			spin_lock(&rreq->lock);
 			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 			subreq->prev_donated += rreq->prev_donated;
 			rreq->prev_donated = 0;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-			spin_unlock_bh(&rreq->lock);
+			spin_unlock(&rreq->lock);
 
 			BUG_ON(!len);
 
@@ -217,9 +217,9 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 	}
-	spin_lock_bh(&rreq->lock);
+	spin_lock(&rreq->lock);
 	list_splice_tail_init(&queue, &rreq->subrequests);
-	spin_unlock_bh(&rreq->lock);
+	spin_unlock(&rreq->lock);
 }
 
 /*
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 237018caba27..f026cbc0e2fe 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -238,14 +238,14 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 
 		cancel:
 			/* Remove if completely consumed. */
-			spin_lock_bh(&wreq->lock);
+			spin_lock(&wreq->lock);
 
 			remove = front;
 			list_del_init(&front->rreq_link);
 			front = list_first_entry_or_null(&stream->subrequests,
 							 struct netfs_io_subrequest, rreq_link);
 			stream->front = front;
-			spin_unlock_bh(&wreq->lock);
+			spin_unlock(&wreq->lock);
 			netfs_put_subrequest(remove, false,
 					     notes & SAW_FAILURE ?
 					     netfs_sreq_trace_put_cancel :
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 7a14a48e62ee..286bc2aa3ca0 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -203,7 +203,7 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 	 * the list.  The collector only goes nextwards and uses the lock to
 	 * remove entries off of the front.
 	 */
-	spin_lock_bh(&wreq->lock);
+	spin_lock(&wreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
 		stream->front = subreq;
@@ -214,7 +214,7 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 		}
 	}
 
-	spin_unlock_bh(&wreq->lock);
+	spin_unlock(&wreq->lock);
 
 	stream->construct = subreq;
 }


