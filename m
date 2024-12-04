Return-Path: <netdev+bounces-148872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF969E3498
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980C28428A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55E1C1F12;
	Wed,  4 Dec 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOTtUe4B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305321BF804
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298555; cv=none; b=UTWqGZXCF/VzKDml+vv4iqdI28H8EUIyyzuPVYyLIhHlWxJskoo0X9iHS0lhNNTpyIv+PDNBTe189xUXtNNqI6J1ny8X1Eqyui8InvedL5Rn50pmLlAP23axOKdqTCTw6g8yq9PxDfjvmmnPOfRcymvl2p2bdoLUYj25wSjjcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298555; c=relaxed/simple;
	bh=saYqm8EOVeANEoTXWTw6WdkYn+balXtt2gaiRxIUU/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhJSfvthooqXxxw+sEDzhXm33rOzzPfAEJTsC9psHuPBlovq1yRWF0X+PdVjd2RwwTzLv4xLOWTpg87uk4PmZkxNSHDbKvXpluwtAjEb89NOPEzONHrmjWn3bAFpyzYzi9BbdhSRdkNqPDlv9D5rFSthkTK/tUEwJR86/WPlayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOTtUe4B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3beAahzzp/czYsbi3q6+uyRb7JHtNp9XY3LLvT2nIA=;
	b=DOTtUe4BWcOsOO38R/0nkQwsawnIcMckw01Bc+BHQkT52BK8OJjEWZ9c5kypLVaw5QZVZb
	THTS1PfsjLJUDNwPz4UI7iQ9NxsPDZJ0xEizdr9KKJfeJ+Lb0DASCrI0gDlc/WFtu+CDc7
	WVh6Qr1SjlbjjWVBorkLpKrc97Po66c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-ldnLZdl8MGOxcgq1vqBU_w-1; Wed,
 04 Dec 2024 02:49:06 -0500
X-MC-Unique: ldnLZdl8MGOxcgq1vqBU_w-1
X-Mimecast-MFC-AGG-ID: ldnLZdl8MGOxcgq1vqBU_w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F7A1955F28;
	Wed,  4 Dec 2024 07:49:05 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A166F3000197;
	Wed,  4 Dec 2024 07:49:02 +0000 (UTC)
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
Subject: [PATCH net-next v2 26/39] rxrpc: Generate rtt_min
Date: Wed,  4 Dec 2024 07:46:54 +0000
Message-ID: <20241204074710.990092-27-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 297be421639c..d0d0ab453909 100644
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


