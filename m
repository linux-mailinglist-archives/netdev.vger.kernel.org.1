Return-Path: <netdev+bounces-213830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD17B26FF5
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE2C1B6708A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56234255E40;
	Thu, 14 Aug 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOoGuS6P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFF25332E
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202160; cv=none; b=M/ZifV63vxW2nzNm5T7InOERI+I/TYdYIObt1tUC+R5+PgizBpo94njajI+sJkqVJfBxveCZZTxd3TQPb7bauHvrns1ezsH2dY67hNFT4Z2jQJT05ktMJW0scnl+MyEZ34fiCyjQ4rudqDFSP1O78JFou2is2LSTNh3Tlw1Wf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202160; c=relaxed/simple;
	bh=XyVZJFZzKfSSIkf/pvmLmwKjraQN8W4KgjzemH/XGU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+Hn3YDGT/XRpwhpMSUQSA5YMF9N8M3H+DN4x/suH1gZhIoGZDjlJX5qhmklqs0ZpuPn6HX6HTIFsgEBPQTOiziPwuZVednni4w6x8K9SKxA+L/k0vWmGEufVa62R/RK0Qh5dXWE8i6pd3MjDVHc2wdkHdpkzA+yHiSZhdn2uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOoGuS6P; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326789e09so2473406a91.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202158; x=1755806958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=QOoGuS6PLrLVYEOtlKI5T8eNQHyAcMh4cBChobGXzGzXqcMo42bibIH/zHtjNpWm0/
         NLd2AEf40k8u9dXeSXewYnszWSnRJeSr21q7ltZ83imxyyTHfMaKC8RKsN7773MstMR2
         9wDF+ayEtVzrn+CQwuCfzcJxjBOUgqDhzBIVynAvkUmAgRjoxfQwvgoyyZP79jyJGVee
         Diy/O9W72+HxlcIBaMY5RILlKNXLScdY5JG0kTYsTjCEctRdITEV552N3YzVwxap3bJq
         kjJQSIScTCa8jkxGbTRcKiosLIuP219FEMheWVpWDYXGQc+uWGhraH4W03OKkl/T2VlT
         3Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202158; x=1755806958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=tQP71JZJ0T9UDc7HFwQ6el17lj6sbxHSqc4ka1T2ryudP3UBixK7hqT4eZm0SaG2tc
         B8Va2draP91zOovVG20AclfQSRB2pnrYUyHQgJNkMQgSo2l35D7JHTBUI4TV7Xhwh7aS
         dqnaVwuvGWbtoMhR3Un3hZE/V4ApyEkZJC2OmRnaD92vbxeVBtKCu8yJtdS+hq0teMtp
         AyCKRBpM0lH0geZ+1UVrqhCJk+xza1PRni/z7/hYLN5Rp2E6tkDBN6i9P1O4Hz4ptlYu
         c6KLNTE+bo63P208KR2MyK5jhoXPVAybsKOOVae5e96KGmJQ8bxzY9OhCzxnedvlXvU3
         e+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWVXIN/4okeOzLcrzO+qAsgvTg/n+dk3TWNNL9NYxbtM5uHrDxrwebYFw49ROfWlEhZ7CZQ7tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMy1SAkdWxJONCOMN2rXsxg/yfIsmaPXIQbRgVSIYa9CgYUAnx
	KPSI5lcW+/CkRs9IpaHLO3UnCOo+qTWf5y1im62JMV3h1rW7SGbk2tQam8K1uJRQSHRA7NQEgQX
	KaN8djA==
X-Google-Smtp-Source: AGHT+IHJqj8OCBO957elyCb7Tb9EvqaiAKT/a7fghGIK2eeAw95lJXxXFobtfukkiYu1/mXizBdvqnwNOyA=
X-Received: from pjbqb16.prod.google.com ([2002:a17:90b:2810:b0:321:c300:9aac])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0e:b0:31f:16ee:5dcc
 with SMTP id 98e67ed59e1d1-323279cec2fmr7690481a91.14.1755202157953; Thu, 14
 Aug 2025 13:09:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:34 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-3-kuniyu@google.com>
Subject: [PATCH v4 net-next 02/10] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b15d7fab5c4b..a1787a1344ac 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -788,9 +788,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
 	 * as it can always coalesce them
 	 */
 	return (data_avail >= sk->sk_rcvlowat) ||
-	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
-	       READ_ONCE(tcp_memory_pressure);
+		tcp_under_memory_pressure(sk);
 }
 
 int mptcp_set_rcvlowat(struct sock *sk, int val);
-- 
2.51.0.rc1.163.g2494970778-goog


