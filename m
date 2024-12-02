Return-Path: <netdev+bounces-148078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD09E0547
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A17716B99A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86685209F51;
	Mon,  2 Dec 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewdg03xi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5168205E05
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149920; cv=none; b=dz2smFH3gwSmwWsokjeLhhIdCuwc6AYwnUoogje15ZOpemB94WNZlHxH9nFEZvdkkxm3Ji3Nh+qjIlDSV0v3JYvOv+4IVbxXLwATZMZ7l8icM6uZPECfb23Nj5NC2taOHLpONjuyZYzgmXbLV7e+iElY1co6A9T5JUSnaxitw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149920; c=relaxed/simple;
	bh=rQ3W2F3r6HiohVE0vY/OBK/76HhFWdieLGVWaORhDMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm+bg8opK6YNs8wWSls64RsurgrcP8H0lU7fyhhXRHZAbh4RIUDS06damTekuwLlgqjXTbITgYWUy/G9kfPw0vAmplAkJDVjOGxRyM/DWqhNoqJhO+Jt3SsNO5VnS29tuIUS+vtJm/Qi56UpMx0ehPqAIFZsVThdGcG1oDjCNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ewdg03xi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obq27x78dLFVc+cuRfM1jM6wMytnV14P+u4LaoDA4AU=;
	b=Ewdg03xi71DO64YF7yr5efHvQdaJGYVx7blHo7AUwrhpKBHPpXRHuP1gbdjHipdxyTizIP
	7FP7hCP9eDaCVJvnH/9Zp1ic/0SYOvWU7LTdMzsY/h4GuKtGbQ8KxhhImSVCgDb2moEAf6
	qevwLa5nBNgcXTdxtjkh0VpN40NWyJU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-ZOjw3ZL8MdimR3D-8UBnNA-1; Mon,
 02 Dec 2024 09:31:54 -0500
X-MC-Unique: ZOjw3ZL8MdimR3D-8UBnNA-1
X-Mimecast-MFC-AGG-ID: ZOjw3ZL8MdimR3D-8UBnNA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDDE019373E6;
	Mon,  2 Dec 2024 14:31:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9AE11955EA8;
	Mon,  2 Dec 2024 14:31:46 +0000 (UTC)
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
Subject: [PATCH net-next 11/37] rxrpc: Add a tracepoint to show variables pertinent to jumbo packet size
Date: Mon,  2 Dec 2024 14:30:29 +0000
Message-ID: <20241202143057.378147-12-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add a tracepoint to be called right before packets are transmitted for the
first time that shows variable values that are pertinent to how many
subpackets will be added to a jumbo DATA packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 41 ++++++++++++++++++++++++++++++++++++
 net/rxrpc/call_event.c       |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 9dcadad88e76..71f07e726a90 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -903,6 +903,47 @@ TRACE_EVENT(rxrpc_txqueue,
 		      __entry->tx_winsize)
 	    );
 
+TRACE_EVENT(rxrpc_transmit,
+	    TP_PROTO(struct rxrpc_call *call, int space),
+
+	    TP_ARGS(call, space),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_seq_t,	seq)
+		    __field(u16,		space)
+		    __field(u16,		tx_winsize)
+		    __field(u16,		cong_cwnd)
+		    __field(u16,		cong_extra)
+		    __field(u16,		in_flight)
+		    __field(u16,		prepared)
+		    __field(u16,		pmtud_jumbo)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->seq	= call->tx_bottom;
+		    __entry->space	= space;
+		    __entry->tx_winsize	= call->tx_winsize;
+		    __entry->cong_cwnd	= call->cong_cwnd;
+		    __entry->cong_extra	= call->cong_extra;
+		    __entry->prepared	= call->tx_prepared - call->tx_bottom;
+		    __entry->in_flight	= call->tx_top - call->acks_hard_ack;
+		    __entry->pmtud_jumbo = call->peer->pmtud_jumbo;
+			   ),
+
+	    TP_printk("c=%08x q=%08x sp=%u tw=%u cw=%u+%u pr=%u if=%u pj=%u",
+		      __entry->call,
+		      __entry->seq,
+		      __entry->space,
+		      __entry->tx_winsize,
+		      __entry->cong_cwnd,
+		      __entry->cong_extra,
+		      __entry->prepared,
+		      __entry->in_flight,
+		      __entry->pmtud_jumbo)
+	    );
+
 TRACE_EVENT(rxrpc_rx_data,
 	    TP_PROTO(unsigned int call, rxrpc_seq_t seq,
 		     rxrpc_serial_t serial, u8 flags),
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 3379adfaaf65..1f716f09d441 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -259,6 +259,8 @@ static void rxrpc_decant_prepared_tx(struct rxrpc_call *call)
 		if (list_empty(&call->tx_sendmsg))
 			break;
 
+		trace_rxrpc_transmit(call, space);
+
 		spin_lock(&call->tx_lock);
 		do {
 			txb = list_first_entry(&call->tx_sendmsg,


