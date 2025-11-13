Return-Path: <netdev+bounces-238330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE3C57552
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AEA03437DE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B1338F54;
	Thu, 13 Nov 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+T+1AcR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fq61gwoz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9933892C
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035405; cv=none; b=g6uTa5ioTzAlTxbBHszmuDe4fN3dqBHmlanG3TGd2M0NmyFzzx1QbT5SDARoDv3pOtv1FrUPKiJSSERCvNJLeTv/ISD9cb7QlUH4hW3vglII+LWqMha1RRom/xXqLP9eZ/GISIZ5DW7w3cEB7r/jDUyXz0qFRmTqC8usA2X8tgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035405; c=relaxed/simple;
	bh=T0nBFV1j3sxyl0ipSJ6SPeJaiNcrqGNNcEGPgng1Qto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7FIxXlYAz7J44kDRVb35tkNiz+WsvVcz0h91KK8ysK/Jod/Z/8wRbqMzyPCyG8yi1pBdWxcI6S0Fr5jKFY94ytIxLFhrmIrZmHblG2TQaSaqKanHZGkA6cXzLZfqidgwEkGwpl5FcaTDpILe5cxbH1YDh5QJlVUozYLdAskGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+T+1AcR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fq61gwoz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763035403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1XB13f2T2pQkQVvJDOyaONCU6FYWol//XsfWhfeDek=;
	b=O+T+1AcRnA2ZqCrpNAFd2WWFZgIN+X2meHE6tEAGnRiCqJaKJr2+kX2DXBXu+cfgNCOizk
	QIJjfvPDsWfdPWkQ+wiuKGWvgn5V4ANadqmv10KXlwPGxz55yS+outJA1yMsn5SP5L6La9
	Y31nSC5qMGd3hfUKX25WR/ZaaxRWQos=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-SHSFEF74M8mR0I_Fq1dZ1w-1; Thu, 13 Nov 2025 07:03:22 -0500
X-MC-Unique: SHSFEF74M8mR0I_Fq1dZ1w-1
X-Mimecast-MFC-AGG-ID: SHSFEF74M8mR0I_Fq1dZ1w_1763035401
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso536006f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763035401; x=1763640201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1XB13f2T2pQkQVvJDOyaONCU6FYWol//XsfWhfeDek=;
        b=fq61gwoz5tmB3qvVaoI8OPwInCa7u3YCr6JAPtf/YUMxGmbtt+fLOM4oVYza5Avm6U
         CxluRzX8fGkIsN6yMba4iF/QOQqWO0FdgTzoZxBpyDWwYA6pjpcig8muHkpFeO/gkBNs
         UE3lC6H3wdJbFLe4uQPqzmdDfBj1WdrPibV1UUNlXmIQd3EVI+Csb4qaO2FaE3yOF6CI
         0u+UEdmIbgvM7f4votKEqgv6BYt+/sk/X/ApFT3CANwZUIxpwAcul641jQcjW+4ytlx9
         ZvoRk6I/Yn3DxHluIAX1EiuDQRY2RQVvVEI46F4zY1D5loXFLEKF1IHsfCfE3jka6Xr4
         +kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035401; x=1763640201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1XB13f2T2pQkQVvJDOyaONCU6FYWol//XsfWhfeDek=;
        b=u68IMb+A7ZLFdJ/Q5UeglZStlV/3rPnCHYnD0WARlmV9SPIY7gM7TcmbH+9ixKiESW
         yjmO/WSwojwjYfqrVMn1VVmvS3DxSHQzSqscSDECBfBC4KFbM/hWMJmJiSBQNv0KZ7CL
         ri8lOOA2tXU3c/w84miovSIV8X08tssxE4PSjil30zFuS7iuuIfTAElXfN/t9VwOiiWh
         NBV/0Iu44Tg9DyqofOWB/KrM4ejzn9YCciABPJl74ykF2PzEqyeInyyTIxTHwJBrOuA3
         Q3vGwYFqo0POXka+Dv0Mv7XxsWbvOLMlO6X3QU+EMHbyl8tWJ3QQZdYG7dP3/KMQcJhq
         jlog==
X-Forwarded-Encrypted: i=1; AJvYcCXNz59DpSPNDXzkX6c0JRN0LftOpfEBcYhZIz/wFReIWJL3gvKqsFSwzPdxxC/NumZgOMcdRe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYh9+O5qyZV2YoWx9EN/XyJzf28XH+gRw7IcDXwlCYydlnvTD9
	agKKPWK8BjWTg9o7voT7LvThqnzyzJwoT28YT2thkm+Uf+TzDEI4tEjVSSSyhuVDBqLA+bcWG7/
	Npup5bxQkxaru/UBUfWhmO7UdmUAp9TWydJJ6AdkBeUHqlB5B0D1z6oZdGBRE6pY+Ng==
X-Gm-Gg: ASbGncs60ELc2iEaIgVSvugymfP6QrU0YQs3oKPeLSII/I8fTJJLMXhYJLplCNCpEjP
	uRMK7DDM+2+tBZuRXCM+u7WG0Yfdv0PUhnBN1aF/SYZKvJKSnIidKTkN7w3e6MzVvGCcs5Mz+G4
	bQ+9wzJGqrBDywIpnpHNZw4FyGneZo38/CBn1IpRBGb/Qw5Yz6oGzHgy2Tl8dnNbpGprAfrgrj5
	p2GjRsD4sJVp1c08RiZnQqDP3+xfiIp/zJv93E9D/wKPBJqwZc7/H1PiVHOuAIfOO0LeqjgNlLm
	JkbBawjLcKjU+lLjL6qRc7tCOjJ5m1Gt6toyTpOBBbdTNQh+kgk/5lnGR5dI383FSNBP8vNXnz4
	gOF7/9hjohG8S
X-Received: by 2002:a05:6000:26c7:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42b4bb981f9mr6698091f8f.20.1763035400754;
        Thu, 13 Nov 2025 04:03:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrknDMXKWfpxOXL6+Xl4wgtLjfnMpqDum9BcTyTPAiSxqSSpss8LmX77BW1SJ2FLfJ1dle7w==
X-Received: by 2002:a05:6000:26c7:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42b4bb981f9mr6698047f8f.20.1763035400167;
        Thu, 13 Nov 2025 04:03:20 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b074sm3418217f8f.7.2025.11.13.04.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 04:03:19 -0800 (PST)
Message-ID: <a4c8e0da-700d-4ebe-b5c9-ffc4b9eebc62@redhat.com>
Date: Thu, 13 Nov 2025 13:03:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: clear RA flags when adding a static route
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Garri Djavadyan <g.djavadyan@gmail.com>
References: <20251110230436.5625-1-fmancera@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251110230436.5625-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:04 AM, Fernando Fernandez Mancera wrote:
> When an IPv6 Router Advertisement (RA) is received for a prefix, the
> kernel creates the corresponding on-link route with flags RTF_ADDRCONF
> and RTF_PREFIX_RT configured and RTF_EXPIRES if lifetime is set.
> 
> If later a user configures a static IPv6 address on the same prefix the
> kernel clears the RTF_EXPIRES flag but it doesn't clear the RTF_ADDRCONF
> and RTF_PREFIX_RT. When the next RA for that prefix is received, the
> kernel sees the route as RA-learned and wrongly configures back the
> lifetime. This is problematic because if the route expires, the static
> address won't have the corresponding on-link route.
> 
> This fix clears the RTF_ADDRCONF and RTF_PREFIX_RT flags preventing that
> the lifetime is configured when the next RA arrives. If the static
> address is deleted, the route becomes RA-learned again.
> 
> Fixes: 14ef37b6d00e ("ipv6: fix route lookup in addrconf_prefix_rcv()")
> Reported-by: Garri Djavadyan <g.djavadyan@gmail.com>
> Closes: https://lore.kernel.org/netdev/ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> Note: this has been broken probably since forever but I belive the
> commit in the fixes tag was aiming to fix this too. Anyway, any
> recommendation for a fixes tag is welcomed.
> ---
>  net/ipv6/ip6_fib.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 02c16909f618..2111af022d94 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1138,6 +1138,10 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  					fib6_set_expires(iter, rt->expires);
>  					fib6_add_gc_list(iter);
>  				}
> +				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
> +					iter->fib6_flags &= ~RTF_ADDRCONF;
> +					iter->fib6_flags &= ~RTF_PREFIX_RT;
> +				}
>  
>  				if (rt->fib6_pmtu)
>  					fib6_metric_set(iter, RTAX_MTU,

The patch makes sense to me, but I don't want to rush it in the net PR
I'm going to send soon. Also it would be great to have self-test
covering this case, could you have a reasonable shot at it?

Thanks.

Paolo


