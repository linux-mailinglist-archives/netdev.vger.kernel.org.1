Return-Path: <netdev+bounces-305053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nCnnHM2zS2ooYwEAu9opvQ
	(envelope-from <netdev+bounces-305053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:55:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D287118DE
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:55:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qIstvMD6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305053-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305053-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D68F53109D37
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5956381AF9;
	Mon,  6 Jul 2026 13:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9AC375F8E
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344886; cv=none; b=KGnA8gyRqOyBPcbB0YWjtQLTCOnMjXXejfyrKtHjDa6xvAoO57Nf2gGSfOChfNXATWIXkdMfhOCA32TgblTsGUEWKv2ewjUfzRQpOiLGO+oD6UPJeQ7sOHDNCiieGzopiaZ6/Mvq3jkJhyxsuzldvD+BpJKq50ZtcHBR16xZIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344886; c=relaxed/simple;
	bh=dhEMbLhW8J+Vx9HRqU2Tme7Ie9fiKeWl3Cgzri1xzO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0mWY34TBSbMFdISd0FNThPuE9Q8JviWOfKzT+fIW8eEBbGUefHF3OhPBgZQBl9X6QPFQgFLIM9MtJ0i12b0ylY50ZN4012/L+cteQlZtimN2u5p6bO6yBQ8oDVxx/mfjob3++EixLelDidLTKAIevIqu1TU4CksuFfIJ4pH6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIstvMD6; arc=none smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80e4455b9a3so43007857b3.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344884; x=1783949684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0doDpWzOG1dsMVuJr9ZQuuX6/xzczUHVpQyKjpbhko=;
        b=qIstvMD65pzZya9+gW0uJGQ63ggh7bRNCeTNYt5PukvyfImAu6oWXrT9Y1mTyBMZDm
         xB2mCROTOGwG0nr8mOcTsr6vcF4xYU63iVOoCsG3lQ+k5u2W/a9QusioCrsG8HNhHfEF
         H9bcVzJwXAT1RwaHflg1FJprVYtA97LgDpqR/vYtt6JzewRjHBPe5N5h+4/AUTavlFlC
         Podp3mWxLD9oySenLMHKg8jBcmjAkQl0ifmKsav3JFsIpY/nAKUuo/yfgwfVbhuznAzr
         KK1VfnTX6IeW0S9ae+HEhHkjnTn6iatkel+pZzDECLuaPu03CIs/Sd4ekkh01oSc62ea
         /SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344884; x=1783949684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0doDpWzOG1dsMVuJr9ZQuuX6/xzczUHVpQyKjpbhko=;
        b=aOPrJYsnbANyQ+PRHURsg3PvVFQ5lcMKYY8rVaJkK9L/GOB7rMVap0PTdrYESGYwOi
         /MXhTWuINtuuNvz4bnxl/hdHVSB5YUxMUYQmx3hsPlINYV7hN5Z7m1eOJsMRAIMpeyqF
         v9DaDBRJOTRDreXrsGhyfZw3hJ73rTgq7gF8GYnAF0Mro6TIWqW3d012q7DXiLETYd6M
         2oQ8j3R5+Vm09LazJeXGBoLMVy0uIFbZbPXnIuJRb4QbAK5eK9IPbCeddo16wmHwhRKk
         fTpK5WJBHBCfGB1lFI8a4J2xKV8LYPexBEAIqsP8e5N6StsyBL+jQtb0pm+BdkGe3OKi
         Fv3w==
X-Gm-Message-State: AOJu0YxO1LUFXiBktwDegj6jfmoraos90fzEnIid5QBcgRQyf5rjK8J7
	nHWlzewfEwFvOdhj4aL/hNcjJkB6Fp7t5Az3w30qY67Z+acagJaW/8h8nNo05Q==
X-Gm-Gg: AfdE7cnOUbsquJKbuOlvAkB8va3i4cx3jg+GGh0zuyPcN9nL4OhYKNHLUJ6676BEKHf
	5UAOKg+vwhqW5NKkWh/4wyn6QcD5+wGvxjDwMNhya9OKGwhquOChhk4j+x7LVerMNtFlq6eP1Ow
	nn6Aaf76YUv4NjpWxwG0JlNXieJO+Xw7ch9CKp3pdybZLiMQoZ2Y5bjanRnLY5Ua5/Ob3LW7yWQ
	Y9EUY953NxW6OYD0PpRiuikDlqCuFr/fkP2pr3jANaAtK+fwBnxAkwdzRvuT7CdOKK10fLqjMM7
	sV4JZab4G3pcxxXyZyeZaI3J+qCZKwjfAF8ncGIOIJdxvW6lslvYeuzGxtpnmwNNLhuqXdno5nM
	OX5tQyM1m1QhB8rjDhkGjAezgd8Mhdl2PTqRjSv3Jur3MqsbEJQycakECAtHvlnjU7y+R2Rse90
	UcD2zc6JoXVoEomgR89NkOLhP5C1dXwP7R3Y7wnTnuejFAxNs/fq/7Wevc7oYTAHqm8XpCKVeKy
	bcB0bR6mIVfjyON
X-Received: by 2002:a05:690c:6b05:b0:80f:34b4:8d with SMTP id 00721157ae682-81be1d38291mr2512947b3.27.1783344884120;
        Mon, 06 Jul 2026 06:34:44 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:43 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 7/7] net: pktgen: add support for SO_TXTIME
Date: Mon,  6 Jul 2026 09:34:09 -0400
Message-ID: <20260706133433.3142805-8-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305053-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55D287118DE

From: Willem de Bruijn <willemb@google.com>

Introduce support for setting the SO_TXTIME delivery txtime on
generated packets. This allows testing pacing and scheduling features
in the network stack (e.g., sch_fq, sch_taprio) and drivers.

Add a new flag 'TXTIME' to enable this feature.

Add two new configuration parameters:

- txtime_delay: offset from now in ns
- txtime_clockid: clock to use (monotonic, realtime, tai)

The queue_xmit mode can clear skb->tstamp in-flight, so this must be
used without clone_skb.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Sashiko: ignore data races in the control fields. Pktgen requires
superuser privileges, has many such races already, which are benign.
---
 net/core/pktgen.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288..be4fce895b2c 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -201,6 +201,7 @@
 	pf(SVID_RND)		/* Random SVLAN ID */			\
 	pf(NODE)		/* Node memory alloc*/			\
 	pf(SHARED)		/* Shared SKB */			\
+	pf(TXTIME)		/* SO_TXTIME support */			\
 
 #define pf(flag)		flag##_SHIFT,
 enum pkt_flags {
@@ -291,6 +292,10 @@ struct pktgen_dev {
 	struct page *page;
 	u64 delay;		/* nano-seconds */
 
+	/* TXTIME support */
+	u64 txtime_delay;	/* transmit time delay in ns */
+	clockid_t txtime_clockid; /* clockid for SO_TXTIME */
+
 	__u64 count;		/* Default No packets to send */
 	__u64 sofar;		/* How many pkts we've sent so far */
 	__u64 tx_bytes;		/* How many bytes we've transmitted */
@@ -666,6 +671,17 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 	if (pkt_dev->node >= 0)
 		seq_printf(seq, "     node: %d\n", pkt_dev->node);
 
+	if (pkt_dev->flags & F_TXTIME) {
+		clockid_t clockid = READ_ONCE(pkt_dev->txtime_clockid);
+
+		seq_printf(seq, "     txtime_delay: %llu\n",
+			   (unsigned long long)pkt_dev->txtime_delay);
+		seq_printf(seq, "     txtime_clockid: %s\n",
+			   clockid == CLOCK_MONOTONIC ? "monotonic" :
+			   clockid == CLOCK_REALTIME ? "realtime" :
+			   clockid == CLOCK_TAI ? "tai" : "unknown");
+	}
+
 	if (pkt_dev->xmit_mode == M_NETIF_RECEIVE)
 		seq_puts(seq, "     xmit_mode: netif_receive\n");
 	else if (pkt_dev->xmit_mode == M_QUEUE_XMIT)
@@ -1141,6 +1157,49 @@ static ssize_t pktgen_if_write(struct file *file,
 			(unsigned long long) pkt_dev->delay);
 		return count;
 	}
+	if (!strcmp(name, "txtime_delay")) {
+		max = min(10, count - i);
+		len = num_arg(&user_buffer[i], max, &value);
+		if (len < 0)
+			return len;
+
+		/* in queue_xmit mode fq may clear tstamp, do not reuse skb */
+		if (value > 0 && pkt_dev->clone_skb > 0)
+			return -EINVAL;
+
+		pkt_dev->txtime_delay = (u64)value;
+		sprintf(pg_result, "OK: txtime_delay=%llu",
+			(unsigned long long)pkt_dev->txtime_delay);
+		return count;
+	}
+	if (!strcmp(name, "txtime_clockid")) {
+		char clockstr[32];
+		clockid_t clk;
+
+		memset(clockstr, 0, sizeof(clockstr));
+		max = min(sizeof(clockstr) - 1, count - i);
+		len = strn_len(&user_buffer[i], max);
+		if (len < 0)
+			return len;
+
+		if (copy_from_user(clockstr, &user_buffer[i], len))
+			return -EFAULT;
+
+		if (!strcmp(clockstr, "monotonic")) {
+			clk = CLOCK_MONOTONIC;
+		} else if (!strcmp(clockstr, "realtime")) {
+			clk = CLOCK_REALTIME;
+		} else if (!strcmp(clockstr, "tai")) {
+			clk = CLOCK_TAI;
+		} else {
+			sprintf(pg_result, "ERROR: unknown clockid '%s'", clockstr);
+			return -EINVAL;
+		}
+
+		sprintf(pg_result, "OK: txtime_clockid=%s", clockstr);
+		WRITE_ONCE(pkt_dev->txtime_clockid, clk);
+		return count;
+	}
 	if (!strcmp(name, "rate")) {
 		max = min(10, count - i);
 		len = num_arg(&user_buffer[i], max, &value);
@@ -1238,6 +1297,8 @@ static ssize_t pktgen_if_write(struct file *file,
 		if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
 				  !(pkt_dev->flags & F_SHARED)))
 			return -EINVAL;
+		if (value > 0 && pkt_dev->txtime_delay)
+			return -EINVAL;
 
 		pkt_dev->clone_skb = value;
 
@@ -2321,6 +2382,21 @@ static void pktgen_setup_inject(struct pktgen_dev *pkt_dev)
 }
 
 
+static ktime_t ktime_get_clock(clockid_t clockid)
+{
+	switch (clockid) {
+	case CLOCK_REALTIME:
+		return ktime_get_real();
+	case CLOCK_MONOTONIC:
+		return ktime_get();
+	case CLOCK_TAI:
+		return ktime_get_clocktai();
+	default:
+		WARN_ON_ONCE(1);
+		return ktime_get();
+	}
+}
+
 static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 {
 	ktime_t start_time, end_time;
@@ -3557,6 +3633,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		}
 		pkt_dev->last_pkt_size = pkt_dev->skb->len;
 		pkt_dev->clone_count = 0;	/* reset counter */
+
+		if (pkt_dev->flags & F_TXTIME && pkt_dev->txtime_delay) {
+			clockid_t clk = READ_ONCE(pkt_dev->txtime_clockid);
+			ktime_t txtime = ktime_add_ns(ktime_get_clock(clk),
+						      pkt_dev->txtime_delay);
+
+			skb_set_delivery_type_by_clockid(pkt_dev->skb, txtime, clk);
+		}
 	}
 
 	if (pkt_dev->delay && pkt_dev->last_ok)
@@ -3869,6 +3953,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	pkt_dev->burst = 1;
 	pkt_dev->node = NUMA_NO_NODE;
 	pkt_dev->flags = F_SHARED;	/* SKB shared by default */
+	pkt_dev->txtime_clockid = CLOCK_MONOTONIC;
 
 	err = pktgen_setup_dev(t->net, pkt_dev, ifname);
 	if (err)
-- 
2.55.0.795.g602f6c329a-goog


