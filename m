Return-Path: <netdev+bounces-77717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F70872B94
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 01:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202E41F2B942
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC8121106;
	Wed,  6 Mar 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFTNkKGW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F06D2F0
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683659; cv=none; b=b3FU5G/SPTPTkaqalHqcqnX3fxSHUipjaukuhID/uPVfGHT4iWpNySi4kHeeS64gMVdLkFS282q+CmmqSQGJF+Ui9wn7Iv4oyKPC4ZAvTuPlKQNkHSHC/Xam2jwjzJg+uZdkFc5TFVB9OrlSxBQD0IOr9EQO2YT2nw3UahE1pGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683659; c=relaxed/simple;
	bh=ljMsL1C2LYCeeJeMBEdzm9LuanQgXWoC+/BDvOiBmDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWFlXBzE3WOm7r58DD2kD+IBtuTrvc8bu4xpyPTjVKOC3lea6xPJVIrz1fF+fdCHO1/dnd4gjUYuwdtAnSpAVTCo2m0LfvAhPpFOy/ajR8OJ2WkcfTzbReaXX6k3wRStjZrNQLLtCbqNlO6w41guGNJnMI3FmwknqOQc6KDtSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFTNkKGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709683657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5AUx7yIzfKd4QjuMWluENnnnPZkBpDZmSme9BhaoSY=;
	b=fFTNkKGWAXlw9oke8AF9MlJMp9QNedWCGvlfCbBq/2oukHIHvUoyDX7JHRFuM/sVb57gJ9
	/iIUONwcHjEtT5pi3j2UACaImPkp0t5JGV+q0C0uYa5lxd+ZQMszhbCK8ndrAVvO9KS2Av
	OBp+1gSGCJXtvhCJkwvrfnxlKMdJP1c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-dZlkstzvOjiNgugmgby_Qw-1; Tue,
 05 Mar 2024 19:07:31 -0500
X-MC-Unique: dZlkstzvOjiNgugmgby_Qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5381C02D2E;
	Wed,  6 Mar 2024 00:07:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 063DC492BCB;
	Wed,  6 Mar 2024 00:07:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 15/21] rxrpc: Parse received packets before dealing with timeouts
Date: Wed,  6 Mar 2024 00:06:45 +0000
Message-ID: <20240306000655.1100294-16-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Parse the received packets before going and processing timeouts as the
timeouts may be reset by the reception of a packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index e19ea54dce54..58826710322d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -358,6 +358,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 	if (skb && skb->mark == RXRPC_SKB_MARK_ERROR)
 		goto out;
 
+	if (skb)
+		rxrpc_input_call_packet(call, skb);
+
 	/* If we see our async-event poke, check for timeout trippage. */
 	now = jiffies;
 	t = call->expect_rx_by;
@@ -417,9 +420,6 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		resend = true;
 	}
 
-	if (skb)
-		rxrpc_input_call_packet(call, skb);
-
 	rxrpc_transmit_some_data(call);
 
 	if (skb) {


