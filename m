Return-Path: <netdev+bounces-247031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F013BCF39B1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 429693031716
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57C33506C;
	Mon,  5 Jan 2026 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9ZsNLL0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2A333451
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616966; cv=none; b=Lm/UMbxnFoHmQsNWCOkBUoidcKfnZktQS7QJe45CFz08k6v6J1y/hXwPsV4xZaupcVTFaBhL6HuwlCKiJ+q4jYUKOYgOe272gJCK1o6RURflDrP9A0F9qYLlbVv6Ty/etbttdm6y30XaihJT3zU6MDaFTCs5rph+au8Mx+W7sd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616966; c=relaxed/simple;
	bh=LZWEskBsU8lieDU1+oZ44DvMo4dcwO7j0DMpykCV7Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP1phLn9FIJ4AUwqidhbtSQLQGS+CPh9+YcOlRjfJ4F+/gpGP91EpqlWAzL6xymN90Wx2TWzJP8+/tZ6Dn5RKyG/rdq4bdQz5hJPK8lEHWE3+efUXbJf6WcVcex0giCxHG/mdkKpChsP78UzT9FGiMybVhnQsXMYwcWnOdA45Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9ZsNLL0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so152135945e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767616962; x=1768221762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FWi4UMmKWtBKBjWiuhONQOF6ehNZanQAGIzU2PCLHY=;
        b=g9ZsNLL0degBRV8j8ia6B6b5I97aSzBnvuD/vcuWXI9JfdfNcyK9yX9tutX9oJTUIi
         vdwyDqUh8aIRoHTKbP20eU2WoWdM/TcM5+BxDzuguCrnfYDLhGqOljlN6avdiabJp2vD
         xTVYfib1EkHoYhiJslunVFQqOk9UgfNSmr1ui8aMRcLjiBG/hu3s/eAPtZNtFNMbgDV1
         kZF1N2AZL6tE0fgGeO/I+hzXkiyjlt9IMyTAbZXYqznTL2ggZV1SmYopbmEqaYBl5NnO
         vDNJ1KGJ20EgjRLN1h0OqfQhhGLDPqx9BhsnasGVNw4rDRSmX+tcvrNhAiyiKFmQjOhc
         q4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616962; x=1768221762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FWi4UMmKWtBKBjWiuhONQOF6ehNZanQAGIzU2PCLHY=;
        b=a1QYm16hLMOBadEJdEZ5fJFSOpaOJU+FcjjpHebAIOH5oJcCNxCiNjGolmgWgCP7Aq
         Y4Y8HE0eaflO7a9pFnJ2z5Kz+aM/0AYJMOEGaYBriU0JuA/tMy3hw62kce3eCuozTEzJ
         s0Qakzy9AV3YuCyn/SeK7T41O9z0qnewQol+SqSJEQ8y10fn7sTQZKnwsG7e1B+kom0e
         tXU8y/c06ItnszX7rdmO2WiWtKag7TiWIGF4wg/ay2n5/UrIXjozi8Xb5fhb4FpGajVI
         3riYO2pS2HBGj6FVKyMfiSraLHG2kU7wITgfvSJkqUiuVDfdAKfFo2kJYXCEBBozSLgA
         wM2A==
X-Forwarded-Encrypted: i=1; AJvYcCW7lF46pCQArDfjrctjdrXVdWVGQRQjgii5THGLRBwjkVD3pyM4pteoSk5xapHKyf5Js6umfAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2n81p55pIPGYQ6RCpLYu2QUUwxVrJX/R/CIrrgtNaqh3JVPq
	s99IP72jfKwghWWuRCxjsCPbBzyuOsU5t05RHKoMrSH98xc+iGWXUqWv
X-Gm-Gg: AY/fxX4z+WvG3yYJ2AyCspYzpWObCz+HHSfMkaYxli0pl4UGSelz/Jv43EffFp+sfid
	uALyjH15ptH2kBMUcXwzVjo2+qrvqaG1D5SdIgyAXCzttiA5p1QfXA8Pb/0GhA5WubalOgHqoRF
	Oos6ddWHDsu6yxb3s6Fw0kXWRqYSzOF5ozgtSVwXSp6pXTJLgdTu9GL+4L7nSHv6cRXaNC4KqHJ
	MBtJc2vZHNVhEEWppzsPvhHrn9SyWYUUrN6EuTu8R/wkup+ZJhPbxKPS+ezWaoJgEyR6h7gmtn8
	vjzi0gB5cYC2JsaS9yls3pVDsEC38Popm469GDySVgklyHDwpet+b8g9nzIXtKg/x6q7gVWriGj
	2YJ5Udthw9MCXe/nnCGOWt9/y+fwPnb3BxR59VoOubtunxmqfkuIFoYejD/d2c6unfZ1zhe8qdc
	LPi6edS3hTymo=
X-Google-Smtp-Source: AGHT+IHtGtvg4uT3cboCMh8iga2sewapNAHrP9JvUocRuk9xAXBp5Q/b/VJsN4JJTeNeQfvMRiCunw==
X-Received: by 2002:a05:600c:8287:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47d1955578bmr717393225e9.16.1767616961956;
        Mon, 05 Jan 2026 04:42:41 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:20bb:19ed:fbb2:7e2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm100277452f8f.39.2026.01.05.04.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:42:41 -0800 (PST)
Date: Mon, 5 Jan 2026 13:42:39 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
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
Message-ID: <aVuxv3Pox-y5Dzln@eichest-laptop>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>

Hi Maxime,

On Mon, Jan 05, 2026 at 01:23:46PM +0100, Maxime Chevallier wrote:
> Hi Stefan,
> 
> On 05/01/2026 11:02, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Add a fixup to the stmmac driver to keep the preamble before the SFD
> > (Start Frame Delimiter) on the Micrel KSZ9131 PHY when the driver is
> > used on an NXP i.MX8MP SoC.
> > 
> > This allows to workaround errata ERR050694 of the NXP i.MX8MP that
> > states:
> > ENET_QOS: MAC incorrectly discards the received packets when Preamble
> > Byte does not precede SFD or SMD.
> > 
> > The bit which disables this feature is not documented in the datasheet
> > from Micrel, but has been found by NXP and Micrel following this
> > discussion:
> > https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032
> > 
> > It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
> > 10MBit. Without bit 2 being set in the remote loopback register, no
> > packets are received. With the bit set, reception works fine.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> I've also faced this issue, however I'm wondering wether this is the
> correct approach to fix this. It seems that all Micrel / Microchip PHYs
> have this behaviour of discaring the preamble at 10Mbps.
> 
> Some of these phys have accessible control registers to re-enable it,
> however this register/bit changes depending on the PHY model. For
> example, on KSZ8041, this is register 0x14 bit 6.
> 
> We may end-up with many many more fixups for this, basically for every
> micrel/microchip PHY.
> 
> Wouldn't it be safer to just always enable preamble at 10M for these
> PHYs, regardless of the MAC that's connected to it ? Is there any risk
> always having the preamble there ?

This is what Rob also suggested:
https://lore.kernel.org/all/20251215140330.GA2360845-robh@kernel.org/

Unfortunately, I'm afraid of breaking something on the platforms that
are already working, as this is an Ethernet controller issue. As I
understand it, the PHY works according to the standard. Since the bit is
undocumented, it seemed safer to only apply it to the i.MX8MP.

However, if this is preferred, I am also happy to always enable the
preamble. In theory, I don't see any reason why it should break
anything.

Regards,
Stefan

