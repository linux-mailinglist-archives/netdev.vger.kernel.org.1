Return-Path: <netdev+bounces-33419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E179DD99
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 03:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2991C20EAB
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EC338A;
	Wed, 13 Sep 2023 01:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8005384
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:33:00 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7A10E6;
	Tue, 12 Sep 2023 18:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qJBQpBNYYlkyqxjelwZuKANH81OCTF0GID3/9TLiuoA=; b=c+vvtVlalT0CtfoSTtdGkB/6UX
	0vaEIh3WXqfy+MkjaZaczVeqG94U2ZqHfGvwJQdGjY4SMFi+mg/+zn7SaEWJrQ0bbpR+zvSIoq+Cb
	l+Ik+/TZWS07EvaM6iOsaD9eS0dW7FtF8D/wqURwPHbK0STlMYosg5AJttfo8hlls9OM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgEkK-006Grg-3h; Wed, 13 Sep 2023 03:32:48 +0200
Date: Wed, 13 Sep 2023 03:32:48 +0200
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <2021acc6-bcf6-4dba-b7ce-ca1b3ca86088@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
 <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>

> If I understand you correctly, this framework has to include the module 
> initialization as well using the below APIs and has to be compiled as a 
> loadable module so that other vendors module can make use of this, isn't it?
> 
> module_init(oa_tc6_init);
> module_exit(oa_tc6_exit);

You should not need these, unless there is actions which need to be
taken when the module is loaded. If there are no actions, it is purely
a library, don't have them. The module dependency tracking code will
see that the MAC driver modules has dependencies on symbols in this
library module, and will load it first. The MAC driver is then loaded,
and the kernel linker will resolve the missing symbols in the MAC
driver to those in the library. It also means that there is only ever
one copy of the library in the kernel, even if there is multiple MAC
drivers using it.

       Andrew

