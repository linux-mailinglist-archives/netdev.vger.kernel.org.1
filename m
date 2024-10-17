Return-Path: <netdev+bounces-136718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303859A2BE0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA05C1F216F4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646261E0B7C;
	Thu, 17 Oct 2024 18:15:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C851E04AD;
	Thu, 17 Oct 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188900; cv=none; b=XB9r0YyIlLLiR1hRPwkhXvHoKhbrxhY9rM3dT83+QYdHiDxfguA2eTBLhSQZd3slZNMUbPPZyz6rgLGaYXTVW1lF6EjhsaKHwtDcLUrQVKPg/rzPnZ1djmaHm16GvHegvRvk0xiQ8lADyLzLo3W8BBDitBymw7eIg87d52v8GVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188900; c=relaxed/simple;
	bh=mNis12xG71cOKii9S3wHPr+6uxx3urLZnrZSZdaSAEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acDearKIREXBV0ypicRIKycvnaEQokySH+cI41LeXf9VxTC1szLsZVYazVYEdnWEV8I3KXCKYX5pbJaykL/mKOpNU7iLwU2vf+8TGgvJMnml9R5VccG2Exh8pcpHpx8cpxnN6um3U7IVxgGYpyNXI3AHC104/eDKt/RMTlRQBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t1V1K-00070j-3l; Thu, 17 Oct 2024 20:14:46 +0200
Date: Thu, 17 Oct 2024 20:14:46 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 09/10] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6mr_rtm_getroute()
Message-ID: <20241017181446.GC25857@breakpoint.cc>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
 <20241017174109.85717-10-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017174109.85717-10-stefan.wiehler@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Stefan Wiehler <stefan.wiehler@nokia.com> wrote:
> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
> must be read under RCU or RTNL lock.
> 
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  net/ipv6/ip6mr.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index b169b27de7e1..39aac81a30f1 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -2633,27 +2633,31 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>  		grp = nla_get_in6_addr(tb[RTA_DST]);
>  	tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
>  
> +	rcu_read_lock();

AFAICS ip6mr_rtm_getroute() runs with RTNL held, so I don't see
why this patch is needed.

