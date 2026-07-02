Return-Path: <netdev+bounces-304214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jSvWMoR+Rmo/XQsAu9opvQ
	(envelope-from <netdev+bounces-304214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:06:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326EE6F9315
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jRxMl5fZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304214-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304214-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4EB31DEC49
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CED3D9522;
	Thu,  2 Jul 2026 14:49:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FBE381EB3
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:49:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003775; cv=none; b=UypqzUIXAGtCLJ3tUEPXOe+rAbwDZLVKzd45r56NYDDvhEvpFR9qEGUI33R0XHAvYNfS32WSGTfxTUFWvrd1jg1/3AiHnuxfOQR5HfSpF6HX+H0L3Yk6mTULys1PiZ2UtrMVqwJV+8NA87bGhmc96ZYUwgd+GceKxrgUNT2Fx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003775; c=relaxed/simple;
	bh=3x9gBWNhbH7Rnla6zazTj+b8J+M6/MGUd8bwPJf31+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ny/8QjRJdqYpZoKcss9czoWdtOOhZC4vyMKJ4KASm073XGUijJvRRB+naUnl6zBF3sEVZFr3gUOUGXFMdl/Eq3vRADAiVjHt8WIL65M3DA68DCrdlZ/4U38x8kwicgaa4F4L2ZGOWhLalKumhKmHocFx+j2yWRWIxsbNiiH6Nok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRxMl5fZ; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783003773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tpcmol0myQtmD5+iMZ6jdVCv5FlIdT/aZfVghPOeOIg=;
	b=jRxMl5fZ9w1YsxiZSSkkbAo8/I0yWMPw1VWbETf7TWn5xw2zJf9e5pZKJtuJpAV4UhRQ43
	0kqCqFioc6JEinueQTystrEFnNNHvrtxdcc0cV89i75YC1FPcvsmyNLLv/0fI28euMpi+F
	s2ccQetdkzZCVnQXRI9C8tWFQzi0uKA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-tSInzLMiMzibD78urzjAmg-1; Thu,
 02 Jul 2026 10:49:28 -0400
X-MC-Unique: tSInzLMiMzibD78urzjAmg-1
X-Mimecast-MFC-AGG-ID: tSInzLMiMzibD78urzjAmg_1783003766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 301551944A8C;
	Thu,  2 Jul 2026 14:49:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C06D41800611;
	Thu,  2 Jul 2026 14:49:22 +0000 (UTC)
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
Subject: [PATCH net 0/4] rxrpc: Fix CHALLENGE packet handling
Date: Thu,  2 Jul 2026 15:49:14 +0100
Message-ID: <20260702144919.172295-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 326EE6F9315

Here's a fix for AF_RXRPC's CHALLENGE packet handling, addressing an issue
raised by Sashiko[1], plus three fixes for things found or noted along the
way:

 (1) Fix a NULL deref in afs_deliver_cb_init_call_back_state3().

 (2) Fix rxrpc_sendmsg so that it doesn't return an error if it queued the
     last packet of a call.  After that point, the error will be returned
     by recvmsg() and returned it twice in two different places may
     complicate userspace cleaning up its own structures.

 (3) Fix a UAF in afs_make_call().

 (4) Fix CHALLENGE packet overqueuing and simplify RESPONSE packet
     generation by pre-creating the RxGK application data up front and
     passing it in a user key (thereby allowing userspace to partake).
     This allows all the OOB queuing stuff to be deleted.

     [!] Note that this entails a significant change in the UAPI for
     AF_RXRPC, with the CMSG types and sockopt to support the OOB queuing
     being removed and replaced with a new single CMSG type that conveys
     the user key ID.  I don't think it likely anyone is using this outside
     of my kafs-utils package.

     This also involves a change to the user-defined key type, making the
     payload refcounted so that it can be accessed and the length read,
     then a buffer allocated that will hold it and other data, and then the
     content copied.  The problem is that the user is perfectly at liberty
     to change the content of a user-defined key (which will RCU-replace
     the content of the key), so the length might change when we drop the
     RCU read lock in order to allocate.  This could be got around by
     locking the key->rwsem sharedly, but that might be able to deadlock
     part of the rxrpc protocol engine if memory reclaim occurs.

I've posted this as a fix for net/main, but would patch (4) at least be
better going into net-next/main given the amount it changes?

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

[1] https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com

David Howells (4):
  afs: Fix NULL deref in afs_deliver_cb_init_call_back_state3()
  rxrpc: Fix sendmsg to not return an error if last packet queued
  afs: Fix UAF when sending a message
  rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE
    generation

 fs/afs/cm_security.c         | 151 ++++++--------
 fs/afs/cmservice.c           |   3 +-
 fs/afs/fs_probe.c            |   5 +
 fs/afs/internal.h            |  37 ++--
 fs/afs/main.c                |   1 -
 fs/afs/rxrpc.c               |  51 ++---
 fs/afs/server.c              |   2 +-
 include/keys/user-type.h     |   2 +
 include/net/af_rxrpc.h       |  20 +-
 include/trace/events/afs.h   |   7 +-
 include/trace/events/rxrpc.h |   2 -
 include/uapi/linux/rxrpc.h   |   6 +-
 net/dns_resolver/dns_key.c   |   1 +
 net/rxrpc/Makefile           |   1 -
 net/rxrpc/af_rxrpc.c         |  49 +----
 net/rxrpc/ar-internal.h      |  22 +-
 net/rxrpc/call_object.c      |   4 +-
 net/rxrpc/conn_client.c      |   2 +
 net/rxrpc/conn_event.c       |  68 +-----
 net/rxrpc/key.c              |  36 ++++
 net/rxrpc/oob.c              | 387 -----------------------------------
 net/rxrpc/recvmsg.c          |  84 +-------
 net/rxrpc/rxgk.c             | 128 +++---------
 net/rxrpc/rxkad.c            |  27 ---
 net/rxrpc/sendmsg.c          |  26 ++-
 net/rxrpc/server_key.c       |  40 ----
 security/keys/user_defined.c |  23 ++-
 27 files changed, 258 insertions(+), 927 deletions(-)
 delete mode 100644 net/rxrpc/oob.c


