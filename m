Return-Path: <netdev+bounces-104221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA890B931
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDCE1F21652
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E119AA75;
	Mon, 17 Jun 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UfBBODtG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FE19A29E
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647774; cv=none; b=PSBnK7SX31JVL3QQ/ps/AvkB8bfi1vse82Dqzi3CMtJdclW0B9ppnwmn4ebruvFpVyFMiKTJQGiz3S/ALHdaVWOfaC3Ouz+nhkTqGkYo4eExOgJBlsVIc3llVnwrj9dAAzIsLvVR9quzjTejgf/1iBkPLbInPl8pTm6OvVz96cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647774; c=relaxed/simple;
	bh=uEGMHEFbMp0HLSU5Z7U4ENmeA4RvQ8IslnoZTeDpYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq1WXF5CBU/OYIiUx/hf3rd47F4sCaTZiSMC6g8xfHNB8Jc37V84QNscSrKy7TU6NpY5SbMWuosicp6ndysWRYht/RAHtDLlPa3mCBRoyByz3lrKxhNVgMUcutTmFeGQ7GqaT4pZaOPRZqIalqsQlNsHhgMQKuY5hNR9JMNeOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UfBBODtG; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b0745efaeeso24523356d6.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647771; x=1719252571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=UfBBODtGKX/lYpNEADTZF7usQLHAoR7lXwZbFTkCpc9B7H2T3I/qYP7GWU92eAz7SK
         zmaNweOEbrnmPRsjPUlZTDKNxP2qsZkNN5h/l5B/dYvfVrCgWIBDWYbz/5oboRKEYabs
         pU0b6btpML9W2UmqbXhViWf5fUSU4LQRDn7IzEhHUL4LLcMEKx2WJ6RWli3mflUKNm+h
         p8sdZBX6DGzKQ4TUVyQ9FJqwm29WMJOc8L+Yknqwgw0blc5twDq7gwZWzL2MQ8D0rAvK
         420o8o9gHFdRjMhLKKQTKv1kDTHJ5Rob7HGGWbJIi+JlA3YA4ty1td/a19WrEJ8CwzMY
         xMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647771; x=1719252571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=JPvfEoZ0bMRW8VLxSe8eDjVY+fifiAno6WM86rMRB6lGOqUMsNsDbTUTuOO+JimnAP
         HsaqaFzYMWKPCH+lfpg1yNFmCA4sWgGjqy17/cn00slq4NKbZ0eHlzN6pB758LQ1XcEf
         /xi8D0sJzWk8zs9BV2wCBTjwZ/qsuo2JXMNKIPm1AWYB8rucEfcQXfgK35f7KBbVAy2J
         C5clcEOWacTeS4zDS7q/MYKD5EXZp8Ksa2djIgBEty7q//cr7bWxWErCBPaCX4xVg0n7
         xDFdJyGj4jGVTRKDhFCGE/lC+32rWtWhYDAqwN2DqNdwOJD9V7K22bRvB52K+kEfddh7
         XAOA==
X-Gm-Message-State: AOJu0YxVZ7rjjgEqj5uaddkv+6kksKeCY9T/p+amAI8Plu4hir3G7TB/
	b3qwBlHXRsXy2BRsNG07n7D7Ayv6CXCMNt/3TupZeXi+2gnvIpwt97qsp6RvwQsF+75GS+IJNL2
	2a+E=
X-Google-Smtp-Source: AGHT+IGDb1Z2mu+N6vTL3KwtF1RLgOFuZEZO687nwA+LSC1hobQujIxWESlnTh3cU3IQaPtqTnbLhA==
X-Received: by 2002:a0c:aa59:0:b0:6b0:82ad:e89c with SMTP id 6a1803df08f44-6b2afc7924emr107624276d6.11.1718647771318;
        Mon, 17 Jun 2024 11:09:31 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c4664csm57391246d6.65.2024.06.17.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:30 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:27 -0700
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
Subject: [PATCH net-next v5 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <5c336e8da85ce9940e75b9090b296cc7fd727cad.1718642328.git.yan@cloudflare.com>
References: <cover.1718642328.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718642328.git.yan@cloudflare.com>

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



