Return-Path: <netdev+bounces-41550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 820DF7CB487
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214CEB20E81
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6D3716C;
	Mon, 16 Oct 2023 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKK+5JW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63935358BB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CED1C433C8;
	Mon, 16 Oct 2023 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487684;
	bh=tMO19lsIUvbHuOMG1oNNP1xqEO8tLMWolyYvNKzCdqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lKK+5JW2ajHNEDpyzad3yLwo7SjgwoVS4G44JlrZRGXp9DB5HEctP9C9i0iYK1ZVR
	 0rCIjENyk6rAKdOzzff8qP4lJJDYs0q92jgg4pQxm/m8RXxlbfYpbURsmO+dwytlw3
	 DQnpJE+2kI8NSl+K7LREUv0lbmJXaAosQ48m7uO9oKLO5TXn4ZnPf7fLZD2zrV6/5m
	 2LPd23oqGqVbtIwdOALe3VaG5OqH1eyGnSJzUNP66pUI6oOc3hx/qNdwhIbdxTBrWj
	 iW0Z8YBQpNgk4zW6pDJLYOIIgMB5ZiqAgWyQwr1TyHRhtoYHaWwvJaI5y5TGGY7CMK
	 SJZfERHJOOwLw==
Date: Mon, 16 Oct 2023 13:21:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, opurdila@ixiacom.com
Subject: Re: [PATCH net 1/5] net: fix ifname in netlink ntf during netns
 move
Message-ID: <20231016132123.50094c45@kernel.org>
In-Reply-To: <20231016201657.1754763-2-kuba@kernel.org>
References: <20231016201657.1754763-1-kuba@kernel.org>
	<20231016201657.1754763-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 13:16:53 -0700 Jakub Kicinski wrote:
> +static int dev_prep_valid_name(struct net *net, struct net_device *dev,
> +			       const char *want_name, char *out_name)

> +	if (strchr(want_name, '%')) {
> +		ret = __dev_alloc_name(net, want_name, out_name);
> +		return ret < 0 ? ret : 0;

> -	if (strchr(name, '%'))
> -		return dev_alloc_name_ns(net, dev, name);
> -	else if (netdev_name_in_use(net, name))
> -		return -EEXIST;
> -	else if (dev->name != name)
> -		strscpy(dev->name, name, IFNAMSIZ);
> -
> -	return 0;
> +	return dev_prep_valid_name(net, dev, name, dev->name);

Humpf, this is not right. IDK what magic seeing something on the ML
has but I looked at this 3 times, and the moment I see it on the list
I immediately realize that the dev_alloc_name_ns() -> __dev_alloc_name()
conversion here is not really exact. We need to go thru a temp buffer
like dev_alloc_name_ns() does, because for whatever reason
__dev_alloc_name_ns() uses its input argument as a scratch buffer.
So if we pass dev->name directly and it fails the name will be
scrambled.
-- 
pw-bot: cr

