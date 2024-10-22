Return-Path: <netdev+bounces-137884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FD59AAF4E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4A62841C3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B263E19E999;
	Tue, 22 Oct 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kN37vXk3"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982445945
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604874; cv=none; b=urPAEVZNP5EfeMfK/3jO3X9Pk+SPyOySMFRhKyTxjtMehKpBtL2yr2FWnl3FQJXIRDLrMuDra/7JD+1CXrqmZmLRRs6kdEOI0Qb7vxK+CwK/0gYUChUOqbMehpYBBRyXaujhQfbk+bibm6VLNPrrKG3UsiJYa1mCFT4IxE6fqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604874; c=relaxed/simple;
	bh=08PTIk7utAa++KvJ+Ofku1IoNE+FnLz4ss39rLSYWFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UV2bLvX3aH+wk/PmxVGG+Jb9rq2kGMmG7KLxLJt6aMNZ8Ws/DSEw2AWidTBM9FIwggN+nEesfHJBZuAVDinaYKEMNoKKsoQ0cKmE0zqn+55WAvd6shmQWCw0xz/Ip0ilpzo0KZ3V1tnlYqyrIz08kQto41taaF+YLVKf2YsTmwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kN37vXk3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 649E8240004;
	Tue, 22 Oct 2024 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729604865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnvK8M+4w+NUk0DJHV+wKYCtOG4dEVROMA34zPfMR5s=;
	b=kN37vXk3TC0o6MwW1Ekpz0CZ3+Ru+C70Lbf+zu7g8+WRO/fKXwuuar/MZidE6gaQ5Gd/cC
	UxpjkxdwUg+1pBEKfZG7r6Otwj79Py/TaM9LOCSCZnJCftmCmzG7fSkWQRVhGVcK7ON4WM
	fPBUbiHDsrUg2fkASpEEhBpokmAj2lrwJNTspWC5kW/V+wdoiHfcKLClwI6qbmJPtVrGGZ
	g+FhphXsiQ/iNJVZsSpMfUxo9GySzHKpaBM2u3sVBvkmsSZBz4sDStlxSdJDY37i87Q40G
	RK+W8KqINGL8Y/TFtfvp6kH80LtSdhXis7ZrTwX5TtdZ+oAFT0oPs77FsyyWAw==
Date: Tue, 22 Oct 2024 15:47:43 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: phylink: validate
 sfp_select_interface() returned interface
Message-ID: <20241022154743.613787a9@device-21.home>
In-Reply-To: <E1t3DSm-000VxR-MN@rmk-PC.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
	<E1t3DSm-000VxR-MN@rmk-PC.armlinux.org.uk>
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

On Tue, 22 Oct 2024 12:54:12 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Validate that the returned interface from sfp_select_interface() is
> supportable by the MAC/PCS. If it isn't, print an error and return
> the NA interface type. This is a preparatory step to reorganising
> how a PHY on a SFP module is handled.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

