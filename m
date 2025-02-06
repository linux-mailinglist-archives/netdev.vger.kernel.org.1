Return-Path: <netdev+bounces-163700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D158A2B64E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FED03A4BD3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778812417C9;
	Thu,  6 Feb 2025 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zscfCGLf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD922417C0
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882966; cv=none; b=RgdKNNVF4nFcwFRgLZUjSG0jEFZ7b3Zufod03kWCPxrCw4rXxllFViKV+qrSy3+E0g/ehTCPKY5ucGxOhdKKvmYYQjz4/iHGSb40OyYjbiocSaAH3KBYDtOESiwMiUAHcl/eEa8j6kPqGkx2e55ElqSSxxCvqCbqsdCl51z/hsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882966; c=relaxed/simple;
	bh=YyIweElI1MyfmFL4j9IskkP6II1usf5EYofUGeFpDGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM0HAxodyHMGHF+l0xfMnnAJ4JqvZJNoDz0/LF3+/N/Uo58ht+hvijw+VFN6/F73mOKqhImMQRBcg7a5mvqR0AEIbKm/QX//HEmafuA1FMYUzFQu+O+nW5wC8a52PCqPnLRjKKee7Eg1n1O2jTZARbNJhB0M7a7b8i39U9cJRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zscfCGLf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=js3AL36A6eIiubEpRJIjSaKUmNgzB7u+2ttRhEMGmnc=; b=zscfCGLfQ/2w3NZ6GtxXetGhKH
	2jvo63d2n0MtSh5CQSP5orQEo9defRPgL1APvcaI+xayEPB0/qkbwwzqhMOybo8OVw6o9YlONkCA3
	2DJnutlObpmAjFuls15TTmrfYNFQd8tO30MYjcBDijphwa8aJzi55d20TmJJSYrZIL8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tgAtG-00Bf7P-Bz; Fri, 07 Feb 2025 00:02:34 +0100
Date: Fri, 7 Feb 2025 00:02:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: enhance error message for 'netns local'
 iface
Message-ID: <e439e851-435d-430d-b7fb-7666ea496954@lunn.ch>
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
 <20250206165132.2898347-3-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206165132.2898347-3-nicolas.dichtel@6wind.com>

On Thu, Feb 06, 2025 at 05:50:27PM +0100, Nicolas Dichtel wrote:
> The current message is "Invalid argument". Let's help the user by
> explaining the error.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  net/core/rtnetlink.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 5032e65b8faa..91b358bdfe5c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3024,8 +3024,12 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>  		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
>  
>  		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex);
> -		if (err)
> +		if (err) {
> +			if (dev->netns_local)
> +				NL_SET_ERR_MSG(extack,
> +					       "The interface has the 'netns local' property");

This seems to have the wrong order. Why even try calling
__dev_change_net_namespace() if you know it is going to fail?

Maybe this NL_SET_ERR_MSG() should be pushed into
__dev_change_net_namespace()? You could then return useful messages if
the altnames conflict, the ifindex is already in use, etc.

	Andrew

