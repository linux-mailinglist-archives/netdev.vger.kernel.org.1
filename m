Return-Path: <netdev+bounces-234711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2136C2651B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED7F3A4D67
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F91DDC1B;
	Fri, 31 Oct 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cLbifxJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E812C544
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931028; cv=none; b=KLn8s6OjBZdbC5CSWCf/Ne2sVOpk6uQUaGI0RiIco3Fl+Tkux6DtjYx5rJxks4zr5IdcTel2b50q7nBPLmp7p01ju2UhIn4SN11kCG7f051JJyzfaWyGAfN0b4TLJ/oJ5JfNFxjvKttckXbzYUAz39eIg89iWwLl4cW94LGNZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931028; c=relaxed/simple;
	bh=zln0QwhKcYthq0pPg/HD/PkBo+S/BsnpF5TZqOulmK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UklWkjazZZeWTdG8i1xQaG7dzPrsUPoTdYuvZYaRrQpzFFj/ith8vsacwnqCxdRt5Vhn96jsoYbYabmxCEMQbFxzizzi2+C7aldRp6hXArj/FsQxAveXGzXRQaLQaRiyXZU3V/+VsKFTxfuqxNRqkqP5Prjy4pPuBfEsP8bkVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cLbifxJm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C1AA3C0E958;
	Fri, 31 Oct 2025 17:16:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F8CD60704;
	Fri, 31 Oct 2025 17:17:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33D371181808E;
	Fri, 31 Oct 2025 18:16:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zln0QwhKcYthq0pPg/HD/PkBo+S/BsnpF5TZqOulmK0=;
	b=cLbifxJmwIvE+XvwKgRbRFJXt77MOSYc7FG8l4ctiYJqL0lJG+s5ItDxDEniaJMWs28o9D
	pJsZ2cDMtVMwXFAm6x4HciQz6eot7y6asiT/7OrtYqYRxUakg+z9oON+YjVfGqQY1jCJxG
	ATkvPl5wlkS2ifwr7ekgbGhDwufinLiLnkL/jwEIVKW06KMYfqR0TAWvtfuBI0STjghngK
	8EO4eZhs6eqrVkdWRUESlrM3SzxEI9wA5gYnuGbgFzR8J/traeZfUGUn2ljprh7NkHm8wp
	c6zNblJiUlIg5Pp19wHfiVNywsQgn5TOKUQYD4SAOmAJLj1ARptjs3rNla1Nzw==
Date: Fri, 31 Oct 2025 18:16:53 +0100
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
Subject: Re: [PATCH net-next 4/7] net: octeon: mgmt: convert to use
 ndo_hwtstamp callbacks
Message-ID: <20251031181653.2832b992@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-5-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-5-vadim.fedorenko@linux.dev>
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

On Fri, 31 Oct 2025 00:46:04 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl command only. But it stores
> timestamping configuration, so it is possible to report it to users.
> Implement both ndo_hwtstamp_set and ndo_hwtstamp_get callbacks. After
> this the ndo_eth_ioctl effectively becomes phy_do_ioctl - adjust
> callback accrodingly.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

