Return-Path: <netdev+bounces-45422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F07DCD50
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 13:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07341B20F59
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B4DDDA;
	Tue, 31 Oct 2023 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hzHJuxP6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEE46A0;
	Tue, 31 Oct 2023 12:53:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8041E4;
	Tue, 31 Oct 2023 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rXuqsFrVvVN5BpjjygfvonPIKe+gbeo3sNDGWVV3pks=; b=hzHJuxP6Ia6A3s/Ei0M5W2eaTM
	J5QpswVnopKUXWfXvjrN7xoImq9yHk5i+DvWH46XT8BKM+wkKR19sFSnxioQVaS39FTZ7FcltYRmD
	pTl9RFyw2qI9lmZI42YYaLak6h7X2KFA0sadE+1PiQU43qCmRoq9XwWf8hTiiaHy9Sxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qxoFJ-000c4Y-23; Tue, 31 Oct 2023 13:53:25 +0100
Date: Tue, 31 Oct 2023 13:53:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, Steen.Hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Horatiu.Vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <0ad1c14e-cd7e-4b24-aec9-75cbd19ad8e9@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
 <eee6df3d-5e6b-4b4c-bfcc-55b31814fb82@lunn.ch>
 <296aa172-404e-414a-a56a-ca82b3e90397@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296aa172-404e-414a-a56a-ca82b3e90397@microchip.com>

> Ah ok, then it is supposed to be like below, isn't it?
> 
> static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
> {
> 	struct sockaddr *address = addr;
> 	int ret;
> 
> 	if (netif_running(netdev))
> 		return -EBUSY;
> 
> 	ret = lan865x_set_hw_macaddr(netdev);
> 	if (ret)
> 		return ret;
> 
> 	eth_hw_addr_set(netdev, address->sa_data);
> 
> 	return 0;
> }

Yes, that is better. In practice, its probably not an issue, setting
the MAC address will never fail, but it is good to get right, just in
case.

	Andrew

