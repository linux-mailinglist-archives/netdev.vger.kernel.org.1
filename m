Return-Path: <netdev+bounces-161793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE97A241A4
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230C41670B5
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E51F03ED;
	Fri, 31 Jan 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkiiXPbM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AA1F03D0
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343624; cv=none; b=Y8f2OLGtV+RQBbjuv+6ShaRH+S5prrgXoNtz1wv93hWFlGb3SmHTGbwmrwbFo002Ld9htUhu2hkq/H7LGiqi0TGK6t89GCmGRUV2mBKsxkV1BLMfC9tD0FTYjzLsBU1qHG53SFXuW2Pf9ot7uNU+WXBdEr8B17Zx+SU/uclLcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343624; c=relaxed/simple;
	bh=yK1qPK7YIzAljxGSHnEbpglppqaNZSTaU9FwgiIREj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4e6Xi9R6YGivxk0nAUA8L2/F3kAi8dyOqR3+ew2NLzwSgnrR5oH54wFxqRHiT457OpClYxxXKCyvj2T/e+/pF1QoZkx+Bh7Z5wo+nlBvqtUQZDiiAw0gvg/80bLkfq2Dw3RLlZEtBG6r6dASopHC5E8KJeCLX/t6P6sjhtPNRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkiiXPbM; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4679becb47eso53121671cf.3
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343622; x=1738948422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSpYIA9faa8FVS0Q0XzrlEe/dG4l3XDdB9pyi1OhEOw=;
        b=OkiiXPbMIk5rWKcsnJKG5RWtAtCI2ELpH+cYZqR7C8hVsAc0/kRzMwnJvMmkQjhaPN
         8CgvWqIsFtCcGEl45cGPzT8Ul6zxbpAN0aMlflod07yddJ5zjLlUjq0oHM2zpD0yBHVa
         mBhc0VlE4pLU3MzTC0FS4O+TgFP1ZBYg++SAv2LPKaWL8aS/WnaC8fTAjvnokGnoaUhT
         vGPTRuVqKZ0KVr20w4fHH0ee+BGKkMTUlifLhFEZIbcyAyF7NVFdZ+k0c/qm5P7rqbpa
         Hr1jyS/d4eEbxRHAv2XZxswban0w7kXDu180h1WEOoM5RS9bvThDKocnBqsb8plyA5A2
         ZeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343622; x=1738948422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSpYIA9faa8FVS0Q0XzrlEe/dG4l3XDdB9pyi1OhEOw=;
        b=N0MfwOAmqiCKgQCL+NgdohpbQm92Uek5pU4vw31oKZDqwsmw8Pr6srlxVmOpJ5vd0h
         UADp8ZVLEvCEr6BuHyHsGRL2XbqIH04JfWBEyoVtbh7DibIFRebxxtwaijT/rAQJC8FG
         Jb7yqGu4GwX4aEYQ72Q6qBvaGdDLbxufRE4IUclm4cSed6JTmt8Osg09sqce9GleQmsQ
         5DdHs/njbcprQC64vkxvSjOIJ9P+QTsFkc/gHTLVG63wON7kHSDz+SztUordzIqiJASn
         XXaHx2Agdt0dOp3HNDo4gaUhLf3h1vlPayAckBs1xbnVs25a0Apbj1lDTuR7pwn3RU4n
         zjdw==
X-Gm-Message-State: AOJu0Yzoa0VNlqfhYt7DCQedxbChH6vClOUSBhH8TDRY8OrY4Iygf7Mp
	pfej4hAwzjGTn3I7pay2KgYAN8daZ+3Lc4nYrAtkR7ZjV5PLY8njjnXjxULzu9mHTAiww8hT0R1
	9yGLnXJ/oHg==
X-Google-Smtp-Source: AGHT+IEe+rIlE66ox8/LKjtCs4/YNHfVdjjkgDUaP87lLuM4ouFSdkzobuhYso0GAJDUNM1LFfXlfUOD5k+L1A==
X-Received: from qtbhj5.prod.google.com ([2002:a05:622a:6205:b0:46c:7332:f1bd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6185:b0:46c:7647:2ace with SMTP id d75a77b69052e-46fd09395c9mr164403981cf.0.1738343621795;
 Fri, 31 Jan 2025 09:13:41 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:20 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-3-edumazet@google.com>
Subject: [PATCH net 02/16] ipv4: add RCU protection to ip4_dst_hoplimit()
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


