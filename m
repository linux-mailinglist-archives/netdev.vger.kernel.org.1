Return-Path: <netdev+bounces-99888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942B8D6D5F
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C661F231B4
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE922B9D4;
	Sat,  1 Jun 2024 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Nqtbt4To"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF102773C
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206187; cv=none; b=M2MuqOygk7G+Bb04Yigq2tylyxM1OsSY3ZZzV99zNwhUBzgLm2xy5VNC2TRlLnC9w3XTMbGaEFygF1eWvbaBo7fWimia8dZ0Pk05VUCeQlFWVTe6rNu6s6Gyo+SnMJxe4tx9cvFGNwtsiAmRjUlusBPWy1/HCFnBYCHgv6NjkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206187; c=relaxed/simple;
	bh=S72Ki5HHkpC2an6q78XTrK7f5rHLvP6MDa6qVibaFlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVinm6YY7471b3wLmkabdSCaRNYLsExF1iGbeMkGibH3W0QN95255GCb9DM1AnqnCXy8J06uPp5eOOkNWvCcASAs7JyRi1uLIA9OFCR/FQEP2iMg36Zuj6oRSpxdCulCV+O478goOxYjygk9HZO9JGXOpNKLkwM5bMrx5r/w4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Nqtbt4To; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a0849f8e5so25307167b3.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206184; x=1717810984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/La4XSUTmNeuu9YRTxpONiBsYW4Mtyght862Rg0qE8=;
        b=Nqtbt4To/8w3O533vKLdhzuG6bV8QHLsQcNSVonu1qpDl5SgF/4KYfk29909tebBhi
         WVxQBeiOpIj4hSnG4N3SbvbvAP09w43N2AA4msyptg1qlsnL3X8bG4BXiwmNPX9+Wi27
         OUoiiwavqaF0wLRjpXWp2t7cMbielEuSFKVwS859mtQ7VSCjJ0+NC0k3rLlpy/xifv8k
         vMzETkn8EPC06xlFzAmorGs0zsZ4nyD/V0xPaq8tmHX/YUsye/PteJfGctczQougjzbu
         PiGyMPt5FzR5UQ420aqx4rlCvIOFZmoaSD8/SuyzTqu/8pkQc0SSvUmZhbVSKa9L5EMT
         /bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206184; x=1717810984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/La4XSUTmNeuu9YRTxpONiBsYW4Mtyght862Rg0qE8=;
        b=sF52myZaTKwIoPkODeDZzKY1Jk3P2nQI6Q2dtt7kDad9B0n7CjxA1BgQYi5lXagT3g
         phZZb+Pzz3EBu1rbc7RMRMhh+Au4cOX27Bk8PxpjsLZKKJkGEdJfDBoxQJutOeEWjziO
         GoxGVfPP7fGkViw/56FBUF/B40tc32034ELx583/+FjPGUikB9WpzjOsv89fWBILZiCT
         2E8SUqYzcsb0XPZC+PzDMr62y3AHqj2A1BtiAuBAMMpOJYuu9bsxTx7GhedQL+G5ldo5
         XVjdOBxxD7bTsy21/UoHATJqfyfaPDQe5kkU9QgSYQuFAh6NAVkJwmmZLtTMPbU4Q9wc
         0Onw==
X-Gm-Message-State: AOJu0YxMiX2hLEGbpebSqkFZcXDr4aTgM+KMTR/DI2ydTjXAsE4jJPve
	Zj0TbuJAIDvU27iZw9DpB5l8bUVGlVD4Lfrjndb7DD5FoHS4UKTcSLNQe2dRVDtXZiQVpZanERt
	dC0s=
X-Google-Smtp-Source: AGHT+IEua05S7PDRoCJza0EQl0jMFsfegyLK1tQ6xf+usXIX97QNBaJMtekX4NLQSbhGYbhg72SnZg==
X-Received: by 2002:a81:4520:0:b0:61b:3364:32db with SMTP id 00721157ae682-62c797fac84mr38162817b3.36.1717206183488;
        Fri, 31 May 2024 18:43:03 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c7667dc7esm5397227b3.81.2024.05.31.18.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:43:02 -0700 (PDT)
Date: Fri, 31 May 2024 18:43:00 -0700
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
Subject: [RFC v2 net-next 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <b86569aac8c4a2f180e7d3e22389547ff2e26cdc.1717206060.git.yan@cloudflare.com>
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

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/packet/af_packet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fce390887591..3133d4eb4a1b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
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



