Return-Path: <netdev+bounces-203766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50316AF71B4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F720524BB0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148A2F872;
	Thu,  3 Jul 2025 11:04:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DF1CD1F;
	Thu,  3 Jul 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540677; cv=none; b=B+rjkfKA/3M40MhfaGIi1HFISoKW8zXKueK1z68Bq6D7lFlhR5ekjXvxhG/eskP4Kx+znPJeHQlFy4qAdnU5s+iOcu8g+fl9DWOW0xZObw3LljQs9LHb0H39dckGk//7aHKULeYXdHLB4thbZs0PCrWFgx5R2Vwe9kkIOWXr474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540677; c=relaxed/simple;
	bh=fQgz2ZgePgB80oVHLAHP3TWpAM5CNA8RBk4IulMuSYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgZ85xEZXkSk+Rvyyi+IA89USjZb/SQyEUNVk98HbPO5JNqUeDgBNrBfaopEP7JrjWs2lU7BEvsh4uGVJto7GUudV2cz77CGK9dvXzvXhmJuy2r7eI5HqP1nrQ0hUQoz+BPubfUpKKHzBw97jxEsYoeC4dHlHbfGwn/vycqUxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EE6C7479E1;
	Thu,  3 Jul 2025 13:04:25 +0200 (CEST)
Date: Thu, 3 Jul 2025 13:04:24 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
Message-ID: <jsfa7qvqpspyau47xrqz5gxpzdxfyeyszbhcyuwx7ermzjahaf@jrznbsy3f722>
Mail-Followup-To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 02.07.2025 12:05, Nicolas Dichtel wrote:
>Le 02/07/2025 à 09:46, Gabriel Goller a écrit :
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
>> To preserver backwards-compatibility reset the flag (on all interfaces)
>> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
>>
>> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>>
>> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
>> ---
>>
>Please, wait 24 hours before reposting.
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n419

Ah, my bad, thought I posted v2 in the morning as well :(

>[snip]
>
>> @@ -6747,6 +6759,77 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
>>  	return ret;
>>  }
>>
>> +/* called with RTNL locked */
>Instead of a comment ...
>
>> +static void addrconf_force_forward_change(struct net *net, __s32 newf)
>> +{
>> +	struct net_device *dev;
>> +	struct inet6_dev *idev;
>> +
>... put
>
>	ASSERT_RTNL();
>

Agree.

>> +	for_each_netdev(net, dev) {
>> +		idev = __in6_dev_get_rtnl_net(dev);
>> +		if (idev) {
>> +			int changed = (!idev->cnf.force_forwarding) ^ (!newf);
>> +
>> +			WRITE_ONCE(idev->cnf.force_forwarding, newf);
>> +			if (changed) {
>> +				inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
>> +							     NETCONFA_FORCE_FORWARDING,
>> +							     dev->ifindex, &idev->cnf);
>> +			}
>> +		}
>> +	}
>> +}
>> +
>> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
>> +					    void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int *valp = ctl->data;
>> +	int ret;
>> +	int old, new;
>> +
>> +	// get extra params from table
>/* */ for comment
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n598

NAK
(https://lore.kernel.org/lkml/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/#r)

But I'll capitalize the first word.

>> +	struct inet6_dev *idev = ctl->extra1;
>> +	struct net *net = ctl->extra2;
>Reverse x-mas tree for the variables declaration
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n368

Done.

>> +
>> +	// copy table and change extra params to min/max so we can use proc_douintvec_minmax
>> +	struct ctl_table lctl;
>> +
>> +	lctl = *ctl;
>> +	lctl.extra1 = SYSCTL_ZERO;
>> +	lctl.extra2 = SYSCTL_ONE;
>> +
>> +	old = *valp;
>> +	ret = proc_douintvec_minmax(&lctl, write, buffer, lenp, ppos);
>> +	new = *valp;
>I probably missed something. The new value is written in lctl. When is it
>written in ctl?

Ah, sorry there is something missing here.

This is supposed to look like this:

	struct inet6_dev *idev = ctl->extra1;
	struct net *net = ctl->extra2;
	int *valp = ctl->data;
	loff_t pos = *ppos;
	int new = *valp;
	int old = *valp;
	int ret;

	struct ctl_table lctl;

	lctl = *ctl;
	lctl.extra1 = SYSCTL_ZERO;
	lctl.extra2 = SYSCTL_ONE;
	lctl.data = &new;

	ret = proc_douintvec_minmax(&lctl, write, buffer, lenp, ppos);
	
	...

	if (write)
		WRITE_ONCE(*valp, new);
	if (ret)
		*ppos = pos;
	return ret;


>> +
>> +	if (write && old != new) {
>> +		if (!rtnl_net_trylock(net))
>> +			return restart_syscall();
>> +
>> +		if (valp == &net->ipv6.devconf_dflt->force_forwarding) {
>> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>> +						     NETCONFA_FORCE_FORWARDING,
>> +						     NETCONFA_IFINDEX_DEFAULT,
>> +						     net->ipv6.devconf_dflt);
>> +		} else if (valp == &net->ipv6.devconf_all->force_forwarding) {
>> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>> +						     NETCONFA_FORCE_FORWARDING,
>> +						     NETCONFA_IFINDEX_ALL,
>> +						     net->ipv6.devconf_all);
>> +
>> +			addrconf_force_forward_change(net, new);
>> +		} else {
>> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>> +						     NETCONFA_FORCE_FORWARDING,
>> +						     idev->dev->ifindex,
>> +						     &idev->cnf);
>> +		}
>> +		rtnl_net_unlock(net);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int minus_one = -1;
>>  static const int two_five_five = 255;
>>  static u32 ioam6_if_id_max = U16_MAX;

Thanks for the review!


