Return-Path: <netdev+bounces-66982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3077841A8D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 04:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DDF1C230AF
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 03:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E2376F6;
	Tue, 30 Jan 2024 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PrBSYoKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AA374CC
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585544; cv=none; b=Buq9V7KTIQtZHtDlAzoa3IE81Gm11hF8Atmj8D7zg4fph+tbqV/Pk5XmQKQPeusZCGiJu97Idgya65Arr2IeTKFetvU6/Eu02jaHf+9Vfc1EfUjO6fWdW4xDfpYZDfyYoAnoz5cZq2KRwis0wSemynav7XgwHWyr0sPwwF9osLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585544; c=relaxed/simple;
	bh=ELYmV9fmW0xc+1ZcDD0YMB3ZtknbgobJp7j2bqTa+U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URUgD49MiqYW13DO99yRegasICZaEOt8JSyXfVn8uUl4Yg/qtL3sEya6/1nthMNyLENN8fh7jZ/bzrzTzCvqXmbZhgNMRwmCiTZtqeLFGLtVCYTxNRhALcKR5+j0BQJ2BV/u73+EglOoI3MkDJ6v4iK1fK26AeJPVi19KTCoXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PrBSYoKc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51030ce36fbso3423648e87.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706585541; x=1707190341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVSWuVPedMZ0hCiYeV6t6vWEzmV0Yu6IxhjiX+iJPeQ=;
        b=PrBSYoKcl+2yXGVfHd9QXPj4LHFMHrXqGcqU6sb5a4ihQp+TV2fM+BCIuym/mXjN5B
         LN6ZnvtahpuPr4J0CqRMglpaMbsZ/bk0ZGCp3IEU2xpJ/hSvjaRdRIN92/ckf6Sp8Mn9
         L5Y5YXSl6Y/UhaINzAgNvl9NK5iECJjFqS7PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585541; x=1707190341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVSWuVPedMZ0hCiYeV6t6vWEzmV0Yu6IxhjiX+iJPeQ=;
        b=Otp6cxvtAHKLy5Mf+210bqTITohLyO/n5J/rWtJcueInmvknDiXLCxVWk665Gpht2O
         IE72Qqa3AHzypTMDWjsjz4neiH1BpLqa4hmyH31uf15rcCrQ7P8J4nUBogEY3MXkvMtd
         q14y1u9XYtGIaz+fAGlZ+JzwKg3htDkohAAmCAVgCpMbJgs46uvOeMw4OC2+NA9rB0nR
         jFowyuqvIfY9NFyZIcy40isCVWT6XOl1jlL6EQMNLVHcWICnHTwiUiJHeqJ/RPemSYzy
         bGR/lshyB6IzMyGFohm0VPaWLAtBV21NY50SiAwv3zYTE1CNm/oss1tRDvZt7mvqUqh7
         12TQ==
X-Gm-Message-State: AOJu0YwX49IXCu04MBAJXsE+A1XduDiERzx2B6+UyC3Z5pfakuJv4/Le
	fxn4IhvWPGxh/3qwUlk49H3o/WzBSsb0AaCXEOoQKeqEhLMlBgdQQzfUrYdsqmkRRovUuczLODw
	NuaLdCxXRcUizQXBw1lDPIqlmOsA8ZSqheqvIrXrTlnDQxGeMpw==
X-Google-Smtp-Source: AGHT+IHxJ9h0TpEGL+1arI5K15dK7ZMfTGGFT7sxI5crnwlEMm10GtDatZbLxi1ebhRtIB1BUsGi7EDALv4X9Wo6UoA=
X-Received: by 2002:a2e:8496:0:b0:2cf:34b4:63de with SMTP id
 b22-20020a2e8496000000b002cf34b463demr4704323ljh.35.1706585540108; Mon, 29
 Jan 2024 19:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126063500.2684087-1-wenst@chromium.org> <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org> <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
 <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org>
In-Reply-To: <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 30 Jan 2024 11:32:09 +0800
Message-ID: <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:34=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
>
> >>> +allOf:
> >>> +  - $ref: bluetooth-controller.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - mediatek,mt7921s-bluetooth
> >>
> >> Can it be also WiFi on separate bus? How many device nodes do you need
> >> for this device?
> >
> > For the "S" variant, WiFi is also on SDIO. For the other two variants,
> > "U" and "E", WiFi goes over USB and PCIe respectively. On both those
> > variants, Bluetooth can either go over USB or UART. That is what I
> > gathered from the pinouts. There are a dozen GPIO pins which don't
> > have detailed descriptions though. If you want a comprehensive
> > binding of the whole chip and all its variants, I suggest we ask
> > MediaTek to provide it instead. My goal with the binding is to document
> > existing usage and allow me to upstream new device trees.
> >
> > For now we only need the Bluetooth node. The WiFi part is perfectly
> > detectable, and the driver doesn't seem to need the WiFi reset pin.
> > The Bluetooth driver only uses its reset pin to reset a hung controller=
.
>
> Then suffix "bluetooth" seems redundant.

I think keeping the suffix makes more sense though. The chip is a two
function piece, and this only targets one of the functions. Also, the
compatible string is already used in an existing driver [1] and
soon-to-be in-tree device tree [2].


ChenYu

[1] https://elixir.bootlin.com/linux/latest/source/drivers/bluetooth/btmtks=
dio.c#L1414
[2] https://elixir.bootlin.com/linux/v6.8-rc1/source/arch/arm64/boot/dts/me=
diatek/mt8183-kukui-jacuzzi-pico6.dts#L86

