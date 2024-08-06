Return-Path: <netdev+bounces-116141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8046949435
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FE11F215B0
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35021EA0C7;
	Tue,  6 Aug 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TNQC634U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CB1BC08F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956904; cv=none; b=ov6z4zb0i8Vuz8Qqk5zsrlgdfkthlLjRNtb5sqjRI05FeAWZDdn74nh+ii1imkGBIld3nwfjRx7qoSM2vDvJyGle1ppUma4BJaqk0Tclh7VqnpXqROqJ0NxN8hDzdrckgJrvBguDjWNH2MK5wpHXLvVSxb5x3AZ56+frwiXT2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956904; c=relaxed/simple;
	bh=7S9JCqqIq8A37uOjHMXLk/ibZjCEak0KO8UDCikOMAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa5YTPc2em54DPFP2nVKdJUAlhsiZuX9r59AhekHDAl4M7gfr7Y67jnF1BUirBnALiYicBwceOIFk0ovTV7UqH8TM89MnYi1At6uGi0EFN8ALHGyeiSlFNmNzP56IQrBAqJNDJoYtvJxJQQBJMP6ZQZMuJvev06TZyNA9PBfaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TNQC634U; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8AE32400E1
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722956900;
	bh=DAlWRC3ee6ki+FbK9OgSi8f71N/oAs1WYuE0UkbI6C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=TNQC634UBCO7XXiGFBmVqxwNCMaMEIngPbAOJoGo3/CKAKw13aV+CNsGdTGFxomKp
	 Op7qdynxF8Ko07elH0ixboG7uJQI3LBQrqVGDSNPJuUIfss42DChUnDv8MwsiCBqcQ
	 Qw0u4HeqtzbefNylGoyszpf73/F7pgtbfNWBOnaVHcOOeAQPpP4x8WyUcc8zkCGkgZ
	 n6fwptuFbfcLjCwL8pfadHEGAOGsN/GgavWlfVknN8kQUIajg668AkBiwJort7vlhR
	 w89tBBsQGnDxZrrKokbr8LGI3TAtAR/sWGzTWp5UUMei1s2AszPkPfQSkfKFPQe3n1
	 A/yxdcmLOxo7A==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42820c29a76so5454355e9.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 08:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722956899; x=1723561699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAlWRC3ee6ki+FbK9OgSi8f71N/oAs1WYuE0UkbI6C0=;
        b=Ny4o+w7Xr/bsc6qQmIiMekfRz+2RZx8xPO7e17AQheS2mMY9JFPl95T2b1y4m8+i8I
         IxsNKEYenc33OuBWihw8wsfIJcMyWmATrD1d2srBXujvjVmQ80Ef8Jl6mkzH8+/V3034
         Q/YTHecj8mIcISQr53X9p3Xcl9ZXv09JH77GqvgRLl8qed3m9jxkLIN4mrpidmkcnnDe
         XnlnjuVRi24LNEjJc/nSh95VGVh62loitvg4Xwkj3voEyukV27xdKEJ8TZwckl2I+jR4
         y9ktza3WrmiY5WDjZHsG7WaEwBgry7OGuPyXcpX1GMD4FZsA2+dqL+9TSuX1KcDpAGQb
         p6qw==
X-Forwarded-Encrypted: i=1; AJvYcCWVGw9NvNAcb0f6VTJQGJEYvz9mn9wdf3ugol8vG7gzLY5XsBUX876Cmi0F/sa6mBwFfUmgsBXjVj4/5aeWJaoSPvMmcC+L
X-Gm-Message-State: AOJu0YxB9Sd0XHfGhSzq/a2pY2nlSyJI+Km82dxqHWQ+5ojg9EtBa2V4
	EzBZf8pyok5WNO+VjDDuOVRijDfNnQkI1yjS0XWcDuwUw5aA6k6N/V0deqVJbUgzeRiMXQ8N18x
	SXIcRXHWvnvzKR9MKp/eUuNAxnZO+yYehHgKaAy7JAMr1VBvpIVUmmrR0X7SnEudJ77xWoO6J6F
	9uEQ==
X-Received: by 2002:a5d:5e0f:0:b0:36b:bce6:2ab7 with SMTP id ffacd0b85a97d-36bbce62d02mr10057310f8f.33.1722956524238;
        Tue, 06 Aug 2024 08:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQk+dKfniqRVJqxrWANNrVfoADt72pTXBGIvQ+HEs3G+2ACSJ4I2nPxt2y80mI6ZFIEekDVQ==
X-Received: by 2002:a5d:5e0f:0:b0:36b:bce6:2ab7 with SMTP id ffacd0b85a97d-36bbce62d02mr10057201f8f.33.1722956522250;
        Tue, 06 Aug 2024 08:02:02 -0700 (PDT)
Received: from framework-canonical.station (net-93-66-99-124.cust.vodafonedsl.it. [93.66.99.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0295fasm13112722f8f.59.2024.08.06.08.02.01
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
Subject: [SRU][F][PATCH 1/2] rxrpc: Fix delayed ACKs to not set the reference serial number
Date: Tue,  6 Aug 2024 17:01:40 +0200
Message-ID: <20240806150149.1609414-3-massimiliano.pellizzer@canonical.com>
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
index cb174f699665..5039613ad0e1 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -667,7 +667,6 @@ struct rxrpc_call {
 
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
-	rxrpc_serial_t		ackr_serial;	/* serial of packet being ACK'd */
 	rxrpc_seq_t		ackr_highest_seq; /* Higest sequence number received */
 	atomic_t		ackr_nr_unacked; /* Number of unacked packets */
 	atomic_t		ackr_nr_consumed; /* Number of packets needing hard ACK */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index b5f173960725..c08715be8e9a 100644
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
index 09fcc54245c7..8816aaa98287 100644
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


