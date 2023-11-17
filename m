Return-Path: <netdev+bounces-48833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F6B7EFA9F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684B81C20B79
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7F5A117;
	Fri, 17 Nov 2023 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq7zG7uw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B02733
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 13:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wytdEGMiDkVc14tR/9rfg5yMQrHZM30J/9oi3ehTfaw=;
	b=Aq7zG7uw1IqZN9zgYBX4uO3rSmpEjyBiOrIok+X5XEA2pXiRBx1cKrAgxJI/W475sf+JZe
	lv7/UEZ7zXLRVnr1QDbWWdYFi9EcU6Z1R4MBAH6grXwNgon0dpRtZ8Z16DeaC3fIw9hw4B
	s1OMBKMIJlIBiJ6VJUS81huOl4cleXU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-0OIdyLFiNPymhSR_8S1xlg-1; Fri,
 17 Nov 2023 16:18:52 -0500
X-MC-Unique: 0OIdyLFiNPymhSR_8S1xlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F6E13C0C48C;
	Fri, 17 Nov 2023 21:18:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80EF91121306;
	Fri, 17 Nov 2023 21:18:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v2 47/51] cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
Date: Fri, 17 Nov 2023 21:15:39 +0000
Message-ID: <20231117211544.1740466-48-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c so that
they are colocated with similar functions rather than being split with
cifsfs.c.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c | 55 ------------------------------------------
 fs/smb/client/cifsfs.h |  2 ++
 fs/smb/client/file.c   | 53 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index c7d8251c28d5..439473aff211 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -982,61 +982,6 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	return root;
 }
 
-
-static ssize_t
-cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-{
-	ssize_t rc;
-	struct inode *inode = file_inode(iocb->ki_filp);
-
-	if (iocb->ki_flags & IOCB_DIRECT)
-		return cifs_user_readv(iocb, iter);
-
-	rc = cifs_revalidate_mapping(inode);
-	if (rc)
-		return rc;
-
-	return generic_file_read_iter(iocb, iter);
-}
-
-static ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct cifsInodeInfo *cinode = CIFS_I(inode);
-	ssize_t written;
-	int rc;
-
-	if (iocb->ki_filp->f_flags & O_DIRECT) {
-		written = cifs_user_writev(iocb, from);
-		if (written > 0 && CIFS_CACHE_READ(cinode)) {
-			cifs_zap_mapping(inode);
-			cifs_dbg(FYI,
-				 "Set no oplock for inode=%p after a write operation\n",
-				 inode);
-			cinode->oplock = 0;
-		}
-		return written;
-	}
-
-	written = cifs_get_writer(cinode);
-	if (written)
-		return written;
-
-	written = generic_file_write_iter(iocb, from);
-
-	if (CIFS_CACHE_WRITE(CIFS_I(inode)))
-		goto out;
-
-	rc = filemap_fdatawrite(inode->i_mapping);
-	if (rc)
-		cifs_dbg(FYI, "cifs_file_write_iter: %d rc on %p inode\n",
-			 rc, inode);
-
-out:
-	cifs_put_writer(cinode);
-	return written;
-}
-
 static loff_t cifs_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct cifsFileInfo *cfile = file->private_data;
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 3adea10aa9da..28c41c449205 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -100,6 +100,8 @@ extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
+ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 extern int cifs_flock(struct file *pfile, int cmd, struct file_lock *plock);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 36128a39e417..5ecbda31ba85 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4583,6 +4583,59 @@ ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
 	return __cifs_readv(iocb, to, false);
 }
 
+ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	ssize_t rc;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return cifs_user_readv(iocb, iter);
+
+	rc = cifs_revalidate_mapping(inode);
+	if (rc)
+		return rc;
+
+	return generic_file_read_iter(iocb, iter);
+}
+
+ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct cifsInodeInfo *cinode = CIFS_I(inode);
+	ssize_t written;
+	int rc;
+
+	if (iocb->ki_filp->f_flags & O_DIRECT) {
+		written = cifs_user_writev(iocb, from);
+		if (written > 0 && CIFS_CACHE_READ(cinode)) {
+			cifs_zap_mapping(inode);
+			cifs_dbg(FYI,
+				 "Set no oplock for inode=%p after a write operation\n",
+				 inode);
+			cinode->oplock = 0;
+		}
+		return written;
+	}
+
+	written = cifs_get_writer(cinode);
+	if (written)
+		return written;
+
+	written = generic_file_write_iter(iocb, from);
+
+	if (CIFS_CACHE_WRITE(CIFS_I(inode)))
+		goto out;
+
+	rc = filemap_fdatawrite(inode->i_mapping);
+	if (rc)
+		cifs_dbg(FYI, "cifs_file_write_iter: %d rc on %p inode\n",
+			 rc, inode);
+
+out:
+	cifs_put_writer(cinode);
+	return written;
+}
+
 ssize_t
 cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 {


