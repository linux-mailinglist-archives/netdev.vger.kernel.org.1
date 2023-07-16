Return-Path: <netdev+bounces-18129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AA75511B
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 21:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B31C20929
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C18F6D;
	Sun, 16 Jul 2023 19:43:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BC28E2
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:43:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453510F
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4N4Zxr23qYclF4YsJPnYQNB5N2+HxPJuwyjW91PS5Hg=; b=LrHk6zzAyozyoAUauyDEI5sqbH
	69y/2NiHTF+UCLx/PE2gBolWXxl+w59AWvkT6sMvY64sc1euIQypAesYis+IBtbw5wjm0qdmIgSFb
	KFNBTIvPu8LgJYFwzoRCU70Yj78YlAiv9cLW3cFAboGD7y0PoLjWcgtDKM3gnU2cSnBI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qL7ep-001Ul0-17; Sun, 16 Jul 2023 21:43:51 +0200
Date: Sun, 16 Jul 2023 21:43:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Chastan <ericchastan@free.fr>
Cc: netdev@vger.kernel.org
Subject: Re: r8169 stuck at 100 Mbps
Message-ID: <f70dd186-e4a4-4650-9648-3a6383a9a5ba@lunn.ch>
References: <856473501.21209060.1689534957968.JavaMail.root@zimbra64-e11.priv.proxad.net>
 <1080145252.21240687.1689535569748.JavaMail.root@zimbra64-e11.priv.proxad.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080145252.21240687.1689535569748.JavaMail.root@zimbra64-e11.priv.proxad.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 09:26:09PM +0200, Eric Chastan wrote:
> Dear developers,
> 
> I am getting in touch because I have trouble getting module r8169 handle gigabit speeds.
> 
> You will find my setup attached.
> 
> Here is the ouptput of ethtool:
> 
> $ sudo ethtool enp2s0
> Settings for enp2s0:
> 	Supported ports: [ TP	 MII ]
> 	Supported link modes:   10baseT/Half 10baseT/Full
> 	                        100baseT/Half 100baseT/Full
> 	                        1000baseT/Full
> 	Supported pause frame use: Symmetric Receive-only
> 	Supports auto-negotiation: Yes
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  1000baseT/Full
> 	Advertised pause frame use: Symmetric Receive-only
> 	Advertised auto-negotiation: No
> 	Advertised FEC modes: Not reported
> 	Speed: 1000Mb/s
> 	Duplex: Full
> 	Auto-negotiation: off

So you have disabled auto-negotiation, and forced 1G. Have you done
the same on link partner? Without auto-neg, the link partners has no
idea what this device is doing, so it is probably doing 10baseT/Half,
unless you have also configured it to force 1G.

But lets take a step back. Put everything back to defaults with
auto-neg and show use the output from ethtool, so hopefully we can see
what the link partner is advertising.

     Andrew




