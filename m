Return-Path: <netdev+bounces-171142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C278A4BB2B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140421893CFD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE41F12F6;
	Mon,  3 Mar 2025 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8HUMDRE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045421F0E51
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995375; cv=none; b=j7TFpPkq4/Do6MouwGHTI92rEUooIcKD9BmJUb33WpW8PrmEBJ1IxGeBPUupGm3H7i0YcW6brO5dxkr8O6A6cvQckXaIrx02DXIvppMcbk668Q3Jk6jtIsq9ZTqe+IVjmxIxdjnVfG3eKOIFHv5xA7dVdlDPGQ5llpW34kp12X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995375; c=relaxed/simple;
	bh=aciRXAPVFSFR+GMkrx+q4evyMV3weqQVuOA3GHiwpvA=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=BCX5VGylvdLDFWMgF+gAVvIrZMsJWCC/4rYyshe37Xj11Bm4A4nExztO91TntwrGxuUu1LE004uClROg5AeLNPOYNg5qLix2ltc1qje56HpXGa0rnOCQAflmEsDghh4QAw8xdC1fSJmckncACZgKtFe1NDFbBBHW+RiqjHcoRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8HUMDRE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740995372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lgxwgajyq4P6106FWVM5wzEqLIj/uo0VoFw3+ApJOac=;
	b=c8HUMDREDY2Qg1dHUGKhHr/L2twQIrpAnhL5d5IoyLVl32NTFdig2P4DrdQEHpIZ9kuLGk
	HY0E9Xapwhpmax5uwn2OhD/tNTR67cGhq0V7FdJ4JACvlJIeGQvwFtyzmPDfWccXl/LdSu
	EMyoF5/5bsPSwwv9/lgODNuvZrUXfKc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-PH4J_WTxON2cY-VhhY_7dQ-1; Mon,
 03 Mar 2025 04:49:18 -0500
X-MC-Unique: PH4J_WTxON2cY-VhhY_7dQ-1
X-Mimecast-MFC-AGG-ID: PH4J_WTxON2cY-VhhY_7dQ_1740995357
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED58A190ECDF;
	Mon,  3 Mar 2025 09:49:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6AD319560AA;
	Mon,  3 Mar 2025 09:49:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: David Howells <dhowells@redhat.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL v3] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3761343.1740995350.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Mar 2025 09:49:10 +0000
Message-ID: <3761344.1740995350@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Christian,

Could you pull this into the VFS tree onto a stable branch, replacing the
earlier pull?  The patches were previously posted here as part of a longer
series:

  https://lore.kernel.org/r/20250224234154.2014840-1-dhowells@redhat.com/

This fixes an occasional hang that's only really encountered when rmmod'in=
g
the kafs module, one of the reasons why I'm proposing it for the next merg=
e
window rather than immediate upstreaming.  The changes include:

 (1) Remove the "-o autocell" mount option.  This is obsolete with the
     dynamic root and removing it makes the next patch slightly easier.

 (2) Change how the dynamic root mount is constructed.  Currently, the roo=
t
     directory is (de)populated when it is (un)mounted if there are cells
     already configured and, further, pairs of automount points have to be
     created/removed each time a cell is added/deleted.

     This is changed so that readdir on the root dir lists all the known
     cell automount pairs plus the @cell symlinks and the inodes and
     dentries are constructed by lookup on demand.  This simplifies the
     cell management code.

 (3) A few improvements to the afs_volume tracepoint.

 (4) A few improvements to the afs_server tracepoint.

 (5) Pass trace info into the afs_lookup_cell() function to allow the trac=
e
     log to indicate the purpose of the lookup.

 (6) Remove the 'net' parameter from afs_unuse_cell() as it's superfluous.

 (7) In rxrpc, allow a kernel app (such as kafs) to store a word of
     information on rxrpc_peer records.

 (8) Use the information stored on the rxrpc_peer record to point to the
     afs_server record.  This allows the server address lookup to be done
     away with.

 (9) Simplify the afs_server ref/activity accounting to make each one
     self-contained and not garbage collected from the cell management wor=
k
     item.

(10) Simplify the afs_cell ref/activity accounting to make each one of
     these also self-contained and not driven by a central management work
     item.

     The current code was intended to make it such that a single timer for
     the namespace and one work item per cell could do all the work
     required to maintain these records.  This, however, made for some
     sequencing problems when cleaning up these records.  Further, the
     attempt to pass refs along with timers and work items made getting it
     right rather tricky when the timer or work item already had a ref
     attached and now a ref had to be got rid of.

Thanks,
David

Changes
=3D=3D=3D=3D=3D=3D=3D
ver #3)
 - Fix the fix for an error check of the form "unsigned value < 0".

ver #2)
 - Fix an error check of the form "unsigned value < 0".

Link: https://lore.kernel.org/r//3190716.1740733119@warthog.procyon.org.uk=
/ # v1
Link: https://lore.kernel.org/r//3399677.1740754398@warthog.procyon.org.uk=
/ # v2

---
The following changes since commit 1e15510b71c99c6e49134d756df91069f7d1814=
1:

  Merge tag 'net-6.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/netdev/net (2025-02-27 09:32:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-next-20250303

for you to fetch changes up to 73f77882c18d849cc8a26e5f06af5e6116169aba:

  afs: Simplify cell record handling (2025-03-03 09:44:36 +0000)

----------------------------------------------------------------
afs: Fix ref leak in rmmod

----------------------------------------------------------------
David Howells (10):
      afs: Remove the "autocell" mount option
      afs: Change dynroot to create contents on demand
      afs: Improve afs_volume tracing to display a debug ID
      afs: Improve server refcount/active count tracing
      afs: Make afs_lookup_cell() take a trace note
      afs: Drop the net parameter from afs_unuse_cell()
      rxrpc: Allow the app to store private data on peer structs
      afs: Use the per-peer app data provided by rxrpc
      afs: Fix afs_server ref accounting
      afs: Simplify cell record handling

 fs/afs/addr_list.c         |  50 ++++
 fs/afs/cell.c              | 437 ++++++++++++++------------------
 fs/afs/cmservice.c         |  82 +------
 fs/afs/dir.c               |   5 +-
 fs/afs/dynroot.c           | 484 +++++++++++++++---------------------
 fs/afs/fs_probe.c          |  32 ++-
 fs/afs/fsclient.c          |   4 +-
 fs/afs/internal.h          |  98 ++++----
 fs/afs/main.c              |  16 +-
 fs/afs/mntpt.c             |   5 +-
 fs/afs/proc.c              |  15 +-
 fs/afs/rxrpc.c             |   8 +-
 fs/afs/server.c            | 601 +++++++++++++++++++---------------------=
-----
 fs/afs/server_list.c       |   6 +-
 fs/afs/super.c             |  25 +-
 fs/afs/vl_alias.c          |   7 +-
 fs/afs/vl_rotate.c         |   2 +-
 fs/afs/volume.c            |  15 +-
 include/net/af_rxrpc.h     |   2 +
 include/trace/events/afs.h |  83 ++++---
 net/rxrpc/ar-internal.h    |   1 +
 net/rxrpc/peer_object.c    |  30 ++-
 22 files changed, 904 insertions(+), 1104 deletions(-)


