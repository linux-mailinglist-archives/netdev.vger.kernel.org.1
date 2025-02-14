Return-Path: <netdev+bounces-166481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C9A361F0
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723F53AF654
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B8266EE4;
	Fri, 14 Feb 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eHMNStHi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D42753E5
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547561; cv=none; b=Cwd0WIc/TBM7U7KF1j/H1WDCozZkt3xDOf2uwOA1KK5zSWFtu9/k5E57FSW/ShvfmpjC7AxaNXd7IDUyUKCZrTgFi08eOtUMqpBOIj+GJVg7lGdj78cATv5zBasbwELMYtOz9BuyiMZQcWbSUxC6DPksZY7W6tNT9K+Nta9nmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547561; c=relaxed/simple;
	bh=GWr1wa7Wch1nTNnrvOefUmqOvdAsWw1teTd4S1/iFew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhUyn9/l0jIXaCJlAk9hPy8pfNgWlOqcFmEx/qYt6EegAcjO94zz/Sni+dFe/zhCOat0gGEuGTrgZXOZK+C7aQDVqHTf5Rnxm81q5pSMiats0AdvRG6x+VpbkKaO6dktayjljMgeb5PAUDPzbjadGQsrYJdxT5kitKZ0mu4FbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eHMNStHi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C8BRSe34JpyTcKkQKMDKCo4oIzw4JxoZjGqxAiXnj9w=; b=eHMNStHiQ5bjECn7LbkJwUup3M
	7m+8Y2qEMCtkTzv3lGgvopeCM6oEwOGl/3ixqvWmki+aqDj0NsamXgC9ylbwXXPJxAMUJBKxIv3PZ
	Qgsv9p8WVjA6O5JlAUTZhzTdApbJ4uWtY+DfS5vCLPHzMIHsoAhudus0NgtMHbt/WWHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tixmU-00E6vH-PO; Fri, 14 Feb 2025 16:39:06 +0100
Date: Fri, 14 Feb 2025 16:39:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 1/3] r8169: add PHY c45 ops for
 MDIO_MMD_VENDOR2 registers
Message-ID: <c5a24fca-2af0-404d-afca-5e5437714676@lunn.ch>
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
 <d6f97eaa-0f13-468f-89cb-75a41087bc4a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f97eaa-0f13-468f-89cb-75a41087bc4a@gmail.com>

On Thu, Feb 13, 2025 at 08:15:42PM +0100, Heiner Kallweit wrote:
> The integrated PHYs on chip versions from RTL8168g allow to address
> MDIO_MMD_VEND2 registers. All c22 standard registers are mapped to
> MDIO_MMD_VEND2 registers. So far the paging mechanism is used to
> address PHY registers. Add support for c45 ops to address MDIO_MMD_VEND2
> registers directly, w/o the paging.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

