Return-Path: <netdev+bounces-76912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5600886F631
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F211F2306E
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816E6BB46;
	Sun,  3 Mar 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yhOjDkKu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785C41A80;
	Sun,  3 Mar 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484459; cv=none; b=A5iSX7rUu63T/CTQt5XJwsVPrDbZU5Bfhm0m1OX3hUYl2At9N7dSJIOg8VAte4dqsJKFgdfvJA+mBoT2bYqoBYiBPOd2PLCt+ahy0lNzidRKdUAeHZkwwgO+gJDawQvJTkGDRIvGYSot6vEw1acL24eBl/Os4HwR+c2mPz4tXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484459; c=relaxed/simple;
	bh=OPL1aIQTuGKgwQhRKtlPzp2Ss/iXbgK7g9IxNTuNO5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFnAsNuTij3Or9uoX8Yr55m1s+qXdz/zV9E2+Ec8bG3zeMAKdAFGduxqVwleT6srO1b2/6O+IT1yqi9olfrzZIu2vrKrYbNIwg/S4WldvQKyaW2Decnz2HAp8cmfy5zyyFXohtCmjc9sQ4vGFOho6JMc1m62RjDz1eqChgQPbTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yhOjDkKu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uOF+7FX2GYrjfEFD+K8IzTHJDjYcWidj50Q1BAozO0I=; b=yhOjDkKuzg82ykFIHZ43wKvG0G
	7Ab6m39xlYjSJW5j9TqtUpFHLZUCRYG3308rRjomQ4hd/lfBjPgQlF5F6BAHBhBVDQOaAJRSoxK3+
	AxJgIPvPxRgdRba9R+eDhMCBJpORc6ymCY03C29NU9/pwnU/gKUKRGNcHveOuvKq3tYc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgozk-009F1k-VU; Sun, 03 Mar 2024 17:47:24 +0100
Date: Sun, 3 Mar 2024 17:47:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <d29b171b-c03a-44db-8e0d-15f9bd35c4b5@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <ZePicFOrsr5wTE_n@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZePicFOrsr5wTE_n@makrotopia.org>

> > +/* u32 (DWORD) component macros */
> > +#define LOWORD(d) ((u16)(u32)(d))
> > +#define HIWORD(d) ((u16)(((u32)(d)) >> 16))
> 
> You could use the existing macros in wordpart.h instead.

I was also asking myself the question, is there a standard set of
macros for this.

But

~/linux$ find . -name word*.h
./tools/testing/selftests/powerpc/primitives/word-at-a-time.h
./include/asm-generic/word-at-a-time.h
./arch/arm64/include/asm/word-at-a-time.h
./arch/powerpc/include/asm/word-at-a-time.h
./arch/s390/include/asm/word-at-a-time.h
./arch/xtensa/include/generated/asm/word-at-a-time.h
./arch/riscv/include/asm/word-at-a-time.h
./arch/arc/include/generated/asm/word-at-a-time.h
./arch/arm/include/asm/word-at-a-time.h
./arch/sh/include/asm/word-at-a-time.h
./arch/alpha/include/asm/word-at-a-time.h
./arch/x86/include/asm/word-at-a-time.h

No wordpart.h

	Andrew

