Return-Path: <netdev+bounces-274046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OvDKsT6zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:00:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9B378FB8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87425301A2FA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0273F7E9D;
	Wed,  1 Apr 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME46JTTj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB13F7873
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040998; cv=none; b=Ai+flcQ8ck9Jfc51G4VD/DHr2tX6WwG0ueAPvTcSe2ZElstadSJxdtPnVL/WxQj9no/ENyXZyRIWLv0Pk6o2ikihM3sepOzMnEYsQmVt7nBki3SXM05uPz0mYYqV4Sxbr6QBFPvu7HpBI2H01ykVnCUjOBqSl1IL/ognrTsM3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040998; c=relaxed/simple;
	bh=qzIoi0e/M4l0OGTa2A/yjLaKaw99iuuxZ2hmyR7RIKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5lbP240gS7yMB2PVd8dAhdkoAiK/S9EQkeHwwpzSWhX+9hdiky6At/E8uDXLCZEoFWv5rnNl4nfk83BfNk9KpnNuZb8rLl6gIkbD/rxs0KeH6E7wDd0+iKfm1hSf+Kpa0MktKObG82kORCfyvmb9xKjeV9EKFLEwE+OwgkQ1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME46JTTj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775040993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gRBP1lB8/pUazuuC0X1VfIS4P0y/NATFNWsT1rsi7y8=;
	b=ME46JTTjxRhQy8vE9RQh3kSPrgmbpVfJi+8g7zZeRA9wgwrqtZWMS/Kz01tOE0esfTEMmQ
	0I2En1jJvOc/HOYlY3v8M7RGEWhIrlJSOzFdWQXGD8ZZgAGEC7oLlMQ3TArT1kjlnvABFR
	5A/m3fhxIp2TV2X4e6udIp6T3abrWnc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-CI-leOclNyGlUYJX5fPbZA-1; Wed,
 01 Apr 2026 06:56:30 -0400
X-MC-Unique: CI-leOclNyGlUYJX5fPbZA-1
X-Mimecast-MFC-AGG-ID: CI-leOclNyGlUYJX5fPbZA_1775040989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8AA61956046;
	Wed,  1 Apr 2026 10:56:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE5AD180075B;
	Wed,  1 Apr 2026 10:56:24 +0000 (UTC)
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
Subject: [PATCH net v4 00/15] rxrpc: Miscellaneous fixes
Date: Wed,  1 Apr 2026 11:55:53 +0100
Message-ID: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274046-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 8BF9B378FB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are some fixes for rxrpc:

 (1) Fix key quota calculation.

 (2) Fix a memory leak.

 (3) Fix rxrpc_new_client_call_for_sendmsg() to substitute NULL for an
     empty key.

     Might want to remove this substitution entirely or handle it in
     rxrpc_init_client_call_security() instead.

 (4) Fix deletion of call->link to be RCU safe.

 (5) Fix missing bounds checks when parsing RxGK tickets.

 (6) Fix use of wrong skbuff to get challenge serial number.  Also actually
     substitute the newer response skbuff and release the older one.

 (7) Fix unexpected RACK timer warning to report old mode.

 (8) Fix server keyring refcount leak.

 (9) Fix call key refcount leak.

(10) Fix the interaction of jumbograms with Tx window space, setting the
     request-ack flag when the window space is getting low, typically
     because each jumbogram take a big bite out of the window and fewer UDP
     packets get traded.

(11) Don't call rxrpc_put_call() with a NULL pointer.

(12) Reject undecryptable rxkad response tickets by checking result of
     decryption.

(13) Fix buffer bounds calculation in the RESPONSE authenticator parser.

(14) Fix refcount leak on multiple setting of server keyring.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #4)
- Got rid of the on_list()/on_list_rcu() patch.
- Removed the list_del_init from rxrpc_destroy_all_calls().
- Made the list_del_rcu() in rxrpc_put_call() unconditional.
- Added four new patches.

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

David Howells (4):
  rxrpc: Fix key quota calculation for multitoken keys
  rxrpc: Fix key parsing memleak
  rxrpc: Fix anonymous key handling
  rxrpc: Fix call removal to use RCU safe deletion

Douya Le (1):
  rxrpc: Only put the call ref if one was acquired

Keenan Dong (2):
  rxrpc: fix RESPONSE authenticator parser OOB read
  rxrpc: fix oversized RESPONSE authenticator length check

Luxiao Xu (1):
  rxrpc: fix reference count leak in rxrpc_server_keyring()

Marc Dionne (1):
  rxrpc: Fix to request an ack if window is limited

Oleh Konko (1):
  rxrpc: Fix RxGK token loading to check bounds

Yuqi Xu (1):
  rxrpc: reject undecryptable rxkad response tickets

 include/trace/events/rxrpc.h |  4 +++-
 net/rxrpc/af_rxrpc.c         |  2 +-
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/call_object.c      | 25 ++++++++++--------------
 net/rxrpc/conn_event.c       |  5 +++--
 net/rxrpc/input_rack.c       |  2 +-
 net/rxrpc/io_thread.c        |  3 ++-
 net/rxrpc/key.c              | 38 +++++++++++++++++++++---------------
 net/rxrpc/output.c           |  2 ++
 net/rxrpc/proc.c             |  5 +++--
 net/rxrpc/rxgk.c             |  5 +++--
 net/rxrpc/rxkad.c            |  6 +++++-
 net/rxrpc/sendmsg.c          |  2 +-
 net/rxrpc/server_key.c       |  3 +++
 14 files changed, 60 insertions(+), 44 deletions(-)


