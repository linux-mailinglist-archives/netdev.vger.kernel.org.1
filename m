Return-Path: <netdev+bounces-214929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631EFB2BF46
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B033562725A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5B322C9C;
	Tue, 19 Aug 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/+fc3IO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190B32274B
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600410; cv=none; b=JzvSdNEIamG9LyE+kfXlgSEQnnmBbobK9QR9q1a41K9eytIqNmtGJ+4iXuo2C+ilh1qrIPVKPmlFFytc9yQo9+9OLj9tcH7Tq678QHX1aqvx6wrPqN0Xvq42KJpeCJkYrsFrEGSwLLfvTrK8s5I5hCtr2uTBEGbBh3V6F/WUAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600410; c=relaxed/simple;
	bh=elzb019ruRrmP1i7xp2LaZA5rb6ro318sxT9KCWpKGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJI8s8XBgQ1T528d7QKQ3+28PNr+Rby33YPtJeQ7iGN2CfVVHGwVR2eUkXbwjSbFnLkKcFV26ybmXKoVJ2/gdDyahY7an0DsHvUN2A7VYu2r4me3k2cFBZeaoO3aJF4Uh2OKOw6oCLB1Y0nkkw9p+AAz7iMaSNwHZycLzVU5Jrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/+fc3IO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Th1VUQFqFIwlrfXv9YrDsFKWFzJEQXeRnE2P8wNg8gc=;
	b=i/+fc3IOvJvOGxnyoWAN6QAkek3Th9WX//sm4b1FCwwRCXvRbeaG8F80GBYUVjO/JP3uXQ
	MvqwreU7WrW972gN1/rD2Zuz4BkGLhp7oRDVJ8s+4trdE5k6C3bwWHSKJAP9INKiM7A0GM
	wphJxi55BWd/LrfGTcCtN+MU4Zix6xc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-FdISCCCbOWW_AJNkfzm-XA-1; Tue, 19 Aug 2025 06:46:46 -0400
X-MC-Unique: FdISCCCbOWW_AJNkfzm-XA-1
X-Mimecast-MFC-AGG-ID: FdISCCCbOWW_AJNkfzm-XA_1755600405
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109919a51so241772461cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600405; x=1756205205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th1VUQFqFIwlrfXv9YrDsFKWFzJEQXeRnE2P8wNg8gc=;
        b=aRNIEh+I+UpFMQXjbakP3cHbKgBCI8tH5G/Hv/SlPqFNxwHkKCi6fvmluP7WihUkTa
         9iaSnMeTZD4LRsfld8UZBwUU1SqY/bD0Wp120mKQfCYZPuEtbwxqhZMn9KdxnqgaWMoe
         +YkWpjNqpCmq2kK7x+WYZKxbVNt6ItBHJSrhuWOYeiB7lx2wT3Arls/UZbWhV34kLx/E
         wQmWc8/wVKHtb10Zyz7y7UTn8n1Kj3rxTwrfl78On4MGA5qeqZ70gpyiAYNkdRfmgUK9
         zuZhSbS0Vg0C7Fd99xJRsBHyFRLjUK6LUhiqh8jA9pX8bGVM8+6nxu0QjdP3n5+zUhnR
         lHDA==
X-Forwarded-Encrypted: i=1; AJvYcCVMVlLJWYl+K+R61sYlGXiO/VJksbo02KbMjJlGLBPlsh77pBJorzLZLbltx2rbhwVUB2KpQus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JI9v7KZZ47uuA7TyItu4Y8xzatIIMmwNrEyYeJZ+KSchyt6x
	Y6rGj2X2BeRzT74lOaFhkEzcE2sC5PBDCBRIUAItcR5u81MmtJ+66eNG9Jba9sYCwQpf5Nbr30V
	JWUU5VzM4u/lkndm8dGTphoNnaomzINsir9oVi/UpTDyQZsPbyrLCR+o+6g==
X-Gm-Gg: ASbGnctiL5s2QNOLc2LuNkDfoHYWsLIZej06qLvZ2okogIL1r0QtQBzTg9xCw0eE7E3
	kyTgO4CX4JJEvQ2syqP49El8Lykn6RwWojejQhYuDg4mTsf4v+95GruM51g4fAYqytfy7Z0B19c
	Y7+8MV9xJJrkrN7O+AUjXcm5tjq79sVM7NkcYcxkoCq6kv1NwxS7iKKXGKvfYL4UpXF1otss5xP
	pHQIrPcnQGeAeDZ6osLZ1tmaH0QhOGVQRLA/nu7/b+ENi/EOesOifOZNrtPLU2Q/GzsFh3bdbrk
	5QDZ/yrTsEbZ0OMqrtj0T2AI2ZnYVL8AQR5H2//ERM5lbjogVZQGAbnkJq2jfjbMBYVIcIYFvxs
	RbAxqEExVz7I=
X-Received: by 2002:a05:622a:58c5:b0:4b2:8ac5:27c1 with SMTP id d75a77b69052e-4b28ac52b62mr9951701cf.76.1755600405462;
        Tue, 19 Aug 2025 03:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBGEnlxs91a9yyAnL3D89TaSlDVI6ydBPLWp7ZWZ3NjDDIfFDapFaGpqUR7/kmISiVmBGcFA==
X-Received: by 2002:a05:622a:58c5:b0:4b2:8ac5:27c1 with SMTP id d75a77b69052e-4b28ac52b62mr9951421cf.76.1755600405090;
        Tue, 19 Aug 2025 03:46:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5c353sm66603271cf.15.2025.08.19.03.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:46:44 -0700 (PDT)
Message-ID: <3bb31f61-08cd-4680-a16d-20c248e3e1c9@redhat.com>
Date: Tue, 19 Aug 2025 12:46:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: ipv4: allow directed broadcast
 routes to use dst hint
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814140309.3742-1-oscmaes92@gmail.com>
 <20250814140309.3742-2-oscmaes92@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250814140309.3742-2-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 4:03 PM, Oscar Maes wrote:
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index fc323994b1fa..57bf6e23b342 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -587,9 +587,13 @@ static void ip_sublist_rcv_finish(struct list_head *head)
>  }
>  
>  static struct sk_buff *ip_extract_route_hint(const struct net *net,
> -					     struct sk_buff *skb, int rt_type)
> +					     struct sk_buff *skb)
>  {
> -	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
> +	const struct iphdr *iph = ip_hdr(skb);
> +
> +	if (fib4_has_custom_rules(net) ||
> +	    ipv4_is_lbcast(iph->daddr) ||
> +	    (iph->daddr == 0 && iph->saddr == 0) ||

ipv4_is_zeronet(iph->daddr) is preferred for the daddr check, and it's
not clear why the new check for the saddr is needed here.

/P


