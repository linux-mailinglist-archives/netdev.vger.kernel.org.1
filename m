Return-Path: <netdev+bounces-167478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A13A3A747
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1DB1668B7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847E21B9F6;
	Tue, 18 Feb 2025 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ath3CRFT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164521B9C4
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906582; cv=none; b=t4OGA9hwp3WP/whA4i8h8QRcAv15S4p/vNT4HQhCSJVuDMsoCMp77T1M7JRs50uiVEHm/HrMu9s+o06MtcjlvVvPaE2WwQ5QyqeSuQXsZlBHhBdd1Cv878wkavD/P3jfv8tqCHInPLat87wRTNfUWUQzvcJgoWxzPJAACCOk6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906582; c=relaxed/simple;
	bh=swGB3xGE9Yoh2kRKbPlYsUFSqqbPDflfTARdV/Ubt4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjM5dbeCQSexiiNaYndytALyoqnBMNwgHdbkUXNaKqbWHCYimGt5Y5cQfghIX8kIB7gricXLWFaKFoHYnzykwseXkCsee7NytI4eMl3QDzKzmYmPNI2JEu5vKf8FhtFGqALvZTXgIS1Xc2JduYkaW1sL/RKWdrI4slVZMLTxj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ath3CRFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YaNAwOy0l3tTCLhav17cAtoV5hBrzuMcbhO7CyzKHR8=;
	b=ath3CRFTNLirjh6+x0sM9NcdyGErIG6R9cTnZPsmf3Pnmj33r73aSvdE4oOSXHsu16KOrZ
	g6XjZPOGla1J6IK+EKTcOn4davlxXh4miHeVRNH9JTaHBH7bGEy1AGsGHhSiaKML12T+3f
	K4DQDERDESLuXuCf3IZ0MFKMc64n5fk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-D2-hc7eYN4mzExwpWZUUqQ-1; Tue,
 18 Feb 2025 14:22:57 -0500
X-MC-Unique: D2-hc7eYN4mzExwpWZUUqQ-1
X-Mimecast-MFC-AGG-ID: D2-hc7eYN4mzExwpWZUUqQ_1739906576
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 213F5180087B;
	Tue, 18 Feb 2025 19:22:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1538E180087C;
	Tue, 18 Feb 2025 19:22:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/5] rxrpc, afs: Miscellaneous fixes
Date: Tue, 18 Feb 2025 19:22:43 +0000
Message-ID: <20250218192250.296870-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Here are some miscellaneous fixes for rxrpc and afs:

 (1) In the rxperf test server, make it correctly receive and decode the
     terminal magic cookie.

 (2) In rxrpc, get rid of the peer->mtu_lock as it is not only redundant,
     it now causes a lockdep complaint.

 (3) In rxrpc, fix a lockdep-detected instance where a spinlock is being
     bh-locked whilst irqs are disabled.

 (4) In afs, fix the ref of a server displaced from an afs_server_list
     struct.

 (5) In afs, make afs_server records belonging to a cell take refs on the
     afs_cell record so that the latter doesn't get deleted first when that
     cell is being destroyed.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (5):
  rxrpc: rxperf: Fix missing decoding of terminal magic cookie
  rxrpc: peer->mtu_lock is redundant
  rxrpc: Fix locking issues with the peer record hash
  afs: Fix the server_list to unuse a displaced server rather than
    putting it
  afs: Give an afs_server object a ref on the afs_cell object it points
    to

 fs/afs/server.c            |  3 +++
 fs/afs/server_list.c       |  4 ++--
 include/trace/events/afs.h |  2 ++
 net/rxrpc/ar-internal.h    |  1 -
 net/rxrpc/input.c          |  2 --
 net/rxrpc/peer_event.c     |  9 +--------
 net/rxrpc/peer_object.c    |  5 ++---
 net/rxrpc/rxperf.c         | 12 ++++++++++++
 8 files changed, 22 insertions(+), 16 deletions(-)


