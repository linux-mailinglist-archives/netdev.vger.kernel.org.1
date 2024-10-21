Return-Path: <netdev+bounces-137567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF19A6F19
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A5A1C228AC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B61D0153;
	Mon, 21 Oct 2024 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ROalZela"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDA29408
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527087; cv=none; b=T0MWqnZ0XPZffkL6uhwLtP8jyWcEBNFVtIRCVjEua7TwDfHNmxdxR/MEENrlWF1MQWZjENbsSTzhvUKzvZJ2qZCB6cVOtvLXpv+PVYI/YPrhbV9kB/5nNomfcLOYNTOUIhliBddXjuyiTWVlkpdC63x3NsNvtm0vDk2Ai1/NcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527087; c=relaxed/simple;
	bh=D0yjWkrdP8fUgduEaSNjMidIWy9TVLg4L834ii1yG+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvXIU/DEiI6pUTldUKM4AnKSkIM1m3BuX3rcjw0Ih70Bt5Rx2UWC1Lb1W7Me7jyj0ks0MoNwaPY88vW9JV+Khb48ln1OlEHwFdUdMHL1YL6OGhsLpikVUiFyob0N4rA9dmPcbXzgx/uY3k+/OscK50V2zsQwNyiNYfQsnvee/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ROalZela; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zg9FQVMc8Rm6QwKeLJZo3DjO4Y1KRQFgoJUdg5baRVA=; b=ROalZelawmy9jvHdxQv3RiROST
	XrnsBuEnQo0idp06DCApP0g9XeO7ReZ3mJhKPLvIZzPwEhW1csleVIu3UzU6QzTPhkMc5aIyGjcIL
	PQb+GFaIU2xbT0b8pzkzAaRq2r01/z6iLymVPTI0HAhTFF3EYXF0fKLrttIhNpUZaYHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2v04-00AkQW-Hx; Mon, 21 Oct 2024 18:11:20 +0200
Date: Mon, 21 Oct 2024 18:11:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: Re: [PATCH v1 net-next 0/3] PHC support in ENA driver
Message-ID: <1e127d15-2826-496a-8834-cd98861eabb3@lunn.ch>
References: <20241021052011.591-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021052011.591-1-darinzon@amazon.com>

On Mon, Oct 21, 2024 at 08:20:08AM +0300, David Arinzon wrote:
> This patchset adds the support for PHC (PTP Hardware Clock)
> in the ENA driver. The documentation part of the patchset
> includes additional information, including statistics,
> utilization and invocation examples through the testptp
> utility.

I _think_ you missed Cc: the PTP Maintainer, although he could be
hiding somewhere in that long list of Amazon people. Do they all need
Cc:ing?

	Andrew

