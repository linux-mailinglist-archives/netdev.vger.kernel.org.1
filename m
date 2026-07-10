Return-Path: <netdev+bounces-306663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AmnYDn9GUWrmBgMAu9opvQ
	(envelope-from <netdev+bounces-306663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:22:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DE73DB50
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:22:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="VEZn5F/x";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306663-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306663-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9391030234F7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991F37B409;
	Fri, 10 Jul 2026 19:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB10373C1A
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:22:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711355; cv=none; b=A19ZcXmN4eKhSRBBKYVPE+pJ9VA0CccIEhQ0FQ6pPpelCXueDr9hI0eUvRqznbc4nJsAc9R5CmlH38lsmls9yxgoEqAJCC0F6UKfiKodUbJkDvPnFlgMXMzoQ3jdmvB051cRNwP/6AZFW7pDQ+Et83dLqcXpQfkNXxvbIjEtUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711355; c=relaxed/simple;
	bh=bvX6nXJHrqYkGdtITDq1Wc6yoIdBnBvAVVrgBcr7giU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4pJ3y8ZtPvJTy1Bv2J/63oyyyLbrz1TljHWg148FVg91k/er+hvtuuqwqQ6Fp+9IhUzc19t6kQb5CjIT8PLR0Lr7cBFy0tSUHRrmZOFx8ZEw/Eo49xXogEQ6wdF6fHIM+S2AD+GupUQmrD6BKQTD1zoX+um2Om6MvTFwrZ3ogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEZn5F/x; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M4yaa8YsWwpBlkXyNkBXTvf91tU3gWrqXC4x53Vl0gQ=;
	b=VEZn5F/xGVtnn2UTNm51JXT9CEMEh4hFPS8xPM0rmMNjbIonljZZB5ezHm3tx0AZex4Ld+
	4YEH2T/Wt+VdDnRKJFAzFwYP0Kvoiv+5HZ9T7z1iSLO+2bAX4BF6O16rBplDM58ZX4AJsq
	KAj9gXk4xXvh+ACxo/7ugRunpv38YIc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-EICO7KdrMOW9-HN3u7EIRA-1; Fri,
 10 Jul 2026 15:22:29 -0400
X-MC-Unique: EICO7KdrMOW9-HN3u7EIRA-1
X-Mimecast-MFC-AGG-ID: EICO7KdrMOW9-HN3u7EIRA_1783711348
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F3B919560AA;
	Fri, 10 Jul 2026 19:22:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DCFE1956095;
	Fri, 10 Jul 2026 19:22:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 00/16] rxrpc: Fix CHALLENGE packet handling
Date: Fri, 10 Jul 2026 20:22:02 +0100
Message-ID: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306663-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D1DE73DB50

Here's a fix for AF_RXRPC's CHALLENGE packet handling, addressing an issue
raised by Sashiko[1], plus some miscellaneous fixes found in the process of
fixing this, plus a number of things raised by Sashiko[2][3].

Firstly, the miscellaneous patches:

 (1) Fix a NULL deref in afs_deliver_cb_init_call_back_state3().

 (2) Fix rxrpc_sendmsg so that it doesn't return an error if it queued the
     last packet of a call.  After that point, the error will be returned
     by recvmsg() and returned it twice in two different places may
     complicate userspace cleaning up its own structures.

 (3) Fix a UAF in afs_make_call() whereby it looks at the call after the
     first send (of the request) completes to see if it should make a
     second send (e.g. for FS.StoreData content) - but the call may have
     been freed if the first send wasn't marked MSG_MORE.

 (4) Fix a couple of afs request delivery functions to pass back -EAGAIN if
     insufficient data is yet received.

 (5) Fix afs_fs_fetch_data() to set call->async on calls marked as being
     asynchronous.

 (6) Fix error handling in rxrpc_send_data() for if ->secure_packet()
     returns an error.

 (7) Fix the update of call->pending in rxrpc_send_data() in paths when the
     call lock has been dropped.

 (8) Fix the generation of notifications from rxrpc after call completion.

 (9) Simplify afs_call refcounting to avoid trying to take refs when async
     call notifications come in, and worse trying to get rid of them again
     safely if the notifier work item is already queued.  This is not
     technically a bug fix, but the cleanup made patch 11 easier to handle.

(10) Make afs_put_call() use an enum value to indicate when it happens
     rather than recording the function return address as the return
     address isn't sufficiently unique if functions get inlined or
     tail-called by the compiler.  This is not a bug fix, but it made it
     easier to debug the problem that patch 11 fixes.

(11) Fix another UAF in afs_make_call() whereby the function tries to abort
     a call if the send fails, but the call may get torn down by async
     notification before we get there.

And then there are the patches to fix CHALLENGE packet overqueuing and
simplify RESPONSE packet generation by pre-creating the RxGK application
data up front and passing it in a user key (thereby allowing userspace to
partake).  This is split into five patches:

(12) Add a refcount to the user key payload.

(13) Make the AFS filesystem generate per-server appdata keys.

(14) Pass the appdata from AFS (or userspace) to rxrpc.

(15) Change over to using the appdata key to supply the appdata.

(16) Remove all the OOB stuff.

[!] Note that this entails a significant change in the UAPI for AF_RXRPC,
with the CMSG types and sockopt to support the OOB queuing being removed
and replaced with a new single CMSG type that conveys the user key ID.  I
don't think it likely anyone is using this outside of my kafs-utils
package.

This also involves a change to the user-defined key type, making the
payload refcounted so that it can be accessed and the length read, then a
buffer allocated that will hold it and other data, and then the content
copied.  The problem is that the user is perfectly at liberty to change the
content of a user-defined key (which will RCU-replace the content of the
key), so the length might change when we drop the RCU read lock in order to
allocate.  This could be got around by locking the key->rwsem sharedly, but
that might be able to deadlock part of the rxrpc protocol engine if memory
reclaim occurs.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #2)
- Split the CHALLENGE/RESPONSE fix into smaller patches.
- Fixed more Sashiko-reported bugs[2][3]:
  - Added some more patches to fix some more bugs.
  - Get rid of the AFS_SERVER_FL_APPDATA flag and check the pointer to the
    appdata instead.
  - Rename the appdata key pointer in the AFS_SERVER to reflect this one is
    only for the YFS-RxGK security class.
  - Use barriers when reading or writing the server appdata key pointer.
  - Ignore the appdata for RxNULL, RxKAD and OpenAFS's RxGK for now.
  - Check that sendmsg() with RXRPC_RESPONSE_APPDATA is passed a user key.
  - Check that the appdata key's payload isn't NULL, for instance if it
    gets revoked.
  - Add some error path key_put()s in rxrpc_do_sendmsg().

[1] https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
[2] https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
[3] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

David Howells (16):
  afs: Fix NULL deref in afs_deliver_cb_init_call_back_state3()
  rxrpc: Fix sendmsg to not return an error if last packet queued
  afs: Fix UAF when sending a message
  afs: Fix two delivery functions to pass back -EAGAIN
  afs: Fix afs_fs_fetch_data() to set call->async
  rxrpc: Fix packet encryption error handling
  rxrpc: Fix update of call->tx_pending without holding lock
  rxrpc: Fix generation of notifications after call completion
  afs: Simplify call refcounting
  afs: Make afs_put_call() take trace argument
  afs: Fix UAF in afs_make_call()
  keys: Add refcounting to user-defined key type payload
  afs: Create a server appdata key
  rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle
  rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE
    generation
  rxrpc: Remove OOB challenge/response code

 fs/afs/cm_security.c         | 311 +++++++++++++---------------
 fs/afs/cmservice.c           |  50 ++---
 fs/afs/file.c                |  12 +-
 fs/afs/fs_operation.c        |   2 +-
 fs/afs/fs_probe.c            |   5 +
 fs/afs/fsclient.c            |   7 +-
 fs/afs/internal.h            |  63 +++---
 fs/afs/main.c                |   1 -
 fs/afs/rxrpc.c               | 137 +++++--------
 fs/afs/server.c              |   2 +-
 fs/afs/vl_probe.c            |   2 +-
 fs/afs/vlclient.c            |   8 +-
 include/keys/user-type.h     |   2 +
 include/net/af_rxrpc.h       |  21 +-
 include/trace/events/afs.h   |  46 +++--
 include/trace/events/rxrpc.h |   4 +-
 include/uapi/linux/rxrpc.h   |   6 +-
 net/dns_resolver/dns_key.c   |   1 +
 net/rxrpc/Makefile           |   1 -
 net/rxrpc/af_rxrpc.c         |  49 +----
 net/rxrpc/ar-internal.h      |  23 +--
 net/rxrpc/call_object.c      |   2 +
 net/rxrpc/call_state.c       |  57 +++++-
 net/rxrpc/conn_client.c      |   2 +
 net/rxrpc/conn_event.c       |  68 +-----
 net/rxrpc/key.c              |  37 ++++
 net/rxrpc/oob.c              | 387 -----------------------------------
 net/rxrpc/recvmsg.c          | 126 ++----------
 net/rxrpc/rxgk.c             | 128 +++---------
 net/rxrpc/rxkad.c            |  27 ---
 net/rxrpc/sendmsg.c          | 107 +++++++---
 net/rxrpc/server_key.c       |  40 ----
 security/keys/user_defined.c |  23 ++-
 33 files changed, 546 insertions(+), 1211 deletions(-)
 delete mode 100644 net/rxrpc/oob.c


