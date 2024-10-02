Return-Path: <netdev+bounces-131392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E2898E6A7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E05F1F235D1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902B1993A9;
	Wed,  2 Oct 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RI50ZEzZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69019645C;
	Wed,  2 Oct 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911028; cv=none; b=Y4CaDjb2I0rV70KoqTp0TpsMwPAIkQmolOxDQW/UkJCbQJhi7OPzwq00+PEJIoydgYVo5dHbkceVXFJGmSWPbxWLoN1ih9M1THCItg/aC/VVEmJFPXGWLgS5GxvH+vJl4+yCdb1YwT3Ish3KRfL2jR14w7iluTRG+c+gmlhBBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911028; c=relaxed/simple;
	bh=Lv1ga8PU+vUnUSK/kSo/9MtN7cMDytSgNT/sDv79pcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGMzGNUNr8dI+Qqh2I5EYSxMN87kaEuqDF2RzuEMLbzxuHm+k1SLN08RIl6r0WG/4VgP+gyELYC1SpU51rtIxvcTMI1CmqGor4JNx5XDbgizbscGa3IbEpDnFs7noxRFwC9cA5OslyLhTRa+sHY1d7HT4Po2YNPsbLF71fhrPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RI50ZEzZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5tLdm1hkwEhBagr5MYqhdz53EKTQxcUJBFsi4fHGq2I=; b=RI50ZEzZUNw48gO9B1JyRbl8RF
	fpL2kFGeHugKYVtlkgzoVNbBcCTOwq45xPoPnAp3DjVVBeVbCkeR5iI5sU2XzHJ/xmOp2TUa0tUBG
	xxfADoGaOLmsQNPxO/D02AEK0j9IBR1uKO9uawePF7VKX17ZE8Kwgx5T+hvrWoTsQYW8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw8aP-008u1V-5F; Thu, 03 Oct 2024 01:16:49 +0200
Date: Thu, 3 Oct 2024 01:16:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Bauer <mail@david-bauer.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: mxl-gpy: add basic LED support
Message-ID: <0644293c-92b9-4e27-b12f-dddc73a63e0c@lunn.ch>
References: <b6ec9050339f8244ff898898a1cecc33b13a48fc.1727741563.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ec9050339f8244ff898898a1cecc33b13a48fc.1727741563.git.daniel@makrotopia.org>

On Tue, Oct 01, 2024 at 01:17:18AM +0100, Daniel Golle wrote:
> Add basic support for LEDs connected to MaxLinear GPY2xx and GPY115 PHYs.
> The PHYs allow up to 4 LEDs to be connected.
> Implement controlling LEDs in software as well as netdev trigger offloading
> and LED polarity setup.
> 
> The hardware claims to support 16 PWM brightness levels but there is no
> documentation on how to use that feature, hence this is not supported.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

