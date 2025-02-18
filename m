Return-Path: <netdev+bounces-167371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B4A39FF3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B343A2EB0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8F269B11;
	Tue, 18 Feb 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="hU++aVqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3B269B03;
	Tue, 18 Feb 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.31.204.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889075; cv=none; b=OHw9eaxEDBHHgOU5pzpKZY5C+26DicqOkU+b+Ww6fNQ8tEVpLP5Qp+KK6MXJtwVtalgsBXjmM0dwaYzIOvIocSWVNuI9IM4shjipeXPpuNOLxP8P7OlW/E54suAGdLJjLZEOEL8HpqFqpctLBQHsOiOC38KTp/T4RpaMnnfBMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889075; c=relaxed/simple;
	bh=XVjc+2G+VrgQvPcMFNc4HVar3B49DDHd2pbUd4bIIGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+YalELl1NghhAxDOZSA8TOBXNwbwP1dqYSaNr5CpQ6hjCjSjgbcbH/EbSlj/xRTTl0z0UE03BQ9q7Aw6sXAzYVaE6Ni6lq5PssZJDfOqCL2Oh0Npz2vVgZIYWCatyK2Ir9LajIAtXvJ8/UnLF3i58aVVMEZBY1xHb1hT5CLLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz; spf=pass smtp.mailfrom=nic.cz; dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b=hU++aVqV; arc=none smtp.client-ip=217.31.204.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.cz
Received: from solitude (unknown [172.20.6.77])
	by mail.nic.cz (Postfix) with ESMTPS id CA1211C125A;
	Tue, 18 Feb 2025 15:31:08 +0100 (CET)
Authentication-Results: mail.nic.cz;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
	t=1739889069; bh=XVjc+2G+VrgQvPcMFNc4HVar3B49DDHd2pbUd4bIIGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Reply-To:
	 Subject:To:Cc;
	b=hU++aVqVL4ZMt+hsOohwqTJLBPYdbPexrCxH8QDEJtcKh4eVqnU63YnydxoSvnP4a
	 HQKnTAgfGhob7Cvv8sP6oNWKL5o5vQj6M4xjxn7Z04Dga/oUEmVRABlR8+vsJlCTq/
	 ikOxwB67usr5DIUBahRVZ6g2E3tl2yfcS/z9DcUI=
Date: Tue, 18 Feb 2025 15:31:04 +0100
From: Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: marvell-88q2xxx: align defines
Message-ID: <zd3ko6rgdp7m4hjeaui5wghivuehfitzrzfuzvcl7d5uzvimlk@35bxsojl5zw5>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
 <rfcr7sva7vs5vzfncbtrxcaa7ddosnabxu5xhuqsdspbdxwfrg@scl4wgu3m32n>
 <65fb511b-e1aa-4126-8195-ca575e008656@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65fb511b-e1aa-4126-8195-ca575e008656@lunn.ch>
X-Spamd-Bar: /
X-Rspamd-Queue-Id: CA1211C125A
X-Spamd-Result: default: False [-0.10 / 16.00];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	ARC_NA(0.00)[];
	WHITELISTED_IP(0.00)[172.20.6.77];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WHITELISTED_IP
X-Rspamd-Server: mail

On Tue, Feb 18, 2025 at 03:12:26PM +0100, Andrew Lunn wrote:
> On Tue, Feb 18, 2025 at 12:54:29PM +0100, Marek Behún wrote:
> > > +#define MDIO_MMD_AN_MV_STAT				32769
> > 
> > Why the hell are register addresses in this driver in decimal?
> 
> Maybe because 802.3 uses decimal? Take a look at Table 45–3—PMA/PMD
> registers for example.

Oh. Sorry about that, then :)

