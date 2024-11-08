Return-Path: <netdev+bounces-143362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9A9C22D6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6271F2263A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA21F666F;
	Fri,  8 Nov 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2FRIWSa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB001EBA1A
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086609; cv=none; b=ci2ca24FN/6FfrA0O3VHT/HLgQh/vbNS4wZCXqB0/kSJOuSKNSqO5HkTUGnuqBnwR/bCxDR319Apr6ljcU/BDJ3Zdm4nTa6m0OMc60A7C6K4gHFx4/hDe6kSJwIR3FjH1rCZQJVOsEwuLJ3rEKaL0EvRapXC+s292HbnILD2BgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086609; c=relaxed/simple;
	bh=LTt43wtm7VPIECMUWRe3OxilrdANCva8RQo02rYBc5k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KMdNYZjhOHmKztd6kyEAmIU7p50TkUJy+TqZU24XxlBR4SGyST0o6TmtRSPVs0cCIkmCzYR0nzCOLfxu+FJd94+Cg+9qzXUF/+mpmNsaM28N/24fsIo7IRrceALgK9H73qUeUFCLgTlRmnEGe+LAivQowt74NmMm+BpDZVsiG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2FRIWSa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731086606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwJwM3+z7apLKFV/fpUBCprrM/E8Cp6F04ODxbzFqfw=;
	b=N2FRIWSaQi+G3HvR0bVpVPUkOKSiM9onStV18UwrGGlCiHhZ+HC1QpygZyDwlZfkB9Bft2
	uF8vg0gqyJV8rCmgF6Kv8rNSTSviB+iAQ4c2HKQxv7dmj/j1rO9zHFqyPwH/hRgPy6pJHH
	KZENtEk7N4U7p7VQbSTGOBhLQA/aBLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-jwRKCGCpNXimF2m3kjGVAg-1; Fri,
 08 Nov 2024 12:23:21 -0500
X-MC-Unique: jwRKCGCpNXimF2m3kjGVAg-1
X-Mimecast-MFC-AGG-ID: jwRKCGCpNXimF2m3kjGVAg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E948D195F198;
	Fri,  8 Nov 2024 17:23:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64CE21953882;
	Fri,  8 Nov 2024 17:23:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-24-dhowells@redhat.com>
References: <20241106123559.724888-24-dhowells@redhat.com> <20241106123559.724888-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/33] afs: Use netfslib for directories
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1360666.1731086590.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2024 17:23:10 +0000
Message-ID: <1360667.1731086590@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The attached fix needs folding in across this patch (23), patch 24, patch
29 and patch 31.

David
---
commit 9d4429bc7bb3f2b518d6decd1ca0e99e4d80d58e
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 7 23:46:48 2024 +0000

    afs: Fix handling of signals during readdir
    =

    When a directory is being read, whether or not the dvnode->directory b=
uffer
    pointer is NULL is used to track whether we've checked fscache yet.
    However, if a signal occurs after the buffer being allocated but whils=
t
    we're doing the read, we may end up in an invalid state with ->directo=
ry
    set but no data in the buffer.
    =

    In this state, afs_readdir(), afs_lookup() and afs_d_revalidate() see
    corrupt directory contents leading to a variety of malfunctions.
    =

    Fix this by providing a specific flag to record whether or not we've
    performed a read yet - and, incidentally, sampled fscache - rather tha=
n
    using the value in ->directory instead.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Marc Dionne <marc.dionne@auristor.com>
    cc: linux-afs@lists.infradead.org

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 663a212964d8..b6a202fd9926 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -323,7 +323,7 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct =
file *file)
 	 * haven't read it yet.
 	 */
 	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) &&
-	    dvnode->directory) {
+	    test_bit(AFS_VNODE_DIR_READ, &dvnode->flags)) {
 		ret =3D i_size;
 		goto valid;
 	}
@@ -336,7 +336,7 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct =
file *file)
 		afs_invalidate_cache(dvnode, 0);
 =

 	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) ||
-	    !dvnode->directory) {
+	    !test_bit(AFS_VNODE_DIR_READ, &dvnode->flags)) {
 		trace_afs_reload_dir(dvnode);
 		ret =3D afs_read_single(dvnode, file);
 		if (ret < 0)
@@ -345,6 +345,7 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct =
file *file)
 		// TODO: Trim excess pages
 =

 		set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+		set_bit(AFS_VNODE_DIR_READ, &dvnode->flags);
 	} else {
 		ret =3D i_size;
 	}
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index f6f4b1adc8dc..60a549f1d9c5 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -644,4 +644,5 @@ void afs_mkdir_init_dir(struct afs_vnode *dvnode, stru=
ct afs_vnode *parent_dvnod
 =

 	netfs_single_mark_inode_dirty(&dvnode->netfs.inode);
 	set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+	set_bit(AFS_VNODE_DIR_READ, &dvnode->flags);
 }
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index f5618564b3fc..e9538e91f848 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -39,6 +39,7 @@ void afs_init_new_symlink(struct afs_vnode *vnode, struc=
t afs_operation *op)
 	p =3D kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
 	memcpy(p, op->create.symlink, size);
 	kunmap_local(p);
+	set_bit(AFS_VNODE_DIR_READ, &vnode->flags);
 	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
 }
 =

@@ -60,12 +61,12 @@ const char *afs_get_link(struct dentry *dentry, struct=
 inode *inode,
 =

 	if (!dentry) {
 		/* RCU pathwalk. */
-		if (!vnode->directory || !afs_check_validity(vnode))
+		if (!test_bit(AFS_VNODE_DIR_READ, &vnode->flags) || !afs_check_validity=
(vnode))
 			return ERR_PTR(-ECHILD);
 		goto good;
 	}
 =

-	if (!vnode->directory)
+	if (test_bit(AFS_VNODE_DIR_READ, &vnode->flags))
 		goto fetch;
 =

 	ret =3D afs_validate(vnode, NULL);
@@ -73,13 +74,14 @@ const char *afs_get_link(struct dentry *dentry, struct=
 inode *inode,
 		return ERR_PTR(ret);
 =

 	if (!test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) &&
-	    vnode->directory)
+	    test_bit(AFS_VNODE_DIR_READ, &vnode->flags))
 		goto good;
 =

 fetch:
 	ret =3D afs_read_single(vnode, NULL);
 	if (ret < 0)
 		return ERR_PTR(ret);
+	set_bit(AFS_VNODE_DIR_READ, &vnode->flags);
 =

 good:
 	folio =3D folioq_folio(vnode->directory, 0);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a5da0dd8e9cc..90f407774a9a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -705,6 +705,7 @@ struct afs_vnode {
 #define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/t=
runc-0) */
 #define AFS_VNODE_SILLY_DELETED	9		/* Set if file has been silly-deleted =
*/
 #define AFS_VNODE_MODIFYING	10		/* Set if we're performing a modification=
 op */
+#define AFS_VNODE_DIR_READ	11		/* Set if we've read a dir's contents */
 =

 	struct folio_queue	*directory;	/* Directory contents */
 	struct list_head	wb_keys;	/* List of keys available for writeback */


