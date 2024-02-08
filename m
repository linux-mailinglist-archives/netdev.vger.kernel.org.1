Return-Path: <netdev+bounces-70265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2984E343
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE0BB2811C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13B76416;
	Thu,  8 Feb 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bGpOxOdZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2Hlnwmg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501E149DFF
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402755; cv=none; b=Ve+2iEVJ7ghPg3g69l83g0AI1Z23EPdHPdGFiKombe8dRo/XP2nKXPlnIJBwusJDyigOnNwaNrdSn5wYK+G+h/6OuGJfdVKLPtQeZu1fmw4mc7OzedyBkvi5e508PNh24Nmc4A+D781V8dsOfE1lQtuYU7+j6fiLpww5OGFRiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402755; c=relaxed/simple;
	bh=1l7WrWXm+4qDe52ts9QBgcAOL5XUwWvb6/fiCXA4wuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJEmuK+JT0bQOyeKFhp7LlSTUbeMPRuM4zfqQ4jGnRYrWNW4x6Zvjc5xmWDK6zHPw8XSpKrItTucG94Xfiw0KEvf721XtiHwtJnMohszjSU0ua6Movo+obQZ8TJtmmlb8tCmTdKORa9NX1wCPHVLnACnU9wayu1SuMJaLxRVpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bGpOxOdZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2Hlnwmg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707402752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kmnynK8D4W3OfNuOIakrEyfM7cioDAxgVK3FbytS1U=;
	b=bGpOxOdZz8KjIh3Scht2Wl87HpaRmBa9E6aSTbQ4MeB4JrLU4CQbks1axiceU91YTAN4SP
	1f0UJixuPUpQvEZeL7Cjj9K5cjw/IjHUDWNPKhop8GqGyox3Wnr3u7flz6tzNMf8EirgYd
	xCuEjuYNJY+uWUom+lCCTn39HTinS8/QbKNCxMFAtDh4bcYOw8v2LfOHIRM2eKc7tBwmz2
	KIUxOE+eHNS4dLoUAe/dkHiQKvy3AklloYgLvpU+78DKum0ARqd0mERdi0DRXO0lzA4vRf
	/Ey/Np4r3CnVNfkGJeEfXeyo7TbVA1uVrkgDMrzmkVkngTZlcI8tkLOhwcAJRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707402752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kmnynK8D4W3OfNuOIakrEyfM7cioDAxgVK3FbytS1U=;
	b=l2Hlnwmg21eD+EOblp3zmFXVSzKQLlL+jBRqJ6ezflWTXHuUah7YE9Sav4hgzNlxyfc2Pw
	0/u0JfQuqs9z9YBQ==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Yannick
 Vignon <yannick.vignon@nxp.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: Simplify mtl IRQ status checking
In-Reply-To: <ZcTNCxrWTAfj90Es@boxer>
References: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
 <ZcTNCxrWTAfj90Es@boxer>
Date: Thu, 08 Feb 2024 15:32:30 +0100
Message-ID: <871q9n81s1.fsf@kurt.kurt.home>
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

On Thu Feb 08 2024, Maciej Fijalkowski wrote:
> On Thu, Feb 08, 2024 at 11:35:25AM +0100, Kurt Kanzenbach wrote:
>> Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO overflow
>> interrupts") disabled the RX FIFO overflow interrupts. However, it left =
the
>> status variable around, but never checks it.
>>=20
>> As stmmac_host_mtl_irq_status() returns only 0 now, the code can be
>> simplified.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 04d817dc5899..10ce2f272b62 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -6036,10 +6036,8 @@ static void stmmac_common_interrupt(struct stmmac=
_priv *priv)
>>  				priv->tx_path_in_lpi_mode =3D false;
>>  		}
>>=20=20
>> -		for (queue =3D 0; queue < queues_count; queue++) {
>> -			status =3D stmmac_host_mtl_irq_status(priv, priv->hw,
>> -							    queue);
>> -		}
>> +		for (queue =3D 0; queue < queues_count; queue++)
>> +			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
>
> Hey Kurt,
>
> looks to me that all of the current callbacks just return 0 so why not
> make them return void instead?

Well, there are two callbacks of this in dwmac4 and dwxgmac2. Both of
them still have the code for handling the overflow interrupt (and then
returning !=3D 0). However, as of commit 8a7cb245cf28 the interrupt
shouldn't fire. So yes, it could be changed to void along with some
code removal. But, maybe i'm missing something.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXE5f4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgoVNEACRQG38O8qvFH2wPmjBeFoLAK3lGxP9
bezvRO/XBO+/YBwOfbfDcFVq4IV46JU3wPsWwSUob/X6dtVWrbuvo18PmIJQLbf7
/w09ozvI59oMpgyGuht7p+sMW6rZJopvnnHcXWyZx5Q6dm78sqxpXJRCOJGgdq2R
LNs6DFtw3GNLC+mgz2qlWKWZb15eNMfPkI9pfzlfIiHC3NOoU06tRGM+u3O8zIkA
LuiZy9jeUW0lfTs73EictPtAWV+kIjAC0Gt20R0D7Y8IqgqhRQLKzsa1Yq2n4oV5
CQgcRZqcsxakjVfNp2P2yubTE9q6OlYYEBL/zW2tKmX93EPQLdKW5e+l04uv5scO
ppbcyFnw4flKX6eNBE5p1Ls2xJx5UypS0B/E/MTmGC/sytC5C6UWvv+S9c/tmbhb
fMWUwqa2nR2weXo7rRqu3Y9BncycxDAl99xCLq7tQJ3TifuX1WQKw6V49w1CTCu1
v98dHRh8Hcb46ZygVRyorNDjynf+ykWJ+arEynZL2qRpoaghPu53zQcwfus2P20D
Iwx8Ps/qRxUimLuyb9xlLaqbMo7pyx7xUf2JX9HCr5MeiDiGEH89IxQ6kmRapaSs
cqoWc8HbLrfRGSaTIzVOHyANQFDZh8yONokswgK3VWb6sJKnc5gTX2IcILiyUMSG
zVDIO7KCp60RvA==
=ersf
-----END PGP SIGNATURE-----
--=-=-=--

