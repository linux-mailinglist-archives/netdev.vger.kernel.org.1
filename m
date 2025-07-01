Return-Path: <netdev+bounces-202961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC7AEFEC3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C81BC8291
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748AD27AC3E;
	Tue,  1 Jul 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NyELBZvB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472E27B4F2
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385530; cv=none; b=XeSUwZUPoVygdXaOQ0Y/JbCQHdT13qyPIUPLfwl/6AN3RB9NYYGxqocgYuk1rOq1O/dzP9LdxWioS2DxPk8REA11sMz8lT/sCj9r4e/1hP/ujEos2Lj998SM89XeEKUcmi2vE4BTavO0jzjX47rq6TYsZfjNtT/6II/GMSuT4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385530; c=relaxed/simple;
	bh=QSAY2cavr+hAtXa06F5WuFx/c09q1MQ9F8YFB1GGlxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRiyHZMg9FXPKof2T/5UynUSHaMl0600u6ChnpnOTOuPrd+tTXW8/lf/2JTyuN2VbQN5fQwDeJdVq3+Tv8KAyUNWsOwr+keS/iLUOCjv8a8NwHqT/2uY+eLxtYZKHQToJyFEn0VjgubhkWSRbQ9e2xWT+KXjFW/EsWEnklzBSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NyELBZvB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso909734f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751385527; x=1751990327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YhrekkuV81u85I0nCYoyFYWO/iQISbDoWTniOveqI+w=;
        b=NyELBZvBrHycyMWM1vTcTDddjbbJVdm+b9HYHFBktbGVHdgTePCtzZDjdWdV0Ah/vP
         Q8fesE9oqpdkA7Ji74z/t90QaVhzuWwBGuSIlckEazZAcDawlnZ8nC0LZh/g9PClw9tp
         RwQzM4D0qJc4X9jXzBDRTPdqjhcG/2u6YqrIDJjDTLqoUWRT3uyIMHZaVw+D1ZCdH698
         loQPti7htEhOEY+VlDX23yS0LPjzApS110pi5jw/PYUkCcYoQLF4NDwaX8BI3jFQg0uq
         u4n4rQ5XyXSJb+foXeXFBZEUNVQcIC6yLUlitTaQExoahg2msvRohSdiUkxrT59GeSMt
         iMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385527; x=1751990327;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhrekkuV81u85I0nCYoyFYWO/iQISbDoWTniOveqI+w=;
        b=I0ScY198/PHbTmcvyJD3hQsbcGPNTEgy1ZaEFMKEbli6namRyoVExSHKqVukAnyvxS
         nRxOwnUm+mdCgbLo26VRtQ8Sl83j8xpYe0krbgLpUklPn3nX05k/RNBLzj1cT+1TK9it
         kvMp6/5IdXYPi45gda2Ab1qefc12yjTyPI8Ic8fuAUW6YRwbGtVFXXwC9Z272FKWUBKi
         fRXpmAo1g4Xy2KXgfs4ui1MeGtnvqonBfVR6IeR+V77BxFVXcYrBeoizKjA6DGtJf3Zt
         xoOc6QV0WgDQlAjr76g9oW8i5fGIOHpp6sihX4Bh5dVL3DrXQYNIR6m+hk2bvxx1h31x
         4f6A==
X-Gm-Message-State: AOJu0Yyq2WoOujihOwxLL67JNIzvox0LIXJv0qRmNXUqcusVIhEnPK7d
	dvYwoC+7+e5XypVSmedllginr+CCMCK8Nl1VGmED7BRsC3dehYnAAWxQay4RJ/QssFxd3vZ2UUE
	Ixp8jlmg=
X-Gm-Gg: ASbGncvvnPdhLadqMeh/IFagXBGN5zWa+TYLGrB24ivdoycjYuGSn0d5rninsUzsU+/
	csa8qIQ+cQc8xxzoLXavQ9sJV4TU3JcHmq/PksfO6rtSkBsooZZSM05ZghpeO/l8IgCg6O44Hey
	fzlb116S0jouifcLhcPrK+k3/n0nXN1Ket7Z63T8f82fOymgvWgHhIkY9EXA8WT8aDcQodFQwCs
	FMB0cL4HXMB/Fcl9J5UCezwMyTHuBNNQF++i4ee2+SuOTLyFrbgh2nwzudvhyCleLhHnvBsCOw/
	rWAL5mBkASy6PezixEEW6VvxVHzyuLuZWrJA2TnXvrvQpfeiUVbxqSUPqshbgH3KJJ3W4jVPqou
	H6R7QJhA5hb6q/o0JVPYF1l3l1+Wl2f70+J/T
X-Google-Smtp-Source: AGHT+IEgqW2tesitKhmnUcBygNXVUscrvykBlr5WbS8x1oTHDseSXjU/Z8mwQaDABjFVm8GOa4CGSA==
X-Received: by 2002:a05:6000:18a9:b0:3a4:f912:86af with SMTP id ffacd0b85a97d-3af23ad08d1mr1306061f8f.2.1751385526598;
        Tue, 01 Jul 2025 08:58:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:3c4c:7e68:5ff:ce49? ([2a01:e0a:b41:c160:3c4c:7e68:5ff:ce49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c523sm198939125e9.6.2025.07.01.08.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:58:45 -0700 (PDT)
Message-ID: <40dffba2-6dbd-442d-ba02-3803f305acb3@6wind.com>
Date: Tue, 1 Jul 2025 17:58:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250701140423.487411-1-g.goller@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250701140423.487411-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 01/07/2025 à 16:04, Gabriel Goller a écrit :
> It is currently impossible to enable ipv6 forwarding on a per-interface
> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
> enable it on all interfaces and disable it on the other interfaces using
> a netfilter rule. This is especially cumbersome if you have lots of
> interface and only want to enable forwarding on a few. According to the
> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
> for all interfaces, while the interface-specific
> `net.ipv6.conf.<interface>.forwarding` configures the interface
> Host/Router configuration.
> 
> Introduce a new sysctl flag `force_forwarding`, which can be set on every
> interface. The ip6_forwarding function will then check if the global
> forwarding flag OR the force_forwarding flag is active and forward the
> packet.
> 
> To preserver backwards-compatibility reset the flag (global and on all
> interfaces) to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
> 
> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---

[snip]

> @@ -896,6 +907,16 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
>  						     NETCONFA_IFINDEX_DEFAULT,
>  						     net->ipv6.devconf_dflt);
>  
> +		/*
> +		 * With the introduction of force_forwarding, we need to be backwards
> +		 * compatible, so that means we need to set the force_forwarding global
> +		 * flag to 0 if the global forwarding flag is set to 0. Below in
> +		 * addrconf_forward_change(), we also set the force_forwarding flag on every
> +		 * interface to 0 if the global forwarding flag is set to 0.
> +		 */
> +		if (newf == 0)
> +			WRITE_ONCE(net->ipv6.devconf_all->force_forwarding, newf);
Hmm, is this true? Configuring the default value only impacts new interfaces.
And before your patch, only the 'all' entry is took into account. In other
words, configuring the default entry today doesn't change the current behavior,
so I don't see the backward compat point.

> +
>  		addrconf_forward_change(net, newf);
>  		if ((!newf) ^ (!old))
>  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,

[snip]

> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
> +					    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int *valp = ctl->data;
> +	int ret;
> +	int old, new;
> +
> +	old = *valp;
> +	ret = proc_douintvec(ctl, write, buffer, lenp, ppos);
> +	new = *valp;
Maybe you can limit values to 0 and 1, like it was done in the v1.


Regards,
Nicolas

