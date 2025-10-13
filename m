Return-Path: <netdev+bounces-228810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C97BD446B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DCA85030FA
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E940315760;
	Mon, 13 Oct 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1w2GYahf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B9315765
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367268; cv=none; b=khgD8cmpkpThCov1xsSkla9c0IaKKJe8oFZF1tucMZdtvYfxpQ21NA3XnPh9iDU2VIzKfZUUNQZaPqPWN+KTMhIDYkC2e+LENKqO/iA7xzhg6khDsPwIhFOhoO/iu8Iris+reEO5U54aYNZG4WBqYXWDMa3myOAbM0ybUvQCN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367268; c=relaxed/simple;
	bh=JDjaVqajR4fPnC/y5LSY3+eJHn3gmfSw25tP8jiU6cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pVh6p6NKddaIRRo0HX4zs4sM1gUDurX9qsedIlVMSIqaJFfZ2KLsCRy2TTsrwCiU8DHI00PnGkCjwppiJ7IF+aeJ6Zu16cawkrMi8MAVYvjyDNcJdQjgtc2LAc8sMnwX2rU/8ziVFYhiQjWnN8uSpKhe29w5n1c/N8MYKoVvvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1w2GYahf; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-79e48b76f68so336054506d6.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760367265; x=1760972065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3DeaUbmzzS9YwPg45jOG0fdajd3YSbK2KyTQNCatt8=;
        b=1w2GYahfEkCt1d4cXwJ8Qr8V8nvUD7cD3Z9Ft3txarU8+10Sg9PQzowR39jVN0O5f7
         XZbC9oriNIjsL5HG94PAXz/N49G91Nj5vVzja+Fp7iUjnohyF2BoCLv7fePX8Ev+qEL/
         PL8xNYiQ49elGXkK5zzDA5bTemhH5vy8Pnj3gkdYg/L9Z5rySXokuh9rQC/tQHGbhej1
         EuX/FRFh8U6Zgu/gGdULDgeagK3ebyWH9TuxGgklIdOJL869V4Jf2HUFAjNn/Co5Ngiy
         YWBmtlkOQtRS2LFzqBsXoRPsQS3S4OapgQGTk9jjZkeL6UI+B9NNd0kBigmhwe3BxNjP
         BgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367265; x=1760972065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3DeaUbmzzS9YwPg45jOG0fdajd3YSbK2KyTQNCatt8=;
        b=g+lTCf6DkxOyW5dF/Iq/aaGYsUvHRXXk3zjKJSdjAeoEr7wsaI2+6ArKlbW673KllE
         9rhA9PFEBbc+oGyd+M4ZMiEltPMUcpHC3ahDMbAGNwFXawDNhj0pkRcCFhvdmRRU6k5+
         jToNRsN2HPCJpaJLB8QVkMcQ/weJGs2FMF6WWsuViynFxZ294F1cD7lcZ5LXIanhvn5T
         /nAVz8HYp1uzEyx85xcBz4r/3afRt3kuqRNbyQVH3KWukG+8KhgmKH7M3k8FB9/soMC4
         eGrjX+Q6gHYJF6bfoiQSkDyJKi3bmv2lCs6Mjyl7k3Ge6aSQyGjb/b4PdlJ9dCmxmWiM
         aZwg==
X-Forwarded-Encrypted: i=1; AJvYcCV8REu9+wCcCPtr6nxe++cHY4jkrNZXpj80oSajgaJbt4GF2v/v99w6RuLAI06Ud+V2lSnGfHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxweKriUuffGEKqnItP+6vohPJHEE8PNvt6r4QKp6vRDnuYv7/M
	3jFegO4KAAW1bTrtmitvaVkqUjRP5x+OQym24IdX7l7plbmNa4RaxzCRKqndn0foc8wYhp4Ic2g
	lnKvPYK5Piyi4zg==
X-Google-Smtp-Source: AGHT+IEqsI1Raj4n7yMPiDZtkAyAinOIL1LBSu2Mnc6owCeqfy9S97XadI08Z7rl8240sZcXhDXY42Dfvom9WA==
X-Received: from qtmk24.prod.google.com ([2002:ac8:6058:0:b0:4dd:1b63:d8b0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d41:0:b0:4d8:67fb:418a with SMTP id d75a77b69052e-4e6eaccd2a9mr336145621cf.2.1760367264933;
 Mon, 13 Oct 2025 07:54:24 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:54:15 +0000
In-Reply-To: <20251013145416.829707-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013145416.829707-5-edumazet@google.com>
Subject: [PATCH v1 net-next 4/5] net: sched: claim one cache line in Qdisc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace state2 field with a boolean.

Move it to a hole between qstats and state so that
we shrink Qdisc by a full cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 32e9961570b467b6066f1bb2c00ff1a270e342bc..31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -41,13 +41,6 @@ enum qdisc_state_t {
 	__QDISC_STATE_DRAINING,
 };
 
-enum qdisc_state2_t {
-	/* Only for !TCQ_F_NOLOCK qdisc. Never access it directly.
-	 * Use qdisc_run_begin/end() or qdisc_is_running() instead.
-	 */
-	__QDISC_STATE2_RUNNING,
-};
-
 #define QDISC_STATE_MISSED	BIT(__QDISC_STATE_MISSED)
 #define QDISC_STATE_DRAINING	BIT(__QDISC_STATE_DRAINING)
 
@@ -117,8 +110,8 @@ struct Qdisc {
 	struct qdisc_skb_head	q;
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue	qstats;
+	bool			running; /* must be written under qdisc spinlock */
 	unsigned long		state;
-	unsigned long		state2; /* must be written under qdisc spinlock */
 	struct Qdisc            *next_sched;
 	struct sk_buff_head	skb_bad_txq;
 
@@ -167,7 +160,7 @@ static inline bool qdisc_is_running(struct Qdisc *qdisc)
 {
 	if (qdisc->flags & TCQ_F_NOLOCK)
 		return spin_is_locked(&qdisc->seqlock);
-	return test_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
+	return READ_ONCE(qdisc->running);
 }
 
 static inline bool nolock_qdisc_is_empty(const struct Qdisc *qdisc)
@@ -210,7 +203,10 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		 */
 		return spin_trylock(&qdisc->seqlock);
 	}
-	return !__test_and_set_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
+	if (READ_ONCE(qdisc->running))
+		return false;
+	WRITE_ONCE(qdisc->running, true);
+	return true;
 }
 
 static inline void qdisc_run_end(struct Qdisc *qdisc)
@@ -228,7 +224,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
 				      &qdisc->state)))
 			__netif_schedule(qdisc);
 	} else {
-		__clear_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
+		WRITE_ONCE(qdisc->running, false);
 	}
 }
 
-- 
2.51.0.740.g6adb054d12-goog


