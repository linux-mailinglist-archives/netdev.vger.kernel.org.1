Return-Path: <netdev+bounces-132620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24F89927A7
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103ED1C203B9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE618BC3A;
	Mon,  7 Oct 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LYT1GUGO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2218B464;
	Mon,  7 Oct 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291433; cv=none; b=X3sEy9jibFWoysiuWcuMtx1tShCIxDufLVm7OjUU8Z74PRh2GbX/1RuWuVc0z9lnBtv7k0m8gx1KhhYMaaH5LEL0HoZzm1YzocjCW5xl3dJ/7xomkywR6yHHzk/vLRzStGDlTwFh5avqy2MK2eSmM2i1bDI7hCFUQupwlsxnT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291433; c=relaxed/simple;
	bh=Wsl9KJO4jiKlen71VeZUY7M9etGcGeC0It/mOeVGyN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWaGjqnMjS5dOGivdL5Ff61Zt6Nr61jArZGdci8SytOHaxQWnp/Ae1FjS9upBxtVaC8P6jZBDTF1a08ZPdHdUDiCZIeJ3cPaAgC0YgtzqL3EGL0p2/yoe8MRVcHGYU2DryJEMwRgKwBqrYKgovAR+PY9PpYAqhZ74nNgEI4nK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LYT1GUGO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XuB13hKYHb3461A/xd4xLI2i4BDxl94mOyqFEkYf0Is=; b=LYT1GUGOpyNltQAkj4h5ciLtLm
	LYo6IRa5VRC8M5mdvks2mSxuSCbC9Veb4f+bfKL6alng2bmeQOSSMy+JMzKkZtNvgal5SPiod803B
	NlQ9JSufxrrUBlEtcgA9VQexftEfhq5SK05WWOL2ASi5mG+jfNyNAQ0JzwltcwKFd/BIwGQvWzFl0
	8N2oEluVeLi/+leYsa0Zp7y4AkGbUN4wS429uKQpcFNoMFSHrBXimcOiVQLrQE8ZOP2Udlbi8hn9E
	FXF1p7TiNNPa1oUwCer9OLiadUgVzJdmgG9oHaFlvIpbiZh8bZPHnpv8MozcDoXp/knon1fTZHT9X
	LXDZK0Gg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53404)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sxjYC-0005Qp-0r;
	Mon, 07 Oct 2024 09:57:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sxjY9-00045d-1g;
	Mon, 07 Oct 2024 09:57:05 +0100
Date: Mon, 7 Oct 2024 09:57:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: dsa: Fix conditional handling of Wake-on-Lan
 configuration in dsa_user_set_wol
Message-ID: <ZwOiYZKGdkH-7qOK@shell.armlinux.org.uk>
References: <20241006231938.4382-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006231938.4382-1-pvmohammedanees2003@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 07, 2024 at 04:49:38AM +0530, Mohammed Anees wrote:
> In the original implementation of dsa_user_set_wol(), the return
> value of phylink_ethtool_set_wol() was not checked, which could
> lead to errors being ignored. This wouldn't matter if it returned
> -EOPNOTSUPP, since that indicates the PHY layer doesn't support
> the option, but if any other value is returned, it is problematic
> and must be checked. The solution is to check the return value of
> phylink_ethtool_set_wol(), and if it returns anything other than
> -EOPNOTSUPP, immediately return the error. Only if it returns
> -EOPNOTSUPP should the function proceed to check whether WoL can
> be set by ds->ops->set_wol().
> 
> Fixes: 57719771a244 ("Merge tag 'sound-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
> v2:
> - Added error checking for phylink_ethtool_set_wol(), ensuring correct
> handling compared to v1.

I don't think this adds "correct handing". See my reply to the first
version.

pw-bot: cr

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

