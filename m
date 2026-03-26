Return-Path: <netdev+bounces-272048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M8oIms2xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:36:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 111CA33612B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A57F53110FF1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225FB3C060E;
	Thu, 26 Mar 2026 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLiVSPFi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074C2D5935
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531134; cv=none; b=XooxCcxkXMoXUhikZTunu+iFZv6KehqWo57ZEnDkWhypgt3FxfxctPBLtpccPB4aMce6XTI9wrND73PqjhJvWaKjPI48vygrx3MxBoQsXB6b0CNMtRgLJ2bsv0TXLzV8pHirbpSX2C/bJxQpL7m/QWQxi3Ftz5M/q5qMvQTpWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531134; c=relaxed/simple;
	bh=uhkPDVDixadPQO+G+Qmnlgq59rRFOKjOaWUGtH4EQ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stIZgyXYndciJw8h0ahlYsfM0ER5u7F13NXf5PdiZRSHDsXFE2MXcexhFdfN+UWuFc7bFVlTc6rMZn2VoQz6eay+eSzFCzm6+1CyZ59rYHanbdvMwR1yxbWy81Z9rbGl8svMaQ+DAVmw7L7vOKMz+PXpRnQjc0jW65A+CqsP5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLiVSPFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774531131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+LaissVIx0yr2jBo6wGg+nKyI7tNmER+28MboWyYboE=;
	b=dLiVSPFiCHCesA71YX4hpQ38yyKJtmr5njSVUMoBxPe5lpxexVMvfi/h60gR1cj/sFaef9
	3zRmrXiyZXi2KkxczzcRSSlt46WpFB/Kt7neiL/M9irQIfJkLzIEXaA5UNLkQC+KiooOYU
	aGDb1WTC76aBOBBR4Vy5zbhN+tvjFow=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-s5t2WR8JOc6_68FflCiKyQ-1; Thu,
 26 Mar 2026 09:18:46 -0400
X-MC-Unique: s5t2WR8JOc6_68FflCiKyQ-1
X-Mimecast-MFC-AGG-ID: s5t2WR8JOc6_68FflCiKyQ_1774531125
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45C9D180047F;
	Thu, 26 Mar 2026 13:18:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 517FD1800361;
	Thu, 26 Mar 2026 13:18:41 +0000 (UTC)
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
Subject: [PATCH net v3 00/11] rxrpc: Miscellaneous fixes
Date: Thu, 26 Mar 2026 13:18:25 +0000
Message-ID: <20260326131838.634095-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272048-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 111CA33612B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are some fixes for rxrpc:

 (1) Fix key quota calculation.

 (2) Fix a memory leak.

 (3) Fix rxrpc_new_client_call_for_sendmsg() to substitute NULL for an
     empty key.

     Might want to remove this substitution entirely or handle it in
     rxrpc_init_client_call_security() instead.

 (4) Not strictly a fix, but move on_list_rcu() from apparmor to list.h so
     that (5) can use it as list_empty() is not sufficient.  Also add an
     on_list() function.

 (5) Fix deletion of call->link to be RCU safe.

 (6) Fix missing bounds checks when parsing RxGK tickets.

 (7) Fix use of wrong skbuff to get challenge serial number.  Also actually
     substitute the newer response skbuff and release the older one.

 (8) Fix unexpected RACK timer warning to report old mode.

 (9) Fix server keyring refcount leak.

(10) Fix call key refcount leak.

(11) Fix the interaction of jumbograms with Tx window space, setting the
     request-ack flag when the window space is getting low, typically because
     each jumbogram take a big bite out of the window and fewer UDP packets
     get traded.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #3)
- Rename the dwc2's on_list() to dwc2_on_list() to free up the name.
- Added a patch to fix the interaction of jumbograms with window space.

ver #2)
- AI review[1]:
  - Added a patch to fix key quota calculation.
  - Added a patch to fix a memory leak.
  - Added a patch to use NULL instead of an empty key in rxrpc_sengmsg().
  - Added a patch to use RCU-safe deletion on call->link.
  - Modified the response packet selection patch to select the newer
    response when there's an older response - and to release the older
    response skbuff.
- Move on_list_rcu() and add on_list().

Link: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com [1]

Alok Tiwari (2):
  rxrpc: Fix use of wrong skb when comparing queued RESP challenge
    serial
  rxrpc: Fix rack timer warning to report unexpected mode

Anderson Nascimento (2):
  rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
  rxrpc: Fix key reference count leak from call->key

David Howells (5):
  rxrpc: Fix key quota calculation for multitoken keys
  rxrpc: Fix key parsing memleak
  rxrpc: Fix anonymous key handling
  list: Move on_list_rcu() to list.h and add on_list() also
  rxrpc: Fix call removal to use RCU safe deletion

Marc Dionne (1):
  rxrpc: Fix to request an ack if window is limited

Oleh Konko (1):
  rxrpc: Fix RxGK token loading to check bounds

 drivers/usb/dwc2/gadget.c          |  6 ++---
 include/linux/list.h               | 26 ++++++++++++++++++++
 include/trace/events/rxrpc.h       |  2 ++
 net/rxrpc/af_rxrpc.c               |  2 +-
 net/rxrpc/ar-internal.h            |  2 +-
 net/rxrpc/call_object.c            |  7 +++---
 net/rxrpc/conn_event.c             |  5 ++--
 net/rxrpc/input_rack.c             |  2 +-
 net/rxrpc/key.c                    | 38 +++++++++++++++++-------------
 net/rxrpc/output.c                 |  2 ++
 net/rxrpc/proc.c                   |  5 ++--
 net/rxrpc/sendmsg.c                |  2 +-
 security/apparmor/include/policy.h |  2 --
 13 files changed, 69 insertions(+), 32 deletions(-)


