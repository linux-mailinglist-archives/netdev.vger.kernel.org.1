Return-Path: <netdev+bounces-148874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F99E349A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1289E1669D8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC9192D91;
	Wed,  4 Dec 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvscBdzs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B3192D86
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298560; cv=none; b=PfgbPgQj0+DvNyEwecvteOLNXumPMFZx1zJUsYVG/fSp6EII0RfRVjX/lqiTAFYSp2TkVYFV+8eBdNtM1KN2RUghtD2hpymq9LyRpJNhWXz4v6Tx1MCijjwkinzckx6rkC+hUOQ6B6AZDG/2tL1j/Yt5VKKSGOOtcIK0zn6KbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298560; c=relaxed/simple;
	bh=3btpIzUrc/ggkCKYwyGitI0UwmXR12kkUzIboNem7/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8/oTyTWheIN2k0mXyWlgqKtS67DaOMEcS94LynnssF5Z8JueTylCslcemkztTcgQoHCwnJLrfQlvQxRPdMHbOdsNRACEOOLn1t0x6bhnivYa+xEFxiA3NiGr+2BVWEGwoeTjwa8Q+FX2aXegt2rnOApTn2uXbshNDOPXnwKNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvscBdzs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4k7JdZ9wo1FEl+k5fitGAIvj93CLuEOezWNS09/9ews=;
	b=dvscBdzsTuiM+myhnP9u5QVi8POY9hzmMMCOI2mhQ9H0GFhCFQclAlz5VUd4lZJ+dWqLaf
	U7Km7vi8VPhZ7h2hU5TttR03+lyMWAbAaA74XVVr+XTFdMp/mnuEMvCJIkiW4efg+nbJju
	WZ24OHsiSDDejqGCGLy8XxXaK5Kts80=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584--tX0nxSnP0WTU0aytHnbQQ-1; Wed,
 04 Dec 2024 02:49:14 -0500
X-MC-Unique: -tX0nxSnP0WTU0aytHnbQQ-1
X-Mimecast-MFC-AGG-ID: -tX0nxSnP0WTU0aytHnbQQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 339B11955DCA;
	Wed,  4 Dec 2024 07:49:13 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A93FB1956048;
	Wed,  4 Dec 2024 07:49:10 +0000 (UTC)
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
Subject: [PATCH net-next v2 28/39] rxrpc: Display userStatus in rxrpc_rx_ack trace
Date: Wed,  4 Dec 2024 07:46:56 +0000
Message-ID: <20241204074710.990092-29-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Display the userStatus field from the Rx packet header in the rxrpc_rx_ack
trace line.  This is used for flow control purposes by FS.StoreData-type
kafs RPC calls.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 6e929f4448ac..7681c67f7d65 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1031,11 +1031,13 @@ TRACE_EVENT(rxrpc_rx_ack,
 		    __field(rxrpc_seq_t,	prev)
 		    __field(u8,			reason)
 		    __field(u8,			n_acks)
+		    __field(u8,			user_status)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call	= call->debug_id;
 		    __entry->serial	= sp->hdr.serial;
+		    __entry->user_status = sp->hdr.userStatus;
 		    __entry->ack_serial = sp->ack.acked_serial;
 		    __entry->first	= sp->ack.first_ack;
 		    __entry->prev	= sp->ack.prev_ack;
@@ -1043,11 +1045,12 @@ TRACE_EVENT(rxrpc_rx_ack,
 		    __entry->n_acks	= sp->ack.nr_acks;
 			   ),
 
-	    TP_printk("c=%08x %08x %s r=%08x f=%08x p=%08x n=%u",
+	    TP_printk("c=%08x %08x %s r=%08x us=%02x f=%08x p=%08x n=%u",
 		      __entry->call,
 		      __entry->serial,
 		      __print_symbolic(__entry->reason, rxrpc_ack_names),
 		      __entry->ack_serial,
+		      __entry->user_status,
 		      __entry->first,
 		      __entry->prev,
 		      __entry->n_acks)


