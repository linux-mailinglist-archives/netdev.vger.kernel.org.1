Return-Path: <netdev+bounces-229072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E806BD7F0E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B04E4FA9D9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6C26056E;
	Tue, 14 Oct 2025 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSpkZNyi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62F30DD24
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427137; cv=none; b=bHX70u2uEWE8cinSuo2eVDRrik4eBQWN9aCq0luQsZGS+bZjH5YvmcDy1+w6C/aUrRRXu4T80qGA5yVNVXegiMyxv8tjJOyl5wnMp48G6VkNt2UefMAmCGyDm0E3AbRtJ30CLfeYBoS2QnGfJfzyZ/jOvenIAse4lY1PWnamNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427137; c=relaxed/simple;
	bh=BZpNB4tvJ5BwXauksNbGeKSCBxFyIHUJN7gMO7KyVM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj2DZkWMD7zkDadScqpOQsJ/XvQSu2AFMHfCxfRlgbZZDmUkoJLFpGF+qz4wFOVImiSl3uXVMZUYLdGkLaXYn143FIaiXKXNuzzdN4jqYn7z2j7xC/5KMI1xK0s5O0kZlJp2uCQMDIoH47PHuMoMPzjD1DOOl1Q9tjox4pkKpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSpkZNyi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxbjMP0kQj6ZgkvaIQ9L0w+ObeQhaUoptYHCkUDRsC4=;
	b=RSpkZNyi6tpn47oguUeOZw8/rQ6fIUa5wAGbgOggXWStCqNqPZXil+VxVM0QFBHR5rDDc/
	0ajA4MGfQqtpaXl2oQOmYMaJZYn/txIsaR/UXT1hRnTnQ7PPGz4v14g1d2E4NZiI98U917
	V1zP83blM8wvYJJHMQZUZ+oKIRbwSiM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-iu9XcR4uPVa7Qpakg6lA3A-1; Tue, 14 Oct 2025 03:32:13 -0400
X-MC-Unique: iu9XcR4uPVa7Qpakg6lA3A-1
X-Mimecast-MFC-AGG-ID: iu9XcR4uPVa7Qpakg6lA3A_1760427132
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so45917165e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427132; x=1761031932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxbjMP0kQj6ZgkvaIQ9L0w+ObeQhaUoptYHCkUDRsC4=;
        b=UidNef8dBoaQ+5UTxSW3DYPlLSeaZHeqSorcVWkgq6X3YaCRSwPWLvbX4fDgegFqOX
         Fakg3pEjTIFA/QqvKEve+OsIuQaln1Cj9/BtKh2UYKxJKRrFcjfSliSZkmXN4nV/cXsi
         nFGzE/it67Pk0eUg6aKcsntom1SupgobiZgm8c9zsJ0/6kIC0otrOI8jcqMCcLSOpKDU
         HaNbAWZrkauWmtPoCq5zt9X/sQTKpZavLa3ZVJznGfNeQJFWgcGNQnTfjoCgKAZwlsdR
         TfRN/2d0KOVz1Dm+/T4uUUwFEslmmgnWvwS5/D8jLajPNcr/arXPgiZqvDRJ6mZJnOD5
         BUBA==
X-Forwarded-Encrypted: i=1; AJvYcCVhkfEZ7YiUk5EA4Wjhgo4f8C8m/ma+AXAZrH7lBVNpjvQVDsSGh/JdQd2o5rRWR7UkA8aHE3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FpkpRYxUlOWUdh1OTFp1XVM1jHUCJx7jBLDmgUlCtzucxRvg
	IAF3z3p2qqd0zBcrrzl3oEpjyp3+r0Dq9mq//bPVbyCJk/DhHYgKJxHgW/AA+0BMPjWwkB4grB/
	K577XNTvZe0DEM9CHzRCwEvv6irKSmFvPlb5ve4gM3kJI9fGisg1vwnyyrQ==
X-Gm-Gg: ASbGncvXW3rPV/waFGdIHbqDmFmnzqThUgJqFULDN0zvvcHKTH7c/Bw+Pgfq/e6oMZr
	BllbnSe51c3g7lgde9x5mv+wcIpiPiJ5dnlLomsAs+T3BCzQJecL+58d/GO0qNwwVaULMkw1LhQ
	sygkeDpMMmzje9+i96ci9bE8Ne2KowpzWP3WHjxciK5LlCd3hAuqwasFg9sTdOJjMGWQniZqT2f
	pydykLjZnmRkT2UgVn+S1pn4btXIPG5Mx8QNxREUJs53Xh+29jfOUf/X0xrfjUGQjflEiBsdZoX
	1/e92PftEllPKBxl5HphLdgr1eR6uOjehcV9hZOoDJihq3Fj9s5Qt8ZkRbqa6BTr4d6XTgyrVR+
	s7Ga5PVDdKT5h
X-Received: by 2002:a05:600c:8718:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-46fa9b08f09mr180277775e9.28.1760427131902;
        Tue, 14 Oct 2025 00:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0t3Cblv/9MCY8KOPsu5w9SX9j8jfT8ylg1tbzh9FUB82XIxwtU32qE7AdOzkVLYuBbtZpQA==
X-Received: by 2002:a05:600c:8718:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-46fa9b08f09mr180277435e9.28.1760427131479;
        Tue, 14 Oct 2025 00:32:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm21829187f8f.35.2025.10.14.00.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:32:10 -0700 (PDT)
Message-ID: <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
Date: Tue, 14 Oct 2025 09:32:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
To: Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Michal Kubecek <mkubecek@suse.cz>
References: <20251014060454.1841122-1-edumazet@google.com>
 <aO3voj4IbAoHgDoP@krikkit>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aO3voj4IbAoHgDoP@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
>> Michal reported and bisected an issue after recent adoption
>> of skb_attempt_defer_free() in UDP.
>>
>> We had the same issue for TCP, that Sabrina fixed in commit 9b6412e6979f
>> ("tcp: drop secpath at the same time as we currently drop dst")
> 
> I'm not convinced this is the same bug. The TCP one was a "leaked"
> reference (delayed put). This looks more like a double put/missing
> hold to me (we get to the destroy path without having done the proper
> delete, which would set XFRM_STATE_DEAD).
> 
> And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> x->tunnel as we delete x").

I think Sabrina is right. If the skb carries a secpath,
UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() will be
called by skb_consume_udp().

skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cache()),
the skb will go through again skb_release_head_state(), with a double free.

I think something alike the following (completely untested) should work:
---
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..4a308fd6aa6c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
sk_buff *skb, int len)
 		sk_peek_offset_bwd(sk, len);

 	if (!skb_shared(skb)) {
-		if (unlikely(udp_skb_has_head_state(skb)))
+		if (unlikely(udp_skb_has_head_state(skb))) {
 			skb_release_head_state(skb);
+			skb->active_extensions = 0;
+		}
 		skb_attempt_defer_free(skb);
 		return;
 	}
---


