Return-Path: <netdev+bounces-221320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D510B50245
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2D81C60735
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4134F490;
	Tue,  9 Sep 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNBQ2ujQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C363451B6;
	Tue,  9 Sep 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434556; cv=none; b=JXiexaevLkK3kSHPvGyc6asDswe/YTL+Pe+kbRla2ZfZG7rH+rZkY6x7b+yvTekhc3Rqc6UUSaCTl/M2Q2vTR0fr2UFDAQ1aO44p2iAbjn89VE7BqcpMWRf5ArHHZOStu78Vov0x4uRjR0oe4m3rD4hX6wKAyXnvOz1PRbzaoFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434556; c=relaxed/simple;
	bh=3JFS7qi/WCdnUSTSsAZiAZWQwu8b4HEGLmE7L2yCBWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taeLAgz2qBoDAT8RtYn6ttzqY6BHvE8MINgQHb/2zjRknQCKg/2oyKRaP9mOL05D3ZpdVmbUDqnX7jbG4UBWksnqi5fCHGCHa18nBLQ1uFiAj6Kv0L2/ApquUNKdTjdSUobh8HKAksllTBRUVLNy6hyg44wOsppIVRqtInVgFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNBQ2ujQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C884FC4CEF4;
	Tue,  9 Sep 2025 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757434556;
	bh=3JFS7qi/WCdnUSTSsAZiAZWQwu8b4HEGLmE7L2yCBWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNBQ2ujQO7daaI51CSxSqryEWfCnP8QIQ6ZJ8Q6nOBNjh3MfsR1I4Ho8NbNrwtL7h
	 B5rCaUjqyrDzGVjo1+r5SfzSpXg2LDLp6GLicEPf2LdN23akLMMdL6cJT15RCCdb6P
	 5GjNUeMEeActlZVS6zzpj21MNi4H1rWYfHaC8E2QdYNbS8c/uDDlV/lPJ6uzQi6o2Z
	 zg0TzKH+u5IAUQYxbmkel2UOdoWn6etcS33xqX0L3OLtwTkZXeb9uXxq9wTXJSiyoz
	 wOrdovN+CGvAfAwIKWy13kkjzOqCeWQjJnOvoTxEanxov+XptqWrmctmatAxrZWQOt
	 qaS7DM9b+e22g==
Date: Tue, 9 Sep 2025 17:15:49 +0100
From: Simon Horman <horms@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vivian Wang <uwu@dram.page>
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250909161549.GC20205@horms.kernel.org>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
 <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
 <20250905153500.GH553991@horms.kernel.org>
 <0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
 <20250905160158.GI553991@horms.kernel.org>
 <45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>

On Sat, Sep 06, 2025 at 12:35:37AM +0800, Vivian Wang wrote:
> On 9/6/25 00:01, Simon Horman wrote:
> 
> > On Fri, Sep 05, 2025 at 11:45:29PM +0800, Vivian Wang wrote:
> >
> > ...
> >
> > Hi Vivian,
> >
> >>>> +		status = emac_rx_frame_status(priv, rx_desc);
> >>>> +		if (unlikely(status == RX_FRAME_DISCARD)) {
> >>>> +			ndev->stats.rx_dropped++;
> >>> As per the comment in struct net-device,
> >>> ndev->stats should not be used in modern drivers.
> >>>
> >>> Probably you want to implement NETDEV_PCPU_STAT_TSTATS.
> >>>
> >>> Sorry for not mentioning this in an earlier review of
> >>> stats in this driver.
> >>>
> >> On a closer look, these counters in ndev->stats seems to be redundant
> >> with the hardware-tracked statistics, so maybe I should just not bother
> >> with updating ndev->stats. Does that make sense?
> > For rx/tx packets/bytes I think that makes sense.
> > But what about rx/tx drops?
> 
> Right... but tstats doesn't have *_dropped. It seems that tx_dropped and
> rx_dropped are considered "slow path" for real devices. It makes sense
> to me that those should be very rare.
> 
> So it seems that what I should do is to just track tx_dropped and
> rx_dropped myself in a member in emac_priv and report in the
> ndo_get_stats64 callback, and use the hardware stuff for the rest, as
> implemented now.

Thanks, that makes sense to me.

