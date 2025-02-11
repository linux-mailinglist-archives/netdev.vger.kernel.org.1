Return-Path: <netdev+bounces-165197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B84A30EAC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6227B162FC0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F82505C8;
	Tue, 11 Feb 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6Gweo1H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4fLvAWT"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159D1F12FC
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285046; cv=none; b=KQkG+yLBGilczp2CdMoYCb5nEpZW2hCnNIMCzatdJqPSOtCX4PlyKfPM1tZMXleVZhRLLub5MazrtLZsYmlCmvMSTYA9j/CkLR4C/8rV2rgerFB4N5S4WNgEefsf8VbeH3eLPjtsz8/hzXecA6kquz/pkEtNAKrBs/LL1ydWhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285046; c=relaxed/simple;
	bh=frPQ2x9r1wmULVqXEPuuRGWbRtOiAHnDEcb1q1nENVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tjqhE1nzjUVraQ45fEVFVhtCffKYAZfn5feR5LgwSKTx5/8NB01OZcd2N0OystNH4Y+/09wG1zx1Zpxyn9Ahp2ZPaqOm1Z8n9c9/kRWl8JgVjC0hUbl5lvKpNC6xrV5dW2PueqrVLDrbcv+sQc9KnSGP3m0clXrElzUMpJ5/HbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6Gweo1H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4fLvAWT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739285042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frPQ2x9r1wmULVqXEPuuRGWbRtOiAHnDEcb1q1nENVM=;
	b=q6Gweo1HpLPTyBz4O/b0+gHb0AFS4c6dQdiKDvQEFQbFtpCWmqRClopXiOKm2ja20L3EDJ
	v3e/lzpuJbTL78rNRg3709tFZ3fC+5dBZCchOQnbqwKWmp4jV+kUnD29E7AdiSRxik7t3f
	5INucZ8ohYQKmama5x68frM1kPvNtmScEqkTA/Y1WiabRwkE3XcgaFRd+c/eD6saJuLz14
	IsW8Wr1jlagNGSMY6tc1h7mBcNTVnj8jsqTa5KBDV1qnc4ynzE9H6ByFvCjp2pFA0TdNo+
	OqmJB0uE9G0IgvPHcAjEiuLhwwnbMXYrEeCaJsB/h50ENH21cU5A7DhwXGbVaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739285042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frPQ2x9r1wmULVqXEPuuRGWbRtOiAHnDEcb1q1nENVM=;
	b=q4fLvAWT5Vlkm8VWaTGtvYApBxoY3M+ZG18eAp42c3vISDHVfKuHKJeRJe173A/x6mzgIF
	DSbdLAn7j+ZNnnBw==
To: Joe Damato <jdamato@fastly.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] igb: XDP/ZC follow up
In-Reply-To: <Z6rAuqYnIzQH_gtN@LQ3V64L9R2>
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <Z6rAuqYnIzQH_gtN@LQ3V64L9R2>
Date: Tue, 11 Feb 2025 15:44:00 +0100
Message-ID: <87ikpgr173.fsf@kurt.kurt.home>
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
Content-Transfer-Encoding: quoted-printable

On Mon Feb 10 2025, Joe Damato wrote:
> On Mon, Feb 10, 2025 at 10:19:34AM +0100, Kurt Kanzenbach wrote:
>> This is a follow up for the igb XDP/ZC implementation. The first two=20
>> patches link the IRQs and queues to NAPI instances. This is required to=
=20
>> bring back the XDP/ZC busy polling support. The last patch removes=20
>> undesired IRQs (injected via igb watchdog) while busy polling with=20
>> napi_defer_hard_irqs and gro_flush_timeout set.
>
> You may want to use netif_napi_add_config to enable persistent NAPI
> config, btw. This makes writing userland programs based on
> SO_INCOMING_NAPI_ID much easier.

Thanks, that looks useful too. I'll add another patch to this series to
use netif_napi_add_config().

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmerYjATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgupeD/0REufAXeovfQatLQDXtxRC5rNUMCRK
ZhJJ08SX1hSZ54M3vA7sX7pzDKg5YBXQIqBVvaE/fto8oWbc1OBM57g3vY8sMCF+
lctEZpn6VDxlRMj2YfJZ+tP3gnImXZlnnBbYgmUp0C+uIyDRPr99QpfohcM99sSm
5bakMC9RrJ64G4lxbIjLw5qyH+xGNZ4+WPoS2uVN3+Nn7llHUGY4Q3A6Wt0hcQg/
XzhdejD9voNkVG6blV5v2nIGNQk3Dq2nf3akAOUyFPxcEtco8ZDDhgnNlNjW4CbY
iWh+PQnsJgzmV7nxqH5j508V42rizJzfmawTjwPZKEYGC7PZqWjg5Qb+BcyXF0if
ZorUeesaOzxPgNLPNOJrqPWLzcX2ofF7lsYeROPuL/r5CHytIV9k5+Vk3Wgsv/2d
heoN+snGL/QcgotauSC04lZAhf3OsPXgK2lop1K5M7+w0KsZKbeBPoTKsuxngFXL
raYoiHLUWEUL8eXGB+hZdiOyFSkU4r1PsBvFIdrikD2F+MrQO+tORwUgOcDvr6Nk
IT8O+VDhXTNoFK2m2QMvHHVm6VP7MYROGoAubZmzSUwMVxoS0pCIz/2UIctLdJZT
Xx4L/HK6le1JEdIzkaNRS9B6KED9PZCVeWVkwIHgYMuWPbhQ610+A94wFHiCWJ8n
LPmzYjQ2ra/2aQ==
=xpvO
-----END PGP SIGNATURE-----
--=-=-=--

