Return-Path: <netdev+bounces-200742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C8AE6B73
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E979C5A49C8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765629E102;
	Tue, 24 Jun 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tMgKJzHE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC929E0FA;
	Tue, 24 Jun 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779365; cv=none; b=FoGbUQ+M4e15AlttzyrGiqDHjpogFE2ImWT7AyKnc0jsOJ5hg075KcddRGWb4a6w0inCkGb1EdkVcT9kMLIw2k5v77j03YpFJVXSB0bSOZhoDXnn7j0bHavcj3CPH4I1RQQz3Q7SDNr9SzPD93UcLTzJAeQOwOHw0wqpSoY0Sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779365; c=relaxed/simple;
	bh=MoGXTJdpi6hUicTi3LQ9cQIpPeUUkI2eIwakQ0B9wKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpx4Kvrh/HpJ8Y27etultrlPSpKdJSyTjrthH3QIHoYehtx8AG8Ifr3kWYjJ6BXoos3Q73/OgPMxqBttdels0/d2rLniQ+05js9nmCfQdYDrzO5VTBMJRH3LQT7czIeVBFocYMaFb9tMRSlmRrLn8bYslUde9+am+k6h2+STDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tMgKJzHE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AoAHvhfVCuq2pKXRmbgnSgh6SAHhKZMl3xK2Jzv2+co=; b=tMgKJzHENZcq4LXdsQdJ7xfZJ6
	X5g2ij0ZLlB9RQbsrO+hdk955MGH0cbUs1i8ALW+fDdd8RJtly4kN02v1mcjr8aRsDMytK0sNFNze
	M/KZkNvbf96y/+wxXsvLkb7f/FLxEkaUuJdhsoGhlPKcqjwAcclDnQxLbd5vKrD/occo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uU5gb-00GoSS-Tr; Tue, 24 Jun 2025 17:35:49 +0200
Date: Tue, 24 Jun 2025 17:35:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: daniel.braunwarth@kuka.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: add error handling to
 rtl8211f_get_wol
Message-ID: <157c7685-f82c-4eb6-9e5d-ca6e9c566b61@lunn.ch>
References: <20250624-realtek_fixes-v1-1-02a0b7c369bc@kuka.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-realtek_fixes-v1-1-02a0b7c369bc@kuka.com>

On Tue, Jun 24, 2025 at 04:17:33PM +0200, Daniel Braunwarth via B4 Relay wrote:
> From: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> 
> We should check if the WOL settings was successfully read from the PHY.
> 
> In case this fails we cannot just use the error code and proceed.
> 
> Signed-off-by: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/baaa083b-9a69-460f-ab35-2a7cb3246ffd@nvidia.com

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

