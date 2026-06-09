Return-Path: <netdev+bounces-297064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PG+ZMEsgKGqQ+QIAu9opvQ
	(envelope-from <netdev+bounces-297064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D708660E83
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ps0qfBfy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297064-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297064-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EDBF301DEFB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1A323417;
	Tue,  9 Jun 2026 14:09:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB6305669
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:09:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014170; cv=none; b=R/IXhi4SZJViII+n0JyralyHeW+QejB6xINO5zSAYhGwU1qkr/qrfTkIVk9MARfvNkQgN0Fvs7PHQ0QfVPj20wCzova0kXhlXe1zYflkqWQWV9y4uJpZNf6XlpR0j8RN/x4dN1Jh5H2oyLCbbgCz9wNimdxiOcEPlSyPfENL7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014170; c=relaxed/simple;
	bh=xTNcFe4H4wOb9Zd65LQtz27KtqACrG9eGYLRK7BNxYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFdS9m0vC6GMt+kDgwS0q930N7qMJIWHDwJ5Q5dPKhdjBJQK0Rd48l3AbgxpyQmT1fi+0p2365IP6ZkZrAdjQzOg5V7xEsTjqrdkfp5/aU64cQXZztP0YZKTX63L78bbQYmjgUMbV4aHdpuFE+XQ23Y/G8JPhxsJmeQ14i38Riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ps0qfBfy; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781014168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bD2+bEr272RjFC7FJNiQ0b6ydrHETlB/7F/+N6uj2E4=;
	b=Ps0qfBfyI9aQb/avtTY353MFTXDm0+jeRYDWmfD6OrrepvYM5l6VJLo5PEg7N4mIp2OIj4
	CJejXUgmXhii65IE501gJ4ZKC8h+Qg0QgZEhbBGgs7CE0gnYpsvW+HCxpRgkT26NNUnwbz
	B1pYxfYsR7JwYm3D7j9/RSNuN/HeT5g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-6bfIusAdNsiM3oTX_UQvvA-1; Tue,
 09 Jun 2026 10:09:24 -0400
X-MC-Unique: 6bfIusAdNsiM3oTX_UQvvA-1
X-Mimecast-MFC-AGG-ID: 6bfIusAdNsiM3oTX_UQvvA_1781014163
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A58E018417E9;
	Tue,  9 Jun 2026 14:09:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E7321954102;
	Tue,  9 Jun 2026 14:09:18 +0000 (UTC)
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
Date: Tue,  9 Jun 2026 15:09:04 +0100
Message-ID: <20260609140911.838677-1-dhowells@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-297064-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D708660E83

Here are some miscellaneous AF_RXRPC fixes:

 (1) Make sure rxrpc_verify_data() allocates a buffer, even if the DATA packet
     being looked at is zero length to avoid potential NULL-pointer
     exceptions.

 (2) Don't move an OOB message (e.g. an RxGK CHALLENGE) off the receive queue
     onto the pending queue in recvmsg() if MSG_PEEK is specified.

 (3) Fix a potential UAF in rxgk_issue_challenge() in which a tracepoint
     refers to memory just freed by a different pointer.

 (4) Fix afs net namespace teardown to cancel the incoming call preallocation
     charger before we disable listening (which will delete the preallocation
     queue).

 (5) Fix rxrpc_kernel_charge_accept() to use the socket mutex to defend
     against listen(0)/shutdown simultaneously deleting the preallocation queue.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (2):
  rxrpc: Fix UAF in rxgk_issue_challenge()
  afs: Fix netns teardown to cancel the preallocation charger

Hyunwoo Kim (1):
  rxrpc: Don't move a peeked OOB message onto the pending queue

Jeffrey Altman (1):
  rxrpc: rxrpc_verify_data ensure rx_dec_buffer alloc

Li Daming (1):
  rxrpc: serialize kernel accept preallocation with socket teardown

 fs/afs/rxrpc.c          |  6 ++++--
 net/rxrpc/call_accept.c | 25 +++++++++++++++++++------
 net/rxrpc/recvmsg.c     | 13 +++++++------
 net/rxrpc/rxgk.c        |  3 ++-
 4 files changed, 32 insertions(+), 15 deletions(-)


