Return-Path: <netdev+bounces-248687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7C8D0D681
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0416D3008D47
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 13:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C809F343D6E;
	Sat, 10 Jan 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/xKS7O+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AF1E3DDE
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768052539; cv=none; b=rNfkEatssTWLkvEA7u+yl1YH7angeCSAZRZVPZ22vEMzYe28Y/lV2ysqLR3gIPgWt3MyXkcoOX4VDSanNdmISy7X2JXZRSEbouyrrT/X2HhV7N2C5844L0pmBBrN1rZgLaBf3O5zhKNCc8a1xWF1KJgrzFxukxagD8HuoOYdZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768052539; c=relaxed/simple;
	bh=QHBtpr+1g4aUJXrWVXx2b2WrXDmyNzy8zeDOP6GFxq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz2KnCwRPJGxMSv6B7r3c8DfOfZeAuAmhJxnWJ1v1lQruM2lvrJcTA4HxbjU2R/9v+lHICZHr35AqbkgnSnwaQBHzTw8ty3O5dsa7RBK7Vn3mQJwupcOAA2/a+gvb6KzwnIB8kM9C3vrQXhLsypKxEyYz/4KwHKq1SSDRsHt5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/xKS7O+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso45680765e9.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 05:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768052536; x=1768657336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niKD7lwOtoha0TRVTxtTbBYIAZIgplZuxoTzqvKJ568=;
        b=W/xKS7O+FR6ocu1/qYakVfkSQ9QPMfgo1cAkdpQb683AgAIzI+hPupbDx2OovcFNo3
         suh/0l7wISQGh76UlJk/vjRB6oqYzg7zJdaQRA7llmz/h2v4uh9VPKfGdyxNsBllvTd+
         0GyR/0jRrPb36qfWVGVXU2gdZyVauFflDg5sJHcvLm22djpeQRlchlvF5567Bb27dUVw
         wekHqUe9NjRzsgS3v1tPv1EaBMvwjQ1mKXc0R7H6lh7w9NKUXyupXJ0/lhu4QFsAuC0y
         jRK4ZyOXQW1rMHoyteITXcyS0EzkBsuFOxiqD9kQ9XtOuyH8ij6+jYXPbJ9SSpEIJxS+
         Vz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768052536; x=1768657336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niKD7lwOtoha0TRVTxtTbBYIAZIgplZuxoTzqvKJ568=;
        b=TBq/aYL3sGNneUzgDBvgPuJNRW50t2A+ep34EoCjjDW0fChSPa5ngS+ABG2vmM+vKn
         scSGafwhb0gwmsxKBnU0sxVzT1N0cj9K+HP0Lt/u3cLStqPHoYVV6sWcUEQtl+N8gnTO
         YHuLzlTjffAtSaJQ+87TU5MBYwzWITxnHoivq7p9SD87Cte72fzoSyZPq2BAJ13byTBh
         yPiWC9jA33c2Ei/jE9ov7VVcNsH1we5rLBL7QNSo2qlr6UM1ktCHRF/mslqvDgwlw60a
         jnMuhFca2fUcXnCXfx31BoOM1t9egYcBaMGGRppXPS3bSHauktKfRBUSWQxHZ20/Filf
         rPWw==
X-Forwarded-Encrypted: i=1; AJvYcCWbwqu9ZCCXdJWiYUdQGY2Cyf1RML7szj2mRYpskDRCFqZ94WBr9nnhQwolaq8Dce9QdL/2Asc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQPljuOZst0Vy5515rh0FSYu8j6fZSd5VK/rT9wtFEBJG4642
	79Z7wiYVLK/xRDC9QzHydiWbXi5Uqb8A3a25MMLgvNCWwGxqZAjPKWeE
X-Gm-Gg: AY/fxX4L/Js+Y71s4TjFbrKOwNDzzbVUozVxPdtaEarv3JbCpK4ymZGqZzQA2TkbikN
	+YF0j4bAapJr4SOvB6bMkRxZJjiGxrfCVLvspH6zmb307ykDte4GW/Yr5V2FDz3f9sUYLV5ITXH
	3FLUL2pPbmjjjIYuhBepHc6Sva90hlYcFa8AU4yd1ni/maN87CjikDC6+XkJac+n5bsvVei/8hk
	HgIFk8Rq0+GnF3GEU2INDewOypasN6gWu1dvUtNyjvGImptuKJgdKAdMzAbaxGKcVBHEhvn39Ob
	0ClqZUOR18vwR3KGeeqV9NiPPfP6OWYhMbTGDH62aEgu/8H2YX7ND5WiQHiOXjAQfx0gbJ90P7q
	8YGdnTKe7HTV2flY6fqn4QrJQNvY/LqdAjrQl8TTWhOpMZxeUYXXtyAP66Yrs+cq4TJsiupqTND
	hi0DlkSipLnkCn9EdAjBOvZw==
X-Google-Smtp-Source: AGHT+IGNmY6EuRXQMgmECxnNtQwrRUp+VeCi3/b3F25cOPZ8t8M9RwpG6+Ph3Pg2FEMSimcUer23+w==
X-Received: by 2002:a05:600c:4f53:b0:479:1a09:1c4a with SMTP id 5b1f17b1804b1-47d84b3b389mr154806905e9.31.1768052536352;
        Sat, 10 Jan 2026 05:42:16 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:6968:58fa:e72d:87c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871ac28bsm85184595e9.20.2026.01.10.05.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 05:42:15 -0800 (PST)
Date: Sat, 10 Jan 2026 14:42:13 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
Message-ID: <aWJXNSiDLHLFGV8F@eichest-laptop>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
 <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
 <aVvp70S2Lr3o_jyB@eichest-laptop>
 <aVvwOYce1CFOLiBk@shell.armlinux.org.uk>
 <aVv7wD2JFikGkt3F@eichest-laptop>
 <aWC_ZDu0HipuVhQS@eichest-laptop>
 <8f70bd9d-747f-4ffa-b0f2-1020071b5adc@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f70bd9d-747f-4ffa-b0f2-1020071b5adc@bootlin.com>

Hi Maxime,

On Fri, Jan 09, 2026 at 10:38:30AM +0100, Maxime Chevallier wrote:
> Hi Stefan,
> 
> On 09/01/2026 09:42, Stefan Eichenberger wrote:
> > Hi everyone,
> > 
> > On Mon, Jan 05, 2026 at 06:58:24PM +0100, Stefan Eichenberger wrote:
> >> On Mon, Jan 05, 2026 at 05:09:13PM +0000, Russell King (Oracle) wrote:
> >>> On Mon, Jan 05, 2026 at 05:42:23PM +0100, Stefan Eichenberger wrote:
> >>>> Yes this is correct. ERR050694 from NXP states:
> >>>> The IEEE 802.3 standard states that, in MII/GMII modes, the byte
> >>>> preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
> >>>> (0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there can
> >>>> be no preceding preamble byte. The MAC receiver must successfully
> >>>> receive a packet without any preamble(0x55) byte preceding the SFD,
> >>>> SMD-S, or SMD-C byte.
> >>>> However due to the defect, in configurations where frame preemption is
> >>>> enabled, when preamble byte does not precede the SFD, SMD-S, or SMD-C
> >>>> byte, the received packet is discarded by the MAC receiver. This is
> >>>> because, the start-of-packet detection logic of the MAC receiver
> >>>> incorrectly checks for a preamble byte.
> >>>>
> >>>> NXP refers to IEEE 802.3 where in clause 35.2.3.2.2 Receive case (GMII)
> >>>> they show two tables one where the preamble is preceding the SFD and one
> >>>> where it is not. The text says:
> >>>> The operation of 1000 Mb/s PHYs can result in shrinkage of the preamble
> >>>> between transmission at the source GMII and reception at the destination
> >>>> GMII. Table 35–3 depicts the case where no preamble bytes are conveyed
> >>>> across the GMII. This case may not be possible with a specific PHY, but
> >>>> illustrates the minimum preamble with which MAC shall be able to
> >>>> operate. Table 35–4 depicts the case where the entire preamble is
> >>>> conveyed across the GMII.
> >>>>
> >>>> We would change the behavior from "no preamble is preceding SFD" to "the
> >>>> enitre preamble is preceding SFD". Both are listed in the standard and
> >>>> shall be supported by the MAC.
> >>>
> >>> Thanks for providing the full explanation, it would be good to have
> >>> that in the commit message.
> >>
> >> Okay thanks, I will provide the full explanation in the next commit
> >> message.
> >>
> >>>
> >>> The next question would be, is it just the NXP EQOS implementation
> >>> that this breaks on, or are other EQOS implementations affected?
> >>>
> >>> In other words, if we choose to conditionally enable the preable at
> >>> the PHY, should the generic parts of stmmac handle this rather than
> >>> ending up with multiple platform specific glue having to code this.
> >>> (This is something I really want to avoid - it doesn't scale.)
> >>
> >> From the errata from NXP it sounds to me like it is a configuration
> >> issue by NXP. I checked the following ERRATAs from vendors where I have
> >> access to:
> >> - ST STM32MP1: not affected: https://www.st.com/resource/en/errata_sheet/es0438-stm32mp151x3x7x-device-errata-stmicroelectronics.pdf
> >> - Renesas RZN1: not affected: https://www.renesas.com/en/document/tcu/ethernet-mac-gmac-function-issue-0?r=1054561
> >> - Starvive JH7110: not affected: https://doc-en.rvspace.org/JH7110/PDF/JH7110_Errata.pdf
> >> - NXP S32: affected: (ERR050706 under NDA)
> >>
> >> So from that I would conclude that it is an NXP specific issue and it's
> >> not the full EQOS implementation that is broken.
> > 
> > I just wanted to check whether I should continue with the current
> > approach or if I should instead enable the preamble in the PHY for all
> > MACs. While I prefer the current approach, as the issue lies with the
> > MAC rather than the PHY, I can also see the advantage of always enabling
> > the feature.
> 
> My main concern was that we may end-up with a lot of different fixups
> for the various KSZ-family PHY devices, especially since this feature is
> sometimes undocumented.
> 
> I've gone through the micrel.c driver, and looked at the datasheet of
> most PHYs in there, and so far I've found that to fix this issue, we
> need to set :
> 
> KSZ9131 / KSZ8041: Register 0x14 bit 6
> KSZ8061 / KSZ8051 : Register 0x18 bit 6
> 
> So in the end, the complexity appears to be a bit less exponential than
> I originally thought, we may end-up with only a few fixups in this driver.
> 
> I'd say, I'm fine with you proceeding with this original approach as it
> minimizes the impact and risk to break other setups.
> 
> I'm sorry for triggering this whole discussion only to get back to the
> starting point :(

Not problem, thanks a lot for the feedback and the discussion. I will
then proceed with the current approach and send a new version with an
updated commit message.

Regards,
Stefan

