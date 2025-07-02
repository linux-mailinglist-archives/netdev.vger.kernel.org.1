Return-Path: <netdev+bounces-203217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A003BAF0CD2
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC7B1C21EE3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528D222D795;
	Wed,  2 Jul 2025 07:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDFB1DF977;
	Wed,  2 Jul 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442167; cv=none; b=fb3Px1raxTPX2fXTL1ry3cCaV1N+nvzOCJZyum6JhqFLf7z8YTrLvLb1fVr5IaxzsuwyAHBtQUQNfkYsRW2CxevBR4/lQTX3Rdfd9Oi+8nm/oHZkprxEmEllIlBuNRfqnVvEBYUSmefn6usB7NhrREpu89b2Qwh5DahIdhQJGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442167; c=relaxed/simple;
	bh=5RD/hCbCr/sGytpploZW8IMrkvaWuftQdGAfxgLWjuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyXpJa/uf6GXOB4PzJ47zB2GNqfe4+0fGOZiJ4VkViGwOJxgS2AaeO8FvlY3OjSeTYm+Ov9pIR/ENULwxtbTbPJ4ZXNEp+jh0sLAIoAXB1wk3Z/mDW5eluPoGaSq98mRMOSA0Jkt+Lm6tqXGwyfnlTlTuQGyPsgDz35OUEV3Cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B25CB47204;
	Wed,  2 Jul 2025 09:42:41 +0200 (CEST)
Date: Wed, 2 Jul 2025 09:42:40 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
Message-ID: <vtgdrglnu52yech4p244ttzaqetooxphultqigf6dmytnfu6ky@rpx5cl3qmzec>
Mail-Followup-To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701140423.487411-1-g.goller@proxmox.com>
 <40dffba2-6dbd-442d-ba02-3803f305acb3@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40dffba2-6dbd-442d-ba02-3803f305acb3@6wind.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 01.07.2025 17:58, Nicolas Dichtel wrote:
>Le 01/07/2025 à 16:04, Gabriel Goller a écrit :
>> It is currently impossible to enable ipv6 forwarding on a per-interface
>> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
>> enable it on all interfaces and disable it on the other interfaces using
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to the
>> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
>> for all interfaces, while the interface-specific
>> `net.ipv6.conf.<interface>.forwarding` configures the interface
>> Host/Router configuration.
>>
>> Introduce a new sysctl flag `force_forwarding`, which can be set on every
>> interface. The ip6_forwarding function will then check if the global
>> forwarding flag OR the force_forwarding flag is active and forward the
>> packet.
>>
>> To preserver backwards-compatibility reset the flag (global and on all
>> interfaces) to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
>>
>> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>>
>> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
>> ---
>
>[snip]
>
>> @@ -896,6 +907,16 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
>>  						     NETCONFA_IFINDEX_DEFAULT,
>>  						     net->ipv6.devconf_dflt);
>>
>> +		/*
>> +		 * With the introduction of force_forwarding, we need to be backwards
>> +		 * compatible, so that means we need to set the force_forwarding global
>> +		 * flag to 0 if the global forwarding flag is set to 0. Below in
>> +		 * addrconf_forward_change(), we also set the force_forwarding flag on every
>> +		 * interface to 0 if the global forwarding flag is set to 0.
>> +		 */
>> +		if (newf == 0)
>> +			WRITE_ONCE(net->ipv6.devconf_all->force_forwarding, newf);
>Hmm, is this true? Configuring the default value only impacts new interfaces.
>And before your patch, only the 'all' entry is took into account. In other
>words, configuring the default entry today doesn't change the current behavior,
>so I don't see the backward compat point.

Yes, you're right I didn't think this through.
This only affects new interfaces.
I'll remove it.

>> +
>>  		addrconf_forward_change(net, newf);
>>  		if ((!newf) ^ (!old))
>>  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>
>[snip]
>
>> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
>> +					    void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int *valp = ctl->data;
>> +	int ret;
>> +	int old, new;
>> +
>> +	old = *valp;
>> +	ret = proc_douintvec(ctl, write, buffer, lenp, ppos);
>> +	new = *valp;
>Maybe you can limit values to 0 and 1, like it was done in the v1.

We use the extra1 and extra2 params for the interfaces when setting
interface-specific options, but I can just copy them out and then add
the min/max options to the table like in `addrconf_sysctl_mtu`.

I'll send a patch soon!

>Regards,
>Nicolas

Thanks for the review!


