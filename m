Return-Path: <netdev+bounces-153439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B69F7F9F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5D1882C0D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7522759D;
	Thu, 19 Dec 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H6EDNFOt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA614226881
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625427; cv=none; b=gI5JySue4XxUjegATHMPAg2ZmeUWRf9JXz8C5x+uqOCzdlCAvzyDDQzvThSxA6pqcuVMW8L/hN+0vj5SLsp/w+0EnXApTrtqrLAwx7vlDM1TF8c7pkb9J5k/zdvadD5aF0VIJiFveXrm+SYJ8MPTjq4FYnrMLoYeA1R0pR91yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625427; c=relaxed/simple;
	bh=D0OhYDa+g+CpDM3T6yXvaAWM7nmPCSb9TQ1ot8Pu+Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBMkoyrHZJ5oI/JdA+IT/nsX0kXXikJyq3iJce/c1z9BXyuzagfLG52p7pMFo3an1nnvmA4h2fGSsU9EhET2LKFCADxls5BnqFC5wF+a5NtJVla/CNvSyWUcH3xG7CIiWWKsT/+h+jVm3mWIvgLGIHHIszHcZgHzjJelyFNWGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H6EDNFOt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QQHQc72sdYpic/oDNDQnnb6lAb0WIH3mjao30boPIkc=; b=H6EDNFOtLj+F1sVnu/WdqNx5Ry
	kIjJi9mQMlLaLu471WLlnITe5KCC7NGEg/b2kU6ahu7TuYLViN8P1KY8Q2li+0Lpry10eiLyD8JEi
	yayRoJY697PT0C6c74hVYE5puIsl3zePjeyobYQPpUbzW6Ya2f/rofEvnpUjhdG7Ho+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJJJ-001g64-Ge; Thu, 19 Dec 2024 17:23:37 +0100
Date: Thu, 19 Dec 2024 17:23:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] net: phy: aquantia: add probe function
 to aqr105 for firmware loading
Message-ID: <d7a5a0ad-17d9-43c3-a2e6-d882ee70deaf@lunn.ch>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
 <20241217-tn9510-v3a-v3-2-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-tn9510-v3a-v3-2-4d5ef6f686e0@gmx.net>

On Tue, Dec 17, 2024 at 10:07:33PM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Re-use the AQR107 probe function to load the firmware on the AQR105 (and
> to probe the HWMON).
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

