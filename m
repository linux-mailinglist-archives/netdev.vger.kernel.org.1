Return-Path: <netdev+bounces-75265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1B868DE2
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C111F23585
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F0137C42;
	Tue, 27 Feb 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HZPAo8JT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4862F9D6
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030576; cv=none; b=sxVdYM4M0jx2UDLkz2a/niJTjbXUXeyFkJwIx8sW/K9TgAL0ifwuOQXlhTY89QvLNqUZglOvRBXJliuSYQHnx8pMLtgtZaKpqU4EbPMzVM+apg0nJT63nYwgXAFIOy6qV7jcdq0FYJswESHdMccmuiWNt1SadquwoDTW9rO/8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030576; c=relaxed/simple;
	bh=zhMlQc4CDQspForTyTJDG1r5n4QJPXKi6ptuxsVaaE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXoS7WfL5hGNahwe9JyFAbQJj4+c5x7zha7wRZnhbJVeNngUcl8xeqMBFrREq/asmGA4nmZJKEmf4VxO0hESsJwdaNrhp3WSNerthO+fMOCn4zKuiJhBRoXo1NCe3vN5s0TNRLnGs6KtYEpIIag927QwNRmX8lLj+1SNcJtnFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HZPAo8JT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UUrvdkoYikInH5aza3vYmFguks+yIznEMoeJ2Qjwpk8=; b=HZPAo8JTRXOkaK9/i3fLKxjQgg
	8v7d0xgx8XktKuFdUyVLeLrq2Oo33ma1sBzSkGQPDXgbqXlnv23lkixUwsTR51ahQcNhzF6kcEt18
	Gj4gP1jeZFMGRiU++mjMQDgg/uwPKx6Q6fmfk9dtRaphzxPJXMI57UKORUYb+XJLyLR2xQnrbTgiZ
	zcWHRmi5aYC8uwHBDzCT3f+4Sx/ph8k/MiisX2t0pYXVOmP4qji+1aUXLAL8rgQXVUaDoeeHaO7X4
	BZVZf0rkDIldkbTlMUshgI7ijPE6xID90mfjTzh1ayoCGh9mBOl/7zkHiea5ELpvAXDrVl3673GdQ
	TuDwdO5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50204)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reuv9-0007pa-1T;
	Tue, 27 Feb 2024 10:42:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reuv8-0007Kz-PH; Tue, 27 Feb 2024 10:42:46 +0000
Date: Tue, 27 Feb 2024 10:42:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 6/6] net: sfp: add quirk for another
 multigig RollBall transceiver
Message-ID: <Zd28pgPK5ZBxjX2M@shell.armlinux.org.uk>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-7-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227075151.793496-7-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 08:51:51AM +0100, Eric Woudstra wrote:
> From: Marek Behún <kabel@kernel.org>
> 
> Add quirk for another RollBall copper transceiver: Turris RTSFP-2.5G,
> containing 2.5g capable RTL8221B PHY.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

