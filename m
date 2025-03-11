Return-Path: <netdev+bounces-174049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FAA5D2A1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A160189E124
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0742265606;
	Tue, 11 Mar 2025 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCGjBtZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4C264FA2;
	Tue, 11 Mar 2025 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732706; cv=none; b=RBUFVtCHmWGFqaC30yK1otblxCPzHbAYautUwmqaRHCg5prCTBrZmh+Vn5vm4cT9qGziLTCYf/VvBMVItC3xcCc6b4nexSXch2oYSkqrp0c1+u9BAezO1HHAQd+fR5vT7AUdAF6Ri2mIW6cP7T83PjAC1fAbFwZ1x5iYOQIDjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732706; c=relaxed/simple;
	bh=daWNpmHArVO4A/jBap6EauRlXOo7HVzttmBmJWNmuEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGQda8v+xB6Phn5rqVlxl7hZCFW7oVabSgYlUGGtSxLKKNnm2QWtv2Xv2+AGMrc1N4UFTwhT3Dy/4lhZdqXXztitfLkwHYNlNNTPNGQr0FFHzXAwC0LdfFSKU5QskqM9/lvGFyUqcJxuLojc2PNLypxh+SiO4vEpBWpJHqfqcCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCGjBtZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6436FC4CEE9;
	Tue, 11 Mar 2025 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741732706;
	bh=daWNpmHArVO4A/jBap6EauRlXOo7HVzttmBmJWNmuEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCGjBtZV7NW4TiiiryUPUid23RjYPD465/iFpWGbU4m81sY514rNuhJJjvS2PE+7f
	 krklT27pZwwSqIoCrXgelhRJ/dvKyMNkZ2TARLXOivGm0juUcoxelBeU58JxmrA3XG
	 /xeV3A8BiLEESaLn+xemxbQEBWAGwBXA9sglk0LUIcy3vsH4h30e2W/vkFqI/5FFgB
	 jNnCw5GHG4igOC5qL5IdjHRdNplVHPNBnPbg6UN2QBTqGM8yugAhLUKNfiodvN4hIO
	 vjbSm7hu0JV1QTtFQ2q7SANzjuwMvpkevRV5cnGgzv50aN1xMKKfuvwLzt5k/pdKWy
	 J2f1bm4IhJaPQ==
Date: Tue, 11 Mar 2025 15:38:22 -0700
From: Kees Cook <kees@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: macb: Truncate TX1519CNT for trailing NUL
Message-ID: <202503111537.C6D088B39B@keescook>
References: <20250310222415.work.815-kees@kernel.org>
 <Z8/l8eM5u7QeUROt@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8/l8eM5u7QeUROt@mev-dev.igk.intel.com>

On Tue, Mar 11, 2025 at 08:27:45AM +0100, Michal Swiatkowski wrote:
> On Mon, Mar 10, 2025 at 03:24:16PM -0700, Kees Cook wrote:
> > GCC 15's -Wunterminated-string-initialization saw that this string was
> > being truncated. Adjust the initializer so that the needed final NUL
> > character will be present.
> > 
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  drivers/net/ethernet/cadence/macb.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> > index 2847278d9cd4..9a6acb97c82d 100644
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
> > @@ -1067,7 +1067,8 @@ static const struct gem_statistic gem_statistics[] = {
> >  	GEM_STAT_TITLE(TX256CNT, "tx_256_511_byte_frames"),
> >  	GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
> >  	GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
> > -	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
> > +	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frame"),
> > +
> >  	GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
> >  			    GEM_BIT(NDS_TXERR)|GEM_BIT(NDS_TXFIFOERR)),
> >  	GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",
> 
> "rx_greater_than_1518_byte_frames" is also 32, probably you should fix
> that too.

Ah! So it is, thank you. I must have missed it while grinding through
all the warnings I was working on. I will adjust this!

-- 
Kees Cook

