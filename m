Return-Path: <netdev+bounces-135921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B999FCAE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA240B246F8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C066E574;
	Wed, 16 Oct 2024 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBA9Y4KY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218203C2F;
	Wed, 16 Oct 2024 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036891; cv=none; b=Nd8/f4rRGWSaQlKJQoffgrJz8nop+Vg3VD98Mdt4KHg7K3Mz++fJK+3ZgtOOZ2EBN1zjv8Fgh71QQbaJzhUg48cvrodRSEIxNSEQTUX1YqtQVnT25xAmqWi+0G5oOA+wdihGVD7iZDBqW3NSo3KDgwutCrzZm1eoiu38FX9jHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036891; c=relaxed/simple;
	bh=/dfhe+BlvxmCl6zGVsAR54TqRd+jSY8NaT9slM696fU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+bbanRCYYn5ru+Vq7YByhvxI+IieTLa5VTOBjOJ7GavOxGxSLL8x7CGu044BSgBgbyQ2xWH4RHtAQh1XAEFGix1cs8WCSLlyOY1TmPGZd6/o4hAlx7xjpwGnXr9YuquSSQq5QeTifDsDjkOmz8SBD0ahmPHbtcKiR5bdgNBPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBA9Y4KY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA5FC4CEC6;
	Wed, 16 Oct 2024 00:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729036890;
	bh=/dfhe+BlvxmCl6zGVsAR54TqRd+jSY8NaT9slM696fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gBA9Y4KY0dZfWjhl6tDUfGR9lJMQlZP1VLVBX5YNoOvf/YpPTPbY9wc1ibh5JIopv
	 s9g6AiNK2e/NS8XIqko+YbNbCGUzQ6keTICAwaiByGhRKl7sXGmPnFKUCb5HcegEPv
	 lzDmXIu4q5dCuVke3y5fpV59j17HW1QmQu8gcf9B1PMEo7Tm4qGpEIEEFQ0N7cACoJ
	 VXRhGXmoEdDWIZ3GQaP7kSuoIUHCorg/pSwysdUCQPhw3nQjASH10AWV5y6N11dXXF
	 xU2GlXOwb8fG+9ZxqDyItVG7x97Lf7gVxCdPSTYfEwTTLLXA1gRNVjJ0efxe1xCRLg
	 q0sx5V2wtj5dg==
Date: Tue, 15 Oct 2024 17:01:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Wang Hai <wanghai38@huawei.com>, justin.chen@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, zhangxiaoxu5@huawei.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmasp: fix potential memory leak in
 bcmasp_xmit()
Message-ID: <20241015170128.49714ba5@kernel.org>
In-Reply-To: <924f6a1b-17af-4dc8-80e3-7c7df687131a@broadcom.com>
References: <20241014145901.48940-1-wanghai38@huawei.com>
	<924f6a1b-17af-4dc8-80e3-7c7df687131a@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 10:14:59 -0700 Florian Fainelli wrote:
> On 10/14/24 07:59, Wang Hai wrote:
> > The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
> > in case of mapping fails, add dev_kfree_skb() to fix it.
> > 
> > Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > ---
> >   drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > index 82768b0e9026..9ea16ef4139d 100644
> > --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > @@ -322,6 +322,7 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
> >   			}
> >   			/* Rewind so we do not have a hole */
> >   			spb_index = intf->tx_spb_index;
> > +			dev_kfree_skb(skb);  
> 
> Similar reasoning to the change proposed to bcmsysport.c, we already 
> have a private counter tracking DMA mapping errors, therefore I would 
> consider using dev_consume_skb_any() here.

.. but this one hasn't been pushed and I presume same treatment will
apply?

