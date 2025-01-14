Return-Path: <netdev+bounces-158095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38996A1072D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476D61678E5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624223098A;
	Tue, 14 Jan 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+7Wle/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158720F99F
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859468; cv=none; b=EKSajdOWdJxlcPqirq1sPl7W0wX60+/7xpwL4ccz07DADUXArgn38AxT1N5zvq6bFfeeMl25xxAY4WgjLaJx9K4kV78yOGr9B/X4dd7AGF/ihuWItKBOor6GTSzBlryOD28NvlzBEmCyRBkd1YbP40wFN9a4dTI7KKyKb3g25Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859468; c=relaxed/simple;
	bh=m3UPMXobZoaJ7CqiQ3F0tW6ip+W7pXQ4Riqc2NZ/waw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq1P/NAdqKcNGS829EBDpAk5NCFNBpb8DXl9tDeXNwAVL+qK+fDBaKLmuoVlofLcjASqvsKD/av+vaP6DGXf+WOV2NiHqhIF/3moOGGnn3zmMivkDykGEkLM6q2zOpoAlPwLoHu5wpdeKbOS70TSOXnxkJuvpS+CwwBWhKNsJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+7Wle/R; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0bf4ec53fso931323a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736859464; x=1737464264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/wqUnPkHUfSZPeicafpwQOCEvjn5Jc9IONjzEWW1Kk=;
        b=D+7Wle/RQzYK0rcxtPntfzen306IvN2UViZO0Xvbh7Roc4rrOkRkoKDFZ8TrEWhUFF
         uLdi0rHW/TLV7RTmPWUTL3y9lMTkah5hkL+jCX3BkeQTQop2NqjUtPcpO2+CCyk3mgra
         3ZjGghKiF9n6fvRMutDXLS3z3My2xeY8M8sFkyNcKPW2vSjWpSylr9MS5+6bCJLrnp4h
         3TbUDmfYeBOn6+Z97K7NOOtCoA0SMFTbGKMMfUES/1CmrhQrnLi4t9BUq6N237JUka34
         geYqPHk2KE1iBVvBBc02PqdlUc6T9uV5p859gx/ZyUe0wBZaPT2W70/1sJydl6j5Emo+
         alNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736859464; x=1737464264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/wqUnPkHUfSZPeicafpwQOCEvjn5Jc9IONjzEWW1Kk=;
        b=BH5T3kqIbJIRgfXBF73laf3T0H4rkf3U9PxpuPekAUC2FCg9HafazYxvdsokYBmDG4
         riwPwJnQtsAtjQlXcZxcst20WbsbutAKBOGICLDWqKhnJE9ytegBKuIaQ7GUWkMN2hnd
         8BY/Gbs60oMLAY4AEApfQRDs4CbT/SVyAiFbRrckKOGQ57BaA9A1BNCKqWiU58xbLVsb
         Nbxu+4T0W7Ieq/SskBvu1TGRU8X031aHeVwRGw9jYseMRF7OC/SybUJXwWmdtjlAzNaG
         M1BYhsRGbo11Y9EEfKl69vW8YVzlGfX1bz2XfYcyY5pn0ItmOGGvMg6qFnvvbkAk6cAf
         mHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKe23AuRmWnstcf2JOuMN++sZK29Zr4ELPpcKY5HtzCPHym38e8mTlUyVkj32dDAg+af2bA0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEt80ZbESlCNWHQRtwIfOnePqC/FhQ1rgFCkIcMht01nsQzx0R
	lX7r4C3B6e4Ffj7U3LSiB4XJ6DvgaJeDdHcH09tNoCYcPjDDe9d1
X-Gm-Gg: ASbGncvnNNFBd0J7p4In+b7ZGz2rmTC02Ucrdinx+qJrBhHLo8EdurN6Vh0b8KEUN9I
	C9jHPmAgWaBCJ5GtYDqlyvbotcZPyRKyn4cnq6m2hVgQMU+9DpAtmMR+6zDUVWE3RsJ8SFp/Co0
	5zqx9R3A75mDFccWU/MkiCbf4UjxoG7mm/nKjQ3xT9J+3ZiXSUonPjsFPecG1w171APvAXvqRwl
	xJU1aKYXPfNeBJWPd46ypGqjtXu6eaNn867nBmvBTty
X-Google-Smtp-Source: AGHT+IEeoXDgl4L3Whp5n/U9RhVAoq8DWplfRB8ruTR8XM2o+ta6PkqlFr15CRmR/MehlW4P+BPIAA==
X-Received: by 2002:a05:6402:2347:b0:5cf:cc32:82f2 with SMTP id 4fb4d7f45d1cf-5d972e1b96dmr8686421a12.5.1736859464073;
        Tue, 14 Jan 2025 04:57:44 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4598sm6028256a12.53.2025.01.14.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 04:57:43 -0800 (PST)
Date: Tue, 14 Jan 2025 14:57:39 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com, Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH net-next v2 5/5] net: phylink: provide fixed state for
 1000base-X and 2500base-X
Message-ID: <20250114125739.sgegfxibbzpc2uor@skbuf>
References: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
 <E1tXGei-000EtL-Fn@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tXGei-000EtL-Fn@rmk-PC.armlinux.org.uk>

On Mon, Jan 13, 2025 at 09:22:44AM +0000, Russell King (Oracle) wrote:
> When decoding clause 22 state, if in-band is disabled and using either
> 1000base-X or 2500base-X, rather than reporting link-down, we know the
> speed, and we only support full duplex. Pause modes taken from XPCS.
> 
> This fixes a problem reported by Eric Woudstra.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index b79f975bc164..ff0efb52189f 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3882,27 +3882,36 @@ void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
>  	if (!state->link)
>  		return;
>  
> -	/* If in-band is disabled, then the advertisement data is not
> -	 * meaningful.
> -	 */
> -	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED)
> -		return;
> -
>  	switch (state->interface) {
>  	case PHY_INTERFACE_MODE_1000BASEX:
> -		phylink_decode_c37_word(state, lpa, SPEED_1000);
> +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +			phylink_decode_c37_word(state, lpa, SPEED_1000);
> +		} else {
> +			state->speed = SPEED_1000;
> +			state->duplex = DUPLEX_FULL;
> +			state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> +		}
>  		break;
>  
>  	case PHY_INTERFACE_MODE_2500BASEX:
> -		phylink_decode_c37_word(state, lpa, SPEED_2500);
> +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +			phylink_decode_c37_word(state, lpa, SPEED_2500);
> +		} else {
> +			state->speed = SPEED_2500;
> +			state->duplex = DUPLEX_FULL;
> +			state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> +		}
>  		break;

Are the "else" branches necessary, given the "else" branch from
phylink_mac_pcs_get_state?

static void phylink_mac_pcs_get_state(struct phylink *pl,
				      struct phylink_link_state *state)
{
	struct phylink_pcs *pcs;
	bool autoneg;

	linkmode_copy(state->advertising, pl->link_config.advertising);
	linkmode_zero(state->lp_advertising);
	state->interface = pl->link_config.interface;
	state->rate_matching = pl->link_config.rate_matching;
	state->an_complete = 0;
	state->link = 1;

	pcs = pl->pcs;
	if (!pcs || pcs->neg_mode)
		autoneg = pl->pcs_neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
	else
		autoneg = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
					    state->advertising);

	if (autoneg) {
		state->speed = SPEED_UNKNOWN;
		state->duplex = DUPLEX_UNKNOWN;
		state->pause = MLO_PAUSE_NONE;
	} else {						|
		state->speed =  pl->link_config.speed;		|
		state->duplex = pl->link_config.duplex;		| this
		state->pause = pl->link_config.pause;		|
	}							|

	if (pcs)
		pcs->ops->pcs_get_state(pcs, pl->pcs_neg_mode, state);
	else
		state->link = 0;
}

