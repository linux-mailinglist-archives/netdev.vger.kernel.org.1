Return-Path: <netdev+bounces-70956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137D85136B
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 13:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C1D1C21377
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D9F39FFD;
	Mon, 12 Feb 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XEUQiYyT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cOe+9uRr"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217639FCC
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740263; cv=none; b=dfmF4Bo9kwbyQT9PWt/VYEGFk4M6rZpM24zQ6+RwZq3SNb+mB0jDXhDQ0lJ63GnJFFozUqFS6X57u8JwBDrxfa7BRSNmt+lczbk3xf3bEXZcDKOCA3oeVRbn0qmQCoJlcRKeEvala6MP9CqNU25oigsq8lYY5RQ1kxYn9ys1HOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740263; c=relaxed/simple;
	bh=Ss8+0g2Vw7bFP3dHKPiPH0ijjnT07QmFxhc8x5JkdWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6C1QfibFIm3WPGKacCreZN6+/XQe6fVH24gQQ67+G+42r4UNEXzB5WB69Ksr/JlWE2/HXC8+FowJHoNBerx29NJokaSp2C8eol6sxluPswfXNvHGK0+bFQPb6M1jG/yEglA8rlKW1dE97tXVlKKAOzb25QOIzfjMxy3TFLo/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XEUQiYyT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cOe+9uRr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707740258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ss8+0g2Vw7bFP3dHKPiPH0ijjnT07QmFxhc8x5JkdWk=;
	b=XEUQiYyTxYObKen4QmrlRE5tC1bNSkyXawJkfGuiti5rRUsakKrPkkl14mjs9KQmujaO4i
	UW9tl+blTBQ5YMT158wXne/LNu1KH9qSFtIPk42yj1M0ExkuzfRdE9Z8D/m/qtS7hSv1U7
	QanaYsrAeoYbpezT7SS0ns+J9cadk9VyEn6wRHnjFAKVDBZJbcTp7m/OJ8Jz3+Tf6X4e/A
	cyOEuS0qk9SQo+VmM9eqovH89LBcZ1LBa3aaQSxcBOOnS30fo2BdhpXK/jhrIs7y4NNCge
	rTCIqkEzbNROcEEMEGGUOv0UVGJEmRfGm9y0GUEmXBxAGOWH3kbxiH+O6uSM2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707740258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ss8+0g2Vw7bFP3dHKPiPH0ijjnT07QmFxhc8x5JkdWk=;
	b=cOe+9uRrx5U1EJs6y9RrsykUs92t+b95NGF4VPv7uAAjHG3AC+h6mI/a9i43cROcXruvqT
	bSO9Wqi2MqdmnSBQ==
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Yannick Vignon <yannick.vignon@nxp.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: Simplify mtl IRQ status checking
In-Reply-To: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
References: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
Date: Mon, 12 Feb 2024 13:17:37 +0100
Message-ID: <87il2t98ri.fsf@kurt.kurt.home>
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

On Thu Feb 08 2024, Kurt Kanzenbach wrote:
> Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO overflow
> interrupts") disabled the RX FIFO overflow interrupts. However, it left the
> status variable around, but never checks it.
>
> As stmmac_host_mtl_irq_status() returns only 0 now, the code can be
> simplified.
>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Hi Jakub,

why did this got marked as Changes Requested. What changes have to be
made?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXKDGETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgnngD/wOtmEmDPbwzPKAYz411R83LsJESiGo
ZgnRhNOzTYuOKVOS8aAEuyCjaj4Kc/jIhwrEhXxReei7fgEwMhvCkxBKS5q7VQvN
zJk/O5VgXPOcS2lE8/vg0hQaetztOAi/GpNF00YOlsSHT/wxtY2AwSZeXDOXrZDl
Ta6Uy78m6nVBTv4FHyKPQIoKHRfdhR/hhVUJh76dN+pRLezsSQvz1qygZLYyHjz9
8WoeGAzjSA9hk6L3/ECEMw+nn70IC7f0R33/hKRMYg0Z6f0UDzJnFrZ29QrWiqHM
W7to6wWFDqNfukWOpEVJF2FlPc/+88BQcGnNndSG/3roakLBxzdsl360hJAdxlPe
cwOJ2HRd8jByU6xJwnO3RcKhMdi/WyH7gmr9Q0S2fZE6vbq7EDfkCVhSwSyOEWUH
7nY6If+JuF1Ew3/Teixa9EKOHTUqndzTOmk4mqv+VmKum5T2gQRdE/P/kNmDrWZF
Us+vMyghfWN24flf3Mkf0/xyg6skucsYy6uMwhtBbZX1RQPvD0qDExALYEEnh7a8
nhNwlHd6/yxaoibxLfk1ftSKujnupPB8yI4B2sIfmJWmJ3sCTBeQbKEeM16mRX7D
I/Vq0TSoKl/zHQY7wrq3hvAWFWk0V8rX3uXEbB1byOvj54V4cph4CfyhfmHd3ZaG
O5ylu4WY7N0R3Q==
=Tj0h
-----END PGP SIGNATURE-----
--=-=-=--

