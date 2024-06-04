Return-Path: <netdev+bounces-100765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624948FBE46
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA49286FB8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B114D2A3;
	Tue,  4 Jun 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F0YGIPaM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6914F12D
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537686; cv=none; b=L2b6nezZEeFE/r5yPeusIUwEsvX4BzdPQpSi3F8v2ebfrNgfdTT4xmrxwN62EmzTTv4SnHt1DO+pJSL1g06Xuo4ZmMVP9ZSjdLSy2s9Zh4pP7wcEF8Wq/EuFg3QeqMmqkWUK/bHxMuvyLyNkQV/BJs8wbNnJ4U7oKF+eU8Js84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537686; c=relaxed/simple;
	bh=uEGMHEFbMp0HLSU5Z7U4ENmeA4RvQ8IslnoZTeDpYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoovlly3FjatkK+zXqpbEuPgBeb1OKTkAipy4U15NJ6Bz58tM6ZWBKIbHZYguoUEsDGPWwqansAFAyw+TqnjLagpNYOk0bU/nuvkDlUwCZ165+56AGsoJvJTgFRRbV+HkfwH751KACOwIEADRpBzTAV/+Ke2ktXeWQnesTqrb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F0YGIPaM; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6afbf9c9bc0so13763786d6.3
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537683; x=1718142483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=F0YGIPaM93k2hd8gAAMatCKDnEXoBJD0/kl28LTYZPwbQgJOaSlpNPIySbvb8tpCUb
         LTfyQlbFJr3uE6aIYr1Fq8awtTVe6uijQlzsui4kBZKgdzbmV2zXQ+LmdQM64i4qI7zC
         E1OrxBwneRq1oFhNE+7MBHsf9KC3l+/cXKf05bieZUjjW2rwlpDKV/KZTL+mLc+Hvfnr
         nfWKopr9oWoPaGjwmQa05zEOFBPlRTBQdKIQJGYfJ+TTPS9GPr/gHQFgPMPT16o3bne9
         9OwXAv3qzfYebk6ycFiBxZgAvb/5OK/+sCuX+5IEor9DyYXVn6jGR1zM5+f9EZfkKp9f
         nHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537683; x=1718142483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=mQ9GnsNRundlJFUKOXkAQjFHNiJahif/kxETkNfwmOHQkQI8WdizhaXF3Yla8my9jT
         cxIy47atnaOIXu9UkLRKY37vIQYSRSWxrQQO+phPzG1iyqFcK7/p+Pvjuqfn0enxxPIp
         TsWEwL27EBI9X0Ef81xnkUpf7h9Ut4lbaw1enD0B8QnaYYPhiOK7l0f7cifqEN+tfGWN
         evz5deqzL13rELaWuRHT47tDw2KZEHjKkaPMHl5e1/lgQyAxqT6CbYABUImes0u7xzDG
         k6MaqP1BMNH9Te+anM55MdAOI6JSNj+74BbTWUPVRZzILNGMMLPfw8D5GLFgBTMa3sXw
         m/Kg==
X-Gm-Message-State: AOJu0YytZFuKN90NZWU9asnnGN+UQGTPTA4Ym9x7IN7glvxE7ZE9D9/L
	KSyGnO7uB9BGvPSv0DDDxw6hFiHCLTDvrdypC5sRNrR0Db0rnJmXLZDMzdU0lpHiBt7GX9+F3S0
	IxWg=
X-Google-Smtp-Source: AGHT+IG6/GBC9sNG+exjZROqqV20El9+yth58LdwTrthEzSlb+iKsIQbqjd2bF6oWHOLCPDaM1c5tg==
X-Received: by 2002:a05:6214:3902:b0:6af:cb9f:59dc with SMTP id 6a1803df08f44-6b020320c02mr6439866d6.1.1717537683041;
        Tue, 04 Jun 2024 14:48:03 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b418d5csm42118766d6.106.2024.06.04.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:48:01 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:59 -0700
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
Subject: [RFC v3 net-next 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <0fa6bd81ccb75b9fe28971a895bb7a700b30b81b.1717529533.git.yan@cloudflare.com>
References: <cover.1717529533.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717529533.git.yan@cloudflare.com>

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



