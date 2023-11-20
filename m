Return-Path: <netdev+bounces-49266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E98347F156D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B781F2424A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87591BDF4;
	Mon, 20 Nov 2023 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omsrc4Py"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887861C295
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C97C433C7;
	Mon, 20 Nov 2023 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700489774;
	bh=qspyWLlSq8sWpiqqSuSqAERRXWBLMY+qTWVHc/Kgvh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Omsrc4PyxEIUeFN5Ayq65crRl3hLKVNA3iff9/dqzjjeBE0az8zdqipvpPl6alQxk
	 E6DOyURCSwVxCJ/NLKbEyO+bWsp1LXHzUvXLZfkGOtT9UeF6D4cs9C6FA04jsM5fab
	 4AQu1xxSjE91ZUYq5gkaBgaRT20TCf3UJJGbXIsITYHHTvFY5IIcsL2kwklI5DwgTE
	 3T2ZDF2tStp/ohTP5wov0fa2bLsco8HW4zeeOHvhdraCZ94aW5O4b+L/Uj9UL904Tj
	 GdQvNSX/e2Z3mTmogcP81pMr4csmoEFcph6SdSRCGmYoxlq3H+vkxRWtoq7x4hoTph
	 czBc15KLN3UgQ==
Date: Mon, 20 Nov 2023 22:03:48 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: HeinerKallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S.Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC] support built-in ethernet phy which needs some mmio
 accesses
Message-ID: <ZVtnRHsnDd+ZdZpq@xhacker>
References: <ZVoUPW8pJmv5AT10@xhacker>
 <b8c29d27-e0a2-4378-ba5f-6d95a438c023@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8c29d27-e0a2-4378-ba5f-6d95a438c023@lunn.ch>

On Sun, Nov 19, 2023 at 05:18:49PM +0100, Andrew Lunn wrote:
> On Sun, Nov 19, 2023 at 09:57:17PM +0800, Jisheng Zhang wrote:
> > Hi,
> > 
> > I want to upstream milkv duo (powered by cv1800b) ethernet support. The SoC
> > contains a built-in eth phy which also needs some initialization via.
> > mmio access during init. So, I need to do something like this(sol A):
> 
> What does this initialisation do?

Per my understanding of the vendor code, it reads calibration data from
efuse then apply the setting, set tx bias current, set MLT3 phase code,
and so on. I can see it switches to page 5, page 16, page 17 etc. to
apply settings. Compared with normal phy driver, the programming is
done via. the mmio rather than phy_read/write.

Here is the vendor source code:
https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/drivers/net/phy/cvitek.c

Hi Heiner,

IIUC, the initialization also needs redo after power off, so it's
not init-once action.

Thanks
> 
> If you are turning on clocks, write a common clock provider, which the
> PHY driver can use. If its a reset, write a reset driver. If its a
> regulator, write a regulator driver, etc.
> 
>       Andrew

