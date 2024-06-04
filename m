Return-Path: <netdev+bounces-100763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D08FBE42
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB45287071
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93714EC5D;
	Tue,  4 Jun 2024 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Wfjeidr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990714EC55
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537678; cv=none; b=LFfNN6CeBcVmsAYafL4qbxAnRUE2zN43TqGQrWn43rs4FkPfXC+aZ+GKHzBaMYCWec6vWPs2qRvFgcP71rNp5Vw0PTRR12Wz2mo+bXxldHfVu3TkmVvF2diumWQuARQQFVkd80Rys7QRO0vQaabOUZ7ZDnbXnFv0eilg8/HGHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537678; c=relaxed/simple;
	bh=deJZMXGB4u9IlWilhC165qOhNKSkcsd0Cq2qS5gJdV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSMcwrrXKsQjCGTsiU0NV0Ew9RErHWTEAvigH1JT8N+TDLPlJuAA62VhN8rFCiwRwdql8fZKgJg4GTu1vH22PfyrQWxX+wuuoAtYFpd77qKoHcgNSIEtEPQahd2pOpgNHAeO01iyTsMzAN+Sfw5BWIaaely9mb9UL42S286w/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wfjeidr3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-440299bcf53so2257151cf.3
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537675; x=1718142475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+g79hCGPCQt1VIhgByLxRis8HiHyiHDdOiniWzs6eI=;
        b=Wfjeidr3NAdkarc/ByAXIbSjDNtXTqCZgl112d02FVLYYsAVJd4Vy9UsYQAzyOpbPh
         5xaJFSnAzThc/6Sziy6n7uemevbHYaY8V9jdL4CqVMANH3B21xKTihUGlSF1HDJiuHvn
         CAQXMvZ1uxNUrw8spiajZX+KMHCRadFJvUK1+7eHx/GzFzBLV0i19N13E7lu1BMOwmg0
         Iv0fqzZExmP8BPu+JOMj/8BU/n5h28sngx3sh4eI6ycT3uEkdnV8ZixjMgq9S31WrpZl
         Upp1THSjnUFxOvJsRT0KovDyjkOwOh+BjX/d/pzVIAWA3Be/tOWUmcPP4zsnS3kaVk/o
         TK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537675; x=1718142475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+g79hCGPCQt1VIhgByLxRis8HiHyiHDdOiniWzs6eI=;
        b=AHk6newJTHrZnmsbwcuoVPgqfqH9KM0gL/bI7UQvVPmaRgPt8cblQhpbjujP5iqEGe
         dTamVRuAok8A79UHO78+7J0Xk8vuKzujUZK/Yy2vMRTOMDM7myWAg7bUeNgA4Fvn/Tcg
         y9yUnlkdiW0cF5Rp4wsudPrvXHxj6aG5juYzO3UzEL405PYNGugJvXnYqnFgWcKtBGRx
         W8oDzW+BRl55tBkFs27tAj/ZDbu1rgpzWCB3/iwIzLyKCA5jJ0dEW4ePmGkrDzsvquLc
         BcVLvJc5hPu47QkXpdsBObClH67sBcTJUhgVUcYY86gAkMrm0b8nfIMiV0ZsfMjEqljD
         0t0Q==
X-Gm-Message-State: AOJu0YzLl5JOK6py4smxPNMDVvXgqh1or9ufiPyUihYy+KDZVOt8mcvl
	eC2GLpy77Z7Bg6wjP6KLBFjYiqzHJT/KRXhoAGKDGIBqAACYShPXrUej6veUnIL5wrgq4TpGeJz
	Uj2M=
X-Google-Smtp-Source: AGHT+IF6wYK2vSs0tnZLGeGleWFepuv42H+1iOxWPaTWSUI1YgoUnJSfAYdRv3oVvyAhsuPNnOPBfQ==
X-Received: by 2002:a05:622a:452:b0:43e:e6e:21dd with SMTP id d75a77b69052e-4402b58ac7emr6655911cf.12.1717537675459;
        Tue, 04 Jun 2024 14:47:55 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff35dfd56sm51508081cf.21.2024.06.04.14.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:54 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:52 -0700
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
Subject: [RFC v3 net-next 5/7] tcp: use sk_skb_reason_drop to free rx packets
Message-ID: <350a9309892d44cf45eff3ba84df4cfe0fa7a5b6.1717529533.git.yan@cloudflare.com>
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
Closes: https://lore.kernel.org/r/202406011539.jhwBd7DX-lkp@intel.com/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: added missing report tags
---
 net/ipv4/syncookies.c | 2 +-
 net/ipv4/tcp_input.c  | 2 +-
 net/ipv4/tcp_ipv4.c   | 6 +++---
 net/ipv6/syncookies.c | 2 +-
 net/ipv6/tcp_ipv6.c   | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b61d36810fe3..1948d15f1f28 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -496,6 +496,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 out_free:
 	reqsk_free(req);
 out_drop:
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5aadf64e554d..bedb079de1f0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4859,7 +4859,7 @@ static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
 			    enum skb_drop_reason reason)
 {
 	sk_drops_add(sk, skb);
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 }
 
 /* This one checks to see if we can put data from the
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 041c7eda9abe..f7a046bc4b27 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1939,7 +1939,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 reset:
 	tcp_v4_send_reset(rsk, skb, sk_rst_convert_drop_reason(reason));
 discard:
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	/* Be careful here. If this function gets more complicated and
 	 * gcc suffers from register pressure on the x86, sk (in %ebx)
 	 * might be destroyed here. This current version compiles correctly,
@@ -2176,8 +2176,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	int dif = inet_iif(skb);
 	const struct iphdr *iph;
 	const struct tcphdr *th;
+	struct sock *sk = NULL;
 	bool refcounted;
-	struct sock *sk;
 	int ret;
 	u32 isn;
 
@@ -2376,7 +2376,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 discard_it:
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
 	/* Discard frame. */
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 discard_and_relse:
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index bfad1e89b6a6..9d83eadd308b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -275,6 +275,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 out_free:
 	reqsk_free(req);
 out_drop:
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1ac7502e1bf5..93967accc35d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 csum_err:
 	reason = SKB_DROP_REASON_TCP_CSUM;
@@ -1751,8 +1751,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	int dif = inet6_iif(skb);
 	const struct tcphdr *th;
 	const struct ipv6hdr *hdr;
+	struct sock *sk = NULL;
 	bool refcounted;
-	struct sock *sk;
 	int ret;
 	u32 isn;
 	struct net *net = dev_net(skb->dev);
@@ -1944,7 +1944,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 discard_it:
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 discard_and_relse:
-- 
2.30.2



