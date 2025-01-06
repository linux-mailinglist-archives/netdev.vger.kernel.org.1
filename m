Return-Path: <netdev+bounces-155591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C1A031E8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0D1883CD7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140C1E04BD;
	Mon,  6 Jan 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VlcUySei"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0741DF961
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198134; cv=none; b=skPY4SM2MTtiJULaAemrJ5OECpmrJqCdDY0ZVbdIV9KQbXmBr7rp4O7By9Injb/jNCl3PnAJ/0w2D0v+VQY8Fu/u9g/WDgNwj41rEadQSCQBtBplUVfVwmBHADan3WG0XgcHHxE/X67uxZIe7aVDn0CbxS7rZzTni7ujtzIUI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198134; c=relaxed/simple;
	bh=tqHaJSUUbqrqutPRvq+MteDcMsc8jZMlUJ87xDFoqrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNvY87kWkh/i5cWdbJp+LsIaUL4t6A0ILwbr+teTuJZBgtDsxvrjcvpZnbbzJvdCimw3TbYOUoH9O2ptVyAct+6Xz9nOeCO354P2axlO+2ZA63ucCE0wUAOTMbMaqwyci1+9Kf6A4CwCfOmc2j7zm9/G3X79sMqkTqi5zl5Jhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VlcUySei; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SjQIDBOOBVJqUUXoqv6QWpRYqizgy8BiPfB2QNTXwxM=; b=VlcUySeitAVLmwhmmQ2ikg35Pu
	ZhaoQUCWfOxZpH9mXi3SST9LUc4xXO2knT8JgaIBU2weBAnLIPm8Ml2LClkxjPwnxEv0CymMNbwsJ
	wYuHBBkazci+XiudKv3inHd1xhx69jFSDZSHz6MD+NWeUTDSx1nRQFMkDDu5jVtNZ+wU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUuRX-001zhd-Ow; Mon, 06 Jan 2025 22:15:23 +0100
Date: Mon, 6 Jan 2025 22:15:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] r8169: add support for reading over-temp
 threshold
Message-ID: <4535017c-10a8-47e8-8a8e-67c5db62bb16@lunn.ch>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
 <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>

On Mon, Jan 06, 2025 at 07:05:13PM +0100, Heiner Kallweit wrote:
> Add support for reading the over-temp threshold. If the chip temperature
> exceeds this value, the chip will reduce the speed to 1Gbps (by disabling
> 2.5G/5G advertisement and triggering a renegotiation).

I'm assuming here that the over-temp threshold always exists when the
temp_in sensors exists? If so:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Does it reduce the speed in the same way as downshift? Can the user
tell it has happened, other than networking is slower?

    Andrew

