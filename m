Return-Path: <netdev+bounces-92919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433248B959E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747761C211BD
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135724B5B;
	Thu,  2 May 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4kmKZzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10EC21106
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636300; cv=none; b=cJtkR+WxguHFgRNTBkkJrvRay+k45/JNgCgttETKGtxEsnLb8KhnIrBIpoyFkl6zvDGGNsZ93spQ28udARxG1HxDDdRl69ASYc4ZKCCgR6B7G+OTQQtk7xl8+OyoavTDqsr+RffUKPxCTmiFD9VHTX2d2x+MROlJyHly8KB5YeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636300; c=relaxed/simple;
	bh=kYoS0DMOZ9opD4qUEZZ81bljlubz2EYYFhlTXUUBuBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY/bf1ORr1esF37ma33JmdvWjKvsKJlWM55a7ODpGsc+ZulLVQWfADN92Cua2p2Wjk0se7V7uMd199xT8CGwDsukigi2aBm+RqxMWELFRdwpL0jO/Hxj3oghfRWGDjHiprGA+J660naelqCkfy30ezocPcaRKxO0SHDbnG9xnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O4kmKZzR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d3a470d5so9516865e87.3
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714636296; x=1715241096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juAuSH1JPhY7PWUJ70Ld08vmAUyCp8zbapAQIba/lj4=;
        b=O4kmKZzR8W/uAJ8Z6XHT1oeyyWTlxcDK34bqXY55c4d/mGW0oMTgyfyj2PjlTnVJbt
         y9ALVA7H0rKFaJjtF1Ip9N1+GfPUxwk/loFEWbCpv1mO1F6QDrtQ70BqOYPQvFVmy0om
         rGs8tjRGTfszA35ZYV7Piz7seQGv5Af7Y1Yxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636296; x=1715241096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juAuSH1JPhY7PWUJ70Ld08vmAUyCp8zbapAQIba/lj4=;
        b=xC9MQwIKXR5MncBdDkYiExPF8d6UIfqnW81P3Hh3diaC9g5XVSd3sehRZvKvNyxlak
         qe7hN2vQyNK7phaLYFizuDbAJpLbjjT6VFJTpxtnjx06j/VJxYb1PsKItZKApCqJ8KNA
         TSDQim5BqM+aBzcGVcF3bKKb4RtYmwwn9yDs8AN16qUKz8hDvcvBtOBc2RbI8M3I9PTy
         pkoJjG2SlP3I6Rf7o7gUbEr3mpkQDe3ILqKwM9udEhAzdVTtEHCbd7Za4UCx513CxSQU
         UAY+lEdSojYcK4pSqEIwM4kJDYE/AsqQcKrZyfbq3usHV6cPoBkVZk42JQuo4+c4ppJs
         i8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW7JTg3xZfc6i8+/UPP4LfwI/Nwq/30PJ4oKzIKU/Ux/ZguSWuLeQazzRBSAhb6aB8CEQ7QLihSlhGZGxXFF4hjVMoIfmvu
X-Gm-Message-State: AOJu0YxRwA0pPI4EA0lQGnoijkGnDkatTQn0omyf2QxhiEArn0T8YDIx
	TPIko+XFh4DiYEjDwWfFL5Y+yfKg+5WSemP/+T5dZ5NcoBVMZIPAEC7JeNCm7j1jxln5xVMjUpD
	gN4iNaGsiyB+3Lyb8TYsmetD+PGmHmOqcgW92
X-Google-Smtp-Source: AGHT+IEAVYn1Zg5pB/+HWCfbuXWxOWUqPfY3srDAkAXrE3zW+4aKcPJ8YB092/ynCkhEGaNCe+bioePdFycOCNiVjR0=
X-Received: by 2002:a05:6512:3108:b0:51e:12e2:2a1b with SMTP id
 n8-20020a056512310800b0051e12e22a1bmr714499lfb.41.1714636295807; Thu, 02 May
 2024 00:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412073046.1192744-1-wenst@chromium.org> <20240412073046.1192744-2-wenst@chromium.org>
 <171322232789.252337.16326980700188367647.robh@kernel.org>
In-Reply-To: <171322232789.252337.16326980700188367647.robh@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 2 May 2024 15:51:24 +0800
Message-ID: <CAGXv+5GroxzyUSQZNW-r9xt6Sgy+EGv3+08Htbb_ZcSRvaBR0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:05=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
> On Fri, 12 Apr 2024 15:30:42 +0800, Chen-Yu Tsai wrote:
> > The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> > SDIO. WiFi and Bluetooth are separate SDIO functions within the chip.
> > While the Bluetooth SDIO function is fully discoverable, the chip has
> > a pin that can reset just the Bluetooth core, as opposed to the full
> > chip. This should be described in the device tree.
> >
> > Add a device tree binding for the Bluetooth SDIO function of the MT7921=
S
> > specifically to document the reset line. This binding is based on the M=
MC
> > controller binding, which specifies one device node per SDIO function.
> >
> > Cc: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Expand description and commit message to clearly state that WiFi and
> >   Bluetooth are separate SDIO functions, and that each function should
> >   be a separate device node, as specified by the MMC binding.
> > - Change 'additionalProperties' to 'unevaluatedProperties'
> > - Add missing separating new line
> > - s/ot/to/
> >
> > Angelo's reviewed-by was not picked up due to the above changes.
> >
> > Changes since v1:
> > - Reworded descriptions
> > - Moved binding maintainer section before description
> > - Added missing reference to bluetooth-controller.yaml
> > - Added missing GPIO header to example
> > ---
> >  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Luiz, could you pick up this patch?

The other one is already merged in the MediaTek tree.


Thanks!
ChenYu

