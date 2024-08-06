Return-Path: <netdev+bounces-116139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A094940F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25A2281D18
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570341BC08F;
	Tue,  6 Aug 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZYCmt8/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724018D653
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956530; cv=none; b=tNF9DqmNAqgb3M5WVZCaHyn7pt1HOKyX+1AuEzW/LbsAPeTblqLoP5FIVUhW4Rl8ce94c/t3dk+nm6tUbcFy1VzyrcJCHBsxuBxwoxKYRVrUgcy8NamFmFI6UN7+EM4UqU9k9wNZsVASEQ1DzYjnyoeB5BjBqt7vE6O9Js0PA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956530; c=relaxed/simple;
	bh=grLCEFMWacuVjzTT+kELouyRVgjKdlzMIEXuG8Ba9nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rC5uxPYFCm0jPNjex4JplRfohaYjviXjtc8uNhZMqoD8jfDpqQNqTfj02r3FoFG6RYU8/WYdPP1rqeUQde9iSXRErKcWpuy9w4Tegkq0wBrYHMaaKZGhirTCFyDnX1kv3IvHhnYzymFpdvgoBlQ2tCHTNc2kv1pTaQLeopcvnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZYCmt8/C; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4D5573F1EF
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722956523;
	bh=jhY/iAGFtGz8gkbOZN5MeWQH+e0m91DhNqvU5T5zzp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ZYCmt8/CbIdp8WP0k1re/0+NOe3+4nYo4UWE7nsrWSYoF8GCfkZGHCHcKU1Tbjjkq
	 65y8QDHCjnsiz4tr8hRhcAqjB/w3THzxI0RUHz093SYokatlujepNPQsaQiyMHoMip
	 //RygbQkFAxDpg+Co3u4gbx02k/C9P6i3ZBC/sOzUWPxNdEyugmscXfvTsr0908OLS
	 WKBa/XzXIPcU0EVnUDBaKWQruQbQoMbjubWVndSS1zJH7O0UpO5wCI7iutCyxhilFv
	 NWYi4s8TmuvcUe90tXSMrIwNMCh5RFU2MPxVVk4fP+NqHaAlZir5BDJPebrgBaMzug
	 XJk30vzsmvYMA==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efce218feso1115441e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722956522; x=1723561322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhY/iAGFtGz8gkbOZN5MeWQH+e0m91DhNqvU5T5zzp4=;
        b=VpiOF8sYquNEejux+Z8qXLyJMe71pWQGr8ICpLDiXFNddd+7Qr8zekCFwy+bEoOJV3
         3ifpJ8bgYyRpK+qmvG6ihcXKF8g9d25Cm8PmAloNvHrrzJZ/oZOmbHlOAxxmDNI7jFcO
         PEHS6SP7b53FGmv2Ho0YZF+Nbqcb22NQiROKoFoOb5fsw3ORrDfP06cugCbq96+Jg6Di
         p3Hf3hfD+sc+eDy8xmTVTOrS71qHm2wlnCkW9qt2a+h1AjSVnhRqQ41oV5EQc6Wyix0r
         yIaOVQ87qXaU5I8rbtIW7HjpubG/jVnNd1BcaQyHATG1Ydl7mA+NthJkGtrOBebzVSqN
         2CQg==
X-Forwarded-Encrypted: i=1; AJvYcCUnP8XRKbPQzghwAY1DJ8a+mVBDm5W4FVYHvQiUmxwnswbl2YVKMLpJZdljuk/C6TScGbSCz5O3JDfaDX9YusRq8Jau+xul
X-Gm-Message-State: AOJu0YylZbidDdzHM3uHm7mkD3vSxQYRNxnJQI0VlgeuJJKwrVwiCKkC
	zOqGX0ee3J3BV1wyQgT7gQ1DiFH1MlEjzqMPfnO7o43zACq11wDJwVqagLX97CnQEPq8X9LOyIh
	U16v9uNxeJkXvm7tPKwbpgjcbNygGHDjAcJXmyrqO7/phoXOixAPaGlXcu748tZMXd2Jp8EuCF3
	jQQ6bX
X-Received: by 2002:a05:6512:12d2:b0:530:ab68:25e6 with SMTP id 2adb3069b0e04-530bb395e96mr10009281e87.48.1722956522159;
        Tue, 06 Aug 2024 08:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEif65fL/GscmO4p1g1gNA0DbXGZyCAeXXHdeLEknaHECNqFC4iyrr1IIYBeFlsxYm4CIeOsQ==
X-Received: by 2002:a05:6512:12d2:b0:530:ab68:25e6 with SMTP id 2adb3069b0e04-530bb395e96mr10009243e87.48.1722956521339;
        Tue, 06 Aug 2024 08:02:01 -0700 (PDT)
Received: from framework-canonical.station (net-93-66-99-124.cust.vodafonedsl.it. [93.66.99.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0295fasm13112722f8f.59.2024.08.06.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:02:01 -0700 (PDT)
From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
To: kernel-team@lists.ubuntu.com
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [SRU][J][PATCH 1/2] rxrpc: Fix delayed ACKs to not set the reference serial number
Date: Tue,  6 Aug 2024 17:01:39 +0200
Message-ID: <20240806150149.1609414-2-massimiliano.pellizzer@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806150149.1609414-1-massimiliano.pellizzer@canonical.com>
References: <20240806150149.1609414-1-massimiliano.pellizzer@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

Fix the construction of delayed ACKs to not set the reference serial number
as they can't be used as an RTT reference.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
(backported from e7870cf13d20f56bfc19f9c3e89707c69cf104ef)
[mpellizzer: removed the "ackr_serial" field from
the struct "rxrpc_call" and adjusted the code accordingly]
CVE-2024-26677
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
---
 net/rxrpc/ar-internal.h | 1 -
 net/rxrpc/call_event.c  | 2 --
 net/rxrpc/output.c      | 2 +-
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e0123efa2a62..cf1cc9c14a79 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -671,7 +671,6 @@ struct rxrpc_call {
 
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
-	rxrpc_serial_t		ackr_serial;	/* serial of packet being ACK'd */
 	rxrpc_seq_t		ackr_highest_seq; /* Higest sequence number received */
 	atomic_t		ackr_nr_unacked; /* Number of unacked packets */
 	atomic_t		ackr_nr_consumed; /* Number of packets needing hard ACK */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 2a93e7b5fbd0..b6cde05d832d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -67,13 +67,11 @@ static void __rxrpc_propose_ACK(struct rxrpc_call *call, u8 ack_reason,
 	if (ack_reason == call->ackr_reason) {
 		if (RXRPC_ACK_UPDATEABLE & (1 << ack_reason)) {
 			outcome = rxrpc_propose_ack_update;
-			call->ackr_serial = serial;
 		}
 		if (!immediate)
 			goto trace;
 	} else if (prior > rxrpc_ack_priority[call->ackr_reason]) {
 		call->ackr_reason = ack_reason;
-		call->ackr_serial = serial;
 	} else {
 		outcome = rxrpc_propose_ack_subsume;
 	}
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 08c117bc083e..a007c2ebe311 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -87,7 +87,7 @@ static size_t rxrpc_fill_out_ack(struct rxrpc_connection *conn,
 		return 0;
 
 	/* Barrier against rxrpc_input_data(). */
-	serial = call->ackr_serial;
+	serial = 0;
 	hard_ack = READ_ONCE(call->rx_hard_ack);
 	top = smp_load_acquire(&call->rx_top);
 	*_hard_ack = hard_ack;
-- 
2.43.0


