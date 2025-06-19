Return-Path: <netdev+bounces-199437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5AAE048A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D67C18948F5
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3F22E3FA;
	Thu, 19 Jun 2025 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OH7wpP59"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6022DFBE
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334194; cv=none; b=fjfVPj4CeGDnY2cE0trtelpwyCnGenSsqR3ZLjoBTeTu1wfNvrmQ1jbxLyX/Wz32IXTMXVCkW9uIfwbcK5jqHrNyCUW4RUvoSp6rIUeTGpuXZy+PvLxmPafFUXoLoO6/M8bB7jZUftjAwaOCBf3kIbBGS7KCWhxSvz6h7eTMtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334194; c=relaxed/simple;
	bh=jTJuWKckd2yI8susTjgnUhd7jdQseY7iiqPvUy80tU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9kfdJQAj0113IgvUHdElgjtyWoZaGfwFf6i4o0rGEh7LlVeCwpmIfwU3ncq0aVB/1VXJ886JMLbwxSHahjZ2ldIDhzS75STD0V4EatX21RPE9PW5afu8mybCk0EyQGn+6aD+WU11Ovx9hBE7KrkmyWdc5NP1rYqG46hKdYE1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OH7wpP59; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750334192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8mIzhMGMDe77XLZvFXAXks/P+U4hv8mJk6umZWCAwc=;
	b=OH7wpP59CI0H+pPxAtHc8t2Ri2JM5uto8fkh0bVq3AZgJtmGkBEKG3jNp4Cc3/bYs7uB23
	oD49AhFjTG1TqAQHPKDVFiDUkIZMA+aT1bABm4pA8RH0U8SbzkathPGAVvJ0V3lXPLuLat
	h4F5ykFw4Psv33bZHHT5GcN7y3UFl8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-i82EnarBM5G7wUZkf6MC5Q-1; Thu, 19 Jun 2025 07:56:31 -0400
X-MC-Unique: i82EnarBM5G7wUZkf6MC5Q-1
X-Mimecast-MFC-AGG-ID: i82EnarBM5G7wUZkf6MC5Q_1750334190
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so417902f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750334190; x=1750938990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8mIzhMGMDe77XLZvFXAXks/P+U4hv8mJk6umZWCAwc=;
        b=I1RmvZvV/3adgpc/UrUfkubQP10Z1Gk0g7U9YGUQf0fRdURPVVaGnuZj09uHrjeVK7
         CId7d6YP1jCqAJJr6rsgCwJCQNeasmwUpvoA+CEfBpTadejG6pyZHcRDoZPQ0+zZYE/S
         +Sd0uVjHudNk/f0t4y4UIpvQWem6eBPShl3y2JrfoGYZxUJ8L80Pv9MOV9duPlWxhnTZ
         D0/GO7oyZf117pJdrOJdlWY4i9vXE8OTOohfzdSC+4JGlfjCDGH7Rekm1isZlQIE8aJp
         /e1VW6/XD14ZUGgfbIq5YhEXzEmqfHhB7Kl3oGP8SYRYYANnADkCouNh0C7NpOtS0J2m
         XkLg==
X-Forwarded-Encrypted: i=1; AJvYcCXzwGGtBNEcX7Rkq8TLgoaNnu2QuclGSTYfM9lcJ96rTQR6x9kK8ZEqE5Wt3L+fmRQbzM6Xvno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX95NeVm7aY2FttddKlCefj9EMFkBmqrjBFYWdL/ubmqvzf28j
	Um1Mvn3l67W7O3egBo/FKHdEBiFwtFelRnrOTY2OD9QmB5Oixjh0nHV2dU+9cA+SO8fbWC5qgpF
	D4XAMZNMX7BcTTqf3FbdtA63+IMhCOsQ7MonNinJYC+R2OlIeNCW2Xd5MBg==
X-Gm-Gg: ASbGnct9TebCDJ7S96G4Bah6r92SSlK/QU7msKu6GQ3rpiJwfUjMnOHj8e200Csw9Jd
	8YnMWHoUBW2I4pmunfN5yooWqQWblkUGt+M78gYQXJ80q8NdsOjFJx8Tn8TPakLFWuC9glakowl
	OxsrjWzbgAQ/FjjLmzSpibK9CFlSDtMpIX1hC4777sgMROBQnww4/yHa0eZ4xhR3Yvn6tz5nds/
	XdD6b61eNxOIG09tCQ8IbpUQrdYysmN4ZJNjY9Pz4Ohr5+Cy7dWO7W2YEgihv7rQVgILFEaU+Ao
	RFUxw+DDFYthIBPAnPa0Gg1MZVE4hNcL0TKDX9wEp1ntJzju8ItnVx8heH6sTDvgut5aqw==
X-Received: by 2002:a5d:6f01:0:b0:3a4:d8f8:fba7 with SMTP id ffacd0b85a97d-3a572367c78mr19609353f8f.2.1750334189755;
        Thu, 19 Jun 2025 04:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9v+jXI8maGPtme70yoJ7bdxe9MDrEI3ZBPJb7uR4Npt8AHvJ67gluOlQedLFnAXZ+0ZjjbQ==
X-Received: by 2002:a5d:6f01:0:b0:3a4:d8f8:fba7 with SMTP id ffacd0b85a97d-3a572367c78mr19609326f8f.2.1750334189375;
        Thu, 19 Jun 2025 04:56:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089b5sm19097561f8f.48.2025.06.19.04.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:56:27 -0700 (PDT)
Message-ID: <7f2ac806-d033-44de-9241-e5a3194dd729@redhat.com>
Date: Thu, 19 Jun 2025 13:56:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 02/15] ipv6: mcast: Replace locking comments
 with lockdep annotations.
To: Kuniyuki Iwashima <kuni1840@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org
References: <20250616233417.1153427-1-kuni1840@gmail.com>
 <20250616233417.1153427-3-kuni1840@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250616233417.1153427-3-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 1:28 AM, Kuniyuki Iwashima wrote:
> @@ -2072,10 +2086,7 @@ static void mld_send_report(struct inet6_dev *idev, struct ifmcaddr6 *pmc)
>  		mld_sendpack(skb);
>  }
>  
> -/*
> - * remove zero-count source records from a source filter list
> - * called with mc_lock
> - */
> +/* remove zero-count source records from a source filter list */
>  static void mld_clear_zeros(struct ip6_sf_list __rcu **ppsf, struct inet6_dev *idev)
>  {
>  	struct ip6_sf_list *psf_prev, *psf_next, *psf;
> @@ -2099,7 +2110,6 @@ static void mld_clear_zeros(struct ip6_sf_list __rcu **ppsf, struct inet6_dev *i
>  	}
>  }
>  
> -/* called with mc_lock */
>  static void mld_send_cr(struct inet6_dev *idev)
>  {
>  	struct ifmcaddr6 *pmc, *pmc_prev, *pmc_next;

Why are you not adding the annotation in the above 2 places? AFAICS
mld_send_cr() is called only by mld_ifc_work(), after acquiring the
relevant lock, and mld_clear_zeros() is only called by mld_send_cr(),
still under the same lock.

/P


