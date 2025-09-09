Return-Path: <netdev+bounces-221137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C950B4A78F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F7F16E687
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01045305972;
	Tue,  9 Sep 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huvR+DMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1BA304980;
	Tue,  9 Sep 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409354; cv=none; b=md/fE3oacnBPeciPOpSIuoLHe3UP1+ADlkqSCpBKwqHfAuHEomNqZhf9rVYipXEg6VCJChUfzOgUgwAMjCLaOxpMrGzyY+7Y3Yq5mKyFMKnF6FOlMXDOsOungNbQyemg1XFrOrLaFtQxRfVYvoNTxQpRW0SsbIxAF3x5RFx/D1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409354; c=relaxed/simple;
	bh=KEUSLfMMWB84n7xGRN2SjgOotEQ+TRM8VUQ+2PeCgJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTSpHtp8yTgVB4vkGK2xmCpU+bCrk/pldrahBT8lk5zgzCxZmUF9iya8KLlDxTbBCEVt/oaTisvsZfeXF40ElXCA+Xht1rY/orM8Gc6Y18/nJY0f6WEHxzwEBv3XwUabU8CCF2KVJLEweCY4x5UXBZ8jGgz8rP3zhc2JitOFHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huvR+DMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FB3C4CEF5;
	Tue,  9 Sep 2025 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757409354;
	bh=KEUSLfMMWB84n7xGRN2SjgOotEQ+TRM8VUQ+2PeCgJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huvR+DMX/VdgIqdU+01Zkr09A/ol3h1HFuMavOqpA4amye8tc/KoxhrDtl0kM5OFk
	 fNv3dTw2WWLU0BBvrOgy74OSva0JjyE4cOXsqn/KfRa8L0BChj0um/pli9OcSRKBC7
	 D5NQEA0utsrwkvWnrWaitCLquTHZkbxFM285zH/cKQVb1vl0n/1GR50ITM7422erS3
	 LjgBFOZen8H/WE8Ers9scHzBVCm0wzU2Wt7JSZL95CF4phNVFQfhE60WV1rSqJZIrS
	 UG0FKsBV0vMUbgH9LbzZW6nnJ2mNkuvhS8fl2JGYjOIMrnl81H4ic0PAKl1Btw7r8h
	 Eu8EEJbTTv/ww==
Date: Tue, 9 Sep 2025 10:15:50 +0100
From: Simon Horman <horms@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: netdev@vger.kernel.org, Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: make RX page order tunable via module
 param
Message-ID: <20250909091550.GA13871@horms.kernel.org>
References: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>
 <20250909091313.GF2015@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909091313.GF2015@horms.kernel.org>

On Tue, Sep 09, 2025 at 10:13:17AM +0100, Simon Horman wrote:
> On Sat, Sep 06, 2025 at 09:54:34PM +0800, Yangyu Chen wrote:

...

> > diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> > index b24eaa5283fa..48f35fbf9a70 100644
> > --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> > +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> > @@ -40,6 +40,10 @@ static unsigned int aq_itr_rx;
> >  module_param_named(aq_itr_rx, aq_itr_rx, uint, 0644);
> >  MODULE_PARM_DESC(aq_itr_rx, "RX interrupt throttle rate");
> >  
> > +static unsigned int rxpageorder = AQ_CFG_RX_PAGEORDER;
> > +module_param_named(rxpageorder, rxpageorder, uint, 0644);
> > +MODULE_PARM_DESC(rxpageorder, "RX page order");
> > +
> 
> Unfortunately adding new module parameters to networking drivers
> is strongly discouraged. Can we find another way to address the problem
> described in your cover: e.g.
> 
> 1. Changing the fixed value
> 2. Somehow making the value auto detected
> 3. Some other mechanism to allow the user to configure the value, e.g. devlink
> 
> ...

Oops. I now see that Andrew and Jakub already responded.
And my comment doesn't add much. Sorry about that.

