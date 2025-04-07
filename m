Return-Path: <netdev+bounces-179724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8630A7E618
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C033B2FB8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B292066D7;
	Mon,  7 Apr 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7unm9X4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB82063D1
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042305; cv=none; b=gmujRoMZE48ZCmpkf6ObRAOoLxkAcS9pF5bEMplk4f8LSTEExB1JqPVI20Qucfxe6MgvuM2yzN+cdSypQqOsQ/ZossMwVVwB0Me98MDirsgNRIVzAZochbJvc48/nWnBAUguAjNeeCYnqGKOrc3WrBwzZ2mQqU2T0SD2hC6WLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042305; c=relaxed/simple;
	bh=BF93SruOi4SJLs3qYKFVD0YuF6aeAyEuwTkG+AFVMug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMUb1G/YLx/xTAQd5C2Dr5/5dg0uy6stT2e0Hrm8c///jOYDFWP06otFfzyvcgMGsHL6oAgIxSXatX2CMBxCkPDK+i54390IwSu6SWPVziBp8+mVAVKiacbrG6kCqVD1jtnsftI1yLikOnnS874Pl4Vnb/5a97dRQr4FwdfaypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7unm9X4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744042302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4BZS8OzrijhjJ+znuRtZhTpd6m/6rBcT/o0yRbV8pvk=;
	b=e7unm9X4AZAzMnVf5nUq/C3pdGP7wVRfoJ3ZBhmGSy0knGKG6HsVv8XkAVf4Bi8NPGdqtq
	XxNDZAMt59d+tfiS0MEO/GsDWMfcgv/7u/J/tMdwdoNtXqQmc1qa5CQLlefS0gpA91+8gw
	8lqNQmG49z7tD3VqEEdDkgNBSOUk8hs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-H99E9py5NoC5_lZ6coOL2Q-1; Mon,
 07 Apr 2025 12:11:40 -0400
X-MC-Unique: H99E9py5NoC5_lZ6coOL2Q-1
X-Mimecast-MFC-AGG-ID: H99E9py5NoC5_lZ6coOL2Q_1744042299
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0518180025F;
	Mon,  7 Apr 2025 16:11:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBBDE1828A80;
	Mon,  7 Apr 2025 16:11:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 00/13] rxrpc, afs: Add AFS GSSAPI security class to AF_RXRPC and kafs
Date: Mon,  7 Apr 2025 17:11:13 +0100
Message-ID: <20250407161130.1349147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Here's a set of patches to add basic support for the AFS GSSAPI security
class to AF_RXRPC and kafs.  It provides transport security for keys that
match the security index 6 (YFS) for connections to the AFS fileserver and
VL server.

Note that security index 4 (OpenAFS) can also be supported using this, but
it needs more work as it's slightly different.

The patches also provide the ability to secure the callback channel -
connections from the fileserver back to the client that are used to pass
file change notifications, amongst other things.  When challenged by the
fileserver, kafs will generate a token specific to that server and include
it in the RESPONSE packet as the appdata.  The server then extracts this
and uses it to send callback RPC calls back to the client.

It can also be used to provide transport security on the callback channel,
but a further set of patches is required to provide the token and key to
set that up when the client responds to the fileserver's challenge.

This makes use of the previously added crypto-krb5 library that is now
upstream (last commit fc0cf10c04f4).

This series of patches consist of the following parts:

 (0) Update kdoc comments to remove some kdoc builder warnings.

 (1) Push reponding to CHALLENGE packets over to recvmsg() or the kernel
     equivalent so that the application layer can include user-defined
     information in the RESPONSE packet.  In a follow-up patch set, this
     will allow the callback channel to be secured by the AFS filesystem.

 (2) Add the AF_RXRPC RxGK security class that uses a key obtained from the
     AFS GSS security service to do Kerberos 5-based encryption instead of
     pcbc(fcrypt) and pcbc(des).

 (3) Add support for callback channel encryption in kafs.

 (4) Provide the test rxperf server module with some fixed krb5 keys.

David

The patches can be found on this branch also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-next

CHANGES
=======
ver #2)
 - Fix use of %zx instead of %lx.
 - Add a patch to add 'Return:' descriptions into existing kdoc comments.
 - Add 'Return:' descriptions into new kdoc comments.
 - Add a function API ref at the end of rxrpc.rst.

David Howells (13):
  rxrpc: kdoc: Update function descriptions and add link from rxrpc.rst
  rxrpc: Pull out certain app callback funcs into an ops table
  rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE
  rxrpc: Add the security index for yfs-rxgk
  rxrpc: Add YFS RxGK (GSSAPI) security class
  rxrpc: rxgk: Provide infrastructure and key derivation
  rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
  rxrpc: rxgk: Implement connection rekeying
  rxrpc: Allow the app to store private data on peer structs
  rxrpc: Display security params in the afs_cb_call tracepoint
  afs: Use rxgk RESPONSE to pass token for callback channel
  rxrpc: Add more CHALLENGE/RESPONSE packet tracing
  rxrpc: rxperf: Add test RxGK server keys

 Documentation/networking/rxrpc.rst |   15 +
 fs/afs/Kconfig                     |    1 +
 fs/afs/Makefile                    |    1 +
 fs/afs/cm_security.c               |  340 +++++++
 fs/afs/internal.h                  |   20 +
 fs/afs/main.c                      |    1 +
 fs/afs/misc.c                      |   27 +
 fs/afs/rxrpc.c                     |   40 +-
 fs/afs/server.c                    |    2 +
 include/crypto/krb5.h              |    5 +
 include/keys/rxrpc-type.h          |   17 +
 include/net/af_rxrpc.h             |   51 +-
 include/trace/events/afs.h         |   11 +-
 include/trace/events/rxrpc.h       |  163 +++-
 include/uapi/linux/rxrpc.h         |   77 +-
 net/rxrpc/Kconfig                  |   23 +
 net/rxrpc/Makefile                 |    6 +-
 net/rxrpc/af_rxrpc.c               |   93 +-
 net/rxrpc/ar-internal.h            |   78 +-
 net/rxrpc/call_accept.c            |   34 +-
 net/rxrpc/call_object.c            |   22 +-
 net/rxrpc/conn_event.c             |  134 ++-
 net/rxrpc/conn_object.c            |    2 +
 net/rxrpc/insecure.c               |   13 +-
 net/rxrpc/io_thread.c              |   12 +-
 net/rxrpc/key.c                    |  187 ++++
 net/rxrpc/oob.c                    |  381 ++++++++
 net/rxrpc/output.c                 |   60 +-
 net/rxrpc/peer_object.c            |   22 +-
 net/rxrpc/protocol.h               |   20 +
 net/rxrpc/recvmsg.c                |  132 ++-
 net/rxrpc/rxgk.c                   | 1367 ++++++++++++++++++++++++++++
 net/rxrpc/rxgk_app.c               |  285 ++++++
 net/rxrpc/rxgk_common.h            |  139 +++
 net/rxrpc/rxgk_kdf.c               |  287 ++++++
 net/rxrpc/rxkad.c                  |  296 +++---
 net/rxrpc/rxperf.c                 |   78 +-
 net/rxrpc/security.c               |    3 +
 net/rxrpc/sendmsg.c                |   22 +-
 net/rxrpc/server_key.c             |   42 +
 40 files changed, 4268 insertions(+), 241 deletions(-)
 create mode 100644 fs/afs/cm_security.c
 create mode 100644 net/rxrpc/oob.c
 create mode 100644 net/rxrpc/rxgk.c
 create mode 100644 net/rxrpc/rxgk_app.c
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c


