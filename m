Return-Path: <netdev+bounces-92471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854AF8B77D6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C511F2254A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D817334D;
	Tue, 30 Apr 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W24cxmfk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4D173328
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485674; cv=none; b=ea1Bdxq7w8jgwkvMzy0NrDRVwDTI186xGk5lbLeTD7eO25UqLqUR4+SxKv/OsAvbtLiUhLRg9cw3giI/zgKRbdqWbcUNjZcKt87J/ApupncwAZh50oRU11wHyS19NwvomJ19TkYoz3KCdGM2Z1eJ0waXxLTUaI+umXmZUlJX4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485674; c=relaxed/simple;
	bh=ARhpxIXoeLR1ngpuAVV3Ez9EqVtZ9SlP4nibSX43Umk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM2H0JNjglZ3KgkjBQ4Y/NcE9FwlSBPuQXQXoPLQx0kjccXp7qTffTHE16frXu5kjNzSQgiYHc9eHvmhSNDs++0QbdpWN2bVebLN8KieKt4QcH7gI1Dw56A248cnMwXmkH64udiMOIRaPHS14bkdhDxV64mOPcUHPT1V1Jh7vFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W24cxmfk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVvsQkYCcJVRpP2m+QZDwQmmWSsKMODgUlfWruXZbkI=;
	b=W24cxmfk7H7b11ZBJbEaPgOzQHwnPp7O3Cu0/sHm+IpDMdKAISVSqd59P8MkeVE0wO+VOM
	SNjgaBalsodR7J7joZyLufggO5rHL/oSCy1XT7UwTcTx2gBFLNVwLU1n+xSHvrF82fzdvl
	q9VbsckCS1rJ8juXgzi3UklFh9YXMLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-zRMsxZfENTaJb65jT9Kr8g-1; Tue, 30 Apr 2024 10:01:09 -0400
X-MC-Unique: zRMsxZfENTaJb65jT9Kr8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9CEC830D37;
	Tue, 30 Apr 2024 14:01:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71CEA1121313;
	Tue, 30 Apr 2024 14:01:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
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
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v2 01/22] netfs: Update i_blocks when write committed to pagecache
Date: Tue, 30 Apr 2024 15:00:32 +0100
Message-ID: <20240430140056.261997-2-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Update i_blocks when i_size is updated when we finish making a write to the
pagecache to reflect the amount of space we think will be consumed.

This maintains cifs commit dbfdff402d89854126658376cbcb08363194d3cd ("smb3:
update allocation size more accurately on write completion") which would
otherwise be removed by the cifs part of the netfs writeback rewrite.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c | 45 +++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 267b622d923b..f7455a579f21 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -130,6 +130,37 @@ static struct folio *netfs_grab_folio_for_write(struct address_space *mapping,
 				   mapping_gfp_mask(mapping));
 }
 
+/*
+ * Update i_size and estimate the update to i_blocks to reflect the additional
+ * data written into the pagecache until we can find out from the server what
+ * the values actually are.
+ */
+static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
+				loff_t i_size, loff_t pos, size_t copied)
+{
+	blkcnt_t add;
+	size_t gap;
+
+	if (ctx->ops->update_i_size) {
+		ctx->ops->update_i_size(inode, pos);
+		return;
+	}
+
+	i_size_write(inode, pos);
+#if IS_ENABLED(CONFIG_FSCACHE)
+	fscache_update_cookie(ctx->cache, NULL, &pos);
+#endif
+
+	gap = SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
+	if (copied > gap) {
+		add = DIV_ROUND_UP(copied - gap, SECTOR_SIZE);
+
+		inode->i_blocks = min_t(blkcnt_t,
+					DIV_ROUND_UP(pos, SECTOR_SIZE),
+					inode->i_blocks + add);
+	}
+}
+
 /**
  * netfs_perform_write - Copy data into the pagecache.
  * @iocb: The operation parameters
@@ -351,18 +382,10 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		trace_netfs_folio(folio, trace);
 
 		/* Update the inode size if we moved the EOF marker */
-		i_size = i_size_read(inode);
 		pos += copied;
-		if (pos > i_size) {
-			if (ctx->ops->update_i_size) {
-				ctx->ops->update_i_size(inode, pos);
-			} else {
-				i_size_write(inode, pos);
-#if IS_ENABLED(CONFIG_FSCACHE)
-				fscache_update_cookie(ctx->cache, NULL, &pos);
-#endif
-			}
-		}
+		i_size = i_size_read(inode);
+		if (pos > i_size)
+			netfs_update_i_size(ctx, inode, i_size, pos, copied);
 		written += copied;
 
 		if (likely(!wreq)) {


