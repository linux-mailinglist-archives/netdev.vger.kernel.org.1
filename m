Return-Path: <netdev+bounces-114310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F78D942199
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9961F25227
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3601718DF62;
	Tue, 30 Jul 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sstIam/L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699A1662F4;
	Tue, 30 Jul 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371366; cv=none; b=QSpCPHD6gDo4sPL1F2Le+Sp3ucAbXVJtJDVJnYmkxEbNjMKk9SSZSBb0Z5SOABNHFGo3KD4f9xnPKyUKBGz/9moPjp8a4T8lUutC17qxLvAo8ce0rW1zVe2P722qN7HpLQJeDb+INPTPa2ru2NnHgT1P/sz6d5CikLXvCNuKeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371366; c=relaxed/simple;
	bh=VysUb6IsHW4duSZ79kXmXf0tnEltW4aDIGDrPlAtLRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUAW2eDfDh64dQwEA0SsWXuI+dOKwmcD4jRjZ1oa71qYzB7EnBEteJk29LseaNwg2SFkoPv0Nx44rn2MptKpZDWiMjHW11Tl8i1ll9bSHIZiDNl51Z1BBCUJ5XlWvgiEpljFy5ohrE+r4OrLoZr+BpRri/soN6MsCxFSLRdIzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sstIam/L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=biBLOAKr0WksW2u6STl5rcpBdcaPI/8W4IiaoGv9CUE=; b=sstIam/LlC1tYpgq863ldGQv/f
	vPnXWzsNfMFVJXjVRjPog9ubslY+B2vLGFJvxL8YVXDaINT1DSazom9ZEIKq6jzCkfhPSWc5bzxLB
	B21k60lT8DOKkiHxWcCljP0qvlCIqYgOUrgMQwi9XA5y2u+x9hsrflBK40Z2pA+kBbMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYtT2-003bzE-A5; Tue, 30 Jul 2024 22:29:08 +0200
Date: Tue, 30 Jul 2024 22:29:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, masahiroy@kernel.org,
	alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io
Subject: Re: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <c9627346-9a04-4626-9970-ae5b2fe257da@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:38:52AM +0530, Parthiban Veerasooran wrote:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.
>   Link to the spec:
>   -----------------
>   https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> 
> - Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
>   Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
>   Link to the product:
>   --------------------
>   https://www.microchip.com/en-us/product/lan8650

FYI: This is on my RADAR, but low priority, probably not until i get
back from vacation. Given the very long timer between revisions, i
don't see this delay being a problem.

      Andrew

