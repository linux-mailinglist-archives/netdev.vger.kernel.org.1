Return-Path: <netdev+bounces-206336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35454B02AE6
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 15:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088E8A62F76
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E227603A;
	Sat, 12 Jul 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmcsRTU7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AEF27602E;
	Sat, 12 Jul 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752325221; cv=none; b=okWAOVqWAd5qXJKyLsLzs+YRpxvQenxgAylor8WHpuRP9dVVPx9ad4EiTZEnyyvFMKZhHUO23SLcAu/p09Z4JjfjiMyTLt8T8VFnFtkM3zTgO+UGxQCVuVCBrLOdg51C7F53MiD1J3MhNAl49T1N1jciGrtGaNsBjFqJVfo7Gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752325221; c=relaxed/simple;
	bh=Cp5tjXCNMGFNEsHlbZX5We8HYRee7+e3mDabMoUvuLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI3EmSaKlTRPSKauhinp9K/CumFH1i6DVCHB1+D2TXYF2lAKscwmmfPaR3kvDykjqQCBf1dzYThWF+w2Ky5KF/2NQdDI+WWaN4XPE+ITd7lUVdVy3nQklqUv5kIInt5HHtaw6g16TWpa3/Sv3CsyJxfwIPiv6a++mf9sXYPVw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmcsRTU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFF9C4CEEF;
	Sat, 12 Jul 2025 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752325221;
	bh=Cp5tjXCNMGFNEsHlbZX5We8HYRee7+e3mDabMoUvuLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmcsRTU78T3ZL52l+L3mNETLu3jiAyzq79m01tfXCHXJegTwmpGcinCfrt0FOuLSv
	 6L4OCxlyq8kjUTGxA2j3IeeABAMCmUfkzVB9JWwVMgdYIobqo/8HNjqYKSJ1aCS04t
	 xqKNCzFP9O7i7OJf+IWQVPhda0iT1gOwAPqWIA6tPoydrdrNEVRTNrUhHPy+33un1j
	 Wl7yBQ5y025LE7vmioae4jfORCHZAd1ZTdNfdZgyP2PcU9Lk17t/6b+/1V1PsyX+WD
	 yLyniulvRm8KK3CeNO+qsoe52tDyimFsuVN1HBHV+Jtui1ebt6eCU30u8UcqYq5gi/
	 N38RFkLQx2dlg==
Date: Sat, 12 Jul 2025 14:00:16 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wangxun: fix LIBWX dependencies again
Message-ID: <20250712130016.GZ721198@horms.kernel.org>
References: <20250711082339.1372821-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711082339.1372821-1-arnd@kernel.org>

On Fri, Jul 11, 2025 at 10:23:34AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Two more drivers got added that use LIBWX and cause a build warning
> 
> WARNING: unmet direct dependencies detected for LIBWX
>   Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
>   Selected by [y]:
>   - NGBEVF [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI_MSI [=y]
>   Selected by [m]:
>   - NGBE [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
> 
> ld: drivers/net/ethernet/wangxun/libwx/wx_lib.o: in function `wx_clean_tx_irq':
> wx_lib.c:(.text+0x5a68): undefined reference to `ptp_schedule_worker'
> ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
> wx_ethtool.c:(.text+0x880): undefined reference to `phylink_ethtool_nway_reset'
> 
> Add the same dependency on PTP_1588_CLOCK_OPTIONAL to the two driver
> using this library module, following the pattern from commit
> 8fa19c2c69fb ("net: wangxun: fix LIBWX dependencies").
> 
> Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
> Fixes: a0008a3658a3 ("net: wangxun: add ngbevf build")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

I note that by my reading these patches are for net-next as the
commits that it "Fixes" are present there but not in net.

