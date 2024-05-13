Return-Path: <netdev+bounces-95894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A78C3CE1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D951F21AE7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A70146D59;
	Mon, 13 May 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KVb74pfN"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1460146D56;
	Mon, 13 May 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587656; cv=none; b=nMMcvnsI6KGvr5lRWOvbdpbjKPSCsVYs4+XVt0W/9p3ugVgAyFFNPJmPgQbPKlZ0g3Zbh9Mh9S8LSoT2dc2biCvp7ogLCYfL2MMlJZ6zY0FsKuxKB3h5j3cfizmqHNCUEiRrobPFuDCiQlg8Z/8tPkyRc8/AecNcnV99bbNX1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587656; c=relaxed/simple;
	bh=v/E2QkMG6Tnerr+A88F9f3vFPE8K82fwGriKYoSJQSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBU7Cbsb8EwK8MGA4o5kHCoLCelxkpt+B+yOnE3Z/gay93YUjz8esJj70mwQFeidvsRaBUOZukTf39Q2f3yENUu5Qwtu2PGHfB6wjWeCie6oxAXCdxZqktl/jqF0MmHvhXXzYASf2AF+5C4dfiK3A1YE2kxWy3drgboA/Qgs+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KVb74pfN; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB31AFF80C;
	Mon, 13 May 2024 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715587653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/YUgEe1bGHZKnZAoXKQuqCOAbUHDdbNXzV7Y3U3kIQ=;
	b=KVb74pfNhpZrW/QoHHtX0rQAF/onUadKVpuW9nH2Jt/p2aJr+M3WfrdsoLbnk83+b3S7gL
	WAxlBSDUFLCITPRCbjqjwoHxVLGuUIyqhDrpu0EUqHUV5miIP2/84lPAV5t/4WfkuBZodx
	TXXJMOVygI5he/O6T1zjLV5JO29Shgb9GtEBtfxF2uBoPZ6xOGdvW1jZoBqSdRVXueB5/1
	PYXCCotWQPY3nwtxuRyEsPQQyDNK4UHgduy2JV2r/zyoVA6rXpKoYdzhEwRWtoMPrrPQfE
	3O06zzM93OmMl2UbkDjYl6A4saWhrhwhEl51Uo9PsnD+kbiI6SWb7EwWpisOWw==
Date: Mon, 13 May 2024 10:07:29 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor
 <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: phy_link_topology:
 Lazy-initialize the link topology
Message-ID: <20240513100729.39713abb@device-28.home>
In-Reply-To: <6cedd632-d555-4c17-81cb-984af73f2c08@gmail.com>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
	<20240507102822.2023826-3-maxime.chevallier@bootlin.com>
	<6cedd632-d555-4c17-81cb-984af73f2c08@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello again Heiner,

On Wed, 8 May 2024 07:44:22 +0200
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 07.05.2024 12:28, Maxime Chevallier wrote:
> > Having the net_device's init path for the link_topology depend on
> > IS_REACHABLE(PHYLIB)-protected helpers triggers errors when modules are being
> > built with phylib as a module as-well, as they expect netdev->link_topo
> > to be initialized.
> > 
> > Move the link_topo initialization at the first PHY insertion, which will
> > both improve the memory usage, and make the behaviour more predicatble
> > and robust.

I agree with some of the comments, as stated in my previous mail,
however I'm struggling to find the time to fix, and re-test everything,
especially before net-next closes. Would it be OK if I re-send with a
fix for the kbuild bot warning, improve the commit log as you
mentionned for patch 1 so that at least the issue can be solved ?

I still have the netlink part of this work to send, so I definitely
will have to rework that, but with a bit less time constraints so that
I can properly re-test everything.

Best regards,

Maxime

