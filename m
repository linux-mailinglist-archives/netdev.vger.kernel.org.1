Return-Path: <netdev+bounces-29178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F076C781F5A
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 20:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2370D280F65
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DFD63D6;
	Sun, 20 Aug 2023 18:57:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BE10F1
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:57:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B71BEF
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CfYHLWu8DTM4h6GppFVa08EJK0iarySCgG915li2Snk=; b=gatwpHwV0p5xAQJtoaRmIgZP+V
	LsVYyd5OQPJHFFzpHC6YmotTG1qO3ywNsMlgHmnc4dCiHfhlD3EGxD18NEcJJvSpwYTx37tEERbBk
	mwcCGJkbnwGIO0svfxi/1Pk/XA8xC/YFG1MlqoSFWXHpYyKvJcKJLXg8axpO7qeYv9V4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qXnYs-004dOc-TM; Sun, 20 Aug 2023 20:54:06 +0200
Date: Sun, 20 Aug 2023 20:54:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, aelior@marvell.com,
	manishc@marvell.com
Subject: Re: [PATCH iwl-next v2 2/9] ethtool: Add forced speed to supported
 link modes maps
Message-ID: <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819093941.15163-1-paul.greenwalt@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 02:39:41AM -0700, Paul Greenwalt wrote:
> The need to map Ethtool forced speeds to  Ethtool supported link modes is
> common among drivers. To support this move the supported link modes maps
> implementation from the qede driver. This is an efficient solution
> introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
> maps on module init") for qede driver.
> 
> ethtool_forced_speed_maps_init() should be called during driver init
> with an array of struct ethtool_forced_speed_map to populate the
> mapping. The macro ETHTOOL_FORCED_SPEED_MAP is a helper to initialized
> the struct ethtool_forced_speed_map.

Is there any way to reuse this table:

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy-core.c#L161

Seems silly to have multiple tables if this one can be made to work.
It is also used a lot more than anything you will add, which has just
two users so far, so problems with it a likely to be noticed faster.

	Andrew

