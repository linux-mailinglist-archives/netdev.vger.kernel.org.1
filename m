Return-Path: <netdev+bounces-109445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C59287E1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52CF1C23D9D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB1148FF3;
	Fri,  5 Jul 2024 11:24:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7038149C53;
	Fri,  5 Jul 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178673; cv=none; b=Czg8VRr3aPm9WRG+SGyHF8c1ttjGDwsJGqdg/IxOTckp9GHqM1WgWxas8kCgSOel/FckXLgz33C0Mx/HC6YrEIfw38rEFkTQVHTj2G9kXYfCGEI7Xhm4fV2MSeZ9AXCrCYWbthUxM7FR1BDui+5wJwRACpRJt7BK1OHIt48hpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178673; c=relaxed/simple;
	bh=7s23rkWuC612dnSWcePNRJLy1PhobERMINXQ/deokm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdi5cLi7i1E8MVRmWxTVnu5L//Ae6KhIfQu53VB5ilko3dA+mgygb08hzdp3T2kxDKv6paWdL4irbtHCBzs4hhBCclNCui0yufhUvUcuTCzlH+CCT4+l9psNe7JClfjEf0+8RVyNRaSsA8JizzP21uacqHdnaQggwTW9QjdKLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sPh37-00000000572-213d;
	Fri, 05 Jul 2024 11:24:21 +0000
Date: Fri, 5 Jul 2024 12:24:18 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: linux-mediatek@lists.infradead.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mediatek: Allow gaps in MAC
 allocation
Message-ID: <ZofX4qfGf93Q8jys@makrotopia.org>
References: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org>
 <3bda121b-f11d-44d1-a761-15195f8a418c@intel.com>
 <C24C4687-1C00-434D-8C37-BDB85E39456C@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C24C4687-1C00-434D-8C37-BDB85E39456C@makrotopia.org>

Hi netdev maintainers,

On Tue, Jul 02, 2024 at 09:05:19AM +0000, Daniel Golle wrote:
> >what about:
> >4733│ static int mtk_sgmii_init(struct mtk_eth *eth)
> >4734│ {
> >4735│         struct device_node *np;
> >4736│         struct regmap *regmap;
> >4737│         u32 flags;
> >4738│         int i;
> >4739│
> >4740│         for (i = 0; i < MTK_MAX_DEVS; i++) {
> >4741│                 np = of_parse_phandle(eth->dev->of_node, "mediatek,sgmiisys", i);
> >4742│                 if (!np)
> >4743│                         break;
> >
> >should we also continue here?
> 
> Good point. As sgmiisys is defined in dtsi it's not so relevant in
> practise though, as the SoC components are of course always present even
> if we don't use them. Probably it is still better to not be overly
> strict on the presence of things we may not even use, not even emit an
> error message and silently break something else, so yes, worth fixing
> imho.
> 

I've noticed that this patch was marked as "Changes Requested" on patchwork
despite having received a positive review.

I'm afraid this is possibly due to a misunderstanding:

The (unrelated and rather exotic) similar issue pointed to by Przemek
Kitszel should not be fixed in the same commit. It is unrelated, and if
at all, should be sent to 'net' tree rather than 'net-next'.

Looking at it more closely I would not consider it an issue as we
currently in the bindings we **require** the correct number of sgmiisys phandles to be
present for each SoC supporting SGMII:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n200
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n245
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n287
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mediatek,net.yaml#n325

Hence there aren't ever any gaps, also because the sgmiisys phandles are
defined in the SoC-specific DTSI **even for boards not making any use of
them**.

I hence would like this very patch to be merged (or at least discussed)
as-is, and if there is really a need to address the issue mentioned by
Przemek Kitszel, then deal with it in a separate commit.


Cheers


Daniel

