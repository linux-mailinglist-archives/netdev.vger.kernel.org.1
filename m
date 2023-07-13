Return-Path: <netdev+bounces-17619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4457525E1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043BC1C21370
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD02319BC1;
	Thu, 13 Jul 2023 14:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0C111AB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0571C433C7;
	Thu, 13 Jul 2023 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689260376;
	bh=yMaUKpvYi5zeXUHVljnQCBlQXnqNTkBJ+0ZM47p/C8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UA4+6khsFMZrtYGmPKYu7GFVGrMiZeQxqpfmA8vMknzgCyx0awhPM7rWv5VNItdom
	 Gh/FGUtB2tb2mL6attySMEkZBwH6v4VyNAy7YwbBSZTwyBWRImidMJaHEq9/ObxCxi
	 vLPgSGLQfQGFe8/Ebdtap7F7JsAS+y8EuSzHj0xb+ymwNb8v94eL/6ye6a3bCEC0I0
	 43sggMaB5uZvfZLUuMszI8SwY07kGbpX3AiNFhxmlgJcQ2HuULx7T182rVzXrzttdx
	 +Bk6SytTEEZc9SjAXJIhUw1rDU0ZtN7dndIKvYxkpM1NGvve/fThH7Y77/g2705T8a
	 c2dKZO5CpSUwg==
Message-ID: <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
Date: Thu, 13 Jul 2023 08:59:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
Content-Language: en-US
To: =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>
References: <20230712135520.743211-1-maze@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230712135520.743211-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/12/23 7:55 AM, Maciej Żenczykowski wrote:
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index e5213e598a04..94cec2075eee 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2561,12 +2561,18 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>  			ipv6_ifa_notify(0, ift);
>  	}
>  
> -	if ((create || list_empty(&idev->tempaddr_list)) &&
> -	    idev->cnf.use_tempaddr > 0) {
> +	/* Also create a temporary address if it's enabled but no temporary
> +	 * address currently exists.
> +	 * However, we get called with valid_lft == 0, prefered_lft == 0, create == false
> +	 * as part of cleanup (ie. deleting the mngtmpaddr).
> +	 * We don't want that to result in creating a new temporary ip address.
> +	 */
> +	if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lft))
> +		create = true;

I am not so sure about this part. manage_tempaddrs has 4 callers --
autoconf (prefix receive), address add, address modify and address
delete. Seems like all of them have 'create' set properly when an
address is wanted in which case maybe the answer here is don't let empty
address list override `create`.


> +
> +	if (create && idev->cnf.use_tempaddr > 0) {
>  		/* When a new public address is created as described
>  		 * in [ADDRCONF], also create a new temporary address.
> -		 * Also create a temporary address if it's enabled but
> -		 * no temporary address currently exists.
>  		 */
>  		read_unlock_bh(&idev->lock);
>  		ipv6_create_tempaddr(ifp, false);


