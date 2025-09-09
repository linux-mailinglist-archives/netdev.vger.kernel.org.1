Return-Path: <netdev+bounces-221252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C2B4FE46
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8532A4E508B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02EE326D79;
	Tue,  9 Sep 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Slrf5eT9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFE23C4FD;
	Tue,  9 Sep 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425826; cv=none; b=gV4CeiPzksrosf6qBKNPYG253m/gseEV7g5qnVCooLGGRFQQw8cL32kKDIfwsZk6Ui/6p39Zb2Vh96Fl+iC9LmjZoSpkshSaKRtKh0m3UXvD6iTMsqvfkCYXOjOpo7Qmiyq/T5kpX6ZXBFZVxavqgFMCTraXZZy4MvC4fpylv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425826; c=relaxed/simple;
	bh=q+zUY/vk2UrM9H6v7dFhvCFkTobyJtpwX6RNiDWTzMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKeoy5CCQF7bYPlPmfLULW9PC2bAUK9R56RpQP2KNAf+O+d4O8WCPjLoJVYcDXzSawoI9bjfdWUGuI1QhQJXR8pWZub/H0fcfBqx4CNtdy/YO+khIv+KaZLMW+R1Vzx2g2ZiIdyp3Ct5QJw1c763KXtMazjA4fcyRRxkF2ZkO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Slrf5eT9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Szz+6SE1IvU4V5JqB9CbABoeZaRwNuKkUjBl+HR3CW8=; b=Sl
	rf5eT9DQ1Hc9h1g3TRf5gDELo/8bYpbpiC1zUuXSWu0YGHx+u36bQ9rfqPIrYIzZ6axfb9b21yu1H
	YV1DxGu0/zVURUAFhwhNt7G5JAp93zBjawfY4iFzUGpFPGO3lNqv7tezk8EXXrUXCJ1CRIF9VTWUN
	t+rCqg6NJLA7tYc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvyjY-007noZ-ID; Tue, 09 Sep 2025 15:50:08 +0200
Date: Tue, 9 Sep 2025 15:50:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
	mschmidt@redhat.com, poros@redhat.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
Message-ID: <350cecaf-9e41-4c34-8bc0-4b1c93b0ddfe@lunn.ch>
References: <20250815144736.1438060-1-ivecera@redhat.com>
 <20250820211350.GA1072343-robh@kernel.org>
 <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
 <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
 <bc39cdc9-c354-416d-896f-c2b3c3b64858@redhat.com>
 <CAL_JsqL5wQ+0Xcdo5T3FTyoa2csQ9aW8ZxxMxVOhRJpzc7fGhA@mail.gmail.com>
 <4dc015f7-63ad-4b44-8565-795648332ada@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dc015f7-63ad-4b44-8565-795648332ada@redhat.com>

> > > Yesterday I was considering the implementation from the DPLL driver's
> > > perspective and encountered a problem when the relation is defined from
> > > the Ethernet controller's perspective. In that case, it would be
> > > necessary to enumerate all devices that contain a “dpll” property whose
> > > value references this DPLL device.
> > 
> > Why is that?
> 
> Because the DPLL driver has to find a mac-address of the ethernet
> controller to generate clock identity that is used for DPLL device
> registration.

Maybe this API is the wrong way around? Maybe what you want is that
the MAC driver says to the DPLL driver: hey, you are my clock
provider, here is an ID to use, please start providing me a clock?

So it is the MAC driver which will follow the phandle, and then make a
call to bind the dpll to the MAC, and then provide it with the ID?

	Andrew

