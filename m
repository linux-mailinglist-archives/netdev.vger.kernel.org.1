Return-Path: <netdev+bounces-172363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D88A545FE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920427A339B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABCD2080C5;
	Thu,  6 Mar 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWHamFQK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422952080E8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252374; cv=none; b=kQfJGLEvy5whSedVe8UwOCFsocySDOLYTU21gK4+yabz/HSo67VbbKAW5p2pCwKqMAms2qD9aN85z5P9Oqd5xyWXGzfJGl/O11bKzR3OamXYBE82caOXrB+zOuM71aNVYNW02L4h07Exf+LHJDrIdWK8B2DCbkAWXlbnJHMQ1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252374; c=relaxed/simple;
	bh=mSmxSodve0PlbUHGBdbSXfSGjnqU4KNXXxkLRgpJjd8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rf7UawZdLO5zKNyMufzcjxYU0ar7aPYBYpB8rp1Suv+9GBpf3xGF/Q6zrXdk/mQkeW6cBSUpUV54hetfHug0TmY1hGBoMgjq9JChTSs1y/w6hGRlovtiXtXCh203/A1zHwf+Lh0y/7xtAnfrR5cmh40LbOWTySjkIxrtywXioV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWHamFQK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741252371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLLdr9AqfAd99MzyxSvOzi/mUQAgoq76kZjDdYfTJYM=;
	b=RWHamFQKZQWHIslSEoxyChKjTgy0gz/d6AnIKyM2Ic8HMNS6VYsENpYGxke+aW4E8sTuAD
	y0az+fhtSVliOfJxH8KRFTbtl2KzNzH8pOAx6foYlQZ+VdHdjd5n8XGu2897QYRX2Jr7zw
	2p7osoPxVCPEdJsBpz7owXfBwaNr9/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-pSKpUaHrPQWvv75Yu9GcHw-1; Thu,
 06 Mar 2025 04:12:47 -0500
X-MC-Unique: pSKpUaHrPQWvv75Yu9GcHw-1
X-Mimecast-MFC-AGG-ID: pSKpUaHrPQWvv75Yu9GcHw_1741252366
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6988C18001F8;
	Thu,  6 Mar 2025 09:12:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 133A418009BC;
	Thu,  6 Mar 2025 09:12:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3761344.1740995350@warthog.procyon.org.uk>
References: <3761344.1740995350@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66440.1741252359.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Mar 2025 09:12:39 +0000
Message-ID: <66441.1741252359@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Al spotted another bug (fix below).  Subject to his okaying of the patch, =
I'll
fold it down and ask for a repull.

David
---
afs: Fix afs_atcell_get_link() to handle RCU pathwalk

The ->get_link() method may be entered under RCU pathwalk conditions (in
which case, the dentry pointer is NULL).  This is not taken account of by
afs_atcell_get_link() and lockdep will complain when it tries to lock an
rwsem.

Fix this by marking net->ws_cell as __rcu and using RCU access macros on i=
t
and by making afs_atcell_get_link() just return a pointer to the name in
RCU pathwalk without taking net->cells_lock or a ref on the cell as RCU
will protect the name storage (the cell is already freed via call_rcu()).

Reported-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/afs/cell.c     |   11 ++++++-----
 fs/afs/dynroot.c  |   21 +++++++++++++++++----
 fs/afs/internal.h |    2 +-
 fs/afs/proc.c     |    2 +-
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 4ca713d3862c..0168bbf53fe0 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -57,7 +57,8 @@ static struct afs_cell *afs_find_cell_locked(struct afs_=
net *net,
 		return ERR_PTR(-ENAMETOOLONG);
 =

 	if (!name) {
-		cell =3D net->ws_cell;
+		cell =3D rcu_dereference_protected(net->ws_cell,
+						 lockdep_is_held(&net->cells_lock));
 		if (!cell)
 			return ERR_PTR(-EDESTADDRREQ);
 		goto found;
@@ -394,8 +395,8 @@ int afs_cell_init(struct afs_net *net, const char *roo=
tcell)
 =

 	/* install the new cell */
 	down_write(&net->cells_lock);
-	old_root =3D net->ws_cell;
-	net->ws_cell =3D new_root;
+	old_root =3D rcu_replace_pointer(net->ws_cell, new_root,
+				       lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
 =

 	afs_unuse_cell(old_root, afs_cell_trace_unuse_ws);
@@ -869,8 +870,8 @@ void afs_cell_purge(struct afs_net *net)
 	_enter("");
 =

 	down_write(&net->cells_lock);
-	ws =3D net->ws_cell;
-	net->ws_cell =3D NULL;
+	ws =3D rcu_replace_pointer(net->ws_cell, NULL,
+				 lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
 	afs_unuse_cell(ws, afs_cell_trace_unuse_ws);
 =

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 0b66865e3535..9732a1e17db3 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -210,12 +210,23 @@ static const char *afs_atcell_get_link(struct dentry=
 *dentry, struct inode *inod
 	const char *name;
 	bool dotted =3D vnode->fid.vnode =3D=3D 3;
 =

-	if (!net->ws_cell)
+	if (!dentry) {
+		/* We're in RCU-pathwalk. */
+		cell =3D rcu_dereference(net->ws_cell);
+		if (dotted)
+			name =3D cell->name - 1;
+		else
+			name =3D cell->name;
+		/* Shouldn't need to set a delayed call. */
+		return name;
+	}
+
+	if (!rcu_access_pointer(net->ws_cell))
 		return ERR_PTR(-ENOENT);
 =

 	down_read(&net->cells_lock);
 =

-	cell =3D net->ws_cell;
+	cell =3D rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->c=
ells_lock));
 	if (dotted)
 		name =3D cell->name - 1;
 	else
@@ -324,12 +335,14 @@ static int afs_dynroot_readdir(struct file *file, st=
ruct dir_context *ctx)
 		return 0;
 =

 	if (ctx->pos =3D=3D 2) {
-		if (net->ws_cell && !dir_emit(ctx, "@cell", 5, 2, DT_LNK))
+		if (rcu_access_pointer(net->ws_cell) &&
+		    !dir_emit(ctx, "@cell", 5, 2, DT_LNK))
 			return 0;
 		ctx->pos =3D 3;
 	}
 	if (ctx->pos =3D=3D 3) {
-		if (net->ws_cell && !dir_emit(ctx, ".@cell", 6, 3, DT_LNK))
+		if (rcu_access_pointer(net->ws_cell) &&
+		    !dir_emit(ctx, ".@cell", 6, 3, DT_LNK))
 			return 0;
 		ctx->pos =3D 4;
 	}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index addce2f03562..440b0e731093 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -288,7 +288,7 @@ struct afs_net {
 	/* Cell database */
 	struct rb_root		cells;
 	struct idr		cells_dyn_ino;	/* cell->dynroot_ino mapping */
-	struct afs_cell		*ws_cell;
+	struct afs_cell __rcu	*ws_cell;
 	atomic_t		cells_outstanding;
 	struct rw_semaphore	cells_lock;
 	struct mutex		cells_alias_lock;
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 0af94c846504..9d4df9e4562b 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -207,7 +207,7 @@ static int afs_proc_rootcell_show(struct seq_file *m, =
void *v)
 =

 	net =3D afs_seq2net_single(m);
 	down_read(&net->cells_lock);
-	cell =3D net->ws_cell;
+	cell =3D rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->c=
ells_lock));
 	if (cell)
 		seq_printf(m, "%s\n", cell->name);
 	up_read(&net->cells_lock);


