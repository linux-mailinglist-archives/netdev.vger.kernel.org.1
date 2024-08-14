Return-Path: <netdev+bounces-118621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC59523F4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923161C21788
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952981CB328;
	Wed, 14 Aug 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRIvkThv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD61DF68C
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668086; cv=none; b=MJYH2sw6TZvdabG6Gil08ShgK5TduYhPOPGzH2X2Xjv8yLYu0UDEbnaa+lDphwnPWpYSRt6qxrIicx6npFpvgEwB9YVvT31MIWlAXjadoosbpl4yV0yqY+qExNWweFTcZCD9AhruDin5v/ZszG3APBFT/z1AkT2AY30R6bASbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668086; c=relaxed/simple;
	bh=2kJCxM72ZbGO1WDhe5FUHbhkLdl4Tf8OOYtkWuf+dgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOoNBAK1lNTe8aEyDVFxRQinjKIDOL911G4IKFKx38MvFqK3ErcnXZG7853uJhhZDXWnzYsIqa6Km4eJQ2QMRxVfNah9GJBLJc1KNLA/b/vUqvZ5qoU6UqhSyFDvVl8KdQMD4H6zd9RgGMcD0LHBL+7RAiSzinUO5nxzPb9lVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRIvkThv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfu/TnsX2YiQImhcvgy6+BH/oHXTJfoVCbcIECxbkG0=;
	b=CRIvkThvM7zimAFOG2u8EyfSYzQeTJdziIw3ZD40+ftld10knuJMi6GcN3p/+fDRRZrtOt
	KEYre5DU1poMShWrenc9hO9fEPPf0hwdZ/5ob9qbjusvZZuzMxLgn1X7jrre6DlOQjAZ8b
	xVJmbYkHaGPuqTf4PMyoKCdOZ1Bjm7E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-7bTnzRmsN_6lVyVNWWDYbg-1; Wed,
 14 Aug 2024 16:41:19 -0400
X-MC-Unique: 7bTnzRmsN_6lVyVNWWDYbg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D4011954B15;
	Wed, 14 Aug 2024 20:41:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEECA300019A;
	Wed, 14 Aug 2024 20:41:10 +0000 (UTC)
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
Subject: [PATCH v2 18/25] afs: Make read subreqs async
Date: Wed, 14 Aug 2024 21:38:38 +0100
Message-ID: <20240814203850.2240469-19-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Perform AFS read subrequests in a work item rather than in the calling
thread.  For normal buffered reads, this will allow the calling thread to
copy data from the pagecache to the application at the same time as the
demarshalling thread is shovelling data from skbuffs into the pagecache.

This will also allow the RA mark to trigger a new read before we've
finished shovelling the data from the current one.

Note: This would be a bit safer if the FS.FetchData RPC ops returned the
metadata (including the data version number) before returning the data.
This would allow me to flush the pagecache before installing the new data.

In future, it may be possible to asynchronously flush the pagecache either
side of the region being read.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index ec1be0091fdb..5a9d16848ad5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -305,8 +305,9 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return afs_do_sync_operation(op);
 }
 
-static void afs_issue_read(struct netfs_io_subrequest *subreq)
+static void afs_read_worker(struct work_struct *work)
 {
+	struct netfs_io_subrequest *subreq = container_of(work, struct netfs_io_subrequest, work);
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct afs_read *fsreq;
 
@@ -325,6 +326,12 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 	afs_put_read(fsreq);
 }
 
+static void afs_issue_read(struct netfs_io_subrequest *subreq)
+{
+	INIT_WORK(&subreq->work, afs_read_worker);
+	queue_work(system_long_wq, &subreq->work);
+}
+
 static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 {
 	struct afs_vnode *vnode = AFS_FS_I(folio->mapping->host);


