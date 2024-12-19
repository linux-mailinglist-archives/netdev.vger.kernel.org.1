Return-Path: <netdev+bounces-153413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB0C9F7DF9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C16B18877D9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745BE226874;
	Thu, 19 Dec 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZUgbu63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565B226861;
	Thu, 19 Dec 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621922; cv=none; b=MDoAY+SJwFcFvPwqBBsQMPfvZTTsrMnrvWBNJhmG/pi1VsEvmlLVl/HHOtoKNF/R9tOFpXBC50EWXIcsTNObhL9UjfK+Q6DjBRGiSu8AhVxlh8musy8MbeDzGApM0xbfkoAlj8AjN3+ubU7I7nkR0uX/taKb9EOcWrizw1eoHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621922; c=relaxed/simple;
	bh=DJc8HBGOy7SSX8hnOaFP0lOTMIm3bgx5nLuXDuzTRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+w29+OD99PJJ13nXRRnJzFyfyODo08s8WKm8CpmciIdGxnN/QSCyntw8wqZBv7hICT1xDiB3yX0hBl2d26w7p8RG9VyljamWKLLaZFWQuqzq1q8C21QRlDlwm9BmLBkTfWVpOB3R4vc46KK0/vQ8R54SUJLZe5o+kyEdviYCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZUgbu63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49296C4CEDE;
	Thu, 19 Dec 2024 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734621921;
	bh=DJc8HBGOy7SSX8hnOaFP0lOTMIm3bgx5nLuXDuzTRKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZUgbu630tIs/ZEA+GLC+dXvHGU+4600k+NAAT++TPspjofChb+ZzcWeHMMPQ/aAU
	 P20V9Ie7Fqy7xcjj2JOGot2ZcqB2yGwg2VEskQNqIu5rFYXhC8am+wLjFZOLYQuYNW
	 8VK9nr+Zxuqo3MJI/T9vulsTDvdlnRpHqwugmjwzSDkSzQuNSjxLxmimYBqA8jBlsW
	 ckkeyPpLl+CTSOvhLm32cqQ7ophiM9ivexH/EvojonG8JzgwIPaUZ1qiOOKHwEvIo9
	 FUK8AcuySLctasu3+g3CcRncga/6ZWXgyZGipeBX81DSHq+C9ecCX+jzwTzoWblvEV
	 38HcWx9evBF/w==
Date: Thu, 19 Dec 2024 07:25:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241219072519.4f35de6e@kernel.org>
In-Reply-To: <CAMArcTUToUPUceEFd0Xh_JL8kVZOX=rTarpy1iOAD5KvRWP5Fg@mail.gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-4-ap420073@gmail.com>
	<20241218182547.177d83f8@kernel.org>
	<CAMArcTXAm9_zMN0g_2pECbz3855xN48wvkwrO0gnPovy92nt8g@mail.gmail.com>
	<20241219062942.0d84d992@kernel.org>
	<CAMArcTUToUPUceEFd0Xh_JL8kVZOX=rTarpy1iOAD5KvRWP5Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 00:14:01 +0900 Taehee Yoo wrote:
> > > The bnxt_en disallows setting up both single and multi buffer XDP, but core
> > > checks only single buffer XDP. So, if multi buffer XDP is attaching to
> > > the bnxt_en driver when HDS is enabled, the core can't filter it.  
> >
> > Hm. Did you find this in the code, or did Broadcom folks suggest it?
> > AFAICT bnxt supports multi-buf XDP. Is there something in the code
> > that special-cases aggregation but doesn't work for pure HDS?  
> 
> There were some comments about HDS with XDP in the following thread.
> https://lore.kernel.org/netdev/20241022162359.2713094-1-ap420073@gmail.com/T/
> I may misunderstand reviews from Broadcom folks.

I see it now in bnxt_set_rx_skb_mode. I guess with high MTU
the device splits in some "dumb" way, at a fixed offset..
You're right, we have to keep the check in the driver, 
at least for now.

