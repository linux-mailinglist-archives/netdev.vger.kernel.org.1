Return-Path: <netdev+bounces-241477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10BC84536
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 705414E806D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8192ED86F;
	Tue, 25 Nov 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvEM6CiO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKu2PDqu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7D2EE5FD
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064646; cv=none; b=tCRwqM9i6DnyIcQnk30rNAqCBnwd5s5JvnIUiS3kMdnqzCuLsZ6QsnucmYi3BywOQXdwYLasaZIccESX/5DWEJg0DL4hqKG7058GoLouBDh/MQg+w1EJowEdjmjIzKqZGgth6kjktVKbNPLC1Hk9K4hDVYjFcHd9RhgHN4OUn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064646; c=relaxed/simple;
	bh=cSARjEbGqlee8x2tQrGf9+P8jQcbtU/psvVjwxy83Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+x0VAsawu7JN4M/YZc/mVuC1I0ZmpVvd2Lo1dP7CgSiOE8TitXEGK5Bo3PKQr4pulM10TczAjrRY2i6Pk1/QHnXfD6PIJv8nWuZOwsotzpSsqDt4KcpV0dSgg2pDs3XA8np7tww6nuicj1KjQt9hmS7d/+XTPL/BVMr5eYeF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvEM6CiO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKu2PDqu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764064643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqZtS8nbqolLVb9mUazTvYVJJ6K4SjHbqJtrPipaFmg=;
	b=bvEM6CiOM0O8ks6ycuHHkxhB/0guSXcuMLgp2L4gp2AH3/fxvFIRGgKH0M+B034n6qnwY1
	pVTzfK4sbMNiSz2rFShLKKE6Laj8CzMAohmTUOT/wS/ts0hmYpCEwBirdMtYKv02EzQGHe
	5/IUO8f2kHfkH2cP5viPUIPUl3HDiuY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-bnC41m5KMwWMKxjzHYFrSQ-1; Tue, 25 Nov 2025 04:57:20 -0500
X-MC-Unique: bnC41m5KMwWMKxjzHYFrSQ-1
X-Mimecast-MFC-AGG-ID: bnC41m5KMwWMKxjzHYFrSQ_1764064639
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779da35d27so63795525e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764064639; x=1764669439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqZtS8nbqolLVb9mUazTvYVJJ6K4SjHbqJtrPipaFmg=;
        b=HKu2PDqujBp6WgsUsKzjX7qjykNJ1Q+ucF06G7hm5geOgncuCD7LDZ7QoAZlZ1hnjY
         KE6B8Ez8sve2hFQQgD6NuJ2ivKRn15vpecTOIJVq44Go9HCy6cFBNxBJZKj6pacaDHvl
         husQD+5+ARwN3vDHmB5L8/MQ9QM0VCUijg2IThwE7PMwACYHhXNanl/Mh7p/S5Kq4/xg
         dQJhqUbLzHXf6rw4FIHwSn8VG+SNMbIYXblmNBJPCj8VeR/OVQIieBHNqXfbU+C2uu58
         YIK2adCQsgmAyttpRzxvIdBpgXl3/MsCXDMFic79/CY6zrvSZwwEguxaQJ99+uCXO8R+
         qElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764064639; x=1764669439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqZtS8nbqolLVb9mUazTvYVJJ6K4SjHbqJtrPipaFmg=;
        b=I6sbIC/pIkH0hRfW7ftZNLzfOttrghgXv44ZJH/kTWQ11tr7sfHbAXyUl+gFMArnPv
         +YjQyB36agRIaSOtWeI+gmokW7cJFkhxYBIwHJK9bcKho2V01EuhncJ7W45dao3A6VTg
         QNKapRvb9UZINJGK2LZ8ro/+iZSYL1CYM0GDm3OLZZPAbBiFTH10uHbakvn0KxPse//f
         ETvNoyXJJzbdzF8xNX4abPg8Du9ehuDVLnTzeo6Yy3JdkYyG1/pjXsq71lh7/TKpjeAO
         8sK/zhpESAaAfHPLNrnrw/jqJyKrsfAxkfJQ/d+zfHHtzW6aF6zfgnECwNhUNi/YyitN
         jeVA==
X-Forwarded-Encrypted: i=1; AJvYcCV1lFflsQH386ZyMayKgrDHKW8oegFv8llhbMOQRPmpQfDNh14P7/2s79orjR+ZIDrln87LayM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pH16FhkbFr9OucZgpw8ciyl/76kcLKhUX+sZmAkiu62S4Di1
	qNcO5XNJ9pnv3g8ewK6h3ldo1WeDCgJ89OwLlVwbWr1SGxdp3MvuxhHcTLN/1luizyDPO7/VSVE
	vB4BtPAzk78xqkxPKz2yKTGsy+J5w7bY3+SjEcEFEO4GCXEGoKNN19cVvOg==
X-Gm-Gg: ASbGncsmiG7gwDw9xC++5PI0NEI/F26uFTLDU/7f/krEI7aEBmwx5wufxFRQE6KhENC
	WbOHpftm8DbxgvC2sk4gxc1/0XaYdxA/GIgVmsuqONlF2mQ1xUuVhwphGbnQ0WB/vHnI/IIpk0e
	ocNL/bumNo2HfI4c7KfU/jI50QbDeL901Ej16xL8QNxbuPVcssb0jZfRnu5evSnMLkTqcgi0B3o
	hUkyEpWxp4hUEfiMJZcQ0lwQTHHYW1M5IPKD0X/N8eLEGjFDhBGEKkyhLwGojUUm1ZGPfycL3Bw
	ZElGqTV0/h8uEAroHTowO0p7UBk3tT6aUndNof8HCTAvZrFp1mmy8BzSOoGoB07jxI6191fx9Nj
	qTLbAtFxtKyyWMQ==
X-Received: by 2002:a05:600c:1c27:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47904b2bfd9mr21275285e9.30.1764064638924;
        Tue, 25 Nov 2025 01:57:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWD7R+r5soYE9QlgtXSfyw7aoEGs6jZbcnbByDzn1GpB6+4CtsPY8yL+YY4tiGyDtW2iYeng==
X-Received: by 2002:a05:600c:1c27:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47904b2bfd9mr21275005e9.30.1764064638545;
        Tue, 25 Nov 2025 01:57:18 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e872esm241360935e9.5.2025.11.25.01.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 01:57:16 -0800 (PST)
Message-ID: <a601c049-0926-418b-aa54-31686eea0a78@redhat.com>
Date: Tue, 25 Nov 2025 10:57:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] l2tp: fix double dst_release() on sk_dst_cache
 race
To: Mikhail Lobanov <m.lobanov@rosa.ru>, "David S. Miller"
 <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Bauer <mail@david-bauer.net>,
 James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251114010644.452441-1-m.lobanov@rosa.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114010644.452441-1-m.lobanov@rosa.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 2:06 AM, Mikhail Lobanov wrote:
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 0710281dd95a..b379b7e6470a 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1210,9 +1210,17 @@ static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, stru
>  	skb->ignore_df = 1;
>  	skb_dst_drop(skb);
>  #if IS_ENABLED(CONFIG_IPV6)
> -	if (l2tp_sk_is_v6(tunnel->sock))
> +	if (l2tp_sk_is_v6(tunnel->sock)) {
> +		struct dst_entry *dst = __sk_dst_get(tunnel->sock);
> +
> +		if (dst) {
> +			if (dst && READ_ONCE(dst->obsolete) &&
> +			    dst->ops->check(dst,
> +			    inet6_sk(tunnel->sock)->dst_cookie) == NULL)
> +				sk_dst_reset(tunnel->sock);
> +		}

The above looks still racy, even if with a smaller race window: AFAICS
the DST could be obsoleted after this point, and later inet6_csk_xmit()
could still race udpv6_sendmsg().

Also I *think* the same race exists for ipv4.

On top of my head, the only safe solution I could think of is replacing
the inet6_csk_xmit()/ip_queue_xmit() calls in l2tp with an open coded
variants using sk_dst_check() - alike what UDP is doing.

The above would be net-next material.

/P


