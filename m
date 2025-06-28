Return-Path: <netdev+bounces-202094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3DAEC360
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2971C4091F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7E10E4;
	Sat, 28 Jun 2025 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ompg9Tvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333F1635;
	Sat, 28 Jun 2025 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069317; cv=none; b=p/yVxOc9FGBdfG3CV8A/ZPxqEFkLfbWoTYC3UJNC3ig/l79O9opwouqYv7epOoIkrMpSIAq1csqtwLyrs6Qd7hH9pBcupdtJz+VmJVP7E3gfV/YKrvjl4kwK6AAywFx6BRv4kbxLOwXS9O9BeAGJbv9Cla9fXtX+R5uzHNUVOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069317; c=relaxed/simple;
	bh=reyTXtbR8Ie0GfGmy+BgOSnPd+2lS+t804f25duRNHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dk7v6MB2cKZg6jgkLg0NnfsCJU0yxcr20nkVz4K9nX+v76MKxuj1DFIzWVso7RR66Z44JQ6tPQ2llszmJChHnalic1h2kXjmg0kH5OlfjkgyDEo1iY7hSe5FmrfOT8zXh4GBPF/9ShpJtqyfogc0fVL+AFJ6uhoEgLWNXkz4VJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ompg9Tvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55764C4CEE3;
	Sat, 28 Jun 2025 00:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751069316;
	bh=reyTXtbR8Ie0GfGmy+BgOSnPd+2lS+t804f25duRNHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ompg9Tvkv90ehDOg4KY/Z2PH375bFy/SQaQo+hOj5iC4FsmxpMORmu4ZTrY5E4oH6
	 CtWBn0r8zPbJFSNO/4Zh+UNtHl+O+rji9Ega41Awo+8Ji8mKpy2XDsgWbw6LFpY0jm
	 /DbPGRBw/CYbBLW5HRi518quu6T95rzfnNNeA5gO8Iwp/Vh5nYKoZQTSAChr0hfqDb
	 4V0JsM58PA/CvqiOkeCcB60Ues6m2CUFUaqXPe7DnlbwuzodHQdkHvDwONM21iqSWV
	 ESZekLdSHx/YRTrNaqz+IYstFcUtuXuSzH2iQGxUylLD6jMXPPNDUc1GTNd3JjBsoq
	 HWuqPfwJuYmcA==
Date: Fri, 27 Jun 2025 17:08:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <rogerq@kernel.org>, <horms@kernel.org>,
 <mwalle@kernel.org>, <jacob.e.keller@intel.com>, <jpanis@baylibre.com>,
 <s-vadapalli@ti.com>, <danishanwar@ti.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss: Fix skb size
 by accounting for skb_shared_info
Message-ID: <20250627170835.75c73445@kernel.org>
In-Reply-To: <20250626051226.2418638-1-c-vankar@ti.com>
References: <20250626051226.2418638-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 10:42:26 +0530 Chintan Vankar wrote:
> While transitioning from netdev_alloc_ip_align() to build_skb(), memory
> for the "skb_shared_info" member of an "skb" was not allocated. Fix this
> by including sizeof(skb_shared_info) in the packet length during
> allocation.
> 
> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is based on the commit '9caca6ac0e26' of origin/main branch of
> Linux-net repository.
> 
> Link to v1:
> https://lore.kernel.org/r/598f9e77-8212-426b-97ab-427cb8bd4910@ti.com/
> 
> Changes from v1 to v2:
> - Updated commit message and code change as suggested by Siddharth
>   Vadapalli.
> 
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index f20d1ff192ef..67fef2ea4900 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -856,7 +856,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
>  {
>  	struct sk_buff *skb;
>  
> -	len += AM65_CPSW_HEADROOM;
> +	len += AM65_CPSW_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
>  	skb = build_skb(page_addr, len);

Looks to me like each packet is placed in a full page, isn't it?
If that's the case the correct value for "buffer size" is PAGE_SIZE
-- 
pw-bot: cr

