Return-Path: <netdev+bounces-224117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDA6B80F13
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17B91C804E7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC32F9C29;
	Wed, 17 Sep 2025 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtQzZIzW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A612F9D8B
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125739; cv=none; b=YIprurbDfPDRqFTPfEqPrwRbz2VZmQEZ5nuLOmj7qcRLwAr1fs4vT3gTrAnBFJ6mUfY7UCvVjiOP4+bsAqJvntrOpcY7wRTKsyR5qH3WMQ2Ci9Hx9Jmxl0+UrnZ4Uc7cdEnmzfnIDKRIhwBnmVFiuNFyaqK68zoh3HB6rII641E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125739; c=relaxed/simple;
	bh=Gedi9LAKDOWbuBOXqPB2nlK7pVkncHsFy989vcqcXNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r26Ptl3HuNE5ymbAF7iJ6wzXFFTAxdHw34uz1NOqkv0DEZo1fdJ5kSHpGpUvwZBQB4PwQ5p0hmRhq5MPF8S6wbvLI/O2Q09dYVFfOjEpXyr+eSDXEab8tbsxP7NId0PAJBUsXeK7u0uZ8E4+CGqlijAQACqcwYN/ISJHEyq2aQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtQzZIzW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758125736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSRX3yc+Xp5djNhCR74CTnUWYES7IBXhDxEMlBqc26E=;
	b=HtQzZIzWeBvq35UjWjR/c+Bw38nGcb1UdR/dtrv/oB/mFza4ytQpUaVdJELaNQAEZU9jBm
	0f5cyYJPMPdlUY9Se5/IOZh7Ff04qtXzdsg4WIXE0lEqq468sabqqo6IxbuH9lomA6hp7a
	WctpJBHyUXA8k0RsDpqYTM4qK8+szx4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-jKX2mVTRP3-EQtY2CptgZg-1; Wed, 17 Sep 2025 12:15:35 -0400
X-MC-Unique: jKX2mVTRP3-EQtY2CptgZg-1
X-Mimecast-MFC-AGG-ID: jKX2mVTRP3-EQtY2CptgZg_1758125734
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eae869cb3fso1407088f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125734; x=1758730534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSRX3yc+Xp5djNhCR74CTnUWYES7IBXhDxEMlBqc26E=;
        b=Gl0hfGeYRsFRCOzHJsKXI9Y7UajFFmmh7x0Z/DkDNNsxvBK4thyXUYAY9PyD4oIKMS
         chimwjIXmNAVaXFRFgQ9rfAuzMEsBROp4+8iPuzuhZ/60RCAjS18DVIAgBKbdPeUM4o+
         wCBrmfm/uQHiYyAsJ5vgq/U/Yq0fhx8MTuBj+CYbE3ZijDN9v7mVwyXJtUEmactQtqDG
         UsLzSP80vBBHcyqFyS4KqoTjchMUqnyn3BP2+AzIjBrx6etmcLbUyLZ8kXier7meWw7t
         cOZCumo+oQT7r5lcfqjYrqj9blZZpZRE/94aUSGK10z28bUlH/Lze1mjQKY8HrHj9mbF
         Fluw==
X-Forwarded-Encrypted: i=1; AJvYcCUX4a37LuboyJt4bYaQkKwDltVSbBZGOYrAwfllvL8ODHhi5HYa7AgGnTlgGTmNXjYkF5+Eysk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iRnSwmTBkJ4IZ1U1DdtAN1IW17pREnKcA7YbMyONcK/zdVeu
	A/D4kAAqA+4PW17vvSSea/jT9omvoGs3eZ6hQ6lB7LozvR+kDkfUPO/ln41fguSxVOrAJZ6a7YA
	vcGcqclvz5xdZ5+mUnxy7GW2+1p4ilvB8DzP2M2xlgue4aCQIQ1rR3onqSQ==
X-Gm-Gg: ASbGncu20RH/pp8o5qq7PHthlgvw7ItQ0lZHEQptETXZYg7jpDM6uamyf59VsuAxJMI
	zTR8ChNIhq6RkQELL1CptteQ4VVYrpEB85AgOIm041b1Y852RqEuhyXq5mX38mTdlEgqUPfvz5L
	cNLV08LsIfoy9FOby1xalYABuyhvmLhix3JFwE6q6gHqdsOKWFRKwZR9AH9tzIxB3RZr/Yus+2X
	flPOaIou7gi0fUG3jGa02iM0wphIvi8VgPmOLZMOU5S0Res/1PP2n7Dg5rY04sohjM22oscgUAo
	pAcsUULiPyHw0u3VOwwL2oYmljs8Rboiq5OmqoCrhW0rnIb9KxdWhDOV5sjerKKoelVsMkZmnn6
	B7mSrUApCOGgq
X-Received: by 2002:a05:6000:1a8a:b0:3ea:6680:8f99 with SMTP id ffacd0b85a97d-3ecdf9b175cmr2013055f8f.9.1758125733875;
        Wed, 17 Sep 2025 09:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9bqLg7aixT3JkKFGEYjeA1dyCc/Qod9OrsH/I1cApgdE7ULxdblon790BOHYmpytEL58PXg==
X-Received: by 2002:a05:6000:1a8a:b0:3ea:6680:8f99 with SMTP id ffacd0b85a97d-3ecdf9b175cmr2013014f8f.9.1758125733319;
        Wed, 17 Sep 2025 09:15:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm26661835f8f.37.2025.09.17.09.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:15:32 -0700 (PDT)
Message-ID: <513d3647-55a8-45ed-8c61-b7bf61eec9f4@redhat.com>
Date: Wed, 17 Sep 2025 18:15:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] udp: use skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-11-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250916160951.541279-11-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/25 6:09 PM, Eric Dumazet wrote:
> Move skb freeing from udp recvmsg() path to the cpu
> which allocated/received it, as TCP did in linux-5.17.
> 
> This increases max thoughput by 20% to 30%, depending
> on number of BH producers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 7d1444821ee51a19cd5fd0dd5b8d096104c9283c..0c40426628eb2306b609881341a51307c4993871 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1825,6 +1825,13 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
>  	if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset)))
>  		sk_peek_offset_bwd(sk, len);
>  
> +	if (!skb_shared(skb)) {
> +		if (unlikely(udp_skb_has_head_state(skb)))
> +			skb_release_head_state(skb);
> +		skb_attempt_defer_free(skb);
> +		return;
> +	}
> +
>  	if (!skb_unref(skb))
>  		return;

What about consolidating the release path with something alternative
like the following, does the skb_unref()/additional smp_rmb() affects
performances badly?

Thanks,

Paolo
---
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cc3ce0f762ec..ed2e370ad4de 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1836,7 +1836,7 @@ void skb_consume_udp(struct sock *sk, struct
sk_buff *skb, int len)
 	 */
 	if (unlikely(udp_skb_has_head_state(skb)))
 		skb_release_head_state(skb);
-	__consume_stateless_skb(skb);
+	skb_attempt_defer_free(skb);
 }
 EXPORT_IPV6_MOD_GPL(skb_consume_udp);



