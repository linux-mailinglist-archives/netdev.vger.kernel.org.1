Return-Path: <netdev+bounces-29187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36938781F9B
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 21:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672E01C20754
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163EC6FB3;
	Sun, 20 Aug 2023 19:43:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97A53AB
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 19:43:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E283C3C
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4+4taJjQhiVAJMxYuoZemGHQ3I1UdBBTGxSFzNRsDEw=; b=k53r60cx6GGgjvDsBLbko2mdFG
	sovvww2CnaHRKuFp6qbeiSi6GvAlxI/iR3/EMemlFvqjy0sueM6Bt6gnGC8A9+y575ywVCoxMYXFe
	uilEB7qmtza4AsJrLmX0i56j6+sDlZBqI+qV+D2bcOq/5iZq7hOABFhqY4GRyDHuoq4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qXoGd-004dbe-1S; Sun, 20 Aug 2023 21:39:19 +0200
Date: Sun, 20 Aug 2023 21:39:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, aelior@marvell.com,
	manishc@marvell.com
Subject: Re: [PATCH iwl-next v2 3/9] ethtool: Add missing ETHTOOL_LINK_MODE_
 to forced speed map
Message-ID: <7d25216b-ba96-467c-928b-63ca1521adeb@lunn.ch>
References: <20230819094025.15196-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819094025.15196-1-paul.greenwalt@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 02:40:25AM -0700, Paul Greenwalt wrote:
> The Ethtool forced speeds to Ethtool supported link modes map is missing
> some Ethtool forced speeds and ETHTOOL_LINK_MODE_. Add the all speeds
> and mapped link modes to provide a common implementation among drivers.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  include/linux/ethtool.h | 80 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 245fd4a8d85b..519d6ec73d98 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1069,12 +1069,33 @@ struct ethtool_forced_speed_map {
>  	.arr_size	= ARRAY_SIZE(ethtool_forced_speed_##value),	\
>  }
>  
> +static const u32 ethtool_forced_speed_10[] __initconst = {
> +	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
> +	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT,

Is this supposed to list all 10Mbps link modes? Or only full duplex
modes?

settings[] has:

	PHY_SETTING(     10, FULL,     10baseT_Full		),
	PHY_SETTING(     10, HALF,     10baseT_Half		),
	PHY_SETTING(     10, FULL,     10baseT1L_Full		),
	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),

> +};
> +
> +static const u32 ethtool_forced_speed_100[] __initconst = {
> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_100baseFX_Half_BIT,
> +	ETHTOOL_LINK_MODE_100baseFX_Full_BIT,
> +};

	PHY_SETTING(    100, FULL,    100baseT_Full		),
	PHY_SETTING(    100, FULL,    100baseT1_Full		),
	PHY_SETTING(    100, HALF,    100baseT_Half		),
	PHY_SETTING(    100, HALF,    100baseFX_Half		),
	PHY_SETTING(    100, FULL,    100baseFX_Full		),

	Andrew

