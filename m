Return-Path: <netdev+bounces-50193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C47F4DE9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA331C20ADB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1905789A;
	Wed, 22 Nov 2023 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oMN6zoRj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B871B5;
	Wed, 22 Nov 2023 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kxp/djjLC0Lw510VoCfRhRGSsD7Q8L/T6M4GAU7G0KI=; b=oMN6zoRjxFSEdgndPqgumoztyZ
	FT0q49I6WX1MeJHViyYdKyK74chUDYr98xtin2diFhAtYR0FvNp62kHN5Wpe3YrYLeusmTecaKh61
	59cPGWCNC9YIG5WlO+HgyeRgVqBNo4CWQeSIt6zIarTKpqsDoGk8iINd19zoAT7KEu4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5ql3-000tZx-6y; Wed, 22 Nov 2023 18:11:25 +0100
Date: Wed, 22 Nov 2023 18:11:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <cde6c19f-01ba-4f6c-9e73-00e4789fb69c@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
 <45694d77-bcf8-4377-9aa0-046796de8d74@lunn.ch>
 <20231122174828.7625d7f4@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122174828.7625d7f4@kmaincent-XPS-13-7390>

> > Is the firmware in Motorola SREC format? I thought the kernel had a
> > helper for that, but a quick search did not find it. So maybe i'm
> > remembering wrongly. But it seems silly for every driver to implement
> > an SREC parser.
> 
> Oh, I didn't know this format.

Its often used in small deeply embedded systems. Microcontrollers,
rather than something which can run Linux.

> The firmware seems indeed to match this format
> specification.
> I found two reference of this Firmware format in the kernel:
> https://elixir.bootlin.com/linux/v6.5.7/source/sound/soc/codecs/zl38060.c#L178
> https://elixir.bootlin.com/linux/v6.5.7/source/drivers/staging/wlan-ng/prism2fw.c

Ah, all inside a header file. Probably why i missed it. But ihex is
not SREC. ihex came from Intel. SREC from Motorola.

So i would follow the basic flow in include/linux/ihex.h, add an
include/linux/srec.h but adapt it for SREC.

	Andrew

