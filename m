Return-Path: <netdev+bounces-276470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJszG61G1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:14:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1F83BBD91
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE1BA303EFC9
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C33BFE4A;
	Wed,  8 Apr 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FB2CUR/q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA43BFE3E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650388; cv=none; b=uI2ZXZ6aL7Ah61xFl8ajW4U+YYBHgyUfugEHnmaZ+KBxZtF1wOwDARAJgdnaNmd4jcabTJsXHxZe1Vvu6tGIeLCSlRl6KY396d2p45kMutqzFO1IZ3fkckdj9muCbCwMH0SdTyyUORlccnVh4FTbaHBlPrSKuBVGPM5DnwjHatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650388; c=relaxed/simple;
	bh=2B62G/a5zm4hq8/oVffFEJKAu1MI4w8vjueFl0YUFk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOpF291Nf0VVyo/HBJIOt5qlPinHcMmcaN+VF+0ZOKwYXxvfvSjZANBqSNgRxmxJW2N40Pdjpf6M0SHtn0R4XIQoZ3aEf3C4HdPHazUhKlDRZbHiy9bFx28+wz8loBJ3iqntzMNcA39kC3YB1QQyYr3n1wVyD4X0/yXZiW0DNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FB2CUR/q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UgrsnkoDlUUHlFBj65sH8/DPWdWPkG1kjE2aKzLldj0=;
	b=FB2CUR/qEniXyKI6oTMOmYgnXlsFwMs7cm1pbKcyItigo+pBt+MiK+/sjCrTxwEG7IcZ0g
	QTXNUY3LFAFgsSIZsvKNH+XFmkw1F+jF6pbOsDQeGlHtOpoBTDaiU34fNG2HKNxtC6MpUC
	59JK5XNyD+SxhCopB/ycHIjiwUW2q5o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-uEDtYeRzOnOg2YzSA5CAHg-1; Wed,
 08 Apr 2026 08:13:01 -0400
X-MC-Unique: uEDtYeRzOnOg2YzSA5CAHg-1
X-Mimecast-MFC-AGG-ID: uEDtYeRzOnOg2YzSA5CAHg_1775650380
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF9C418005B0;
	Wed,  8 Apr 2026 12:12:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B260A1800351;
	Wed,  8 Apr 2026 12:12:55 +0000 (UTC)
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
Subject: [PATCH net v5 00/21] rxrpc: Miscellaneous fixes
Date: Wed,  8 Apr 2026 13:12:28 +0100
Message-ID: <20260408121252.2249051-1-dhowells@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-276470-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD1F83BBD91
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

 (8) Fix call key refcount leak.

 (9) Fix the interaction of jumbograms with Tx window space, setting the
     request-ack flag when the window space is getting low, typically
     because each jumbogram take a big bite out of the window and fewer UDP
     packets get traded.

(10) Don't call rxrpc_put_call() with a NULL pointer.

(11) Reject undecryptable rxkad response tickets by checking result of
     decryption.

(12) Fix buffer bounds calculation in the RESPONSE authenticator parser.

(13) Fix oversized response length check.

(14) Fix refcount leak on multiple setting of server keyring.

(15) Fix checks made by RXRPC_SECURITY_KEY and RXRPC_SECURITY_KEYRING (both
     should be allowed).

(16) Fix lack of result checking on calls to crypto_skcipher_en/decrypt().

(17) Fix token_len limit check in rxgk_verify_response().

(18) Fix rxgk context leak in rxgk_verify_response().

(19) Fix read beyond end of buffer in rxgk_do_verify_authenticator().

(20) Fix parsing of RESPONSE packet on a connection that has already been set
     from a prior response.

(21) Fix size of buffers used for rendering addresses into for procfiles.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #5)
- AI review[2]:
  - Dropped patch to check rx->securities in rxrpc_setsockopt().
  - Changed patch to check rx->securities in rxrpc_server_keyring() to return
    error -EINVAL.
  - Added patch to check rx->key and rx->securities correctly.
  - Added patch to check return of crypto_skcipher_en/decrypt().
  - Added patch to check buf len in rxgk_do_verify_authenticator().
- Imported a patch to fix parsing of RESPONSE packet in wrong state.
- Imported a patch to fix size of address buffers in procfiles.

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
Link: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com [2]

Alok Tiwari (2):
  rxrpc: Fix use of wrong skb when comparing queued RESP challenge
    serial
  rxrpc: Fix rack timer warning to report unexpected mode

Anderson Nascimento (1):
  rxrpc: Fix key reference count leak from call->key

David Howells (9):
  rxrpc: Fix key quota calculation for multitoken keys
  rxrpc: Fix key parsing memleak
  rxrpc: Fix anonymous key handling
  rxrpc: Fix call removal to use RCU safe deletion
  rxrpc: Fix key/keyring checks in
    setsockopt(RXRPC_SECURITY_KEY/KEYRING)
  rxrpc: Fix missing error checks for rxkad encryption/decryption
    failure
  rxrpc: Fix integer overflow in rxgk_verify_response()
  rxrpc: Fix leak of rxgk context in rxgk_verify_response()
  rxrpc: Fix buffer overread in rxgk_do_verify_authenticator()

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

Pengpeng Hou (1):
  rxrpc: proc: size address buffers for %pISpc output

Wang Jie (1):
  rxrpc: only handle RESPONSE during service challenge

Yuqi Xu (1):
  rxrpc: reject undecryptable rxkad response tickets

 include/trace/events/rxrpc.h |  4 ++-
 net/rxrpc/af_rxrpc.c         |  6 ----
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/call_object.c      | 25 ++++++--------
 net/rxrpc/conn_event.c       | 19 ++++++++---
 net/rxrpc/input_rack.c       |  2 +-
 net/rxrpc/io_thread.c        |  3 +-
 net/rxrpc/key.c              | 40 +++++++++++++----------
 net/rxrpc/output.c           |  2 ++
 net/rxrpc/proc.c             | 37 ++++++++++++---------
 net/rxrpc/rxgk.c             | 19 +++++++----
 net/rxrpc/rxkad.c            | 63 ++++++++++++++++++++++++------------
 net/rxrpc/sendmsg.c          |  2 +-
 net/rxrpc/server_key.c       |  3 ++
 14 files changed, 138 insertions(+), 89 deletions(-)


