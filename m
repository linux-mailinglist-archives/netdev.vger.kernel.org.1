Return-Path: <netdev+bounces-118625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3BA952410
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8CF288698
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04451D1F6C;
	Wed, 14 Aug 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kn2cbI94"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656291E4876
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668118; cv=none; b=dZmL1V3YGIhgB6UHCU3RzlKuncpO73MzrR5FahBbig/zsE9ZRsJG5t1crLUoboT9ekllYGEnJDEhd9APLMM2cJbh+IeUH16Ze1QVlQmtmzFHbsiDVRTAyc7gBo+5KNG30+NXzbFU/qkBvTWU6iDaHMY0nHRY1tRMvyBkerG4eDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668118; c=relaxed/simple;
	bh=DD1eQpUxkAPmfZotg9tfN4mZGu06Z/ldU+SXV5KTneo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCqBduRixWxJLHxA2rJjSpGubheypRg7vkI5Zn8G6XaGVKV3DUcJl3MDlqORINZN1YkToIO5CwKXDFvYIwpFOUq8jfFhCIJZFKr4RfJMJCjkxkSLQsh2Au2uNgQJ71yOfBgHJTl90ZueAs4lrlDJ2f77C7l93+fquawkUZELYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kn2cbI94; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71aFx04FBERopiPPtaaAjec9tErJI5QLn4peDvc3p4I=;
	b=Kn2cbI94SX7+qeNgFhqBPVTqayPrXv+hiCCvaa6CXXQMEKEH7C7KpJqu3SSXCWLcuKAFuH
	c2EePwfH5ZmgwZa/QM1zRhZJukeXseAkQsvOJ7AH46svXj2drlXj7F84R+6Oh82VITjimu
	Fwdx/SUHw4w5Ovb5COq0quRSVH1wi8A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-F-R71-2QP0anx8F_m7msPg-1; Wed,
 14 Aug 2024 16:41:49 -0400
X-MC-Unique: F-R71-2QP0anx8F_m7msPg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B0671954B11;
	Wed, 14 Aug 2024 20:41:46 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A276F1955D88;
	Wed, 14 Aug 2024 20:41:39 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/25] netfs: Cancel dirty folios that have no storage destination
Date: Wed, 14 Aug 2024 21:38:42 +0100
Message-ID: <20240814203850.2240469-23-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Kafs wants to be able to cache the contents of directories (and symlinks),
but whilst these are downloaded from the server with the FS.FetchData RPC
op and similar, the same as for regular files, they can't be updated by
FS.StoreData, but rather have special operations (FS.MakeDir, etc.).

Now, rather than redownloading a directory's content after each change made
to that directory, kafs modifies the local blob.  This blob can be saved
out to the cache, and since it's using netfslib, kafs just marks the folios
dirty and lets ->writepages() on the directory take care of it, as for an
regular file.

This is fine as long as there's a cache as although the upload stream is
disabled, there's a cache stream to drive the procedure.  But if the cache
goes away in the meantime, suddenly there's no way do any writes and the
code gets confused, complains "R=%x: No submit" to dmesg and leaves the
dirty folio hanging.

Fix this by just cancelling the store of the folio if neither stream is
active.  (If there's no cache at the time of dirtying, we should just not
mark the folio dirty).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c       | 6 +++++-
 include/trace/events/netfs.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index f7d59f0bb8c2..04e66d587f77 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -400,13 +400,17 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	folio_unlock(folio);
 
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		if (!fscache_resources_valid(&wreq->cache_resources)) {
+		if (!cache->avail) {
 			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
 			netfs_issue_write(wreq, upload);
 			netfs_folio_written_back(folio);
 			return 0;
 		}
 		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
+	} else if (!upload->avail && !cache->avail) {
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
+		netfs_folio_written_back(folio);
+		return 0;
 	} else if (!upload->construct) {
 		trace_netfs_folio(folio, netfs_folio_trace_store);
 	} else {
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 7b26463cb98f..76bd42a96815 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -153,6 +153,7 @@
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
 	EM(netfs_folio_trace_abandon,		"abandon")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
+	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\


