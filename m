Return-Path: <netdev+bounces-181561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5AA8586C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EF91B8382D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64267298CCB;
	Fri, 11 Apr 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UchL1O98"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95827CCC2
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365203; cv=none; b=f/tIaKQ1e4SiLj8Th+FnAxRqnDc03QsSDX1jBILEP112NhfhKhgCrtRm1fpaX0Mo5lsG0ydjyXt/X/hxEdiwoMMCEZ4g0e/Rk+s/M6IqMyGstVBEyXa308XrRJabxTVJoJESei4fw0BAiEzOvOQhHkefqu5nZFv/pBs7CVHdEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365203; c=relaxed/simple;
	bh=yKoA9Namj7yNT7c8W3MYzYbO+Ykh9lszAVjUm4BhDSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h063ZVDEz/Xb+EwlI6hq3n/G1bXZCdmSJWeZc57TfuX/STecgRQ+joAQ+7V0rWio5fJkH4uMIo9IqjEguNjz6/Ooc960Thfzp/K4TyfrdgQxycAzXlE7+2XDOQqf+iZPaBHh8ClJT7fN4Q84t1h3f6ZoJ1peq75XWMgW9pWtofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UchL1O98; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xvO7V3S78cYx1yzlKhGUaydwdvq61boBgSY2GyqChTs=;
	b=UchL1O98ul7TlR6Sb15VFMXO3/B0sEeS0bwzhK6lTfm31CMYXOxurRlyxHtocVHgzR1s/V
	//kKUc86coCCjTD6UfDLnRYyJ2/lFb/D0MxOvqj+634zwVesgBg5jc0KUA8yN2lrhXuN6a
	qlHNDnhSu1p8U4vQb7g9klEHlsEX6Os=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-_oP_b7wcODiMSj2sfVuYwg-1; Fri,
 11 Apr 2025 05:53:13 -0400
X-MC-Unique: _oP_b7wcODiMSj2sfVuYwg-1
X-Mimecast-MFC-AGG-ID: _oP_b7wcODiMSj2sfVuYwg_1744365191
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF8171956050;
	Fri, 11 Apr 2025 09:53:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A1B91955BF2;
	Fri, 11 Apr 2025 09:53:06 +0000 (UTC)
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
Subject: [PATCH net-next v3 00/14] rxrpc, afs: Add AFS GSSAPI security class to AF_RXRPC and kafs
Date: Fri, 11 Apr 2025 10:52:45 +0100
Message-ID: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
ver #3)
 - Fixed a leak in an error return path.
 - Added a patch to remove/adjust some __acquires() and __releases()
   annotations to remove some checker warnings[*].
 - Removed the additional __releases() notifications from oob.c.

 [*] Note that lock_sock() and release_sock() should probably have some
     sort of lock annotation so they can be checked.

ver #2)
 - Fix use of %zx instead of %lx.
 - Add a patch to add 'Return:' descriptions into existing kdoc comments.
 - Add 'Return:' descriptions into new kdoc comments.
 - Add a function API ref at the end of rxrpc.rst.

David Howells (14):
  rxrpc: kdoc: Update function descriptions and add link from rxrpc.rst
  rxrpc: Pull out certain app callback funcs into an ops table
  rxrpc: Remove some socket lock acquire/release annotations
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
 net/rxrpc/ar-internal.h            |   82 +-
 net/rxrpc/call_accept.c            |   34 +-
 net/rxrpc/call_object.c            |   24 +-
 net/rxrpc/conn_event.c             |  134 ++-
 net/rxrpc/conn_object.c            |    2 +
 net/rxrpc/insecure.c               |   13 +-
 net/rxrpc/io_thread.c              |   12 +-
 net/rxrpc/key.c                    |  187 ++++
 net/rxrpc/oob.c                    |  379 ++++++++
 net/rxrpc/output.c                 |   60 +-
 net/rxrpc/peer_object.c            |   22 +-
 net/rxrpc/protocol.h               |   20 +
 net/rxrpc/recvmsg.c                |  132 ++-
 net/rxrpc/rxgk.c                   | 1367 ++++++++++++++++++++++++++++
 net/rxrpc/rxgk_app.c               |  285 ++++++
 net/rxrpc/rxgk_common.h            |  139 +++
 net/rxrpc/rxgk_kdf.c               |  288 ++++++
 net/rxrpc/rxkad.c                  |  296 +++---
 net/rxrpc/rxperf.c                 |   78 +-
 net/rxrpc/security.c               |    3 +
 net/rxrpc/sendmsg.c                |   25 +-
 net/rxrpc/server_key.c             |   42 +
 40 files changed, 4272 insertions(+), 245 deletions(-)
 create mode 100644 fs/afs/cm_security.c
 create mode 100644 net/rxrpc/oob.c
 create mode 100644 net/rxrpc/rxgk.c
 create mode 100644 net/rxrpc/rxgk_app.c
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c


