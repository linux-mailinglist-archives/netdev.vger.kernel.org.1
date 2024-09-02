Return-Path: <netdev+bounces-124207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA199968855
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FFF283750
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBAD205E16;
	Mon,  2 Sep 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xp0TbXSm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC07205E13;
	Mon,  2 Sep 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282195; cv=none; b=W14Pxz/myduDV1EL9eQxe4oVzC7k8c0k7ARfYUFaO8VcXL27rtFi9ynd0wf5aAtwswP4vTsC8GtESftU5GQavOLHcGA4nbsOy+0T9kh8FSiMfWUR/kmZ5uqPjFKNMitc+MkzT14pfqKrk35jbsTFicsk9XGfWgSaHw2erzSESVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282195; c=relaxed/simple;
	bh=nSIF/RQGx5zQtCXbmymoOL7oYYS9z5GWXT5pcvJmmpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE8S/Nw+FBPK1UuAzc90HbhWDeP6l9UmpV80JeS1RP09V8pBuU2iRwLHQGk6dy/KYnrD8Uni+YbMOmSA5DXcG98cqRC4MKLUomjyxUjC/XHD5bvv7pVrnDLI6QOzxsvSvAcmc65rYHbPpkCex37fjxzPbqHNhQ4y347oWALm6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xp0TbXSm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U3Xd6kNh6CWaWB54nOF4pQA55V5GFAOUyi4PSPw4mso=; b=Xp0TbXSm9K+7hX6rneaiKXKWOw
	DDsd+SHAzXFKWIy3tHK4eMfCmpO9qTpnlUeur5aRAbFy5ifalISetHhASYuLzRwJqh1N8FRC6Ar6B
	BejECX62TVOxatTNlP0siah1an1G0g1w32GoX3lqlEspelxX4STuHckYiWrImL1cD8uc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sl6hl-006J03-Di; Mon, 02 Sep 2024 15:02:49 +0200
Date: Mon, 2 Sep 2024 15:02:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
Message-ID: <f2598368-745f-4a83-abfc-b9609ebff6b0@lunn.ch>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-4-danishanwar@ti.com>
 <22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org>
 <177dd95f-8577-4096-a3e8-061d29b88e9c@lunn.ch>
 <040b3b26-a7ef-47c7-845d-068a0c734e61@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040b3b26-a7ef-47c7-845d-068a0c734e61@ti.com>

> Yes, and I have already added this in this series based on your feedback
> on v2.
> 
> I have one question though, in emac_ndo_set_features() should I change
> these HSR related features irrespective of the current mode?
> 
> AFAIK, if NETIF_F_HW_HSR_FWD is set, the forwarding is offloaded to HW.
> If NETIF_F_HW_HSR_FWD is not set the forwarding is not offloaded to HW
> and is done in SW.
> 
> So, I don't see any need to enable this features if we are currently in
> switch mode. Let me know what do you think. Should I still enable this
> feature irrespective of current mode and later handle this in
> prueth_hsr_port_link / unlink()?

The user should not need to know about the different firmwares. So i
would allow NETIF_F_HW_HSR_FWD at any time.

The exception would be, if you look at all the other drivers which
implement HSR offload, if they all return an error if the offloading
cannot be enabled, then you should do the same.

	Andrew

