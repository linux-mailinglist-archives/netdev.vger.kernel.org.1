Return-Path: <netdev+bounces-114129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFEC941076
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B461F25C86
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB519D8A6;
	Tue, 30 Jul 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFICk5fG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77718C336
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338890; cv=none; b=BUkMkjfeu9/rvW4zVG0P0AFom+RQr6hYILkk6fndKK4SIs9ikN8pmylhaN9Q4xFr3X4qBSdBqcjWNq90NBlBeAh+8RyR4opYulzt3JP92gIyopilGMf4OToPv5DTNlC12nipBYyDNwyPsjcraHwVPaSf3YRG2F1udl+RWcem5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338890; c=relaxed/simple;
	bh=s6rWg0fq6s5g8o1bakDHd+9/38EIiJtiHrkvN9uHprI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mirHVE7VuXQ9FGIU7sLdKXdlTWH7nKfUHk7R4JNRM5agd3hWdmUDDsw8C7XN2RXSgnkkbjcs4sUq93YdOb5y36ZpUFrlMaeYfZkqynfjU57ePJ679MO3HLCB2H3JoK4unLgu/F2HOj0NLXzK8VMqdX4obvB6EVgHc7hvmPIQ8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFICk5fG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722338887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zD1SJ3PPbyt4DC17BZgXd92OL4IE72/gvd82oVvg8UM=;
	b=UFICk5fGJTSvdbM+8MNWn+0a5Hk44N+59lzup2enyFGF4hBkB4cOmKaVpVw7JKvuCH25XR
	x0kjNHlHb5SHXhiOv3ffh19ln9sJ+rI8NBaOuYdi2z6o7p28ef4Y7FRGBkZDYLcRXlZZxz
	Kr32Oot52+uc1BcDoh45uzZIQnWNtC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-tTsrvhUzPwWvgPKzv50Q5g-1; Tue, 30 Jul 2024 07:28:06 -0400
X-MC-Unique: tTsrvhUzPwWvgPKzv50Q5g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3684e48b8c4so126293f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 04:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338885; x=1722943685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD1SJ3PPbyt4DC17BZgXd92OL4IE72/gvd82oVvg8UM=;
        b=D5xEEPQVbuLgNXlprAn0/1Aw7t5cDjU4aaC435yfDY2EuHv3hDqG0NTDMs3wcDQyss
         Fa/uYULJdgOht411ttm4cMJmt6eOX1HLvm6u4C2edNOnWVqiby+8W6bvdMWgIcC4moVu
         s8hINUjIatVxhvGQPcDOMS4cB3y18Lv16FcBnOcs4eieOTwECNXpaMTC7DWosX8bEmtS
         OL4127darHc68p2da7WjyH21X+AXqRb46xjuK/TfHCqDzPfDFpoi4QLmQHD826kcXaYr
         YCo1igMv8KMR3614hAuBzKSPvkLvBuaL56tLWtB2ktZt4qGhRgycWw7BpNAAx1z99bJx
         XwLQ==
X-Gm-Message-State: AOJu0Ywrm4RRcfoI/fYIwoGL7zLfKxPxRdESF3vDds8o1/x6osiofPgJ
	oOnLzf8l1vwDLtBp9vcqu/bwX4EiBMeGFbspj5uJ/7gjwqJbyWo3GtWFwCNaCrvsCYd3EissyfH
	wvkpFvuq7ZM7zUShc/cvFAf5FotH1m0Ozjzf1fJQwSpbGqjccfxx3Hw==
X-Received: by 2002:a05:600c:1c2a:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-4280542e12bmr73625165e9.1.1722338885108;
        Tue, 30 Jul 2024 04:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSJZKLldnxth/7Kv/IJC29OBUSCr6BzSO00P8WsfDDBSGFdXZFtwxbxcyyuNgHpBD5te80Tw==
X-Received: by 2002:a05:600c:1c2a:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-4280542e12bmr73625045e9.1.1722338884644;
        Tue, 30 Jul 2024 04:28:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280fa9a30csm142642345e9.30.2024.07.30.04.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:28:04 -0700 (PDT)
Message-ID: <169992e9-7f5c-4d4e-bf7a-15c64084d9b9@redhat.com>
Date: Tue, 30 Jul 2024 13:28:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] bonding: change ipsec_lock from spin lock to
 mutex
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
 <20240729124406.1824592-5-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240729124406.1824592-5-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/24 14:44, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> In the cited commit, bond->ipsec_lock is added to protect ipsec_list,
> hence xdo_dev_state_add and xdo_dev_state_delete are called inside
> this lock. As ipsec_lock is spin lock and such xfrmdev ops may sleep,

minor nit: missing 'a' here ^^

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 763d807be311..bced29813478 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -439,38 +439,33 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>   	rcu_read_lock();
>   	bond = netdev_priv(bond_dev);
>   	slave = rcu_dereference(bond->curr_active_slave);

Is even this caller always under RTNL lock? if so it would be better 
replace  rcu_dereference() with rtnl_dereference() and drop the rcu 
lock, so it's clear that real_dev can't go away here.

Similar question for bond_ipsec_delete_sa, below.

> -	if (!slave) {
> -		rcu_read_unlock();
> +	real_dev = slave ? slave->dev : NULL;
> +	rcu_read_unlock();
> +	if (!real_dev)
>   		return -ENODEV;
> -	}
>   
> -	real_dev = slave->dev;
>   	if (!real_dev->xfrmdev_ops ||
>   	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>   	    netif_is_bond_master(real_dev)) {
>   		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
> -		rcu_read_unlock();
>   		return -EINVAL;
>   	}
>   
>   	ipsec = kmalloc(sizeof(*ipsec), GFP_ATOMIC);

I guess at this point you can use GFP_KERNEL here.

[...]
> @@ -482,34 +477,44 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>   	struct slave *slave;
>   
>   	rcu_read_lock();
> -	slave = rcu_dereference(bond->curr_active_slave);
> -	if (!slave)
> -		goto out;
> +	slave = rtnl_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +	rcu_read_unlock();

You can drop the rcu read lock/unlock here.

[...]
> @@ -569,14 +574,13 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>   	struct slave *slave;
>   
>   	rcu_read_lock();
> -	slave = rcu_dereference(bond->curr_active_slave);
> -	if (!slave) {
> -		rcu_read_unlock();
> +	slave = rtnl_dereference(bond->curr_active_slave);
> +	real_dev = slave ? slave->dev : NULL;
> +	rcu_read_unlock();

Same here.

Thanks,

Paolo


