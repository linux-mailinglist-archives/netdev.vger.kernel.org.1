Return-Path: <netdev+bounces-215567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F01B2F451
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203341784A4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D22ED868;
	Thu, 21 Aug 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZzwgdmN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051A2EFDA8
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769362; cv=none; b=RhzNIo6hteGxscx3JidrMT/uF4JoHX7L9gF8R0cJlLXgI+0C6xgzkLHntiNqdu2R3hAOPk/lWjdVYZd/bQIHNS5Vw8YMxKFeGr9ZjmC3V8+V0vdOZ5L/DOg5rVQM5iEGxk8qqhg3TOS2gK2/TcD6h5oVgG/br718VoKk34bQXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769362; c=relaxed/simple;
	bh=Y/8/4xBnYM+a2pABQYuBM5lM5u9sXzSEfIpVTCZenc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N73Ak+S4iFWs7FenKjze70wliE1+gWgffU/WzJnrPMEUtoM5qpQb0yd9lR0oOAVUwKiK6rPyMY8FI4YrJcXvzju7/ubZAtkQ7EpWDOtrisSJZaXRNrrxesXilJUeAmJhBLcHtBf8fZY4SMzjPiQj3Ke8Gg+HrxlyhUhrwf8qtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZzwgdmN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755769358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7e/AESVWGY80+OX7Lbi81zvHgzcoacjfV+IOdwHfo64=;
	b=QZzwgdmNaJiMITqFoPX0caQzwgEWJekKojKpevjVPCRyjWQeXEdCMUkU5N0e8A1AD3e7BG
	lkUy1lW1XZW7rbDU+xsbUThXd434/V8xpVzOSQMw3Pib61Tn2SbCxMZaQb6IfUuTWG1XoL
	0GO5TCEKFP4Pe7UJkdDtwq8euMdmWB0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-PI6sBz5jNEuFSbueSfRKeA-1; Thu, 21 Aug 2025 05:42:37 -0400
X-MC-Unique: PI6sBz5jNEuFSbueSfRKeA-1
X-Mimecast-MFC-AGG-ID: PI6sBz5jNEuFSbueSfRKeA_1755769357
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86499748cso522343285a.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769357; x=1756374157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e/AESVWGY80+OX7Lbi81zvHgzcoacjfV+IOdwHfo64=;
        b=KLkQ5eB6lqwo6cba0wTdTsiO4hxk5nlAMewOa7RV4gRZY7QUMm3avxrM9RLAGf6vJA
         4yhjBu+HhDLgX0PXDkledMvEr5zK+4sBV1OcB0wiurli88mU1Mj9JrZlacHFLRGH5WmG
         8j3r/yakvW23N6Fjw6ypyR3cvTXLDui0eyNzOFslbXGU7tdBf0xmXeSwqzEKf5tsc2lX
         ggztDMrW0CA0TgqyAd81W17078L2nK/xEMYfmMY1SHhiVXsGuL3xHaViy4H4rDvda4BH
         hktBX7CAI6gtL+s57FpLxEw6NLN23zGbrxt32jbRO9DLbh9qhTB78yYYjokNhI4YiLIs
         Grvw==
X-Gm-Message-State: AOJu0Yz9KZTZktIck25D/YqAj5K5LrVVsRdMVzwDlV9ErW4NUxp5IVFC
	QzQXPI/iVOPgQUpZ+qwyAqA4jW8ko0jRQxeqIR5tpdNUMik9QzE4Gydbs3J49EFuV9bpEau/fkd
	4DV7Cho+TRv2TlNkpaF0nLWl8kWfhoczIe9brmM9qwmjYeT78TOfY4ovldQ==
X-Gm-Gg: ASbGncuKPqvpToq2gZ2RngRk+qYrj+t3WpniFaMMaE3JiTQ4PnQUvnN+FKCPySsnnC9
	L3Pu8iuI5HPlw2TKVjDi0RZIidoYqKC9JR3C1QKFCK4ImakbB3hKHxGWcKMoDZcKxm6Z9FOZhnd
	AyeLpnzOcah0NTz4mYcmuZgPdesLUTD2KO3nf0P3ENjYilMM3djP97TDCkP4nHSqiI2pPwW4KY/
	WvawW422TmQreQDeKDLi57aKHqhumcj+HETs3D4WcHGa9ZCMbZ+ZgaRLO6nDojyNFWDXM9AOJKt
	uCBzaDw5lLW9E8vAVrf0oS7Byob1l9ZLZjzqu53XcgarJ8gcIMKalOL15XfkevyS0+qDv/KdbHY
	szbDFU5wqt3Y=
X-Received: by 2002:a05:620a:3943:b0:7e8:594f:d3d3 with SMTP id af79cd13be357-7ea0948de2dmr177143485a.31.1755769356949;
        Thu, 21 Aug 2025 02:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnj5oa0giFQO7yCjIQInKC3BV64wT5OGw8vHaBnbe4tBPDAmYH9TUEvawpexDCTQcgTiSnDw==
X-Received: by 2002:a05:620a:3943:b0:7e8:594f:d3d3 with SMTP id af79cd13be357-7ea0948de2dmr177138085a.31.1755769355405;
        Thu, 21 Aug 2025 02:42:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ea048399f2sm179119185a.42.2025.08.21.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:42:35 -0700 (PDT)
Message-ID: <4ff3b7df-cba0-4446-8411-7b99b5cdce69@redhat.com>
Date: Thu, 21 Aug 2025 11:42:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next] ipv6: mcast: Add ip6_mc_find_idev()
 helper
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818101051.892443-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818101051.892443-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 12:10 PM, Yue Haibing wrote:
> @@ -302,32 +310,18 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
>  }
>  EXPORT_SYMBOL(ipv6_sock_mc_drop);
>  
> -static struct inet6_dev *ip6_mc_find_dev(struct net *net,
> -					 const struct in6_addr *group,
> -					 int ifindex)
> +static struct inet6_dev *ip6_mc_find_idev(struct net *net,
> +					  const struct in6_addr *group,
> +					  int ifindex)
>  {
> -	struct net_device *dev = NULL;
> -	struct inet6_dev *idev;
> -
> -	if (ifindex == 0) {
> -		struct rt6_info *rt;
> +	struct inet6_dev *idev = NULL;
> +	struct net_device *dev;
>  
> -		rcu_read_lock();
> -		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
> -		if (rt) {
> -			dev = dst_dev(&rt->dst);
> -			dev_hold(dev);
> -			ip6_rt_put(rt);
> -		}
> -		rcu_read_unlock();
> -	} else {
> -		dev = dev_get_by_index(net, ifindex);
> +	dev = ip6_mc_find_dev(net, group, ifindex);
> +	if (dev) {
> +		idev = in6_dev_get(dev);
> +		dev_put(dev);
>  	}
> -	if (!dev)
> -		return NULL;
> -
> -	idev = in6_dev_get(dev);
> -	dev_put(dev);

Not so minor nit: if you omit the last chunk (from 'if (dev) {' onwards,
unneeded), the patch will be much more obvious and smaller. Also you
could clarify a bit the commit message.

You can retain Dawid's ack when posting the next version

/P


