Return-Path: <netdev+bounces-201634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C27AEA284
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F27A3A97
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F72EBDF1;
	Thu, 26 Jun 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoDgvR51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037952EBB82
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951823; cv=none; b=gDA1OLyCp9TkcflpR32nPOZrApDw1OwVPNYOyuWnFX+cIWsc9fE4HMWRNzd34pC2v+AegapDrc59OD0IpA3nQBwPcBFU00B8CJZ02OnegZ7NSl3jAWiKw2Qf4b2rR3O/D4EFdh43k3cMi+Zw3XtC6ENZHscytV2sBAPGPvcwG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951823; c=relaxed/simple;
	bh=jXNf8qbzgxojayyElY11UhPGFQDfHxCSCMKuSG36VzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kSSeJ9puFR4vfB1/ez7794bV7YcYtivWaW7XOlbFlfGNpzbYF9ib1UndMDeM9ZDNoFgMaHbw7zbgvzZhLCCoWYDap9tiljoA+vDaSPIfDr9Pqe2vRnuHYa9Bh01t2pwMAzY8tUKV26jSK3vOXe8GYkLbheTp9tx+eX03Opgkfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BoDgvR51; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a58cd9b142so23735901cf.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750951821; x=1751556621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWRh5QIPDv9wXlLweKudFkWL4K1RtnoAFhY/T6zTnVM=;
        b=BoDgvR51mqQwgeWXDDFsSw6ndhAcyKr+UWtVt8R0H9cp8Xv4G74wLg/smo3eFMuKMX
         9UnpNIZN3aAFJ1TglpWhcL0xLl8T/tNfC/i5kt4aNX78HuaZtrB+EsZyX0191GhtLEuu
         lCxgJcyiKZZwmEXmEuyTk8Bvh2u5tFAiLOscBV/u6sVr8ggJfh5SMy3WRloMJQ8DHNMH
         uxrM5eVxOe8JcP08xoLpiTxFVU0QIQgsFaroSUi6N8J/GlnUkm/Zd93/ZoinFwzZCnNU
         wmkMX87gadMkq1JVsK4Xmz9KhiWeaHWzH8IHK1a5ECKrtYdc0ezNWzgmDnshAndZPYPg
         D3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951821; x=1751556621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWRh5QIPDv9wXlLweKudFkWL4K1RtnoAFhY/T6zTnVM=;
        b=AprSiIvwfWe8yr12YWo/ADC8DZUD6Dg/nPUoVB8JReAYzYlfU/N6hyEeLX1E81+UxP
         w/E/EOmi7I37DPqGEf6eOnN3Pv/hIqs5iiyXqVflPNUq+Qi2HPzr5ERFx6Tl/9J8EzLA
         KE0Tyv4IrD081fjP8B+DM2zY/uMXnvCtxW4gjAa5MT12SJ8GDHMInv4glOF+u1A01a4p
         XjfF475w0QyW5zSp88RnyQReQ8pKSIjSoYyOMSFmrbWyVuqCrOWzWIHthL046h5gBc+K
         r31Sd8Y5s6bn+1VRMEAeIrIc9zOHGc0Z0k5ffTcZct3y+2KEKy3gxhjNb6WiFvgHXmAz
         DhZg==
X-Forwarded-Encrypted: i=1; AJvYcCWN/u3iFk7yqzIs9XZ/mWtH5ys43YmnZv6va4SkC3+vzxfkFGmQC3dUI1K1dnr3mWZfLYwEd2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YykztC/xwT8aFuf20ShJB4f1+KFMNlHSZo3vCWPyTAKIamyISrT
	csdQeRqWiDR3+nASjUDpKaw7SGSg9ZNnGVNqD0u4cXNaBR7etrcM3WUoal+/9K9+in9JdUILYj2
	GQMTmTrQ36cZ0Yg==
X-Google-Smtp-Source: AGHT+IFJgtbSBySy3ccVyb1dP2EcNRnXLyQfeXYiCk2o1ilDYfGtukfJD/tr+Pb2gVwM8Rd9MnB9csJq0b3rwQ==
X-Received: from qtbay42.prod.google.com ([2002:a05:622a:22aa:b0:494:7721:2cbf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fc2:0:b0:4a7:64cf:f092 with SMTP id d75a77b69052e-4a7f28aab20mr69487991cf.17.1750951820866;
 Thu, 26 Jun 2025 08:30:20 -0700 (PDT)
Date: Thu, 26 Jun 2025 15:30:16 +0000
In-Reply-To: <20250626153017.2156274-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626153017.2156274-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626153017.2156274-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: remove rtx_syn_ack field
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now inet_rtx_syn_ack() is only used by TCP, it can directly
call tcp_rtx_synack() instead of using an indirect call
to req->rsk_ops->rtx_syn_ack().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h      | 2 --
 net/ipv4/inet_connection_sock.c | 2 +-
 net/ipv4/tcp_ipv4.c             | 1 -
 net/ipv6/tcp_ipv6.c             | 1 -
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index b07b1cd14e9f4d41d2b4fbad6015bbfae4190636..bad7d16a5515beec7375bddbb74fdb8a6d0b4726 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -30,8 +30,6 @@ struct request_sock_ops {
 	unsigned int	obj_size;
 	struct kmem_cache	*slab;
 	char		*slab_name;
-	int		(*rtx_syn_ack)(const struct sock *sk,
-				       struct request_sock *req);
 	void		(*send_ack)(const struct sock *sk, struct sk_buff *skb,
 				    struct request_sock *req);
 	void		(*send_reset)(const struct sock *sk,
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index f4157d26ec9e41eb2650b4d0155f796d2d535766..d61eef748851796f53592ca6781428266bdaca26 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -886,7 +886,7 @@ static void syn_ack_recalc(struct request_sock *req,
 
 int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req)
 {
-	int err = req->rsk_ops->rtx_syn_ack(parent, req);
+	int err = tcp_rtx_synack(parent, req);
 
 	if (!err)
 		req->num_retrans++;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 429fb34b075e0bdad0e1c55dd6b1101b3dfe78dd..56223338bc0f070179efb2ce9996fa7146782adc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1703,7 +1703,6 @@ static struct dst_entry *tcp_v4_route_req(const struct sock *sk,
 struct request_sock_ops tcp_request_sock_ops __read_mostly = {
 	.family		=	PF_INET,
 	.obj_size	=	sizeof(struct tcp_request_sock),
-	.rtx_syn_ack	=	tcp_rtx_synack,
 	.send_ack	=	tcp_v4_reqsk_send_ack,
 	.destructor	=	tcp_v4_reqsk_destructor,
 	.send_reset	=	tcp_v4_send_reset,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f0ce62549d90d6492b8ab139640cca91e4a9c2c7..9fb614e17bde99e5806cd56fdbc4d0b0b74a3f57 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -835,7 +835,6 @@ static struct dst_entry *tcp_v6_route_req(const struct sock *sk,
 struct request_sock_ops tcp6_request_sock_ops __read_mostly = {
 	.family		=	AF_INET6,
 	.obj_size	=	sizeof(struct tcp6_request_sock),
-	.rtx_syn_ack	=	tcp_rtx_synack,
 	.send_ack	=	tcp_v6_reqsk_send_ack,
 	.destructor	=	tcp_v6_reqsk_destructor,
 	.send_reset	=	tcp_v6_send_reset,
-- 
2.50.0.727.gbf7dc18ff4-goog


