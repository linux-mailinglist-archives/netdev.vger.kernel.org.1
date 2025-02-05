Return-Path: <netdev+bounces-163094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE48A29544
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927727A3991
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8F1DAC81;
	Wed,  5 Feb 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHgh+gzj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886ED190676
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770695; cv=none; b=gVrWxmL8lwjzJWiHecIztAJnFURLqcJJlnK1+6a8fUZhvgSwQ8VtreqVFcH6FEwjfXXa4GlySe6Er++mYPRIZogOkokx9ExyBhgi4AmQhLdLCE7WJuVdX2fZNh08GdBg+HK0X3nT5kK4aQUtQqeMsMUm5ciTwN0/w98+pOFGAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770695; c=relaxed/simple;
	bh=vDaWHHNgn1bWEPl0PRv7zsig9RoElCDHRaoQj0cC/Q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWw7MrMupmjPIFm2ZzopGJU+20YMLwN9t3AMIOOr76kyRdSJS+kk1z43KnJc2l1NtmpfK4MIodOAANddShAY9X7MUKe0RHbOxa/HpSjBDbQXsq4JC6rDVP8Xu8zM6y3WQrj60Bgo2UCiuZXqggfR31pItQ+XesWC3Df/cA46gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHgh+gzj; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e4237b6cf0so31525696d6.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770692; x=1739375492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3VvVkXoQOBpW0WsqT7kuoRLQqr+20O8tQ41NFxntCc=;
        b=DHgh+gzjDKuRrXgaCkqgiXsCE4pFob/v3I6RYqhFoYI/ztXQwSOn4N8hP89R1fEHl6
         pHb1xatAoU3lEsARZXCnqIOLSJSxi+RYkx+D5ITSP/hFfChBsI6KvSx+NajfqmnVQH13
         WyL2qmJrcffUmpCSFW4jn4GMA4xQPdUpeiI+YcWlMJkY9NGsZ1P5PNknOo9XbI4+6zyN
         68YEphXgOFeN0bp5oXYww7wj0ssGEcMrM+jXRAMN26pf0/jRI9Zjsa32NzOZaGFM4h5e
         u3NK8Rz9emkdXbUC944hfC/1xzkAMaMhRkBHDSvkHjlR+VDucbJa8Zjp6keh8jCAoo8u
         EEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770692; x=1739375492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3VvVkXoQOBpW0WsqT7kuoRLQqr+20O8tQ41NFxntCc=;
        b=pH8fmoPk4PT0YoWJKrsUQKdrGn5rYWrK//QhQtYYcb71fnG1qeF8xXdVsUbLSGNEet
         XW2SI1butsRTYRmRiYy/SsuIsFkQEDl/EPl9yNiIF/JKAYKNp5YIsD5Lm7QE8Al2PDXB
         Dk3pTUrs3pZUL4MJqTzASR8k6Ten3m7yD3lCpEwp48d5S3jcVtFc5zn9KYJcMgHYIdg4
         ESIchTdjhZYakvimM8aRR5cLYXrkNexcSULeG3K4Z8g6lqbkt+2eIBDglFnhgJG1M9wN
         VPeux2ohHer3IV4PQckytbvkj9/NtOJJdWknVWRGiVcb3Ilu7YYgG8c+ZmR3SdLgBZQJ
         5I0A==
X-Gm-Message-State: AOJu0Yx2lONvRRGbUVeJYuabzBLlDb45E4cuVgGJE0zDUMWYqREuD246
	fip7y9hRC4jOm3IwjaiD0wD/6+Rpksj8m+Oer+BZzIfeY5P0RKWZgER70FP78Rd2xNZRaZXsBYh
	4VkYWkIVg0Q==
X-Google-Smtp-Source: AGHT+IHATkkvPF0N+tQw8EXYeZKAAC9VFQszl64ErivYrZfBroKVNJXooLDN3Sb/ARgvXROqk/Hl+qKKqcaMeg==
X-Received: from qvblh5.prod.google.com ([2002:a05:6214:54c5:b0:6e4:1e22:3bc1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:598e:b0:6e2:383f:4ad2 with SMTP id 6a1803df08f44-6e42fbc6ccamr47736696d6.15.1738770692322;
 Wed, 05 Feb 2025 07:51:32 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:16 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-9-edumazet@google.com>
Subject: [PATCH v4 net 08/12] ipv4: icmp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__icmp_send() must ensure rcu_read_lock() is held, as spotted
by Jakub.

Other ICMP uses of dev_net() seem safe, change them to dev_net_rcu()
to get LOCKDEP support.

Fixes: dde1bc0e6f86 ("[NETNS]: Add namespace for ICMP replying code.")
Closes: https://lore.kernel.org/netdev/20250203153633.46ce0337@kernel.org/
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 094084b61bff8a17c4e85c99019b84e9cba21599..5482edb5aade2bc25a39d75ab16feba476bb08ac 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -399,10 +399,10 @@ static void icmp_push_reply(struct sock *sk,
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
-	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	bool apply_ratelimit = false;
+	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	struct sock *sk;
 	struct inet_sock *inet;
@@ -608,12 +608,14 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	struct sock *sk;
 
 	if (!rt)
-		goto out;
+		return;
+
+	rcu_read_lock();
 
 	if (rt->dst.dev)
-		net = dev_net(rt->dst.dev);
+		net = dev_net_rcu(rt->dst.dev);
 	else if (skb_in->dev)
-		net = dev_net(skb_in->dev);
+		net = dev_net_rcu(skb_in->dev);
 	else
 		goto out;
 
@@ -785,7 +787,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	icmp_xmit_unlock(sk);
 out_bh_enable:
 	local_bh_enable();
-out:;
+out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(__icmp_send);
 
@@ -834,7 +837,7 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 	 * avoid additional coding at protocol handlers.
 	 */
 	if (!pskb_may_pull(skb, iph->ihl * 4 + 8)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return;
 	}
 
@@ -868,7 +871,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 	struct net *net;
 	u32 info = 0;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 
 	/*
 	 *	Incomplete header ?
@@ -979,7 +982,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)
 {
 	if (skb->len < sizeof(struct iphdr)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return SKB_DROP_REASON_PKT_TOO_SMALL;
 	}
 
@@ -1011,7 +1014,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 	struct icmp_bxm icmp_param;
 	struct net *net;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 	/* should there be an ICMP stat for ignored echos? */
 	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
 		return SKB_NOT_DROPPED_YET;
@@ -1040,9 +1043,9 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 
 bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
-	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *in6_dev;
 	struct in_device *in_dev;
 	struct net_device *dev;
@@ -1181,7 +1184,7 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 	return SKB_NOT_DROPPED_YET;
 
 out_err:
-	__ICMP_INC_STATS(dev_net(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
+	__ICMP_INC_STATS(dev_net_rcu(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
 	return SKB_DROP_REASON_PKT_TOO_SMALL;
 }
 
@@ -1198,7 +1201,7 @@ int icmp_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	struct icmphdr *icmph;
 
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
@@ -1371,9 +1374,9 @@ int icmp_err(struct sk_buff *skb, u32 info)
 	struct iphdr *iph = (struct iphdr *)skb->data;
 	int offset = iph->ihl<<2;
 	struct icmphdr *icmph = (struct icmphdr *)(skb->data + offset);
+	struct net *net = dev_net_rcu(skb->dev);
 	int type = icmp_hdr(skb)->type;
 	int code = icmp_hdr(skb)->code;
-	struct net *net = dev_net(skb->dev);
 
 	/*
 	 * Use ping_err to handle all icmp errors except those
-- 
2.48.1.362.g079036d154-goog


