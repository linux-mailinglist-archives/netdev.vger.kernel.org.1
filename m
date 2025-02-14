Return-Path: <netdev+bounces-166483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E87A3620C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD5F188BD0F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E20267395;
	Fri, 14 Feb 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LiGHkJ+W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061F266F05
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547798; cv=none; b=o2D96gFjHo+QlhJRJz3I6xFl1YJOl+y6o94iIZdg0XU4II+G8sO1H92pI2dx/LKledBScmQa1TcOPJ4WO/+i264HLXC7qHyR/7WJ0fkSiNQrmavalgYSWYBMKkW/8mIs3iwWE+MLsH2fANXMR5DPGCyPp8/HTTNy9vAxP57rW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547798; c=relaxed/simple;
	bh=2+MqWPRmKjQq6cUNKy+3jSbcy7zihdLnRN/sqo97ezs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsWtEVGFKy9fuXnqXIwAdt8DINkS9MFLzVN29chlv8TElXE2aQnkO1U/hQaADwIF1RCASWG4y8fDfa8HlCwas2vrmnHPjDeufxwW4iN4zGzAlie+BudswaxfQvzAEpDrJdHYPc2TTXRVS2CZJy/ymk+gBSQ0JDq36lV/Q5aZOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LiGHkJ+W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=apcpmTj0oZ6kNSN0yogZYJrRHoNcrp/9UB3QL+IbHFY=; b=LiGHkJ+WKme7nUI+Mozeh/Ljc2
	1VA+SHAJH6X6iXhdRCC0U+CXpMSNc4VtOYI0j96XTGQarTu5hYQvsexhufxpMqhycjK7ng0vl5/BK
	AN1XdcmmsjJ4z+ywWRor6/HxSVq8GCR9b4d6ChO9cDLrsNbVqdhH3iXt+nAKMZtAtFRQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tixqO-00E701-TG; Fri, 14 Feb 2025 16:43:08 +0100
Date: Fri, 14 Feb 2025 16:43:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/3] net: phy: realtek: improve mmd register
 access for internal PHY's
Message-ID: <99b05422-5152-4d94-9aa2-885f4a1e2a2a@lunn.ch>
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
 <a5f2333c-dda9-48ad-9801-77049766e632@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f2333c-dda9-48ad-9801-77049766e632@gmail.com>

On Thu, Feb 13, 2025 at 08:18:17PM +0100, Heiner Kallweit wrote:
> r8169 provides the MDIO bus for the internal PHY's. It has been extended
> with c45 access functions for addressing MDIO_MMD_VEND2 registers.
> So we can switch from paged access to directly addressing the
> MDIO_MMD_VEND2 registers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

