Return-Path: <netdev+bounces-203265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD8AF1121
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DEE484188
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417224DCF6;
	Wed,  2 Jul 2025 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BGxsK39q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04181246BD9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450736; cv=none; b=LOqPbRMK3tO4kmSJtekHo/CQjLhTMvcE7i/JMvS2t21Jt/mT53y/YfcGBpU4X9hPeTcMA42R5QJ7VGo0t7UE0iyqnW7y3JTNZci3o0xv3IRYeqAmTCTP95xN8EOypRQRRwl7DVTBRHRTukBvnrI/kqfCf05np68P8pf81gZh2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450736; c=relaxed/simple;
	bh=/odDKUbMEXHb8YPMgH2eLGCrRUFAWoeTkGz9mBkC5Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP3H30LsTZmSEUkHE2rxPJ0gIT/DjxY8vBXGhDbsseyLC0a3tvtPZm3f9Zr5zn/yI0I4xx0tBqAsUpG50zQvrmwpIh+7Bqdjk1vcoxgBBmx0qyurkcNUszV3DOs8LO3ZU/v3uwR9rI4KPyXXMqfe3etlYcEgz+Qn8CDHl/IS0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BGxsK39q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453079c1e2eso7463645e9.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751450732; x=1752055532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jge/315nZmEr34QaqRg13k9ENVxZ/tBr+eglZFNGido=;
        b=BGxsK39q6HlSq5lD/xVCPlwrLgbplvcfaNL9uBz6yF8r8zbqGQhlfUA5DXLXtL0Snx
         046iUZncJRrVFYyBZYucf5Fx4cFJh1m2ZhMqYVpZQCHX2PImREFO312YUFMy8pMnkg5u
         +qw02de1oQGX/Od2FJOuTb9148j2awPyxgSsB9encjnwLpqRydIRUvP6wBcgZ9ZQex3Z
         zGDoa4tvj1NRdBWCtae9+I4JDlPRriN56OimNMgXAwrgLGwPLHs8DDQ0MHXr+tNqT/sd
         wE5Wd4MeoWNJaXtQy85ltwnQfFbiK70ynox3wh4MjvzJs7MZ6hMzMnqQ6aa3T5Dcp8nV
         UlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450732; x=1752055532;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jge/315nZmEr34QaqRg13k9ENVxZ/tBr+eglZFNGido=;
        b=LwUCN/xdkowVl8/xKL+Gyf7e2VTzq/lW8yCqh8ruFhTLkzqt4XdyOEZSJi6okPpxrU
         brEV721QAEFKjrpjknR7fLIUdZjGwSYaJVC14uYyZXHa/i/8p9qGEJgn+mAhH8Qy1cW6
         rNQ/x8xf5iLDb7y6q40778FZn7XHLk33GlJRvhhYKcheoMyHFKH9C0OnjORmWtm4djkj
         aKLxvGqfYwH0N3D32FGUp96QS7Cgc1dKvJGBJr8SxRNn3/QFVi9WjwQ57CjipX0QiXfF
         wPF4owOrIRE21eKNPXxAAeNB7CpGKlPd3AJ8slB30ZB3bbnGN8+dxGQaUnb/7djJHwSK
         Povw==
X-Gm-Message-State: AOJu0YxxhNpCagJfEwDaQouDK1nQuiWpxBsTmA7BVnfVw6ItK1wJBAdw
	//60maoLfY0qjD3G/tuvyBm3w96FpnMflgVh4MfYZvpNSYqv/NGdkfOtYp4jfvcy2Sw=
X-Gm-Gg: ASbGncufRPaiGSPaNffW/IKHKqXfpkVLeJVMc+ibWRUqhrWQWFN49T1r73QYC57SFZv
	efgOcMedg4tb6xsyD3xm/ZaObxLRLsmmWtvJ1tLn+06S3NsVrLSwsWfKZPDdlPyL2JDwn9IE9lh
	vJjOLtO6/9MN7Nyf8m44UQvvev7hp5bV8Sbv4vvPDyoKiPDTiga3p9BBPrH/L4Ql8Boc4+jubij
	ZDHJZaqCjBlVvxktCEfMYYvSSR6ys5fAI5OtHi0VeYZDzTrLyLwEsvufXX4UwdK1z1H45VvWAnP
	a0GyMbxhEpp/q0HVlxAYEOgxyNR8WbxTYihi0egY5/pQEdtV9IFqieP8QLXlP6sHiHDnPU8LqQZ
	QKh2If/+rzbBu220hucTQ1l/JaD5mx2I/ezqa+4U=
X-Google-Smtp-Source: AGHT+IHl6GEGttPh0i4rVP4SmhL82lbxdawS1oN4zDLT3XLS5VSAgR8qS48eCoKhOKWSCmnAPDEk0g==
X-Received: by 2002:a05:600c:46d1:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-454a3706e3amr8521565e9.5.1751450732227;
        Wed, 02 Jul 2025 03:05:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:5568:c43d:79bc:c2ec? ([2a01:e0a:b41:c160:5568:c43d:79bc:c2ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a72dasm192919735e9.16.2025.07.02.03.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 03:05:31 -0700 (PDT)
Message-ID: <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
Date: Wed, 2 Jul 2025 12:05:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250702074619.139031-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 02/07/2025 à 09:46, Gabriel Goller a écrit :
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
> To preserver backwards-compatibility reset the flag (on all interfaces)
> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
> 
> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
> 
Please, wait 24 hours before reposting.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n419


[snip]

> @@ -6747,6 +6759,77 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
>  	return ret;
>  }
>  
> +/* called with RTNL locked */
Instead of a comment ...

> +static void addrconf_force_forward_change(struct net *net, __s32 newf)
> +{
> +	struct net_device *dev;
> +	struct inet6_dev *idev;
> +
... put

	ASSERT_RTNL();

> +	for_each_netdev(net, dev) {
> +		idev = __in6_dev_get_rtnl_net(dev);
> +		if (idev) {
> +			int changed = (!idev->cnf.force_forwarding) ^ (!newf);
> +
> +			WRITE_ONCE(idev->cnf.force_forwarding, newf);
> +			if (changed) {
> +				inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
> +							     NETCONFA_FORCE_FORWARDING,
> +							     dev->ifindex, &idev->cnf);
> +			}
> +		}
> +	}
> +}
> +
> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
> +					    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int *valp = ctl->data;
> +	int ret;
> +	int old, new;
> +
> +	// get extra params from table
/* */ for comment
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n598

> +	struct inet6_dev *idev = ctl->extra1;
> +	struct net *net = ctl->extra2;
Reverse x-mas tree for the variables declaration
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n368

> +
> +	// copy table and change extra params to min/max so we can use proc_douintvec_minmax
> +	struct ctl_table lctl;
> +
> +	lctl = *ctl;
> +	lctl.extra1 = SYSCTL_ZERO;
> +	lctl.extra2 = SYSCTL_ONE;
> +
> +	old = *valp;
> +	ret = proc_douintvec_minmax(&lctl, write, buffer, lenp, ppos);
> +	new = *valp;
I probably missed something. The new value is written in lctl. When is it
written in ctl?

> +
> +	if (write && old != new) {
> +		if (!rtnl_net_trylock(net))
> +			return restart_syscall();
> +
> +		if (valp == &net->ipv6.devconf_dflt->force_forwarding) {
> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     NETCONFA_IFINDEX_DEFAULT,
> +						     net->ipv6.devconf_dflt);
> +		} else if (valp == &net->ipv6.devconf_all->force_forwarding) {
> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     NETCONFA_IFINDEX_ALL,
> +						     net->ipv6.devconf_all);
> +
> +			addrconf_force_forward_change(net, new);
> +		} else {
> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     idev->dev->ifindex,
> +						     &idev->cnf);
> +		}
> +		rtnl_net_unlock(net);
> +	}
> +
> +	return ret;
> +}
> +
>  static int minus_one = -1;
>  static const int two_five_five = 255;
>  static u32 ioam6_if_id_max = U16_MAX;

