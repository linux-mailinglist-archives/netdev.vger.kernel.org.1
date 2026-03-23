Return-Path: <netdev+bounces-270580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ONlFdJbwWlZSgQAu9opvQ
	(envelope-from <netdev+bounces-270580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:27:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B62F64EC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEEEF33F73CD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E63B2FED;
	Mon, 23 Mar 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnSoU8nr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB03B27F3
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278328; cv=none; b=GGUGMkFVJSufPPfk3ApTRCKY2eCyGJP+k/gdVk0hn1/ET6Q7WLlYSc9Atb2ttDmBFr03AK2rpJK4ludAV4DFwAS5kGGxV+6Gb7HKnLirqHTfS+FJUXabaYjrwZrJUEBJ+fgBFjPAZBnTEOq54tynRYsM5UVGoQmi/ZmmosC7HqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278328; c=relaxed/simple;
	bh=pPlspyNj4n+vvkKxerUv66d87Gnnx+6OnZiz8DvMiPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiacSJ8hH6z0vwBJC0chmSvQX7BdYuipGT9VmgHuYqQudMNLSFT+RUH+yPUHcrvPWoacqbGUb+/yOv/uGiHsBnYoXQco5OwZy967rMmQ728Ajifl0lFzxstRbC0Qzo+EsPtOgLJRzERmkzj9AFElwYG6dHgbkhRHg+V7VIotEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnSoU8nr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774278325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nk9vvWE5q4tAXOhjDvn4XjSlgx7RjlQ36W0BymAHfk0=;
	b=bnSoU8nrwFlUxnYGpm9vPOxDbHx8n2ZS/4z+wzmrVWKHqKcMb9rStDZbhvl7gzf4AmkGpS
	cBXcKYlPiKCi2axFhZgXM6kMaooo5Ce1b5tUiXBvZ1mK19We0PrU67BGH8hSYgazW1KQG9
	OoZc0MqWFmC2O0IwBiEtcKNkLQSmDWE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-5WXzMz2rMTWHE3Bh3_Za-w-1; Mon,
 23 Mar 2026 11:05:22 -0400
X-MC-Unique: 5WXzMz2rMTWHE3Bh3_Za-w-1
X-Mimecast-MFC-AGG-ID: 5WXzMz2rMTWHE3Bh3_Za-w_1774278314
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 370011955D78;
	Mon, 23 Mar 2026 15:05:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDC68180075B;
	Mon, 23 Mar 2026 15:05:09 +0000 (UTC)
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
Subject: [PATCH net v2 00/10] rxrpc: Miscellaneous fixes
Date: Mon, 23 Mar 2026 15:04:51 +0000
Message-ID: <20260323150505.3513839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-270580-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AD0B62F64EC
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

With respect to the AI review[1]:

 (*) The use of rcu_read_lock_held() to avoid deferring call cleanup off to
     a worker thread needs more consideration and so is unaddressed here.
     I don't want to defer the cleanup if I can avoid it, but I'm not sure
     how better to do it.

 (*) rxrpc_put_call() shouldn't now be called in irq or softirq contexts,
     even from a timer; __refcount_inc_not_zero() and a spinlock are used
     in rxrpc_poke_call() to render that unnecessary.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
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

Oleh Konko (1):
  rxrpc: Fix RxGK token loading to check bounds

 include/linux/list.h               | 26 ++++++++++++++++++++
 include/trace/events/rxrpc.h       |  1 +
 net/rxrpc/af_rxrpc.c               |  2 +-
 net/rxrpc/call_object.c            |  7 +++---
 net/rxrpc/conn_event.c             |  5 ++--
 net/rxrpc/input_rack.c             |  2 +-
 net/rxrpc/key.c                    | 38 +++++++++++++++++-------------
 net/rxrpc/sendmsg.c                |  2 +-
 security/apparmor/include/policy.h |  2 --
 9 files changed, 59 insertions(+), 26 deletions(-)


