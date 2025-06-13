Return-Path: <netdev+bounces-197604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC827AD9489
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520263A6A83
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7922F74E;
	Fri, 13 Jun 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h2XCX4Xb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188E20F09B;
	Fri, 13 Jun 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839868; cv=none; b=Gz6gA2bQb19zShHL1tcZ7xsOrG1+Oakv0mrvvQbBIV/7zVmJQALq04SgJ5luG00saLnU8aRQNTPqSLeg2WU5RGfGzuYSdorap6wX5its9AIZ1RT7UVB+bTDUqoy2OtWfosv42xl6laybDZUCyTj/in0zNxyj7pLyayx5Avw8uso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839868; c=relaxed/simple;
	bh=c6ic4uyyibrOHjp/7Qs3GaQhWzY5pwR5KkmgcUsMSmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqJsdZXnEn7uGaTdYLESEB7ShXZ+0M8nAkaMH5wC1Z2J4o3vs4BErMSxK6Yd707rNtSNmXOE6ckFUqhJamjlXw4JZ4IJjSde1x2/UDsKd7L6yXDJrWHgDtb5Mm/1vSG3xF90YFkOL36eQe0/QpVuXIQGvwWLZblir39DI7FFFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h2XCX4Xb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dtw/cLueprulsHn809qaNjUx7R0yzTXpmSFdq34F6qY=; b=h2XCX4XbenMdDIyVDfa6wKBybu
	1RaCrxd14jBF3ltU9nS6m9CoS66Ytbwmb1kDNYLWS9r+QJdbVE4nFhWAUXPCxZs80mh+1WxlhnGrI
	s5+/ETbpyeg5tFY13AyQiRMNNI3DhiZO3/v4nXIBmXMeXIWcAZPdIlxQCnL+wyObU+PA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ9HX-00FkzO-RK; Fri, 13 Jun 2025 20:37:39 +0200
Date: Fri, 13 Jun 2025 20:37:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH net-next v2 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Message-ID: <729dfa8c-6eca-42c6-b9fd-5333208a0a69@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-7-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-fec-cleanups-v2-7-ae7c36df185e@pengutronix.de>

On Thu, Jun 12, 2025 at 04:16:00PM +0200, Marc Kleine-Budde wrote:
> Use the provided helper function skb_vlan_eth_hdr() to replace manual VLAN
> header calculation for better readability and maintainability.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 6b456372de9a..f238cb60aa65 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1860,8 +1860,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		    fep->bufdesc_ex &&
>  		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
>  			/* Push and remove the vlan tag */
> -			struct vlan_hdr *vlan_header =
> -					(struct vlan_hdr *) (data + ETH_HLEN);
> +			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);

This is not 'obviously correct', so probably the commit message needs
expanding.

static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_buff *skb)
{
	return (struct vlan_ethhdr *)skb->data;
}

I can see a few lines early:

		data = skb->data;

but what about the + ETH_HLEN?

	Andrew

