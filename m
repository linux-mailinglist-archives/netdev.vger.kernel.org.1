Return-Path: <netdev+bounces-16160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233B74B9CE
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1299128195C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FED17ADB;
	Fri,  7 Jul 2023 23:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCF17AD3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 23:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D18C433C8;
	Fri,  7 Jul 2023 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688771451;
	bh=epNAr2DDyGPShAjRJk+xhNsNY5DucIhhIQhO0oT11n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOzvootFxD46KcjzgYrtI2oxMbaSldAb75HMTQdUCLpDzul5OTrFWcH1CGmcfMwBZ
	 pbZeyIc4tkoY4udUKoiIop3n+IDcu23uzomggPH8iypEASs8GGNDc49LwAQcqpkKM8
	 JtUUXhU7QsMuvPokTSfZC3iegHb/9l2EAAml232xt1rZuqHg6E1LppiKm3ZrWivA3m
	 6hIHpF1F9sux+gOVX8BlTagqYkOUPl4ZLwoKiy583hM6eu4M+VsVt9Cp49f9D4Z1m2
	 oVXmTvzq6qG7C6ui8Iih9aWdTpmemfvTrrq6iJBx/vGJsQp1ts+F2ZpeIaGxrD2GSj
	 YOviVzQzXjLFg==
Date: Fri, 7 Jul 2023 16:10:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, sergey.senozhatsky@gmail.com, pmladek@suse.com,
 tj@kernel.org, stephen@networkplumber.org, Dave Jones
 <davej@codemonkey.org.uk>, netdev@vger.kernel.org (open list:NETWORKING
 [GENERAL]), linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] netconsole: Append kernel version to message
Message-ID: <20230707161050.61ec46a8@kernel.org>
In-Reply-To: <20230707132911.2033870-1-leitao@debian.org>
References: <20230707132911.2033870-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jul 2023 06:29:11 -0700 Breno Leitao wrote:
> Create a new netconsole runtime option that prepends the kernel version in
> the netconsole message. This is useful to map kernel messages to kernel
> version in a simple way, i.e., without checking somewhere which kernel
> version the host that sent the message is using.
> 
> If this option is selected, then the "<release>," is prepended before the
> netconsole message. This is an example of a netconsole output, with
> release feature enabled:
> 
> 	6.4.0-01762-ga1ba2ffe946e;12,426,112883998,-;this is a test
> 
> Calvin Owens send a RFC about this problem in 2016[1], but his
> approach was a bit more intrusive, changing the printk subsystem. This
> approach is lighter, and just append the information in the last mile,
> just before netconsole push the message to netpoll.
> 
> [1] Link: https://lore.kernel.org/all/51047c0f6e86abcb9ee13f60653b6946f8fcfc99.1463172791.git.calvinowens@fb.com/
> 
> Cc: Dave Jones <davej@codemonkey.org.uk>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good! net-next is closed for the duration of the merge window 
so you'll need to repost next week, and please put [PATCH net-next v3]
as the subject prefix while at it.

> @@ -332,6 +350,11 @@ static ssize_t enabled_store(struct config_item *item,
>  	}
>  
>  	if (enabled) {	/* true */
> +		if (nt->release && !nt->extended) {
> +			pr_err("release feature requires extended log message\n");
> +			goto out_unlock;
> +		}

This is the only bit that gave me pause - when parsing the command line
you ignore release if extended is not set (with an error/warning).
Does it make sense to be consistent and do the same thing here? 
Or enabling at runtime is fundamentally different?

