Return-Path: <netdev+bounces-232570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD5C06AD0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 443FE507C23
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438D1FF7C7;
	Fri, 24 Oct 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJTzsgoQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3E1F462C
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315644; cv=none; b=Qgz36k4L9iYnpbiPgYfCX0FO8FjDQq3glEx3g8aC3SnPZIq1cqvbAjKuMIGIWd/UEU4UH9YFNW1mhI8zh26LrjnTbVtIYQhgOc15GmdnihaFqhGi3+FORmjLCINtnHBv8gmUTZX2xZkW8MpQVJNo4cNc5ObsoVqety5QjXUT1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315644; c=relaxed/simple;
	bh=7bNrS0idSyoOK5HTHFIzxp/9RrnqV0K6hYOGVJ2o9c8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PZy5q84AIAd4zgwtS+s/kyzsF5t3TJ+gsN6qq1ErNEhSjJ10Cc/cCorOQV1XQe7CTGj755uKQ8rhRSC20ZrpflCNTgrXk7MmqCwOKubs8w8lS3TP/JrAuI/hVSKD/Efi2zDarQD5zfQNtRAEvHWQRAwh2g+NnbkibHmLYXIx8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJTzsgoQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761315640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0zG4FmLeJZKywQ/yv1mXTKBR1/QBymmCDORQZLAZOU=;
	b=OJTzsgoQg4nCuYHEcADj1FAeNCZvkTXFI4pW27NSqEHP1VerYLs6Ov3aGCIGnhyHOM9QDj
	Y5qfsmhpNAgXJ9ptCU5U0MtEW0+6TsjegyHXxjULjjyr4gw7ZQG7TE7OLDl1WEpopMj6+j
	jEyxnpGKRb7pWiGQskkWNL/VguwaZHI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-t3_quZesM4i5rxFO_-Wrkg-1; Fri, 24 Oct 2025 10:20:39 -0400
X-MC-Unique: t3_quZesM4i5rxFO_-Wrkg-1
X-Mimecast-MFC-AGG-ID: t3_quZesM4i5rxFO_-Wrkg_1761315638
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d584a5147so164462666b.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315638; x=1761920438;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0zG4FmLeJZKywQ/yv1mXTKBR1/QBymmCDORQZLAZOU=;
        b=VDvglrkmnHctG7/JOzpg6mfrUcNYchEGR0l2CQXUMvKbzLh29nZ/Ox55XaEjjq6q+9
         szdkM/LAX30RwTBhHTx2/RCfq5Um4t+jwFrUR09d3S23PlZDHK/BGrDPMPpdHn2+uTIs
         nIp44YcBtdzMTKLpRId7fhqGl2ai3xYXlGsyCM9Bv2VjXbNM0SYLdWT/S+yCwlXk92uG
         1mto3A4yA71beyncpq4loZgIrC1yEYXfholZNK+0kAYbWt4Bp+D3AXn8Kibh9ZQXyuh0
         us0roV9jAineOvQ7jWZtpyWvnkWi3EKSu77TGTpx89ORzDZg8mclz2f5kxIFIeSdfZ4o
         6LHg==
X-Forwarded-Encrypted: i=1; AJvYcCVj2o+CfuIDsa/is3gcQPrrwCcLqNLlIjCQcBNVTLdIz7eYPh0s5a2+9xnAunyMn5dm2STjF2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcFW8X+IvOtQ/JbvK50qe9FLMgAjguqrlLB02bffUvjshAB0Q
	eGJjtu6TSZw40oevRx5mXcXp7suHqVKbqu7AWCMbjoi5y0oaAT/u7imYAY8QN7JdKczSnELr8Ky
	Ibs8jLQ3FYwrlV/mTccxTfkTq7OGNkQU99s8Asu+Cs4dSZzBHyGtE7jdP6g==
X-Gm-Gg: ASbGnctjan01odxxj3W4Q3nuSku4k4vbQ+d2I22AHT/TWIlK5Yu/KFm7iAXYyPev0ge
	LMzWM4/ncyBl4+g3e5+WKG2nY84pys+OgUp9N1YH0pVtzOobAKdYhQKdqlLAoG73Ts1UM8BEfN2
	/y6N7kh07zsFtgfSadN/W+CkRjWj5T84n+DoMjEogzdCpEhTlclkUx4kvJAQbf7iE8qVig4vD+z
	1CPvVOTY/JrOVvRiEZ3QAT5rYup5RM9TjVo88tS2jDki4iDme549zeg10sEGsoGPvK+5fC99U96
	Wal0CH7XwOnqU6CxMdmGCBn82s/4eaFE5lQU7WXJ6O6NNMh9C40dwAXB0pXeJqK/RbC6bv83CJw
	wjfSeNtuWBZegaSnjA0eHb6A=
X-Received: by 2002:a17:907:fd15:b0:b60:18d5:4293 with SMTP id a640c23a62f3a-b6471d45e76mr3455762566b.9.1761315638092;
        Fri, 24 Oct 2025 07:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh/0Q+22Fax089EqYk+r+im+q7S8/f/gRHSVQ7yD+yp9r3NCNb9dQdJV5y04Li0W418orApw==
X-Received: by 2002:a17:907:fd15:b0:b60:18d5:4293 with SMTP id a640c23a62f3a-b6471d45e76mr3455759566b.9.1761315637667;
        Fri, 24 Oct 2025 07:20:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d727b4338sm203849866b.52.2025.10.24.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:20:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4FB972EA574; Fri, 24 Oct 2025 16:20:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, Nicolas
 Dichtel <nicolas.dichtel@6wind.com>, Cong Wang <cong.wang@bytedance.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
In-Reply-To: <20251023083450.1215111-1-amorenoz@redhat.com>
References: <20251023083450.1215111-1-amorenoz@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Oct 2025 16:20:36 +0200
Message-ID: <874irofkjv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Moreno <amorenoz@redhat.com> writes:

> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
>
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
>
> The semantics of the flag does not seem to be limited to AF_INET
> or VF statistics and having a way to query the interface status
> (e.g: carrier, address) without retrieving its statistics seems
> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> to also affect IFLA_STATS.
>
> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/core/rtnetlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 8040ff7c356e..88d52157ef1c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  	if (rtnl_phys_switch_id_fill(skb, dev))
>  		goto nla_put_failure;
>  
> -	if (rtnl_fill_stats(skb, dev))
> +	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
> +	    rtnl_fill_stats(skb, dev))

Nit: I find this:

	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
	    rtnl_fill_stats(skb, dev))

more readable. It's a logical operation, so the bitwise negation is less
clear IMO.

-Toke


