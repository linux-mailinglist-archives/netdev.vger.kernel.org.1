Return-Path: <netdev+bounces-228215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB692BC4DDE
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE503E1C4F
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4BF2494FE;
	Wed,  8 Oct 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GuevdtlZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB153F9FB;
	Wed,  8 Oct 2025 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927151; cv=none; b=gI86qg/p4uGyz7+YePmVKSHnF6upVS6o64AO0/J0Enx+UrCR1Tl4ohP219RnpnsFC0R3zC7hNw/cCfIDomP//5ALBcZWyRWj6Po5YaAn8jcfZd82HpwqdFmjU62Ck288vOpBM9mUpD+C/TY28PF7bpf/e3nFW2wS9H6qwYkMlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927151; c=relaxed/simple;
	bh=uqFeHCHEdmppnNDUEAbUawlRMRfJfab7jqYkIwxENrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3KmCKw6FXhKDq1F8W1P7uBHnQ9uP0M2YliTA1BzJHzK005GupNYzfxMi/feBRFlxWdJNgwhrdRt4z5mILMBbtfQsvVV+pCZ0FzRYbaOuJfCafbRGCsDWwx+pbDl+wf1Le0jJ8Uc8AMf7R+vuujh25Wrb6p34iEwgzaU2Id7y+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GuevdtlZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TshhvW/gfh9QydjJNrssGopp+xrjGD3PPRULh3PF/6U=; b=GuevdtlZX8wZReV4UBX9KFEzPJ
	ZvH8nuYFtri8zX9f6B70qlx1Odq92d5zqNEL3kqqTUeb5uZ5tkQM2CDxgBWpCCimzZpJKqsoP3gnh
	XCJjl/wRU+vXVdcxjpJTgbPazVirD5PcMgNy9tt0xtkihYS3y/XrPWXmSruvA2vQJndg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v6TRU-00AR9B-LO; Wed, 08 Oct 2025 14:38:52 +0200
Date: Wed, 8 Oct 2025 14:38:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Conor Dooley <conor@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <e14c6932-efc9-4bf2-a07b-6bbb56d7ffbd@lunn.ch>
References: <20251004180351.118779-2-thomas@wismer.xyz>
 <20251004180351.118779-8-thomas@wismer.xyz>
 <20251007-stipulate-replace-1be954b0e7d2@spud>
 <20251008135243.22a908ec@pavilion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008135243.22a908ec@pavilion>

On Wed, Oct 08, 2025 at 01:52:43PM +0200, Thomas Wismer wrote:
> Am Tue, 7 Oct 2025 21:40:03 +0100
> schrieb Conor Dooley <conor@kernel.org>:
> 
> > On Sat, Oct 04, 2025 at 08:03:53PM +0200, Thomas Wismer wrote:
> > > From: Thomas Wismer <thomas.wismer@scs.ch>
> > > 
> > > Add the TPS23881B I2C power sourcing equipment controller to the
> > > list of supported devices.  
> > 
> > Missing an explanation for why a fallback compatible is not suitable
> > here. Seems like it is, if the only difference is that the firmware is
> > not required to be refreshed, provided that loading the non-B firmware
> > on a B device would not be problematic.
> 
> Loading the non-B firmware on a B device is indeed problematic. I'll
> append the following paragraph to the patch when reposting it after
> the current merge window has closed.

Is it possible to ask the device what it is?

If you can, maybe you don't even need a new compatible, just load the
appropriate firmware depending on what the device says it is.

	Andrew

