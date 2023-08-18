Return-Path: <netdev+bounces-28810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F59780C42
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B79828223A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE7182D2;
	Fri, 18 Aug 2023 13:08:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083EB7ED
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:08:00 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C013E3A9A;
	Fri, 18 Aug 2023 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H7VtEsZofYId/aG305o0Ub13+3fvF0NwF4OODNLCumA=; b=jN18pognnRJGsiK2TBBQh836Ey
	NtS2ADPP1juZxm9y+X0RR5bPJSoix/ltu8+PlgO9oXmwIZx6DF44AJCOP0E06L7iCatpCXjyn/1nO
	ZSyDx4jdvjXIk6QT9jpsF/O4Bhnq5JoC18XoWO+ehwwPvuFxLWssqcxbHuoC20UVOgng=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWzCf-004Uj3-I9; Fri, 18 Aug 2023 15:07:49 +0200
Date: Fri, 18 Aug 2023 15:07:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Fix deadlocking in phy_error() invocation
Message-ID: <6e52f88e-73ad-4e2a-90ca-ada471f30b9d@lunn.ch>
References: <20230818125449.32061-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818125449.32061-1-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 03:54:45PM +0300, Serge Semin wrote:
>  static void phy_process_error(struct phy_device *phydev)
>  {
> -	mutex_lock(&phydev->lock);
> +	/* phydev->lock must be held for the state change to be safe */
> +	if (!mutex_is_locked(&phydev->lock))
> +		phydev_err(phydev, "PHY-device data unsafe context\n");
> +
>  	phydev->state = PHY_ERROR;
> -	mutex_unlock(&phydev->lock);
>  
>  	phy_trigger_machine(phydev);
>  }

Thanks for the patch Serge. It looks like a good implementation of
what i suggested. But thinking about it further, if the error ever
appears in somebodies kernel log, there is probably not enough
information to actually fix it. There is no call path. So i think it
should actually use WARN_ON_ONCE() so we get a stack trace.

Sorry for changing my mind.

    Andrew

---
pw-bot: cr

