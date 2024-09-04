Return-Path: <netdev+bounces-124903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E5096B5A0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F62B2AD1C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB61CC16A;
	Wed,  4 Sep 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o6jghW40"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C919B3C3;
	Wed,  4 Sep 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439939; cv=none; b=hlov4bDwoKOjqA94FInou2IZA12I4HyXwJzx6/uyXpQl9RGswaBSAoPeHUuiKP6Jyloyc2F/ECgc8MqhT4LZRZEs4N0v8Ys/lix+OEiGUG1iLz5iYzqtx+xVn8gvOaangcCfLmCvIaWOLG+nUxd2epqg1D76CgTQW6pAbI8JXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439939; c=relaxed/simple;
	bh=HSJBwW+MHAYy1AdbMrHJblicKcjmvt8EgdQB+6w4QF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdrJT6Z8P5VrnPcuaiC3D0Jn8RLfagwx5+xfSiXWZ0/YZbiYf0f0xFYfYHTeF3T/53EScVnWFBG4vEdvIEdhE8wzwnDsg2UOM9+FNihjDlZWm9oLPpwvbeUwHlfCidxE6DiQWnijr0FBgjGRFBCJU8DTyybNatN1a43KVZOJ+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o6jghW40; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAC3824000C;
	Wed,  4 Sep 2024 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725439936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gQVLtPniH2vSqBzxSwNJZS10K7mVOFLUlzmTaph06o=;
	b=o6jghW40e7NxWe+r/5ufjYWB0EyArQLTsDLkEjimsQpoxMs7ZrHLu2tFrBzlH3SE/vLF5d
	tnDBS5epwhzwX/E2hq6oGuPYi5ZrvXoOF3HkfohVPZKOLSpN4jrJZQCkhn2j7cxvr/52DP
	rBBNAdSOAeLIsIA1olc2I2fA1v4JneJ/5dTdAihY2nhHFzxKQFIY8C0+KhDkAh7KhkcG9m
	+yMrMTEvQlOzUaSqUoaNRrSuhc6bZEAqNCVa33UHaDQC7gtHk7VhqiFItyi7N08LRsCIIY
	Dma7a2qgvvlKh6X1vMiRzFQY/6FdSpHzrIgtHF3xJJrHmPIof1nXO5B1T+oPGQ==
Date: Wed, 4 Sep 2024 10:52:13 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 4/7] net: ethernet: fs_enet: drop unused
 phy_info and mii_if_info
Message-ID: <20240904105213.0756629d@fedora.home>
In-Reply-To: <a6eeb9e1-09f0-47a4-bf78-d59037398078@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
	<20240829161531.610874-5-maxime.chevallier@bootlin.com>
	<a6eeb9e1-09f0-47a4-bf78-d59037398078@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew,

On Fri, 30 Aug 2024 23:07:56 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Aug 29, 2024 at 06:15:27PM +0200, Maxime Chevallier wrote:
> > There's no user of the struct phy_info, the 'phy' field and the
> > mii_if_info in the fs_enet driver, probably dating back when phylib
> > wasn't as widely used.  Drop these from the driver code.  
> 
> There might be an include of linux/mii.h you can also drop?

Oh nice catch ! They are indeed no longer useful, I'll add that in V3.

Thanks,

Maxime

