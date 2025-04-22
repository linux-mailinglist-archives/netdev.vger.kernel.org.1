Return-Path: <netdev+bounces-184548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE0A962A8
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAAA17A818
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B06256C93;
	Tue, 22 Apr 2025 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="daQNUfuy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95F256C90
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310744; cv=none; b=AgXQFhT1yAWos+4k/X3yB0dGKy7Htgd30O2UZOezaBLLtW19ms7qHxNFjgI4+2TWCbs617L1fSeaXDl5RU6jDCzIDdj5awH/j14/FyrjpszHtMBj6qDighsdkYa5ipHxCJfq/jL4gvcRRqqKUnaWqiIkmT9nOvzJUZ/EJrgsXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310744; c=relaxed/simple;
	bh=md54eftSqSvagKV4lssM18jAS8IPYi7EGuAzwU7ygXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFsaAfSZWel4a+Ub0WuqCScNlKP0QzeH3GYdJa+ilggWtXQtWUfIUuqbDDpFEYmTH/xlIu0B69itJfT7duFnWoxzI5vfIEMsl7vCpfOw7x8zwPHMQmt5oo0dClfpX+osm3Zs43enIJLjFbGabf2nbMtJhzUekDqGErzrvZuT9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=daQNUfuy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+vovlrAh34BqLlcA5qqWSA+VUMyuO5igI3//WoHM4UE=; b=daQNUfuyKlysKlINUAmTxK6i/E
	U36AHcnZOlWM7AaYCK8jJ1447zh/+kGb8nMcVbbREqez4Sn2wZ2pvH7a81sndswHEK+X6fdddUVn7
	DCrwyhRZhTqvKjnwWxKqcJCk0GxW75osushG0LlAE7SzoEi4RbpsyPpLTcFqQb9jTkMYhsNCVgoby
	2+TofNHMagjrPhRAqOT79UGWxOyMhWMTEL564ZPznYCGA4WhbR/uvlu58skTBYpmbXKRcU8IM3jAR
	XbEE0IFj3+K6DCpsiBu7Pxe4YjOyyN+e5x0kD807jR4nq33zidftfVV+3/cB8TSh2cgzLxNfI/pHe
	EwzhHNKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u793B-000425-0S;
	Tue, 22 Apr 2025 09:32:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7938-0007KM-1u;
	Tue, 22 Apr 2025 09:32:14 +0100
Date: Tue, 22 Apr 2025 09:32:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH 1/2] net: phylink: Drop unused defines for
 SUPPORTED/ADVERTISED_INTERFACES
Message-ID: <aAdUDgTVIWbSA2Xa@shell.armlinux.org.uk>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <174481733345.986682.8252879138577629245.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174481733345.986682.8252879138577629245.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 08:28:53AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The defines for SUPPORTED_INTERFACES and ADVERTISED_INTERFACES both appear
> to be unused. I couldn't find anything that actually references them in the
> original diff that added them and it seems like they have persisted despite
> using deprecated defines that aren't supposed to be used as per the
> ethtool.h header that defines the bits they are composed of.
> 
> Since they are unused, and not supposed to be used anymore I am just
> dropping the lines of code since they seem to just be occupying space.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Please send this separately, it can be applied independently of patch 2.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

