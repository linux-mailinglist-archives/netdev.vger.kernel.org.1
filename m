Return-Path: <netdev+bounces-274056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNuCCtL7zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:04:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4213790B5
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E732E306EA34
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8777140B6E1;
	Wed,  1 Apr 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoHwJO+1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796E3D1714
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041052; cv=none; b=GGynzwxy1XT3Sr1e5Wo9KHI3dB+Iw6E08HndqNFzk710iMDD1hPsA2R3Wmf7e89gg80MTQu1z5YO/5XbFh8fVoCMVY6ZyEqgxLAGtTNwsZYz/ix9CBfjNG2n/Q7y5HYnnUmtvB6L8+u8SkXymYur1LvAIgjiB2IbzrwOIu9+nWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041052; c=relaxed/simple;
	bh=GVaGOg5XzUZkGQvl2oMBK566BhyRcXzXiuQrO4tMk2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgyJgirC5LxQm5QZQBILFbzYkG7QjvMOK74v8yjPHxUvqt161XEjzz63S91f9qRwjSRPfXW4juxePHpIbGlaNfFj3laqPsqORJJNR6jhb3XIU81vTMtbcr7GDApX0Gp4MDJPd3eAYOovUVrvbQujWGmR0bCZwpbY3UCkmZHaw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoHwJO+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XgIGNcrY/xUhk108tuLpob5a6M3Bi/f07YnbtomyLc=;
	b=HoHwJO+1DXPsJWGrndspqlQj/LGgrtv+2stW64+Im7N6yvl7pvEnl8sOoxtCG+kuaKHzTC
	f2ITWF6QXiy1/QPdroaoOtOg1VSRbPtBoY3Dfr/vDFaWExd7VNTJcS1AJT/Kuc6KEUtjiD
	TEP2kERy5cLzcXTjeeMiEcYLOu5Iqkc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-JRV-RMLrM6aOxjLlMnhlpQ-1; Wed,
 01 Apr 2026 06:57:26 -0400
X-MC-Unique: JRV-RMLrM6aOxjLlMnhlpQ-1
X-Mimecast-MFC-AGG-ID: JRV-RMLrM6aOxjLlMnhlpQ_1775041044
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAE4A18005B6;
	Wed,  1 Apr 2026 10:57:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF27A18016F9;
	Wed,  1 Apr 2026 10:57:20 +0000 (UTC)
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
	Marc Dionne <marc.c.dionne@gmail.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v4 10/15] rxrpc: Fix to request an ack if window is limited
Date: Wed,  1 Apr 2026 11:56:03 +0100
Message-ID: <20260401105614.1696001-11-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274056-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,infradead.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: 3D4213790B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marc Dionne <marc.c.dionne@gmail.com>

Peers may only send immediate acks for every 2 UDP packets received.
When sending a jumbogram, it is important to check that there is
sufficient window space to send another same sized jumbogram following
the current one, and request an ack if there isn't.  Failure to do so may
cause the call to stall waiting for an ack until the resend timer fires.

Where jumbograms are in use this causes a very significant drop in
performance.

Fixes: fe24a5494390 ("rxrpc: Send jumbo DATA packets")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 include/trace/events/rxrpc.h | 1 +
 net/rxrpc/ar-internal.h      | 2 +-
 net/rxrpc/output.c           | 2 ++
 net/rxrpc/proc.c             | 5 +++--
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index f7f559204b87..578b8038b211 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -521,6 +521,7 @@
 #define rxrpc_req_ack_traces \
 	EM(rxrpc_reqack_ack_lost,		"ACK-LOST  ")	\
 	EM(rxrpc_reqack_app_stall,		"APP-STALL ")	\
+	EM(rxrpc_reqack_jumbo_win,		"JUMBO-WIN ")	\
 	EM(rxrpc_reqack_more_rtt,		"MORE-RTT  ")	\
 	EM(rxrpc_reqack_no_srv_last,		"NO-SRVLAST")	\
 	EM(rxrpc_reqack_old_rtt,		"OLD-RTT   ")	\
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 36d6ca0d1089..96ecb83c9071 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -117,7 +117,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_jumbo[10];
 	atomic_t		stat_rx_jumbo[10];
 
-	atomic_t		stat_why_req_ack[8];
+	atomic_t		stat_why_req_ack[9];
 
 	atomic_t		stat_io_loop;
 };
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index d70db367e358..870e59bf06af 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -479,6 +479,8 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		why = rxrpc_reqack_old_rtt;
 	else if (!last && !after(READ_ONCE(call->send_top), txb->seq))
 		why = rxrpc_reqack_app_stall;
+	else if (call->tx_winsize <= (2 * req->n) || call->cong_cwnd <= (2 * req->n))
+		why = rxrpc_reqack_jumbo_win;
 	else
 		goto dont_set_request_ack;
 
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 59292f7f9205..7755fca5beb8 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -518,11 +518,12 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]),
 		   atomic_read(&rxnet->stat_rx_acks[0]));
 	seq_printf(seq,
-		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u stall=%u\n",
+		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u stall=%u jwin=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_ack_lost]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_more_rtt]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]),
-		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_app_stall]));
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_app_stall]),
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_jumbo_win]));
 	seq_printf(seq,
 		   "Why-Req-A: nolast=%u retx=%u slows=%u smtxw=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_no_srv_last]),


