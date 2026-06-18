Return-Path: <netdev+bounces-300444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JfUSASv3M2qSJwYAu9opvQ
	(envelope-from <netdev+bounces-300444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6758B6A0B1A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:48:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=c0cygJuJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300444-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300444-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E4D530053A0
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874872D73BD;
	Thu, 18 Jun 2026 13:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9D280CFB
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:48:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790504; cv=none; b=t32mZZzO+/AGn/OTqxn+xqCRzyM5fI4J0ZKTJjHn9EFFyVHjnSYsgM0AcGbmd8ovhg50F0zSR0hWExC/lCiin82vj6/9IU7nhWxR7kCyhocKzfqnHtO5mroontxRQhySxquJEJ9myRY/gAW1gRj3AFO384Ti8wBc3JhSIo/pBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790504; c=relaxed/simple;
	bh=fROVoubvc5vuiv69rKd6jz0WF5eakT6t7VuD7uX934k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRzxuBGFPgbU/GTEb7uEm6yv/vKqLKhT1jWD91fR6ngUURJDh8CUxTDAH0qz4nx0S4HIFirHxDB3b6NYF0hjZ9jqN2ELLJrTNsXMv2t5bcbrwToy/pnQCNpqawSWGuDM/n3rZzaQT6xQvRla7HljrG9ZfMNZESE4hYD6LibJJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0cygJuJ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QBXft/hPvHTS/BnFxjUMT262NUVqxVG6rPSQCAo5ed4=;
	b=c0cygJuJzFqs8zxvqSUz3S9ykTVbphuptL+2pwAsyEFXHDpTPSHVuujMMCkln2x/TfRZNt
	SolnaKo/hMg6dF228FQdmNmCt2+5xRq8AUJOp3tL8bBkOTNAhzZaAd4s8kccAvFbzptuex
	/NUAt4gbgAk8TBUy5L9/Xya5I7J7ySU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-W3T82XVJNJWRtCHFSGMNAQ-1; Thu,
 18 Jun 2026 09:48:15 -0400
X-MC-Unique: W3T82XVJNJWRtCHFSGMNAQ-1
X-Mimecast-MFC-AGG-ID: W3T82XVJNJWRtCHFSGMNAQ_1781790493
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3581E188EB78;
	Thu, 18 Jun 2026 13:48:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5AFC18001D2;
	Thu, 18 Jun 2026 13:48:05 +0000 (UTC)
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
Subject: [PATCH net v2 00/10] rxrpc: Miscellaneous fixes
Date: Thu, 18 Jun 2026 14:47:51 +0100
Message-ID: <20260618134802.2477777-1-dhowells@redhat.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300444-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6758B6A0B1A

Here are some miscellaneous AF_RXRPC fixes for more stuff found by Sashiko[1][2]:

 (1) Reject ACKALL packets for calls not in Tx or immediate post-Tx state.

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

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

[1] https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
[2] https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com

Changes
=======
ver #2)
- Addressed the Sashiko review[2] of ver #1.
  - Added patches to fix more bugs that it found.
  - Adjusted AFS preallocate charge cleanup to only cancel the preallocate
    work item after unlistening rather than flushing the entire waitqueue
    (which may be waiting on DNS lookup).
  - 

David Howells (9):
  rxrpc: Fix leak of connection from OOB challenge
  rxrpc: Fix double unlock in rxrpc_recvmsg()
  afs: Fix further netns teardown to cancel the preallocation charger
  afs: Fix uncancelled rxrpc OOB message handler
  rxrpc: Fix the reception of a reply packet before data transmission
  rxrpc: Fix oob challenge leak in cleanup after notification failure
  rxrpc: Fix potential infinite loop in rxrpc_recvmsg()
  rxrpc: Fix socket notification race
  rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)

Wyatt Feng (1):
  rxrpc: input: reject ACKALL outside transmit phase

 fs/afs/cm_security.c    |  3 ++-
 fs/afs/rxrpc.c          | 10 +++++++++-
 net/rxrpc/ar-internal.h |  4 ++--
 net/rxrpc/conn_event.c  |  9 +++++++--
 net/rxrpc/input.c       | 29 +++++++++++++++++++++++++----
 net/rxrpc/oob.c         | 12 ++++++++++--
 net/rxrpc/recvmsg.c     | 10 ++++------
 7 files changed, 59 insertions(+), 18 deletions(-)


