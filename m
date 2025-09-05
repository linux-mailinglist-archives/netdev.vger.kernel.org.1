Return-Path: <netdev+bounces-220405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66053B45D5A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E5617B822
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7DB2F39A6;
	Fri,  5 Sep 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf19mXo8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC631D74A;
	Fri,  5 Sep 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088126; cv=none; b=MYE3DViQhik0yK9EegvPFJfAMSVE1vBEYNgd2QhbbvLgo1S08AcL16fab7i/NZYNNaEq/7o9dgWdRSK/SI6WeEDAriCIvXUBFf0VArFa6tFjw75bXayjVulECq7PuE+qU1xYeaBvAPKFUMldDo6i5oMtM+kWO4tu5m58hpvSfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088126; c=relaxed/simple;
	bh=XtZf11jbbBoilXsBT63MRb4g16CbjYXTUzh33VUyndQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edUTDMyFRyaN1DsTkFkeEBpfxD4L41xgRF9xhwNNya9sG0eHqt7PZVT6jKAVrf+raN64Kb814Ziz36in91JnyblJM26kEE4bYEQ9hQf2qswSLHcrJaOhedt0s/zN0d4K9fgIrd7Prp+HJmiMD/c4shqW5QePjZxo0Si2RM1pciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf19mXo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13389C4CEF1;
	Fri,  5 Sep 2025 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088126;
	bh=XtZf11jbbBoilXsBT63MRb4g16CbjYXTUzh33VUyndQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qf19mXo8p1IPKQFY0/UahTIRblVXtBICsSc3ebDDzITfYScFms3XLSzR4XT/AfBD1
	 OySqhbWgBYAoQIPBm7WPAl1n8ItJ4IVZ7w32lKiBEOSAKlYAoJci+pSJYpRmfsSi+S
	 2A3XDv2mWJhfeWexq7r+XRNFXiseFSMS/0Xjn9E1F1GwunHAuVWuE1YEbPUGOaSOgV
	 BS4HYB46R7qujD8hm3bOvz3ki4e8bD4ZNWtYmnU6ro2b4OO6OBOCHVLvphT4el6TtF
	 MnX+9ukJdOrtuZtElMAFMhCDHRVV/2HCvjYFYPuDpwfXB7OBg+cvAziKtB1RO6aPZc
	 wMTMMngXUOpIw==
Date: Fri, 5 Sep 2025 17:01:58 +0100
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
Message-ID: <20250905160158.GI553991@horms.kernel.org>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
 <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
 <20250905153500.GH553991@horms.kernel.org>
 <0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>

On Fri, Sep 05, 2025 at 11:45:29PM +0800, Vivian Wang wrote:

...

Hi Vivian,

> >> +		status = emac_rx_frame_status(priv, rx_desc);
> >> +		if (unlikely(status == RX_FRAME_DISCARD)) {
> >> +			ndev->stats.rx_dropped++;
> > As per the comment in struct net-device,
> > ndev->stats should not be used in modern drivers.
> >
> > Probably you want to implement NETDEV_PCPU_STAT_TSTATS.
> >
> > Sorry for not mentioning this in an earlier review of
> > stats in this driver.
> >
> On a closer look, these counters in ndev->stats seems to be redundant
> with the hardware-tracked statistics, so maybe I should just not bother
> with updating ndev->stats. Does that make sense?

For rx/tx packets/bytes I think that makes sense.
But what about rx/tx drops?

...

