Return-Path: <netdev+bounces-223653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05EB59D35
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E703BA7A3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D073164BC;
	Tue, 16 Sep 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L25AjDIE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5B31FED0
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039010; cv=none; b=BBeTD76nPjHyEQrAgzcURIDICWiZwBaIPkvfk9aJdLfNrXvp/rXU8jOcAK031MNvoacDD1COlNhvcsnF/AzT9YjsHDrhb2BYMTM2wyjRp3pn4na6mn1xS7efEe0mLXECtbJZ1hWpts4IJWxtcJnR008bshxAALJSRZAO12pJqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039010; c=relaxed/simple;
	bh=R/P1k/Y+6Rp+lpjpmWLC/2++RRWbaSFW+OR1moYK+c4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uUgZl0/jl0/RGB3pU1NH/HhbFsfGngGuC9yIB/fya9Pdxi+QeH3ZRWK2uFE7N985jsWXdR14xe/rcHwKmhqo/wo7E4py5kIBy4Yc0v4u4M2NPa9Esgn85woR3X52cNa6g8/ymOJ0qC9pTUt1Q2CGr5ppIzZ+zhp6lGK4aHsYxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L25AjDIE; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b47b4d296eso148664061cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039007; x=1758643807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/MQSA3eVX1BRHvsH1qSEgSg5eYH/+2RsDjkquuJiFY=;
        b=L25AjDIElKXR8VE/GnwSyeWrimV18GEigYYxRkrOygkzmoW9M8Z0CmR01Ud4HUOsi+
         hlgSvthet9oyglL1Dqt0mGxo76wbwxNAn7mde7Qc5onMp7HDn/SIUDPoVcCZ8DuNpZqB
         VmwQuy6qnTTcBPR5MXeEvGQSQpnr1KH3eyJs+/rRjmJqnLm+0tF64H5eaHLgCtXPkNDu
         VKiSLmmVSEHx2KUR/ibqLz9PnYLIoQQs/A4TAWuUdpOu7LsMVQVLJfzXeKopa/hG1wIQ
         gnE7X3hMP0h+h0e3ojplOU3ypuFDSczLIrGQ48CwgRvd2wOSAr9CkvVzituKBwbyjIsO
         LAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039007; x=1758643807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/MQSA3eVX1BRHvsH1qSEgSg5eYH/+2RsDjkquuJiFY=;
        b=p5MxmyAX9HfFVSP/nE7RAMASVDKdcj1gTADIxtRGIDOFMoQQrJVTo+1jCUGl7Tf39/
         zxSh83IH6ryri48tumRxPkjks6F25oVobHcQQo9LLCNZtaA9saCsSO8KcSq1wOhOulQI
         P8+HMQ0Bjq+WCqLCIL8Bqdh9AEbMPyz2LkthGPwc5alut1yRlJdSIIXNjgGfp44dh36q
         BdCWCSkS4g3bIXp0dM2TfjQWxpEJ/s9wHh3ubOzvTjztCNBnC5/x3IoUsw/UNiojEKLc
         ru5FVw75LbDbhrm01mKPyeuz298YbsBYXpU2GeL0WTTCTj84r3tYyRCnTavY4gENXDec
         F9uA==
X-Forwarded-Encrypted: i=1; AJvYcCWGpShdx6UdpauVE7khQp0N2PT1jCl9D9ItoX0vherMiMRC5Nt74ScJhsuUEfqXUZ2LkBYBYgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKpSAZK8sUIdf2gH/DAA2IzJjSEl/vhk2rkpDFQmw4FYAmuqg
	ZaWv5wURlLthQkob1HlmTrtIBv0+D8ux4Lp0yw3iR8+DMMPVbPBIvM3QQlnwhVSt0GEaCZzqGn4
	tjwOb8AjSjfOYyw==
X-Google-Smtp-Source: AGHT+IHSy7xwb7RoedvutTGianBuDSpFtByuT/1LZBbw3mEeONc9IFivYHvejt8cDzwda779HdU8MjOz8YiE4g==
X-Received: from qta21.prod.google.com ([2002:a05:622a:8c15:b0:4b5:fa2a:fdd5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a9b:b0:4b6:22c0:28b2 with SMTP id d75a77b69052e-4b77cfff59amr219638441cf.35.1758039007432;
 Tue, 16 Sep 2025 09:10:07 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:48 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-8-edumazet@google.com>
Subject: [PATCH net-next 07/10] net: group sk_backlog and sk_receive_queue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

UDP receivers suffer from sk_rmem_alloc updates,
currently sharing a cache line with fields that
need to be read-mostly (sock_read_rx group):

1) RFS enabled hosts read sk_napi_id
from __udpv6_queue_rcv_skb().

2) sk->sk_rcvbuf is read from __udp_enqueue_schedule_skb()

/* --- cacheline 3 boundary (192 bytes) --- */
struct {
    atomic_t           rmem_alloc;           /*  0xc0   0x4 */   // Oops
    int                len;                  /*  0xc4   0x4 */
    struct sk_buff *   head;                 /*  0xc8   0x8 */
    struct sk_buff *   tail;                 /*  0xd0   0x8 */
} sk_backlog;                                /*  0xc0  0x18 */
__u8                       __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
__u8                       __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
struct dst_entry *         sk_rx_dst;        /*  0xd8   0x8 */
int                        sk_rx_dst_ifindex;/*  0xe0   0x4 */
u32                        sk_rx_dst_cookie; /*  0xe4   0x4 */
unsigned int               sk_ll_usec;       /*  0xe8   0x4 */
unsigned int               sk_napi_id;       /*  0xec   0x4 */
u16                        sk_busy_poll_budget;/*  0xf0   0x2 */
u8                         sk_prefer_busy_poll;/*  0xf2   0x1 */
u8                         sk_userlocks;     /*  0xf3   0x1 */
int                        sk_rcvbuf;        /*  0xf4   0x4 */
struct sk_filter *         sk_filter;        /*  0xf8   0x8 */

Move sk_error (which is less often dirtied) there.

Alternative would be to cache align sock_read_rx but
this has more implications/risks.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0fd465935334160eeda7c1ea608f5d6161f02cb1..867dc44140d4c1b56ecfab1220c81133fe0394a0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -394,7 +394,6 @@ struct sock {
 
 	atomic_t		sk_drops;
 	__s32			sk_peek_off;
-	struct sk_buff_head	sk_error_queue;
 	struct sk_buff_head	sk_receive_queue;
 	/*
 	 * The backlog queue is special, it is always used with
@@ -412,6 +411,7 @@ struct sock {
 	} sk_backlog;
 #define sk_rmem_alloc sk_backlog.rmem_alloc
 
+	struct sk_buff_head	sk_error_queue;
 	__cacheline_group_end(sock_write_rx);
 
 	__cacheline_group_begin(sock_read_rx);
-- 
2.51.0.384.g4c02a37b29-goog


