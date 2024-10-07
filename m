Return-Path: <netdev+bounces-132835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD54993623
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143381F20B68
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F431D958F;
	Mon,  7 Oct 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1JILRZN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18C1DDC32
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325516; cv=none; b=O4UNhfTaP1PR2MpoS9lFiiu7R5zY6LHkXwpt1ses0z5dErN6V92Z/WlRK2oTeWZiZw1nC3bMlzYlTkfqnTnG9TM5eMzuR8SIx8PbwvzDH3qqiWwgx9jRjB9bSCqGHxkHkYverkxD5xlqNvKSCBIaI03XaVnN/SVgfeHG5RLjIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325516; c=relaxed/simple;
	bh=oGtEuK+ebNMAjT7/nnwBDyWAZ4aVWwWtDDHgyTwJvEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U84EOiNAkdxozL8kyGvqxOFtElwrnY6fswPpZEBmWpNc+BHD6ta9uqLsQru/K6mltqjotLbdaXP46S8hjwSFEir6KSHF3xhz9bpepBi04Fh/z2f8QID0PZFHhHKVYsL0LUHg9DOK3VylCvwUIRc2gY2jDqOLYhWMGbZ2L4E57z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1JILRZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4g1hLpzfKGShOmDLdQ19djFGvaS09pRykFK9NEmYhQs=;
	b=P1JILRZNBs7qtGMDt19SX6aL/M9awP9SINp8bIOUGALMGcqMHf/kW3JkW1aNgcWhG7xXVY
	F6xZm8DYxwTkashbmD3mHd/+3NexKwYuustdYPLqCnhLhg+ugZPICS9GJC1lSzGAEbui5/
	r+Ekh23grgP+baH3Q6MWDQCZg7tPMxY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-HQJH54XEPNurRzPzJwoyPA-1; Mon, 07 Oct 2024 14:25:12 -0400
X-MC-Unique: HQJH54XEPNurRzPzJwoyPA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cae209243so30350325e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325511; x=1728930311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g1hLpzfKGShOmDLdQ19djFGvaS09pRykFK9NEmYhQs=;
        b=FNiYUdY8DzzGL13p4fqusjeEZIb20qgfFyYLkFJGQdLc5DCHdM+4phrQxY4WUP+YsB
         8AxuZMLuDF/Mg5hKDNHXf2GHjbeB7WJBrnDG0BZ2lRhPUDUJL9s/J+EHOIOJrs0FOETM
         iHMHABAeoe6PUKcfu3c79sx6GFvnv+vbCCsb8TxWLDh4DBbMt/Ds1U4VOh5uCK8+A8i5
         L4BIBG00r/gqISHZNRWYW5uuTW+8OifZlHTY9M8BpnQCC+upYkEpHF4xcDa871D0nw+C
         B+icDwnNydBXp4V60sfyh5+luybVaDJXwLu9nCwyEad3vPG24L9nU87PiN8pjg0QCaG/
         Hn4Q==
X-Gm-Message-State: AOJu0Ywsr8/IeslEMteAgeG0lsIKJ+iFQMCzwaUramGquJ9db/uTsoUk
	a4bSi4ELIebD+v//e6VkKQ52/5weBvohWMdFHe+OBPNd8fbCmT8W14mNdBEivbvychOvB1wSrkE
	DLWs2lJVhYq1LF7siu8Zr7/wTjGB57YbYKJJi/3VXx9yOKYpT+V8Q5A==
X-Received: by 2002:a05:600c:1616:b0:42f:8ac8:5e5c with SMTP id 5b1f17b1804b1-42f8ac860dcmr52410855e9.12.1728325510916;
        Mon, 07 Oct 2024 11:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYoYb/XOX1nLRmeDyanwiFN8LFrlgZDzgrpAPVciJy7/ntwqBwANWRLqG1w4mRopclm472pw==
X-Received: by 2002:a05:600c:1616:b0:42f:8ac8:5e5c with SMTP id 5b1f17b1804b1-42f8ac860dcmr52410725e9.12.1728325510487;
        Mon, 07 Oct 2024 11:25:10 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e89b42sm81887965e9.13.2024.10.07.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:25:10 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:25:08 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 7/7] ipv4: Convert __fib_validate_source() to dscp_t.
Message-ID: <8206b0a64a21a208ed94774e261a251c8d7bc251.1728302212.git.gnault@redhat.com>
References: <cover.1728302212.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728302212.git.gnault@redhat.com>

Pass a dscp_t variable to __fib_validate_source(), instead of a plain
u8, to prevent accidental setting of ECN bits in ->flowi4_tos.

Only fib_validate_source() actually calls __fib_validate_source().
Since it already has a dscp_t variable to pass as parameter, we only
need to remove the inet_dscp_to_dsfield() conversion.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/fib_frontend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index d0fbc8c8c5e6..8353518b110a 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(fib_info_nh_uses_dev);
  * called with rcu_read_lock()
  */
 static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-				 u8 tos, int oif, struct net_device *dev,
+				 dscp_t dscp, int oif, struct net_device *dev,
 				 int rpf, struct in_device *idev, u32 *itag)
 {
 	struct net *net = dev_net(dev);
@@ -357,7 +357,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	fl4.flowi4_iif = oif ? : LOOPBACK_IFINDEX;
 	fl4.daddr = src;
 	fl4.saddr = dst;
-	fl4.flowi4_tos = tos;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_tun_key.tun_id = 0;
 	fl4.flowi4_flags = 0;
@@ -448,8 +448,8 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	}
 
 full_check:
-	return __fib_validate_source(skb, src, dst, inet_dscp_to_dsfield(dscp),
-				     oif, dev, r, idev, itag);
+	return __fib_validate_source(skb, src, dst, dscp, oif, dev, r, idev,
+				     itag);
 }
 
 static inline __be32 sk_extract_addr(struct sockaddr *addr)
-- 
2.39.2


