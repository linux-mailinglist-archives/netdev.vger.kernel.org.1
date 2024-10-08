Return-Path: <netdev+bounces-133291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A281499579A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193A0B25861
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F02213EC7;
	Tue,  8 Oct 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaCkyej6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69C212F1D;
	Tue,  8 Oct 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415703; cv=none; b=RWYu51d0+tglfR+u08XyEYr8OSi+fY9f/rzz8Tf1lUA79/VAdeHOWc6sw4lcQYwE7vE8TGA6vXuQWzaR0KxQJC/8UR+faAz0aI2UOeZqDJh3Vzg1K2INlKxN/Utq0BzsU2LtPGA+GzxccF80QWrTKwoga9aSEfuj5ICqeGgWCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415703; c=relaxed/simple;
	bh=RK25T107lI4DmIJDuzw6Hn5qqZ616GbPfczJPYgzaQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTs9MxXlBek/LnNlA09Xx8qq4tatH1AN/tIeMU+fZuv9AUlHmE2pGBi2BsAwe+cYYb7PrEF+cglbZxmGDVbaHZT1KOisXZ/vR3KgSh9foUY4k9uiLylBAjRSkIoKrb6zYrpB0XJ1P1D/EgoBvGH1lvHQ/RkOvRIfJJZKe5Qv9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaCkyej6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207DFC4AF09;
	Tue,  8 Oct 2024 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728415702;
	bh=RK25T107lI4DmIJDuzw6Hn5qqZ616GbPfczJPYgzaQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eaCkyej6FjktBi9FIK7a6xbjyvMg4zh5OFyjp6VfVMc6g9BtkGTJAWqLkNkTqAghk
	 qnlJLI5rVhI0aBMbVG35BtBlYqmMqmg7TqEsRlfeIe0jyEJHlDua/3qBeqUlgERSok
	 L4QImpOnjmiCBDf2AIRY8fJMM7FHjKm9pZGeva2g152Lt9hgxi6D2quiI+4ij0UMJc
	 Z2d3mhSkOwisQ7TlT0CWt9CQlnX0XvDS7lUMDmqErgr0ArG0bbFkshJEVmgswEhCa8
	 aTlRFirfqCKz4oL0hRCFe40Fg0xSbE5pklLEpa4HZHaew/kb6pKtkSaG0ECZnfP8/q
	 LqmBIjDTsiOlw==
Date: Tue, 8 Oct 2024 12:28:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Brett Creeley <bcreeley@amd.com>, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com, kory.maincent@bootlin.com,
 andrew@lunn.ch, maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com
Subject: Re: [PATCH net-next v3 5/7] net: devmem: add ring parameter
 filtering
Message-ID: <20241008122820.71f67378@kernel.org>
In-Reply-To: <CAHS8izPmg8CJNYVQfdJB9BoyE75qf+wrz_68pTDdYffpEWDQMg@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-6-ap420073@gmail.com>
	<70c16ec6-c1e8-4de2-8da7-a9cc83df816a@amd.com>
	<CAHS8izPmg8CJNYVQfdJB9BoyE75qf+wrz_68pTDdYffpEWDQMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 11:49:50 -0700 Mina Almasry wrote:
> > > +       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> > > +                                       &kernel_ringparam, extack);
> > > +       if (kernel_ringparam.tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
> > > +           kernel_ringparam.tcp_data_split_thresh) {
> > > +               NL_SET_ERR_MSG(extack,
> > > +                              "tcp-header-data-split is disabled or threshold is not zero");
> > > +               return -EINVAL;
> > > +       }
> > > +  
> > Maybe just my personal opinion, but IMHO these checks should be separate
> > so the error message can be more concise/clear.
> >  
> 
> Good point. The error message in itself is valuable.

If you mean that the error message is more intuitive than debugging why
PP_FLAG_ALLOW_UNREADABLE_NETMEM isn't set - I agree :)

I vote to keep the patch, FWIW. Maybe add a comment that for now drivers
should not set PP_FLAG_ALLOW_UNREADABLE_NETMEM, anyway, but this gives
us better debuggability, and in the future we may find cases where
doing a copy is cheaper than buffer circulation (and therefore may lift
this check).

