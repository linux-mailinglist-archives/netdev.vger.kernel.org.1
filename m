Return-Path: <netdev+bounces-236594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A98E7C3E381
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F54E1885868
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF592EBB88;
	Fri,  7 Nov 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEuw8f4l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804626FA4E
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481610; cv=none; b=uDJuwEk6sH5KtWCDzYBEW0MjrHKkfMqOHudCGkb+4jdZsTp6NRjFyKzYwdyAn82RL/XS1q3Nw5tEN/+rLusTcaL/FHkzQtXDl2vPrC4qv3gHBHDw5CBeGl0ho3ueZXPDJWmBOFjLonRxfam1Ceidk4sqtsKQL75zP0C9vjqrzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481610; c=relaxed/simple;
	bh=yI9/btSbMlag2p/FMyM8VJQDk13VaetD5zbbw1FiH2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4t411RVW/qJz+Nxn0lGv8MArfc5Q0UNZE3uCH3GjZaL4tJnOGymuQanjoIfzf3aD7lc9bvMEBRcb4KluuTZyyR3+KCEJvYz9Z+gRf+iTs8XapPYim8d3VH/ToSS62MUN8WndddnqbzLfRUeyzesfSY4xy6l7pQX49nRJS3wURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEuw8f4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC9BC116D0;
	Fri,  7 Nov 2025 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762481609;
	bh=yI9/btSbMlag2p/FMyM8VJQDk13VaetD5zbbw1FiH2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gEuw8f4lnVWFwq0AintG9EObs8Wd5iwmAe3tsBoUxPQdIqA/6oohX+h2khQY8Jn/d
	 uYtdZwQzfB4LhsZUV5fjDwO+zqECqrjwzp4YYaKmZN82oDApjkVGHrq+a2F1grmkfD
	 HliXSCg4XYTnv0ZRudRCn0YSaYWY9shj8Ay9LK2/Og0WIeRpLX/Ik2iFFrFzh9n35s
	 OryBmBpL2/0pmB1Jk9ItWZ//hLCmWYTs5q7pfhC7TReNh8RUkxDMs/sRXJ/3Cl2Ni9
	 2R3KzjridB5tfP8k9+RJuwSDe/IWSqCV/mUclrMmtCMQfZES6G+JPIuZGtk/3MjfCR
	 BbUAnbtfSlWiQ==
Date: Thu, 6 Nov 2025 18:13:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. 
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo 
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim 
 Fedorenko <vadim.fedorenko@linux.dev>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 3/5] eea: probe the netdevice and create
 adminq
Message-ID: <20251106181328.25661cea@kernel.org>
In-Reply-To: <1762481052.9107397-1-xuanzhuo@linux.alibaba.com>
References: <20251105013419.10296-1-xuanzhuo@linux.alibaba.com>
	<20251105013419.10296-4-xuanzhuo@linux.alibaba.com>
	<20251106180111.1a71c2ea@kernel.org>
	<1762481052.9107397-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 10:04:12 +0800 Xuan Zhuo wrote:
> > > +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> > > +	int err;
> > > +	u32 mtu;
> > > +
> > > +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> > > +	if (!cfg)
> > > +		return -ENOMEM;
> > > +
> > > +	err = eea_adminq_query_cfg(enet, cfg);
> > > +	if (err)
> > > +		return err;  
> >
> > AFAICT this is leaking cfg  
> 
> cfg is freed by __free(kfree).

Oh, sorry, please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
don't use __free() in drivers.

