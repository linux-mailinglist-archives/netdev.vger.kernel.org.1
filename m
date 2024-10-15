Return-Path: <netdev+bounces-135446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C299DF82
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E392B20E41
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE1717E016;
	Tue, 15 Oct 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="f8UvGRaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63877231C95
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978317; cv=none; b=rb5VFiMPRXxRtewJ/RcMnVBKZXN37fF58hqmrwnLgxE7ENLBZ3AhaE9Qng2Q1Ayv3An4getgHAYsj19HoEsqc5JAFrIfRKG/Rzf1B3shs7sighZwo32TP95OfEKzWj2a4cnO+xe6EKcRRyns2bnunk7FnOv+kzwwsjioK9JuPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978317; c=relaxed/simple;
	bh=8WFPwkfl5Zl279e9KpqKxJLo3XaklUu8GfbAqveSirI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t4bt+bKJNCNj1hZphg9qPhKkMV+yYTZTBP/OFp+7tUqI4el6dntr08ApNO3UqpSV8OHIPls1Y2lecx62rW42lTRw1kiPJ4QuBLbRsWXzH7UyBCsi6OUgwrorJbIUjaVhkfCOxbcp9+pE1LB+tyEgk5ok0XSH2jiZLpxXoKww5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=f8UvGRaH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4304ea60a58so6306045e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1728978314; x=1729583114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tCjTOD6RccsjBLhCHqxQsUi4Ne/TR+Hf8YTrvIBi5Y8=;
        b=f8UvGRaHO3qoNFlsf2UWIeCjtFjEj8BkG6rDW0zQ/CHylRRgrOTlhmPa8Su+XmCiTK
         h2VGu5uY3sIyujASlDwyHqbR1fEIBpquz/jztHX6bzUxfXmTtR+Zk8LPsFniV5td5lgn
         pOKS4T/Hb8v6sxWSiEeGDU4XEkhF3CL6+hwB5+OKrPPHMYrOQ9U7RiJaQN9d3ghuenBf
         2u30HbmX0+fHLIr3xAccbEYQ9ZtWHqj5HFhXU8W8UBcbDQ3J2vEBElt8arQoLfNW/pkd
         p2DqZFFX2xXErIHnQ3NlCNZN9+4ZKJnnocFEgfAzpbnRCwMV8GI11N0nmN7CfGzR7Dqp
         2MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978314; x=1729583114;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCjTOD6RccsjBLhCHqxQsUi4Ne/TR+Hf8YTrvIBi5Y8=;
        b=dCjqXq8tgDyjrlJkKhTq+KHhTSSaTZIna5ioTBrZjXIlENR8NHgfX6w8670Jinr0do
         Pee47LkiUVbp9FO24fOyoXmunE/H9oHLPpvr0NZkMpn+2+cLIn9ZeY3P0gSUY/fmvQdg
         TAMe63Wls7lcIv/+na+MTqkJ/ZadZPghMR4/XY84s5hAfjJ3gExA8TFDS2VIq6vxw0Pq
         bD9VmGqWeydbsBl5OTeUVlidjdX93hH2ZiNmx4OgPLwdzp8YrI/4j27MuXHSahaUE9pJ
         zn0+auEAM8hPG777bM8M1CqdGbg837eyKXihO87w1eaiCIWVdpfxwbIzjZ/L8lzqxMXO
         SdFA==
X-Forwarded-Encrypted: i=1; AJvYcCXrm3fDTTq+XWV6T35lExsufiUe87+skp4u1eGvoPZzzPvg2K3PC+MseJBB6zYw8Wnkg+ACv8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJxuCgtc/G9bBuCApWY/ztgT79IBU/IRryvqRXleUNod1zkNq
	Y7TajxJO/UHBqgXf1miCgfwSUC8ZmDuvCKHbiXQREN4QLwxq5mDIKhmXffekg3g=
X-Google-Smtp-Source: AGHT+IHuJ/KdZ3x8Px7xIduqo0njRD1I2750TFgOAiI/NqqJyKAEa5B6bgZrrKDKLXUKRHeB0Ofmog==
X-Received: by 2002:a05:600c:358f:b0:430:549c:8d55 with SMTP id 5b1f17b1804b1-4311de9fffamr52605705e9.2.1728978313672;
        Tue, 15 Oct 2024 00:45:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:3580:daf2:14d4:f937? ([2a01:e0a:b41:c160:3580:daf2:14d4:f937])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8382sm846599f8f.86.2024.10.15.00.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 00:45:12 -0700 (PDT)
Message-ID: <3ad78fb0-4aa2-424b-9e91-8c32b1c266f5@6wind.com>
Date: Tue, 15 Oct 2024 09:45:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2 iproute2 2/2] iplink: Fix link-netns id and link
 ifindex
To: Xiao Liang <shaw.leon@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20241011080111.387028-1-shaw.leon@gmail.com>
 <20241011080111.387028-3-shaw.leon@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241011080111.387028-3-shaw.leon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/10/2024 à 10:01, Xiao Liang a écrit :
> When link-netns or link-netnsid is supplied, lookup link in that netns.
> And if both netns and link-netns are given, IFLA_LINK_NETNSID should be
> the nsid of link-netns from the view of target netns, not from current
> one.
> 
> For example, when handling:
> 
>     # ip -n ns1 link add netns ns2 link-netns ns3 link eth1 eth1.100 type vlan id 100
> 
> should lookup eth1 in ns3 and IFLA_LINK_NETNSID is the id of ns3 from
> ns2.
Indeed.

> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  ip/iplink.c | 143 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 118 insertions(+), 25 deletions(-)
> 

[snip]

> @@ -618,20 +653,25 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
>  			if (offload && name == dev)
>  				dev = NULL;
>  		} else if (strcmp(*argv, "netns") == 0) {
> +			int pid;
> +
>  			NEXT_ARG();
>  			if (netns != -1)
>  				duparg("netns", *argv);
>  			netns = netns_get_fd(*argv);
> -			if (netns >= 0) {
> -				open_fds_add(netns);
> -				addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
> -					  &netns, 4);
> +			if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
> +				char path[PATH_MAX];
> +
> +				snprintf(path, sizeof(path), "/proc/%d/ns/net",
> +					 pid);
> +				netns = open(path, O_RDONLY);
>  			}
This chunk is added to allow the user to give a pid instead of a netns name.
It's not directly related to the patch topic. Could you put in a separate patch?

> -			else if (get_integer(&netns, *argv, 0) == 0)
> -				addattr_l(&req->n, sizeof(*req),
> -					  IFLA_NET_NS_PID, &netns, 4);
> -			else
> +			if (netns < 0)
>  				invarg("Invalid \"netns\" value\n", *argv);
> +
> +			open_fds_add(netns);
> +			addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
> +				  &netns, 4);
>  			move_netns = true;
>  		} else if (strcmp(*argv, "multicast") == 0) {
>  			NEXT_ARG();

