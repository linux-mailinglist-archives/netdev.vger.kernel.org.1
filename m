Return-Path: <netdev+bounces-142865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320729C07EC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEBF1F21692
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B020FAB1;
	Thu,  7 Nov 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HFXknFo8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663520F5C8
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987200; cv=none; b=GcoBGMa2ujWxcpB9Yf90PDBJ6w9J6PIPrPy8qRYp/dSJPOBRs+LGcoSSaZIFHIKjOpKTRWNuStX0Q1+zt+BoTGpLHy4LqhrW6x7JFnlR1V0e1baUTZ+oXLA2A0tLiFv0UaeocLfrr5qyCne7mE8Ds6ZHiQd2tnu34Gfvst55/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987200; c=relaxed/simple;
	bh=if9jk2dSINoBzH18clA/Ys8T00nd8m33f8XjKwcmKzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFyFQ9K6qNj5mbzvTZRviXHQqvHSNwxsnb3mOU3PpnJCSTkIPrLyJjbGopvID0g8ern4gin4RjieAWxJPlupKRMovd/UqhRx6wfbSySZkcigFJ+00cpyPSrYqjPSqksUNGrYr0Cm6PC58KCFRGrQiw6apCDRDBavGF/8EXtI8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HFXknFo8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9xKdMkn79d9dnT0G1cO0adRkZI6PucX/suKssJncjsg=; b=HFXknFo8GksUNKf1250xOEd8uY
	LyikmqyjXzlTSRRYGeZP1+EPn3dILymah1Dqhx6qfJLQ2uGbqmSRtLFZqH6hkWXt7bCW7YLhvrEr/
	TlROF3xvseQWUMIXFQGzzo0NoeUDe8HVUvDhTIXU9c9IuwbGo0gyY1nAWqT/WkDlo0Qw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t92qC-00CT1q-UK; Thu, 07 Nov 2024 14:46:28 +0100
Date: Thu, 7 Nov 2024 14:46:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH net-next 1/4] net: phy: make genphy_c45_write_eee_adv()
 static
Message-ID: <f67de48c-e21e-445a-b2e4-3bd182891640@lunn.ch>
References: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
 <d23bd784-44e6-4a15-af3a-b37379156521@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23bd784-44e6-4a15-af3a-b37379156521@gmail.com>

On Wed, Nov 06, 2024 at 09:19:59PM +0100, Heiner Kallweit wrote:
61;7801;1c> genphy_c45_write_eee_adv() isn't used outside phy-c45.c,
> so make it static.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

