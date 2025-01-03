Return-Path: <netdev+bounces-154981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68523A008CA
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3623716211C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB31F941B;
	Fri,  3 Jan 2025 11:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD31B87F3
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904487; cv=none; b=OeU5WAJ7hmSJLh546dicHhCUj44r8E3optKVTA6B25D0yfpVna8zT9O7rte5H8blouMg7P1MMoF+f1DYVW/TweJdYA+HsVT9aZl4TUMGs9zDWuqV7hS/502ElNoEXlbxbrdjyyf38OX6XNYAtxXhl/zi9ucVUri7CX3NWQtdxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904487; c=relaxed/simple;
	bh=tbHx2sZ9HwC4VuBmxauxzHxHl87uINyCB2nyxHLw8FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6jTWrWBtgPoKgk2cgHhU1OOagJrf7bDI17RMW2WNPFLyyAPVlxRwnzFmMtYwLDVz2LCyrek0BUmgsW1z8+BJgMDQGMcNDmUfFHvA5Fhz4Oz50gBRDg0t6as+SoTF3OGkqHsKe4sAfqDPY3rWlwV1rnTLHialopFOZPpV4QsqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso20131286a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 03:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904480; x=1736509280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TipG4wrwzpQ5zjZebGL+fg83+D4HToB3QQ5DA7PZrr8=;
        b=YPgERaZX7P96MWCBIxhuzV+CWgloB0L9S/YxXuvhDwINpjborZBOIBIbGwkI55DZuu
         z6oJAMpk/+MeIWOT0yqy5JnsamOSPWZaqYUooS1jxY0RYVNrylimhM4ui4q0RLSdlBYP
         +FuiqtPDp439aiHVv3oKrD1QCwjHA0u4fMVx72POYTBAJ3TRlPdzf96eMgc2BJP1/NDG
         uug8mgLQ7mBrtiY7EMIhBAJzEZixypX2sQL7YqMh5PyM4LJ/Y4ZNWL1uxvxoPtaE3Ogz
         T5o3WrREWZBt0K9fwOh6T5fmWjscuvQxcMMWMqhFVvS883eU5zwiwwUNOaNnv6Mvt9GA
         hU9g==
X-Forwarded-Encrypted: i=1; AJvYcCUSZcJ3K7KUq69mmBFUjHCyh67mV47n2II+6PsZ/Uw6Jk53U6Td3lQdDgbmCz1p7xeT7pmnoVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy496V5VcJ4TdxK5TBMZUN0D/5cBO0ODTAbIzO52Qwcmnpsn9oA
	Csj/uOfKutpCKzNiQnnguZcZwbNuQx2NvNXEqp/d4wp9tTdoR7Bq
X-Gm-Gg: ASbGncuK9KeZTHduZdUedOABODpSzzsdgqwTJyBfBOCPu71FYpocojVcHVk1pLTN4gD
	dLdyq7oJyCkGrZ55DmYq9hSPjiUd9wagJfHLENsNm14+5Q6YRQETmbznrysz7psq1D+Go5DghJc
	d29/9wQT/lUiB6O0zf2sTqAUGQGSKpkbpNrovg3sKV0xBLiHd337RLhkHG3g4WI+MKQp0l+Qv1Z
	ueXfuNy7jdEO9aBOffTyv+j7DUtsly39o9D5hpC1fqWiXU=
X-Google-Smtp-Source: AGHT+IF1S2f5vFfMZdpiAdJ/JCNUPkTXnMlVxIuzIygCfUfwXXbrV8S9HCFakqvLIHnrsPdsG7FV7w==
X-Received: by 2002:a50:cc48:0:b0:5d3:cf89:bd3e with SMTP id 4fb4d7f45d1cf-5d81de1c92cmr92960385a12.30.1735904480035;
        Fri, 03 Jan 2025 03:41:20 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e894b60sm1914772666b.68.2025.01.03.03.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:41:19 -0800 (PST)
Date: Fri, 3 Jan 2025 03:41:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <20250103-loutish-heavy-caracal-1dfb5d@leitao>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211021851.1442842-1-ushankar@purestorage.com>

Hello Uday,

On Tue, Dec 10, 2024 at 07:18:52PM -0700, Uday Shankar wrote:
> Currently, netconsole has two methods of configuration - kernel command
> line parameter and configfs. The former interface allows for netconsole
> activation earlier during boot, so it is preferred for debugging issues
> which arise before userspace is up/the configfs interface can be used.
> The kernel command line parameter syntax requires specifying the egress
> interface name. This requirement makes it hard to use for a couple
> reasons:
> - The egress interface name can be hard or impossible to predict. For
>   example, installing a new network card in a system can change the
>   interface names assigned by the kernel.
> - When constructing the kernel parameter, one may have trouble
>   determining the original (kernel-assigned) name of the interface
>   (which is the name that should be given to netconsole) if some stable
>   interface naming scheme is in effect. A human can usually look at
>   kernel logs to determine the original name, but this is very painful
>   if automation is constructing the parameter.

Agree, and I think this might be a real problem. Thanks for addressing it.

> For these reasons, allow selection of the egress interface via MAC
> address. To maintain parity between interfaces, the local_mac entry in
> configfs is also made read-write and can be used to select the local
> interface, though this use case is less interesting than the one
> highlighted above.

This will change slightly local_mac meaning. At the same time, I am not
sure local_mac is a very useful field as-is. The configuration might be
a bit confusing using `local_mac` to define the target interface. I am
wondering if creating a new field might be more appropriate. Maybe
`dev_mac`? (I am not super confident this approach is better TBH, but, it
seems easier to reason about).

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 4ea44a2f48f7..865c43a97f70 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c

> @@ -211,6 +211,8 @@ static struct netconsole_target *alloc_and_init(void)
> +	/* the "don't use" or N/A value for this field */

This comment is not very clear. What do you mean exactly?

> +	eth_broadcast_addr(nt->np.local_mac);

Why not just memzeroing the memory?

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 2e459b9d88eb..485093387b9f 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -501,7 +501,8 @@ void netpoll_print_options(struct netpoll *np)
>  		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
>  	else
>  		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
> -	np_info(np, "interface '%s'\n", np->dev_name);
> +	np_info(np, "interface name '%s'\n", np->dev_name);
> +	np_info(np, "local ethernet address '%pM'\n", np->local_mac);
>  	np_info(np, "remote port %d\n", np->remote_port);
>  	if (np->ipv6)
>  		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
> @@ -570,11 +571,20 @@ int netpoll_parse_options(struct netpoll *np, char *opt)
>  	cur++;
>  
>  	if (*cur != ',') {
> -		/* parse out dev name */
> +		/* parse out dev_name or local_mac */
>  		if ((delim = strchr(cur, ',')) == NULL)
>  			goto parse_failed;
>  		*delim = 0;
> -		strscpy(np->dev_name, cur, sizeof(np->dev_name));

nit: You can reset np->dev_name and np->dev_name and just overwrite one of
them depending on what was set. Something as:

	eth_broadcast_addr(np->local_mac);
	np->dev_name[0] = '\0';

	if (!strchr(cur, ':'))
		strscpy(np->dev_name, cur, sizeof(np->dev_name));
	else {
		if (!mac_pton(cur, np->local_mac))
			goto parse_failed.


> +		if (!strchr(cur, ':')) {
> +			strscpy(np->dev_name, cur, sizeof(np->dev_name));
> +			eth_broadcast_addr(np->local_mac);
> +		} else {
> +			if (!mac_pton(cur, np->local_mac)) {
> +				goto parse_failed;
> +			}
> +			/* force use of local_mac for device lookup */
> +			np->dev_name[0] = '\0';
> +		}
>  		cur = delim;

> @@ -674,29 +685,46 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
>  }
>  EXPORT_SYMBOL_GPL(__netpoll_setup);
>  
> +/* upper bound on length of %pM output */
> +#define MAX_MAC_ADDR_LEN (4 * ETH_ALEN)
> +
> +static char *local_dev(struct netpoll *np, char *buf)
> +{
> +	if (np->dev_name[0]) {
> +		return np->dev_name;

nit: You don't need the {} here.

> +	}
> +
> +	snprintf(buf, MAX_MAC_ADDR_LEN, "%pM", np->local_mac);
> +	return buf;
> +}
> +
>  int netpoll_setup(struct netpoll *np)
>  {
>  	struct net_device *ndev = NULL;
>  	bool ip_overwritten = false;
>  	struct in_device *in_dev;
>  	int err;
> +	char buf[MAX_MAC_ADDR_LEN];

nit: keep the revert XMAS tree format here. Also renaming it to
local_dev_mac or something similar might be a good idea.

>  	skb_queue_head_init(&np->skb_pool);
>  
>  	rtnl_lock();
> +	struct net *net = current->nsproxy->net_ns;

Does this need to be done inside the rtnl lock? I tried to search, and
it seems you can get it outside of the lock.

nit: You can move declaration of `*net` to the top of the function.

>  	if (np->dev_name[0]) {
> -		struct net *net = current->nsproxy->net_ns;
>  		ndev = __dev_get_by_name(net, np->dev_name);
> +	} else if (is_valid_ether_addr(np->local_mac)) {
> +		ndev = dev_getbyhwaddr_rcu(net, ARPHRD_ETHER, np->local_mac);
>  	}

nit: You can get rid of all braces above.

I haven't run the code yet, but, I will be doing it new week.

Thanks for addressing this limitation,
--breno

