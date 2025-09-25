Return-Path: <netdev+bounces-226417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DBBB9FF8E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768592E5F7D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB7291C1E;
	Thu, 25 Sep 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCI+F+46"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016FF2900A8
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809920; cv=none; b=rpOjyNkbyLZrXPQbzUTLptM9GA/xYg8tdhjvlKkpXKcZj1ujl7is6Nw+buG1N6lqqxuJ7ROmEvKseAhY50juVbL73/tXqS/bK1PLSna9m5Gsyj2VABXgxjurqnuVVJdM5uNTa4SsgtFt70H6R+fzI4QVe7uONTscA4ExhWC3pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809920; c=relaxed/simple;
	bh=cUOyQ/7AUjEqXxi/gjAV8MaYsxKoeiWLEhw7Pt7mXfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnkMYgSPgLEVH3a1Sd8OQ2E2cRGKhUNukq2u4lnrIqaTmwbpJ8k1nvXUc4CEwWiTcdvvdOd8g0wapgdk+90ErC9Eiw34IP0U6ErMGsVKYqjABWxruqitUj2dyw9UYIA2xAzXFx5kl/Y9Dj5yVYty02PgfaV37++IzIQYbw9Mcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCI+F+46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758809918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQxIMKGMi7wxU7fW/PKEJ2e8iHYmnS3c3/gsv1SZ2nk=;
	b=JCI+F+46mHQgmXuABHl4GxPgIBlQlI4EejPE4bigi2t91cwP7nP7a15VjJ8kYpf7D3gKf9
	Ad56CQ/i61FFHDJI29afOrlJZN5gtf3kh11gXciykJz8yPPFA/9pZxReQzsA6u5iahtSX2
	K99Q+ohPptdp41cRU+Ir18VaiJ/CgnE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-jbSibkS6NU-yAYqxVR7t1w-1; Thu, 25 Sep 2025 10:18:36 -0400
X-MC-Unique: jbSibkS6NU-yAYqxVR7t1w-1
X-Mimecast-MFC-AGG-ID: jbSibkS6NU-yAYqxVR7t1w_1758809915
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f28552927so7733175e9.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809915; x=1759414715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQxIMKGMi7wxU7fW/PKEJ2e8iHYmnS3c3/gsv1SZ2nk=;
        b=g02IqTTBErtjq3F4AeRNR0muHuKqvudpqoiDWh/vJa99mjaLv+NjL+9kSEh6+ySFwa
         6NvjfL9X64tlY0jDZPA2koESuV1RQev9aclDuI4j7Iiqc3HX+rtwc3g8PnFBG0pEgY/u
         mPu8O8bArFUSepRZSBQkqk242JezcgJ67kTU9rL437aiFbsBbP70nt+Btx5BaCNpG9Wc
         sD1iQ51qZms4zELDLJjIxR9lCvoJBwa+q5ngwPN7SwHrUXxkUPFVvZgW3Nwu34xBPvxu
         9XwRVs9j+kNXKNT9cPrg5t5FNTg5+8Y4j/YXlHVEktJ+pO5GPewEFpsDE6j1h+irajFc
         mImA==
X-Gm-Message-State: AOJu0YyfrTrpPLiA/wT0yGdnczKxByU/ibfcALZ/sln4nSzPwWJ4xO/D
	Me0x3OEArl/BfsHWmkWfnQIWDOMi1Ns7syVn+T3fAJg33/xt350yVoJd4aXojDOmRztALdbMnZN
	NYQR8lcjq2xQcyrUl6N2LMVBdmnaLutkbhqrmXxb0iuqJpWjQ9LU27EH4cVr7q/pa4w==
X-Gm-Gg: ASbGncsUMvDUMsWnHUm7CIQLAXMrj0pBZ0oe2bQ30gQXF9AT+hMpO9DbB1Oearvk3ef
	aXxyTWh+8bFnFw9zuORBQmFVS4H7b/wS8/W3NxrsHUmvyhOIxfXyWtewodF6HoLqJ90g2qTqLFh
	TiqTovpbjBlpUqEF0gmaoEcoaw0RFvo/4NLwoMHsDdh8rII66EFXMOWbH/HEzHE1c2Q6duAgilR
	cED3IOgnS6EoOPGOl9PMUVkcXr2Kv13VKTtwY6XuY8A32SaVOsab1YBkdXR/7TCuvTgPPTtKJpd
	Mxu1kn7pNw/2+XdfBOFc4ySDAYduzZu9RfcapZLJJeRcrY1KRzSbLIEOpGuxSTomjLjLpBYNYQ0
	hkAZ4n9w4uZLu
X-Received: by 2002:a05:600c:34cc:b0:46b:22b9:299a with SMTP id 5b1f17b1804b1-46e32a58ff5mr33673195e9.37.1758809915188;
        Thu, 25 Sep 2025 07:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDvs9H1o/zzGpl42kkXiRr6WXo379n8CQ/CtW4fsi3GtZDLGLZg5Idmx4EnPFZ0+QvDOE9Og==
X-Received: by 2002:a05:600c:34cc:b0:46b:22b9:299a with SMTP id 5b1f17b1804b1-46e32a58ff5mr33672925e9.37.1758809914835;
        Thu, 25 Sep 2025 07:18:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b562d8sm36106845e9.0.2025.09.25.07.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:18:34 -0700 (PDT)
Message-ID: <7be5af09-2531-4b68-89af-106f90649bee@redhat.com>
Date: Thu, 25 Sep 2025 16:18:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 15/17] udp: Set length in UDP header to 0 for big
 GSO packets
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tcpdump-workers@lists.tcpdump.org,
 Guy Harris <gharris@sonic.net>, Michael Richardson <mcr@sandelman.ca>,
 Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>,
 Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
 <20250923134742.1399800-16-maxtram95@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250923134742.1399800-16-maxtram95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index 54386e06a813..98faddb7b4bf 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -184,7 +184,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
>  
>  	uh->dest = dst_port;
>  	uh->source = src_port;
> -	uh->len = htons(skb->len);
> +	uh->len = skb->len <= GRO_LEGACY_MAX_SIZE ? htons(skb->len) : 0;

You could introduce a 'set' helper, and use it here and in patch 13/17

/P


