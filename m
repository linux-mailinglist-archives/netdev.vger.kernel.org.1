Return-Path: <netdev+bounces-241347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7418C82EEE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2EC14E1276
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552021DA61B;
	Tue, 25 Nov 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ma6gDb4/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B33EA8D
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030409; cv=none; b=CjV6PjGY1jr7AZc0NXPejBQnUnb4vSAnleExanngLNcwSVykvhpPBqji81lI6S+EQ5Eow8sPeGbknJQvuxO0oOq2tJ04ZjrSPrW47DN9qGAGKTx5fVoVlnS3kHVfxvbYQkVaOm0G0I4ksnpt++1fhodunV0GIONileHRhN//QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030409; c=relaxed/simple;
	bh=Y9mC9WIBCIQmcP1DvNjjmfm/t+jbQUZGHBkQDRsJAwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVl8/28PrK/X7Sb1bH8k0p0maB6St4Qs1GmQq6AWLtIGdPQLxb1gn+6/av/J1bWEX6/l4Ks66etyw44H3Q75r0Cipr8c6L12RddOxtIisg2Rwfa3rC1ZpzCf330sL5eHfFpJrbv2275eDNXs2rarGuxpZcgykx4iZJeXNAb3XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ma6gDb4/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1nGtpAGtRpw42mNhdvsLox7KtduwvyOV9K1WcddwTac=; b=Ma6gDb4/J48fZGtWyIfwUv8g8N
	K0vrBgQMrj487WbYCK1ytyXPZR3EkGhY1NnR3mn+Z5Ru0prIirwVlOLP2r/5W4TT6JQViSi03InRv
	1dXyx6rs5DJKczYPdJIInDmNWfy8SltvBX5Mt+1bOjn+8ZmkZ/dLjXOyIBjLOaI4IWaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNgtB-00ExaZ-4U; Tue, 25 Nov 2025 01:26:37 +0100
Date: Tue, 25 Nov 2025 01:26:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: improve MAC EEE handling
Message-ID: <cf43702b-e743-44a2-8398-427dccdcdbc1@lunn.ch>
References: <91bcb837-3fab-4b4e-b495-038df0932e44@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bcb837-3fab-4b4e-b495-038df0932e44@gmail.com>

On Mon, Nov 24, 2025 at 08:37:53AM +0100, Heiner Kallweit wrote:
> Let phydev->enable_tx_lpi control whether MAC enables TX LPI, instead of
> enabling it unconditionally. This way TX LPI is disabled if e.g. link
> partner doesn't support EEE. This helps to avoid potential issues like
> link flaps.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

