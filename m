Return-Path: <netdev+bounces-249465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB33CD196AF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B651300DB04
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2D286881;
	Tue, 13 Jan 2026 14:22:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449D21CA02;
	Tue, 13 Jan 2026 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314167; cv=none; b=tZsrc9d2wLZrP0NhLi0WlD7wrsBGDtkuAIxP3vzERj9m5O+BeGx5m4MGwK39MtcgZsyiq4s3r09upItckoh1gG272JNlHBtriAKIO6Zqe9AZpSOItLGRuGz7gfAztEdB8IwZSf4jqcwWbJJC5+UUFqpymCxB06HlSw9w8ufb3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314167; c=relaxed/simple;
	bh=45dZQdW9fGUa224LTS3tQ2Qsw+8kqQrF6HjLpsqqbfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rde93hUFKgQVE6aTYusHwYea0UHaEdzQTn8RtNU5xekv6yUjCJXGOHxBzsOqBqpB7ZYPQxi3jzdF0UPkCdQpGp5cFkjPpud17r+CxHOW48NU0UDLLc2eDX1y6Djm9vcNBYXSBC06F4D+Yh7cJGfAFuuLWa6vbFxbWzPPK6h2+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vffHv-000000004Ng-1YDD;
	Tue, 13 Jan 2026 14:22:27 +0000
Date: Tue, 13 Jan 2026 14:22:24 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Rex Lu <rex.lu@mediatek.com>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: support using
 non-MediaTek DSA switches
Message-ID: <aWZVIBh6AKiIaxdr@makrotopia.org>
References: <34647edacab660b4cabed9733d2d3ef22bc041ac.1768273593.git.daniel@makrotopia.org>
 <252d6877-d966-4d19-a38c-cc83ba908494@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252d6877-d966-4d19-a38c-cc83ba908494@lunn.ch>

On Tue, Jan 13, 2026 at 03:00:18PM +0100, Andrew Lunn wrote:
> On Tue, Jan 13, 2026 at 03:11:54AM +0000, Daniel Golle wrote:
> > MediaTek's Ethernet Frame Engine is tailored for use with their
> > switches. This broke checksum and VLAN offloading when attaching a
> > DSA switch which does not use MediaTek special tag format.
> 
> This has been seen before. The Freescale FEC has similar problems when
> combined with a Marvell switch, it cannot find the IP header, and so
> checksum offloading does not work.
> 
> I thought we solved this be modifying the ndev->feature of the conduit
> interface to disable such offloads. But i don't see such code. So i
> must be remembering wrongly.
> 
> This is assuming the frame engine respects these flags:
> 
> /usr/sbin/ethtool -k enp2s0
> Features for enp2s0:
> rx-checksumming: on
> tx-checksumming: on
> 	tx-checksum-ipv4: on
> 	tx-checksum-ip-generic: off [fixed]
> 	tx-checksum-ipv6: on
> 	tx-checksum-fcoe-crc: off [fixed]
> 	tx-checksum-sctp: off [fixed]
> 
> When you combine a Marvell Ethernet interface with a Marvell switch
> offloading works of course. So it probably does require some logic in
> the MAC driver to determine if the switch is of the same vendor or
> not.

MediaTek folks also got back to me in a private message, confirming
the issue and also clarifying that the length of the tag is the
limiting factor. Every 4-byte tag can work, sizes other than 4 bytes
cannot. As MediaTek's tag format includes the 802.1Q VLAN as part of
the tag itself I suspect VLAN offloading will still need some extra
care to work on non-MTK 4-byte tags (like RealTek 4B, for example)...

> 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > index e68997a29191b..654b707ee27a1 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -1459,6 +1459,26 @@ static void setup_tx_buf(struct mtk_eth *eth, struct mtk_tx_buf *tx_buf,
> >  	}
> >  }
> >  
> > +static bool mtk_uses_dsa(struct net_device *dev)
> > +{
> > +#if IS_ENABLED(CONFIG_NET_DSA)
> > +	return netdev_uses_dsa(dev) &&
> > +	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;
> > +#else
> > +	return false;
> > +#endif
> 
> I think the concept of determining if the switch is using a specific
> tag in order to enable/disable acceleration should be generic. So i
> would try to make this an helper in include/next/dsa.h. Any MAC driver
> can then use it.

Now that I know that the Ethernet driver should have 4 modes:
 - no DSA at all
 - DSA with MediaTek special tag
 - DSA with non-MediaTek but still 4 byte special tag
   -> VLAN offloading needs to be figured out
 - DSA with special tag size not equal to 4 bytes
   -> no checksum and no VLAN offloading

> 
> > @@ -1531,7 +1551,7 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
> >  		/* tx checksum offload */
> >  		if (info->csum)
> >  			data |= TX_DMA_CHKSUM_V2;
> > -		if (mtk_is_netsys_v3_or_greater(eth) && netdev_uses_dsa(dev))
> > +		if (mtk_is_netsys_v3_or_greater(eth) && mtk_uses_dsa(dev))
> >  			data |= TX_DMA_SPTAG_V3;
> 
> This looks to be in the hot path. Do you really want to do this
> evaluation on every frame? You can change the tag protocol via sysfs,
> however, dsa_tree_change_tag_proto() will only allow you to change the
> tag while the conduit interface is down. So it should be safe to look
> at the tag protocol once during open, and cache the result somewhere
> local, struct mtk_eth? That should avoid a few cache misses.

+1

> 
> > @@ -3192,6 +3212,14 @@ static netdev_features_t mtk_fix_features(struct net_device *dev,
> >  		}
> >  	}
> >  
> > +	if ((features & NETIF_F_IP_CSUM) &&
> > +	    non_mtk_uses_dsa(dev))
> > +		features &= ~NETIF_F_IP_CSUM;
> > +
> > +	if ((features & NETIF_F_IPV6_CSUM) &&
> > +	    non_mtk_uses_dsa(dev))
> > +		features &= ~NETIF_F_IPV6_CSUM;
> > +
> 
> 
> When is mtk_fix_features() actually called? I don't know without
> looking at the core. You will want it when open is called, when the
> tagging protocol is fixed.

It's used as .ndo_fix_features operation, which is called by
__netdev_update_features() at various occasions, and I'm not sure if it
would be called as well when changing the tag protocol...

