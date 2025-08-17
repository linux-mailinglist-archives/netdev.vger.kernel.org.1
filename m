Return-Path: <netdev+bounces-214399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89000B293FA
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818AE2A49A8
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC11F4CB5;
	Sun, 17 Aug 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rC1G319d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2D14EC73
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446694; cv=none; b=JC822BIj4XuThMJunzrR7rvKA/W+bwa1ereWR+sJivFOm/glKKWH6ivIo1IEMfektQQL+L/Jp3AHD/BbV73kCJ6+V+tm6vVo5P9x9EhcizIJGKXNp2bDb4GOwiF8fnfVLTMjL/7uIMePzv2aO/uIsG6uRHzH6bQpwaBr163VUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446694; c=relaxed/simple;
	bh=70nj/bwe1ofe/dXixEBO/yoBaoggTvY9MIMBWlAybDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggH69U4Mi7c5/mZS3FPHjHGf/rjb4NGzFfvJXl4NY2YipGT8SSETczvhrvGWUnjNzthKUDxE9rXIqPPBeKZFAlflrXaA+PBYnuxzAhgKEBiNiWCyNYaovyuyOcoVNEZHnT1TBsTGMB1rjpaJa7CVpEYmEDIZhuFym1mJNIsucjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rC1G319d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=POmukRFkjYpNXYmDEPj/7QMdAoS9bsibi9ZYM92l9p4=; b=rC1G319dTDBFPpGTPqkcpbL3HP
	QRy7+PTdl6rXOCpbsnZoW9eRT/HTpDkvV38pa5R3sZaUwBqPhMWRcTJXghaFODfj/1bt9qR/+iSnF
	UFeHFBOmNQ9e/FjkROLMguEQQ1MF7Jm/+OHTPgM25A5hdD2vuWO9nGHI6xIYLJWfmC/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfsD-004ydR-DH; Sun, 17 Aug 2025 18:04:45 +0200
Date: Sun, 17 Aug 2025 18:04:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 7/7] net: stmmac: explain the
 phylink_speed_down() call in stmmac_release()
Message-ID: <3590bd11-c934-4838-b9c7-87a480dc3696@lunn.ch>
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
 <E1umsfV-008vKv-1O@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1umsfV-008vKv-1O@rmk-PC.armlinux.org.uk>

On Fri, Aug 15, 2025 at 12:32:21PM +0100, Russell King (Oracle) wrote:
> The call to phylink_speed_down() looks odd on the face of it. Add a
> comment to explain why this call is there. phylink_speed_up() is
> always called in __stmmac_open(), and already has a comment.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

