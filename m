Return-Path: <netdev+bounces-148659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D469E2D1F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FE2282CDA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433D205E2E;
	Tue,  3 Dec 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2UqUT2Lw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE41F9F71;
	Tue,  3 Dec 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257845; cv=none; b=YipNhnugLgenElNCsWKjecDU+j5wXq91yNzEmFDO3uE//c27Tcnxm0HCLy7P/wjIYnqXq3m31LiEjOUhA2P1exaV3gHCiUx58Keyth9/pMa+ogQBZ45t4eKd6BnGJDX3fIdMavuTd5+Muz3aQjrf0gpp5pJ7Zu84zu08zW+75yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257845; c=relaxed/simple;
	bh=iPs7G0fRMzdN4ZRKH+RVVT6silGtng16v7pxTywJF4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVw89S/JFtHlmr43kWpWYTtp+uGQIPHEm1uGqMjO3hgFkupbS/kP8aKww0zXKS2rjrDdnhb/N2igH7/FDFbhVYaeBCQPcmsFY0FY0kLDxrLEXHrjIVPbl7cqm5CczIIFt8MI4FspLlAw7e9b78QcPr6/Zo6p2rfH4bNa7B1u9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2UqUT2Lw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GTPy/joqbMl57z6E3Ph4ZgeJWARWgwquWaZEdS/f2iw=; b=2UqUT2LwMKxKgTE5SIS88r6qI6
	8FNTrSPqZ9FrAjVVKBdKF2j0gYhbH4+QDkPGhkYdytQzsRAjvPKhCWduW2kz7axIHFAuCplHzIqR5
	OXMhr8jvNHy3o3jIb9l5skeTLd/fC6Vu0cuaf71OGahd3U1qH6iFQ/ByHCrO+kvjuxsU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZXZ-00F85d-IZ; Tue, 03 Dec 2024 21:30:37 +0100
Date: Tue, 3 Dec 2024 21:30:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 04/21] net: usb: lan78xx: Improve error
 reporting with %pe specifier
Message-ID: <2ab07aec-a546-46c6-ad94-3d1a275cad5b@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-5-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:37AM +0100, Oleksij Rempel wrote:
> Replace integer error codes with the `%pe` format specifier in register
> read and write error messages. This change provides human-readable error
> strings, making logs more informative and debugging easier.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

