Return-Path: <netdev+bounces-137855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BFF9AA181
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EE9B23A02
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD0A19CC26;
	Tue, 22 Oct 2024 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jg19uSHv"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15119B3CB
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598098; cv=none; b=EAiwOz/QzuYGb2mYJfkG3Zq5WMwzFrEECExC+cQVZut+rJXazOkHdJaKAefOHwV2IJURkybJ0pPfJpF18GRRoL1zo9HJc+i543wsGGntu4vi+/ZGBnfU3/59BN7hfpIfg/W2bKssqSkOMpY1J23GwN/8rjtHoP7SqGmSeaATJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598098; c=relaxed/simple;
	bh=GZpQVUuxETWWHX2pzleNZIEFCE3opULuAXuW7IcvF/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2/o/8Yb1gf5vfZhM6Q/VfSQkjPbtBt1P4lsTaf2K9I7ksq9bnjdgUO7bdZGQ/4ms4Q/JYjWftl/Fw29otFYEwbZrY4FL+4Ti4pn7yxnmLLZyvF0SRUvS0l6w5PbvMML/f1ZwUMuiOVYfQFH/K956PxD04+VTweZgPnk3dzDUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jg19uSHv; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 368621BF210;
	Tue, 22 Oct 2024 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729598089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnSzE30qAasyKztbpvSTjQTMBc2dNb33L3q1GTCrawI=;
	b=jg19uSHvf+KCNIGSwSyKnA/T3sS3fi9lUpmrEEoFpv07qBnIykX7NtPx24jZRtTXp9A0c6
	JmDeJQhHOT41ILZglx2VthUjEQo2I5ZNuiS/CU2174kHacDZXJ3SQa0Vm2vQT6rEHrW9Th
	L2BPeFa7o1+8iUNowHW3OQcdpEHuIAXF+88/xk5OIFNGnN3X+8fT+pXEJ9c4Pjf9Zrc65t
	jyLQSRWJsl2xoLi3ALxHzyGhd6mtffgylREbXJox1CqOzw532VKuQy3k1Huok/+vTYb3no
	52nKefQIvmTZU0ifTTQWq1NTjo8P56prmHsYVbNlqRDCVD3uATDTkNLkDWNB8Q==
Date: Tue, 22 Oct 2024 13:54:47 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: phylink: simplify SFP PHY attachment
Message-ID: <20241022135447.391b6f59@device-21.home>
In-Reply-To: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
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

Hello Russell,

On Tue, 22 Oct 2024 12:39:06 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> Hi,
> 
> These two patches simplify how we attach SFP PHYs.
> 
> The first patch notices that at the two sites where we call
> sfp_select_interface(), if that fails, we always print the same error.
> Move this into its own function.
> 
> The second patch adds an additional level of validation, checking that
> the returned interface is one that is supported by the MAC/PCS.
> 
> The last patch simplifies how SFP PHYs are attached, reducing the
> number of times that we do validation in this path.
> 
>  drivers/net/phy/phylink.c | 82 ++++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 40 deletions(-)

It looks like the patches didn't make it through, there're also not on
lore nor patchwork :(

Maxime

