Return-Path: <netdev+bounces-125616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C50996DEA6
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D525B215BF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798719DF42;
	Thu,  5 Sep 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eQNFS9wO"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB6195FCE;
	Thu,  5 Sep 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551024; cv=none; b=KI8tcPyie59dto3SpJ+0r67SVjNH4q33S4dVC1YloMPhGodKkEacQYdYWRkhP7lvNoBKhA4h7clcbzwu2K4YoE+gB3IqF5V8AGu6FTlLO9IicTjIvoW/xSrzkSx4gIkfeNiPTZqo8/3KBLliBt0eDenNQwFhV8oODfUu8eA9yDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551024; c=relaxed/simple;
	bh=lg5JUkjflpb/kImGMN2KZHwHVERNIoz2DOFTF2IEvC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4lAOGdS6O/0+2Pjx3evFI+1iabYKTOTo40E/QfbakTGe16hASxB7L3JC6ZL8DRRCMS5UbxLogV3b81DuDBqy64hePXmC11iNOBbVEaANiD0sfcYpk3GumEqcga2BqdbQHZZ0Ujnl7HwD5e44CiIBp6Te3QPMH7a/0u88QoUODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eQNFS9wO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D37BEFF808;
	Thu,  5 Sep 2024 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725551019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxP6w8j9WP79mdTm5d/To0+iMbvLn3Hg6dKf0xNiVF4=;
	b=eQNFS9wOij6K/ypgfc3Nv81+j4Bns+SAecSpxVX/AZCU2mRtx29n7uoSuQYSa9Kwsm6bZV
	m3Ux+oAG/D8PbZzPENVNgGF9PttP7tro8s2aOcz2UQcG60Uu29eJ+VUsx8ZJwYTaDU881c
	iyZUJhv3xp92qAvYRzhxIjDyRx2PaxR8O5nUxOPksaWURtXrY6Uq6H5PyZFL2ZPTEvHQLw
	cPrfWwuVPKC2pQcC5iqnS+f8ILbAsCUnyRl5pYbjNaX9fU5icz2lbQjFyPDDqEb8Bud5DI
	CWArk2cSnGEWorQfxN5x0W1LC+4Um4/LyPOp0C1pIF7V5we70Hh2uxNAXicqIg==
Date: Thu, 5 Sep 2024 17:43:36 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH ethtool-next v3 3/3] ethtool: Introduce a command to
 list PHYs
Message-ID: <20240905174336.1ba5d8d7@fedora.home>
In-Reply-To: <20240905102417.232890-4-maxime.chevallier@bootlin.com>
References: <20240905102417.232890-1-maxime.chevallier@bootlin.com>
	<20240905102417.232890-4-maxime.chevallier@bootlin.com>
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

Hi everyone,

On Thu,  5 Sep 2024 12:24:16 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> It is now possible to list all Ethernet PHYs that are present behind a
> given interface, since the following linux commit :
> 63d5eaf35ac3 ("net: ethtool: Introduce a command to list PHYs on an interface")
> 
> This command relies on the netlink DUMP command to list them, by allowing to
> pass an interface name/id as a parameter in the DUMP request to only
> list PHYs on one interface.
> 
> Therefore, we introduce a new helper function to prepare a interface-filtered
> dump request (the filter can be empty, to perform an unfiltered dump),
> and then uses it to implement PHY enumeration through the --show-phys
> command.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Damn I just realised the netlink dependency was left-out of the
patchset, I'll fix that in the next revision... sorry for the noise.

Maxime

