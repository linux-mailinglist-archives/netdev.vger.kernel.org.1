Return-Path: <netdev+bounces-154807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7579FFD56
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6143E1882859
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189184E0A;
	Thu,  2 Jan 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Hp4mkhbl"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF208F58;
	Thu,  2 Jan 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735840924; cv=none; b=OJilZkVoE4NdCZX/OAqr5QfaIal0hNMaE6L6nx7IZ38lES5DosdewwnMWW5/5yfqYlzhsBjK9ggCUXxFyVmBGcPP+B4i59lNIbAAtD2d9eIhbQw+AesQ2tGUe4YEEhB9koZCXR1AkMQtDDJ9jU64aPeK9sl5gvQxn+uN4f5yf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735840924; c=relaxed/simple;
	bh=dVVH+9Uqa5eEn3gI6bXtwz0biUyYcPsqH72CHQaI1/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nGhj8NxwbQR0ujCQrkxhLjmts8GEEGRFoGrTvV9SR3PNQ+UvOAF04nUsnq/U6tFr/vy2X2BaZIp0Ab3Z/pnsRW+Fa7maSt5LhzSTsUdkRKVhcsdMPyBGl27KzjH3XQHrN5LRii6YhixffMs8f0IC+h9xtbZTR8TE+/eN6IqGiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Hp4mkhbl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C9825404F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1735840916; bh=ybDDiRwO410ltH/c/WMHZGHV/aoneDh5QxoTEstSjZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Hp4mkhblnysz6W45W0n2sEDb7wlr2UPtvDR5B5JtcUhHkvu2sDoHkJ3nAForawXDt
	 pIVbopSJO8FBmvwciAsRT2yinLM033xfGvCNzTxGDrse5ql1Jl4enenM6tnRcpsC+d
	 DhhtdI2PUoGbiwjcTC/ciNeRpC37nDkL1wOl4H97lElkA96f8QnmgkERRilG4AsPfz
	 /iFDax+wXAPsUwXRA5tRkZKGpw+hG48ADduIj3fOuijFx7UkjxDOgV5/tCIElyi5m+
	 0aNo+LVE7naVIgwDXLjUZVslKkslTg7Ej5lJcr+TxTiiqXxfxKFR+a2HjKlNGr9Z9e
	 SPDDE/GdkgoXg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C9825404F1;
	Thu,  2 Jan 2025 18:01:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
In-Reply-To: <Z3bFWDjtGNqSGfdD@shell.armlinux.org.uk>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
 <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
 <Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
 <20241210063704.09c0ac8a@kernel.org> <Z2AbBilPf2JRXNzH@pengutronix.de>
 <20241216175316.6df45645@kernel.org> <Z2EO45xuUkzlw-Uy@pengutronix.de>
 <Z3bFWDjtGNqSGfdD@shell.armlinux.org.uk>
Date: Thu, 02 Jan 2025 11:01:54 -0700
Message-ID: <87seq1xffx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> This is the fundamental problem with kernel-doc, when it's missing
> something that really should already be there. It's not like we're
> the first to use function pointers in structs - that's a thing that
> the kernel has been doing for decades.

Unfortunately, kernel-doc is a gnarly collection of Perl regexes that
first appeared in 2.3.52pre1 some 25 years ago and has only grown more
gnarly since.

> I also have no desire to attempt to fix kernel-doc -

Neither does anybody else.  There are a few of us who will mount an
expedition into those dark woods on occasion to fix something, but there
is little desire on any part to make significant improvements, including
adding things that should already be there.  It's just barely
maintainable.

The proper solution is to reimplement kernel-doc in a language that
people actually want to deal with, cleaning out 25 years of cruft in the
process.  One way to do that would be to bring that functionality
directly into our Sphinx extension, rewriting it in Python.  An
alternative I have been considering, as a learning project that would
make me One Of The Cool Kids again, would be to do it in Rust instead.

For the time being, though, I wouldn't hold my breath for getting this
kind of improvement into kernel-doc.  I wish I could say otherwise.

Thanks,

jon

