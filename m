Return-Path: <netdev+bounces-263698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDZgA8H+p2nUnAAAu9opvQ
	(envelope-from <netdev+bounces-263698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:43:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C231FDC7D
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5BA2304AAFD
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A14439A06E;
	Wed,  4 Mar 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oxgpf30n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87739A05A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617402; cv=none; b=ZhNEaaIi/oG9ACenLzFmvE1wwztrwnFz+0r+OUyO24p97xWa9S7hnLBvjoamw+H7pD5zkHGrnECz3+hDyorqJZcj27HgVjmIIPyvNIulYMYme0nEt3voSBPV7mT6D7GDvTB6v8oxwe5I2VHH0y12FiJ3DE44Xrs8i2uqBpcwOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617402; c=relaxed/simple;
	bh=R0uCK9WbpzHSEfbrqjG/qMQI25IjsDAb0fQJV8yYDoY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YECEjJa8pvyLwRRnObH8f4SCNoYC7rm/F07isf66hyg+RJJo8LLV3s6VXxmY9JjLZ3fI0BFzfW6zjNtFclWg7GAk/s3Wh1zb8kzVaDrr4hSudKyykGI3c9KKqjGG+eElYFoF/uHuxbWmeEXKb44xvSwOXwjLhtHcZNME6Ym3eeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oxgpf30n; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64ca2fce86bso7817901d50.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 01:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772617400; x=1773222200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l8Uxe4MkiFK1BvC9hzWNs2GqCwXMfpiybl/gcG4/irI=;
        b=Oxgpf30nb0iAVDu7GtSGayVVa+7wrr4dkeXTa2ka6+TIy3HxIvoPRE4roL7o5y85gK
         dARJ4WgQjieoGyh4STu+C1c7Dgv36BobUwaFI5n0KSHNx8p/hN9Qh5/yLODUib7t+QgW
         zYeQ3+8PeF1rCDVlN5+u+je42y/KDy7qPM2o3sXszvgz+6+gtITv143q9+p6CilMkl1n
         2rnZYATRTf0HZVP2jCPCJqET+0eW6ElR3KLFO6gh5rz0yV+No3vhqqXS1R66GPV50pMI
         jTk9Tdn1DNrW9nbl70M2rm8EJhru0QVTlCrN6UyZx8d1h7f7tJ++u0eM/Bui13wMSDf6
         fHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772617400; x=1773222200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8Uxe4MkiFK1BvC9hzWNs2GqCwXMfpiybl/gcG4/irI=;
        b=jfJg+dSt/144Eg0gb7hs2ZSeQKC/9BmnNJCD1cbslUqhRw+oJqtENAh3BZGYUobMsZ
         4TCA/Ba6LiuAOV30/DFje4cUjglc4hpCh2gLVdLxF5oLiDbOT0wYIPmuJl+SYIo6vD48
         RkbQ7/Bnp5EA8+IlhYcJWqXfTg6qBUCs8gr6J+795f0aFEa40sWrxaAuF3zkR4rSUwfm
         V7Kllc7elS2siS8Rdt4DTaF8oH41IPfj1ZR/CZxra6LgaLXR96UMhwvVaJcdi/1oS7Ny
         730j4/OJ7gH963bpRYuA06OUf9uhh7Syjpr83lrxmFRpX5usMqFamtsWMG0694dC41FV
         96iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV54wlnn8UdQv2tUaP2dLWeuUsLN/8Sf0bxgyZ76D4OBl0eKXMHJhLe2qRr6JOIPLq9TLKr3Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywge1h/4TK5rPKfr9Lf9ojMyHPw6kz03i5/kRhchcXMIp0Ijlac
	WEFUt+juupnlL/JnFWjcN0C6qWqvu5M0fHikxXwDSMm/caDdSzpz+erScj4kotnOO9NY/BQ5li9
	dKVGA1DE2Qr4k4A==
X-Received: from yxzt31.prod.google.com ([2002:a05:690e:16df:b0:64c:9ac0:70be])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:864e:0:b0:64a:d6a2:c6a with SMTP id 956f58d0204a3-64cf9c1d63cmr838590d50.88.1772617399824;
 Wed, 04 Mar 2026 01:43:19 -0800 (PST)
Date: Wed,  4 Mar 2026 09:43:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304094318.1769536-1-edumazet@google.com>
Subject: [PATCH net-next] inet_diag: report delayed ack timer information
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A4C231FDC7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263698-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

inet_sk_diag_fill() populates r->idiag_timer with the following
precedence order:

1 - Retransmit timer.
4 - Probe0 timer.
2 - Keepalive timer.

This patch adds a new value, last in the list, if other timers
are not active.

5 - Delayed ACK timer.

A corresponding iproute2 patch is needed to replace "unknown"
with "delack":

ESTAB 10     0   [2002:a05:6830:1f86::]:12875 [2002:a05:6830:1f85::]:50438

    timer:(unknown,003ms,0) ino:152178 sk:3004 cgroup:unreachable:189 <->

    skmem:(r1344,rb12780520,t0,tb262144,f2752,w0,o250,bl0,d0) ts usec_ts
    sack ecnseen bbr2s wscale:12,12 rto:10 rtt:4.073/0.205 ato:4 mss:4096
    pmtu:5000 rcvmss:536 advmss:4096 cwnd:48 ssthresh:48 bytes_sent:288980
    bytes_retrans:20 bytes_acked:288960 bytes_received:288970 segs_out:28986
    segs_in:30626 data_segs_out:28898 data_segs_in:28897
    bbr2:(bw:575Mbps,mrtt:0.049,bw_hi:1.48e+08Tbps,inflight_hi:48,
    extra_acked:1,mode:2,phase:PROBE_BW_UP,pacing_gain:1.25,cwnd_gain:2.25)
    send 386Mbps lastsnd:5 lastrcv:1 lastack:1 pacing_rate 711Mbps
    delivery_rate 575Mbps delivered:28898 app_limited busy:91010ms retrans:0/2
    dsack_dups:1 rcv_rtt:151640 rcv_space:266250 rcv_ssthresh:265904
    minrtt:0.049 snd_wnd:270336 rcv_wnd:266240 rehash:1

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 9d215485b5c7e7ba29dd53c924f0245439d74af5..e4cb18061aefcc22df04644c00bf5c7db4e150d2 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -298,6 +298,10 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
+	} else if (timer_pending(&icsk->icsk_delack_timer)) {
+		r->idiag_timer = 5;
+		r->idiag_expires =
+			jiffies_delta_to_msecs(icsk_delack_timeout(icsk) - jiffies);
 	}
 
 	if ((ext & (1 << (INET_DIAG_INFO - 1))) && handler->idiag_info_size) {
-- 
2.53.0.473.g4a7958ca14-goog


