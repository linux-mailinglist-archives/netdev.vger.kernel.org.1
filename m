Return-Path: <netdev+bounces-224608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBDB86DEA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AA41B204A6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF6306B04;
	Thu, 18 Sep 2025 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ouiYAA45"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1A31A7E8
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226500; cv=none; b=HS3mg5XuepitL96Ik2HU2VgOoR9KwRpfGEkJ8gG/rXixk1gpNddY11hnq6Oa4m8WYheh3et8XygeBZzQ4Za4EUrbgp4v/j2bRFvho+GkIaAe/OdoJtUueIe5zwBdVzINsqxRC2OdyHI2rdeYmjcXl9Wj1YI28Bou6jOKKEZktxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226500; c=relaxed/simple;
	bh=NkoRHeelwabiqPXxMTI7N9Ed9MlcCjEv5V+TAhuw+lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfZa1qbCrjZdSlxLjjqBGp+gtkzx6Cn1X0PUUSVFlOIuDTTMXSZEIe3Wmo40HEZnS4WJx2bPdPfXolP0/d59Yf7qCLwQudRz3Ad/AJaK+djIgIdfFU/9eQ2OxZ0knydL6xjqclJW0CrLY4UUyBGOcFjucK5ekHObIzlLOCsacOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ouiYAA45; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SZACeKKy5eNu5XegVGWULxdN1hFvl7LpEQymc3sawEI=; b=ouiYAA45isD3YRkRBjzSWzvK+0
	/YlHIXf5QWWZm+FRYSVtuLVizjQ5ATdr/h8zvDaNQIP0OtkIG/lcHGsfMf5W7Qqoel13hPA+pGXru
	UIYkproy3jLVzYpPyRCeyA6bVCg9yByiYotzi3/FnamTzduQh2SNwipgLxjBXDsNNjwQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzL1t-008sCm-KJ; Thu, 18 Sep 2025 22:14:57 +0200
Date: Thu, 18 Sep 2025 22:14:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 09/20] net: dsa: mv88e6xxx: always verify
 PTP_PF_NONE
Message-ID: <1b2988c5-b9a6-40ae-9820-b84ad8c1b9c5@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbZ-00000006mzu-3pQK@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIbZ-00000006mzu-3pQK@rmk-PC.armlinux.org.uk>

On Thu, Sep 18, 2025 at 06:39:37PM +0100, Russell King (Oracle) wrote:
> Setting a pin to "no function" should always be supported. Move this
> to mv88e6xxx_ptp_verify(). This allows mv88e6352_ptp_verify() to be
> simplified as the only supported PTP pin mode function is
> PTP_PF_EXTTS.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

