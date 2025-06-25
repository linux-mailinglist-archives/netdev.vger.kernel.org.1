Return-Path: <netdev+bounces-201018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8381AE7DFD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735DA1BC4AEC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9D2BD588;
	Wed, 25 Jun 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfPTpJOx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7628136E;
	Wed, 25 Jun 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844655; cv=none; b=NIwoSL7A/3u8OQaB2p4dw+m0t+O3+rkfupvTf8omXt+xFTiKAZ7/qyZ6riARrBQjhG1kXD3FSGktUIDDfOF3CONueBuZKpRJwKe9F68XBuDWQaqM+haaizvjgDB+DU8lwd/Zjiqraa65G+KqAMX/RRSz3Iu5V/r8xp1zjUG8Qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844655; c=relaxed/simple;
	bh=W44FJCHamTXPtN10U+bjllFqugIjjnTsBA1YGbThxRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXfXbxMf2yMtp5vZoRyKqucDR5HIBwLHBgWuw5QLaBwLi4c5EzT8U8MERXY21Z2WGhLnXQ/4wXpGfTJrZM/JkZKpm9Pq0EtWS/JAVFi2snCGbeeGovQKFXcqlWaAtn6bPwVmq89IrboCr9VwkBGDwojZli1XBhci6YEYmVkbRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfPTpJOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBDDC4CEEA;
	Wed, 25 Jun 2025 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750844655;
	bh=W44FJCHamTXPtN10U+bjllFqugIjjnTsBA1YGbThxRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfPTpJOxbuMLdlTMAF+9mgPwUBR8J9wF8R1FHHTG/AYf5uLPtu66JDmM4kOPMXOqm
	 S+CE17kn0TWN3xnPG6GdGi+c/MhcPQShwaeNs48TacWFObdCejN543F4YPaW7lAunK
	 nr/sPNanr+JA74wdS46gs8GTePilYZwA83AzN22VXAt7ltxVg/dEzYwu51APvM6UfM
	 ln+KN77ghsEHASZMRzPa2REzw7wBNOhD+f/A29htGHmDdv2wrX/Q0GBGT94vewmJQV
	 XSQv2l1yLsfb8bH2OabsCyEe9dVtLYKw3yyGaN31k/luJwFdsANt7YGlogo0KH9oh5
	 56wn4q5tdWYnQ==
Date: Wed, 25 Jun 2025 10:44:11 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vlad URSU <vlad@ursu.me>
Subject: Re: [PATCH v3 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
Message-ID: <20250625094411.GM1562@horms.kernel.org>
References: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
 <5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>
 <20250624194237.GI1562@horms.kernel.org>
 <0407b67d-e63f-4a85-b3b4-1563335607dc@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0407b67d-e63f-4a85-b3b4-1563335607dc@jacekk.info>

On Tue, Jun 24, 2025 at 11:05:05PM +0200, Jacek Kowalski wrote:
> > > Unfortunately some systems have left the factory with an empty
> > > checksum. NVM is not modifiable on this platform, hence ignore
> > > checksum 0xFFFF on Tiger Lake systems to work around this.
> > 
> > I think that you need to update the patch description. As of v3 it's
> > the last word of the checksum that is being checked, not the entire
> > checksum.
> 
> As I understood it, "sum" is the resulting value while "checksum" is the
> value appended so that the "sum" is equal to some constant.
> 
> But my understanding is utterly broken by this line:
> 
> > > if (checksum != (u16)NVM_SUM) {
> 
> Where variable checksum (shall it be "sum"?) that includes
> "checksum" (or maybe checksum word?) from the *checksum* register address
> (NVM_CHECKSUM_REG) is compared to a constant called "NVM_SUM".

I agree with you in so far that there is room for interpretation on what
these terms mean. And I think your interpretation is internally consistent
(even if I might have interpreted things differently myself). But as you
say, the code seems to use these terms differently.

> Is something like this fine by you:
> 
> > Unfortunately some systems have left the factory with an unmodified
> > value of 0xFFFF at register address 0x3F (checksum word location).
> > So on Tiger Lake platform we ignore the computed checksum when such
> > condition is encountered.
> 
> ?

Yes, I think that matches the code change nicely.

> > > +#define NVM_CHECKSUM_FACTORY_DEFAULT 0xFFFF
> > 
> > Perhaps it is too long, but I liked Vlad's suggestion of naming this
> > NVM_CHECKSUM_WORD_FACTORY_DEFAULT.
> 
> I can update it as well once we agree on the wording.

Thanks.

> 
> 
> > > +	if (hw->mac.type == e1000_pch_tgp && nvm_data == NVM_CHECKSUM_FACTORY_DEFAULT) {
> > 
> > Please wrap the line above so it is 80 columns wide or less.
> 
> Wilco.

Likewise, thanks.

