Return-Path: <netdev+bounces-148093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BA9E057C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8486D16BD02
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FD207A35;
	Mon,  2 Dec 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeHpxY3f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60320FA9B
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149970; cv=none; b=sstMD3cqrdFybXiX/7OniaBN08lx31opVY4gtYwQLXLPPOFbwsd7uxOU3Kl8whZfuZhn6kF3etwtPf46VfEwc4FmM5xqtPv+BmjnDhaVM9geecaMfmBn2B2f8N+Lces683/UvKXClS52YNFKSvXb8zW9s02gTFli82/2KvWdBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149970; c=relaxed/simple;
	bh=rrXphWx7QrOLsCBz3AC1ktSEv3T8W7Dz5tEizkKr8EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5jSBdcW/ooei643E8qEHdXi0MwoyMF1CDziqy/GGLlK9c8wdhYTBc6SocwDIKq2+FdO0UJBQ9fkyoTGLt1eIt3ez+KlcjfJl0bCHQbaAz8W8Gil/Alg8taFJuLj0y7ylbtHCbpnhMKmReSdNdXT2NdfjtH6F8aAWXVGLXBAaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CeHpxY3f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUaH/E/uQvvvUZnJpTOiFJnQsdMHKLQl3PlwZU/GdKE=;
	b=CeHpxY3fRRoiJgFuLM4e7WEUfqCcf1xB1/mHzKLgXxGkNodDPXuFgKY1hf19T/dutyTscT
	xxwC5+oVK0+4LvpgGrnvFsulIUwK9/5mqHARTpn6zoTewlJw24Fd3CT8+YS4yJbm9jpPxf
	50S7MxiI3sbTky/3NlJAaRSh9RyscLc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-AJO1ynnVMSK7KnrlHcqzPg-1; Mon,
 02 Dec 2024 09:32:44 -0500
X-MC-Unique: AJO1ynnVMSK7KnrlHcqzPg-1
X-Mimecast-MFC-AGG-ID: AJO1ynnVMSK7KnrlHcqzPg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96227192538E;
	Mon,  2 Dec 2024 14:32:42 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB6CE1955D45;
	Mon,  2 Dec 2024 14:32:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 24/37] rxrpc: Generate rtt_min
Date: Mon,  2 Dec 2024 14:30:42 +0000
Message-ID: <20241202143057.378147-25-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Generate rtt_min as this is required by RACK-TLP.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 lib/win_minmax.c        |  1 +
 net/rxrpc/ar-internal.h |  2 ++
 net/rxrpc/rtt.c         | 20 ++++++++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/win_minmax.c b/lib/win_minmax.c
index ec10506834b6..1682e614309c 100644
--- a/lib/win_minmax.c
+++ b/lib/win_minmax.c
@@ -97,3 +97,4 @@ u32 minmax_running_min(struct minmax *m, u32 win, u32 t, u32 meas)
 
 	return minmax_subwin_update(m, win, &val);
 }
+EXPORT_SYMBOL(minmax_running_min);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e68d0ecc4866..012b9bc283eb 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -371,6 +371,8 @@ struct rxrpc_peer {
 	spinlock_t		rtt_input_lock;	/* RTT lock for input routine */
 	ktime_t			rtt_last_req;	/* Time of last RTT request */
 	unsigned int		rtt_count;	/* Number of samples we've got */
+	unsigned int		rtt_taken;	/* Number of samples taken (wrapping) */
+	struct minmax		min_rtt;	/* Estimated minimum RTT */
 
 	u32			srtt_us;	/* smoothed round trip time << 3 in usecs */
 	u32			mdev_us;	/* medium deviation			*/
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index 6dc51486b5a6..8048467f4bee 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -127,16 +127,27 @@ static void rxrpc_set_rto(struct rxrpc_peer *peer)
 	peer->rto_us = rxrpc_bound_rto(rto);
 }
 
-static void rxrpc_ack_update_rtt(struct rxrpc_peer *peer, long rtt_us)
+static void rxrpc_update_rtt_min(struct rxrpc_peer *peer, ktime_t resp_time, long rtt_us)
+{
+	/* Window size 5mins in approx usec (ipv4.sysctl_tcp_min_rtt_wlen) */
+	u32 wlen_us = 5ULL * NSEC_PER_SEC / 1024;
+
+	minmax_running_min(&peer->min_rtt, wlen_us, resp_time / 1024,
+			   (u32)rtt_us ? : jiffies_to_usecs(1));
+}
+
+static void rxrpc_ack_update_rtt(struct rxrpc_peer *peer, ktime_t resp_time, long rtt_us)
 {
 	if (rtt_us < 0)
 		return;
 
-	//rxrpc_update_rtt_min(peer, rtt_us);
+	/* Update RACK min RTT [RFC8985 6.1 Step 1]. */
+	rxrpc_update_rtt_min(peer, resp_time, rtt_us);
+
 	rxrpc_rtt_estimator(peer, rtt_us);
 	rxrpc_set_rto(peer);
 
-	/* RFC6298: only reset backoff on valid RTT measurement. */
+	/* Only reset backoff on valid RTT measurement [RFC6298]. */
 	peer->backoff = 0;
 }
 
@@ -157,9 +168,10 @@ void rxrpc_peer_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 		return;
 
 	spin_lock(&peer->rtt_input_lock);
-	rxrpc_ack_update_rtt(peer, rtt_us);
+	rxrpc_ack_update_rtt(peer, resp_time, rtt_us);
 	if (peer->rtt_count < 3)
 		peer->rtt_count++;
+	peer->rtt_taken++;
 	spin_unlock(&peer->rtt_input_lock);
 
 	trace_rxrpc_rtt_rx(call, why, rtt_slot, send_serial, resp_serial,


