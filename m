Return-Path: <netdev+bounces-167936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543A2A3CE6B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E22F18900A0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 01:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5512AEFE;
	Thu, 20 Feb 2025 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfAuMPYq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279923A0;
	Thu, 20 Feb 2025 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013660; cv=none; b=jbn799ZyITfT++2MbHtlD7+6j4sL6K2qAHhhF9nC0oIPkzHpMz8FtfDQMhWziTrKJ0WRGingq1albopKgv380iCtA7DY0vDybaw57IPv/q+BMnhfsqQOeckC1wC03TGNnT93bRrOEaOQZx3/0bkeQsOcw1xcPRkiVBe6bb5xnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013660; c=relaxed/simple;
	bh=IXRpGB7uDUnhmqWJ1/W2fqWqvDKPGkRzkpS+hVtJbJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1TRbw2RY9HN9S/B/S2IOWW9LakNU1u7sdYa2uRoPAqYY7Za9S4Gzb5TPFPxMc6obi8yWwD+V/9QjKrnomy+ICQIycWGiYqosTDktz8lQfpBeX6gGwZ+W9YQXdU3DE3zfmeZCDem55is2hP9GubSTz2jV1q+dflLzugVrEnS/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfAuMPYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8B5C4CED1;
	Thu, 20 Feb 2025 01:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740013659;
	bh=IXRpGB7uDUnhmqWJ1/W2fqWqvDKPGkRzkpS+hVtJbJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfAuMPYq9cV7XmfYjWLOjgfT3I8/hllgctTjceietDwUuH0HmxTXRBvprxpGQWlP2
	 LCOLRpb5AcoeGdssdzPUGy2u+XHZzYh9KpDQwLTwvl3GBx+DEU3aMZ0VPR9A1H1G68
	 ZJy3J9Jq3OxSoPPfm17N5DrnAaj/HqKA1W0+ElYD5nmglHy/DC/ITdzXorEC9tTxZP
	 7B3AukKVFQGBw/OYVfIcukkRwzTmIo2SiMup3qDsU2WtRvg6OG0TGvpNnPcw8UFfsK
	 Z/BoxR6H+pe9Eu+g0naubT64FyLUmBHU78ikztJ5cZxURdr3lcMZ27G/HXNy7D3Ce8
	 rXyqlUmwkT8fw==
Date: Wed, 19 Feb 2025 17:07:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, almasrymina@google.com,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 dw@davidwei.uk, sdf@fomichev.me, asml.silence@gmail.com,
 brett.creeley@amd.com, linux-doc@vger.kernel.org,
 kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v9 07/10] bnxt_en: add support for
 tcp-data-split ethtool command
Message-ID: <20250219170737.25a3a4ed@kernel.org>
In-Reply-To: <lq62gh5sua72thbwswtodutom44d77nar2pxo7gue4h3w2muoc@tpol55i7vic5>
References: <20250114142852.3364986-1-ap420073@gmail.com>
	<20250114142852.3364986-8-ap420073@gmail.com>
	<lq62gh5sua72thbwswtodutom44d77nar2pxo7gue4h3w2muoc@tpol55i7vic5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 10:11:01 -0700 Daniel Xu wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > index f88b641533fc..1bfff7f29310 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > @@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
> >  			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
> >  		return -EOPNOTSUPP;
> >  	}
> > +	if (prog && bp->flags & BNXT_FLAG_HDS) {
> > +		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
> > +		return -EOPNOTSUPP;
> > +	}  
> 
> I think there might be a bug here. On my 6.13 (ish) kernel when I try to
> install an XDP driver mode program, I get:
> 
>     [Tue Feb 18 17:02:14 2025] bnxt_en 0000:01:00.0 eth0: XDP is disallowed when HDS is enabled.
> 
> Setting HDS to auto (seems like off isn't supported?) doesn't seem to
> help either:

This should fix it, I think:

https://lore.kernel.org/20250220005318.560733-1-kuba@kernel.org

