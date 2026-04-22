Return-Path: <netdev+bounces-280475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP/DKpr16GncSAIAu9opvQ
	(envelope-from <netdev+bounces-280475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F144881A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B924B30C32DA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A10037CD3C;
	Wed, 22 Apr 2026 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XByyTfV1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8237700B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874493; cv=none; b=V618Ulp7fOh8xOwiXQ5gBWjfZZ2YKEbl35XLP7nW2/MIkjhekBP0JMYCX40lDpeZUUw+F0Hhrtg9sDp0ZXAzG+x9GjoX9YpNPQvZAj7DPaT70pVz1MBJes1DoNzXnHLWYhbNLqRtj1jFRaMrcn4MexVDBrm7qw4dHhuB0VRy2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874493; c=relaxed/simple;
	bh=ceG9hlKcQQLjEH1fq+ZRm0GaB7amhKFeoxZPMjcJvzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7WFLQ7gt9qZ/YGima5UzQx9ewZ7gxLDfY6S52Q6CCP4fADCxt12ZLVdFAuYGMOpIDJajmYiUEg3ycoakU84hI4h88+HT4Y1hQ3x3oTkjxTCBMkIwS4FckLZUwefTmdYgUil2DSfQLf+VufIs0WeJQ1QJx/xbw8F5VmuoF0FjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XByyTfV1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776874490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6mOsgWOxnc0+otBr4h76GnPam6a+9tcfPC9mgj/QtDw=;
	b=XByyTfV1Q6ZyU0cTJ43lX0ntKcwMuKyDly1dFJXKnVmIxxOpXC95ByeWViHKoDqIRZUSAS
	Zxp8VIkF1VGtHVF/06duATuGgxFUT0SqUMPDwKf1ibpah1H1pBtBvF6I5fau90cgsg3eUC
	aVHeKGPtHruD/WPSwumqD4NX79YiAFk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-S-YlvY_tPcivoOF_d9Eqww-1; Wed,
 22 Apr 2026 12:14:47 -0400
X-MC-Unique: S-YlvY_tPcivoOF_d9Eqww-1
X-Mimecast-MFC-AGG-ID: S-YlvY_tPcivoOF_d9Eqww_1776874486
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D334180034D;
	Wed, 22 Apr 2026 16:14:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA1A219560B7;
	Wed, 22 Apr 2026 16:14:40 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Date: Wed, 22 Apr 2026 17:14:29 +0100
Message-ID: <20260422161438.2593376-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280475-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 146F144881A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are some fixes for rxrpc, as found by Sashiko[1]:

 (1) Fix leaks in rxkad_verify_response().

 (2) Fix handling of rxkad-encrypted packets with crypto-misaligned
     lengths.

 (3) Fix problem with unsharing DATA packets potentially causing a crash in
     the caller.

 (4) Fix lack of unsharing of RESPONSE packets.

 (5) Fix integer overflow in RxGK ticket length check.

 (6) Fix missing length check in RxKAD tickets.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #2)
- Use of __free() constructs in networking code is disallowed, so rework
  the rxkad_verify_response() patch to just clean everything up at the end
  and cope with NULL pointers.
- Reworked the unsharing fix:
  - Used skb_cloned() and skb_copy() directly rather than skb_unshare().
    The problem with skb_unshare() is that it kills the source skbuff if it
    can't copy, which then has to be propagated up the call chain.  Even
    so, the code still had an bug from this[1].
  - Split into two patches, one for DATA and one for RESPONSE packets.
  - Do the DATA unshare a lot further along.
- Imported a patch to add a length check on RxKAD tickets.

Link: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com [1]

Anderson Nascimento (1):
  rxrpc: Fix missing validation of ticket length in non-XDR key
    preparsing

David Howells (5):
  rxrpc: Fix memory leaks in rxkad_verify_response()
  rxrpc: Fix rxkad crypto unalignment handling
  rxrpc: Fix potential UAF after skb_unshare() failure
  rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
  rxgk: Fix potential integer overflow in length check

 include/trace/events/rxrpc.h |   5 +-
 net/rxrpc/ar-internal.h      |   1 -
 net/rxrpc/call_event.c       |  19 +++++-
 net/rxrpc/conn_event.c       |  29 ++++++++-
 net/rxrpc/io_thread.c        |  24 +-------
 net/rxrpc/key.c              |   4 ++
 net/rxrpc/rxgk_app.c         |   2 +-
 net/rxrpc/rxgk_common.h      |   1 +
 net/rxrpc/rxkad.c            | 112 +++++++++++++++--------------------
 net/rxrpc/skbuff.c           |   9 ---
 10 files changed, 106 insertions(+), 100 deletions(-)


