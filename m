Return-Path: <netdev+bounces-287607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA6GByaABGrmKwIAu9opvQ
	(envelope-from <netdev+bounces-287607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:44:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA11534447
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C514317434E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D1436346;
	Wed, 13 May 2026 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erZIhWc1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81099315D58
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678398; cv=none; b=HKE+CwREyCGnURo1hrA+tU2aM1eLUfL0R5xcs+AhjJGhsPd43YoOe7TzduxdVIzoWI44rKKLklGCzknAcwwV/8iFS9pr72UQYeYOuemeywGO+pYnNpeaME1OXaUwX2yqTT2wKoKU1htBuLGA8pGsuU0ArrvsjQRG+ARbcbvrbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678398; c=relaxed/simple;
	bh=r/fBsjeGzJfj/ZbB0uyid/RH6pJDN+6+cnhcG67eY2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tyvkxhk5d/N0gZAqRkOEpNtrhc4s5enzgvQSzjcms5lffdpryl027/zP9M7SHYVo/+HYeHQACyyThYsf0LrL02zwtPrSAiuRgz0joxQ/KFOVnRHL+mjyskPtMuZRTN/p/BQhSkvJJb1jM8aM5DnHC5B+Mhjt8th/RMQWIs3QNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erZIhWc1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778678395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EoseOhYi91+mDix+KVynQe7OdMKXMV9xklv/VJoSjOQ=;
	b=erZIhWc1BQEioqVMDdXHhRtYs4TNbxDJXCEmSOrlZTFcRLoGQ0lCNR06HJR8xR28uCMEx6
	UTQp5foMrHrGIKw4sZWheUtKV78jzmQ/PrLQL/+ItK05IXOVnMmQ9ZbqXrBu84uaWkx2ZZ
	aroNuJYZ0IMjyHPx2I+cQm6snFM+tWI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-hGIoQFglNV-MtL5Cdk0pAg-1; Wed,
 13 May 2026 09:19:52 -0400
X-MC-Unique: hGIoQFglNV-MtL5Cdk0pAg-1
X-Mimecast-MFC-AGG-ID: hGIoQFglNV-MtL5Cdk0pAg_1778678391
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3303B19560A7;
	Wed, 13 May 2026 13:19:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAA0319560A6;
	Wed, 13 May 2026 13:19:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/4] rxrpc: Better fix for DATA/RESPONSE decrypt vs splice()
Date: Wed, 13 May 2026 14:19:36 +0100
Message-ID: <20260513131941.1439155-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: BEA11534447
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287607-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Here are two patches containing better fixes for the in-place decryption of
DATA and RESPONSE packets that can corrupt pagecache spliced into UDP
packets and sent to an AF_RXRPC server [CVE-2026-43500], plus a patch to
precheck the length of rxgk-secured DATA packets.

[!] Note that Hyunwoo Kim's fix is included as that is a prerequisite for
the main patches to build.  This is in Linus's tree, but not yet net/main.

Of the main patches, one patch fixes DATA decryption by having recvmsg
unconditionally extract the data into a flat bounce buffer and, if need be,
decrypt it there.  It doesn't seem to cause a performance problem to do
this even on unencrypted packets; for encrypted packets it makes sure the
content is correctly aligned for crypto which seems to get a small
performance gain.

Further, it means that DATA packets are no longer copied in the I/O thread,
avoiding a slowdown of the protocol engine that runs there.

The other main patch fixes RESPONSE decryption by having the connection
event handler worker copy the data to a flat buffer and, again, decrypt it
there.  This simplifies RESPONSE handling.

With these two fixes, the data content of the received sk_buff no longer
gets altered.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #2)
- In rxrpc_verify_data():
  - Flipped the order of the buffer size comparison.
  - Used max() not umin() to calculate the minimum buffer size.
- In rxrpc_verify_response(), returned -ENOMEM rather than uninitialised
  ret.
- Removed the xdr wrappers that were added to make backporting easier.
- Fixed Sashiko review comments[1]:
  - Added length prechecking of received packets secured with RxGK, thereby
    avoiding looking at an unallocated buffer.
  - Added missing crypto free.

[1] https://sashiko.dev/#/patchset/20260511160753.607296-1-dhowells%40redhat.com

David Howells (3):
  crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
  rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in
    recvmsg
  rxrpc: Fix RESPONSE packet verification to extract skb to a linear
    buffer

Hyunwoo Kim (1):
  rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present

 Documentation/crypto/krb5.rst |  17 +++-
 crypto/krb5/krb5_api.c        |  54 ++++++++++--
 include/crypto/krb5.h         |   9 +-
 include/trace/events/rxrpc.h  |   1 +
 net/rxrpc/ar-internal.h       |  14 +--
 net/rxrpc/call_event.c        |  20 +----
 net/rxrpc/call_object.c       |   2 +
 net/rxrpc/conn_event.c        |  29 +++----
 net/rxrpc/insecure.c          |   8 +-
 net/rxrpc/recvmsg.c           |  72 +++++++++++++---
 net/rxrpc/rxgk.c              | 156 ++++++++++++++--------------------
 net/rxrpc/rxgk_app.c          |  44 ++++------
 net/rxrpc/rxgk_common.h       |  66 +++++++-------
 net/rxrpc/rxkad.c             | 115 +++++++++----------------
 14 files changed, 306 insertions(+), 301 deletions(-)


