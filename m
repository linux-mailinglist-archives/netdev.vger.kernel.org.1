Return-Path: <netdev+bounces-269481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK4ZJU4RvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:07:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BDB2CD678
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4EE3129F17
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6ED2D63E5;
	Thu, 19 Mar 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsNC2irP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858622EDD45
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932559; cv=none; b=MabWRkA9bY2g6S5eK7cUjYvpUlEt6DjaGyOC/vwrx6Pfyr+uVprTfL+8U0C3HEKvyPoM5dIm1cMeMv20JUpXbGAX2PtQ/6gf3X8qmt1vAbirx62K0FPadhz+SuyDW1FUFrBWSQBIC1QI/gHDGAmuWpOnLYZgEeIDwbIPWz4ZlZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932559; c=relaxed/simple;
	bh=ZZSl2R9yQzWHbw+Z9/N7SgiDuhKnLR6GjG12YGJUfh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEvXZRCXrVNmKIW0RdpwE7mnVTjNd+1UC3N6HkeVRWh929VDDP1rnGt7JaSTJLYSGHRsVExqG6FbKtm92Q8iWT0j8oCV0Gb2ZC8AvbqVOsryWo5a+JUomz9oaLuy8zRnglm9rK9ZXl/XUMPnhJ1S83Vt2kozHSiDlYT9P3qqY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsNC2irP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773932557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ebrJ62foz9xZtNO5QERusSf9DnH1BQTE5l7Qze0ryhw=;
	b=RsNC2irP9VckP8JAQhLhLLiP4cZ6S012/mWM62uEIZEaL6re11DAPgxWWRbZOzPpKH6gRY
	7qbkevYFnApngIzWfWR0qJIbpnKdgWWmhS4mnK91Vgn6Ofzh5wPvcA2zD1qg91cUgnG7r9
	+P5O4s9t6Ho7Hv4kMNIBu4jZC6ar+FM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-frajSfo6P9CxG_fz5_2REw-1; Thu,
 19 Mar 2026 11:02:35 -0400
X-MC-Unique: frajSfo6P9CxG_fz5_2REw-1
X-Mimecast-MFC-AGG-ID: frajSfo6P9CxG_fz5_2REw_1773932554
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FA671956089;
	Thu, 19 Mar 2026 15:02:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.45.224.65])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90D2230001A1;
	Thu, 19 Mar 2026 15:02:30 +0000 (UTC)
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
Subject: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Date: Thu, 19 Mar 2026 15:01:40 +0000
Message-ID: <20260319150150.4189381-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269481-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.957];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3BDB2CD678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here are some fixes for rxrpc:

 (1) Fix missing bounds checks when parsing RxGK tickets.

 (2) Fix use of wrong skbuff to get challenge serial number.

 (3) Fix unexpected RACK timer warning to report old mode.

 (4) Fix server keyring refcount leak.

 (5) Fix call key refcount leak.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Alok Tiwari (2):
  rxrpc: Fix use of wrong skb when comparing queued RESP challenge
    serial
  rxrpc: Fix rack timer warning to report unexpected mode

Anderson Nascimento (2):
  rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
  rxrpc: Fix key reference count leak from call->key

Oleh Konko (1):
  rxrpc: Fix RxGK token loading to check bounds

 net/rxrpc/af_rxrpc.c    |  2 +-
 net/rxrpc/call_object.c |  1 +
 net/rxrpc/conn_event.c  |  2 +-
 net/rxrpc/input_rack.c  |  2 +-
 net/rxrpc/key.c         | 30 +++++++++++++++++-------------
 5 files changed, 21 insertions(+), 16 deletions(-)


