Return-Path: <netdev+bounces-221965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F12DAB526DE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352881BC69EC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1551623A994;
	Thu, 11 Sep 2025 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9lKBMTz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265A23815D
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559999; cv=none; b=BysSXB2x9OmoYPWXHXL7hybW9k9zVYt3fRbwBrsZLA8sSoWfxD1P92AMQvYDmdHaAc5/oUxhS+Xljzzoj3p9eW0zD6iezW1QvMXk51rW5StAI167YX+59Y7aPSKxDfDVKl1XbamZ85lCmQRB72zYbQRf605dH7Zr4nPqXCr280k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559999; c=relaxed/simple;
	bh=ciN4weaJrNWYD3SrcACG56G+PE4mHa98uWCJsUXtyEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p3DjcdittT8gkDcpacfO03Z1Dgiw5vo9JEYY2HTTVbjnu7fGGR2lyYf9Go0FXhyhu775pfbFe6yqGGihbGM1YS7XdUb8OTYVZi8Owcbr2QwyLLc4jQ+l1dHXEBShwBfJwKviIs5y3RhkXJXzfpyrEit6VT0//HB87DTrBRC1Hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9lKBMTz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24b0e137484so2216525ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757559997; x=1758164797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nZpH0YKYU3d87rHwwlMFWpOnF/PYqrlxb+V+A0nBn4=;
        b=r9lKBMTzMQHBtLbzGMWAM2bKC85OwEi1C9TStlby+aW2jkv8wHM0KSu+vhLD1zBZB+
         t1X9/eYuhllPqefCsw1J9F25ys0/dQItZI7FNoNt+eZUGi7j/RWjrMq+cJfISZ6M7Q+e
         aQsAhrStiwoCSzWe88GgCQAZq9IB04meofVvMAVHpgBecD06+/m3rzkFrWkJyeC6WFNa
         cWgwUYS8ewoPjP8w1N4f7c930agCBU3ECeVsgAO13bZnAni7c4qByNhmU9mYZb/J/vst
         AvXY4NOqAm0+6e665IfOiDi+SWHVzyzUsYbD6QSrWVIfNWriSgi2Vqjmi2yZlNpwoT9T
         JTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559997; x=1758164797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nZpH0YKYU3d87rHwwlMFWpOnF/PYqrlxb+V+A0nBn4=;
        b=K4fXbcjMs/QpPqPiNecVs1JmyoO18xOOgDH3VfjqyQD0gLqXKhrFjwOYdOxuUst8kJ
         wyg87RTyp6ClWe8S+J9qCZvBn3I3REBm1qMVJzJ9hq+fMkz9h1nU/8PGvDj9ieHv/ctZ
         07+7TRw9WgB06deVpB6aXT8fRs6WxR+tuH8emUYkm5m/wQmTGGZYX6b6H88OKsEwTFlu
         lJHbtbl9cQENgJpWN0sy6Tt82Rv9nmyrrc4cozWuXWReoQMmLbNlmzaT+HFFdq5EpQJ9
         oA52Ysx6CnmFlshoPgqMsRXkBaTGSyEzNu8ojqdXkr4aHMos6S3I4nLxTRjs1m/iB0g1
         ZLcg==
X-Forwarded-Encrypted: i=1; AJvYcCUbTNHibatxarIpOtGXKi7gsOZyADqpIdIsVm+NZXJKCgMKdzFdY68b1ILejnidqI5KvPMCBYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0USsPkIYVdreJ+d13WIL9XrDhSMXTSZLfzacnKUmzn+VKv/u
	MFkfZhWRi36fbJkbUwIw61sQfnPw2noGnccmgxVW3r1mLINODLh8C3VUYEnGkhYK1etTm2NZkwf
	Ts8bjVQ==
X-Google-Smtp-Source: AGHT+IGdSmV5Fs0N33L0nNqVTjes9fj3wYAhyJbQLhdgqrnGdxxtXpdWT+WjHElnenWXoYFiSBvu8ZU8JkE=
X-Received: from pjbov15.prod.google.com ([2002:a17:90b:258f:b0:325:a8d:a485])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e750:b0:25c:5747:4491
 with SMTP id d9443c01a7336-25c5747470dmr695715ad.46.1757559996986; Wed, 10
 Sep 2025 20:06:36 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:34 +0000
In-Reply-To: <20250911030620.1284754-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-7-kuniyu@google.com>
Subject: [PATCH v1 net 6/8] tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_fastopen_active_disable_ofo_check() is called from tcp_disconnect()
or tcp_v4_destroy_sock(), so not under RCU nor RTNL.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use sk_dst_dev_rcu().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Neal Cardwell <ncardwell@google.com>
---
 net/ipv4/tcp_fastopen.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index f1884f0c9e52..de849b8c87ef 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -560,7 +560,6 @@ void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net_device *dev;
-	struct dst_entry *dst;
 	struct sk_buff *skb;
 
 	if (!tp->syn_fastopen)
@@ -576,11 +575,11 @@ void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 		}
 	} else if (tp->syn_fastopen_ch &&
 		   atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_times)) {
-		dst = sk_dst_get(sk);
-		dev = dst ? dst_dev(dst) : NULL;
+		rcu_read_lock();
+		dev = sk_dst_dev_rcu(sk);
 		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
-		dst_release(dst);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


