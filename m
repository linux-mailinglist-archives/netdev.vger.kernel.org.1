Return-Path: <netdev+bounces-230818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3FFBF01A6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941EF189ED3D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26382ED846;
	Mon, 20 Oct 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="1Dmt4BIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVv9h4vv"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B032EFD8F
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951424; cv=none; b=WDr8LsQ0eAUNPwLLN15AuMpcdDvcoJoEeK5WsqlGfrsMa25uA/CEGsNJwu30ZHsRw4Lv0JLVj4tCzObmkdcF8LTp4J1vBnAb12jPEdYu3FsLEtEonxXYo7198tE72Oye8MlESHwlCNyKH0Z1ZDJSwxktb1utk19a7ZZ5FMTQGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951424; c=relaxed/simple;
	bh=P79UHccwcgEWVBGz1KcEPTQTM6OY5QxvDpDKCvddb3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofqidzpRjgj29njdfeXQL62lGXEpHFelrHnAVtdYujakIh/cGP/1yZO23L4hAdCAS4/3capVQmvPzzVOChDz3RGH0WkRWfcBwlei1/tJ6wKT0NrNaAhw6TiuAhQearUXT9dl6UnCHPcPnA5YGQDmkDpAATlOl0eUMg0zAfveRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=1Dmt4BIj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVv9h4vv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CEA361D000DE;
	Mon, 20 Oct 2025 05:10:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 05:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760951418; x=
	1761037818; bh=fbeI+mZpIV+oK437BE8tkb1TtWDzlBfuXU+n/16Vcw8=; b=1
	Dmt4BIjeowEd30c95j7D2XXYJbr6I1OrWCw7E30gAsRJq6SfY5XrCAj449mMCDNq
	ov+UTEApwK9IWGZZR/2Zpy30T3Dp/g8kToGBdfYazmPqdBJ3nLXQBgrF4UMOq4bx
	iZqJhxWwkVIM2XoPz02vQWHZ+hZIVSs+9L1ypKSc9VSrVMuWUhqC40+p1vpmDGx8
	T9W/J76OfiSCA5+tHFGPObkfjzLPe5tmNNQWCSY5ZtK+H/iQqi0bPxgNC/S3w57K
	/vyMGDyXzPfgfe03kPUxOFoFtd8AXIaS9DVFShYZGiD2O9W7G3/8aCV74NdWPzMl
	76E8fRBr/3oQEme1hd6QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760951418; x=1761037818; bh=fbeI+mZpIV+oK437BE8tkb1TtWDzlBfuXU+
	n/16Vcw8=; b=cVv9h4vvyf9vk8VRfpIdHGGcTyDsGcDIAMdpWZZRrwAUbYOLblT
	MUh6Sm5qnPY1scK9x3VR2vNXEbAKG+AdiVhUXRMjvaCTQOEMgZjlIpNPOb8Mc6Np
	U5o5rLNbu4NEYuXQ9yXoNtwhKW04vrKC8cLloe4PPjGnd36zpXr9PF1YLNw/RW2W
	YOp0Y2CbYhcE5tI/3OP8oo9930xiPvXidkq2P9HdN1KttjYzJn7DWrMDtOoDuXbU
	XSstEyymGO2MYiYu+1I3fzoSo9GzTinrWg0hicDzWtYA/Eq1ybOg52rD1Fr3j4jg
	kNdF+8a3x67TFvsF2KH+xMudx+BUAxQJpQw==
X-ME-Sender: <xms:efz1aA4M3K_oC8y3qf89aQeG36uiClWS39QONq3D0cxO2c8Pp3DmEQ>
    <xme:efz1aLQB1KU-aqToUQEqqeNsdIlAL99zHjBzn0tfwQ5E2cglsJ7IENkl7MwpFJg1q
    hqJv2y3B8ttiUH15FixEEey3UN1zI_CcMpMHh2TWI6AAEf7FbiK8A>
X-ME-Received: <xmr:efz1aH-vu45dzo1-ptNKas2bggQn8po2DVFlurvUnWoKwMv8HpZ5L_ZT5pSS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhird
    hush
X-ME-Proxy: <xmx:efz1aEpR4oxSHdjJFYC1oNcRgqi4P8Gwc1qhv--bzNeRJfgoIYm6Vw>
    <xmx:efz1aFUeSkwkkHNHEt4u4aaVoahjj9A2Npe_6dzfrC4RRHaoQu7hDw>
    <xmx:efz1aB4SrWw3sS8VdHL06GGQax5x71fr5QC-sYR4b9T_PP3s-8HqDA>
    <xmx:efz1aDBNlTU22gto8o_tiCmdCsXZFO2a-cG78DRlcBDmRYysusnGqw>
    <xmx:evz1aEBV3gfAWA3eMVN7XQZ0PQ3qvpG3q_zFUznH39mRyVcezNQI867e>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 05:10:16 -0400 (EDT)
Date: Mon, 20 Oct 2025 11:10:14 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
Message-ID: <aPX8di8QX96JvIZY@krikkit>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017034155.61990-2-liuhangbin@gmail.com>

2025-10-17, 03:41:52 +0000, Hangbin Liu wrote:
> Some high level software drivers need to compute features from lower
> devices. But each has their own implementations and may lost some
> feature compute. Let's use one common function to compute features
> for kinds of these devices.
> 
> The new helper uses the current bond implementation as the reference
> one, as the latter already handles all the relevant aspects: netdev
> features, TSO limits and dst retention.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

No objection to this patch/series, just a nit and some discussion below, so:

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>


[...]
> +/**
> + *	netdev_compute_master_upper_features - compute feature from lowers

nit: I'm slightly annoyed (that's not quite the right word, sorry)
that we're adding a new function to "compute features" that doesn't
touch netdev->features, but I can't come up with a better name
(the best I got was "compute extra features" and it doesn't help).

> + *	@dev: the upper device
> + *	@update_header: whether to update upper device's header_len/headroom/tailroom
> + *
> + *	Recompute the upper device's feature based on all lower devices.
> + */
> +void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
> +{
[...]
> +	netif_set_tso_max_segs(dev, tso_max_segs);
> +	netif_set_tso_max_size(dev, tso_max_size);
> +
> +	netdev_change_features(dev);

Maybe a dumb idea: I'm wondering if we're doing this from the wrong
side.

Right now we have:

[some device op] -> [this new function] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features

Would it make more sense to go instead:

[some device op] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features -> [this new function]

?


Possible benefit: not forgetting to fix up the "extra" features in
some cases?  (ie calling netdev_change_features when we should have
called netdev_compute_master_upper_features)

> +}

-- 
Sabrina

