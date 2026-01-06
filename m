Return-Path: <netdev+bounces-247363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08557CF89C4
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6515302E329
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319AE3451BD;
	Tue,  6 Jan 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2F6BrrXY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAE3451AE;
	Tue,  6 Jan 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707099; cv=none; b=Jcyvb8XHCI/LSrZX8s7rEz1ZtlpnbNGuUZNLXjIzuUISDTa5rxmlNEXNqXS2fb6MGRu5k7eMnPcJqgydaF+8HWNosH+s1UZEPG2CFaOfREdnkx6OWERGRRiBBWJql+kPwjBp64hV0ChRPGs21SG8Sa1OiJ5FChOc5wncTzFfttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707099; c=relaxed/simple;
	bh=uxqJoj37/ZG6LJdRd5d07DaTXghuz7rGNM0Hi+qqwqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNBncP2Rk+V/3ZNh+vd9lI5yuRah3Jf6S3/fkqooB4uMEEXlyt8+t3Fo1yKgifd4anJ61bO/NPT3wvtLgILYxdXFo5XDnpWTIPoZCljaAZsjHiWK55sgJ3n+FKNm4h+BoD/ww17vg6PU1JVprKdjGtmkhRrhPL1a7uBfzTcrXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2F6BrrXY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o0RudgO9iEA2ZXa1tQpeCXg4p6eGEhFPUYkddbZvK20=; b=2F6BrrXYDF+SPnzbOOS5IyT5NC
	6T/2VWxHcEKD4yHtLiFoEIHs3qFzwFj2lPDXqQ3oOy+O1t8Fc+hFc8Kos+OmW7HERhVaKLeiuMclZ
	85NUBLMb1mgoz63DshFJ610ocvRZvBzUFkDIp5hhqH8FgkYt/2ak1+Cn04cpWhNtDsqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vd7Mf-001cxr-8j; Tue, 06 Jan 2026 14:44:49 +0100
Date: Tue, 6 Jan 2026 14:44:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: count tx_dropped when dropping skb
 on link down
Message-ID: <b6ff2078-86d7-4416-a914-e07ae13e2128@lunn.ch>
References: <20260106122350.21532-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106122350.21532-2-yyyynoom@gmail.com>

On Tue, Jan 06, 2026 at 09:23:51PM +0900, Yeounsu Moon wrote:
> Increment tx_dropped when dropping the skb due to link down.
> 
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> ---
>  drivers/net/ethernet/dlink/dl2k.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> index 846d58c769ea..edc6cd64ac56 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -733,6 +733,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
>  	u64 tfc_vlan_tag = 0;
>  
>  	if (np->link_status == 0) {	/* Link Down */
> +		dev->stats.tx_dropped++;

Do you see this being hit very often? It should be that as soon as you
know the link is down, you tell the core, and it will stop calling
start_xmit. If you see this counter being incremented a lot, it
indicates there is a problem somewhere else.

You might want to consider converting this driver to phylink.

	  Andrew

