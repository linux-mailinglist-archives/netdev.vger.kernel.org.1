Return-Path: <netdev+bounces-12850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175417391BE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293511C203A1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A411D2B8;
	Wed, 21 Jun 2023 21:43:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3219E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:43:47 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322D1BC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9mGUhT/7NxwgE689oqTM9R3LBRaJ3oanHg5oIt2ortA=; b=PMu49/6gjUf+uhSiADJmiDfFmJ
	hcb3BTQ91r7VgxGU+79RD5/WZEYnZAFfgELmYSwrGMccbj2JIMTRprTGVQ6z7EfZ/XFDHt5fnFD68
	Jxss7ZpdG6v75VGkBNi7zRxy62OyaFGIjRSNz3mppJIr+BWqcv7rUQhu+NkTMDhnI7vE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qC5c6-00HC85-Dy; Wed, 21 Jun 2023 23:43:42 +0200
Date: Wed, 21 Jun 2023 23:43:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>
Subject: Re: imx8mn with mv88e6320 fails to retrieve IP address
Message-ID: <2647dbfe-860d-4a45-94ed-d1d160d9a3be@lunn.ch>
References: <CAOMZO5AdPZfQQEfSgW-Cgw2GySerc0oxUu4OEcQoxwVeB+wQWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AdPZfQQEfSgW-Cgw2GySerc0oxUu4OEcQoxwVeB+wQWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> When the Trendnet switch is used, DHCP fails and ethtool reports just
> these lines differently:
> 
>         Link partner advertised link modes:  10baseT/Half 10baseT/Full
>                                              100baseT/Half 100baseT/Full
>                                              1000baseT/Half 1000baseT/Full
>         Link partner advertised pause frame use: Symmetric

Ah, i read that wrong. What you are saying is the Trendnet additionally
has 1000BaseT/Half, and symmetric pause.

1000BaseT/Half should not be causing the problem, 1000baseT/Full will
win the election, and 1000baseT/Half is not even supported by
mv88e6xxx so is not even an option in the election.

So this is might be down to symmetric pause being negotiated.  You
might be able to prove this by hacking mv88e6185_phylink_get_caps()
and remove MAC_SYM_PAUSE. It should then no longer advertise pause,
and so the resolved auto-neg should not have pause.

    Andrew

