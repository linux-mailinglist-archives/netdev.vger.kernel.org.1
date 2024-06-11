Return-Path: <netdev+bounces-102711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A467290459A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654091C236B0
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8933155CBD;
	Tue, 11 Jun 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BLAdvYPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA69155CB0
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136710; cv=none; b=fhb6PSZLfCLxQ4aCxrkmMUY6M2Y9rdV9+qLcYInlaiun4UhEAlyniSlyKFGC2Uze0j4CHX6z1r9bS+C3FQSy4JG3uhRxTm0cfbGB+SMMMCOxaUkGm//EdW1tQM1jx9yhG+fgdf4UlV7+SawcF8UEXLml9DAt7jkjrN1wngrStRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136710; c=relaxed/simple;
	bh=uEGMHEFbMp0HLSU5Z7U4ENmeA4RvQ8IslnoZTeDpYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdlnDuoRDw4cBUBhJtAO5RpbHMc05nwSyXO2Kf44mR6psNWkvAVP/epURaBQ9UwGrdnZqExpqYeFYxP8UFoGPrJaxl3198oF47bQNLgofGRrjRjU3a8/8udF8JfjEaVbxjeduswpWOo84BWLgLiGXJSzKbKBHC+v5aJwp6DA3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BLAdvYPO; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d220039bc6so1920826b6e.2
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136708; x=1718741508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=BLAdvYPOmNLvO8NmKWEtx0nklLBJaYUdVFzgkK2dVlbNnqgFPkwxJoWZZKwhq0671J
         q7PA/wVKvXCNC+WKDsvdxlL4Ehnc9FirtVlKkcdFMIT8zHM+hFXDTYF5IXOAtCMaUn4k
         zDdXjr8Gfl7KyXdkf/eODvTJlR+sCXpjk4OE66LkT+pW/fRiRjxwMZmxdxU5I5HIMbHb
         576JECWCQEkchcDsJQyTMwmOhchiX1Du3C3DOPiXW3IccHsgfUJzttvrSyPWSJhSiSHV
         vTUf3wiuKxYC5tw3jprYqd988DXFNmbOupFZ9z0SSmq7g9a2RrtdE5oKahTD4JcJYwsk
         BdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136708; x=1718741508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=cRjs0b9sw45d3l4l0vQlz+ccM3k2My7kuvC3rCBP2jKs7WZid/EvlXslpWT5N704g4
         D+wcJ6Wkn1Fay83uUQVhEuMVzprhlSh8mUQQ4NuyyxXxcXJSNQ9cBnVJAd5gbJCqzafO
         CnXIyyamnBT07w4sheBftfOamAaONcZ6td3uHI2qNaBi3L2lk9BpquCpINDITqR7ivU/
         RrJ0C7WUpVVBibq+YDpXjztKXi6OREX67a4nYoom9Me0LkF642novAsy29B9VJPrvrfN
         2ENrnzHO2PgB7RIzJ+h/rh+SlNokD6/+3qyKDwLTvSus/mCRq6G+LYpplKShoZWTytI7
         o0kQ==
X-Gm-Message-State: AOJu0YwA86mPQhHVijvaI3r4rvACCFBNjYcsqDMAZsIvlc7giLE74ZbN
	u5cPqC+08NJcIdJbJxtcX/EPAZhSBKJabhIl1+F2oCj8HoXdNedgMRUYSpIo54QwiwX2Ta6EnwR
	xdFA=
X-Google-Smtp-Source: AGHT+IEGIV0gZp72yRtvxivrL8faWuzoltB8Q4iILsjQhsbDP5KDliZvlfbJPyDSrZPDnmEc+K4n+Q==
X-Received: by 2002:a05:6808:f07:b0:3d2:2721:8a7e with SMTP id 5614622812f47-3d227218ac9mr8752502b6e.34.1718136707949;
        Tue, 11 Jun 2024 13:11:47 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4404fe04e87sm39018771cf.55.2024.06.11.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:47 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:44 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 net-next 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <922de9af0ce7fd5ba6028d95da6c4d918b563876.1718136376.git.yan@cloudflare.com>
References: <cover.1718136376.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718136376.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406011859.Aacus8GV-lkp@intel.com/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: fixed uninitialized sk, added missing report tags.
---
 net/packet/af_packet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fce390887591..42d29b8a84fc 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2121,7 +2121,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		      struct packet_type *pt, struct net_device *orig_dev)
 {
 	enum skb_drop_reason drop_reason = SKB_CONSUMED;
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct sockaddr_ll *sll;
 	struct packet_sock *po;
 	u8 *skb_head = skb->data;
@@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
@@ -2234,7 +2234,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		       struct packet_type *pt, struct net_device *orig_dev)
 {
 	enum skb_drop_reason drop_reason = SKB_CONSUMED;
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct packet_sock *po;
 	struct sockaddr_ll *sll;
 	union tpacket_uhdr h;
@@ -2494,7 +2494,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2503,7 +2503,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
 
 	sk->sk_data_ready(sk);
-	kfree_skb_reason(copy_skb, drop_reason);
+	sk_skb_reason_drop(sk, copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2



