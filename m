Return-Path: <netdev+bounces-299899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L+7CEk91MWpUjwUAu9opvQ
	(envelope-from <netdev+bounces-299899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:09:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C1691BF9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="Tlh2Fk/M";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299899-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299899-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA0D2309A432
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC94611C1;
	Tue, 16 Jun 2026 15:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A854657DA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:58:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625485; cv=none; b=XZchEU2eTSZHsLVN8K+lbgIl2Q824NmiNNW+4oR3Oq8F37lYduZg+95NaPiDdoLeqH2o/u1dFW2E+3CLIQ/hSh4BSlE2Mhxw4tOnGJ42BYXcAmBFLfZF27yrSLEYabw/5YQtxIwDIOQx4x+c2f/pSd4TwkzG6aH8Kelq2Jdk9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625485; c=relaxed/simple;
	bh=dbQ9pJ31/1M8XBsRCJd5ZEytrkYHN9jxmNkw5XsEGjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxBq8Qh5QqqUyahCYIoVLLnAqSwLvESayX0yBLsHcu7fjfWyXnY8jjZg44qvWaxJjFIKGPLx2X8maElruH+ysuTLYHqY+KaGr9hAnHolF1kDMGhp4Y0gq3F9eYAv9JaMMaPzoHh40c5JA4oYLip/2sS3MqFqssyFOR0cC5oNuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tlh2Fk/M; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781625483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JJyvLiSqe3Ee9HXvQNjNWd2o1CZuH+blOS3SFjgfc+8=;
	b=Tlh2Fk/Mb2L4v4f0/JQtziwxRKEUniMzQoWhN2agmu+QXbLO9ahxQSdCMgQEdTCx9QSlLl
	Pqm42u5P+UR0hG0/usMUmEGr+R886yMEwYxDeeRaZNVoV6nK92JudsEu2i3iU0Xv4hdFAS
	ZQnLd2eEMTaEYs/sbZ3yeXINZsdRk9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-WLUG5ZPbNtCFBJZUV-KDMg-1; Tue,
 16 Jun 2026 11:57:57 -0400
X-MC-Unique: WLUG5ZPbNtCFBJZUV-KDMg-1
X-Mimecast-MFC-AGG-ID: WLUG5ZPbNtCFBJZUV-KDMg_1781625475
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831F91955E75;
	Tue, 16 Jun 2026 15:57:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 632C51800595;
	Tue, 16 Jun 2026 15:57:52 +0000 (UTC)
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
Subject: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Date: Tue, 16 Jun 2026 16:57:42 +0100
Message-ID: <20260616155749.2125907-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: DC1C1691BF9

Here are some miscellaneous AF_RXRPC fixes for more stuff found by Sashiko[1]:

 (1) Reject ACKALL packets for calls not in Tx or immediate post-Tx state.

 (2) Fix connection leak from AF_RXRPC recvmsg userspace OOB handling.

 (3) Fix double unlock in AF_RXRPC recvmsg userspace OOB handling.

 (4) Fix AFS preallocate charge to flush the waitqueue after unlistening
     the socket so that any charging thread that does manage to get started
     will be waited for before socket destruction.

 (5) Fix AFS OOB notify handling to cancel in-progress OOB notification
     handling and then to flush the workqueue it's on.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

[1] https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com

David Howells (4):
  rxrpc: Fix leak of connection from OOB challenge
  rxrpc: Fix double unlock in rxrpc_recvmsg()
  afs: Fix further netns teardown to cancel the preallocation charger
  afs: Fix uncancelled rxrpc OOB message handler

Wyatt Feng (1):
  rxrpc: input: reject ACKALL outside transmit phase

 fs/afs/cm_security.c |  3 ++-
 fs/afs/rxrpc.c       |  5 ++++-
 net/rxrpc/input.c    | 16 +++++++++++++++-
 net/rxrpc/oob.c      |  5 +++++
 net/rxrpc/recvmsg.c  |  2 +-
 5 files changed, 27 insertions(+), 4 deletions(-)


