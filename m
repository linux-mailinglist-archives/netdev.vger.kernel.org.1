Return-Path: <netdev+bounces-35275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E27A8710
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73111C20D73
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5E7339AC;
	Wed, 20 Sep 2023 14:37:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38F29A1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DD4C433CD;
	Wed, 20 Sep 2023 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695220649;
	bh=s3bgrhGXXnBGfp10fZJfnsYMF5SLUWmZavWbit4GAME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VFIXjgiuGVGbrTsnE7dgq5v4mKL1vJJjajF7DoeJMlqYqnb0roGK+NZI1SfIeFE7s
	 +fwwjpVKcaKpYvaHAYFwcjLCHcyFEv4kWEWxEXmy6dxo19oW1i4b91Z85+EsEo5Vun
	 Y9JYO6m3W+jbeQkHKoMBv86JdJw3AA+TLCuNYZrgR9rtLQSQmOWRyDXd/GHdceIFfT
	 3FtS3z+auc7IXqgdYWvnfHbfZF1Pgi4vFf036gfdNmhv/n9aXT38DrMswvSTXIFimH
	 sUic0hwGTvpZpL04rbuoFD21085Upmp+degkyasjoOfDRU6qjMlo0SEgRHlNjq4J5w
	 DoafowMjETJfg==
Message-ID: <c1859ea9-b020-57b9-dc29-98cebdd14f0f@kernel.org>
Date: Wed, 20 Sep 2023 08:37:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v3] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
Content-Language: en-US
To: Patrick Rohr <prohr@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>, Jen Linkova <furry@google.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20230919180411.754981-1-prohr@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230919180411.754981-1-prohr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/19/23 12:04 PM, Patrick Rohr wrote:
> This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
> lifetime derivation mechanism.
> 
> RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
> Advertisement PIO shall be ignored if it less than 2 hours and to reset
> the lifetime of the corresponding address to 2 hours. An in-progress
> 6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currently
> looking to remove this mechanism. While this draft has not been moving
> particularly quickly for other reasons, there is widespread consensus on
> section 4.2 which updates RFC4862 section 5.5.3e.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: Jen Linkova <furry@google.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 11 ++++++++
>  include/linux/ipv6.h                   |  1 +
>  net/ipv6/addrconf.c                    | 38 +++++++++++++++++---------
>  3 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index a66054d0763a..45d700e04dba 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2304,6 +2304,17 @@ accept_ra_pinfo - BOOLEAN
>  		- enabled if accept_ra is enabled.
>  		- disabled if accept_ra is disabled.
>  
> +ra_honor_pio_life - BOOLEAN
> +	Whether to use RFC4862 Section 5.5.3e to determine the valid
> +	lifetime of an address matching a prefix sent in a Router
> +	Advertisement Prefix Information Option.
> +
> +	- If enabled, the PIO valid lifetime will always be honored.
> +	- If disabled, RFC4862 section 5.5.3e is used to determine
> +	  the valid lifetime of the address.
> +
> +	Default: 0 (disabled)
> +
>  accept_ra_rt_info_min_plen - INTEGER
>  	Minimum prefix length of Route Information in RA.
>  
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 5883551b1ee8..59fcc4fee7b7 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -35,6 +35,7 @@ struct ipv6_devconf {
>  	__s32		accept_ra_min_hop_limit;
>  	__s32		accept_ra_min_lft;
>  	__s32		accept_ra_pinfo;
> +	__s32		ra_honor_pio_life;

Any reason for this to be 4B entry for a boolean? all of these __s32
entries for what are really booleans is pushing devconf size over 256B
which means allocations are 512B. Unnecessary waste of memory.

