Return-Path: <netdev+bounces-232376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0136C04DA2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CC61AE0ABA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4D2EF667;
	Fri, 24 Oct 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPg+0q5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C62EF673
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292234; cv=none; b=Ih4mt231uuzLqMMDUAnWUoAZVDLtofFDvLkdNItzvdL2Tx+bQoYYwuak8lf1jMTRRwZ4Uw0sGmVrUUwLJAlbKQErX+QoDdE6jJiIcdfLgl69Dv6z7Wf0Pi3T2RAF/vClA5nga8P9ironx6kdkACZuYaCOu8ktiffbdrzl9y2RRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292234; c=relaxed/simple;
	bh=HYeNLajkD+lS/7fLxxyM+Uku76cK7IqcHQNsW9OVm0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=io43DhrmzpCegTZr4f/x9+6c5EDs2zZjqNiCr1qvald+by9K97jTdbVgmJ+bGQmY5HmN8Ytvbfkp0Wezk2q4DZZGKIT9h203oH+wOCHnjpiIPNSKpkrTyz3RyTxoAn1bttovunqPo7zE8cGNpnWKS11IHbGIAuefSZicjQpM6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPg+0q5Y; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-88ef355f7a3so523676085a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761292231; x=1761897031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uh6V4ej3tUSQu9dfieVhc8CIMklXd4yFOnTxayFJ/qQ=;
        b=EPg+0q5Yijylq+oxRZZiHe9Z9XhhVFcOlVviYh3HDMPYXBU7J19jisqMdiGvH1LRC1
         OSt6GpSECnisFAKrauYzFufg5+pMW/vh5QVBWA6QPTxzmfDZnbrzajdNn402B4gmc93M
         bj33nrIjyEBlvUmXFnAfqxgchmIt7Z/jWD4zJ5d2NaDf6CTfe3FRLe0dWyEKzq23flPu
         1tKB+q/6ia/jx45tPY1FnI4lyTNvk/okHJZCzTF/1YuoELImKeKBabVeBYa9AWX3vfaJ
         8mNtXNzva8OYPkOLyikWT7NkuXSc10hH/L6sbA/295btutYSNKLBSaYgYZJJOCamir8K
         CsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292231; x=1761897031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh6V4ej3tUSQu9dfieVhc8CIMklXd4yFOnTxayFJ/qQ=;
        b=Uhc116QkzqnmlGsEXdq8+acK6zg7hFmX17xf3nsGsnrTxz9ExsVFaE4HpjKpbpwmk8
         iSiTEexaROHIUxq6gmFl5eZxmi9bLrm8ZZWq7QkrzXk/msASBdHQpAK58x1dOvoLyD9n
         AAxKvKfwCa50MJ07HI0jsR+EzOl7Jqv8H4CQll10yXF7UVz27PnC3uiVZ+CG+wQFA3uM
         bsAhD/Woe04FH41fys8BNXSDP9gbslbV5W/fRIGyuHApJSEENHX+ktHLGWg74EWcCYOP
         c8IjtBLGzGwhgdUQaETBTJBKATB4HRsMlVO26XIm/T8YC8fH6VpoVfJmB/70EJhSpYl2
         C25Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZLETL06bVrmlSQ0Grb68t26nITHayWHpOHKKniszQSdZg4SR7G35e66d6uhsjWHebx0k3hx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtQUI+wAhEbAnwdZHu9q2hMLgdX952xd2u+5wbAQ1z6mbDv75
	yFgtSsuC1d25U6aF/13MD2RlOajuuPAbuTaYDpA4eT/mbdVQTM6Qy7AFPWIajbieFPnW+IVY4um
	4IOYTj0gKG0scyQ==
X-Google-Smtp-Source: AGHT+IGp24UmUr/nDNmzEoxJ28XHsJ0ft6WgKxxMY5PYn/6lzgnxIg+SPmf3Q9FfWf93pyDGK6y7O4xDRvtQ3Q==
X-Received: from qknwc9.prod.google.com ([2002:a05:620a:7209:b0:857:4a4:d18d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3954:b0:890:bbeb:1359 with SMTP id af79cd13be357-89dc038ee85mr142499985a.34.1761292231242;
 Fri, 24 Oct 2025 00:50:31 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:50:25 +0000
In-Reply-To: <20251024075027.3178786-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024075027.3178786-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024075027.3178786-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While chasing yet another receive autotuning bug,
I found useful to add rcv_ssthresh, window_clamp and rcv_wnd.

tcp_stream 40597 [068]  2172.978198: tcp:tcp_rcvbuf_grow: time=50307 rtt_us=50179 copied=77824 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=107474 window_clamp=112128 rcv_wnd=110592
tcp_stream 40597 [068]  2173.028528: tcp:tcp_rcvbuf_grow: time=50336 rtt_us=50206 copied=110592 inq=0 space=77824 ooo=0 scaling_ratio=219 rcvbuf=509444 rcv_ssthresh=328658 window_clamp=435813 rcv_wnd=331776
tcp_stream 40597 [068]  2173.078830: tcp:tcp_rcvbuf_grow: time=50305 rtt_us=50070 copied=270336 inq=0 space=110592 ooo=0 scaling_ratio=219 rcvbuf=509444 rcv_ssthresh=431159 window_clamp=435813 rcv_wnd=434176
tcp_stream 40597 [068]  2173.129137: tcp:tcp_rcvbuf_grow: time=50313 rtt_us=50118 copied=434176 inq=0 space=270336 ooo=0 scaling_ratio=219 rcvbuf=2457847 rcv_ssthresh=1299511 window_clamp=2102611 rcv_wnd=1302528
tcp_stream 40597 [068]  2173.179451: tcp:tcp_rcvbuf_grow: time=50318 rtt_us=50041 copied=1019904 inq=0 space=434176 ooo=0 scaling_ratio=219 rcvbuf=2457847 rcv_ssthresh=2087445 window_clamp=2102611 rcv_wnd=2088960

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/trace/events/tcp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 9d2c36c6a0ed74c82306f347ff41fabed7ada8c4..6757233bd0641778ce3ee260c9d757070adc0fcf 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -218,6 +218,9 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__field(__u32, space)
 		__field(__u32, ooo_space)
 		__field(__u32, rcvbuf)
+		__field(__u32, rcv_ssthresh)
+		__field(__u32, window_clamp)
+		__field(__u32, rcv_wnd)
 		__field(__u8, scaling_ratio)
 		__field(__u16, sport)
 		__field(__u16, dport)
@@ -245,6 +248,9 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 				     tp->rcv_nxt;
 
 		__entry->rcvbuf = sk->sk_rcvbuf;
+		__entry->rcv_ssthresh = tp->rcv_ssthresh;
+		__entry->window_clamp = tp->window_clamp;
+		__entry->rcv_wnd = tp->rcv_wnd;
 		__entry->scaling_ratio = tp->scaling_ratio;
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
@@ -264,11 +270,14 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 	),
 
 	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
+		  "rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u "
 		  "family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
 		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
 		  __entry->scaling_ratio, __entry->rcvbuf,
+		  __entry->rcv_ssthresh, __entry->window_clamp,
+		  __entry->rcv_wnd,
 		  show_family_name(__entry->family),
 		  __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr,
-- 
2.51.1.821.gb6fe4d2222-goog


