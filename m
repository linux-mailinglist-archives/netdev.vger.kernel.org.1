Return-Path: <netdev+bounces-248395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57366D07EE0
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 381D93038051
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FED344057;
	Fri,  9 Jan 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYNaQebR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32CA2FA0DF
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948138; cv=none; b=nxp2QfH8A+XjUHbX7MAJlIK+0PNeSbxPHqcDl7LT6Wkw94uhsqitdczBvaqv7mLbV4d8BdrU3ZNAXB361zKBpGb2bxv6eoFMpS06rtAXgG2QDTj1FYtwoH74eyF8yylt8QPs9SRq0CmAbToNZSHZ/FmD5jtQkISR/gUiWVcy8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948138; c=relaxed/simple;
	bh=02A6x4UGa/2dbvl2Im6Qey6hXFFU0uIY+U1g300uWoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e177EBLfZMTCJUvJcgYsvJ/BnnKQmnBHdGAy4twmlyT1e9wgIw4icH8GXTvBBF9YqNjYHsmHNLwWjwjC7luW8bagaTI7iFH2PiCCysw853C6Twff2xASw/+LXybRqT0Fp76DFEUZ/Fn5Pyrp/jSEyaxHINq4iF5ZvvSQ+TRjlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYNaQebR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305552so2708085f8f.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 00:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767948135; x=1768552935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N/+wP7VUxOoGGhH+GyCKQ5tv6/IVz0LS1NxGo+a69kI=;
        b=QYNaQebRtfe/V//lsNZ8n5oNh3ZQMay44QJVODzZmspwFrOFxiN6yA5bQm19AC8TbK
         NEcUnlPxHF0eOgSm22oZYQKdvtwIlRHFAPGiDCqNEY4FL/LLMsDTENCZgLpsNsY/JBCZ
         fZum0RQqDBRPWjdJVhnspaB7Jc58uZ98VkqIHEUodsXn7BSW/icH8Fjkw0fQvvY9S/9N
         9DqRg/4KJfe/F4DEoOoclafi0bHTXv19kZQ1kvYfFos3qOANvmSOk6r33eHQ34lkOvRy
         Xcs/8tLC/Iz4HBAqaffSa7RZKep9mobym+IYmnBsJADzB8I7NOdPjgr+G3Gk1ZOJt8ow
         0Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767948135; x=1768552935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/+wP7VUxOoGGhH+GyCKQ5tv6/IVz0LS1NxGo+a69kI=;
        b=CRAfLNzSNKu99WMi4M6Jviv0Q1kNVAoLdnKbXF79Vic7coJNKDMyiR7H/SlDUyvVDG
         uKMy0u5+RuhdeahnMBkV8e2Fe+mc8dDdzsvAEUqTc6uki0WvBGsQo2xuwWuyM6Shz2R/
         WAIF62GgcKOsvhYiVeJDXzhKydpY7J6YSrYDnGm5VPKMQ3epIEKpsrpiagiJkenT0z2+
         IOGdJXtvwmPiCpGDlJSEkcmi5PARjnlLthDB6RxQlCV1IQ+lMxhnWcbufIlIdL57QhbV
         oEXtNSwpIxfL+p0iNfhv9woTka6n8Pj/48D2dYXqm0aRx1EjbgNCP8Xuh0eujpC5CV2v
         k2wg==
X-Forwarded-Encrypted: i=1; AJvYcCWCwmHFRl+thhO74hM5jbrhz1M24LeLFOVwDU+qeEykJAz5XDPGjgb/o8vOnNhyi/vMbHIIiDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVjPzEB9EF+Eyw4IpaTYESK4FtkBfV6Hu09Vg2mywiGzh6SjG
	O10SGVQ89PVMr72rlUhaPdDtVoRkr4t96AAHGsZMEfb8FzG6bXAyZySZ
X-Gm-Gg: AY/fxX5N/IhnTe8LGVQOigc8XT0fjjpOJl5qGco3CdtUigrYXOs3TBt6+6/uGZvT3jS
	JIqLAWkz9bC6NLsA/f75pi8khlUqtto0+5OYo/F+dOy4xbxBnke3XYg8EkC1SKCKkaMgA7QT9xY
	hdfxcbL0QhUb7+X+HzIAXpp5k0OZus0Tlqp1QoGbhBWRUUhrO446m677A+vOY7/8l5BzVZ9reMA
	WxMY3Gm9gk4GQGYgPZS1ZWiLeYa+nf+KYPi2a5d5Uo9QWhIg32SFUKVnZkO/prbOlNDpnp1JLph
	a82xk6kmqbwZTDiiaN26A9HB9xUnwJgm6vNxSNrJEQCCHtxI/opQIWuZJ+ecZsK3UmJCr3cA+sD
	wljSwkg9Pe+5Z64jtGfv5JxLB1p1Okks/cWEqRDuVDmCeGW9veDJjtannLOKxj9zvnLJmPLMK7C
	3R8slJ9iiV0kM=
X-Google-Smtp-Source: AGHT+IGYAk2S3Qdr9OmtCXbZaajNREwTznfK/Lnn5IG7bEwG+8LMc/qLBJq9BAHsaKGTT3hoN4rQcA==
X-Received: by 2002:a5d:64e3:0:b0:430:f68f:ee7d with SMTP id ffacd0b85a97d-432c379b79cmr11104260f8f.47.1767948135127;
        Fri, 09 Jan 2026 00:42:15 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:66a2:be50:e0d3:29f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacc5sm20839538f8f.5.2026.01.09.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:42:14 -0800 (PST)
Date: Fri, 9 Jan 2026 09:42:12 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	robh@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
Message-ID: <aWC_ZDu0HipuVhQS@eichest-laptop>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
 <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
 <aVvp70S2Lr3o_jyB@eichest-laptop>
 <aVvwOYce1CFOLiBk@shell.armlinux.org.uk>
 <aVv7wD2JFikGkt3F@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVv7wD2JFikGkt3F@eichest-laptop>

Hi everyone,

On Mon, Jan 05, 2026 at 06:58:24PM +0100, Stefan Eichenberger wrote:
> On Mon, Jan 05, 2026 at 05:09:13PM +0000, Russell King (Oracle) wrote:
> > On Mon, Jan 05, 2026 at 05:42:23PM +0100, Stefan Eichenberger wrote:
> > > Yes this is correct. ERR050694 from NXP states:
> > > The IEEE 802.3 standard states that, in MII/GMII modes, the byte
> > > preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
> > > (0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there can
> > > be no preceding preamble byte. The MAC receiver must successfully
> > > receive a packet without any preamble(0x55) byte preceding the SFD,
> > > SMD-S, or SMD-C byte.
> > > However due to the defect, in configurations where frame preemption is
> > > enabled, when preamble byte does not precede the SFD, SMD-S, or SMD-C
> > > byte, the received packet is discarded by the MAC receiver. This is
> > > because, the start-of-packet detection logic of the MAC receiver
> > > incorrectly checks for a preamble byte.
> > > 
> > > NXP refers to IEEE 802.3 where in clause 35.2.3.2.2 Receive case (GMII)
> > > they show two tables one where the preamble is preceding the SFD and one
> > > where it is not. The text says:
> > > The operation of 1000 Mb/s PHYs can result in shrinkage of the preamble
> > > between transmission at the source GMII and reception at the destination
> > > GMII. Table 35–3 depicts the case where no preamble bytes are conveyed
> > > across the GMII. This case may not be possible with a specific PHY, but
> > > illustrates the minimum preamble with which MAC shall be able to
> > > operate. Table 35–4 depicts the case where the entire preamble is
> > > conveyed across the GMII.
> > > 
> > > We would change the behavior from "no preamble is preceding SFD" to "the
> > > enitre preamble is preceding SFD". Both are listed in the standard and
> > > shall be supported by the MAC.
> > 
> > Thanks for providing the full explanation, it would be good to have
> > that in the commit message.
> 
> Okay thanks, I will provide the full explanation in the next commit
> message.
> 
> > 
> > The next question would be, is it just the NXP EQOS implementation
> > that this breaks on, or are other EQOS implementations affected?
> > 
> > In other words, if we choose to conditionally enable the preable at
> > the PHY, should the generic parts of stmmac handle this rather than
> > ending up with multiple platform specific glue having to code this.
> > (This is something I really want to avoid - it doesn't scale.)
> 
> From the errata from NXP it sounds to me like it is a configuration
> issue by NXP. I checked the following ERRATAs from vendors where I have
> access to:
> - ST STM32MP1: not affected: https://www.st.com/resource/en/errata_sheet/es0438-stm32mp151x3x7x-device-errata-stmicroelectronics.pdf
> - Renesas RZN1: not affected: https://www.renesas.com/en/document/tcu/ethernet-mac-gmac-function-issue-0?r=1054561
> - Starvive JH7110: not affected: https://doc-en.rvspace.org/JH7110/PDF/JH7110_Errata.pdf
> - NXP S32: affected: (ERR050706 under NDA)
> 
> So from that I would conclude that it is an NXP specific issue and it's
> not the full EQOS implementation that is broken.

I just wanted to check whether I should continue with the current
approach or if I should instead enable the preamble in the PHY for all
MACs. While I prefer the current approach, as the issue lies with the
MAC rather than the PHY, I can also see the advantage of always enabling
the feature.

Regards,
Stefan

