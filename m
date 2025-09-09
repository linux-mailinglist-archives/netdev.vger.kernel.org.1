Return-Path: <netdev+bounces-221323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B965FB50252
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A0216142A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0334F490;
	Tue,  9 Sep 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6xkxEpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3034321F;
	Tue,  9 Sep 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434713; cv=none; b=mbehB07fbmElg9uhplhsn75suQrceGh7ZlSJfg97YKERPKY3rglzNGbCyvqWs+z7CRa1+Vqrg7v1SaLKj8KXXi1ZaZsok9PnD3DD+vFPf/47uPhhIJ+KMCE19pi6WrvF/CCTwfx1JUWs1Y8QU7WE8NVwmMkKfJntiJVogsBi1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434713; c=relaxed/simple;
	bh=zjM0ZFGXF7CG6poTLXyEy9jmsj2idsqfoWbfmtN5A3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6XEodZKxeFUSV/4fu2Yt5zSRecPohttkjaw9IF1vR6dXIBU/zIx99pMgxpbStN5GkvsH06HiboWlOVjnwvITl/BkCiO7WAi9QpMFnWbQmhz+T/68R6GEHdoFcnBB0lABfdlYCDDv/9niUs+MDdXUhC7UD6lTlxVu9b0EVnh+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6xkxEpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F587C4CEF4;
	Tue,  9 Sep 2025 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757434712;
	bh=zjM0ZFGXF7CG6poTLXyEy9jmsj2idsqfoWbfmtN5A3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6xkxEpNBw1feIQDl8RsDKxxWge5IUdPMauh/ToF78Bce2M3GcCE5+/nNRgWF413s
	 mif1rMBOMk9PJXb58miP2BiKseccrCu7/xCv327yCT1Yb2GQROqaNJKmR2s7IwI2Or
	 uQWctEPywqiMcJIJQc9H5qjZBUqD+VBtMenWpmoe6tO/7qtWwpt58TJK3S9zvf6Q4E
	 IAf8w8pbXhR6QMEf+BzLoXRYO5TCndRRxlTml20MtSLkNfzmmesKN7PrRH6q8exv7R
	 8ngtUh5qT3Q5B13Nr6/77K5RLeIEgo8Dq1KFXJrLid3Ogzu5INwWYvqOoVCcJBb74J
	 hubKpObcQGCAQ==
Date: Tue, 9 Sep 2025 17:18:26 +0100
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
Message-ID: <20250909161826.GA23218@horms.kernel.org>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
 <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
 <20250905153500.GH553991@horms.kernel.org>
 <0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
 <20250905160158.GI553991@horms.kernel.org>
 <45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
 <20250909161549.GC20205@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909161549.GC20205@horms.kernel.org>

On Tue, Sep 09, 2025 at 05:15:56PM +0100, Simon Horman wrote:
> On Sat, Sep 06, 2025 at 12:35:37AM +0800, Vivian Wang wrote:
> > On 9/6/25 00:01, Simon Horman wrote:
> > 
> > > On Fri, Sep 05, 2025 at 11:45:29PM +0800, Vivian Wang wrote:
> > >
> > > ...
> > >
> > > Hi Vivian,
> > >
> > >>>> +		status = emac_rx_frame_status(priv, rx_desc);
> > >>>> +		if (unlikely(status == RX_FRAME_DISCARD)) {
> > >>>> +			ndev->stats.rx_dropped++;
> > >>> As per the comment in struct net-device,
> > >>> ndev->stats should not be used in modern drivers.
> > >>>
> > >>> Probably you want to implement NETDEV_PCPU_STAT_TSTATS.
> > >>>
> > >>> Sorry for not mentioning this in an earlier review of
> > >>> stats in this driver.
> > >>>
> > >> On a closer look, these counters in ndev->stats seems to be redundant
> > >> with the hardware-tracked statistics, so maybe I should just not bother
> > >> with updating ndev->stats. Does that make sense?
> > > For rx/tx packets/bytes I think that makes sense.
> > > But what about rx/tx drops?
> > 
> > Right... but tstats doesn't have *_dropped. It seems that tx_dropped and
> > rx_dropped are considered "slow path" for real devices. It makes sense
> > to me that those should be very rare.
> > 
> > So it seems that what I should do is to just track tx_dropped and
> > rx_dropped myself in a member in emac_priv and report in the
> > ndo_get_stats64 callback, and use the hardware stuff for the rest, as
> > implemented now.
> 
> Thanks, that makes sense to me.

Oops, for the 2nd time today I see I've responded where other's have
already done so. In this case, please take Jakub's advice elsewhere
in this thread.

