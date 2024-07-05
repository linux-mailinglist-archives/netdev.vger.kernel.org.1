Return-Path: <netdev+bounces-109515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B2928A9B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8291C23C48
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026616C690;
	Fri,  5 Jul 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3rWRPeZb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1516B3B9
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189189; cv=none; b=QF+R5Weyt4K9aY3NZKawxb48jJkgJixYJJsVdHUTTlGL4bgLGRK6dcO0E8naTuPSp26uTKfeVp/neDvnnes8wQBKpC5wI4TLm+/AGVGmYEShMFnyWd+6Juet04Vip8kmDIJNU8EPOyfHoOSC6a5cZz2H1fW1PjTgXZhZIGIg5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189189; c=relaxed/simple;
	bh=1Dygpl06jFVVM6wrZmiCZe9AP+iH7OukKCY3YCcJ5QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFBJ7Bt/gBgCbV9V4JMPKYBexMeEOzpy68LHp+yGIYc8XOk5QN5w7g8fRKxM3Ma6NbJ3/SdtPfPYLI2L93eQZqpbqq9zFM5b205LqZ5ZR3G3ymZIBfhbclTWml50eN+GsTpDiu/ezGHT4BYfwbl4VTbT0UKXj3HlBdA2+nTMOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3rWRPeZb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4TncQTk9jtPVo0pI7ZF1TxvKH5f0Gl9QkbrKgKvpt4o=; b=3rWRPeZbfl3u3tMy6zUcrZL8SW
	o3TXjcSL7YJy6Zx+WGYepqAvST5UrzrLxY3gOtuGII44EjByXsT/ozOVzt8Kwmi5eWf4tDkt7/LUe
	AZxoND6+/R0SYVsLfqbM/BW3VC4OYnOigPLjNM6oP58VT1T9KVhig3FMexCCz31FNH/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sPjmm-001tnL-9I; Fri, 05 Jul 2024 16:19:40 +0200
Date: Fri, 5 Jul 2024 16:19:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
Message-ID: <7eab05e6-4192-4888-9b6a-6427dc709623@lunn.ch>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>

On Fri, Jul 05, 2024 at 02:33:31PM +0200, Johannes Berg wrote:
> On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Date: Fri,  5 Jul 2024 13:42:06 +0200
> > 
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > WARN_ON_ONCE("string") doesn't really do what appears to
> > > be intended, so fix that.
> > > 
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > 
> > "Fixes:" tag?
> 
> There keep being discussions around this so I have no idea what's the
> guideline-du-jour ... It changes the code but it's not really an issue?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

> It must either fix a real bug that bothers people or just add a device ID.

It is clearly not the last. So does this actually bother people? I
would say no, the WARN_ON_ONCE() will fire, it will just not be as
helpful as it could be. So for me, this is net-next material and no
need to have it backported to stable.

	Andrew

