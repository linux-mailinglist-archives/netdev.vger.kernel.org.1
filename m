Return-Path: <netdev+bounces-166908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0081A37D99
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC036189592C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187561A8407;
	Mon, 17 Feb 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xoZE3DCU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01381A3147
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782461; cv=none; b=F9bBQJVVyeZRblvaQBVmOKHu6ABpPE4Iy3F5GvCXrgqRMAJi8RSTaQtTjVXBeLmzwhh348j4IfjUK5kTmKQBB0ArWFwb2NPDhDFWJjpEzmfdTEMLAgJ+SnQ/o5cjQA3UXxBsjikbaS7gCk3r/diftpfx4D3JJ4xJzMSuesREVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782461; c=relaxed/simple;
	bh=oWineBVGnkNk6iKLOeOh/F+cD1tt/QEO+9jjmOxZo+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6R3aw5EdSArI2lSoUCH0jZM6vOd8gWDfwDXMnso3dxmhkRriGEQzJ3tGrSHy5IkUItKrOTfPnptbpMT5B8q+/+NwPn54H3INar9zaEkMQyDM+QxhiDK4hL8SqgS8Iq76sZHBzLSD/7r0OTYvO+VuZq8G6Hq//x3jsppczPCBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xoZE3DCU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hN/9/MVhJnRh726Rcj9Zi8lsbYpYMhXieCYJUD1CniY=; b=xoZE3DCUPt3ST+/Vrq48t25XRG
	9lqo7ecj0SG5BJ6VUDSiX35C3j98aFLP9ekK0SfBxN0UZq0CIxdeFd7Dm8nOw86O6tZFDbYNQHyJT
	nTLkmqA8FCLQY8xvwN3oPKo4dRTery46QO8JzM3jxCslzBjiplLV61g20DDuNdgZjoAx0rOpf26CT
	1XVH5hOZh2vYEWBb3OElDA4muyOmqZJXit1yQDTAzJ0XxJtXJOuj+REN3wdww/YdpQQCWLO9n6amB
	+ttZ3gIrAmKi3fs+M/iHfm+CXgLvDeXc65G9AQrFBM6w1o41mFtVQhdYJdVnCMyMF81FvLe1F/RB5
	bZB6jMyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjwtB-0005rM-1h;
	Mon, 17 Feb 2025 08:54:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjwt8-00064b-1m;
	Mon, 17 Feb 2025 08:54:02 +0000
Date: Mon, 17 Feb 2025 08:54:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] net: phy: move definition of phy_is_started
 before phy_disable_eee_mode
Message-ID: <Z7L5KuOg8-ZPJ3iP@shell.armlinux.org.uk>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <04d1e7a5-f4c0-42ab-8fa4-88ad26b74813@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d1e7a5-f4c0-42ab-8fa4-88ad26b74813@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 10:15:42PM +0100, Heiner Kallweit wrote:
> In preparation of a follow-up patch, move phy_is_started() to before
> phy_disable_eee_mode().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

