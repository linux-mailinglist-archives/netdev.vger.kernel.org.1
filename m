Return-Path: <netdev+bounces-161941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED1A24B90
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 20:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474C818863FF
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91741C3C01;
	Sat,  1 Feb 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qM7VuuqU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BA182;
	Sat,  1 Feb 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738437748; cv=none; b=VlUvkFtmCyY6KIn6T6DQe3hRsO0TwD8it+ahrC3IIkRe2prT3QeXSfgZHAneLA/0Z3xaGFXYJnGVYBp+ZRlaND1TM0Qdk9CLm0SNTLmHdvZUmlHU8/dkivX5/ANNhi0eB5tu9dmULImm07+/nsRYhsNLb9M8c4mgnVkEfa5al+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738437748; c=relaxed/simple;
	bh=eq90rFSpRQmil4os8XqZjOcWHJ6eM4h8IMQ7Ah4c5wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym0btHEEpeNvk+AsQy9//1DBXRloW0lRcWaBXUYPG/R86Pph1nrxO/qwAeMMYkcUtNzRPdbJP1X7/IDxzY5OF2ca5WIyKjWhhLk35e9C5Y7QzoYGlJuV6Ne2N2hxV3CDu4Zy7MhscwnoezH4Y8sbb/RMXCyb4NbUx17rieailOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qM7VuuqU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kMPOvCeFAGL1Bzwhnzo7bfHBjVlXhYB3RaP4/eVOF4M=; b=qM7VuuqUUsNGS3N5O4A2GXpxCv
	ve24WUI2D4ycBprLxsKCSju4KGq+f6lzghmCeBb4inmaasZI6Jze/50/AExlDQAXVX/GZy9vECx+R
	9CLOQo2h2ZmxB99Uv7WBDlmoKK1wzcmfes8ZzGdAWxRNUsPYXwIzxD4KAzBCPMgy93+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teJ42-00A2uZ-LG; Sat, 01 Feb 2025 20:21:58 +0100
Date: Sat, 1 Feb 2025 20:21:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability
 value when FIFO size isn't specified
Message-ID: <35ac46e5-1a5c-4416-a6c8-1fd42ea47d37@lunn.ch>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>

On Sat, Feb 01, 2025 at 11:14:41AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Jan 27, 2025 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> > When Tx/Rx FIFO size is not specified in advance, the driver checks if
> > the value is zero and sets the hardware capability value in functions
> > where that value is used.
> > 
> > Consolidate the check and settings into function stmmac_hw_init() and
> > remove redundant other statements.
> > 
> > If FIFO size is zero and the hardware capability also doesn't have upper
> > limit values, return with an error message.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> This patch breaks qemu's stmmac emulation, for example for
> npcm750-evb. The error message is:
> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size

Hi Guenter

Please could you try the patch here:

https://lore.kernel.org/lkml/915713e1-b67f-4eae-82c6-8dceae8f97a7@arm.com/

	Andrew

