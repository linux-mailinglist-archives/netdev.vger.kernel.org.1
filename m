Return-Path: <netdev+bounces-288503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LKaA8imB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:05:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9AB559335
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C10230117AE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4FC38E100;
	Fri, 15 May 2026 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMuwrsa6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6EA3612FB
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886332; cv=none; b=XXa3eQEHPm99o+tv8ilmwT9BuB+AP9uy8E570esCodkwM8VCqtNvpYXkHJm6XbInzONoBYv9ui8D1zgPhSyLdVkKHmUDE3o3wX7+ESF9+IstO8MoMuA0gj9+qOQRXMJw8StImTk922rpbCy+hoS858AtBHRbnSUj+eFN6VOsg04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886332; c=relaxed/simple;
	bh=otoOHvz6ksbDtP3Irl9ZCRP6uM1kF48O3Mlzu/O94KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtIkUspKWWTlltbJd0AXTREMuPtImdCLSLN8ny4MVhHBuZhmCF0VhvsGEV/19ExMZqj8RLNn6CHaIPATBMUZYcOJVUVwAo/hnMjnz5ruOsgJZJu87y7uqUacU6rojCVRpfgy1wVr/O5FfRQxmgIWnA118jyXsUzrwwbG/E7vaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMuwrsa6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778886329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K6TYCEkgkT5CMcs2qjob9vuSOTj8gzTrqBcRlGY1nfg=;
	b=NMuwrsa6AWJSGWnhrXaSGhuvBj5FdH6hFNyBfLwlbNAVLYa1I4bXu4illnXjFJ03F2rqS2
	go0CiwzNtxXI+/Psq2vDPNQLPro2OlZ4BZZ+4ExTymyvqoqxOcglS80R0DYl3ZajM7PVBl
	AjB9/ZgkJ4mI4zRlMH9Dwwso0K5vj2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-69I9TNbrNVyXugxeqO_37A-1; Fri,
 15 May 2026 19:05:26 -0400
X-MC-Unique: 69I9TNbrNVyXugxeqO_37A-1
X-Mimecast-MFC-AGG-ID: 69I9TNbrNVyXugxeqO_37A_1778886324
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44DFD19560B1;
	Fri, 15 May 2026 23:05:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BDE5196B0A4;
	Fri, 15 May 2026 23:05:19 +0000 (UTC)
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
Subject: [PATCH net v4 0/3] rxrpc: Better fix for DATA/RESPONSE decrypt vs splice()
Date: Sat, 16 May 2026 00:05:12 +0100
Message-ID: <20260515230516.2718212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 6B9AB559335
X-Rspamd-Server: lfdr
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-288503-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]
X-Rspamd-Action: no action

Here are two patches containing better fixes for the in-place decryption of
DATA and RESPONSE packets that can corrupt pagecache spliced into UDP
packets and sent to an AF_RXRPC server [CVE-2026-43500], plus a patch to
precheck the length of rxgk-secured DATA packets.

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
ver #4)
- Updated to current net/next, dropping Hyunwoo Kim's patch.
- Don't allocate more than 65535 bytes of buffer so that ->rx_dec_bsize won't
  overflow.
- Fixed Sashiko review comments[3]:
  - Fix incorrect ticket length limit.
  - Don't need the MSG_PEEK limitation; can avoid this by checking seq of
    skbuff being recmvsg'd against the one on record for the content of the
    decryption buffer and (re-)decrypting if it doesn't match.

ver #3)
- Fixed Sashiko review comments[2]:
  - Fix wrong abort codes.
  - Fix skipped rxgk_put.
  - Fix some mis-sizeofs.
  - Fix flipped length check comparison.

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
[2] https://sashiko.dev/#/patchset/20260513131941.1439155-1-dhowells%40redhat.com
[3] https://sashiko.dev/#/patchset/20260514155304.2249591-1-dhowells%40redhat.com

David Howells (3):
  crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
  rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in
    recvmsg
  rxrpc: Fix RESPONSE packet verification to extract skb to a linear
    buffer

 Documentation/crypto/krb5.rst |  17 +++-
 crypto/krb5/krb5_api.c        |  54 ++++++++++--
 include/crypto/krb5.h         |   9 +-
 include/trace/events/rxrpc.h  |   1 +
 net/rxrpc/ar-internal.h       |  14 +--
 net/rxrpc/call_event.c        |  22 +----
 net/rxrpc/call_object.c       |   2 +
 net/rxrpc/conn_event.c        |  32 +++----
 net/rxrpc/insecure.c          |   8 +-
 net/rxrpc/recvmsg.c           |  68 ++++++++++++---
 net/rxrpc/rxgk.c              | 160 ++++++++++++++--------------------
 net/rxrpc/rxgk_app.c          |  46 ++++------
 net/rxrpc/rxgk_common.h       |  66 +++++++-------
 net/rxrpc/rxkad.c             | 115 +++++++++---------------
 14 files changed, 309 insertions(+), 305 deletions(-)


