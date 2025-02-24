Return-Path: <netdev+bounces-169242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FBA43118
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B8616ACE5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED7A20B814;
	Mon, 24 Feb 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmYYiaDG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C01C8602
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440530; cv=none; b=U35glny3T6s7ttpFa6xJSLPcq3rwijWMNh1MhMtq87Unuylm3ZE/V17D4e5kFl4E4IK+Sdt9y2jUMIGIyGI1kpjM7z2jgwPfBjw5Gl0/IaamXNSN6H2SuAFZWUHQkKVPlgoTKWY50VdR7Jc7/cmr+5eE9Pw23evKtiMmOBve7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440530; c=relaxed/simple;
	bh=16zL/XF6wfUSDCzrCVzmUwXhl5SdLyuBXgX+5oIZkWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixudhOQwIYy1FAtqel7B9uZcvaiGcXjhksnYfdxHvV5IcTQqH+8x25ZfhE5POBn8E/79401DcKlr9EzkjZo2fZ09X6z6isU6b2YvaKGfNthLN++Dng3QkwwPYh7zcjMX5g65bBM9B6zU6f+r5Pma/61/g5qqrXB7CJKnMCVsEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmYYiaDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=93uY6gagY63USM5e5KI9PRClg9kYawtsBZpalOdSzx0=;
	b=PmYYiaDGmwPhkupT6IwGWxcPaVfOngREktU8QhtdSA1x9fKMXeAh1LPg0RC+o9VcBKC9AQ
	XLm5/9rkt2mzrmNIVW3cn+tPnO7AdZxR49llpI2/qR0lwyG6j1a89J2qNPjk+5E8YEYP1c
	sNuSlHnVragTn0FWKIRUsNq6xVwQ7bI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-j6czRUGhMUiy3r8HCtlU9Q-1; Mon,
 24 Feb 2025 18:42:02 -0500
X-MC-Unique: j6czRUGhMUiy3r8HCtlU9Q-1
X-Mimecast-MFC-AGG-ID: j6czRUGhMUiy3r8HCtlU9Q_1740440520
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88B08196E078;
	Mon, 24 Feb 2025 23:42:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6DA81800945;
	Mon, 24 Feb 2025 23:41:57 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Date: Mon, 24 Feb 2025 23:41:37 +0000
Message-ID: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Here are some patches that fix an occasional hang that's only really
encountered when rmmod'ing the kafs module.  Arguably, this could also go
through the vfs tree, but I have a bunch more primarily crypto and rxrpc
patches that need to go through net-next on top of this[1].

Now, at the beginning of this set, I've included five fix patches that are
already committed to the net/main branch but that need to be applied first,
but haven't made their way into net-next/main or upstream as yet:

    rxrpc: rxperf: Fix missing decoding of terminal magic cookie
    rxrpc: peer->mtu_lock is redundant
    rxrpc: Fix locking issues with the peer record hash
    afs: Fix the server_list to unuse a displaced server rather than putting it
    afs: Give an afs_server object a ref on the afs_cell object it points to

On top of those, I have:

 (1) Remove the "-o autocell" mount option.  This is obsolete with the
     dynamic root and removing it makes the next patch slightly easier.

 (2) Change how the dynamic root mount is constructed.  Currently, the root
     directory is (de)populated when it is (un)mounted if there are cells
     already configured and, further, pairs of automount points have to be
     created/removed each time a cell is added/deleted.

     This is changed so that readdir on the root dir lists all the known
     cell automount pairs plus the @cell symlinks and the inodes and
     dentries are constructed by lookup on demand.  This simplifies the
     cell management code.

 (3) A few improvements to the afs_volume tracepoint.

 (4) A few improvements to the afs_server tracepoint.

 (5) Pass trace info into the afs_lookup_cell() function to allow the trace
     log to indicate the purpose of the lookup.

 (6) Remove the 'net' parameter from afs_unuse_cell() as it's superfluous.

 (7) In rxrpc, allow a kernel app (such as kafs) to store a word of
     information on rxrpc_peer records.

 (8) Use the information stored on the rxrpc_peer record to point to the
     afs_server record.  This allows the server address lookup to be done
     away with.

 (9) Simplify the afs_server ref/activity accounting to make each one
     self-contained and not garbage collected from the cell management work
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

David

The patches can be found on this branch also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-next

Link: http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=crypto-krb5 [1]

David Howells (15):
  rxrpc: rxperf: Fix missing decoding of terminal magic cookie
  rxrpc: peer->mtu_lock is redundant
  rxrpc: Fix locking issues with the peer record hash
  afs: Fix the server_list to unuse a displaced server rather than
    putting it
  afs: Give an afs_server object a ref on the afs_cell object it points
    to
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

 fs/afs/addr_list.c         |  50 +++
 fs/afs/cell.c              | 436 +++++++++++----------------
 fs/afs/cmservice.c         |  82 +----
 fs/afs/dir.c               |   5 +-
 fs/afs/dynroot.c           | 484 ++++++++++++-----------------
 fs/afs/fs_probe.c          |  32 +-
 fs/afs/fsclient.c          |   4 +-
 fs/afs/internal.h          |  98 +++---
 fs/afs/main.c              |  16 +-
 fs/afs/mntpt.c             |   5 +-
 fs/afs/proc.c              |  15 +-
 fs/afs/rxrpc.c             |   8 +-
 fs/afs/server.c            | 602 ++++++++++++++++---------------------
 fs/afs/server_list.c       |   6 +-
 fs/afs/super.c             |  25 +-
 fs/afs/vl_alias.c          |   7 +-
 fs/afs/vl_rotate.c         |   2 +-
 fs/afs/volume.c            |  15 +-
 include/net/af_rxrpc.h     |   2 +
 include/trace/events/afs.h |  85 +++---
 net/rxrpc/ar-internal.h    |   2 +-
 net/rxrpc/input.c          |   2 -
 net/rxrpc/peer_event.c     |   9 +-
 net/rxrpc/peer_object.c    |  35 ++-
 net/rxrpc/rxperf.c         |  12 +
 25 files changed, 922 insertions(+), 1117 deletions(-)


