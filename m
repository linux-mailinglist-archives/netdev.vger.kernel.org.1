Return-Path: <netdev+bounces-228022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E58BBF196
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8D124F14F5
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F022D5436;
	Mon,  6 Oct 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opRRy4mw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCA1D90AD
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779076; cv=none; b=Do0rvMgPHbZ/Z1boojZxd5j79s2eWa4mr9aebi1Pv2vmfYel6c6QGHgAgMNEFhMOA/Kb7FDD+tUk85sTPxqQUkCJhiF6+nizxO0gGjCUOj0xDub65Y62keEZ9cEwZoNSCB5oVXFHxKDkxVT73zOl7W4+04YoJQw/EsLj9E7eu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779076; c=relaxed/simple;
	bh=DwHCcwHiY3+5OsrlmvNHVmpSYDb20Q2Gpnrs88p9lPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BdtJe+1U9InmjbI9gZgYqXNL7cB5NEhW0iI4JQfoS36RYyEunwYy8Z7vhfjBqUXafCaEzkjsjGZXM3lDxmSroprRumC/g4q72TlYKHxC+10NXwb2jvgbqKSSp5WbAx+P4Tn1qtvH8IoG5zg2vVVDYUDen3GO9z60vK/4i321YBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opRRy4mw; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4df10fb4a4cso195801911cf.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759779073; x=1760383873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJtOOPhDCvCIQwyM5dgerJ5AxW5xTTSXRi7iMC8PIZk=;
        b=opRRy4mwVGTCsbHLWODZY3p812vginPLHPPtpeJnGwhoxPj+P61yuwYeo73gpfQMK8
         FdvCgrbIUUyBEsulE2QkcqZRLIw7ONOlRYeEPcMRBbMoHXReiMt5yYk9p7rlHsAOUR+H
         BaTBZpy7dV2uN1XFrW3XnBvJWuKnFqve5clS4E3qn/jSZcX0YJcWkm0Aptya+2sPqxXl
         yKJQat/Dr+VB6aJsEeRhelsyGv2RSrTlulXuofcqIvM/Lmf2sxkvfrEE0ep9C2Q5M8xp
         7jeTaj8QSK1FwsFBMXX1lAyhJfHvIAqWMGCi921ZYcIyXiYkaQBB6ddhPgjfj8ioJEgj
         0Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779073; x=1760383873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJtOOPhDCvCIQwyM5dgerJ5AxW5xTTSXRi7iMC8PIZk=;
        b=n/U/1yRUi92nUssgn5axkvsDf3V3kKh2Wd2DPVvzB9C4XT7dd7tsYO/cEcaolco0lz
         GdIMza9z/k9t7IAdXalBlC9GBVuztk/gL4jRrmeLNB8MnMCQLiaZls0Abk2w3VpYmD0g
         koHAgpr3qsCB6gBoI0WEzMqYPadLxX7k7aa4I2uaxNU2PKTGoof2MmTPYZ3HSewY1ER6
         cDp0GASQzb7KI3pfv3Ar4GMe0Zu6mn7smSahNb4EMxIqqtNGuZXT6uC0Ibgykzloy8e7
         LaK4orBsRxraAqK2n+xil27qGOcCt984uXtwQQWo9RMTfeawxThM8JgABhWMnRA4yOF2
         jwJg==
X-Forwarded-Encrypted: i=1; AJvYcCU2zo3BE2g/VCX08vcBo/xCaHlSzOD0FGWDMw9ae29IkUuLhSKYWQ0qRaa4/RUcOGAeJfK7hvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9pfmxxa28CCO1mBUGAZiHFCQ5M7u5goRgKy/++1jKEkj+T8po
	HqC9jFNvpk98ddYFpW8bMPzmYwzaMoOf9VapsITNNNdRXjLs8UB60aiCXjazm+miyItBgiQvgcC
	YRRQK3J43LfAzmA==
X-Google-Smtp-Source: AGHT+IFadKSORN6X718NQC/oqrKVt0938fXC/eK7gDFc+SmASjSmdMb3BTx8TfjqCMpWZlJYuG7RwtGpPWVB3Q==
X-Received: from qtblj18.prod.google.com ([2002:a05:622a:8492:b0:4d3:9afd:7023])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4187:b0:4da:767f:f1cc with SMTP id d75a77b69052e-4e576af95e8mr180132691cf.66.1759779073538;
 Mon, 06 Oct 2025 12:31:13 -0700 (PDT)
Date: Mon,  6 Oct 2025 19:31:02 +0000
In-Reply-To: <20251006193103.2684156-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006193103.2684156-5-edumazet@google.com>
Subject: [PATCH RFC net-next 4/5] net: sched: claim one cache line in Qdisc
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
2.51.0.618.g983fd99d29-goog


