Return-Path: <netdev+bounces-167481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6FBA3A749
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B66188B8B9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B91EB5F1;
	Tue, 18 Feb 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzc4oCNd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA291EB5EB
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906598; cv=none; b=rD0oQ3FP/kyUUL8t9/iWsdsJ9kCBPvejCs/40MHh4tXnq+zxQ3429atCZUy5xdbxP7usos5osWn0/LOgMDkwokP5NYhvPov1HwSOSPHsOm1+q02ljbXcpSF73AUSv2fnYZqGRRZlZUNHFuIx/KNP6x59BGFo2fAbFI4guiPDb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906598; c=relaxed/simple;
	bh=eZXHQ2G41uUOKVDh8j9cpZv9XKLuoY45JwNn5kAktpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1iXTPK+1LGPcyjG1SOyUKyg2b3A+3xr6mopsCWgpUpV2dMyPafayk8IuSj8g864XoHiWpk3d8HEBHk2g5hYSGoGT/lNVok8t4l3TCQ5ZcKWgNs5Jll8YeH+QckrIgjr53Z4naavhrSAMw4QMyAa6vBXNKDBO0hH7a2v1LdhUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzc4oCNd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaiYoCGsFpAWLKJ3d+qpfykW2KxLfKQHY0MVDwtgSTg=;
	b=Yzc4oCNdLGbg1Xb/UE5i3+TG9ajDJICGke5yArY+h0lzT1TEfWRWnOEMFaVFqgjk1XBjoS
	C42em6OsBF1dZNCKEbcfKcFsuPXacGDNRplb5PNfD1edLakPpgWlQxsg4Ep2nGFuhEe6fE
	DTIfKJ3ti46e7Q/2y5B6KeyOT6l/Mq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-NCeu0UUnNc-PQ1hbDUvhMg-1; Tue,
 18 Feb 2025 14:23:12 -0500
X-MC-Unique: NCeu0UUnNc-PQ1hbDUvhMg-1
X-Mimecast-MFC-AGG-ID: NCeu0UUnNc-PQ1hbDUvhMg_1739906589
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 669641800873;
	Tue, 18 Feb 2025 19:23:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 890AC1800359;
	Tue, 18 Feb 2025 19:23:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 3/5] rxrpc: Fix locking issues with the peer record hash
Date: Tue, 18 Feb 2025 19:22:46 +0000
Message-ID: <20250218192250.296870-4-dhowells@redhat.com>
In-Reply-To: <20250218192250.296870-1-dhowells@redhat.com>
References: <20250218192250.296870-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

rxrpc_new_incoming_peer() can't use spin_lock_bh() whilst its caller has
interrupts disabled.

    WARNING: CPU: 0 PID: 1550 at kernel/softirq.c:369 __local_bh_enable_ip+0x46/0xd0
    ...
    Call Trace:
     rxrpc_alloc_incoming_call+0x1b0/0x400
     rxrpc_new_incoming_call+0x1dd/0x5e0
     rxrpc_input_packet+0x84a/0x920
     rxrpc_io_thread+0x40d/0xb40
     kthread+0x2ec/0x300
     ret_from_fork+0x24/0x40
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    irq event stamp: 1811
    hardirqs last  enabled at (1809): _raw_spin_unlock_irq+0x24/0x50
    hardirqs last disabled at (1810): _raw_read_lock_irq+0x17/0x70
    softirqs last  enabled at (1182): handle_softirqs+0x3ee/0x430
    softirqs last disabled at (1811): rxrpc_new_incoming_peer+0x56/0x120

Fix this by using a plain spin_lock() instead.  IRQs are held, so softirqs
can't happen.

Fixes: a2ea9a907260 ("rxrpc: Use irq-disabling spinlocks between app and I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/peer_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 2ddc8ed68742..56e09d161a97 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -324,10 +324,10 @@ void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 	hash_key = rxrpc_peer_hash_key(local, &peer->srx);
 	rxrpc_init_peer(local, peer, hash_key);
 
-	spin_lock_bh(&rxnet->peer_hash_lock);
+	spin_lock(&rxnet->peer_hash_lock);
 	hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
 	list_add_tail(&peer->keepalive_link, &rxnet->peer_keepalive_new);
-	spin_unlock_bh(&rxnet->peer_hash_lock);
+	spin_unlock(&rxnet->peer_hash_lock);
 }
 
 /*


