Return-Path: <netdev+bounces-129473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67173984132
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22376281DD5
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33B154426;
	Tue, 24 Sep 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqNq6PQy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264331537D9;
	Tue, 24 Sep 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168190; cv=none; b=kp94dISWEvvNSpSNJ3SgI+gQap9pXPLcuEiytzzDuW7nrX9b3W2NilTYppamurqExSzapifXsru19ocITMGqJyrh5O5RYd1VEd2taKMYhfdSJkblSCwMv3IdzR2TiqkpD5au6v4H6ZaGqoYrE6apuvIlsB550EQZmOaujzFteog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168190; c=relaxed/simple;
	bh=l2WaCC6osdjx7ypvsbjBOYNMI1Da/nkosnrB7tAbh9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5ScylOBkJ2f4lRTJ7hBRBPzxovFuYbwedwHfQU+wTEM/170HDcXKsIp3WgaxlePF5HMMEYFDtD0o2+3DcTRAb/b1WsM2nUiom5V2JVZdp3qCRIEk8qu9Vy2KU/mc344m/jyinYf9t4tcsbclIK5KeGHg1VZunHFBcDvzSpKISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqNq6PQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4264C4CEC4;
	Tue, 24 Sep 2024 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727168189;
	bh=l2WaCC6osdjx7ypvsbjBOYNMI1Da/nkosnrB7tAbh9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqNq6PQyhWcCTgga3S9H93wjmoK9yJyNTuShx6e1Vc+Oo9zCp5ECk16HAjfmhRIm/
	 I+v75C3kpc9BGDtOaNNipkdS3T6KcPH2SRSGxAcg2oLfwxqwPLtNlWyvwjGcNqTRnp
	 WUd5ai/qCi9tdM2X/f//xwD4ON4fHvGrykOBUzQuBr3j8hESz4LYjtaPH1n4R8BgJh
	 0fp81Plvd1t0eG1mO3RQnZ5vgHorQWSObSa1rSuU47yp1nMhNq5mWlbxPrc06ZrWJg
	 pPa8EtqJUOw9mFDNAXhP1SmXBvynDkEm0x5T8mGaJ4jAZcnOEjltevu0599jkDkvjd
	 +jLoxU1rKyNxA==
Date: Tue, 24 Sep 2024 09:56:21 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for
 bitmask checks
Message-ID: <20240924085621.GG4029621@kernel.org>
References: <20240923153427.2135263-1-kory.maincent@bootlin.com>
 <20240924071839.GD4029621@kernel.org>
 <20240924101529.0093994d@kmaincent-XPS-13-7390>
 <20240924082612.GF4029621@kernel.org>
 <20240924103357.1ca3d22f@kmaincent-XPS-13-7390>
 <ZvJ71uWZygUxrmEo@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvJ71uWZygUxrmEo@pengutronix.de>

On Tue, Sep 24, 2024 at 10:44:06AM +0200, Oleksij Rempel wrote:
> On Tue, Sep 24, 2024 at 10:33:57AM +0200, Kory Maincent wrote:
> > On Tue, 24 Sep 2024 09:26:12 +0100
> > Simon Horman <horms@kernel.org> wrote:
> > 
> > > > Don't know about it but if I can remove it from my driver it would be nice.
> > > > :)  
> > > 
> > > Right, no question from my side that this change is a good one.
> > > I'm just wondering if it is best for net or net-next.
> > 
> > Indeed, I don't know the policy on this. Do you think it shouldn't go to net?
> > I will let net maintainers decide. ;)
> 
> The net is always the right place for this kind of fixes. In any case, it
> would be better to have actual symptoms of the issue addressed by
> this patch in the commit message.

Thanks, I think that would address my questions about this patch.

