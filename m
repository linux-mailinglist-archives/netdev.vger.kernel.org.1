Return-Path: <netdev+bounces-99569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EC8D54D2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1831C20E23
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D58194C9E;
	Thu, 30 May 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RIqk3s5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DE194C89
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105636; cv=none; b=Zd5hSz60fdToZFKbWthUgoE10VBjBNDSEM/fA8NK4pVVHn9x1hhhmfDu7aFwnK8slO3WZQcalIH3W65NtcQ1HQcvRgoimFuQJU+c45ep7AZwBkM7iiQvT9caWKh60iuP+bmaSb81XZ2j1zl/7ogIadoJ5UkxQvqlquglAQS/SN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105636; c=relaxed/simple;
	bh=zBPfgKOCZ7FGTb7LtwnzoLHAcib59MLufF+CqN5TSP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St9gi+8JW8fPg6hADpNCsUUEiU0Tf/K47OyuPNAiZsrs4IVoDr/QBjGaKrFj4+tsPUHcA6nR1BSaowUx/NK7rJKW+/oqcb3RtqHXRkAQeZ3kZNP5DAxE529VkqlhgoxNSjjh+ZnuOXj+BAQrSBfd17/Qf/6IRbfpADE1VWjFeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RIqk3s5l; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ae0bf069f3so6871106d6.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105633; x=1717710433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hK/RV3ZAvRKcX5XY/+KVfGOngLsfuJvHovUEHHeWptM=;
        b=RIqk3s5lhEwhRYw2FJe+5RyMoRbsOM8vHvqrYMHGPlB89vYoQ/PqZ7HbJZtaDYZUWa
         C4JTfmtEFVTY6rSLh1NYvVTpzyhPWLBgdF66rNKCmdn9ac90gzM3GvhWEYUwj4HVfVoW
         NK97NcO/BRerw9aXN0sm1A/l2CIHmsIWZ1O6zkzt9XrDCpxVatMWZMqVnIXbG+Tk5KBm
         opLgza+MZ9UTbMGVwxGJCPLu7jpqvYlrA4mDcBrBRHmJgg+5g56VQ177iT5/x5L9tmij
         o4mNTmuUpveL82Ywmx556WyuJV6C3HpY7Z61XYmiXJhENLJLWnOssgh+KUNMe77nPjO3
         p3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105633; x=1717710433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK/RV3ZAvRKcX5XY/+KVfGOngLsfuJvHovUEHHeWptM=;
        b=uJWFRjzbxIzc3b0T4WP4UShP8CYfCx/9ChLcGSMTv/65DaW9gQvSW1iwrACM+UVfws
         c4fL1i+rMFbJr6mLCWAXQ8OFKMwwicnE4Obm3+CB0FYztk3apqOFl/dwtUnzacr1j+Lo
         Nr32xfE17HjnpexU4Xav4q3ZjVedEQpM9oqagMC3GNz5NjKsZ+/QJpV22UUzHUiurN6x
         iBkYniDNuWPzMTGMcfv/Qr8KcLiIBMOc4VFtx0h5Wn80M6s11LC/uKSBu9yTHG9NK2Kz
         vH8f3Xv0NLEHHQEqEsXUltCuILY8KXLPg5zT639k+1ME0+OTUBjnU+PNSARiFQ3+PCD+
         R9Pw==
X-Gm-Message-State: AOJu0YwWIocZ4fP3s0JwGPygo5uu5nSHwTosuvMYLo3ahQn1y3T5FPGz
	/Z4hKUh/eM+lesU4xPaCDPKMpPy3L4cHJuSNlO5gs56XzE8euPd/a8k6/Gp57hm7aeFCNPHWLp2
	quI0=
X-Google-Smtp-Source: AGHT+IHbqI93EibzSyAta5LKCbpan2p512WiBaSen+5LGFNq3txKFmbJqCRt3fWHnZRqPqSQpd153A==
X-Received: by 2002:a05:6214:33ca:b0:6ae:19e2:39d3 with SMTP id 6a1803df08f44-6aecd6ef732mr1410496d6.45.1717105632747;
        Thu, 30 May 2024 14:47:12 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4064d2sm1877406d6.91.2024.05.30.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:47:11 -0700 (PDT)
Date: Thu, 30 May 2024 14:47:10 -0700
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
Subject: [RFC net-next 6/6] af_packet: pass rx socket on rcv drops
Message-ID: <df2ad57a2986038ae9b5e46c73d48c22bb86b788.1717105215.git.yan@cloudflare.com>
References: <cover.1717105215.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717105215.git.yan@cloudflare.com>

Use kfree_skb_for_sk call to pass on the rx socket

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/packet/af_packet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fce390887591..30a6447b4fc4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 }
 
@@ -2494,7 +2494,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2503,7 +2503,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
 
 	sk->sk_data_ready(sk);
-	kfree_skb_reason(copy_skb, drop_reason);
+	kfree_skb_for_sk(copy_skb, sk, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2



