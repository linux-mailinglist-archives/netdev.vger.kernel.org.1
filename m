Return-Path: <netdev+bounces-30691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABA7888E7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC9D28183D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819ADF4A;
	Fri, 25 Aug 2023 13:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E97495
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:47:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4862139
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gKuBgkbgBYolUQH8i5kQlcPak6MN8SYhusYfvpxpzM8=; b=0meFFz3aMsHLiLRCk6G1W1z4Ri
	UirXjCPly9DzueUCBu/VRaQDIIT4IIP4gVHyWkH97MreLyHwcVblRgiUCjQVliu/C+jTEsRdxAQ4q
	264pd8nsJahLqFU/zzGAvJVkLtIZy2TWLlzPbSjPUgoBRFYgbh90zEKc1lVmPboCaXf0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qZX9k-0055vx-0Y; Fri, 25 Aug 2023 15:47:20 +0200
Date: Fri, 25 Aug 2023 15:47:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Pawel Chmielewski <pawel.chmielewski@intel.com>,
	"Greenwalt, Paul" <paul.greenwalt@intel.com>, aelior@marvell.com,
	intel-wired-lan@lists.osuosl.org, manishc@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/9] ethtool: Add forced
 speed to supported link modes maps
Message-ID: <51ee86d8-5baa-4419-9419-bcf737229868@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com>
 <ZOZISCYNWEKqBotb@baltimore>
 <a9fee3a7-8c31-e048-32eb-ed82b8233aee@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9fee3a7-8c31-e048-32eb-ed82b8233aee@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Let me think how we could do that.
> Andrew's idea is good. But most high-speed NICs, which have a standalone
> management firmware for PHY, don't use phylib/phylink.
> So in order to be able to unify all that, they should have ->supported
> bitmap somewhere else. Not sure struct net_device is the best place...

I would probably keep it in the driver priv structure, and just pass
it as needed. So long as you only need one or two values, i don't see
the need for a shared structure.

> If I recall Phylink logics correctly (it's been a while since I last
> time was working with my embedded project),
> 
> 1) in the NIC (MAC) driver, you initialize ->supported with *speeds* and
>    stuff like duplex, no link modes;
> 2) Phylink core sets the corresponding link mode bits;
> 3) phylib core then clears the bits unsupported by the PHY IIRC

No, not really.

All i think you need is a low level helper. So don't worry too much
about how phylink works, just implement that low level helper passing
in values as needed, not phylib or phylink structure.

What i don't want is a second infrastructure to be built for those MAC
drivers which don't use Linux to control the PHY. Either share a few
helpers, or swap to phylink.

> The third step in case with those NICs with FW-managed PHYs should be
> done manually in the MAC driver somewhere. Like "I am qede and I don't
> support mode XX at 50Gbps, but support the rest, so I clear that one bit".

I don't think that will work. New bits keep getting added, more speeds
added. So 'support the rest' is not well defined. You need an explicit
list of link modes the driver needs. We already have code to convert
an array of link mode bits into an actual mask, e.g:

        linkmode_set_bit_array(phy_basic_t1_features_array,
                               ARRAY_SIZE(phy_basic_t1_features_array),
                               phy_basic_t1_features);

	Andrew			       

