Return-Path: <netdev+bounces-161554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B1A2248F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 20:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6953A1729
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF91E0DCB;
	Wed, 29 Jan 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iliYlKf8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F6190462
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179020; cv=none; b=KmCjPkenGTg7pYCYYLJ91GhIWMb0LNFdfClDA2PkCET3/66pYFGaBU5A2NXfqbNrhnIyM6RfPml3mWbIJHdq+cU4K87fMRgeG/hpIINZmMTKyJoithks3DbVGlTBVEa+dCGrEqlEBdO1LrDKE0/6+DhEON4ia/TyDwip8UBs7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179020; c=relaxed/simple;
	bh=jtShdk1cLxI3rsQL364KYAtkjGyrugsFoIDco1+bSw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPkksL0lOzdJlOzF8FqL93vLg6AMoH9Yme6gsBhhQ8wg0hJQn2SQcOr+2hlqd/JcaxmKUYajfKSq77nCiUBq7NJTyAuuidpcDU2HyQNLep7INEf5au9cqSei/VWru+Nwjt9qyzDIbr/o9P9X8UFrsw7i5U8gZJTLFw49+gGGpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iliYlKf8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dl5tdFJKGkb0tly6/jg3uxs+uJgTOsmpr2dUEi3zFeQ=; b=iliYlKf8V0uex8sekdGf6ezWT+
	l7qob9WqpiqHTlYhtB7tD3b22uDcIvcgdRBAXS2M45JsBYIxXn2ialDOyheijmyIEEOKNhB0aV7sf
	RkhNn3bB0TiCKe5z/VxN2HZp9foATsH0ObnciK2IkVx+mI0P238TQqk4ynMCbBqObjipTGYNtYb2p
	ovJoQMHjpM8OXqRoyziFOy1+AGg2GKLSX0N4oU+haHRQ9YUH5B9kMY9ImollxTXaCD8c9xi+RR2Xo
	7fT2Ci6k+OMIspZlieA1ScuVTFb9IMtV2TP9NPzVV0qo8WIB/buAPIF3I1gNudDV7D0oCXB3Cs/ON
	hJ0rW55Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32908)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdDlC-0001zc-2K;
	Wed, 29 Jan 2025 19:30:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdDl9-0003uU-2Q;
	Wed, 29 Jan 2025 19:29:59 +0000
Date: Wed, 29 Jan 2025 19:29:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "sreedevi.joshi" <joshisre@ecsmtp.an.intel.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>
Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Message-ID: <Z5qBt4Cnds7NvBea@shell.armlinux.org.uk>
References: <20250129183638.695010-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129183638.695010-1-sreedevi.joshi@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 29, 2025 at 12:36:38PM -0600, sreedevi.joshi wrote:
> From: Sreedevi Joshi <sreedevi.joshi@intel.com>
> 
> When attaching a fixed phy to devices like veth, it is
> possible that there is no parent. The logic in
> phy_attach_direct() tries to access the driver member
> without checking for the null. This causes segfault in the
> case of fixed phy.

Kernel mode doesn't segfault. That's a userspace thing. Kernel mode
oopses.

I'm confused. You mention veth, which presumably is drivers/net/veth.c.
Grepping this driver for "phy" returns nothing. So how can veth be
broken by a phylib change?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

