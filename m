Return-Path: <netdev+bounces-99568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBECB8D54CF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1293D1C22532
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E41194C6C;
	Thu, 30 May 2024 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KFMlbyfE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39519067D
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105633; cv=none; b=bFVV9842y+xM5XP0rWRyUVQWRLMYtKSEhCplprMvtW1qPlqp/mxDBBSzinroVPpZZsZ8b01Urf6fxB51QXpW0u3mFlSC5qo7hB7uDI1bGTq5H9pRuD/gsJHioVyfoZ93KlqayPsq0jsf7KsfHy47Y9zh86zhtW+FlRlhWtPN9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105633; c=relaxed/simple;
	bh=6dowC/Uwf26NiZaIg168nDsdSN0aKz+6tZkvOLAwGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSz7qz/4Vr0+ZDGkVCHkUy3S/XdiwYbWCZtES85yWhiyJyIGSANGdRHJmrGI8tSGHDwIpqYQwUxn0wytQuv42qzjzPLclyJUaOW27CnV+zWrIHeYSJ/H9ROMg4BDdAGrqBVJXnB3CIgDFV1YEOMTyyv1tFV35BSRiPGKvw353+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KFMlbyfE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f12eb91ec7so794586a34.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105630; x=1717710430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27TjARiWthXWjefcQW0222UB7xMw3bcD7v/H3qDKiuE=;
        b=KFMlbyfELd+IMDBFEv5TVqpkYAIFrnadoOkHZntt+LWWH5Lyvbt/DCUuIzSgcEJyw1
         jThW9oHKYeY+NY4aOwCCj9kYiDcpRCLRQOR3w4wV7rq8auNss+wFYeHVovWx9wWPbDub
         LW5C8L8KXNXc8KXUmI8a/rQMFRQ+YvkhMD+DfJr+ezRo9xkkYGs6V7wy+DOapKKeFHAJ
         fQ4IvRgfrNgqTzSOmi+j/oy0AddmU7pH3ja8xlu0soA40jA9MzxdOz8GFxoLLP2Mc88I
         jDuPxmj5VH1Pf/JETPXZ62xAmTMkYRzi2UNFSrI7V1mMYdhMSjuMdWN7ZEppnUlupffu
         Jq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105630; x=1717710430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27TjARiWthXWjefcQW0222UB7xMw3bcD7v/H3qDKiuE=;
        b=f1if3l0wmUGwOmTR92zn5H8DtvwuQmHGkkmR7QrvEctQlsX7bmO4F6OBoe8IeB0epM
         +ph11fcShzNPUffZx8pwY+lsUTcdTToSgOAkPgnz9i2s/WEwM70Qv6aBv0Q2kqZyAAeW
         ZB/ISJiBhhHA9dCWSfFPIJcb/Si/1zCxGXicLB6+Foe6SzMC8NBM3nzrKxvYIteqBmuX
         joqFbyKfBTjYuQYdk1R/j9x66/xcoMF9pNeKXtyR2uH+/jzILaEZOh1yksermEAc2Eov
         /TGX1IfJ0F4gY1q27uvFZDYk/ULawwF5SQPnCVhgAn8RMkxGUivGtUhFx6jVJ7rgs9NA
         8ipw==
X-Gm-Message-State: AOJu0Yzt1bNB9GkyccBpJ170gPw8NEPUoKQpkfCs9guJNSgwd3Zq2L2r
	QJf1zHmojGuuPkAgTTIpXYzoFNeusg/Qg1eK+gtE3Tn32RKVBs24oPBPi5Ddj2+q3ZIp/0SK7kp
	UMw0=
X-Google-Smtp-Source: AGHT+IHZeVl7ouGz/puxd9+5HcfYhWbufP8hbtU6k28G151wktaPRdVbkT1nW53EUrW/uRp7+N61ew==
X-Received: by 2002:a05:6830:1e15:b0:6ef:9ec1:2bf8 with SMTP id 46e09a7af769-6f911f9fc2bmr93153a34.23.1717105629904;
        Thu, 30 May 2024 14:47:09 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23a42bcsm2009991cf.16.2024.05.30.14.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:47:09 -0700 (PDT)
Date: Thu, 30 May 2024 14:47:07 -0700
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
Subject: [RFC net-next 5/6] udp: pass rx socket on rcv drops
Message-ID: <64c8339aa96232b5d36738162e7bf58412bf6682.1717105215.git.yan@cloudflare.com>
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
 net/ipv4/udp.c | 6 +++---
 net/ipv6/udp.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..e5dbd1cbad50 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2074,7 +2074,7 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		kfree_skb_for_sk(skb, sk, drop_reason);
 		return -1;
 	}
 
@@ -2196,7 +2196,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return -1;
 }
 
@@ -2485,7 +2485,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 drop:
 	__UDP_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..97a327c759b8 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -673,7 +673,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		kfree_skb_for_sk(skb, sk, drop_reason);
 		return -1;
 	}
 
@@ -776,7 +776,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return -1;
 }
 
@@ -1054,7 +1054,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 discard:
 	__UDP6_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, reason);
+	kfree_skb_for_sk(skb, sk, reason);
 	return 0;
 }
 
-- 
2.30.2



