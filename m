Return-Path: <netdev+bounces-99882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF88D6D53
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512791F20C95
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F61F519;
	Sat,  1 Jun 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EZEulQPL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA2AD4C
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206170; cv=none; b=puuQNpjkQrqXziSb/lA72SYVEElZNDkPkpIADqI2WP3m5yYJcr4hbloLKRMcUnPan/1Dk1ot9GNkJvl3LiPialRtINiBGgKC26UoOcDeNr4DWSPQOQyqzjEetuMTWjF22QIhiVJH8WeDP84cXBz8TseARiSSjFxvV7Hr84Wj4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206170; c=relaxed/simple;
	bh=fMhS89j65J/ioJctAsELK69LYt7rCRTJv5kJAJc12O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZnFCET23DlqtcX9JLe9Sg/Dqhk14rHN/NLl6WVGyyMmg5OW2QWCWg3TH0de1Drbk/ufymOUd/hdnFMEYV/7YWIYqytL1nUW1OMzQqBElw9S8umqqZ11pcKb6G/f4vhKiuwr0Gxpkq+qsbJQzdZhEc9ufgb1sVv+jO/cRJkwpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EZEulQPL; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfa79233c48so1147381276.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206167; x=1717810967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cundJu+cYnxxw8687bE9Xl3Y+llWE0GOh77B0ua/CNI=;
        b=EZEulQPLbNS0NM15eeqKtV9wFeLGCPEme9p9MxydLAhDWvxVpmc43mkyJD3lgqbHXR
         gwMG7e7eAxQzsVvz+brmbu/uZvfH4D9aGhPFlMVBWYSGaab5kn9Ggb31RKkT+KsCEi3i
         cq5R+J6SZUrwaQASzn05t6gmqiUXEaHfkdWYFjeBDHen/QBz4ceYUl1NPZQKNwlV0T29
         8GZA9YUVTndFYXQNs+shzcvBN4qeekaOAbLmE9UZ9fDETaKxmGaBEvtW5AIDI9Ghz0Lo
         HNGw0ZwI6wU3YOysfGBIVn4mYqwExGOnSgqSIctwuFR2oqhfRGQCh8tuNyuvdBIONmJH
         M91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206167; x=1717810967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cundJu+cYnxxw8687bE9Xl3Y+llWE0GOh77B0ua/CNI=;
        b=ZIxha1SudtNz1el8KjqwLHqOg6/Wry7gGFxdZp5Fr1xAfEI8+O5plYDNa9dijoQYpu
         RfCKl0NreXw2WnCMqq7EDRd2ANCK8KUSc9qffWOIVm9gheBqhmeO65YWMvFGZWRG+521
         kz0uULVHPmaZF+KOlh3evO3o9KQ9Qi47aAzhjn32WTUvHhXqibf/ZEqjnypzBxJwYpmg
         pptxTjzKEnU0MolitsJP6tfURplNLB6+4n1tb2HymD77N/p6sAFJ36P3wVNdX6H3XMgA
         AM2fCF51wkCvOv438Ndc3vtm+CufsNlsdkb9/9jH/NcFtxDWLvZZvV534RJTZDjAwKtD
         qAUQ==
X-Gm-Message-State: AOJu0Yy+6QhNKCKnRnMVjH+V63r9XpZLvZ2a03tWEfBXvdWAR7dhT64x
	fqu8M9dtB0DgH/J/3he8K0os6dUeNTvNtSEDIili+4bOh+dClEsdWwmagVWNEMqIwyurXKamE1r
	SZYQ=
X-Google-Smtp-Source: AGHT+IF8/QXX/W3z+6+bPU1EZTN+wOS5BbuypuBo+0m5XNlSWCNf1UxNrXiBYmUihxaQr4gR5LJW8w==
X-Received: by 2002:a25:abd1:0:b0:df4:dcb6:75bd with SMTP id 3f1490d57ef6-dfa73bc31f9mr4195161276.9.1717206166653;
        Fri, 31 May 2024 18:42:46 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfa6f011334sm561875276.4.2024.05.31.18.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:45 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:43 -0700
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
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC v2 net-next 1/7] net: add rx_sk to trace_kfree_skb
Message-ID: <451ae2a5c2ddb3c127cfddaf4a6579d6e85791f3.1717206060.git.yan@cloudflare.com>
References: <cover.1717206060.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717206060.git.yan@cloudflare.com>

skb does not include enough information to find out receiving
sockets/services and netns/containers on packet drops. In theory
skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
stack for OOO packet lookup. Similarly, skb->sk often identifies a local
sender, and tells nothing about a receiver.

Allow passing an extra receiving socket to the tracepoint to improve
the visibility on receiving drops.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/skbuff.c          |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 07e0715628ec..aa6b46b6172c 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,15 +24,16 @@ DEFINE_DROP_REASON(FN, FN)
 TRACE_EVENT(kfree_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location,
-		 enum skb_drop_reason reason),
+		 enum skb_drop_reason reason, struct sock *rx_sk),
 
-	TP_ARGS(skb, location, reason),
+	TP_ARGS(skb, location, reason, rx_sk),
 
 	TP_STRUCT__entry(
 		__field(void *,		skbaddr)
 		__field(void *,		location)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
+		__field(void *,		rx_skaddr)
 	),
 
 	TP_fast_assign(
@@ -40,12 +41,14 @@ TRACE_EVENT(kfree_skb,
 		__entry->location = location;
 		__entry->protocol = ntohs(skb->protocol);
 		__entry->reason = reason;
+		__entry->rx_skaddr = rx_sk;
 	),
 
-	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s",
+	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s rx_skaddr=%p",
 		  __entry->skbaddr, __entry->protocol, __entry->location,
 		  __print_symbolic(__entry->reason,
-				   DEFINE_DROP_REASON(FN, FNe)))
+				   DEFINE_DROP_REASON(FN, FNe)),
+		  __entry->rx_skaddr)
 );
 
 #undef FN
diff --git a/net/core/dev.c b/net/core/dev.c
index 85fe8138f3e4..7844227ecbfd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5233,7 +5233,7 @@ static __latent_entropy void net_tx_action(struct softirq_action *h)
 				trace_consume_skb(skb, net_tx_action);
 			else
 				trace_kfree_skb(skb, net_tx_action,
-						get_kfree_skb_cb(skb)->reason);
+						get_kfree_skb_cb(skb)->reason, NULL);
 
 			if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
 				__kfree_skb(skb);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..2854afdd713f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1203,7 +1203,7 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
 	else
-		trace_kfree_skb(skb, __builtin_return_address(0), reason);
+		trace_kfree_skb(skb, __builtin_return_address(0), reason, NULL);
 	return true;
 }
 
-- 
2.30.2



