Return-Path: <netdev+bounces-286736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC+vBaEEAmo3nQEAu9opvQ
	(envelope-from <netdev+bounces-286736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:32:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21474512346
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E73F1312D231
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1718426ED6;
	Mon, 11 May 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxkAj2N9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724C402BB4
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515692; cv=none; b=DMk1m/JZ92Y2oNBPs/ch9cdZG2TqDIf8F1/Twh2KulBF53C1AORPHljpM9fC0fwqSU1H/dDRE9bh4c3vJsukBxErJYy0vafsYV03+J6Xtl73Bov1fuQmRlryNAulJy9XhkGMwmZ62I19iSKEfTMi+avJ76jwerXRXmeJRFGN+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515692; c=relaxed/simple;
	bh=HK4MCwhfyt9ibnRO04VTu4Jdd7IDk7J0IS6n+D1jTnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuSrC4y6ar/Gn1IitmEBc0OQLIaQzmqK2BGBfbGeLRMxfGP9veXIzeztZy0GsU6pGtlK1MSqZTNQSklB08FccjbsXNP/TYp72DNQlqFaoSk5xxuhLc26oc13fZWZ7hZSF49YLfew5pZ7hACNQ28ISEVC209ZZNBMUFa3HFeMyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxkAj2N9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778515690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JW3MiTOFMa2gQ0jtbM/Ke7EaW8T6dpP8mKSUpldJkdA=;
	b=VxkAj2N9Cs/LAY4ekzeMj9JCSX17IeapbzUx0IxfVGwsaOQ5U8C0caEckilxntWHswtKvk
	UOHAe1cKgRGyl+yIiJttwTcNWyo7lWk1pJt/rCknl/StN4d6bK4f6igGusM83fO/pkRNSp
	ENhi+WRNb/OyT4cTFYRIo0/1gB7/e5o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-lLr3-bHjPJOeoZiHGs72LA-1; Mon,
 11 May 2026 12:08:05 -0400
X-MC-Unique: lLr3-bHjPJOeoZiHGs72LA-1
X-Mimecast-MFC-AGG-ID: lLr3-bHjPJOeoZiHGs72LA_1778515683
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40A9E19560A6;
	Mon, 11 May 2026 16:08:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 277781800465;
	Mon, 11 May 2026 16:07:58 +0000 (UTC)
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
Subject: [PATCH net 0/3] rxrpc: Better fix for DATA/RESPONSE decrypt vs splice()
Date: Mon, 11 May 2026 17:07:46 +0100
Message-ID: <20260511160753.607296-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 21474512346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286736-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Here are two patches containing better fixes for the in-place decryption of
DATA and RESPONSE packets that can corrupt pagecache spliced into UDP
packets and sent to an AF_RXRPC server [CVE-2026-43500].

[!] Note that Hyunwoo Kim's fix is included as that is a prerequisite for
the main patches to build.  This is in Linus's tree, but not yet net/main.

One patch fixes DATA decryption by having recvmsg unconditionally extract
the data into a flat bounce buffer and, if need be, decrypt it there.  It
doesn't seem to cause a performance problem to do this even on unencrypted
packets; for encrypted packets it makes sure the content is correctly
aligned for crypto which seems to get a small performance gain.

Further, it means that DATA packets are no longer copied in the I/O thread,
avoiding a slowdown of the protocol engine that runs there.

The other patch fixes RESPONSE decryption by having the connection event
handler worker copy the data to a flat buffer and, again, decrypt it there.
This simplifies RESPONSE handling.

With these two fixes, the data content of the received sk_buff no longer
gets altered.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (2):
  rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in
    recvmsg
  rxrpc: Fix RESPONSE packet verification to extract skb to a linear
    buffer

Hyunwoo Kim (1):
  rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present

 net/rxrpc/ar-internal.h |  77 ++++++++++++++++--
 net/rxrpc/call_event.c  |  20 +----
 net/rxrpc/call_object.c |   2 +
 net/rxrpc/conn_event.c  |  32 ++++----
 net/rxrpc/insecure.c    |   8 +-
 net/rxrpc/protocol.h    |   1 -
 net/rxrpc/recvmsg.c     |  72 +++++++++++++----
 net/rxrpc/rxgk.c        | 175 ++++++++++++++--------------------------
 net/rxrpc/rxgk_app.c    |  91 +++++++++------------
 net/rxrpc/rxgk_common.h |  76 ++++++++---------
 net/rxrpc/rxkad.c       | 175 +++++++++++++++-------------------------
 11 files changed, 349 insertions(+), 380 deletions(-)


