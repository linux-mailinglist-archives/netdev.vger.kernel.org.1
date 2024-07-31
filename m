Return-Path: <netdev+bounces-114342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA699423B8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213D01F23482
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706C1396;
	Wed, 31 Jul 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r95qWvGE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95238C;
	Wed, 31 Jul 2024 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384772; cv=none; b=R0eH3cXxft9/vY27b34lYAjn2Z3/kuCClKMabjGBRaTe+1vWuEwbWFeKNna/Ue8/ank8AM4RSglMSc6+E0hKGQeQjFmCSjSdI54TqOdkqCASuFDO4gLMDpqt8j2ZQrCouclZsPTWlpoTLtz6VKiELx4IYalQsbNVIuuFKfX+H0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384772; c=relaxed/simple;
	bh=PhDi+CbPR4gXfBzhndWGNrMM9z5hFGJo6RbykyFKFCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3gAE1XpNruYtnl+w/cWkIP9nwxpXqG5G5oZGHARCcLl1NpCJHo/1R3RLwLVzUpWyxAUZ8o8Q8Kvzqyk7S9SDKC+ySVNx9/v/Ih0ou+7BAhHivnz3F9BXj3mw7i6BoizOONoT3dJhmEfcshBNl3F3LdcO1PP99X9y6LouKxvGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r95qWvGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB67C32782;
	Wed, 31 Jul 2024 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722384771;
	bh=PhDi+CbPR4gXfBzhndWGNrMM9z5hFGJo6RbykyFKFCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r95qWvGEBTyQj10+VV80i3roYtBGQVJ413LNBZHRRccL+kPivs6v8mpUjYGQ9zG6Q
	 qPrvDZFZIF1N2vUObLcSGhn7FNTu43fhu/ym0FDMaFH9fNZrcuzK39vpWtKpFIwA6K
	 0nDpj57OamtprszC6W3Jw9LvRI4Ko2VFpslvr/bYGOcjevxu4NJhiUO3FTbwqjtAG4
	 g6rBVuut05flEuRmr0Uco4fLRKCvi5pryuK/ksA32bxxgfpeO1W/u1HFgLgsxdtK+D
	 M0V2VqstYhj77JpZNKoHGVLNN3lfZbpuFKOlKBybjUE5CtuXMttZmjNUp0fSx1lekv
	 c+96kCp9WFqww==
Date: Tue, 30 Jul 2024 17:12:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
 ruanjinjie@huawei.com, steen.hegelund@microchip.com,
 vladimir.oltean@nxp.com, masahiroy@kernel.org, alexanderduyck@fb.com,
 krzk+dt@kernel.org, robh@kernel.org, rdunlap@infradead.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, UNGLinuxDriver@microchip.com,
 Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
 Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
 benjamin.bigler@bernformulastudent.ch, linux@bigler.io
Subject: Re: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <20240730171248.45da6dc5@kernel.org>
In-Reply-To: <c9627346-9a04-4626-9970-ae5b2fe257da@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
	<c9627346-9a04-4626-9970-ae5b2fe257da@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 22:29:08 +0200 Andrew Lunn wrote:
> On Tue, Jul 30, 2024 at 09:38:52AM +0530, Parthiban Veerasooran wrote:
> > This patch series contain the below updates,
> > - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
> >   net/ethernet/oa_tc6.c.
> >   Link to the spec:
> >   -----------------
> >   https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> > 
> > - Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
> >   Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
> >   Link to the product:
> >   --------------------
> >   https://www.microchip.com/en-us/product/lan8650  
> 
> FYI: This is on my RADAR, but low priority, probably not until i get
> back from vacation. Given the very long timer between revisions, i
> don't see this delay being a problem.

SG, thanks for the heads up, let me mark it as deferred, you should 
be able to bring it back to life with a pw-bot command.. or ask for 
a repost.
-- 
pw-bot: defer

