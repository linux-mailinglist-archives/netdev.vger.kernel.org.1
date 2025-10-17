Return-Path: <netdev+bounces-230307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20DBE68B1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF36B62474D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410F30EF72;
	Fri, 17 Oct 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZKZ55eRj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524F30F54C
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681414; cv=none; b=FpI5Ms01PArucCQNDrN69IkF28Jz2DKN5qqkkSJEbIdZCUgI0X/hXF4Bsqx3SChv07AH+alIeXu2nXVptOoVAW9/6bVA6ZGbzfiV/L7L0pAKbhLMPSyQ65eOTjzQKYr90xNDOVldArEB2wh1hSm0h97yEpnQCJOcrmYuhIuW2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681414; c=relaxed/simple;
	bh=tzvj+dF7GYN05CycS5ptnofaexzJ2122giVs3WVtybQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGbQsh5xyO5jNzg7MnXWQ/pzhIAzGm0SvZrg9zXiZ788hyhjKCyb6CuNuC62C2CmWX9tYSh9WdraDFpDi7bCBPQrRM53rP6cn54Vi3BLlZ4lhfcKSW3R3zBBPWVwI870K/aNca3t7bZtli6KGruJ2QpiSvNHltGEeomR/CgpiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZKZ55eRj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b48d8deafaeso320860166b.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760681411; x=1761286211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6waZ7M3zINDb7ZucUBWuxq4+vcAnZAQSMKo/t03dBg=;
        b=ZKZ55eRjp2PPbtOSo/tCzyqUvdmFQ0hDpRxmcwnztEoih5nSOM68YyC609ljp1eocw
         4F41+AkJ9sVkyP93wQCR0Ohn63zepCFXW/2b0WjROi2gertFy9ByZXi+rVmvDHp74ML9
         7smAddL56WOWchBc7RRMhl8x3pzbvz5M0l5XCgFKJqtgV0ctEQiROIU7HyaZgHyzLzyX
         QceR3ZRLs9nNY7jMLu+h+M8DSE1j4d+FIcOYixDMVlKVfFfxYX1hd9kY0qiWIjNI4ha0
         x8XoRnSJHIY+xph0WtnBTQ5xe/gnrpH/hM8veNQVmyWDD/AhVsMTGbCq7QutlJ5ys6UT
         NJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681411; x=1761286211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6waZ7M3zINDb7ZucUBWuxq4+vcAnZAQSMKo/t03dBg=;
        b=kzSOAc4cF1ftG0HIbU7P4OAitBWd/9zXj/oRycSsPVedExOGeP/Tg7hbPmtoOCsabk
         QkuFwrRlFOzvyR/D1mNydhvkA7WsQH4NCNCLWbyfF8ZmgYoo+eRrFYExZ6FOKMufU0n6
         dmMPVRsp9/30y5t0pOQLqim1fzLzFqcsCTDYrsLwEnbjscO8vFTjAzScdS8idU32kAlH
         VACfGaO7csk4EK6UQ7GRCNfDLjM0+XJQUv4kbj6icvZfV7QEWp34/fXoIKuDxZkGCi9/
         p9gQlgOCEyLpoF2y6tKROhR5VxNI+21TcNykiZHVS4jLG92I2noKnofu+0x/xZLqxcpZ
         UFFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJHFmT6Fufta5ck5c5xNM/Ny5iciHsYC74NORvbFJRXRtQMW643gfpxAmTJj1Xei4yhSWFFRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVeS7Ddeo/PcqcA70gdrMK8KxpxSvl+WFoV2k/v6/IBeqNBY4v
	aF47JoFhXMfB+aLlBPpH83Xqw2AdezgSvWZ+gt6JlhYOkHElzfstaMU/z8hl/AJTLjo=
X-Gm-Gg: ASbGncvcmhh76idnYDPgekf/BXEHQaU/ffY9UhN9h3jO9n9FKxCV4n1/OS0qWfgKxrc
	8KVmGr73GyAqd7UeWpq0qHBC8UOU53BhX4ZE2ABD7FY1MfyrNGyA0PgqfewQ5P+Dme2YoFFRMBl
	ZI5iYKHqek/G+eAVQExcxUI0XJgqMRUFZ84/NN52ErI8VYpuO3E+w66PnNLuXClzE3Awr8sm3zV
	LnbAIu1zZJrnaF+VhiEMFqzdkIjyieC0ReyvOj2LlPoqmqA7F4Ps7HIprFv2fRVtblqcDohiS2K
	avyU2u2WLk3ntm02M/tVkGLw+qault0ci6KAnNTdyv2UPR1kLA7rzYhDpLeP7iuq2w965MmvCiv
	/ELAmGGSk1huqrgQXASitafmn72jd+0AUPpG6scu1tXQm6hPplZI2QR7kMldRnNk/XeVIm075kE
	g5wmejjhlcwDz0Ax4E/F/LnrGB+YdMz9+rceVLNYp7Ctk=
X-Google-Smtp-Source: AGHT+IECBBefYDxm3VztfrVoSJFgzWCxr6FwbCzBp/zx5ySKXbWRJApWHiTT/WyzbR2JJ2GvkAYP0A==
X-Received: by 2002:a17:907:fd15:b0:b47:de64:df34 with SMTP id a640c23a62f3a-b6474241266mr309874466b.51.1760681410460;
        Thu, 16 Oct 2025 23:10:10 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa2c8sm735915766b.46.2025.10.16.23.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:10:10 -0700 (PDT)
Message-ID: <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
Date: Fri, 17 Oct 2025 09:10:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
References: <20251017030310.61755-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251017030310.61755-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 06:03, Hangbin Liu wrote:
> Currently, there is no straightforward way to obtain the master/slave
> relationship via netlink. Users have to retrieve all slaves through sysfs
> to determine these relationships.
> 

How about IFLA_MASTER? Why not use that?

> To address this, we can either list all slaves under the bond interface
> or display the master index in each slave. Since the number of slaves could
> be quite large (e.g., 100+), it is more efficient to show the master
> information in the slave entry.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_netlink.c | 4 ++++
>  include/uapi/linux/if_link.h       | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 286f11c517f7..ff3f11674a8b 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -29,6 +29,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
>  		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
>  		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
>  		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
> +		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_SLAVE_MASTER */
>  		0;
>  }
>  
> @@ -38,6 +39,9 @@ static int bond_fill_slave_info(struct sk_buff *skb,
>  {
>  	struct slave *slave = bond_slave_get_rtnl(slave_dev);
>  
> +	if (nla_put_u32(skb, IFLA_BOND_SLAVE_MASTER, bond_dev->ifindex))
> +		goto nla_put_failure;
> +
>  	if (nla_put_u8(skb, IFLA_BOND_SLAVE_STATE, bond_slave_state(slave)))
>  		goto nla_put_failure;
>  
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 3b491d96e52e..bad41a1807f7 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1567,6 +1567,7 @@ enum {
>  	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
>  	IFLA_BOND_SLAVE_PRIO,
>  	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
> +	IFLA_BOND_SLAVE_MASTER,
>  	__IFLA_BOND_SLAVE_MAX,
>  };
>  


