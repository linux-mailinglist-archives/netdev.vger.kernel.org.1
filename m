Return-Path: <netdev+bounces-248928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A795D117B1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD702301E190
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F28347BA1;
	Mon, 12 Jan 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpNokiu9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96F3469E4
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209795; cv=none; b=ZJOD3UiVNZIy1RR3Pv7k9GGpKyo/oy+DH8KX98YjrTLPX60u5YWpiEVYWEKIT19lNaDGqtrUWhkEeri95YNYuyD/m3LDHqmFIa1jxoeLei1cSXG0bBTrZ4P1jNNjgoQSRXQvuo8n3BMhOR0/c4xdfVgs4tiC+2INvBqOuQBwVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209795; c=relaxed/simple;
	bh=VQm1PyOgsvCpvBNvC4Qdu61ZrW6H6U3qOQ/DdDMJmQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RELmSEI7+ht2wa7dUPwgDY8kWqK+I1A84nlYMTSbTMAQSPdfSizreTIJWKZWO3YA1SjmGO3CPikR4pR8uaXOYlaHaNZb1w+sEUJk49Vl/BzPrTKFmdXn4sFTL/s71dNwRPY2UxbS/8b0YR2Tq5ypFjt6d0laC+GAKWx7pU+oREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpNokiu9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso36235195e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 01:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768209792; x=1768814592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH7l/IngScfdGsuBC+TU2Q1UG3VpnMUzYFClpTkwAAs=;
        b=EpNokiu9WT8qQrlqwqStFoDGDVVDJf1iO2EJs6HSU8nhy7S3jcyvJ+uT/yPizHDlL9
         XESRGihqsnu9LoOTnpNt24tKeGikEhQKdRapz1tqYlPfHjxmLUKWSypceh+/OAzlC4Mr
         hqY+ucZ45jIvom80kNouT26ytVFS0nTJeSZzP44ddeQOQN6pqbAb+myQTApmbScw/R4V
         h022pm+7EFhdJYB5XFKPvhXoi3rkBfCBEzo1LOYjEG1aUNqE9GOxdoI+k95neAMMxJRK
         zctVTNgb6yLOcLBVPGlEgY5CjBiU/mhKzaDXZbAv9K9uilvcqmw91iCFpPMYL+5Zg6vH
         28TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768209792; x=1768814592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH7l/IngScfdGsuBC+TU2Q1UG3VpnMUzYFClpTkwAAs=;
        b=c7XumOY2sN9R4y/3u4EMlzJRNGJAMuRK6MtB50weeK38N+9N1mFQfv2s7aldFImsfC
         vAFfPrCpmKxRdfR5tI/JUjBNE4xNNPnx6r5+Iwsy9gKGMtLnVqb0UuzYV6uRSBt/4wTF
         OHRFzcm0wWEskvoKYVAFupnAM2oCKlnJV+ThT8WEdE4nb1C//jv5qvmjT8JCy2ZKJLPC
         BsP6LuZnG3aLHHv9KF0ZYm8JcmQmPFGAXUFprlOpWscMH0hP4lAULeo/g8mDJ1brv+ww
         ThkKlIG7q2+3VFNRAjUwFsbpIXDFranktu0Pmz+N9DiUC9Vanq/UtEjAMl8E813XZ5oS
         hQsw==
X-Forwarded-Encrypted: i=1; AJvYcCWLYatgpjS6zxoAcZjL8dUSQ1h07RvEvaI48pRXl1U87Pn4QWXunWavCguWkGNaXZyXn5O6i3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgoZBjLPpn5kSA44FIEC0aUfO9SPlcQ3M7dh+Mmsdq6Pw+Trf
	0mvZZvQXmHH+wOzQyYdm8W23rqyHNg20jfN9HGOL8+ZlVhLNriFaO0pv
X-Gm-Gg: AY/fxX4ZaIoA2It9jLru13tQ63D1xihiwHPD/RXd4JxQzr1/dfOL16mbYbUvZ/TbtqK
	KpfsCJA83eyxQHQi+XwqI1Zw3qkvi7Q5ZuHOl8BPwWiR3UKgbCyFtO0Y+5p8BI6tD2dQdEEvNcv
	fAkwOjmENZLryQmF1IBhPXGoEtZsipwBjX+x8NkaMT5WVaXPYHH5hP7qv+2vqKtLWQW9L7rDrKS
	ZCUzqMZkVzAh2nuKbDbUGwzWjUY0/OQ3J4uR+fTFpDDqFipmcX0Okcyi8fLv2nOjKxhsGUB5acU
	TLivVdd/7bwv5uB4D/VVhCh0hSKExMRxy5PR5aupjKoYXR3y1C3O5RK4Or803OBaq6vW/c260q/
	DnwBrJ9Jn0QQQq8SURFwy8jeVpkTYeCiTp+S43tLPB6ITHocp3DhEq1DGGvMbRMcBTVW7xElLO7
	H0zVVgEqWexoA=
X-Google-Smtp-Source: AGHT+IEgPar+mXM5tZEw8XTR8zGlfzWecvjpL3x+Bjt2enom7FVlV7Q9qKVKAMWvUj+uzL/JY/TX0A==
X-Received: by 2002:a05:600c:1d0c:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47d84b4093cmr171075305e9.25.1768209792166;
        Mon, 12 Jan 2026 01:23:12 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:6091:7b62:54d8:ee9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm357831195e9.7.2026.01.12.01.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:23:11 -0800 (PST)
Date: Mon, 12 Jan 2026 10:23:09 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	robh@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
Message-ID: <aWS9fbfvuayJpo3a@eichest-laptop>
References: <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
 <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
 <aVvp70S2Lr3o_jyB@eichest-laptop>
 <aVvwOYce1CFOLiBk@shell.armlinux.org.uk>
 <aVv7wD2JFikGkt3F@eichest-laptop>
 <aWC_ZDu0HipuVhQS@eichest-laptop>
 <8f70bd9d-747f-4ffa-b0f2-1020071b5adc@bootlin.com>
 <aWJXNSiDLHLFGV8F@eichest-laptop>
 <aWJ0iV6-_4XqpeHD@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJ0iV6-_4XqpeHD@shell.armlinux.org.uk>

On Sat, Jan 10, 2026 at 03:47:21PM +0000, Russell King (Oracle) wrote:
> On Sat, Jan 10, 2026 at 02:42:13PM +0100, Stefan Eichenberger wrote:
> > Hi Maxime,
> > 
> > Not problem, thanks a lot for the feedback and the discussion. I will
> > then proceed with the current approach and send a new version with an
> > updated commit message.
> 
> We could add a flag to:
> 
> /* Generic phy_device::dev_flags */
> #define PHY_F_NO_IRQ            0x80000000
> #define PHY_F_RXC_ALWAYS_ON     0x40000000
> 
> indicating that the MAC requires the full preamble, which the PHY can
> then test for and configure appropiately.
> 
> The question is, whether the requirement for the full preamble applies
> to many MACs, and whether there are PHYs that default to producing
> short preambles.
> 
> Looking at Marvell 88e151x, the only control it has is to pad odd
> nibbles of preambles on copper (page 2, register 16, bit 6.)
> 
> AR8035 seems to make no mention of preamble for the MII interfaces, so
> I guess it has no control over it.
> 
> I've not looked further than that.

From what I have seen only the S32 and i.MX8MP MAC require the full
preamble because of the errata. I also checked the i.MX93 and i.MX8DX,
they don't mention the errata, so I assume they are not affected.

Not sure if adding the flag would be a bit overkill. However, assuming
we would do it that way. Would ndo_open be the right place to set the
flag in the mac so that the phy knows about it?

I would think about something like:
- Add a flag STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD to stmmac.h
- Add a flag PHY_F_KEEP_PREAMBLE_BEFORE_SFD to phy.h
- Add STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD to priv->plat->flags in the
  mac driver platform probe (e.g. dwmac-imx.c).
- Set PHY_F_KEEP_PREAMBLE_BEFORE_SFD in stmmac_init_phy (during
  ndo_open) if STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD is set under
  priv->plat->flags.
- If PHY_F_KEEP_PREAMBLE_BEFORE_SFD is set in the phy driver keep the
  full preamble if the phy supports it during config_init.

I could send the next version doing it that way, to see if that's the
better approach.

Regards,
Stefan


