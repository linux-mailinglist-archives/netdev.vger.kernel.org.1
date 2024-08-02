Return-Path: <netdev+bounces-115439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C182C946618
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663801F21BCB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE65F13A402;
	Fri,  2 Aug 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ShlXcg56"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9751ABEB5;
	Fri,  2 Aug 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722640367; cv=none; b=LTgDI9HX5OPLTcQrMbKDrtTCD4MMTDE6Xgr6bEPqgCt4dXaUFRAZ65efffFzI1JlHZ1uK8fGJV2Zzyw0Knsv2vMZkJKADcNCkat7cNkrLlO55n2Ak4JlIYcNCPc18zWc4iEybJjMpcYWDSTkKyEc1NfteanpzoBz+tvK75v0D4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722640367; c=relaxed/simple;
	bh=SCDsB4bbmoJNrgxaoQYZ/7PJtVzlO/953ZqzDo9eUPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htm6kU8abHz390EVmxCG7gyb5PdS2IqBNfTZpff7HUh58+8swSd2HrhE0s0yGbi9oGZU/OwHp9YqV0uzXqb/U0g9UVqUu1pJXxc76w1MpN8ZOQXHIol6LB1K/9QGbLw7BcyI0TnrkYrdPW1xjND7iHew2Gxdbj3121CG0tW32b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ShlXcg56; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yHWTEXTfr8q+uwoBl3Raiba5gJpQovam4VYqeUWZ2fE=; b=ShlXcg56YbUVH3HfOXAOnGvqcv
	r4AUu2vtDOgip12eNzp8laHVp5loRNxVwxs6l41I3y8CaRkUJgJsnQtCiL1gf0VDTuL1n06M8scm6
	kV1r++bx6ZbaBxMzFXB/YxRTW+nAUFVOIwNOSWsT8ngJkBkBQ9CoaFzk+3a/1/Wt9HMk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sa1Rs-003tnD-50; Sat, 03 Aug 2024 01:12:36 +0200
Date: Sat, 3 Aug 2024 01:12:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/6] net: dsa: vsc73xx: fix port MAC configuration in
 full duplex mode
Message-ID: <fde76183-ba7d-41e9-bde7-9d717ad4c456@lunn.ch>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802080403.739509-2-paweldembicki@gmail.com>

On Fri, Aug 02, 2024 at 10:03:58AM +0200, Pawel Dembicki wrote:
> According to the datasheet description ("Port Mode Procedure" in 5.6.2),
> the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.
> 
> The WEXC_DIS bit is responsible for MAC behavior after an excessive
> collision. Let's set it as described in the datasheet.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> This patch came from net-next series[0].
> Changes since net-next:
>   - rebased to netdev/main only

Since this is targeting net, a fixes tag would still be good. If
nothing else it prevents somebody trying to backport it to linux
2.6.39 :-)

       Andrew

