Return-Path: <netdev+bounces-71360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1D853124
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDD6B25F81
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CCD524A8;
	Tue, 13 Feb 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nm/BwZBY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9284F21C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829235; cv=none; b=ZsdXhuXr9pEtDYsPi9lF1JZ/QcHGbCyH1sX6FwXHlKXuFHy+EoiYSARF6JXghFj/PfmmGt58nML5dphyKnTWfAEFk7CnuC+oEDpHoUpTRXTQBJ3o7IBgDznwHR5qFpDyiFwOI3IUW+Yt2PPCEAzXH7hD4g4pcUkNyDKrFz895Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829235; c=relaxed/simple;
	bh=H7Gg+qdcftnVbkauPWca5h8mw2wQLEGh0IRO1YM4J94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjB3nJui4sz5SrjLMcfX9WYSwMjSbzTisQEEMeSy1JB/8/XTCoxclYYz2b/rUPVkUA0nQ4nyQHS6tdEc2Uwg3cJfmFzbfnaVl4EXe+Xud0F/FoIPTPNEOgUfei5lJnl0dZ3Oom2GK2X3rbVuBHOcGvBkepv7TgFOMA3u7K6T7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Nm/BwZBY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FlCv0+trx0XKNXuR+z2PCrzMeZWArfD8xk//ZuKjpu4=; b=Nm/BwZBYCNl6wr60NwwrPXnoaj
	rXo6DiWbyN2kK/z3JGkpCRr9gNOyJBJ36xxE36wZLVrG744kwBHUvHCgO7MFnhOPJ9pnRViw3PBnn
	DDqSrPx3FACWXhNUCdq/OAEbRe/R2HKuQOmBogI9rW4Nxw6iyCArQG2p0xleX28W8ZDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZsOo-007g3l-WE; Tue, 13 Feb 2024 14:00:35 +0100
Date: Tue, 13 Feb 2024 14:00:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] r8169: add support for returning
 tx_lpi_timer in ethtool get_eee
Message-ID: <5f34a7e9-6f16-4836-b310-5729448129b7@lunn.ch>
References: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
 <4eee9c34-c5d6-4c96-9b05-455896dea59a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eee9c34-c5d6-4c96-9b05-455896dea59a@gmail.com>

On Mon, Feb 12, 2024 at 07:59:26PM +0100, Heiner Kallweit wrote:
> Add support for returning the tx_lpi_timer value to userspace.
> This is supported by few chip versions only: RTL8168h/RTL8125/RTL8126
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

