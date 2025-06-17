Return-Path: <netdev+bounces-198425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C035ADC1F3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11AD7A9CD2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D721B9DE;
	Tue, 17 Jun 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="khyMBJjL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B43C01
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750139880; cv=none; b=uUJ85yyPmhNS0CBqya5nSk0GinIO9+mskyuyMOFVwmmOEwpjibePtWbecnnF+fVm5eZWZdqY/uMYkv6Nw3DB2bmPuRUykHz/yxYAuoroSz8kdZO3jayqsy1trmr25sTqjAGVRDnCJ22geBV/Zu34JRhznf44PeVICpuneSTVVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750139880; c=relaxed/simple;
	bh=GRYarQ+kHkb/ukxZY27ulsblCQqYCRFLgbkK8/s6tj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP+m/u/G1YmRAajvHbBhyz5bkOmBp4ugLtceDbYBU4oddoNDVXCO3bqfRxouOxbmubM9CjjaNSqdLTh64eTsIXsaqQctGDbZ38qB64EQMxic8IUwFlIyJC1oAt3P3Wzwp7ODkGML6uduyizlmVG4BrMSOr+j9D36VVj3CMfoYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=khyMBJjL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade326e366dso971743266b.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750139877; x=1750744677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orUmTfObyCoRilgOAZEE4KG1ZsUE67JBZL30U/ZdLd4=;
        b=khyMBJjLeH0NmVcdbDi5nC+whlK62cRoVOsAWHOqy4UG62hhqtRXZdj+zLKA93nZ5I
         6Nu6YwGkJXRRSzJ3vHjr5WlGKbSotWYegt+Zwwr5L45/vYIZpHh6RtAF+lNjdra7VH16
         JXV49SMjr8CY7AKFapv6wU3Av5zkJqWXWseoEsEbrlZiYKkSwA31nYgwrzjYN70xNpXo
         mGvvJC7Vbi132I5rZ2bjuRL6xpMKbwl+BbhwCTzTvNry5V5wPKHIBAVWj7lFnIhH8K2k
         4TDGRU2zP9lCTfjJOCnwr3uOSb5UeK4dzpeEf+8MCl6QjrAIVhqer42yX/x+Gn/V/rGh
         Zztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750139877; x=1750744677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orUmTfObyCoRilgOAZEE4KG1ZsUE67JBZL30U/ZdLd4=;
        b=cb8EVV31sz0vn6uI7EwrZpgUAartdT5vg3dtomLEaLwxtYXbKbhqC/K8eQS6F7+1Ci
         cLYl6v/kBc9SSeVBA5YjM9V2g7Axe3VBUL1pqNMGl3eT+GQA6xkRezggB6BB0/JCStWP
         d28CD2nTZDxwLvJP9ge8RzoIoz874CGGhVyXpc9Muosv2zQIcPQVBDCZAzcOPAdIClOY
         5rjtupEwXPwTO6Qpfy9YDSR5erLXMVOgALiXs8doc7HgW6y/ZljrJfB50HGi1ZMA3IMG
         4zt9sGkr8JRhrNYT9xuVXbzbXObt7RhEJT+j6HTtH9TOX3oNG/APMh1sIILZdp2zuScz
         Rgww==
X-Forwarded-Encrypted: i=1; AJvYcCWu64lkSb68ToAAISXcQYYtUq7OInEuSKtX8EnGHIP7CiF+1nntJm8FMcxB7jLjao95psr27aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5HYyBcgxOeIutPKDvfgvxZFH0DQAyoDzxSx9jpByzAOer0Ng
	R1qJ0wiVoES4rwspTyigJxeqd2GMM03FaRqoihnXxKDJTgP8mzqmqfZXVJGT2xnpd94=
X-Gm-Gg: ASbGncta++oP3uMEV0DQ2QFQ3fKFuopRVvpNHln7V9KfZ2lFsYS9LeXDfeYYXCwaDJZ
	VSC/FUhEQ3PU2JP4pCb88F+DWDObJ2Ew/a0RMssfZJ1C1qXFkzhS8B+c7ruNM0gunk37waNqpsW
	H8idZsf6nD1eWpZPkLfAG5lpwys1HxWZWG6XPUUdpHMJZjdOWsa4Ukqp/DB+r1E41zGq19REpQ1
	7aaxKCZkZUzDcljj8SzDNbAkSJSDazlgnZZwo+AUiNQZ4LsfioKq6SxUNR+26jMZlN3JyWz9QjX
	lXTUFNB+7BeTKt74ytzIhq68onBFsfdbFtSK8CtJDUANJEH1pCEPJiLo4Qwgr1ExFfcRnMBe6tw
	6o3Y8nx3y8DDT5Hpb3XTZHwIL1MTS
X-Google-Smtp-Source: AGHT+IEe9oiH/XW45dcZzWkk+b2BNMUc2j8IfiGoL68WhUG3Yi3uAEdxwgcuEWUTHnM1E0z8dGSjwg==
X-Received: by 2002:a17:907:72c4:b0:ad2:5499:7599 with SMTP id a640c23a62f3a-adfad320f66mr1273488466b.18.1750139876819;
        Mon, 16 Jun 2025 22:57:56 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81b8a3fsm793128166b.38.2025.06.16.22.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 22:57:56 -0700 (PDT)
Message-ID: <92580e9d-55c1-4298-ae7a-00726a727fb5@blackwall.org>
Date: Tue, 17 Jun 2025 08:57:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier = 0
To: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Stanislav Fomichev <sdf@fomichev.me>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-doc@vger.kernel.org
References: <1922517.1750109336@famine>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1922517.1750109336@famine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 00:28, Jay Vosburgh wrote:
> 	 Remove the ability to disable use_carrier in bonding, and remove
> all code related to the old link state check that utilizes ethtool or
> ioctl to determine the link state of an interface in a bond.
> 
> 	To avoid acquiring RTNL many times per second, bonding's miimon
> link monitor inspects link state under RCU, but not under RTNL.  However,
> ethtool implementations in drivers may sleep, and therefore the ethtool or
> ioctl strategy is unsuitable for use with calls into driver ethtool
> functions.
> 
> 	The use_carrier option was introduced in 2003, to provide
> backwards compatibility for network device drivers that did not support
> the then-new netif_carrier_ok/on/off system.  Today, device drivers are
> expected to support netif_carrier_*, and the use_carrier backwards
> compatibility logic is no longer necessary.
> 
> 	Bonding now always behaves as if use_carrier=1, which relies on
> netif_carrier_ok() to determine the link state of interfaces.  This has
> been the default setting for use_carrier since its introduction.  For
> backwards compatibility, the option itself remains, but may only be set to
> 1, and queries will always return 1.
> 
> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch
> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> 
> ---
>  Documentation/networking/bonding.rst |  79 +++----------------
>  drivers/net/bonding/bond_main.c      | 113 ++-------------------------
>  drivers/net/bonding/bond_netlink.c   |  11 +--
>  drivers/net/bonding/bond_options.c   |   7 +-
>  drivers/net/bonding/bond_sysfs.c     |   6 +-
>  include/net/bonding.h                |   1 -
>  6 files changed, 25 insertions(+), 192 deletions(-)
> 
[snip]
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index ac5e402c34bc..98f9bef61474 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -258,13 +258,8 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>  			return err;
>  	}
>  	if (data[IFLA_BOND_USE_CARRIER]) {
> -		int use_carrier = nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
> -
> -		bond_opt_initval(&newval, use_carrier);
> -		err = __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
> -				     data[IFLA_BOND_USE_CARRIER], extack);
> -		if (err)
> -			return err;
> +		if (nla_get_u8(data[IFLA_BOND_USE_CARRIER]) != 1)

you can set extack to send back an error to the user that use_carrier
is now obsolete

> +			return -EINVAL;
>  	}
>  	if (data[IFLA_BOND_ARP_INTERVAL]) {
>  		int arp_interval = nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
> @@ -676,7 +671,7 @@ static int bond_fill_info(struct sk_buff *skb,
>  			bond->params.peer_notif_delay * bond->params.miimon))
>  		goto nla_put_failure;
>  
> -	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
> +	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
>  		goto nla_put_failure;
>  
>  	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interval))

