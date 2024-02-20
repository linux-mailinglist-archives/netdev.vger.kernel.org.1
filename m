Return-Path: <netdev+bounces-73231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B285B819
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943B51F21CD4
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327160DF8;
	Tue, 20 Feb 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hnEuLAHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uuKrjn6d"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE366B51
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422302; cv=none; b=fj4/pW3ArZk45tIVml0LDfNemRuNkPrvKwdKj0aUAIvTCahP/K8JBDGHSJv+2zbRtOomrHwsJOU1nQvQjfkpPWuzjO2MATk9GFNwAhWYykacOuWBluJLOayp/1o2qm8F0yQv29meRdg8nMyCFZNifoAEVro9IHaFsCGFsj2o0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422302; c=relaxed/simple;
	bh=sGjk30z9P5FxvC2x9h3mWXSO2M2G1WdWaveL9jmSnmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c9bfJ12gWy2Aq5nZ9Z8EOMutSrB44TijLes5b0F3BTrdCeIjGWzsGXOG31nE0LFj9CfPRwWDbDO27lrIJGIuTSnisjyYen/ItST2UTbz7bT/Psf6T1yWUdvUxGRR4MuFWyiYYLYDi88dHDNRUuZb5DRBIRNAXOc2TeHDvN5IM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hnEuLAHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uuKrjn6d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708422299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0IOZw6hyqiMqx4EefUlP36lkvuV/22XmEQa54rFkuug=;
	b=hnEuLAHnE35zRzIKCohcn8gnB/h12LULynfKsxpr97CogKyO26g5Z+AwjtoBLtne01WvW1
	W0wP9Idd+jr74lq8ogajkpHodAmursLOqj8+vkqPAGDrUo98RcZ7Hxy+Gl35hQbeBzJP5m
	5cQmhW/HdZhi47TAF7kbjyU1p9Kpl4A502wLvIaTC9rm5ES/g0gIpNLSrb9xiojIJkdrhB
	5kTXcLXdPlWAxpd9Dw83qv7/KiNUVr/Ym7WHB1TAfr6sq3MvBFsLLgeG3KsF+5BiYPPFGK
	EX46b6+LL8Kp9h/Hj+zdsbq9kKcs3V5Xvu9zglOH6qn3SWJEXG3pUBiKOMI7bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708422299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0IOZw6hyqiMqx4EefUlP36lkvuV/22XmEQa54rFkuug=;
	b=uuKrjn6dTnGMOlTvKs6676TlXRz1fM26Uzpz5QUWhv2bNCeL/A/Y+8EZuxjhEXVtefHfAW
	/NtYsJlYYV2jdLAQ==
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rohan G Thomas
 <rohan.g.thomas@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: Fix EST offset for dwmac 5.10
In-Reply-To: <mmjrlyzhegve5u3s3lhw4hmhooxixn3pwxkkdikxgxno4teqyz@rtetljwg6ffg>
References: <20240220-stmmac_est-v1-1-c41f9ae2e7b7@linutronix.de>
 <mmjrlyzhegve5u3s3lhw4hmhooxixn3pwxkkdikxgxno4teqyz@rtetljwg6ffg>
Date: Tue, 20 Feb 2024 10:44:57 +0100
Message-ID: <87ttm3wjty.fsf@kurt.kurt.home>
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

On Tue Feb 20 2024, Serge Semin wrote:
> Hi Kurt
>
> On Tue, Feb 20, 2024 at 09:22:46AM +0100, Kurt Kanzenbach wrote:
>> Fix EST offset for dwmac 5.10.
>>=20
>> Currently configuring Qbv doesn't work as expected. The schedule is
>> configured, but never confirmed:
>>=20
>> |[  128.250219] imx-dwmac 428a0000.ethernet eth1: configured EST
>>=20
>> The reason seems to be the refactoring of the EST code which set the wro=
ng
>> EST offset for the dwmac 5.10. After fixing this it works as before:
>>=20
>> |[  106.359577] imx-dwmac 428a0000.ethernet eth1: configured EST
>> |[  128.430715] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been swi=
tched
>>=20
>> Tested on imx93.
>>=20
>> Fixes: c3f3b97238f6 ("net: stmmac: Refactor EST implementation")
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/hwif.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/et=
hernet/stmicro/stmmac/hwif.c
>> index 1bd34b2a47e8..29367105df54 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
>> @@ -224,7 +224,7 @@ static const struct stmmac_hwif_entry {
>>  		.regs =3D {
>>  			.ptp_off =3D PTP_GMAC4_OFFSET,
>>  			.mmc_off =3D MMC_GMAC4_OFFSET,
>> -			.est_off =3D EST_XGMAC_OFFSET,
>> +			.est_off =3D EST_GMAC4_OFFSET,
>
> Unfortunate c&p typo indeed. Thanks for fixing it!

No problem. I was just wondering why the confirmation message doesn't
show up after updating to v6.8-RT :-).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXUdJkTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkDMEACpywx0fzS87yvO1q6df6W3FbGVVYuB
Ius17j0DnWupFElYtSbJvmOjHI9wI2j1aOBSbqSOdTTxEsYR2XWvfmlgH57WOfBB
oz4JPnfjV8P3rb6nlXcqOeWlultJg2ee7P4/P9kbDeEkSRb6KOArkjBxkQT99oLS
wNaqPjboXyO50ZDR2lrZqjjQWCSg8uHKt70vMfxCOra/ENiMRM/oNBb1ZQj02XcP
5rN3bKJGiwuyjFvLZUmWnvmI9KYRErEHtuoN+SThdPZzvLATJQxMM0b4YT53wUHf
5ATVgFvF/slTVh8OR5b/9K9Io17hpESubQN293JVK7Ja2kNMjmahvZaS3LvXlJu0
e9QqVHQsMgHdhp0QrBCalGvRY8wow4bJ+41IaJdGYSsoqOJBFEYNCj/EWjTdovz7
uQ0qeNJaaAz82ZGF4816jVrFY3b/nkTm/eI4YzFnl6IKTiRkxvDbm7/ER0XWel+e
huh420Nt7km7Xcs8t0pSYur2hE8YH/lh595iW7032llm4SuxpdDDKlgVYmVtoXUW
/lQLtrLiaXYEDE3HjmBrCQb14Wbc4WL2cdgqcakKfHRrWvezXICvcFGsHhCUMPDu
VGNXo8iO9bWdmuzwDHe/Yt1Ujq/8ZQsP2C0/2PZYejdXBNQJuzhypdur8WTFqul8
GKydbDv/RnY8Bg==
=08hW
-----END PGP SIGNATURE-----
--=-=-=--

