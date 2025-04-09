Return-Path: <netdev+bounces-180620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D15A81E35
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA1E460E91
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6C25A2A6;
	Wed,  9 Apr 2025 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6VLy1Ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49021D618E;
	Wed,  9 Apr 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183461; cv=none; b=BrBwJaRrDqE14edhtHwEIyQDM69WTaVF/QWFZhHhaJgAtWvDwcYxS94nS46ZELoi9YQuYV6CTZjw8pGqaTxxrahTB2R1zwmTi0SkAv84qfRiJaSKiUGnhXLLAbj+4T1xd5Tmh6dMUKl/K8w2LpW1PFlB6ZKLLnH9l1g4V9q3msI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183461; c=relaxed/simple;
	bh=ArnVJjgtEXQreZlof1n4klVL4Al+j0YMxwGKjs+jRVw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTo8d8ncX4msz0ViP0uPc9LHlFlIM9Fxdv02Xq12DBS6DFmYAp/uTiQlcSTFo85BK1S+fcRMHTcIrjb940lzsKlFdCP6cDogc1oaHntAnbZMfstPXAFK0cVszM78+d3ADAkIxFE9zAkNmRUwX2vaCqsjB0FdulJUSZ5dQNQudDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6VLy1Ai; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso30721995e9.3;
        Wed, 09 Apr 2025 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744183458; x=1744788258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZXtjZfZaiKjV8pxyq15n6Y19W+V1TF7wJPTAdWOpVU=;
        b=L6VLy1AiP5b+i+Lw874nqiE3j9a9azy0MT1yCFzjLNMpWnXQWPytDX+IFZt6LqZ36s
         SY0eFFrMP6ru0ZS7uoJSsngb2Etw/DrvIVs34f85juynD9CVEXk8/q449CAGayYYtkcN
         saz9XuAs2YgJBueFQQcWwYXZ88hB19vYF++hb9TFpGY2XBy5II7xPpbPs/hUlAiWFuVw
         VmKLYOmB/LSCgrP+2HAE9+JOXMdevLULxS04F0B2c8dxFZcGUVVxI5j0RN5FcMeiJvvN
         qwhm7wTns0zmgHnOLLGMSy7aYL5hu0yUi0nUw4YjlvAt1Tgse5nEbj2dt4aBRMhAo5LY
         mxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183458; x=1744788258;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZXtjZfZaiKjV8pxyq15n6Y19W+V1TF7wJPTAdWOpVU=;
        b=LASGSm9/lOgAy9p0afqHs0+/24BRO8DoVzjZaIdXrLqpLEmXvc29zFIr5Ms3u2hMMV
         pkbmgqC+El2xCd1LTDvMV8n5rWnnJBNVnjqGN/ntFNfgtGcr0+SKDuTdxXdyYKnCtWY5
         bhEgndldjkyPoXI3wU9EfqCdDYRzgfGbMB98V5xWzrFrmq2+u4rJJMAsMFz/ho1I/mts
         QhGMuxwXbjQ6eidQUgoFa/CSfMxE2O/wS1HELEofHn5TG97g4Tjpl3eqJyCufevmjgR0
         9OVs8592gBaNtDUUlFZWJVWeqey0JwDsBPwhVGsm5QyK3YxWjGLMk7lnENDr6WusG9Fn
         U2EA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Bb5E8excsyy8gnuW95LJ64MQS1H/fNjTwUUshNDIV3EIs+vVnuYg9I/bQM2Z46cbIUmeGDn4qGRYac3G@vger.kernel.org, AJvYcCVL4U7/MnhJYWaOIv+oWs0QotlPiCVcJkhRMN7XW5H8+FFJZCORD9TcslF7px/pPrvxxbXJP3cb@vger.kernel.org, AJvYcCWPONnkwhR0IoamAncI9xjm7SL8hlOE1A0Ei5Z4DBPRnhNb2mT9k49ukA7mGv+yC93+hoU0vq+Trdn2@vger.kernel.org
X-Gm-Message-State: AOJu0YyMo++6CX1zk6tAbhrOijKq51DljEDBpgUmgZO5UT0TTDpb2Dxf
	PlyOZhL8U90OOoJCXjs1hmDrRhDQSXG9yznZ0nXBKt+17S6UOjp8
X-Gm-Gg: ASbGncu2aMLjeLYlCgx0L9YA4kepQ/XS2OD44fEL4D2T2knRVIM+ZDYolAeEsDr3ntw
	OQin5rvo9kK9QvL0sB3DDDhtG6bW3UXe4mLsI+MYdCYIysX3BSiaAPJ28vVTZdu5Lodq/27Txvp
	p6yd6KV4P/j3pVCFGWj8ZPf7eUReA4KgRyz4aICOFl3EY4j1dSt+zzSNAWMqdU1RGEKoijYfKdZ
	WPNDOJ33HgtWmKAm13V33tACuZw+Zel57GZ3GawyIhZp5wv5naC/GwwTostiSbmYrZNP+luMRgl
	GGLdA7bI5UzE6eKfLof8hyoAy5qKV0TyNc7prOJMUZfOYReykaoA2dl5E/NmGqTkWtBKHWte
X-Google-Smtp-Source: AGHT+IGmE5yR1RN6Y7itWh5Vm0T8GjGIHHBkIqnzUxoL1+oe6xxmSqm3+M+hIS7IhsxEa2DRXkctcg==
X-Received: by 2002:a05:600c:a0a:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-43f1fdc3f1emr12061765e9.1.1744183457625;
        Wed, 09 Apr 2025 00:24:17 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8224sm6776875e9.22.2025.04.09.00.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:24:17 -0700 (PDT)
Message-ID: <67f620a1.050a0220.347fc7.1fee@mx.google.com>
X-Google-Original-Message-ID: <Z_YgnQEv2i8n3uA2@Ansuel-XPS.>
Date: Wed, 9 Apr 2025 09:24:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v14 07/16] net: mdio: regmap: add support for
 C45 read/write
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-8-ansuelsmth@gmail.com>
 <20250409090751.6bc42b5b@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409090751.6bc42b5b@fedora.home>

On Wed, Apr 09, 2025 at 09:07:51AM +0200, Maxime Chevallier wrote:
> Hi Christian,
> 
> On Tue,  8 Apr 2025 11:51:14 +0200
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Add support for C45 read/write for mdio regmap. This can be done
> > by enabling the support_encoded_addr bool in mdio regmap config and by
> > using the new API devm_mdio_regmap_init to init a regmap.
> > 
> > To support C45, additional info needs to be appended to the regmap
> > address passed to regmap OPs.
> > 
> > The logic applied to the regmap address value:
> > - First the regnum value (20, 16)
> > - Second the devnum value (25, 21)
> > - A bit to signal if it's C45 (26)
> > 
> > devm_mdio_regmap_init MUST be used to register a regmap for this to
> > correctly handle internally the encode/decode of the address.
> > 
> > Drivers needs to define a mdio_regmap_init_config where an optional regmap
> > name can be defined and MUST define C22 OPs (mdio_read/write).
> > To support C45 operation also C45 OPs (mdio_read/write_c45).
> > 
> > The regmap from devm_mdio_regmap_init will internally decode the encoded
> > regmap address and extract the various info (addr, devnum if C45 and
> > regnum). It will then call the related OP and pass the extracted values to
> > the function.
> > 
> > Example for a C45 read operation:
> > - With an encoded address with C45 bit enabled, it will call the
> >   .mdio_read_c45 and addr, devnum and regnum will be passed.
> >   .mdio_read_c45 will then return the val and val will be stored in the
> >   regmap_read pointer and will return 0. If .mdio_read_c45 returns
> >   any error, then the regmap_read will return such error.
> > 
> > With support_encoded_addr enabled, also C22 will encode the address in
> > the regmap address and .mdio_read/write will called accordingly similar
> > to C45 operation.
> 
> This driver's orginal goal is to address the case where we have a
> PHY-like device that has the same register layout and behaviour as a
> C22 PHY, but where the registers are not accesses through MDIO (MMIO
> for example, as in altera-tse or dwmac-socfpga, or potentially SPI even
> though  there's no example upstream).
> 
> What is done here is quite different, I guess it could work if we have
> MMIO C45 phys that understand the proposed encoding, but I don't really
> understand the dance where C45 accesses are wrapped by this mdio-regmap
> driver into regmap accesss, but the regmap itself converts it back to
> C45 accesses. Is it just so that it fits well with MFD ?

The main task of this wrapping is to remove from the dev side having to
handle the encode/decode part. regmap address is still a single value
but if a phy is mmio mapped is difficult to support c45 since you need 3
different values (phy id, mmd and addr)

With this implementation a c45 that is mmio mapped can implement
whatever way he wants to configure each parameter for read/write
operation.

Example the ecoding might be on different mask and with the additional
function it can be reorganized following the specific mask.

> 
> I'm not really against that, it still converts mdio access to regmap so
> there's that, but is there a way to elaborate or document somewhere why
> we need to do go through C45 -> regmap -> C45 instead of just
> writing a mii_bus driver in the first place ?

This was askek to prevent creating additional ""trivial"" mdio driver
that would all do the same task. Since mdio-regmap was already in place
it could have been extended with a more generic approach.

Any hint on where to better document this?

> 
> As I said, I think this could work and even be re-used in other places,
> so I'm ok with that, it's just not really clear from the commit log what
> problem this solves.
> 
> Maxime

-- 
	Ansuel

