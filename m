Return-Path: <netdev+bounces-247480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E12CFB1F3
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42C64300E62B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DB324B27;
	Tue,  6 Jan 2026 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOvi6VBY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73C30B51A
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767735902; cv=none; b=uw0Ps9eefOdhsxnLjIyueXl4g3XJyFQGkgOysObD4Kr6Ral1IFJrdYl4vvHITn0rsSyfEkIl0TS+ZOymoswT6rL0HHsff3HqHwiXRp6gSdLyVAbXb3eYLDjOaxt2XnFikP5EIM4inP08EI4OMpzzmMKTgn1bhb8fuH2BCNCIM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767735902; c=relaxed/simple;
	bh=JttCpsSUeiclCS0amSNQoEaALqaunw0BGjw2O/ph5Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHeUusI/7XC09O/MgVhPxd5BkvDA2X852dQM5hLm4ZinXDiIGfL3VqAMYL19gYa9LnAt/czXHbepBs0wmMKU3rxhjsL7qDv/9WA5XwT1DCDi1taVIrbm3VHEPbMVOAtZ2wt7bdlY7iEM+qZLymjuqP28BIrBpwv7tKQsGkVKF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOvi6VBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B57CC2BC9E
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767735902;
	bh=JttCpsSUeiclCS0amSNQoEaALqaunw0BGjw2O/ph5Qo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dOvi6VBYNuCATAepaLqU1eErybfMwAvZncQAeneeK/QJYVEgP95Q6ApZEFND0Ytxd
	 K0beUQ7PVksZuOq8FvAXItri5X4Kq6/j0LpAHLyzOEBtHppod0/GrH+LNIFgbl6gmm
	 pw64g3olZWWkYeHqLJzmub9IAflpt/pt3hbQutRJusiJXZ1tD9OW75+2PFgVaBzEzB
	 DdBFRgANp3bKJ+k6IORg4s7g4NSN1OoQHV2VSeJBaAWDcohkys9FlxJcXKc28iV4qh
	 lYl0wv14Skb343IP40zLeiAh4iaknfV0EO/c79KW3h8X3yH0mCCKWOH92zWLoTLNAa
	 F39h3mRZVkw+A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79e7112398so237927566b.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 13:45:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKJf7z4OrS/s8uLzogpRTb0Y4Pml+vH3t+kOMZCWEDXF91gAGMKsyGATjwMk4mjLxBDBKZEJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1k4bsqI3ujr7TlSxCoTKgTlbYMFwMMQYIrwyVbWCnNZqMN9Ta
	xa27nQerFGD1bbODxUZT01uicADQeb4ny0nKn/JNtCTS80NGjmaLtpfWOfvQFmIP+ma5RXYdeF/
	FS5QS2ifch3/Q7MIL8ylnpwoDqPnkhA==
X-Google-Smtp-Source: AGHT+IEjrvbEDUapgFRPfSRLcyQnp2+3eYc5vauPrFRqRHPMdnl9KlBHcpoL794w7RR12SXJM+/lcy7IprrngoUzQQ8=
X-Received: by 2002:a17:907:7fa5:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b84453eb335mr40051766b.52.1767735900967; Tue, 06 Jan 2026
 13:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106143620.126212-1-Frank.Li@nxp.com>
In-Reply-To: <20260106143620.126212-1-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Jan 2026 15:44:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxKvrOWq6Y=nRzPz+W0HYGR1Egy8qcGnd_6XDFOCfcFQ@mail.gmail.com>
X-Gm-Features: AQt7F2rxYuRKfsW2A7MFdTtlHTPtCjOh90uCeuQyt55itPQ6SCq66xhFomktgUY
Message-ID: <CAL_JsqJxKvrOWq6Y=nRzPz+W0HYGR1Egy8qcGnd_6XDFOCfcFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: microchip: Make pinctrl
 'reset' optional
To: Frank Li <Frank.Li@nxp.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, 
	"maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	"open list:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	m.felsch@pengutronix.de, imx@lists.linux.dev, shawnguo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:36=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Commit e469b87e0fb0d ("dt-bindings: net: dsa: microchip: Add strap
> description to set SPI mode") required both 'default' and 'reset' pinctrl
> states for all compatible devices. However, this requirement should be on=
ly
> applicable to KSZ8463.
>
> Make the 'reset' pinctrl state optional for all other Microchip DSA
> devices while keeping it mandatory for KSZ8463.
>
> Fix below CHECK_DTBS warnings:
>   arch/arm64/boot/dts/freescale/imx8mp-skov-basic.dtb: switch@5f (microch=
ip,ksz9893): pinctrl-names: ['default'] is too short
>         from schema $id: http://devicetree.org/schemas/net/dsa/microchip,=
ksz.yaml#
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

