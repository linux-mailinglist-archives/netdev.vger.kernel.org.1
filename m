Return-Path: <netdev+bounces-301721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1IQ9MhAIPGqriwgAu9opvQ
	(envelope-from <netdev+bounces-301721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:38:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24F6C004E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=a4VgV1Ql;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301721-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301721-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1958D30160C5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E463254BD;
	Wed, 24 Jun 2026 16:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D6321420
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:38:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319113; cv=none; b=oR4neVp/pn8xAuoYPbCF9MpCAObqJzMkA3tkk3liv19gwfx0KvneYU6DBJyOpX0qov0D4Ezgu4zNPnkb8/bKD3eWTZegcf5VlBzphTV02vpUtWbTeECeub+Hp/XP4etJL25S76zHdDtN774uM26IwlOk80Bik1gLxlVZTR6Ea7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319113; c=relaxed/simple;
	bh=drQd0HYuz9vuIHkJo/9JWypWO3eGbRn4OysFQXbtVJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKIgFFiN2414N9E7ETjBL50HFEylctkxEP29znyjYt5/jnWM5I7iHf1olYyTcgsgGmKzYAUde2ese1g9cd/4Xzy3EvMR88RVimbR/mpTPkoABOiAT2jbYQmreBNSWsUXBjeesA+TbFCAncrBZ1QlBKsqBNceL6IpyXYm+ic2j3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4VgV1Ql; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KJzpZVivU+zmX8PaF3iP8LGOQH9txCF0/l8aRP/jb5I=;
	b=a4VgV1QluRQz1oHHrZ47llDMybqIw6a9FEOqmw7mNeTJt7t+pxD4mScQXboDtuEKy+1SiX
	ewA11iXkyPPVw41tHwBAqa5rkcjVjWAlip/Pl/HCzU4svrE0nRyfKKYPae4QNMU4lEnlBp
	nYqUcKvsMljwUUqMok77U2PLXhQWJWQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-1kRsgGuqPF-SnLOpkG2OXw-1; Wed,
 24 Jun 2026 12:38:28 -0400
X-MC-Unique: 1kRsgGuqPF-SnLOpkG2OXw-1
X-Mimecast-MFC-AGG-ID: 1kRsgGuqPF-SnLOpkG2OXw_1782319106
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17268180034E;
	Wed, 24 Jun 2026 16:38:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F4E01800361;
	Wed, 24 Jun 2026 16:38:22 +0000 (UTC)
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
Subject: [PATCH net v3 00/11] rxrpc: Miscellaneous fixes
Date: Wed, 24 Jun 2026 17:38:07 +0100
Message-ID: <20260624163819.3017002-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301721-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 3F24F6C004E

Here are some miscellaneous AF_RXRPC fixes for more stuff found by Sashiko[1][2]:

 (1) Fix ACKALL handling by adding two more call states to simplify when
     ACKs are valid.

 (2) Fix connection leak from AF_RXRPC recvmsg userspace OOB handling.

 (3) Fix double unlock in AF_RXRPC recvmsg userspace OOB handling.

 (4) Fix AFS preallocate charge to flush the waitqueue after unlistening
     the socket so that any charging thread that does manage to get started
     will be waited for before socket destruction.

 (5) Fix AFS OOB notify handling to cancel in-progress OOB notification
     handling and then to flush the workqueue it's on.

 (6) Fix handling of apparent reply reception before initial transmission
     starts in client call.

 (7) Fix OOB challenge leak in cleanup on notification failure.

 (8) Fix infinite loop in recvmsg if OOB packet available, but no calls.

 (9) Fix notify vs recvmsg race where notify thinks the call is already
     queued.

(10) Fix MSG_PEEK call leak for calls with no content.

(11) Fix rxrpc_rotate_tx_window() to check that there's something in the Tx
     buffer before attempting to rotate it.

Note that the latest Sashiko review[3] has some more pre-existing issues,
but I'd like to get this set of fixes committed before tackling those.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

[1] https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
[2] https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com
[3] https://sashiko.dev/#/patchset/20260618134802.2477777-1-dhowells%40redhat.com

Changes
=======
ver #3)
- Rewrote ACKALL fix to add two new call states to make it easier to track
  when ACKs are valid.
- Addressed the Sashiko review[3]:
  - Use READ_ONCE() to access net->live.
  - Added a patch to check the Tx buffer is occupied before rotating it.

ver #2)
- Addressed the Sashiko review[2] of ver #1:
  - Added patches to fix more bugs that it found.
  - Adjusted AFS preallocate charge cleanup to only cancel the preallocate
    work item after unlistening rather than flushing the entire waitqueue
    (which may be waiting on DNS lookup).
  - Added extra cancel for OOB rx handler in AFS.

David Howells (10):
  rxrpc: Fix leak of connection from OOB challenge
  rxrpc: Fix double unlock in rxrpc_recvmsg()
  afs: Fix further netns teardown to cancel the preallocation charger
  afs: Fix uncancelled rxrpc OOB message handler
  rxrpc: Fix the reception of a reply packet before data transmission
  rxrpc: Fix oob challenge leak in cleanup after notification failure
  rxrpc: Fix potential infinite loop in rxrpc_recvmsg()
  rxrpc: Fix socket notification race
  rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
  rxrpc: Fix rxrpc_rotate_tx_rotate() to check there's something to
    rotate

Wyatt Feng (1):
  rxrpc: Fix ACKALL packet handling

 fs/afs/cm_security.c    |  3 ++-
 fs/afs/rxrpc.c          | 10 +++++++++-
 net/rxrpc/ar-internal.h |  6 ++++--
 net/rxrpc/call_event.c  |  5 ++++-
 net/rxrpc/call_object.c |  2 ++
 net/rxrpc/conn_client.c |  2 +-
 net/rxrpc/conn_event.c  |  9 +++++++--
 net/rxrpc/input.c       | 39 ++++++++++++++++++++++++++++++++-------
 net/rxrpc/oob.c         | 12 ++++++++++--
 net/rxrpc/recvmsg.c     | 10 ++++------
 net/rxrpc/sendmsg.c     |  3 ++-
 11 files changed, 77 insertions(+), 24 deletions(-)


