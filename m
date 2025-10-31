Return-Path: <netdev+bounces-234714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D27C26536
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2229B3512AA
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713A2305070;
	Fri, 31 Oct 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YlG03qKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81022FDC2F
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931425; cv=none; b=LCjx9uno5TWeeT/u+ssZpugYnHUeTjWuBMk+rwqV3ibh7PYBVHUhYcAPiCIg1QmFMGnjVMytIa4AYs/lUcGySeIdaMav/dt5K+xRfKn6mFHcMJvC36YfWL97sTaNsZlEBf3snbOmdCvXFubWtIR+ANvar8CoVAy/Mk8dlkIAh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931425; c=relaxed/simple;
	bh=6q2NkSh6EvEes0ee9aqz6Mk5HT39PLgzFSFsdCKynDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sg3xX8qZJ7M6q5umvdMi7vW8mqVl7ATY4ldui74hf2d0K9NyZm4wj7aq7XuFC5nyuQ1bb9/P/HciF9YfDjaVQv01YifsBN1fgMSILuJnYl9WsmAv7hvL2dyuZwPi8qUlwB5+WkihEKUlv8zbtviJh6P5t/XANrygkmjGmoRDnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YlG03qKI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0760C4E4141E;
	Fri, 31 Oct 2025 17:23:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA21560704;
	Fri, 31 Oct 2025 17:23:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA61411818007;
	Fri, 31 Oct 2025 18:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931419; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6q2NkSh6EvEes0ee9aqz6Mk5HT39PLgzFSFsdCKynDs=;
	b=YlG03qKIoTkx0feVDAy0QuYyShELPfDSt9dm2JX1B05UDHCWj5nH7jgEye1xe8foK1ArFS
	w+LkB3eULvCLBCTNUc3wexzM1e7QDQUSgS0WdruZ+YnMTO+tNTSRk23eHLLfByCqxmOp3J
	G0wtaOfTbEHPh7Kpf4anCpcDZly2vO6YtjJQAShmKJ3fw/eJUOhpoX2XdFvLCgg9z4zvE5
	EIaxNViXFpcwm4uthXkR5iSwjmwxF56sSddmV6rx/0BRXKFwdW4fCq8nJbGU4Okbmr1v4D
	p5+0hBVVckTn7apqyBwcnrQz5fu/VYW91UEVXrm/bKuxs1pkyTEITX/exEcWuA==
Date: Fri, 31 Oct 2025 18:23:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Marco Crivellari <marco.crivellari@suse.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 5/7] net: thunderx: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251031182334.41cb5156@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-6-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-6-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 31 Oct 2025 00:46:05 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl command only, but it also
> stores configuration in private data, so it's possible to report it back
> to users. Implement both ndo_hwtstamp_set and ndo_hwtstamp_get
> callbacks.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

