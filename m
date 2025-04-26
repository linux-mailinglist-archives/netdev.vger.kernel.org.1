Return-Path: <netdev+bounces-186191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4CA9D698
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82AF1BC799E
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484471865E5;
	Sat, 26 Apr 2025 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSuDw74T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F1185B4C;
	Sat, 26 Apr 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626246; cv=none; b=TfYeSjICsKtkwtzg/0ZM9rDkBMdJa1s0JFxV8MmBgnzKDbBe1DZoHIXJLZjBFk+6CUxi7O8j4vdy7kd2ekDP+YTl6Sl5uqRo30S+CqCpuKjlEqisNS0/2zzzKZIQNtSD4xhQhWu74duZk6ems0BeZNtTD0HwC6x/Mwk28d2Y1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626246; c=relaxed/simple;
	bh=bNU4pzJ5wlqCuRsV/oqD019TNucqvQgOF77N/7cF9b4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIbpep1i4uymGLDWOFTDyczg41QZkQwgddykSDCc3qHLLfBTjNjAAo9O7xEwWp2wZWySanrlHMN1fjY1k1mHkt+CcP7wq85jgr2AnIgQ9pp4sAqPxB3O+L7NklvNXsH0sQG74LER+PhLSe6TqnBBMmFcEDbH8leVnVobObkgfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSuDw74T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5596C4CEE4;
	Sat, 26 Apr 2025 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745626245;
	bh=bNU4pzJ5wlqCuRsV/oqD019TNucqvQgOF77N/7cF9b4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSuDw74T5JJzoD9haGpUGjLMrnO7eW7vl9bNtoMaSpLxYJaXjQaF2SL0ROZ5tZpL6
	 uhVHMNs2sX3Sy7hrn+V4xAs188NIwGIRYTCtp2UUQ9DTKNQ1QpG+NFQRc0jUd7EPp5
	 MVzPldxEce3Dho/4MZHwpExbrfNzg/514zYv3Hw+H+yOUV/EJjzNCP2WM9YZkFlnAW
	 a9yp9owECLh8Au3qvA/UvtvyLP7UlTlTJHBRftszNAgr5/FDFHLKUECsKX3Wk1XnD2
	 k+Z1jft3IweZ0Pqi+o54tiucnHLO8+bnJ1g3LlAd1zam7Bn2WNnNiwUhmWqdEg44Y3
	 3KtyETx0rqh5A==
Date: Fri, 25 Apr 2025 17:10:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250425171044.4a9e1b4a@kernel.org>
In-Reply-To: <20250425090153.170f11bd@device-40.home>
References: <20250422161717.164440-1-maxime.chevallier@bootlin.com>
	<20250422161717.164440-2-maxime.chevallier@bootlin.com>
	<20250424180333.035ff7d3@kernel.org>
	<20250425090153.170f11bd@device-40.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 09:01:53 +0200 Maxime Chevallier wrote:
> > > +/* perphy ->dumpit() handler for GET requests. */
> > > +static int ethnl_perphy_dumpit(struct sk_buff *skb,
> > > +			       struct netlink_callback *cb)
> > > +{
> > > +	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
> > > +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> > > +	int ret = 0;
> > > +
> > > +	if (ethnl_ctx->req_info->dev) {
> > > +		ret = ethnl_perphy_dump_one_dev(skb, ethnl_ctx->req_info->dev,
> > > +						ctx, genl_info_dump(cb));
> > > +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> > > +			ret = skb->len;
> > > +
> > > +		netdev_put(ethnl_ctx->req_info->dev,
> > > +			   &ethnl_ctx->req_info->dev_tracker);    
> > 
> > You have to release this in .done
> > dumpit gets called multiple times until we run out of objects to dump.
> > OTOH user may close the socket without finishing the dump operation.
> > So all .dumpit implementations must be "balanced". The only state we
> > should touch in them is the dump context to know where to pick up from
> > next time.  
> 
> Thanks for poiting it out.
> 
> Now that you say that, I guess that I should also move the reftracker
> I'm using for the netdev_hold in ethnl_perphy_dump_one_dev() call to
> struct ethnl_perphy_dump_ctx ? That way we make sure the netdev doesn't
> go away in-between the multiple .dumpit() calls then...
> 
> Is that correct ?

Probably not. That'd allow an unprivileged user space program to take 
a ref on a netdev, and never call recv() to make progress on the dump.

The possibility that the netdev may disappear half way thru is inherent
to the netlink dump model. We will pick back up within that netdev
based on its ifindex, no need to hold it.

