Return-Path: <netdev+bounces-166460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D633A360CB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3413A6BBD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4E264A63;
	Fri, 14 Feb 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rGPMn/Vg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584C2641F7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544755; cv=none; b=WsnQlsYST2mQqxUqQ01F0dQPK7d6aTrohMiXIq0+o41o+W+Ho7JZ3cBmO6dMuCGD9TCzP4C0qwCZumlVGP4829xVUK9+DS9w2QyAgBOM9aF7r0CZbF3PntMqDemteboqeqwRrMDtH2ASaX4Gcy9JAyUuN/mDLiQFyAMxRA01oaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544755; c=relaxed/simple;
	bh=Z744SQNM1sh8KyJv6UXTyp75cxfnl+as8kJv//M/KFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+HwC+lScL0OVXVcVzZS/mb3nimjEZqsApfpE2VQWhd3J97gvQhc1VP10BYjO2fDuE/+7vITqwLnjWgtqoLuQ9Q6V1kfV3Ut2xL5oCthRw2nSkNNoG2Y0tXjRcn43B/thJHe8R0afheLHftprWNxWbfJSFmoQ5KSoDUWgKr15NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rGPMn/Vg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i2m3G9u2qZ7iqqygQ75W35bNDpMgfgIv3y50sTmdvOk=; b=rGPMn/Vg+Hn66r4WfYvoxEFoYm
	GM90WJP7jjY8ZtWgUsJOdG70SAm5LFsrKbpgt3ukY89UPzYPWndWScnHSv/8vC58OS0F3QyfkDbJj
	rd52Zl93/ogadQviM3B64o1oGT/ga2XxkqLsPlEteI92cMxp8y3xdfTVqBEdVYSTWni3V3Znm86mp
	KgXqxveGTjFHUtSI/MaFuWWcdigumWAgKIZo3kgFHQuF+9sjl5Di8uIgP+lOewqV6VXR9HH7vDI06
	vO/YWBqp4RrUoIMwGLaba5L+OU531K5BP9z2+xmMkGZ/NgG+MRkPFXrXDQlfvtczdu2sjdyCVvmxj
	K7AtAhFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51830)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tix3M-0005Te-1v;
	Fri, 14 Feb 2025 14:52:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tix3L-0003Fg-1a;
	Fri, 14 Feb 2025 14:52:27 +0000
Date: Fri, 14 Feb 2025 14:52:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] net: phy: stop exporting feature arrays
 which aren't used outside phylib
Message-ID: <Z69Yq9ZlbdZpf_O1@shell.armlinux.org.uk>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <01886672-4880-4ca8-b7b0-94d40f6e0ec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01886672-4880-4ca8-b7b0-94d40f6e0ec5@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 13, 2025 at 10:49:19PM +0100, Heiner Kallweit wrote:
> Stop exporting feature arrays which aren't used outside phylib.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

My grep confirms.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

