Return-Path: <netdev+bounces-131604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E55498F013
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AFC1F214AE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE3199386;
	Thu,  3 Oct 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vEkaMnYN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4921494DB
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961125; cv=none; b=uE0KKf+jGIE/dpyFKQfQak+JHTF2iu6NSqjlwxShCCwZtYA7gwSi0u2avM0Oyo0FB0b7+PfxS9xbp9FRGlZmqPG931ISu7Sk9/iMDD2uTmNMsEh+kMRn1dd6R4TrQk5COMbcfwhZtd2SpBv1q5uLrdqVUVv8OGJ6my8PyPq7WaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961125; c=relaxed/simple;
	bh=SD8HkOMJhM4qoa5j+cSUFRNsJqzu0DWh6znvW+5V7/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXllDETW7oGIOr2LfY6K9aaFapGVyqts0LOgBwRL2nBR9YghxZwxODH4vmjArkAdHd/jUJLq5js7Epfbx7CDfCaieAkNHhsMl0H6RjBixleU8w6dyLHhAmvmTebYK6NbcT7drahrglPrLdkL8M8mRJPLRR7Dg1uS545pdLKf4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vEkaMnYN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9Gs4wgpDHxpisGgy+r/z+PVhrHXygcptYleuaTGaRhU=; b=vE
	kaMnYNJZAWFYwPp6WmKxgr2gzOTMuIgavI/6lAuE+mnGUwaZ7u6/CSJFZdzC7CS/PZACVoL6U0S5y
	lsau+yD+mgo5csX5ZShmJiAICylr2z6dQTXDbFyol9lAdka3NAbcSOcAej9F2UsPZC/jNGiDgaDGl
	GNPRpdBfsUGaeWM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swLcZ-008wsA-7B; Thu, 03 Oct 2024 15:11:55 +0200
Date: Thu, 3 Oct 2024 15:11:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: dsa: Switch back to struct
 platform_driver::remove()
Message-ID: <d8adaca8-0fd7-43d6-9eef-76a0c826838c@lunn.ch>
References: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
 <36da477cb9fa0bffec32d50c2cf3d18e94a0e7e3.1727949050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36da477cb9fa0bffec32d50c2cf3d18e94a0e7e3.1727949050.git.u.kleine-koenig@baylibre.com>

On Thu, Oct 03, 2024 at 12:01:04PM +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/net/dsa to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

