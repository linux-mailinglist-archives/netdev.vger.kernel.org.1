Return-Path: <netdev+bounces-101528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584EA8FF376
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA02B22A2E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57455198E7D;
	Thu,  6 Jun 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IxIY+/zM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nK5SsT/R"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C8198A31;
	Thu,  6 Jun 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693896; cv=none; b=kLb8X//pKmIstN1OdL891rnch7VNCuMlnb84Iaom3xOhO668EEuzZQA4vB1IwZcjhqrbR4pO2zjRozud58vd6oglGy5oaq35yrNWobUh2D2gP2RANouY1evnLMetYfcOtMwGxCaX3HbMI8RBm6ncT2lcZxNGx5UzSIbpXHREobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693896; c=relaxed/simple;
	bh=63wNISo13/97qVFbNwC/m0bF2xFFqGttpBT+0BwEnew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WeM6ZvS+CqRyflNvBGbnLE4XuVDGJfmgLpXs5oO1dZ+WgiDPC3z80WbQxzMFRAOmJqtmwkuLbV4TWaWfqm4mB8Vr6qB0MFytzgKIB/lTIRPx94+8lFimqubGXhwy1mm0me4UmtUh6Yr55OFP3cgyB1uJqOyrhxQsJmhtUv93ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IxIY+/zM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nK5SsT/R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717693891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=63wNISo13/97qVFbNwC/m0bF2xFFqGttpBT+0BwEnew=;
	b=IxIY+/zMpLVNBKwD4IIN7f9oggeNH/7nzTmJzXTJ/UU41EtCzDmCSrVINaoPZP2N0R6dIB
	lAszc6oH0T2ngObSapuyxXF5iL8sC1RQQNfuZmHKa/Z5PJJFyPcpA1WRkYlJruwpuiW5o/
	HAnJNO4Nt3W4ariTgSQi6I8TmGKoQ+VGvWDqHM/AzXhOvD1qCSuUZfezH0fk1WX82uj7uh
	GFtghOgPGZivz3pbSq6qx+Jj2ITbzEEcdf8dRC8Stpz7+ryajtGP+79BnLBrauMoUo9Q66
	CPtet/fYTk87xqFIwOAmg3Hu9dAjngX0cZf45C8aFVtfVpH2jqZJyjiqwuRQjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717693891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=63wNISo13/97qVFbNwC/m0bF2xFFqGttpBT+0BwEnew=;
	b=nK5SsT/RjHVycaC4bMAFKGA9vyxTnnZUtHCHBHYZh9ewna4xNtsu6rTVS47g2ci1iiWCEq
	EG9YCNdvcMBq8yDw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: hellcreek: Replace kernel.h
 with what is used
In-Reply-To: <20240606161549.2987587-1-andriy.shevchenko@linux.intel.com>
References: <20240606161549.2987587-1-andriy.shevchenko@linux.intel.com>
Date: Thu, 06 Jun 2024 19:11:29 +0200
Message-ID: <87frtq2dz2.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu Jun 06 2024, Andy Shevchenko wrote:
> kernel.h is included solely for some other existing headers.
> Include them directly and get rid of kernel.h.
>
> While at it, sort headers alphabetically for easier maintenance.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmZh7cETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgjZVEACuxnRhqdhTumWAeUFO7CWUch7cSn8q
tqSHUEJoPjv/m7pypn6xqYIk8pTr/5FdvWXeyMCPWFF1MHG8KVufgvZgPJx2cpu+
4l0t3mBN2hQwx3KF37l/2Xt0ro6CA2HnguggBwfSwyg8OoA6v4HdD4R0iymjKPsh
4mYupER4oxnfYucp6K3teTNc9SMIO+KeInCUKyQ8ipCeV4xwrMoxZigSeax/IAEV
l8dNQtJKDakgEJ+/+8BsMoe1lTl1qWhwfA2DrERMv/X+OwRiGsMAdu1BetAmGyTe
uNUgMNRhAlgVkfouGf1JzG4DwAy+/r5vQhfQqzDIVrBQR+uGrE/H6YpcW+N90BFo
XR+4ycMY4T/obPSSRVp5EMMHAhLGTNmpJ238+jFsCqEh1vfSPKitcGoyjJJx+32I
Ub42h8mAwOyMQpDEWL5iMGCY6MbtmSTlbxZT4zVqd7rEaxwR1ZVGmSG59X5nJClI
kZKN8P9Njb/OMH5CKc4A/Lpfyx/i/WH1EXogEws3r08jz59i7yZ+L7DXW38y9EuQ
nxC9gmhO4+2zLybC0PGt+XzEbxc+CPkf78Ev3gOzKXo8/KGczpooineI1ypTlOZw
EIZUXpSoZrZd2J8KXJo4tlEPzWhVxF7YC6GWMI59E35VesyN2i2dR5FomRFSpiBj
lA+rJ4fRv+E5QQ==
=1rPQ
-----END PGP SIGNATURE-----
--=-=-=--

