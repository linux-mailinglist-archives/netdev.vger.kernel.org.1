Return-Path: <netdev+bounces-249461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F8D19679
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6065830158D6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09275392B7F;
	Tue, 13 Jan 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YauCC3HT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="isVVI3NB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36F39282A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313674; cv=none; b=SAX1AkdLe6HdMI3m7KWs5zkQH1h/vzreYfXmNagj9WiBbk2rvyl1nFHhJp8MGdTNMC3uqcjOiuv97daw8Th2rHa3jKhUG8a5CmWFpuBHldm++ldQf01eutNEbXGbqboqxaZrQFihmf4YTzRw9E33YAwZhUjnXKGpw4YD5BHFGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313674; c=relaxed/simple;
	bh=aBVelbI/sMGAYMMEAE2Ew3E7aX9YWT4jgzkmVOrZRUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TWtohkh6AkkvkzywLKDMy8O4svdThZRur60jO3yRo9SdiiAh0CQSz3Iiskfl2bcHg+fo6qHyBmgXq/GwhDTZcUIFnwLfsATIxZsYz3a41Blk4vOH6bQK7p92uw51OK9nxEs+cEFvhuHPRt6RN4zU8Ncjszgn7axuzNtv9JUjN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YauCC3HT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=isVVI3NB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768313670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBJmtZHikDScEfDNRwxtIPloOkwf8FJUCotz3rSZm9U=;
	b=YauCC3HTmdzaKnKzIk02OMoM9Nmo8i99mJ7My4qCPp08Cqk4mKpQSVKXcS7ls5wn4bbrJ1
	w/T0r7VHSaN9LG3RE6z202YtLAQY7TZxsPOOvGGEo/WdJBanLqbSb7+XYbUhqKYQH4xWqy
	Exv15zM6jNj3LMpSu9LOy2Cbha66Igw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-1NARqoIYPlyqK4XtNtibaA-1; Tue, 13 Jan 2026 09:14:29 -0500
X-MC-Unique: 1NARqoIYPlyqK4XtNtibaA-1
X-Mimecast-MFC-AGG-ID: 1NARqoIYPlyqK4XtNtibaA_1768313668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so69793255e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768313668; x=1768918468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBJmtZHikDScEfDNRwxtIPloOkwf8FJUCotz3rSZm9U=;
        b=isVVI3NBGtBLzouvb/jTs1t1e8UrQRUtev6Lx0SiUK045mFXpwXZMO2RI06zltCrRe
         XhWphegcoYy7avE9ebpRLx35SkxoKeN2OyxJEvErAjcP8v4EwRshdwqM2IYzZBaY8Wts
         xFf1Z7FcqmzKzNLVNqFSowS5ANrB02Fo3aN5vXSAN5X6cD19DCRKW6ClQJdDtH5ghqzU
         TbDRIVVoh9hao6Utojwbuzx2b7lamunogY7HvfHyewWbjfsa3xT7z/5lZTunv/a9Y1l4
         cMhVs+kE52zmjQrpeZZA8h0nyJyD05rsPjTPNWUifIux5RJbJrXPSCi+4DQf6nNEKZLf
         qxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313668; x=1768918468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBJmtZHikDScEfDNRwxtIPloOkwf8FJUCotz3rSZm9U=;
        b=RssetaV5QBZq/eeRch8ZM5b/vxSl8gD2VtVjMXQATP8rcpaCzUGmXOKdhfqfKG6oRk
         6zpOUpDbSYs1Jktdoar9AZxNJSaYngpCDjHEbVhguolEKJNs5NcZD/MusFhPik+14SN8
         lZwkqDqdS1EHNz8t3TkyroYHxr6aFDpHU5YAGYMuKV/MHbTixFD7SHXA147pxhtpUEVU
         pIIEEV3fWWeo4nDBU3RXDSAmo+ycC0SOGjBi1EMSWS5eEjKyHu+K8tLSPM11YugJYKfP
         6PlPRu/x7U76gpIpVIYeFp33VIubhZqcAs1HmvGa36Idozm2yS6S+8tP5ueoZBuqjtMC
         4z3g==
X-Forwarded-Encrypted: i=1; AJvYcCXu6vKLejBl+iTvN5A1tBc+m7sFUNVcun/TYVUJcEIFFLVF4w/aAzdc/EXH6DDg/a+VBa6pOOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMrGRO7FRt89CkTBe4Rb7ByXtuHBhurIDm2l2Jnf+XmdpIr1C
	DhB3pLgw8OTAVkxynbrULPPNtFfHicttM7LOsPOh6J3CMmbpyO3oSfQkX1+BCa/umXcdCV3raVs
	27Ytf+9li5lFG4VQO7FZQ1Pro8rCw29ZTsnXxM2I1jCiqpFkYfD11b6s5Bg==
X-Gm-Gg: AY/fxX6WlutTFoh9SbjhlFLtEbYNDFm0ISvqe+2uu+ni5mmhzseo8yX8qULYen0xN+l
	CR2MaHVtGHLfewJ8A52j/DtybqNroFZCToMtH7S+PqgfLD9c35jT/WGj7xEA+QFraupXrCfM3XR
	ddGDMeyjdIQZ9ERIWvOsapYdEYtru3Ty9fukRpPQCqALqECW7GZw25XtA62L+AtKtoTKJb6QkE8
	BEfUD2l6q3Mjy1TnI767ASIhNmlKVQ+FIeA4RRAz8FgK/WyA2nBaXP+ZOvKzaGJPxh1FG/qz5kG
	0l1sD/Pbx5UPG/m0M/AeLah/vciaJPjriymtHgl4pCSkCPHkfUrg7aJUPtp25eVRbIl7HrvpWRg
	2xw5e1xJeGzkT
X-Received: by 2002:a05:600c:c3cd:20b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-47d8a17124bmr160381915e9.25.1768313667996;
        Tue, 13 Jan 2026 06:14:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnqXP1Utpvoan26ZK//j88cBpCAw6IzGcyvoYOK6Q6IIyxoX08lXHXm3zbOQMApf4MebttCQ==
X-Received: by 2002:a05:600c:c3cd:20b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-47d8a17124bmr160381655e9.25.1768313667579;
        Tue, 13 Jan 2026 06:14:27 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7035f2sm390629415e9.12.2026.01.13.06.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 06:14:27 -0800 (PST)
Message-ID: <3e3ef9d0-f1df-4568-a207-2a121ca76def@redhat.com>
Date: Tue, 13 Jan 2026 15:14:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org
References: <20260106095243.15105-1-maklimek97@gmail.com>
 <20260106095243.15105-2-maklimek97@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260106095243.15105-2-maklimek97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 10:52 AM, Mariusz Klimek wrote:
> @@ -177,8 +178,13 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
>   */
>  static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>  {
> -	unsigned int hdr_len = skb_transport_header(skb) -
> -			       skb_network_header(skb);
> +	unsigned int off = skb_network_offset(skb) + sizeof(struct ipv6hdr);
> +	unsigned int hdr_len = skb_network_header_len(skb);
> +
> +	/* Jumbogram HBH header is removed upon segmentation. */
> +	if (skb_protocol(skb, true) == htons(ETH_P_IPV6) &&
> +	    skb->len - off > IPV6_MAXPLEN)
> +		hdr_len -= sizeof(struct hop_jumbo_hdr);

I'm sorry for splitting the feedback in multiple replies.

I think the concern I expressed on v1:

https://lore.kernel.org/netdev/a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com/

is still not addressed here. What I fear is:

- TCP cooks a plain GSO packet just below the 64K limit.
- Such packet goes trough UDP (or gre) encapsulation, the skb->len size
(including outer network header) grows above the 64K limit.
- the above check is satisfied, but no jumbo hop option is present.

I think you could use the `ipv6_has_hopopt_jumbo()` helper to be on the
safe side.

/P


