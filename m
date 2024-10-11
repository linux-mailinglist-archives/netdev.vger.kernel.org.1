Return-Path: <netdev+bounces-134642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621399AAE4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1A428560B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544641BE854;
	Fri, 11 Oct 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eN3j79HV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CF1A070E;
	Fri, 11 Oct 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670394; cv=none; b=HZ5+CLxnGigBE7wY+T1nMjdG8ym/hTi+TD9e1D6NBVdpHpv5qsHY2fvnMSVXC5ILbYvzwbI0luTp1BiNZ2Fr/9kGqZelwxnXjUQs8rM54yaY3dpUUtyzLOcDs7pSZ3equJLZz9g6VxhHFaWZbpEJYv09agbBdRwDKz0e3qDVCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670394; c=relaxed/simple;
	bh=jnbhC213kd4emhfVyJ+XREvUMWIznLtqmGTU+VqR4oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8RAmnUj+g3QFu7WtDV5/M1NNfpL+lylgqqb68NdP35RSmWV3HW+WU0dCALz9N33zwJWjNN/vVulCm/1yZezu4Rn+884U8kuSfJlprU9jb1025HwPDBhwH6POtRXCjQmcXtaMGwoJ24OtgXur6cM7OK7B7lDLL2MK6KVhouc+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eN3j79HV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZNAh1l1/fxoRZwtgHn3zXzVz8802Imef5L4KPtHxgDo=; b=eN3j79HVQlZC3tuFDtDPExgxFJ
	Nu2KMaVrGt2IRYmanab7gG0fb+R6irHUi6RsokRo8kD9auxhy8sy/gqKMukUq5FoBSiRXzHIn9fuX
	piyzSSujeHHDV7BeeA1/zVXhyo6PV/bHbKYDrAp895Y4mKcAADNmLm+bDqDi17EREufg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1szK8C-009jZG-10; Fri, 11 Oct 2024 20:12:52 +0200
Date: Fri, 11 Oct 2024 20:12:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: allow forcing order
 of MDI pairs
Message-ID: <795c9b87-ecd5-4fa5-82ae-b88069cbaafb@lunn.ch>
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
 <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>
 <114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com>

> This change is breaking networking for one of our Tegra boards and on boot I
> am seeing ...
> 
>  tegra-mgbe 6800000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
>  tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY
>  (error: -22)
> 
> The issue is that of_property_read_u32() does not return -ENOENT if the
> property is missing, it actually returns -EINVAL. See the description of
> of_property_read_variable_u32_array() which is called by
> of_property_read_u32().
> 
> Andrew, can we drop this change from -next until this is fixed?

If it is as simple as s/ENOENT/EINVAL we should just fix it, rather
than revert it.

	Andrew

