Return-Path: <netdev+bounces-99886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952398D6D5B
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E05F1F2281A
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D861D555;
	Sat,  1 Jun 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xv0WToc1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B01B5A4
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206180; cv=none; b=eTIa7RlP507wtTAYCY4H72BVfrGkjyXkp0h7ZRnZbN2ekI77YNjyfPsJX5YZzpTGC9W9ghkF5qhTa7sypsaq0BaHzUxhmoHx63VCa4nRem0zB6c+VBt95ZTgQ0NR91K+vQjsHT9qA95MqALlVgAoBp4KNwGdFpPscZCpicXgD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206180; c=relaxed/simple;
	bh=1LVHRhrSMWEwJpOY/aznILauVa0NivSWY+f+CAqnbvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7NLfKaenEbkrpFMsZph99/OXis2NJDBHAPv99w0LeczSHB/xNPSdlwVq+D0hcmLwzvGWiHvcBwPmgxiXJmPb4ehbsR+lyU71ctFX+CN+QMP09WJSoQajP0GgjS35bXiRtw54oVJLmo0FiSdKZXaWwtYQZ7kB5e4sLI2czPudUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xv0WToc1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627ea4e0becso25694887b3.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206178; x=1717810978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYA4sm5ZJWs2eGhWm2n7K+ofN7tUeRmWPht1RYEuz58=;
        b=Xv0WToc1MxZYkw9/ypiCWj7FEmuwkczmpehZ0DufYqltgqrX7JDaeZDrOki/09xyvU
         AQy2YzDMP3ScLeqgyv09ZDPSpzyJA7rx8qQjEHXbzfOmdoTdGAPGmMEakDJERmsm0nDU
         fSKeMYiBDcrkM0BqpZBshezHRoxsiPNrsSstqML0tnyfPd0qSrBLGAMOty84sVnyrgg7
         CluutMd5s+Hzbe2tSE4h9+NbGiv9u27k7ndjaxH/unCEjxkwsbYhQmeS3u3ItcAdUcXf
         jsK2geImaHkqYeTUgaIa/lUOjECIu1rPaj92vc8aFL7+QlEHJVQCzxpqy8g5Kjy4o4UJ
         SKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206178; x=1717810978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYA4sm5ZJWs2eGhWm2n7K+ofN7tUeRmWPht1RYEuz58=;
        b=ugpAprJniTAlBOAum5XQsEgo/4QVEg3WtUZsIxVNygVE5e24kuuf9y2nXCf2mDmtDe
         WeYI1XjTLTyY2E/aFeTc9TgPtjaYz9p++pP6p4lIr4bsa/yIJVkkWac9blaqFc5SXqVs
         R8yKvl3CW9R1cnQJtluhTdbWBpo0rr5H4F1fzSW3BuiClk9z3NIOenmPDZpxldZpH1Mm
         zADoFf8faLCKQdiGPyvEg18eCdrZlUOhA/zgudlQVbZGRtog16MkZtKnvhuhQL3snuTJ
         /zIW3yAWkKiKbk/APSHtPdGKJOElLxq9Xgj8XLlJkL34X3oK3liiMJDu3LDay3x3GQoU
         yfwA==
X-Gm-Message-State: AOJu0Yzv7YgN/Rjdi1j3E6rargVI/TR1d9tEtM6cDEY+QnW0q5G8Rivy
	t4spDAZpO8/zhZb+lpz2KCEbS/ncn6BtpRP+8oUdxJM0jSbWugoQEsw8I9HeXv4hyk1kz8jZ6pk
	/qk0=
X-Google-Smtp-Source: AGHT+IHFKpM9VUj5fPdAjZri6ASqCbW12U8KkE2PQMXK9hGY4p9KtRo4Ib8XzSacGGYo3hFMh5BQkg==
X-Received: by 2002:a25:1387:0:b0:df4:d7e2:aa2f with SMTP id 3f1490d57ef6-dfa73dbfb85mr3516117276.59.1717206177923;
        Fri, 31 May 2024 18:42:57 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfa6f150099sm555136276.60.2024.05.31.18.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:57 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:55 -0700
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
Subject: [RFC v2 net-next 5/7] tcp: use sk_skb_reason_drop to free rx packets
Message-ID: <40d89398347be8d269f49f604bf82bdb9855d00d.1717206060.git.yan@cloudflare.com>
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



