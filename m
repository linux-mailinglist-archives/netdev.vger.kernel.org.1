Return-Path: <netdev+bounces-162107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C8A25D00
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C3164B23
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E354520E006;
	Mon,  3 Feb 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aN9BUGVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48C20A5ED
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593054; cv=none; b=CBOVU+T4pxSqK8VoRMlSZb3aBGkyxtbR/zLGrIquNnFytAPjEe0+WeS9seTTDswI44GfQGrLbKA8dAQflec9CXD0DGbA+3paj7tlOzL4Nw4cKissH8sAtB9XkNAu8ogGRLlVli2xb49K6pRkJ0+mwF5d4qipoa49c5lnx0/ULRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593054; c=relaxed/simple;
	bh=BjDBT6Ld/KkPV9e18e0rFMjRoUhNxwx0+3f23tk62VA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hhj2FlPcEj2gOuh2ulHne31eFPOiaMc5LezVZTsz3CT0BOcZFSZsjUGxBQrEanx5pfi6358sJfCdLp6lgWzKh8142phvXa7NUHlYSdu/fBH6Him/dzlU9j5Oi5tIgLZklEzWWoTh375zTglvNxT7og4clLAJRrkKy1e4yrygWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aN9BUGVt; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46909701869so99361001cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593051; x=1739197851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFUTWn43E87kH4WvQpJOMQwE5y357mjWskRk2Y0FDpo=;
        b=aN9BUGVtij+kL9hX454yLyu9b59FS0OjI0g9GDzE6TuQPKJM53B7Pxh+/WuGuPb+Q1
         JO4H7LcnuXT66ZjdZ+A49QuaesTa4uegkRf9VjFt5/OFIwlR1Xk7NTsa+a3IvxbKgnaa
         n/FoBdYF694IU2QHutKh9p7zuxPwgAqeVop6oM6C2Mpdl458z4SwjTwVfEhNcud88C55
         UipVaUH+Uu7e60JeY+T7OrfFpVgwrNX20/Dyx7uFoh2UmDLSeCdly8BMXjjfT8rvSF9B
         tIJ/cjl3qw7rxiqjPz/JTOGgfMbqn8DMBWyas6ena4IYug1CWq347Amow8H4EV64J0iK
         QjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593051; x=1739197851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFUTWn43E87kH4WvQpJOMQwE5y357mjWskRk2Y0FDpo=;
        b=tRERXR/h2qaKN8lHP3mvvqQI/J7jvJvFbrXQkbLRcqtIoCJSDjLt3duUmhLn5a95OP
         Tvc/cPTcwJt1kNnIn4bvVo6LPDH8ufKTxUI0vI2QK4qcLvvUaQmWJOUtGMJ6dxkKIYip
         Ae/PoYyDuvhyaD1gsfmlk22nf94+wnGebRdJvIkMboyhufwqOxZYFkCtBdGGmy+gPYXe
         UroZ6gdoZKV5Df9ubk6g/EuerE+38heO3PelO+GP1hOctel6WgQlzYwgRDLoiSoDGcVI
         Hm18ovBk84qUOx702WN4E3BQgEYwNxmfwy4Fmq7EGR+utUvepgJYGxVvk/VHbGLew8jj
         7gvg==
X-Gm-Message-State: AOJu0YzQIA25nJ2bVuZ6EsZnpoI9qD7Z7H58WZS3dwaVOKvd/0Uck2NF
	EknDyJf2XpfoH6xzyceHRR90IowfbxT6cJJPOA2Fev7ai+2jVJhfv/SKzF+XQsZJIHFTJHHkSQz
	ICwOAYU9Ajw==
X-Google-Smtp-Source: AGHT+IGvYma/ATaRnFREOH+tvmRCOgKofawknl3O75OVXUcuXOjekwJUF7rPMvr5TPMXLsQWwTghwJmc7WQwaQ==
X-Received: from qtbfa8.prod.google.com ([2002:a05:622a:4cc8:b0:467:60a9:3317])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:90:b0:467:6cce:44ba with SMTP id d75a77b69052e-46fd0bcb95bmr347270301cf.43.1738593051103;
 Mon, 03 Feb 2025 06:30:51 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:32 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-3-edumazet@google.com>
Subject: [PATCH v2 net 02/16] ipv4: add RCU protection to ip4_dst_hoplimit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip4_dst_hoplimit() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: fa50d974d104 ("ipv4: Namespaceify ip_default_ttl sysctl knob")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/route.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f86775be3e2934697533a61f566aca1ef196d74e..c605fd5ec0c08cc7658c3cf6aa6223790d463ede 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -382,10 +382,15 @@ static inline int inet_iif(const struct sk_buff *skb)
 static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
-	struct net *net = dev_net(dst->dev);
 
-	if (hoplimit == 0)
+	if (hoplimit == 0) {
+		const struct net *net;
+
+		rcu_read_lock();
+		net = dev_net_rcu(dst->dev);
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
+		rcu_read_unlock();
+	}
 	return hoplimit;
 }
 
-- 
2.48.1.362.g079036d154-goog


