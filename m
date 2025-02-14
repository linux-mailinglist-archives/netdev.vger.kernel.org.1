Return-Path: <netdev+bounces-166459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108DA360CA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245213A5C16
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8A26659B;
	Fri, 14 Feb 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GtvaUx1E"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E358A2641F7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544683; cv=none; b=n/LvR8FRMCBxUdTJAJr8W7ndE09x4gNui6rflenFq61GglZtIhiHtUHcVlpkxBdBWEbSFux5hPZ37sWoJYgUWEJ5sHzmguDjJkhvBfbHYNScD0uJtXBFftt7SJ5tt4Be7PRwoNFtWcRQnDjhzt4K8Aou08Q4TGh/UA+gg+/UBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544683; c=relaxed/simple;
	bh=wuwDNo7OFBDNwH1ZIGLhidwIHnnb850naVW4FIZSQdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n91pXbI7rdGKSry7ZfPfppfAg/x5Y4G5QIsa6yhxdVz1WfUifRfdESkajt1Dl0gEDASxXAlZa3Ly1qFTjQuYd40AKjWgI8/bSc7CznrVLlrGi5B7eJ3eHwZKv4UH5aFFHoY2JWL6UNGxiixgNZ+YCpZqe78Fj1wR47GVt6VhoTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GtvaUx1E; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EKAN1QdHtlr+sGVCrtpF9ooKwAQsJDa1wCsb7ZZ/cro=; b=GtvaUx1EBv4n2LAGlyTMkhFgte
	ZtnkdgXbuEGKr/QDSqDt1OLXNhVBQEX8yo8if3oKNoSGdYZJDB0zE3hkjlG2yfMi3g0T1Xtz6kekY
	eXohFQdpG4OHXHN9w2+Nnl+/8dhT0fGXPuQQ1aJwVsQwQT2LjSj3O7QMgdapGFrmv03ssno8JuK4n
	lHEqf46UNAoe3SpccRCa6cdGpQxt+avW6Q/uVyXrjUDYUGqyOpPszvAInW4ur8KpWUk+DPF8ixOCK
	Wfhh7yiuirMsAMTRBf9e74eBUJKOiilReJv6KZuowiEbc7qTvDnL0UUEprf383Zq5uL/q+NAMK/8Z
	Fsw6ULnA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36412)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tix29-0005TP-0B;
	Fri, 14 Feb 2025 14:51:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tix26-0003FY-19;
	Fri, 14 Feb 2025 14:51:10 +0000
Date: Fri, 14 Feb 2025 14:51:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] net: phy: remove fixup-related definitions
 from phy.h which are not used outside phylib
Message-ID: <Z69YXhvvfg5x_qkB@shell.armlinux.org.uk>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <ea6fde13-9183-4c7c-8434-6c0eb64fc72c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6fde13-9183-4c7c-8434-6c0eb64fc72c@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 13, 2025 at 10:48:11PM +0100, Heiner Kallweit wrote:
> Certain fixup-related definitions aren't used outside phy_device.c.
> So make them private and remove them from phy.h.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

