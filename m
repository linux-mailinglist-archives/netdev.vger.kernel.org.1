Return-Path: <netdev+bounces-253963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X31mDjD8eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:56:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB898AD9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D753015465
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38388315D3B;
	Tue, 27 Jan 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2ztZtMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420A25CC74
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536557; cv=none; b=D6BWlnExZ0fuLIAhhmnc3hj3ZzuYme4B4amgHVf3MQT/LtCPhWdNe7pEjAGqcHfORycTBW1bXcIRdyo3o6FIH+qZaCQz15gXB8fwyDD7iAO74nDFYlIf4buArJHvuSX6eeJUCzr7C5M05LZzuIImiYayYvEjvjzLY5QETqKHGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536557; c=relaxed/simple;
	bh=cP+OGD9Gn9U/NQ+AprPLH+WCYSqd5uNqFtviPLQ3STE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HJxJ7Su69j6sPkEtJlf3wQeXTHPAXe0NVziCpwunOz4WPU7ii5yL0Bu8BeOGncimByrgeyMmpJZDKKnmiOyVIe4eT15LrltH+Cfe5Ukh/UXlnus2EhXxJBLlESiWUkfBW9sQBqKtX2VM11ekaVYPuAym+iZo3tqfqV8cmunFI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2ztZtMy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so68269375e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536554; x=1770141354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hthcVHV/k0u57vyFoX+P0YGVxTjphzbI21IfTtl3ntg=;
        b=d2ztZtMyuHtwae9rDJAfRczmlXH2cg6dEZUAP2dHGj4h8cYouQ+gWwCi9nnKWJ8gD4
         r2l0jswVhQ3RW82SGK4AqrjvPrm5JAgUEIkv9/Qxc52OFCy/2sBfp3rbzhCUZPFitkIC
         OTjF3h7q/ioUm+1683M70NajI+Uw55tHveN7ddwd/wahwFyzqlDVd2LE+3YAd4hquQig
         hmQCpeh5b+/tXK583YweXNywBLHmcqKMPTYPju9AJK1k4f3cYsKFR2UcuKwo54mkafT5
         0HTxWCw60XilwjYPQzXBzOdI673tg0rsvEuC+JnXOK/75hJV5EuuXFMuHaRXNqzqeMKs
         YhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536554; x=1770141354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hthcVHV/k0u57vyFoX+P0YGVxTjphzbI21IfTtl3ntg=;
        b=Q4vdn4ogKOF11UcD6aHiqBVh7GRKOfNI8mcb8OR8HqdO0R9+KUcjh7ciSRjGOgtwSG
         cjJVVHJ0gIR/49oQa5ETQvkSTW9rVbcuuC72SjfSCHtFHolqKzcg1fMNlAW8nJXc2JO3
         lCDJKTenUZBX5zbtRfgiAxjS1yMqsVd0+oD31mi/YQ/IimcPEAvDMfqgarmecmqyGvxG
         0DnPVyXqz53oulDzFqKALv4NtDe5UpR/PXzfVbYKHw2pCT7/2Y7TGqZhYigJcgoFHXJd
         suXqUS75pWwhcGJL+QzHHrJ/asthTj4EyGxV+DlyABlZnCK//mW8q+UM2jZn2z511UXW
         fhqw==
X-Forwarded-Encrypted: i=1; AJvYcCVPb6ajtv1oUmmvDNFC5iScI3BOS1xvLmF2eMmvVp9R2l9CRi1g9X/AiPMMGyPQntBLeoYC+II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9whcJbYe6cP9ANdcm631ZLgzw6Aey5jD65bs2MW903WyRhY+
	UNlRrK6h4lgTX+3B2K8tbSWwni8x1zQNygfwwYKaaTYYAlmEJ7FmYT9Fk2iRCyxH
X-Gm-Gg: AZuq6aJMm3RBaxylahihp1qK/ngJdKvcHFw6MRlv8L6wbwJPm76jTyrnYDNP3aq9Htb
	v6fXFRYM3ngfWUGzxgSHdzbJvyEnlWL16R16C40CT0YtX1gfJai3QjJapKrV2akhejvGXQCqYL1
	IjccxNakpW09lwdgagVdIn+fdT8VODrcwXnbam6T1BOZ5Lp7AY+V71NTnYnmRO4XQYa3CIw61Lx
	Of3jGd17NzDnFhIZx2gXDXcjTlZ3B4evo+ePo6gDFnbqnnRhPuu53IzfYrHy085aUcUGN5xja2M
	rLNRmMHUc5RTq2IqWU0yiKWRr2kg0iGcuUgyaru8jnJyfI/Vw8scLE9hMYAbKU2bMVczdEjIIFq
	OW2yDXpJBR879sGj9wj3nWcKau2pJeIPocCdyYnwqGcB3wvDjN2rAyGYf+n0PPGv+qAgI3rtHH7
	mr3fekctC6NkCAMA0tnt1YFCWCofIfgi96uDJ3U0fdqij46JYrED0T6egE9OUuoiKVJQ==
X-Received: by 2002:a05:600c:4e15:b0:47e:e414:b915 with SMTP id 5b1f17b1804b1-48069c0fdf3mr36029985e9.2.1769536553920;
        Tue, 27 Jan 2026 09:55:53 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7800:6d36:b552:d917? ([2a02:a03f:a75e:9a00:7800:6d36:b552:d917])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm397886f8f.34.2026.01.27.09.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 09:55:53 -0800 (PST)
Message-ID: <4196ef50-2ea0-4067-8d92-bc797ed7aec6@gmail.com>
Date: Tue, 27 Jan 2026 18:55:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/7] ipv6: Set HBH and DestOpt limits to 2
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-5-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260126194826.236075-5-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253963-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email]
X-Rspamd-Queue-Id: 85FB898AD9
X-Rspamd-Action: no action

On 1/26/26 20:48, Tom Herbert wrote:
> Set the default limits of non-padding Hop-by-Hop and Destination
> options to 2. This means that if a packet contains more then two
> non-padding options then it will be dropped. The previous limit
> was 8, but that was too liberal considering that the stack only
> support two Destination Options and the most Hop-by-Hop options
> likely to ever be in the same packet are IOAM and JUMBO. The limit
> can be increased via sysctl for private use and experimenation.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   include/net/ipv6.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index c7f597da01cd..31d270c8c2e4 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -86,9 +86,12 @@ struct ip_tunnel_info;
>    * silently discarded.
>    */
>   
> -/* Default limits for Hop-by-Hop and Destination options */
> -#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
> -#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
> +/* Default limits for Hop-by-Hop and Destination non-padding options. The
> + * default value for both is 2. This sets a limit at two non-padding options
> + * (see sysctl documention)

Reported by AI:
s/documention/documentation

I guess there's no need to respin only for that?

> + */
> +#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 2
> +#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 2
>   #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
>   #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
>   

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

