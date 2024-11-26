Return-Path: <netdev+bounces-147469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817F9D9B54
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B6281C3D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148C1DAC8D;
	Tue, 26 Nov 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6kc2Ifg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACE1DA622
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638185; cv=none; b=iXMSh4k9ijd71UA+D3TA+/i3ToWDvFWR94PbucbasgmZsIj2hUzDVjphNUBdZGqTwDD3O2PIdsl/bexwX68p/96OMdrG8JLFGug9TMEEbi4HhKZfO/KU0xT3W6pFDF+NXMEA+nl5PuVCHbLDsSzCtS5ddXHnW8vX48dZLuI7g6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638185; c=relaxed/simple;
	bh=1lJjfa0NYmOPSLtpL2pXdpetV86kY39b+sCABhxs40k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnDx5QpgC+uX52bqvQqpYGJ+NMFAMVQGmo3dWtpLC6qnrg353MG1c7/JJbb5nS4LBssaytUtEIa2exa6otQcPD6kLUH+GPr9zE/aiaj+1eZBY6oAVlI62MgzH51Nvn8zbKuQdasawmBqnR2WyyEV/1SmRfpxWSccnZ1i07nHTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6kc2Ifg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5C0C4CECF;
	Tue, 26 Nov 2024 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732638185;
	bh=1lJjfa0NYmOPSLtpL2pXdpetV86kY39b+sCABhxs40k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i6kc2Ifg5I1kPNKVUBTB8Qt9UPm26I+HMNmqzt6xxe81veujyiLlRw66Yqq3A88/o
	 I+XvnJa4NF3BdArLiSOx1xbAnGjj0Y3qFQwRNikw0V129e2Oxi1kJY7AI96DcXkRYR
	 WqvkGHJv7y+YsynTaAyfVayW24QiwLNVGn4EUoVbCj88dh7OfjNmfSMk4+MgeP41MH
	 8n4i1blwdDzItNTWrfjM6URdMHqOhi5UMNSQymU/3nGbfzzN8HXKoQHPB4Do1m1kfp
	 7rBiDYZ6sNqkaOK4YXV47WNkYQTIOKvWC5MXd6Wao2LiBjWSLpaFWO38SBLcSOIujO
	 AKas9/saFXssA==
Message-ID: <e4477a20-8f35-43de-a7f9-a0c7570248cc@kernel.org>
Date: Tue, 26 Nov 2024 09:23:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: Fix icmp host relookup triggering ip_rt_bug
Content-Language: en-US
To: Dong Chenchen <dongchenchen2@huawei.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 herbert@gondor.apana.org.au, steffen.klassert@secunet.com
Cc: netdev@vger.kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com
References: <20241126025943.1223254-1-dongchenchen2@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241126025943.1223254-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/24 7:59 PM, Dong Chenchen wrote:
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 4f088fa1c2f2..0d51f8434187 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -515,7 +515,10 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  			  flowi4_to_flowi(fl4), NULL, 0);
>  	rt = dst_rtable(dst);
>  	if (!IS_ERR(dst)) {
> -		if (rt != rt2)
> +		unsigned int addr_type = inet_addr_type_dev_table(net,
> +							route_lookup_dev, fl4->daddr);
> +

	unsigned int addr_type;

	addr_type = inet_addr_type_dev_table(net, route_lookup_dev,
                                             fl4->daddr);

allows the lines to meet column limits and alignment requirements.

> +		if (rt != rt2 || addr_type == RTN_LOCAL)
>  			return rt;
>  	} else if (PTR_ERR(dst) == -EPERM) {
>  		rt = NULL;


