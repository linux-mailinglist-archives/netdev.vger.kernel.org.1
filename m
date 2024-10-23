Return-Path: <netdev+bounces-138115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D639AC01C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA821F21D3D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F351537AC;
	Wed, 23 Oct 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aukyNOez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29ED3A8D0;
	Wed, 23 Oct 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668120; cv=none; b=ROSgIo2eyd4R7r3aK9YrOrbDNpGj4yPRPfpI6D/WZqJXx/jLy0lrdR90lNTiOGECM1uwmrtIEds4aTyFcwJpB7V1Vl5GlL/1vdIDJpZHx7RCdXOmCAl0XG9UbJSMq5guvxQR080XBN/o8Cc9JLyx/kJlmuUr/oCww/p8Fn/cQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668120; c=relaxed/simple;
	bh=50ezmcEJzxDJ24mowip9lHrIonLa3G33aAyWzqTY2C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpBU25QqYn8f8/8zwN5KCZ0AW/ad1C8CSaewJ12eQVBRbociayZvYpcN8GkRYafSmH92NSvE3QRXawpCiRQKHhVngwEefkcssYNW4BObkwX8ocOTxP0lsvIjW1w+F/812GyHuddkpWKcvpRAJK53Selg7cC7Ojgqc231Ly+Cgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aukyNOez; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8c50fdd9so3948855ad.0;
        Wed, 23 Oct 2024 00:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729668118; x=1730272918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JpW5l4cHfObYzl7+2svJ3Qk3MetE1pLsV3fZ39aook=;
        b=aukyNOezlMoyLLPOnobizcuoLXqApP5+SFgftgaMYrQjRAdreKkGefUiRwcKrgFh1U
         vGXymT3blML9AdzJEp82I3rj/PjG2sF8I5xl8gvFlCkKMpeQC+ejulE6YEA2/XinL3vA
         +QCW5EsZGT/0O9bGOEtohDS1Kk9idGqKBtdqjNSppbAsiZC96GzOOraPkv82KYPTESfA
         mz3c5JMWgU4iT4XKn4+Acbf8Ygcp6npnEf97AmDT0UaqTWOGkFo+KkB5a2+4sWxdccz3
         f+GEL7DJrKJOdhNUXTZ3vQaJ+061vV6E1UAj/04cMCw1zMlX3b0wUkdL4dUxOMMR8UYG
         ltLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729668118; x=1730272918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JpW5l4cHfObYzl7+2svJ3Qk3MetE1pLsV3fZ39aook=;
        b=Yayv2axVMXF7Hti/dUmaoOkLGQSLJCcCwqe4cLI8vYYF+hy/4QcKjE9Oe2nisrgMki
         0NZAdHFqISEYe1VdEum2AtGMxSK2pTPKupb3+Sdgs1x+IrZ3y+X1Ebv4Kdm9sXIGRDJ5
         +CYwjBhOHvJgFysK11E1J9AUUbkwPAUxx69MjKcGsl1TTi5mH5RXsRYkThqRClu2FdQO
         G23TkTBDcjz46bEQK91/S4hDrI98A+CppOjMNg7Z0gkRwW7jYLVZ7z7ynMaC8PrreAPO
         S5MEYRjGCCEtFBNRvI5HSwETP4fyWJ5g1kwKk7tBYuA4uXR+perEH8uqBM9qY2cpw+ri
         aNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Tzc5GX6BT1R+lAKCrJfejs7gu4A1ISfuDxTzj3K2/uQAjqh7aBOIUqTlRb4uc0fut2lGEYNb@vger.kernel.org, AJvYcCVHZPeLqCYjOQP3TPAHjN9OabwvAX3yjw0oKVKu2moXis40NlOJnDLPFkrnWYjXjBM9h5RiCUJl4E1U@vger.kernel.org, AJvYcCX6z5FOaaugTphGsLZR7YFT+aYaojDTW8pgHI+Aq55Nqe4x7Ko5loOW+/gXSxSHaLGymikn7v5lXNcjT7v7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46+GZDEEvpBgdNr4qM/m7FYZ1zBvL/tbPxcGiK3fyjCEmTEkO
	AQKf1POiv1CISXxl8kK11IbSUe4nAT5n2YWY/CCChVEjx8ojpuFv
X-Google-Smtp-Source: AGHT+IFtrw0bTSDjOUHwOCouu0KJSU1+vA+nX8p6eBupMmcRvLXscxMVgLjlJ5OaperPpo2phGpacw==
X-Received: by 2002:a17:903:244a:b0:205:8763:6c2d with SMTP id d9443c01a7336-20fa9ea22f1mr30676555ad.9.1729668117790;
        Wed, 23 Oct 2024 00:21:57 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eeef535sm52795975ad.44.2024.10.23.00.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:21:57 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:21:36 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <amg64lxjjetkzo5bpi7icmsfgmt5e7jmu2z2h3duqy2jcloj7s@nma2hjk4so5b>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
 <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
 <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
 <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>
 <424erlm55tuorjvs2xgmanzpximvey22ufhzf3fli7trpimxih@st4yz53hpzzr>
 <66f35d1b-fd26-429b-bbf9-d03ed0c1edaf@lunn.ch>
 <zum7n3656qonk4sdfu76owfs4jk2mkjrzayd57uuoqeb6iiris@635pw3mqymqd>
 <d691a687-c0e2-48a9-bf76-d0a086aa7870@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d691a687-c0e2-48a9-bf76-d0a086aa7870@lunn.ch>

On Wed, Oct 23, 2024 at 03:08:52AM +0200, Andrew Lunn wrote:
> On Wed, Oct 23, 2024 at 08:41:36AM +0800, Inochi Amaoto wrote:
> > On Tue, Oct 22, 2024 at 03:51:08PM +0200, Andrew Lunn wrote:
> > > On Tue, Oct 22, 2024 at 06:21:49PM +0800, Inochi Amaoto wrote:
> > > > On Mon, Oct 21, 2024 at 03:27:18PM +0200, Andrew Lunn wrote:
> > > > > > It is related to the RGMII delay. On sg2044, when the phy 
> > > > > > sets rx-delay, the interal mac is not set the same delay, 
> > > > > > so this is needed to be set.
> > > > > 
> > > > > This is the wrong way to do it. Please look at how phy-mode should be
> > > > > used, the four different "rgmii" values. Nearly everybody gets this
> > > > > wrong, so there are plenty of emails from me in the netdev list about
> > > > > how it should be done.
> > > > > 
> > > > 
> > > > The phy-mode is alreay set to the "rgmii-id" and a rx delay is already
> > > > set (a default tx delay is set by the phy driver). In the scenario 
> > > > the extra bit is used to fix 2ns difference between the sampling clock
> > > > and data. It is more like an extra setting and the kernel can not handle
> > > > it by only setting the phy-mode.
> > > 
> > > This sounds wrong.
> > > 
> > > So in DT you have rgmii-id? You say the PHY is doing TX delay. So you
> > > pass PHY_INTERFACE_MODE_RGMII_TXID to the PHY? It is not clear from
> > > this patch, i don't see any code mentioning
> > > PHY_INTERFACE_MODE_RGMII_TXID. Could you point me at that code.
> > > 
> > > 	Andrew
> > 
> > The phy on the board I have is YT8531, The config code is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/motorcomm.c#n868
> 
> This PHY should be able to do rgmii-id, so there is no need for the
> MAC to add delays. We encourage that setup in linux, so all RGMII
> MAC/PHY pairs are the same, the PHY add the delays.
> 

Yes, this is what I have done at the beginning. At first I only
set up the phy setting and not set the config in the syscon. 
But I got a weird thing: the phy lookback test is timeout. 
Although the datasheet told it just adds a internal delay for 
the phy, I suspect sophgo does something more to set this delay.

Regards,
Inochi

