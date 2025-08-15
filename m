Return-Path: <netdev+bounces-214183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D3B28706
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74BF7BB6DD
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E97F2C032E;
	Fri, 15 Aug 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vzv8hfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE92BE7DA
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289059; cv=none; b=R9MynONcCnKBIbeJDKR9McUJug5ffWMV8Ztg7xt1dLPgSEMO/lbmKe35+r/t47LzT5vhrClon/2npba9BJoL2CEPLRDJaaiE28CLvKuZvirOChSZUPzOSzVqunMht+5VxxVrOAvcemJyr170FMC1s+2TKnEWsqjbDk1a3nDJOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289059; c=relaxed/simple;
	bh=XyVZJFZzKfSSIkf/pvmLmwKjraQN8W4KgjzemH/XGU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mAP7clID2TTFIvR+6gnJt1qO+Mg2Nba3ZPBcuEjrUBlX8Fny1mEh3d7zhuZ04cW+X/fmj6X/+//xeco3dzDYCC4utdjxHVshX8CA5xIP0mK1VixOBxxgy8ChYy+nwGUUymu80xrja1xXFJR+JcQno7LeboB9HmSxmvtXveerem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vzv8hfy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eaecf8dso1748364b3a.2
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289057; x=1755893857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=4vzv8hfyj6U/S5Ut/cNt1mnZcSnJFucxdlyaNcPlsHbp2xZlKco3aOKky6auRSVlMt
         Zn9DapLv5QhrnuqGroXyaxb14+6ejLNT2gTFZ/oT12XqHqSfY947SD/zJpm8WBhvULpH
         MeX5rneRQ+bIT1cLQ/Bvl/Q8n9yEnBj9X+xAWeKQuPYGNozGEWWNW3OH2W5/j9dWbbGU
         2bAJHJmrQJ6Ohi2ltp2hNP/28wmmB6EufMBJgIAmC+l+t7wcU+eaCOf7lqw+WOLKkuCH
         LZfOqHZ5yzyMstUfFxmjSc5JLCAWs9ouNtUmc6AU+OJvlYRDk9kQEeLWITzj5vRnGka4
         w4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289057; x=1755893857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=Q6cWyvqL1KhvFrXCvI6ZWmVN4T0ynVp0/BiDFigY5BEvdlu0cpuimBMegr3hdTfvRT
         gzVq57dYsdtbK8Tyxv3cqjqiBe85hqVkyMbbtiPc710A4uxyj9rD35wtEfuU6Hc5ek77
         kSzNjMD6KlncDFLweT6pW7sZG4EHH3notPZGNy0LYuwHszXKn2mEGhMebU8PokXrmvU0
         KtSprAkLJHxcBDF4gAqe7eOmP/BV8O+UhmaRF4zhlAU/n0ln+zYXoupZevPsGL3tPmYv
         GgzuDI94/c7apXpp64OqLpx97FhTX1xX18OJipJsJkshk3Mr+D9+sS4z8b/vzIo4P+0A
         wWYA==
X-Forwarded-Encrypted: i=1; AJvYcCVlAa0ve2K+agB9tx655YzYsmgou6RonV+W+IML4b7A5BClyN1t3ZKc1VSh5u6BsRGDbbcod9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8EiKvfATtgyoWSrjpO3V+zfIdm8D9Kq8iq6zvz/NJ8ygYIcW
	PVyLC2gnd2t0L0tLd9Oesst+1h9ryCFKASWZDif/Aw6jjptNzWL9g9aXeWIEwhxIu1isjmS8Rcf
	Gi3Bazg==
X-Google-Smtp-Source: AGHT+IEr+/ZjFkXy8umwdjDxM5J/aKMeoAE5dmVL5UloiD+KmJwNlOPL6BEq/ZXuKgz5B8/N8YhDKs6emow=
X-Received: from pfnv9.prod.google.com ([2002:aa7:8509:0:b0:76b:8c3c:6179])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1893:b0:76b:e805:30e4
 with SMTP id d2e1a72fcca58-76e44838e26mr5098018b3a.24.1755289056973; Fri, 15
 Aug 2025 13:17:36 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:10 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-3-kuniyu@google.com>
Subject: [PATCH v5 net-next 02/10] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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


