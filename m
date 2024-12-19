Return-Path: <netdev+bounces-153387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52379F7D29
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E4E16660A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED322541A;
	Thu, 19 Dec 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZd36j3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A2225419;
	Thu, 19 Dec 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618585; cv=none; b=lnaQdRdhcsoVw6yraOtn9qVodDgvQJ4+YVIvxjMxE5Y3MOg5foaPFwSmMvhAsou2Chw3YUr/795oZvj79N7ifzROKRajDWPiaPzNbNXaDRUFy4C6SoT5OnSnK+676vm5C+ykby34nVOBg5j2tcLMdKZJgs5/iDkkBKT1m04CTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618585; c=relaxed/simple;
	bh=FB3zN8u7NkyfjNY65kv5CcRxbDACn26FF53+F6xOJps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZdrAOWAIsM6MKAzOdFloXrGiGA3nBUb0zgHnCPrWSjzU99jOwPwtaZfBqtVR805E2yESSQnl60HXVBMDkF/7NIhEP8ta7RApKZzFxx4xb27onSZUmijhKMNT884fdDB8JQzLsJ2dWd/0vXG4Sd0VIk7QDTXHycCPEJSOETfGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZd36j3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD66EC4CED0;
	Thu, 19 Dec 2024 14:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734618585;
	bh=FB3zN8u7NkyfjNY65kv5CcRxbDACn26FF53+F6xOJps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZd36j3UcVAsaEMXgAzwHtqxQLGgvKgGl+jUR3hfvZodifoTokwq20tf6dc3dsTE6
	 G+5jrQADTUZ/INFAejn2nyoUuAGjhLyuz5k60I7KkvZbZI7HtyGaIC6sLf2Emb5qpW
	 VsYkcDVpl0kz5rnWnDZzIEAUALEzGBlngqPhCkePjqOuHbQAI5wmIo9xpF9VgbFG0j
	 RnLV3GkklufrLOIwR+01D3BsZqcHMMWxxLgmQeiadcC+Q1SOjaVhEJJgmIUMg/q2/K
	 JAFyj2r4P+ex9BxvGQv2uuANmrbRFGHAZpfdUHf+FSbHwdUGxtsZ6PvRSv9hc8gHUv
	 /3gAzF7V/BuEw==
Date: Thu, 19 Dec 2024 06:29:42 -0800
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
Message-ID: <20241219062942.0d84d992@kernel.org>
In-Reply-To: <CAMArcTXAm9_zMN0g_2pECbz3855xN48wvkwrO0gnPovy92nt8g@mail.gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-4-ap420073@gmail.com>
	<20241218182547.177d83f8@kernel.org>
	<CAMArcTXAm9_zMN0g_2pECbz3855xN48wvkwrO0gnPovy92nt8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 23:05:30 +0900 Taehee Yoo wrote:
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > > index f88b641533fc..1bfff7f29310 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > > @@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
> > >                           bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
> > >               return -EOPNOTSUPP;
> > >       }
> > > +     if (prog && bp->flags & BNXT_FLAG_HDS) {
> > > +             netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
> > > +             return -EOPNOTSUPP;
> > > +     }  
> >
> > And this check should also live in the core, now that core has access
> > to dev->ethtool->hds_config ? I think you can add this check to the
> > core in the same patch as the chunk referred to above.  
> 
> The bnxt_en disallows setting up both single and multi buffer XDP, but core
> checks only single buffer XDP. So, if multi buffer XDP is attaching to
> the bnxt_en driver when HDS is enabled, the core can't filter it.

Hm. Did you find this in the code, or did Broadcom folks suggest it?
AFAICT bnxt supports multi-buf XDP. Is there something in the code 
that special-cases aggregation but doesn't work for pure HDS?

