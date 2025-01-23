Return-Path: <netdev+bounces-160510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC6A1A019
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFA216D55E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0320C47B;
	Thu, 23 Jan 2025 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKQ4AAYh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318820C03A
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621781; cv=none; b=uuZY0dgfX8zlB9D4pNGzlYlRxqaLl/3Bt3sELUpqRguvxsj4vbVLB57xfNjmSul2RmTKhY5gqUvE/HFLXhwPmw0gTycW6FBdSAWRlWVa39wcb7IC76OfuDe7XsfatHOjnEJE4Xq/iSnp/scpElbcPpK9q0JY7XCW6CAeYeT4dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621781; c=relaxed/simple;
	bh=W5EOVpddbQRRllFhbSwuM+hw+G/Vrs8x/dSe5NV+jUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TXV16s76/mNXy+CNvm1GxlcaSMNtWVEfef9PPjDK4jlWBuYZGVfW53A7A2srXKnvC9NFHll/mfugtddsf5EpRxgLjfWsTGhi+MtDLHJHqVXm8w5VCcmYWRG0pwHsdN3bdcygbjLAOGVd939eOIXiXMB4XZTF5ODmDnhO0p4+oWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKQ4AAYh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737621778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7VpKnoXpxqrufmF6Uq4djpTFVl/srMFbe01PZDMXHg=;
	b=XKQ4AAYhHYszoxuefe+zZ4NSr8ib3aYIx/qJ4t6ZdL6GJ6xi4aFyXJQ7tyWFYrpxjJifZq
	DPHv04ynW2hKn1jBwndqPNj2LGi8SQYCComeDCvoZ5TodQ+7Od8qHUYUoTmtQgLv1XzcPx
	il4PmuwREzmWK6kRcEN4QmwyspVQVWE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-wYLA7cYsMyOWsDSYMelq3Q-1; Thu, 23 Jan 2025 03:42:57 -0500
X-MC-Unique: wYLA7cYsMyOWsDSYMelq3Q-1
X-Mimecast-MFC-AGG-ID: wYLA7cYsMyOWsDSYMelq3Q
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43619b135bcso2885785e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621775; x=1738226575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7VpKnoXpxqrufmF6Uq4djpTFVl/srMFbe01PZDMXHg=;
        b=lU7beywfa5acwoaESDLFWMM518A3p9qV6bz1V1ckCcvRovM8TSk9nko7edHpIza2BB
         AqC4CtbgKhWJ2xCbAZ+owA7AeeKxjBbPkLAFI7j16QJVYTJ8XefolfonjCeXGVrWZqfB
         k8ErK4JyHEwUS82V/fHHryslXB5wzFnSNWB4FCJAT/rwMw8mWdrF+c2ZLpjfSW0r4H+9
         No80A2A+KehA+XxKoMRL/zNunALuj/sMbdruqGw/fC+DK49vtOm0RxSCSWZ/ZaZtyx3B
         frDuxsQ4fpvv9zGUswEjqCAsO3rD9zZ6vSjcMS/+1HVyrZiCkjFPKAXWvBfv2yj1FTnx
         /u6g==
X-Forwarded-Encrypted: i=1; AJvYcCXEJGXAD1KZDsfK+mHjKoZw+Q5AcSWcv9sD5b/zVP76CVvCiXQImjFrH/jO6RK6mx03RFg7h7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ENckMVAXtZ0E6gNku+AHlvdaifsjznhI8GJZGZrvRYTsW0+d
	7nsMJV5gqqptk8ywm9ARYIc7o6QnNBUrZ1UGEYb2XRLV2F/Zi2u9hMm5Y2+rj0YIcHalzE6+jo/
	ZjbdZ+SQWUzd9xeWu3F0xTl9/ogHwEFbozb21ld49UIAn37xU7NMK/N4/g0Kw5Q==
X-Gm-Gg: ASbGncsObuU8bFeFI3ivEOCleeMB5Kfvk+qZf6Mv9cAzM1u7FuL+nZRgSF9bg4Ai59t
	4evs4Hun5iHiSlM/YNRiI5B27nthd+gEsOEcgPZbE+PL7CJHgbEgktgUgDAH/LOtwac5V/XJizG
	e4NGNne5tysQfa1+OCxQdcmi7nl8hkeTKd/6bwtXLMJQ9hrgqJqyqjEMTrTZjbL4tyksQRDwVfN
	Cl+aMs7WiqGgzjfmJapuvaHjzQxrgAP3bodGeZt9etyVO8hxepJt/I3hUxzBPmt6RhB++8oHcVZ
	wgsGrVoCAfr8tuJxExi6zR6s
X-Received: by 2002:a05:600c:3d05:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-438b0dc9532mr88513525e9.5.1737621775459;
        Thu, 23 Jan 2025 00:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+6X3e7kB0DtfO/qbwwTzYJk66XVeL1g86ixoWl/N8/0lpKCBF8Ed1lo5mhchkHseZsdmgcw==
X-Received: by 2002:a05:600c:3d05:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-438b0dc9532mr88513315e9.5.1737621775153;
        Thu, 23 Jan 2025 00:42:55 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b1ce51a6sm43477185e9.1.2025.01.23.00.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 00:42:54 -0800 (PST)
Message-ID: <3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com>
Date: Thu, 23 Jan 2025 09:42:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned
 skbs
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250121115010.110053-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 12:50 PM, Thomas Bogendoerfer wrote:
> gro_cells_receive() passes a cloned skb directly up the stack and
> could cause re-ordering against segments still in GRO. To avoid
> this queue cloned skbs and use gro_normal_one() to pass it during
> normal NAPI work.
> 
> Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> --
> v2: don't use skb_copy(), but make decision how to pass cloned skbs in
>     napi poll function (suggested by Eric)
> v1: https://lore.kernel.org/lkml/20250109142724.29228-1-tbogendoerfer@suse.de/
>   
>  net/core/gro_cells.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index ff8e5b64bf6b..762746d18486 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -2,6 +2,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
>  #include <linux/netdevice.h>
> +#include <net/gro.h>
>  #include <net/gro_cells.h>
>  #include <net/hotdata.h>
>  
> @@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>  	if (unlikely(!(dev->flags & IFF_UP)))
>  		goto drop;
>  
> -	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> +	if (!gcells->cells || netif_elide_gro(dev)) {
>  		res = netif_rx(skb);
>  		goto unlock;
>  	}
> @@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *napi, int budget)
>  		skb = __skb_dequeue(&cell->napi_skbs);
>  		if (!skb)
>  			break;
> -		napi_gro_receive(napi, skb);
> +		/* Core GRO stack does not play well with clones. */
> +		if (skb_cloned(skb))
> +			gro_normal_one(napi, skb, 1);
> +		else
> +			napi_gro_receive(napi, skb);

I must admit it's not clear to me how/why the above will avoid OoO. I
assume OoO happens when we observe both cloned and uncloned packets
belonging to the same connection/flow.

What if we have a (uncloned) packet for the relevant flow in the GRO,
'rx_count - 1' packets already sitting in 'rx_list' and a cloned packet
for the critical flow reaches gro_cells_receive()?

Don't we need to unconditionally flush any packets belonging to the same
flow?

Thanks!

Paolo


