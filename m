Return-Path: <netdev+bounces-208683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C40B0CBEE
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C73172DFF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E39823B62D;
	Mon, 21 Jul 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+14S70Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931E23D2B6
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130193; cv=none; b=s+2VdgvkZEZCFx0sNYLCQ0H/0WpdCG++zvDhKXQXx6yIrhNDxYiIZSx5UatuDgHp1oEQx8Aton+sjmmzH1ZHRbBLE2AZLS0dTecVFpNdJah7M5HmkngqTHIj17AYwEA31cNhcgIq2aYiD3Lq6kNDeC+Ykc8LTgsuhTCfuNVuDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130193; c=relaxed/simple;
	bh=lqqyywnLH34ueK612ieCcIgpjbH8J04q4qB8KlcMhUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c0L0PEEI2n3LU0C606uSx5jqTdfmlrRr1R/Py0lE8grBp9Z6XYv9tjkrRG1lH8pxzCi23BCzJqRjtgwzxLI1+NxFNgApPAvZ0s/2C2S4iY/Y4d4Rjv+8P85Tm3Mjz3Sl/mDat5Kcv4+ptFRKrLw6u+RkTqjPfMzcWCKui1RVTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+14S70Q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756a4884dfcso4489804b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130190; x=1753734990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc1Ez/xk0myRMpWYi7JwhYCdmsN/iTRwifsr6matvKU=;
        b=3+14S70Q9jsaXsxqvMDpjYpF6kYlJe7EfRnKBY9/TrskMmyPMepz3uX0oTgUHJcXvX
         QEG3ym5rhBhQzifFvdxqDIG6tuu19B8R15Gc/m/JfDvWpUrZiu20Mu2s1JyXQb7Flzs9
         yUdTTHJPRUJSd6ZAq00OwZWAFm7SrNiNrQs2qIfj0cBB5CVtIe3itI8qFTqCp4y9V/Xv
         4yI/n8dXilxSKIKTIrzv8iKbQDDuyUdkTpYqqrPNd/LCWqaha4nI2cC+1QT9LAgMcVj9
         tl1YT8mgkdloar+amjUAi9zdG3Rc3GW9QvB0MR/ktkAZurnLF4IDEmlwTwYSyfkQJvwH
         jaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130190; x=1753734990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc1Ez/xk0myRMpWYi7JwhYCdmsN/iTRwifsr6matvKU=;
        b=Cj0GkIqrv6qxDK57Nm0fqyxllJeYoPT/mSezf6HjZ0TC8opNr0OW7/xGyk4yeyCKiS
         C6eVr/mKHm9VDxNEtLFrN/mPkOtV5KHGiBUHH1wB5Ha+75iMa7kKv8u1isyO0sBDjn8x
         gaQqPA3Wgjx4Zr99QthiycqKJnUbY57tlWPfNeluRSXZ/Mcm2KpZHyjh4soGWWOncFwy
         0ejNENZXHUuWqOqPespe/OoScovqyusVmnH5EKNsmKq07BKxNvwzSVx02+jQB1j09A9l
         /b1EYuz3Uq97EuXh0XoJgq3ng9u+4JS2o7QYN4q/JZKMSa+lDE5m9Qf5cloz2mWWAuSc
         Qgig==
X-Forwarded-Encrypted: i=1; AJvYcCVzED0RF+cPJKLA/Hl0xtq567TuJdzmY7Wq+BV2JjHlDe3/HQN0HqU9yF4FLGe1pfmLxG1AqRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkeezaJV4JMFUq7flCzisBGfm4Lvq8BduOqbFD254V0ungzjrZ
	GoF2k4Lm7+xxlnNySMu3BsN9HuZoHN3LZiSwmm7E3XeEDBCyZ0GMAoeG0X7PGFKb6hgMMBS5xGx
	TEp3JiQ==
X-Google-Smtp-Source: AGHT+IGaUy/HgUE6Lp8HLDEGr2kbd1XL7Q/OQ0eUpQ2PrdZCIeYCL6Si0ZJ9Rped6b5KZL3DccuQO15A9BE=
X-Received: from pfbhd9.prod.google.com ([2002:a05:6a00:6589:b0:746:1a7b:a39a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a05:b0:742:aecc:c472
 with SMTP id d2e1a72fcca58-7572266ffdemr27218148b3a.2.1753130190133; Mon, 21
 Jul 2025 13:36:30 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:21 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/13] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6ec245fd2778e..752e8277f2616 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -787,9 +787,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
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
2.50.0.727.gbf7dc18ff4-goog


