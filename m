Return-Path: <netdev+bounces-305049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XSmTFT7JS2r2aAEAu9opvQ
	(envelope-from <netdev+bounces-305049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:26:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E871291D
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:26:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j5yUfzKV;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305049-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305049-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A44C31C675C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C036F912;
	Mon,  6 Jul 2026 13:34:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A8242D97
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344882; cv=none; b=NuARRhLP4zhZ6GgFZEK6blMe2YMPPz7EQXTsQxAAOvOZby+md/BRhu4YMnhBO2Z0mapmgQW4jnBQa/v8D/nCgaJMUi0UhKjXk6lY/gstXWbKgMi5Y2Yn+obYUXJWeesHgoumxaUsaxZJ+gaB6OcMNMit2lkHBAyMz+/cG0ovT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344882; c=relaxed/simple;
	bh=uJH61AuKNLDgxNVFQxNRRR1zcKN9S6Q8K3SZ6xsylC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3c1bDhZr8qgIaViYh8cZ1tQEnwLzpYccYhz46Cvox0EtoElxpUc7P5A5t9reLkDlmCesxGUhGMnPQS5/0D5Fig1HTShv/f6Jg/vqRz+aYoULVTpxO9DDR3ndRhxrYEf4ytBYNspccnLxBz15fhMSB/bNyInwq26ZpO5TBfMHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5yUfzKV; arc=none smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-804e46366d7so45083177b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344880; x=1783949680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0qrXkuZFbpb/ZLWfzjEsgyN9/LBHDZAebjYE4NdL2o=;
        b=j5yUfzKVjAy+KRgJi98znge86f6SxCmUWYh0BfNrKt/9FQe/UVVNtZCW+7TRqVRpQ7
         vmk+dDK+yYQ0ETqEYIBSqNovLyXzUYrFQ/LmbDBhc88MEznTt0CZfhskGaLRStsxo+q6
         2Mx6nZN8wjsIKM6XueFjSNPKc0zaoiwTI9Db6u+lVZaBYF28aqXoxXOb3fKas3ZRxSLi
         4jT7lVvWCubNJr/41WJyo1DPyqJcNoiFTgp9ANuOPeXlK0uO7JbZ81Ri3wPTXTE/Df0V
         /EbGC/1e+bgg/gA75aZ5fWsnM/06dzuqi8gCq/5ijnRmepVibK2iz8W2M3BC16ausEEF
         b68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344880; x=1783949680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0qrXkuZFbpb/ZLWfzjEsgyN9/LBHDZAebjYE4NdL2o=;
        b=RLmb4xR4kwYFrJ6Vwuym11nBQft7aFYWSF3v1u5yt+NoJFGclLVKPihqy9Hj8ZQqrP
         Q+7IUMg/4cHJdzV3z/4oRM38L1BBa+YHC3YEnX6JML7006N+dsnLzC20sbymPeYvzE+h
         HJUfkbgfh/5fL9ZXgY6VSd+Foebqpn25B9cGFAMJiLcS6EYuWXGE7tx9DHcBngzpWm+x
         6JWpe2ctIgq98nhPLQri5lZFD21edHZsRYlkckkNW16mff9MD7VTUp/M2WsvFKDiJf3F
         Y9KSyv0g4EUOP8LD92qY8dHA2TDjlZuHhjssIbK18nJS64dBH+eUkb5SBFoCG4MqcvvW
         p06w==
X-Gm-Message-State: AOJu0YwB7vGVFQNrgBnGa8qpr0oMUZpJ1xdCp5eA7QNSONjDKL3br44H
	EqhpKKr2CQtl5Dowz5iS3bIUWIl7gyn8Kz4mA317LK1vBc0PNpEvT8UUvUxzUg==
X-Gm-Gg: AfdE7cmiKO422Ugb+jzt5V2lxE3OgrGTwg4pmast6qDVvTsYu1Rhw1wsA5mi4V9NXhU
	Nj0bqUJ5efTOPMrNicX4yDnceQiZrbtDxcAwDtQUBeiXTNJKNtVDbIoIzEuYazWXSVS/GyEGNe+
	B3wjTm87UXHa83HZHKxxX0N3wROrtrKzaWUpbAClkLYYXJYeXJxcXEgonfv7gyKL5Q5Noul+XoS
	09AQHxXbDUwsyJRbIzOyhJuKzeUf/+U6ud5+bSIqbrbEoC6BJjrrPemDDhkDvL48LxVj9QSK5kI
	KLWjOcLPJ3aykMRuho5vi/1/oTO09Ck2Snuoytn9dNQNWTEAF52nv4D2PxdWRewl+wRRWYjyNVT
	Gq0D7OJUc5mKxz/kn2qkvIrCUJRLY9GeMTFRL0xHvnEJ7uTYBp0MUb1KXS5bRa0jp3AAJzGrjA8
	fC9L+AOE4nQ8HQQXEyALtRamZAWViDV2WhovEXvcLTQn9I3EuEtvlSdO0hbmt4NBSdgNLogXEOp
	2H/SPWPv3Qf8KZX8P9IpDUVVIY=
X-Received: by 2002:a05:690c:62c8:b0:80c:85b6:7659 with SMTP id 00721157ae682-81be329f9d5mr2088617b3.62.1783344880391;
        Mon, 06 Jul 2026 06:34:40 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:40 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/7] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Mon,  6 Jul 2026 09:34:04 -0400
Message-ID: <20260706133433.3142805-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E54E871291D

From: Willem de Bruijn <willemb@google.com>

When hardware offload is enabled, FQ will forward packets to the
netdevice for pacing. The device has to test that skb->tstamp is
in the future.

Avoid this cost for packets whose txtime has already passed, by
clearing skb->tstamp.

Also disable timer drift logic when offload is enabled, because
time_next_packet can exceed now causing a negative value.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Sashiko, ignore pre-existing issues. In particular, effects on
non-EDT packets and when queue or sk rate limit is set.

Sashiko, pacing offload is an optimization. Ignore that some packets
may not get offloaded, e.g., when txtime is a few usec in the future.
---
 net/sched/sch_fq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index d4cc8bc9fa06..36006f69a875 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -399,6 +399,11 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
+
+		if (q->offload_horizon &&
+		    fq_skb_cb(skb)->time_to_send <= now)
+			skb->tstamp = 0;
+
 		return &q->internal;
 	}
 
@@ -707,6 +712,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
+	u64 time_next_packet;
 	struct sk_buff *skb;
 	struct fq_flow *f;
 	unsigned long rate;
@@ -721,7 +727,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	if (skb) {
 		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
-		goto out;
+		return skb;
 	}
 
 	now = ktime_get_ns();
@@ -758,8 +764,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(f);
 	if (skb) {
-		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
-					     f->time_next_packet);
+		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
+					 f->time_next_packet);
 
 		if (now + q->offload_horizon < time_next_packet) {
 			head->first = f->next;
@@ -828,11 +834,15 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		 * f->time_next_packet was set when prior packet was sent,
 		 * and current time (@now) can be too late by tens of us.
 		 */
-		if (f->time_next_packet)
+		if (f->time_next_packet && f->time_next_packet < now)
 			len -= min(len/2, now - f->time_next_packet);
 		f->time_next_packet = now + len;
 	}
+
 out:
+	if (q->offload_horizon && time_next_packet <= now)
+		skb->tstamp = 0;
+
 	return skb;
 }
 
-- 
2.55.0.795.g602f6c329a-goog


