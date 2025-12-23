Return-Path: <netdev+bounces-245861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D163DCD9694
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 972CF3014597
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D771CDFCA;
	Tue, 23 Dec 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI1zT9mh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyBCvUZJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650001A9F8C
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766495772; cv=none; b=e+zW4hNN61KlER2L2k2H15AEaKUAJNtl2RenssHXdkSXNhXLgp+n/T+cXBl7vc5D7vlK3GhVBSoPYiDfEqNmGgizvkg0ZMwbzhxRryM0c9xGxAeLm4TzLkqFa3NJiPh/JgLWFg/0dfc7bJOH/jsVCGw3MP3h4pGxU8+TvrHGNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766495772; c=relaxed/simple;
	bh=WqBQ/hpNjZN9Cxv1HaJmF+GqXlLZwRqHc1QOTIoDszc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1JEh8eiUeb0G2o5sRzHeakQUX3NvGwM86nsdH5irl2eNIH9h2PjkeJfuCdyTERZN+/pjxfKBERvzmVqE2aj0ThZjLN2Mslg801t482jtQFfsHxSjQJcnXcklybPkvlGrgbyLMwaxN5xMWrSYWxdsV39zwS+NNQXAjoh9aJN20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI1zT9mh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyBCvUZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766495769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y97rc5GcE3Yd5eT+dtSrmA8PUrYxFCSHrbekggpdJo4=;
	b=hI1zT9mhXIwFdpCYOCF3c5Swlxiscv9PIB7Ymsd7gH3TTeGSTG1d22oli8ZBgN/hUGqKBx
	viC0V47nb654aG3QjIgH6/KvHzJc2mGEIvXbLJy0b2CjgdFI+uuJLGtvcl5T2r0KSZfpDM
	mTpRTLZJGT9Q7g3s3llRnsGcxchuGYc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-2DvWN2EmNTGFJ0Uq9I9QUw-1; Tue, 23 Dec 2025 08:16:08 -0500
X-MC-Unique: 2DvWN2EmNTGFJ0Uq9I9QUw-1
X-Mimecast-MFC-AGG-ID: 2DvWN2EmNTGFJ0Uq9I9QUw_1766495767
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7a29e6f9a0so564004966b.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 05:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766495767; x=1767100567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y97rc5GcE3Yd5eT+dtSrmA8PUrYxFCSHrbekggpdJo4=;
        b=IyBCvUZJ4ajE4pYd8jYielaolm/3IyWgTQuMdMHZFiOt8IFH1TPESnDF4iuVlVrPb2
         6bdjv1WI5F3wpqM5xltwuKMrYp50iFBj+pWfxRj45PECLU9aNsUeTIbpjEvm9kLHPSQl
         AceQqeDna2mlJjEt9ZqMka5pTt0GiLKzEqt+QBCjKYXgApgK0gneY8TcmYBJeqwbX9ML
         Av+DzqTuEnjlaDsXfVew0RxuRekBghjBzp6bS3bRcccRW+v5u3grPoCVWWS780LyY7w4
         YljyiR5ZOgWpPXPflqQ/yuIRDKlNO+5lEAFSOhNWulQevKX/JGD98ASpt2z1aHQ0FkD4
         MBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766495767; x=1767100567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y97rc5GcE3Yd5eT+dtSrmA8PUrYxFCSHrbekggpdJo4=;
        b=QgDPkYaoFU/v9yrF1GE6qymkkHfugFCWtPnrPYMiIrRFRGAAzqEaDuw4iKJToBrs6B
         Nt9BdzZnj0kv0AimsbG8eIcML4i3SpCpFlhTEbaXU0HF6czEhQBTQTPKvz50Cz0Mulr3
         tj9MlSjdydXrWi2u6ysxsrHnvVIhU5HObTvC3ibVEgRaQ+w0yeNwmSNLykwle0QVSHNQ
         sBZ9alVt/aR3rHsa3u3QFL49A0Vl5hxyxmK07xIMI/7zVqj/moqMSjRra8osF3XivCGL
         lzM5nc3tz1QlqolMBjuxiU9g6OFVgLZBYVrg3FNlFxrkqKXUYhehaJQTxdSj9DMpVd5p
         lo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRpUj+m8VcMQ6P2qc0CeVQUqSUScIxEPxbCb61LzjCp2eDvipKgbJiAj/Xm6IQdDX+4excgk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4X50C1UTD87YGFHtrvK6LiaG/p/ziHDSb00P+hVsC42AxzrTX
	OAfVhZnePx12zJ0IZop2K4EctU73eAO7y9oqZBVu1TI55fI0TOrOBa4dbseUhWiu5X9WNwpCjQ4
	tEBqznhc1HzTdrJJUinnbMWVPHOcyADiW7nsYNd/+VedojG5bYqKjgpDXuw==
X-Gm-Gg: AY/fxX7yQ7z8lP/I9RRaTGZRaSdnD8BdaFyGuxg5j8pOlJQnIKaeg3C6loAKutMIjkA
	W7UPq0fTxAGP8vKXqJ5ZO2+3GyA3Mb9jlGPy5Ho3KFif2YjlT8vH3ACFgY9IjUnno8hi6YHBd9p
	JCxSruWJ4FZbFDJkCcGftouUYQFysMDioZBRhTBcVxVzAQe3ytqozU+6u7CT0m9ba/dRPs8s7GQ
	GvoURLUB2Ewzn60z94d77BN5pnY7jkf0KvF06zphSe7hVmD3orwIqJamyh1Q2W82P+nNPRWlCz+
	8CbfpfwYBgKzRJnWiV0hPklX2+Vs2VhlNHvCj2fFy13HXEVB9rSmN6rDoAsEjS1TIV1fjXRN47M
	2j2nkupwaHTRNnw==
X-Received: by 2002:a17:907:97d6:b0:b73:70db:49ab with SMTP id a640c23a62f3a-b803719f96emr1420033966b.35.1766495766675;
        Tue, 23 Dec 2025 05:16:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjxAAVvYrg5+y4kU7bqUbucP8T0bUOR5ViNdKkpg22IJis92cWk3F0dDEC5WBtVcJs+vFO1A==
X-Received: by 2002:a17:907:97d6:b0:b73:70db:49ab with SMTP id a640c23a62f3a-b803719f96emr1420029366b.35.1766495766138;
        Tue, 23 Dec 2025 05:16:06 -0800 (PST)
Received: from sgarzare-redhat ([193.207.125.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8045a086fasm1219177166b.70.2025.12.23.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:16:05 -0800 (PST)
Date: Tue, 23 Dec 2025 14:15:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
Message-ID: <aUqI_qW3SZ-WBXk3@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
 <aUptJ2ECAPbLEZNp@sgarzare-redhat>
 <ff469a0f-091b-4260-8a54-e620024e0ec9@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ff469a0f-091b-4260-8a54-e620024e0ec9@rbox.co>

On Tue, Dec 23, 2025 at 12:09:51PM +0100, Michal Luczaj wrote:
>On 12/23/25 11:26, Stefano Garzarella wrote:
>> On Tue, Dec 23, 2025 at 10:15:28AM +0100, Michal Luczaj wrote:
>...
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index adcba1b7bf74..c093db8fec2d 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>>> 		} else {
>>> 			newsock->state = SS_CONNECTED;
>>> 			sock_graft(connected, newsock);
>>> +			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>>
>> I was a bit confused about next lines calling set_bit on
>> `connected->sk_socket->flags`, but after `sock_graft(connected,
>> newsock)` they are equivalent.
>>
>> So, maybe I would move the new line before the sock_graft() call or use
>> `connected->sk_socket->flags` if you want to keep it after it.
>...
>>> 			if (vsock_msgzerocopy_allow(vconnected->transport))
>>> 				set_bit(SOCK_SUPPORT_ZC,
>>> 					&connected->sk_socket->flags);
>
>Hmm, isn't using both `connected->sk_socket->flags` and `newsock->flags` a
>bit confusing?

Yep, for that reason I suggested to use `connected->sk_socket->flags`.

>`connected->sk_socket->flags` feels unnecessary long to me.
>So how about a not-so-minimal-patch to have
>
>	newsock->state = SS_CONNECTED;
>	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>	if (vsock_msgzerocopy_allow(vconnected->transport))
>		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
>	sock_graft(connected, newsock);

No, please, this is a fix, so let's touch less as possible.

As I mentioned before, we have 2 options IMO:
1. use `set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);` but move it
    before `sock_graft()`
2. use `connected->sk_socket->flags` and set it after `sock_graft()` if
    we want to be a bit more consistent

I'd go with option 2, because I like to be consistent and it's less
confusing IMHO, but I'm fine also with option 1.

Thanks,
Stefano


