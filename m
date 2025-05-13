Return-Path: <netdev+bounces-190104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D314AB5302
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E55D18975D2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8391E9B1A;
	Tue, 13 May 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kSYMCRbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001851EB5D0
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132682; cv=none; b=GJ0TkWCurSpVZTmv9e8pZxMTB0TD4MkjW1tsri5ti9a9krOn74O6g1pufOubZXFo9To3+Xeyh90U0zgqaF5pLRJkUsVWNqFYAVl9zHGfgFF6431kD0xEpGzho9Db6ULBNTiALRM9fq+2dwLinsC4phkNrgpWqOqnrYPqjX08NCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132682; c=relaxed/simple;
	bh=FqN/Fo9+LKwUTLI0alHPRDvl5SrukKcjU9zic7WhYTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh5MkY2Pxswwidyx0oNeeJI3XPvniT1cwRosCCPrD3eGOq3blnGCcco3Y2UgrI6vNr3/AR6I/6wbTqBUHqfTwsDaVGKoVSLJLAoa251dmZ7A+ylzMB1KdOCfN2E2ZOe41jM4FWkLZ/c7Whqxt4u3GB0pBxUG1JRDeXfF5cVRfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=kSYMCRbX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fc7edf00b2so7501536a12.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747132679; x=1747737479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgjbk4WeES6WO2sV0D94KvrO2p9sXdkDbOYK1jxxPFM=;
        b=kSYMCRbXCNsSiKwBWXI8IwQxmR8m8SBEeyHSjisW2tmeCsCYmrI+8t4xeF2B4QA8JJ
         1JoVmUnP26kptOfgRD+Mj0TrZ1McMJqyeupjq7sBq8KS9xUnmMZhhoATIMBHbf76UFJL
         g7Xj/pLo3eWYImoCOZ9Mi/f3GR41618bH+ItmQWJJ18Do226rAbgFnWykfG0R/OIl4de
         yJg725BIesvi1Pd/1H5KdmnC3nc2GvVFAsQMEBmsUzrHZiC4kha+w2/th76rPh4Cshfz
         aNtuqP0PpsMubJ5Ldx31DIBf4ypk53pR/WKtkt2X0U01oZzGmlmdFkReghWtQyJJctB2
         qyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132679; x=1747737479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgjbk4WeES6WO2sV0D94KvrO2p9sXdkDbOYK1jxxPFM=;
        b=gOOkZz0z1JMpdzhfYyBQ3tzKEaJlN8BOYlpRE2Q4/7597eFpO7Ke+Z7N3asa1fxlVC
         rFJm1EX21ye/5FlrIc1UYWuaSQBpCYW7KmFWqn5JHwJuVhpNfpVbbRqoThsE0KODy7zI
         lqiHn0i4W3syU+nUt4URTPj1uAYGBah1WGdEM5rcdwMZ7xlQqP3aKWs/XwzJyYLlPozu
         dAeH6kIe0hgi31gVQptZlUeQsRgWYLzSTtxVOmwPQUdXknZ9Od7k3KvjzqRUxq36brQO
         nNvzcuR8dlNXL95V4KfJJxGUCvyei443pH1eYM/RxD/zR7GSngdjskdYpS7xN4rL4M1j
         2l5g==
X-Forwarded-Encrypted: i=1; AJvYcCV7oUnByJYttcbo6o1xIxp3QAkbc8VicoRRdsCb+p3iRUlQuE2qXcwihrLycYuAk+wz/QMFdKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmb4QwWIxfRBVVGgZU6Ke7TuqmjtmNmSVotl8WjvWGhTYSMUSy
	dkVkAfpoyn21nWcMXXzOCN32CgrVvtaZ889bVc7nW+MLIoJXTrB5II4HmPDN+HI=
X-Gm-Gg: ASbGncsH0JvcBE5TwJiTl4UGDj5D4VVFphZFjsMKi1rO6dne/Ynac7Pc3E/mVSoW1/I
	edfaMK6N+wieTOMCHKmw3Jbr8herS5I4G0CE4APIkhY8cPEGy28+Zq5KiftpsyfONHKPpesLNjd
	RamcbVpoaew6CUmoVgHx+RcLB1PSCRzf1ZWnGsqg+SvWtqx2xKZyuSky5fb9ypJPTjShve/jOga
	v/U5o+J4m62y07i437VEHoVR3zmHpkD6mFj+40945kZuwYpXXAIk0T1VPa/jzBZbiuff1x/JRCZ
	ziUW+9vs2TiiTgYGLzmudOgUI+yUbxx4IYv2TDzQ4vk7L7zBR1o1OAW7UoQALSWXEgxF19Yv00A
	2FQtuY7E=
X-Google-Smtp-Source: AGHT+IHKcysvJC+Oy+VUNaGAFbGnRZGaggSsyAGiqyBYD6ep8PVlWf4F/OZEgO0Ov3x8/78Z3HeN7g==
X-Received: by 2002:a05:6402:27d3:b0:5fa:a42f:70ee with SMTP id 4fb4d7f45d1cf-5fca035da3cmr13768657a12.0.1747132679145;
        Tue, 13 May 2025 03:37:59 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70f51esm6977565a12.79.2025.05.13.03.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:37:58 -0700 (PDT)
Message-ID: <b7a91eeb-4bf4-4bb7-ab2b-aa4b03ebcf70@blackwall.org>
Date: Tue, 13 May 2025 13:37:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] net: bonding: send peer notify when
 failure recovery
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
 <F5D495B5C2A94D9F+20250513094750.23387-4-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <F5D495B5C2A94D9F+20250513094750.23387-4-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 12:47, Tonghao Zhang wrote:
> After LACP protocol recovery, the port can transmit packets.
> However, if the bond port doesn't send gratuitous ARP/ND
> packets to the switch, the switch won't return packets through
> the current interface. This causes traffic imbalance. To resolve
> this issue, when LACP protocol recovers, send ARP/ND packets.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
>  Documentation/networking/bonding.rst |  5 +++--
>  drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
>  drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
>  3 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index 14f7593d888d..f8f5766703d4 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -773,8 +773,9 @@ num_unsol_na
>  	greater than 1.
>  
>  	The valid range is 0 - 255; the default value is 1.  These options
> -	affect only the active-backup mode.  These options were added for
> -	bonding versions 3.3.0 and 3.4.0 respectively.
> +	affect the active-backup or 802.3ad (broadcast_neighbor enabled) mode.
> +	These options were added for bonding versions 3.3.0 and 3.4.0
> +	respectively.
>  
>  	From Linux 3.0 and bonding version 3.7.1, these notifications
>  	are generated by the ipv4 and ipv6 code and the numbers of
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..d1c2d416ac87 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
>  	return 0;
>  }
>  
> +static void ad_cond_set_peer_notif(struct port *port)
> +{
> +	struct bonding *bond = port->slave->bond;
> +
> +	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
> +		bond->send_peer_notif = bond->params.num_peer_notif *
> +			max(1, bond->params.peer_notif_delay);
> +		rtnl_unlock();
> +	}> +}
> +
>  /**
>   * ad_mux_machine - handle a port's mux state machine
>   * @port: the port we're looking at
> @@ -2061,6 +2072,8 @@ static void ad_enable_collecting_distributing(struct port *port,
>  		__enable_port(port);
>  		/* Slave array needs update */
>  		*update_slave_arr = true;
> +		/* Should notify peers if possible */
> +		ad_cond_set_peer_notif(port);
>  	}
>  }
>  
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 8ee26ddddbc8..70bb1e33cee2 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1243,17 +1243,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
>  /* must be called in RCU critical section or with RTNL held */
>  static bool bond_should_notify_peers(struct bonding *bond)
>  {
> -	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
> +	struct bond_up_slave *usable;
> +	struct slave *slave = NULL;
>  
> -	if (!slave || !bond->send_peer_notif ||
> +	if (!bond->send_peer_notif ||
>  	    bond->send_peer_notif %
>  	    max(1, bond->params.peer_notif_delay) != 0 ||
> -	    !netif_carrier_ok(bond->dev) ||
> +	    !netif_carrier_ok(bond->dev))>  		return false;
>  
> +	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
> +		usable = rtnl_dereference(bond->usable_slaves);

If mii monitor is enabled in 802.3ad bond mode then this will be 
dereferenced in bond_mii_monitor() with rcu, so you'd have to use
rcu_dereference_rtnl() instead.

> +		if (!usable || !READ_ONCE(usable->count))
> +			return false;
> +	} else {
> +		slave = rcu_dereference_rtnl(bond->curr_active_slave);
> +		if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
> +				       &slave->dev->state))
> +			return false;
> +	}
> +
>  	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
> -		   slave ? slave->dev->name : "NULL");
> +		   slave ? slave->dev->name : "all");
>  
>  	return true;
>  }


