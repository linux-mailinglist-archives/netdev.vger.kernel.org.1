Return-Path: <netdev+bounces-114823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C694454C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2281F21E38
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F545014;
	Thu,  1 Aug 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="jps2gZp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88AA13C90C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496701; cv=none; b=hv28F+EYwMUfmrtIfRrUHa+wVk4F8g3NpLC1+EZNgcDuLjFkIkFXBPd4t/s2UBcwx3NDXT2bM55cOy8FZwhImDqYnwEIQtlQzcrdJju9Gw286aMMyhTbaYMr8fsxu71RmrSwqAXSIg8TmCOlpp4Fevd1LSUqFA2T8By6aTWFzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496701; c=relaxed/simple;
	bh=Sl40Pk9E4MQ2wodYddYPTpV8yQcpMgd2IvmfhA3SMI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fosx9H1Me6x/nA56LoUeWqi2rqEbX6EMIE9bV2yH2TPcYaaYk4U6aq++wdv1miiHbij2FF+fFPlZutL++/yigdioZO8z6KOfifilWVeyeqi7SVA2bed/K1Kw5Ima51dzP13kUdTtsrVBu8lnfL9D+Md7jaF3wLs9HoeoDjHDMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=jps2gZp+; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 2E8707D9F3;
	Thu,  1 Aug 2024 08:18:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722496693; bh=Sl40Pk9E4MQ2wodYddYPTpV8yQcpMgd2IvmfhA3SMI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:From;
	z=Message-ID:=20<6e6236db-9e36-527e-eaef-591a20a9c3d2@katalix.com>|
	 Date:=20Thu,=201=20Aug=202024=2008:18:12=20+0100|MIME-Version:=201
	 .0|Subject:=20Re:=20[PATCH=20v2=20net-next=201/6]=20l2tp:=20Don't=
	 20assign=20net->gen->ptr[]=20for=0D=0A=20pppol2tp_net_ops.|To:=20K
	 uniyuki=20Iwashima=20<kuniyu@amazon.com>,=0D=0A=20"David=20S.=20Mi
	 ller"=20<davem@davemloft.net>,=20Eric=20Dumazet=20<edumazet@google
	 .com>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.org>,=20Paolo=20Abe
	 ni=20<pabeni@redhat.com>|Cc:=20Kuniyuki=20Iwashima=20<kuni1840@gma
	 il.com>,=20netdev@vger.kernel.org,=0D=0A=20Simon=20Horman=20<horms
	 @kernel.org>|References:=20<20240731200721.70601-1-kuniyu@amazon.c
	 om>=0D=0A=20<20240731200721.70601-2-kuniyu@amazon.com>|From:=20Jam
	 es=20Chapman=20<jchapman@katalix.com>|In-Reply-To:=20<202407312007
	 21.70601-2-kuniyu@amazon.com>;
	b=jps2gZp+o6OrDtp3iXxa9mEGNsNvFr+pL3lAC2PrR/LF7snU7Zna+Q4RJ9nRnB4aw
	 SzUbk47oQtjGWbFufV53Wzjj3GFWYfCAOQlplBnVglukJJwljFKn59EIB6Zjx7CwTd
	 46VXeS9tdvuJFuKEja7rg8KxCBXACPxvPz+iJ7L8jB56JZe+IdQUou43bc4Hulh0e7
	 vxWzRzcQsliPzm+hLxZpxoPabp2KJIONAsjp5d+gZCDXgXUgtcHdeQBDTwhPYhbT6f
	 SvecgTjKD8HMwDeUsZRvOnMCeW8gC4DmhyMYwGz+wiwhoECGy5caRZeKVhcx/O3i4v
	 Vn5/JttJaVojQ==
Message-ID: <6e6236db-9e36-527e-eaef-591a20a9c3d2@katalix.com>
Date: Thu, 1 Aug 2024 08:18:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 net-next 1/6] l2tp: Don't assign net->gen->ptr[] for
 pppol2tp_net_ops.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20240731200721.70601-1-kuniyu@amazon.com>
 <20240731200721.70601-2-kuniyu@amazon.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
In-Reply-To: <20240731200721.70601-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2024 21:07, Kuniyuki Iwashima wrote:
> Commit fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and
> ppp parts") converted net->gen->ptr[pppol2tp_net_id] in l2tp_ppp.c to
> net->gen->ptr[l2tp_net_id] in l2tp_core.c.
> 
> Now the leftover wastes one entry of net->gen->ptr[] in each netns.
> 
> Let's avoid the unwanted allocation.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: James Chapman <jchapman@katalix.com>

> ---
>   net/l2tp/l2tp_ppp.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 3596290047b2..246089b17910 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1406,8 +1406,6 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
>    * L2TPv2, we dump only L2TPv2 tunnels and sessions here.
>    *****************************************************************************/
>   
> -static unsigned int pppol2tp_net_id;
> -
>   #ifdef CONFIG_PROC_FS
>   
>   struct pppol2tp_seq_data {
> @@ -1641,7 +1639,6 @@ static __net_exit void pppol2tp_exit_net(struct net *net)
>   static struct pernet_operations pppol2tp_net_ops = {
>   	.init = pppol2tp_init_net,
>   	.exit = pppol2tp_exit_net,
> -	.id   = &pppol2tp_net_id,
>   };
>   
>   /*****************************************************************************


