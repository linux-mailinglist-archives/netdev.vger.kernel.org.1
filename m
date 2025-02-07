Return-Path: <netdev+bounces-163873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E53A2BE3F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251F47A5016
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB81A9B3B;
	Fri,  7 Feb 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DNG3E55o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZWqJSd9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19CB7DA8C
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917527; cv=none; b=t980BMOaKJ1vMTdmcaX25pOsH8vIFeV7ZDGkUI1TCnu/xl9QBNAnk9zUY6BGrWrbbzOgg5CXycgC7ht+VH0P1bFCIrvC6SHo9jKWK9CEUUESLnwHipMZJ0GpbEWuu/gXj8dvPf9RyxMhy8i3RuIKsSIDMinRd2Ce0Dm+9Qg4iOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917527; c=relaxed/simple;
	bh=/YUQ/fILgc54btr/46zTjALdXn3Fvk+L2rzUrK8Xock=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnRHQrx5og2HuceKnGWINzl8cmQYl9qmxPnCwxB+ML9TMNA1TDsRMg8Lhmlr7nzQcHKrCkX1cQb7YUo0sAMhLov1bfQ8MKo0MxyqhcViI8m1mB+3VCSJ0D7NrihFtsF8wP9KBCDGY2IR9fqG9nKkWcd9ziH3MZyHfwF4nXRjH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DNG3E55o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZWqJSd9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738917523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/YUQ/fILgc54btr/46zTjALdXn3Fvk+L2rzUrK8Xock=;
	b=DNG3E55oMumLP+OxTyPwucv7X27zS2lm28lD9JC5O3D1lSclgyqRTlD51/SYyB3QvhyeYa
	Axi2kibW0OazKV1yYwnzcdcZy9s8ZhnM+lDUKbAgWVsenaNsDH79mK+dp+UtgaQ2rtgUJx
	5VR2Kwdo56S5B2YIzwqzmD0r+EC1Kn7glZ0UcVOKqq8rSpKzX5wCouOMqzJnBUAWD5tCP1
	aWTqa7ir/hqH2dK+/6PROG+QVyweAnEUWuB1iF/K9mstj+oCqMp56fmBfnAlzfVwhO95+3
	Vxn63ioKHkK3q0RiLmywW5E7nZx7rBcigbVMU47Wv0yEyeyTHWYYybFKLTCrtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738917523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/YUQ/fILgc54btr/46zTjALdXn3Fvk+L2rzUrK8Xock=;
	b=KZWqJSd90PgDReyirmGu+baYSzWqBPR4NT8ZJ9cY8gcXdRIvI7NAQ4M+khb7ohE0rzAiik
	F0PXrhhbHST/0oCg==
To: Joe Damato <jdamato@fastly.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Stanislav Fomichev
 <sdf@fomichev.me>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: igb: XDP/ZC busy polling
Date: Fri, 07 Feb 2025 09:38:41 +0100
Message-ID: <871pwa6tf2.fsf@kurt.kurt.home>
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

Hello Joe,

I noticed that XDP/ZC busy polling does not work anymore in combination
with igb driver. This seems to be related to commit 5ef44b3cb43b ("xsk:
Bring back busy polling support") which relies on
netif_queue_set_napi().

I see you implemented it for e1000, igc and so on. However, igb is
missing. Do you have any plans to add the missing registration to igb?
Just asking. Otherwise, I can send a patch for it.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmelxpETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgra+D/wKi0eOYmVv55JcJAPC3Xn+o/z6WMtq
B85O33kxcbKLdI4Q+VGbULeMUdJAo0BTdUJJTgFgFwlWQnLiD0XvHT6iduhL02/s
Qa/pT4tGU5B6+fV6etQIs793r8ezrgHZkiPslAI2wHJ/9uWhQilGXPhw5j5sB5Gj
qdSttpOGRgzxeKm5BroSkNBQ1uRV52rqedGGs4TMLq69/IS3B20tyT4ocphBB0Ig
rQhWN1q6n9OLO8kQcuSIgqPhVdT4HRy0y4T4iHzoXmC4K2ixru7WlSdVHwdSn14K
LaM8lzvUS3V+7OxJ4J3gSmrQDQi/SQ49bRMTUcsFc0lXJ5VSfe95Vhh7vGZplbyV
eEDUHZV1doqBhEHMWlLWhUj62bMHHYYlLqnk891tJ3HH7Vg6qDRq48+rvq3l+cDx
ARq8LYMurFk4u/3E2trAawqSjvojD8OIFuMpCM4ODzkHqtoBCQAIBE1y0x2jDbTt
qHufPcfNmxSZ7/RpS8VzOKghRNkt6zr8XTfTNqdEQypcLfjLc1toH/nY2LPccSZR
qxwRKhplh1MP/l+5ra7OZKU4IzM/jWiD/dCGwKD8bthdmWqJfbOYSyyRoU7Ss0V9
i7LvonC4XtnfycNivIpG6JtG1X6xOdqUrmNkXMvzQ4LoiV1qIWJ9rSS+yw4j9Lk3
AJoIsz2u6/tIWA==
=p631
-----END PGP SIGNATURE-----
--=-=-=--

