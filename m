Return-Path: <netdev+bounces-193720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA5AC530B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 18:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E558A1BA31B5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A027CB35;
	Tue, 27 May 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IhRDeJrS"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EF269827;
	Tue, 27 May 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363475; cv=none; b=QXm51u8NzmVevEiMEsIHib59hWg7w75dGNdfyOr+wa0kRucjKUERFitFnZ8/M0NhRambP9GM4WLisyOFBC55wTP+CxGAM6anGzUz1LGDBDIkJ7BLckXKxw4HFCu6JvRZHuoiOt3vbyhuGnZLp/NVGotaVhIi7x0yV0TbdtxprzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363475; c=relaxed/simple;
	bh=JKIBHO1WBEk2DpCG4CViKibfgUWTWKWdTlFL7XeRaf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7n59ICQRr/t0oJBj8ur8DOgOXGNEIz8dszxDaSkF2fB98KcZjE1+oLnouZf+/AmNsInnVkmOwxFFdTCmiPIZwYsNopz/oZ9DDPTx4AwPxN9MBiWo4BYDJVo1BpbuXTKQOD3nQRewyjlvrGs0syr98tJcldd6ie095IB5GdxTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IhRDeJrS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 538A81FCF2;
	Tue, 27 May 2025 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748363469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZYLROFC13QWr0WtIHITpKv2k/IYMUKl/Ik95XSzStc=;
	b=IhRDeJrS9jEMuIKBecnBJriiCigzhovdLdAo8PcxOnxSCbLHAg2pE5zE5zYVmw1R4+039U
	CK8W6lC0U0n5puU297QfUE5VkxhETbk9T+KybDCrRlalPEUgCI6a0740UOxd5Sbwd3cSL2
	mYH8HJ8au6B/lR5hCQcIYrJhJye69OOHxk3cD3dKL0RXz7SNYbNHAEaaoAxe5DOl+XHiNp
	hu2gde3xzMIE+FeM8/T8HK4PBLAbR+2FWXws0XHzYk8mKOP1L7b/Qv0aa9Dm4dU5Z6Me3B
	0gtdejge1087acIokX/hgKqRFBJKeJRrdTYh4v+2O5SPx6Mj07/+3K8M5YqlMg==
Date: Tue, 27 May 2025 18:31:05 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, Phil Reid <preid@electromag.com.au>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: add explicit check and error on invalid
 PTP clock rate
Message-ID: <20250527183105.7c4bad49@device-24.home>
In-Reply-To: <20250527-stmmac_tstamp_div-v2-1-663251b3b542@bootlin.com>
References: <20250527-stmmac_tstamp_div-v2-1-663251b3b542@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdekieculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekheegieejkeetfffhleehteffgefhfffhueefieefffejfeethfevudetudeuueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrjeeirdeivddrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrjeeirdeivddrudejuddphhgvlhhopeguvghvihgtvgdqvdegrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopehjohgrsghrvghusehshihnohhpshihshdrtghomhdprhgtphhtt
 hhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Alexis,

On Tue, 27 May 2025 08:33:44 +0200
Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> wrote:

> The stmmac platform drivers that do not open-code the clk_ptp_rate value
> after having retrieved the default one from the device-tree can end up
> with 0 in clk_ptp_rate (as clk_get_rate can return 0). It will
> eventually propagate up to PTP initialization when bringing up the
> interface, leading to a divide by 0:
>=20
>  Division by zero in kernel.
>  CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.30-00001-g48313bd5=
768a #22
>  Hardware name: STM32 (Device Tree Support)
>  Call trace:
>   unwind_backtrace from show_stack+0x18/0x1c
>   show_stack from dump_stack_lvl+0x6c/0x8c
>   dump_stack_lvl from Ldiv0_64+0x8/0x18
>   Ldiv0_64 from stmmac_init_tstamp_counter+0x190/0x1a4
>   stmmac_init_tstamp_counter from stmmac_hw_setup+0xc1c/0x111c
>   stmmac_hw_setup from __stmmac_open+0x18c/0x434
>   __stmmac_open from stmmac_open+0x3c/0xbc
>   stmmac_open from __dev_open+0xf4/0x1ac
>   __dev_open from __dev_change_flags+0x1cc/0x224
>   __dev_change_flags from dev_change_flags+0x24/0x60
>   dev_change_flags from ip_auto_config+0x2e8/0x11a0
>   ip_auto_config from do_one_initcall+0x84/0x33c
>   do_one_initcall from kernel_init_freeable+0x1b8/0x214
>   kernel_init_freeable from kernel_init+0x24/0x140
>   kernel_init from ret_from_fork+0x14/0x28
>  Exception stack(0xe0815fb0 to 0xe0815ff8)
>=20
> Prevent this division by 0 by adding an explicit check and error log
> about the actual issue.
>=20
> Fixes: 19d857c9038e ("stmmac: Fix calculations for ptp counters when cloc=
k input =3D 50Mhz.")
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - Add Fixes tag
> - Reword commit message to clarify the triggering cause of the issue
> - Link to v1: https://lore.kernel.org/r/20250523-stmmac_tstamp_div-v1-1-b=
ca8a5a3a477@bootlin.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 918d7f2e8ba992208d7d6521a1e9dba01086058f..f68e3ece919cc88d0bf199a39=
4bc7e44b5dee095 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -835,6 +835,11 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *p=
riv, u32 systime_flags)
>  	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
>  		return -EOPNOTSUPP;
> =20
> +	if (!priv->plat->clk_ptp_rate) {
> +		netdev_err(priv->dev, "Invalid PTP clock rate");
> +		return -EINVAL;
> +	}
> +
>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
>  	priv->systime_flags =3D systime_flags;

This may be some nitpick that can be addressed at a later point, but we
now have a guarantee that when stmmac_ptp_register() gets called,
priv->ptp_clk_rate is non-zero, right ? If so, we can drop the test in
said function :

	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
		priv->plat->cdc_error_adj =3D (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_ra=
te;

There is another spot in the code, like in the EST handling, where we
divide by priv->plat->ptp_clk_rate :

stmmac_adjust_time(...)
	stmmac_est_configure(priv, priv, priv->est,
			     priv->plat->clk_ptp_rate)
		.est_configure()
			ctrl |=3D ((NSEC_PER_SEC / ptp_rate) [...]

Maybe we should fail EST configuration as well if ptp_clk_rate is 0
(probably in stmmac_tc.c's tc_taprio_configure or in the
.est_configure). That can be a step for later as well, as I don't know
if the setup you found this bug on even supports taprio/EST, and setups
that do didn't seem to encounter the bug yet.

Besides all that,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

