Return-Path: <netdev+bounces-132242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BE99116D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD207B2473F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1301B4F19;
	Fri,  4 Oct 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NxNQa9yL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AFC1D89EE;
	Fri,  4 Oct 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077145; cv=none; b=KXHbFaARMx46cRaMuC7mSMSwCYm6VJ6ATYPh1OeQo3er68Q274Bhs5v5bofUMlP9uRv7/K7CFQCxL+ZbKoSmAoIMOWyAcQawPEDow2EwXwDhknDIbpgWcn1XuOeDDl61gDAqrAKEt/7pEZi8m/RJS0ah2ONhDK3s9x2NwSiSdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077145; c=relaxed/simple;
	bh=N2zUrzE7KIqWt7BwfcOY1XPoDyWO2rmbt3vyR+rsnNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0m6xndpGB3MYfm9rpH/8vjvbyFtarIgzzTVlT1g8RsvoGjLDS193OiAJhMutPGZMxyXt6ZuAji78Mvqd2RmxtxiARpwnQjgOBJn5w0yq2FM1mOfw8Zb4ulJaGb815K13Dd0yt5Vn8MUbcw4YukziL0PxvTslC+9HMxrN7JnOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NxNQa9yL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FZ9KmEreKaJMOHQNIxj2haoGiMXD+u4VxPUzPzykFvE=; b=NxNQa9yLUHGu9izKgxgje0zD+h
	ACvdCPJM5EB3MmX9c27491l6n9EM5x+6gsqOCq21ROmnfwhPszUVWuuTPxjzh1fl8HQ6FaX+WZrh/
	EwurzcvFOmPGwOxwhio1BttIxI48b4ZNWt7/Fin6hJ6A5Ri9a5HKpD/RVCk+/zvYs77g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swpnl-0095tb-7m; Fri, 04 Oct 2024 23:25:29 +0200
Date: Fri, 4 Oct 2024 23:25:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: make sure paged read is
 protected by mutex
Message-ID: <398aed77-2c9c-4a43-b73a-459b415d439b@lunn.ch>
References: <792b8c0d1fc194e2b53cb09d45a234bc668e34c6.1728057091.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792b8c0d1fc194e2b53cb09d45a234bc668e34c6.1728057091.git.daniel@makrotopia.org>

On Fri, Oct 04, 2024 at 04:52:04PM +0100, Daniel Golle wrote:
> As we cannot rely on phy_read_paged function before the PHY is
> identified, the paged read in rtlgen_supports_2_5gbps needs to be open
> coded as it is being called by the match_phy_device function, ie. before
> .read_page and .write_page have been populated.
> 
> Make sure it is also protected by the MDIO bus mutex and use
> rtl821x_write_page instead of 3 individually locked MDIO bus operations.

match_phy_device() as far as i know, is only used during bus probe,
when trying to match a driver to a device. What are you trying to lock
against during probe?

	Andrew

