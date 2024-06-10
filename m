Return-Path: <netdev+bounces-102253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2490218D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C832844DE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E197F48A;
	Mon, 10 Jun 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LR97d/lE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CF77113;
	Mon, 10 Jun 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022252; cv=none; b=AwJv1pK9Oc3tGOgp/Mp95A1b+36aQHtTPIh4h5iS6V4PEvFWZNfS7uZI6aoSOaXxjW/IpNuVFfHtJv+eb/ya0QqVThmr8VDG/3Uqf/jvYIbXKWHXBmIyIFeBVHIqTSskJc+uN2KKGKIMbtQayE9e1jGMyoKU5rUaT/abogY7dIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022252; c=relaxed/simple;
	bh=WxBt1LYI+G8crvipEAQbHlrmLEJVwJgdrizF3CAAUZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSsJX0wk/Y79AYfZULOfIlIpILeRs6T6OHwXmdHldXH8g8pIl+I57HOJq6Rp6k3FcDbup5Bu1QINkhIGN68L7fQAG5nQn88g9o+CszVgfcGzmpzgycR6u5Mb7jzOfVgqj3OcfAZeB9cwfLhC7fc78RNkdi+SCcu79jA6TR2+B8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LR97d/lE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MQkiYaJ4TVVyUT+MXJZg/wmEgVdFmPfhNbXdXG7OKQs=; b=LR97d/lELyX/p5wMACCy8eJYo2
	M/IrKN2DJofb3y4zUQ08h0xxTRK7wQKHCldVQichbVWsMIQ3lo4wRSL8HF2TpPSVftJcsZtPE2Ves
	GB95sh1rJ3yDwtvpWZL/p9BqOR5jAURrdQ2syYzskezF3J/uXU0Xt4pGx/ZBmxoHmaVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGe42-00HILq-Pt; Mon, 10 Jun 2024 14:23:54 +0200
Date: Mon, 10 Jun 2024 14:23:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0] net: dsa: mv88e6xxx: Add FID map cache
Message-ID: <e850b74d-fac6-4680-b9d0-fc2c3e1aa848@lunn.ch>
References: <20240610050724.2439780-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610050724.2439780-1-aryan.srivastava@alliedtelesis.co.nz>

On Mon, Jun 10, 2024 at 05:07:23PM +1200, Aryan Srivastava wrote:
> Add a cached FID bitmap. This mitigates the need to
> walk all VTU entries to find the next free FID.
> 
> Walk VTU once, then store read FID map into bitmap. Use
> and manipulate this bitmap from now on, instead of re-reading
> HW for the FID map.
> 
> The repeatedly VTU walks are costly can result in taking ~40 mins
> if ~4000 vlans are added. Caching the FID map reduces this time
> to <2 mins.

How long does the first walk take? Rather than having fid_populated, i
wounder if the walk should just be done in mv88e6xxx_vtu_setup() or
mv88e6xxx_atu_setup().

	Andrew

