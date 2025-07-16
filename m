Return-Path: <netdev+bounces-207405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91590B07053
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69EB5828FD
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469C92E9EC4;
	Wed, 16 Jul 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxNr8dV8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCE2EA46E;
	Wed, 16 Jul 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654135; cv=none; b=mHpaB8+fkS4+IHaF3mDIJlpwshx6wJhCd+d0hJkis80sEgYdtqzhfaxzhbBHrr8XOIaG8PjCC6Oc78524+/q1M1F2NBzOGdUVl8EHDTBtTbRu8PoksZqtHk2NuiH3E1eMs6EFjINNUXSIk3H8PYTbGVZ2MMLgEmjqFnT8HGgwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654135; c=relaxed/simple;
	bh=cnOqqRyy8qapop2aj8Jh9qYqoK7bu5+GswzkuuErweY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtJBeCm5s5kuJmAOScIoiLc5T9b5GHka/8DkNOf4zur/j/RzxnjnpJEdYHL6gH0o1wFs9Ok3eY7qtFfN51Ntc/ua6NBYDGllDRmorR33zBB1kkXWtFF/iAnXMS8iE4D6NPox0iOmEH8C/cq7Y0SPK3EsJAVKdbGSb0fbdOAAd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxNr8dV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA6EC4CEF0;
	Wed, 16 Jul 2025 08:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654134;
	bh=cnOqqRyy8qapop2aj8Jh9qYqoK7bu5+GswzkuuErweY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxNr8dV8utIpB32/zJ1R+YimFzAuZwRROQZBqfJHoDS1ouPaDNML/T8mkaNtZMorC
	 kPTe0Y1t6Iey7AUMZP7C5z0XxnTIjBMTw/w+h+6SFXB0B1AwAfN33HXIgy28zIE6Py
	 RyPQ33zcZhyWh/Zbgw+mAuB4HhAhx+GgIkjvmpgzyIc9k5uJadbiBJyJ3TPXEiPZ+N
	 gt+wfW/KeOkvC+pDiV/pYPoCG4OGTZgGyqAmSuTJyH1V1IuwYfH7Up4a+Z11t3vYYC
	 a6VuvwUWYzY1djopIhfce3XbH4hsyUXakJfB45GOZK8PpEl6aE56MoeJ3BsFJ2cRnI
	 MNn3jyoDwNqiw==
Date: Wed, 16 Jul 2025 09:22:09 +0100
From: Simon Horman <horms@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Set CIC bit only for TX queues
 with COE
Message-ID: <20250716082209.GH721198@horms.kernel.org>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-3-c34092a88a72@altera.com>
 <20250714134012.GN721198@horms.kernel.org>
 <9f4acd69-12ff-4b2f-bb3a-e8d401b23238@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f4acd69-12ff-4b2f-bb3a-e8d401b23238@altera.com>

On Tue, Jul 15, 2025 at 07:14:21PM +0530, G Thomas, Rohan wrote:
> Hi Simon,
> 
> Thanks for reviewing the patch.
> 
> On 7/14/2025 7:10 PM, Simon Horman wrote:
> > On Mon, Jul 14, 2025 at 03:59:19PM +0800, Rohan G Thomas via B4 Relay wrote:
> > > From: Rohan G Thomas <rohan.g.thomas@altera.com>
> > > 
> > > Currently, in the AF_XDP transmit paths, the CIC bit of
> > > TX Desc3 is set for all packets. Setting this bit for
> > > packets transmitting through queues that don't support
> > > checksum offloading causes the TX DMA to get stuck after
> > > transmitting some packets. This patch ensures the CIC bit
> > > of TX Desc3 is set only if the TX queue supports checksum
> > > offloading.
> > > 
> > > Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> > > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > 
> > Hi Rohan,
> > 
> > I notice that stmmac_xmit() handles a few other cases where
> > checksum offload should not be requested via stmmac_prepare_tx_desc:
> > 
> >          csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
> >          /* DWMAC IPs can be synthesized to support tx coe only for a few tx
> >           * queues. In that case, checksum offloading for those queues that don't
> >           * support tx coe needs to fallback to software checksum calculation.
> >           *
> >           * Packets that won't trigger the COE e.g. most DSA-tagged packets will
> >           * also have to be checksummed in software.
> >           */
> >          if (csum_insertion &&
> >              (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
> >               !stmmac_has_ip_ethertype(skb))) {
> >                  if (unlikely(skb_checksum_help(skb)))
> >                          goto dma_map_err;
> >                  csum_insertion = !csum_insertion;
> >          }
> > 
> > Do we need to care about them in stmmac_xdp_xmit_zc()
> > and stmmac_xdp_xmit_xdpf() too?
> 
> This patch only addresses avoiding the TX DMA hang by ensuring the CIC
> bit is only set when the queue supports checksum offload. For DSA tagged
> packets checksum offloading is not supported by the DWMAC IPs but no TX
> DMA hang. AFAIK, currently AF_XDP paths don't have equivalent handling
> like skb_checksum_help(), since they operate on xdp buffers. So this
> patch doesn't attempt to implement a sw fallback but just avoids DMA
> stall.

Ok, fair enough.

As per Andrew's advice elsewhere in this thread.
This patch also looks like it should be a fix for net,
and should have a Fixes tag.

