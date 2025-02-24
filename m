Return-Path: <netdev+bounces-169248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CD7A4312E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EAB3BB3CF
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9AF20E6FD;
	Mon, 24 Feb 2025 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PylwmiKG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDB20F079
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440555; cv=none; b=MuN+seAzHKcesm9vAhPd7X9ebAmPbhGNfTb8Y7/JxkO6UMrsSZn+srkO29v4enPf+0D9PJyHN+p9W0ZaND8wQqK/Xz0aEJ4NLdQMm7OUpcWGy8AHfuQaC5IObC5jCZD1c/J8qvYt9ED9GXBgBqTOB4oIFdfJ/JoPlgB6ljpXtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440555; c=relaxed/simple;
	bh=GdbljZFNj7POPRFhKVaSUpADd+7BpiTUNmm49Xp9Ki4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoqP0MTkD3HZKfSuqJNdJObyC1eEhcBbPHBBB20amEaRP33U0GX4VFbqOcZCVhnLhbPkNsRtvXFYaOEFRBmYLfZhEOvn5Lgqpr5NqxBL8n6FnOwMDmUx27QInN0niJFjRJri3WJXF5rjen2OP77RA9P0ZZessD0mUxItdIaq6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PylwmiKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv/5i8PhIxgYjeghwWkBeRPJ7ZuuG8uq4ln7l4W9+kw=;
	b=PylwmiKGSBUA/1PnUp67lbI9jAw8mKo/cRpBUsHJdcgurzTai+HBM/LNudnz3bKWnjCIKo
	0V8urV02rUb9jT++55rc3uV0DEQgKcj6Sbk9y73/iYMM0AF5zPgT2G67wO/gNZ+mgCwDlT
	kxnrY5dS6N9CKBKFmk25Yv9ypjBekKQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-oGPOxP_TMyy4TZCd_9iL-w-1; Mon,
 24 Feb 2025 18:42:29 -0500
X-MC-Unique: oGPOxP_TMyy4TZCd_9iL-w-1
X-Mimecast-MFC-AGG-ID: oGPOxP_TMyy4TZCd_9iL-w_1740440548
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 503BF1979057;
	Mon, 24 Feb 2025 23:42:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DBAC300018D;
	Mon, 24 Feb 2025 23:42:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 06/15] afs: Remove the "autocell" mount option
Date: Mon, 24 Feb 2025 23:41:43 +0000
Message-ID: <20250224234154.2014840-7-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
References: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove the "autocell" mount option.  It was an attempt to do automounting
of arbitrary cells based on what the user looked up but within the root
directory of a mounted volume.  This isn't really the right thing to do,
and using the "dyn" mount option to get the dynamic root is the right way
to do it.  The kafs-client package uses "-o dyn" when mounting /afs, so it
should be safe to drop "-o autocell".

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
 fs/afs/dir.c      | 5 ++---
 fs/afs/dynroot.c  | 5 +----
 fs/afs/internal.h | 2 --
 fs/afs/super.c    | 5 -----
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 02cbf38e1a77..9f62b8938350 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1004,9 +1004,8 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry);
 	if (inode == ERR_PTR(-ENOENT))
-		inode = afs_try_auto_mntpt(dentry, dir);
-
-	if (!IS_ERR_OR_NULL(inode))
+		inode = NULL;
+	else if (!IS_ERR_OR_NULL(inode))
 		fid = AFS_FS_I(inode)->fid;
 
 	_debug("splice %p", dentry->d_inode);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d8bf52f77d93..bdc86dedd964 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -155,7 +155,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
  * Try to auto mount the mountpoint with pseudo directory, if the autocell
  * operation is setted.
  */
-struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
+static struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 {
 	struct afs_vnode *vnode = AFS_FS_I(dir);
 	struct inode *inode;
@@ -164,9 +164,6 @@ struct inode *afs_try_auto_mntpt(struct dentry *dentry, struct inode *dir)
 	_enter("%p{%pd}, {%llx:%llu}",
 	       dentry, dentry, vnode->fid.vid, vnode->fid.vnode);
 
-	if (!test_bit(AFS_VNODE_AUTOCELL, &vnode->flags))
-		goto out;
-
 	ret = afs_probe_cell_name(dentry);
 	if (ret < 0)
 		goto out;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 90f407774a9a..be9d5b9cc7f6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -700,7 +700,6 @@ struct afs_vnode {
 #define AFS_VNODE_ZAP_DATA	3		/* set if vnode's data should be invalidated */
 #define AFS_VNODE_DELETED	4		/* set if vnode deleted on server */
 #define AFS_VNODE_MOUNTPOINT	5		/* set if vnode is a mountpoint symlink */
-#define AFS_VNODE_AUTOCELL	6		/* set if Vnode is an auto mount point */
 #define AFS_VNODE_PSEUDODIR	7 		/* set if Vnode is a pseudo directory */
 #define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/trunc-0) */
 #define AFS_VNODE_SILLY_DELETED	9		/* Set if file has been silly-deleted */
@@ -1111,7 +1110,6 @@ extern int afs_silly_iput(struct dentry *, struct inode *);
 extern const struct inode_operations afs_dynroot_inode_operations;
 extern const struct dentry_operations afs_dynroot_dentry_operations;
 
-extern struct inode *afs_try_auto_mntpt(struct dentry *, struct inode *);
 extern int afs_dynroot_mkdir(struct afs_net *, struct afs_cell *);
 extern void afs_dynroot_rmdir(struct afs_net *, struct afs_cell *);
 extern int afs_dynroot_populate(struct super_block *);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index a9bee610674e..2f18aa8e2806 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -194,8 +194,6 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 
 	if (as->dyn_root)
 		seq_puts(m, ",dyn");
-	if (test_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(d_inode(root))->flags))
-		seq_puts(m, ",autocell");
 	switch (as->flock_mode) {
 	case afs_flock_mode_unset:	break;
 	case afs_flock_mode_local:	p = "local";	break;
@@ -478,9 +476,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (ctx->autocell || as->dyn_root)
-		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
-
 	ret = -ENOMEM;
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)


