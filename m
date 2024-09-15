Return-Path: <netdev+bounces-128455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6C97994E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63BB1F229B0
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122E7381B1;
	Sun, 15 Sep 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CVHANUWE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB64642D
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726437631; cv=none; b=syYLueCFIFRUdeiaQRs81/oc5ByYA551F93IDLQuEbvQzMErbbr5M0Ea14mZzMcA/gPjs09MVL6I0t0fu0EFdAqxOh8uA2mgoYdmlvpDIDksWD7SmiJNpTYoVkqiumvbNVHaulBvT6f5EkQlNBanKApm0QWi4L2G9D+bwuE0njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726437631; c=relaxed/simple;
	bh=hMcWLD+UudfVOmTJQXZuMZwCR9xHEWrIpj4fwh+ifPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul1P9vJdn8D2qNf1GsM3VM2YsNysXMBQTGQU13aMaXPebTiLnK4YyPwMEl7ZNpZ2WEhZrv+QA6zChfnBPmD3XZCDfPWOtHJ2PpHnZva39D3Qfqn0EFYX0FCgtu3/+QpkHR1bpjWAry7Vyv7/rwIBjtP9G+2KWbCTOLmY+Lm2ZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CVHANUWE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sW43ZRIHzYAXHAcXI1SBxcIE2kzz/W/8J10BUbSXTww=; b=CVHANUWEa3EpOC+JdUXL0nQhQ2
	I/vA+W/f1kU83718vRrNcuMPFSwVqLwEsvbKWVtP6t0DBBHbZBcGRDXFX3SyGlyNnU11NWvr0PpVN
	47ZSebAmZklgfPJ9D3Iqpp0Ef9AHkZH1qO5IUqJXmQzEzLXuWnQa+kjBr9xbjzTrLwh4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spxI8-007WSX-GL; Mon, 16 Sep 2024 00:00:24 +0200
Date: Mon, 16 Sep 2024 00:00:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/7] net: tn40xx: add support for AQR105
 based cards
Message-ID: <47aa78c1-4e31-49f9-8bfc-489927cb774a@lunn.ch>
References: <trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07>
 <c3bd51cc-fc8f-46b5-bfc3-ccb0fa1386e9@lunn.ch>
 <80d6ffff-fce0-4fa7-8042-249bfc368e65@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d6ffff-fce0-4fa7-8042-249bfc368e65@gmx.net>

> Sorry for the noise on the list.
> Yes, I am a git beginner and have done all the e-mail submission part
> manually. Which has been quite an effort.
> I will resend the patch series as RFC.

No need. Please just try to address these issues with the next version
of the patchset.

With the merge window open at the moment, and the Linux Plumbers
conference soon, it may take a while for you to get full review
comments.

	Andrew

