Return-Path: <netdev+bounces-21956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3E765767
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18EB2823D2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A025B1775D;
	Thu, 27 Jul 2023 15:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F8171C6
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA8C433C7;
	Thu, 27 Jul 2023 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690471463;
	bh=x0oeQt5XG7CgnXWpG7MTxiW85iG8DcAAU/cdmq71YJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gizN+sYMt5OlHesp7dPp5/iFIdUM55zNQPlkmYjH0DH2L1GNZM4/grOLDg/QT5pwb
	 WhWJNPxcfWy0VI9ZanvolSOp6fA6SAmOsQUhFoHoS1igmdJVzuQFOH8iPjTYzR11TF
	 ANDdr5IUUVo9D85ATBk+hQS3xlOJfvQnViJy7Gu7r/vF6M282rROMKXrCIf3eHh6i3
	 //HjjPZ8lFuEEtWbNvHTOmtIOl80c5BTs0/EvyfDbJo7bqV+grdqMBy5VUEbLP861Y
	 HEaB5I4XfxR1I3wAKwl9CAIahIcHQIxL+mHVPseojq2S5oOETjvFxCkG0sXCdULqPX
	 KxbmMIeL67b/Q==
Message-ID: <ee6c4ea7-c78e-ede1-6d5d-b39f38ab71f1@kernel.org>
Date: Thu, 27 Jul 2023 09:24:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [net-next v2] net: change accept_ra_min_rtr_lft to affect all RA
 lifetimes
Content-Language: en-US
To: Patrick Rohr <prohr@google.com>, "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20230726230701.919212-1-prohr@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230726230701.919212-1-prohr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/26/23 5:07 PM, Patrick Rohr wrote:
> accept_ra_min_rtr_lft only considered the lifetime of the default route
> and discarded entire RAs accordingly.
> 
> This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
> applies the value to individual RA sections; in particular, router
> lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> lifetimes are lower than the configured value, the specific RA section
> is ignored.
> 
> In order for the sysctl to be useful to Android, it should really apply
> to all lifetimes in the RA, since that is what determines the minimum
> frequency at which RAs must be processed by the kernel. Android uses
> hardware offloads to drop RAs for a fraction of the minimum of all
> lifetimes present in the RA (some networks have very frequent RAs (5s)
> with high lifetimes (2h)). Despite this, we have encountered networks
> that set the router lifetime to 30s which results in very frequent CPU
> wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
> WiFi firmware) entirely on such networks, it seems better to ignore the
> misconfigured routers while still processing RAs from other IPv6 routers
> on the same network (i.e. to support IoT applications).
> 
> The previous implementation dropped the entire RA based on router
> lifetime. This turned out to be hard to expand to the other lifetimes
> present in the RA in a consistent manner; dropping the entire RA based
> on RIO/PIO lifetimes would essentially require parsing the whole thing
> twice.
> 
> Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  8 ++++----
>  include/linux/ipv6.h                   |  2 +-
>  include/uapi/linux/ipv6.h              |  2 +-
>  net/ipv6/addrconf.c                    | 14 ++++++++-----
>  net/ipv6/ndisc.c                       | 27 +++++++++++---------------
>  5 files changed, 26 insertions(+), 27 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


