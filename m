Return-Path: <netdev+bounces-288027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIm1IBLwBWq3dgIAu9opvQ
	(envelope-from <netdev+bounces-288027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:53:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE9544552
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E5E3038142
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015D2E8DEA;
	Thu, 14 May 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8YV4Yj6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D2316197
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774000; cv=none; b=Gtxz16KfnEJsdqJgA7YILtNR0ERFPsVmwty7qW/MCGsGpRwfsImBupDWE5yHT5eKrC3h9BuVGst+Z1twmjqIbPDkIqUwO/XgeGPtwcOvWHGRjq/yxk6/hfpiUUoJWfnOVrv0hFnF4mCgZkEOsN5b25Ig77AZnCj59AuwdBzp074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774000; c=relaxed/simple;
	bh=l+rLmMg/hVX2hhsETNj9o6r4r9qcBCC30BsnxOxqUDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwO9LyjNaDZRlXl5lL3Do+eLEs45P27D+VbkM42EHhTosbk53cGh8MifW6SpC6Z4RnTJZU8a5NxVcDl0xjuxr3x5Z7iQuNzUQ7gS9xay79fO6oCXNotXn7cIenZD/a0FGFhkq2n2ZuJiFIY/nIlWlP6QWUBsJaFbPuersYGSfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8YV4Yj6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778773997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wPJD4cSvgohi5bUcmXKy4d3gwoNT23eATH97E0wX5lw=;
	b=f8YV4Yj6aVnGFNvDvQDzPh1VBg/zx5S6FdS53xcrEquDONcJFDL97jRU2of+uIrMwT1yla
	6eWpkrzqAaA6MV4gNwY/wMd8bqX/AnBcKX+xqyRd6ZtQJ1CTEuiQTMXrenpjXf3YRby5Am
	4a0k2EYfJnlc278syF/lQCHweP5hstU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-aVvCfNSXPFq9J8wwaUEzPw-1; Thu,
 14 May 2026 11:53:14 -0400
X-MC-Unique: aVvCfNSXPFq9J8wwaUEzPw-1
X-Mimecast-MFC-AGG-ID: aVvCfNSXPFq9J8wwaUEzPw_1778773993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47831180061E;
	Thu, 14 May 2026 15:53:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37AF130002DA;
	Thu, 14 May 2026 15:53:07 +0000 (UTC)
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
Subject: [PATCH net v3 0/4] rxrpc: Better fix for DATA/RESPONSE decrypt vs splice()
Date: Thu, 14 May 2026 16:52:58 +0100
Message-ID: <20260514155304.2249591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: DFFE9544552
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288027-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
 net/rxrpc/conn_event.c        |  29 +++---
 net/rxrpc/insecure.c          |   8 +-
 net/rxrpc/recvmsg.c           |  76 +++++++++++++---
 net/rxrpc/rxgk.c              | 160 ++++++++++++++--------------------
 net/rxrpc/rxgk_app.c          |  46 ++++------
 net/rxrpc/rxgk_common.h       |  66 +++++++-------
 net/rxrpc/rxkad.c             | 115 +++++++++---------------
 14 files changed, 315 insertions(+), 302 deletions(-)


