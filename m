Return-Path: <netdev+bounces-220319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8378B45666
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE105A4D15
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEEB343D92;
	Fri,  5 Sep 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wv1ats1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262632F74D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072005; cv=none; b=tCChWRt0e2prDu1ATZpSqqpvpqD03T0xPOboe6j9lKZ/15ChM33mIocrUBcxwLgAucRh4eqLrnpq+Lk7SdzDoakK7NsGohhmEtZN+yRBtxtwG8b9MDmymuS6CxrnAvRvwYP1z9QBAVuYqdFcv4iCnWHb2FDBaQZbdAcMWMYtILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072005; c=relaxed/simple;
	bh=o3hildMwaW8SKO7ju4TnjzbgldI5VhKTu/M3PBEf9Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnK7vsB4AYcut3Budea966GqpTS5G8a1oxAujBLbtWgQKcMn4J3cYLnD2AoR5lLUbLPZGmdHKR4Hmd7XN5HQX0h2P4ZMxHsO2LcUftncZ1niSWCRyP+ACkuO5PfoYj/EAvS6MEnF+G3BmMtxADYJLvld5EE3jB4UZMSJjc2TUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wv1ats1l; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-336d3e4df3eso18035121fa.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757072001; x=1757676801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e737NFCnB1pAiZwFeuIFUAdoH1qix+jNDtR6tlkeuzc=;
        b=Wv1ats1lENeDFeCHltS6z4eXYjp2PkHp41U/KSjwkprIJpiwUA2iVdzBaZiRrx1Mt0
         qHGzczd2Z5jSluwCy8P8ACWB3Gle0ScrGvwq4D87K+DQ+Kn1EKuy9V/NtvOQhoVvhDw1
         VlhaCRenYJr1p6TqCwmNzarskvRPWlEJDa2Nj8Rx+vO3RPTFL8o/Q46mAI6+DAl6RbDn
         ZYZKDb0HjPYXY9TG0yQXthJbEdx7DvqMucAOcim7XURySnkfmfW2beuJwk8vwC9AIaRY
         bPmuFP2vDrK4ShsfmwWPEdFTsf1mqOJIf3RdGn/j4v4G0Gq7NWGy2otXfxbf4BukM+3s
         cpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757072001; x=1757676801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e737NFCnB1pAiZwFeuIFUAdoH1qix+jNDtR6tlkeuzc=;
        b=tLtW2TLG9X8qZxJloSPiO326dFhz8jJL+NBLZjW4sXHcbMAc/TPHuZ5DFMaeF3okEz
         6NE09ihtPDVk9IL9P65Y3xCHqWRSLZeRcc+QNfja4VhEPl+f32eHkh7m5zonPT6HoNJO
         JCRiWhq3+d0jxlUwqUhzm9J/mDfW6ZpMHsfSwW2Ke9xmwhKBsF4RLdEv3qqOD/coJrVN
         jgWBFzH1akD7Cmxe165LMbD0py4p/2q6Rr/bbjwp0b8l7drGjGevPDA1+KaEYrCux9rN
         bwyE3dT5kIlf1fxde/WiO1T2zQnhI73dR0gfFxvF4uXwchzqvWEbFiFORU09SeHpLblq
         7yxA==
X-Forwarded-Encrypted: i=1; AJvYcCUWelCqtvl8J10kBPPXrz6bzUUh3Jgk9bHRsxUtDsqtl4ITm2sMTWohjLNN5JEUB7VC+lX0P0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEISjaojmdv/GGSJVudRwK6oIO7zI6cKyr4i0f60lI4dv4ia/G
	psSxa5htVW55h4xeg4nrQ/HZswMAN6uvkeATLMslDC2oyc+D+lhJYA8pOJp76luhJ8WlEytwSAM
	NbLX5CmVzcYiLZTbvULib5kXGYzS+InFInB4Dgi8eKg==
X-Gm-Gg: ASbGncvivfEDd6ouPFXsMtebOwoIQOjR1uOVR1Q4uQrn7v36l3P0ccfZ24d+3DJOnzP
	ZNxqe+2+UqS74B7j+8FJnSI4uGSzWfErKY+tcAZHqjOtNL6r+CxV3YX/H6GUBrR2uvlCtOOkTkW
	PaoJv+KWiaRq7c6h18CMXfdXKmVEcAaaFDA19Z276RYKSWREuPPChqtlfIdUgEcdvYdWgURsAlg
	+pj+Hsr9vKZNx076w==
X-Google-Smtp-Source: AGHT+IGSWO4nCHB8o/6t/y6RH8BOysPzoQ6jiv8gZqcTwwokf+Kq7hYmaaHYY9kCJZ1mu3fJ8bEoY6l6Nt8aDc5ponQ=
X-Received: by 2002:a2e:a482:0:b0:336:7c7c:5ba5 with SMTP id
 38308e7fff4ca-336cad21f17mr50388961fa.23.1757072001159; Fri, 05 Sep 2025
 04:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171302.324142-1-ariel.dalessandro@collabora.com>
 <20250820171302.324142-14-ariel.dalessandro@collabora.com>
 <CACRpkdbpKqKyebADj0xPFq3g0biPh-vm4d6C3sd8r0URyfyYRg@mail.gmail.com> <caguo7ud4dapb4yupeq2x4ocwoh4dt5nedwjsyuqsaratugcgz@ozajhsqwfzq6>
In-Reply-To: <caguo7ud4dapb4yupeq2x4ocwoh4dt5nedwjsyuqsaratugcgz@ozajhsqwfzq6>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Sep 2025 13:33:09 +0200
X-Gm-Features: Ac12FXx6o0aglHH6TQGfVH200HSX_9WYooYS5LFefZX_Ln3xQz4XYXPyVN0c3dY
Message-ID: <CACRpkdZRHQ6vuchN8x8d0uPCVMPPHOdBVWiUhzFJNs2paHGbYw@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] dt-bindings: input/touchscreen: Convert MELFAS
 MIP4 Touchscreen to YAML
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, airlied@gmail.com, 
	amergnat@baylibre.com, andrew+netdev@lunn.ch, andrew-ct.chen@mediatek.com, 
	angelogioacchino.delregno@collabora.com, broonie@kernel.org, 
	chunkuang.hu@kernel.org, ck.hu@mediatek.com, conor+dt@kernel.org, 
	davem@davemloft.net, edumazet@google.com, flora.fu@mediatek.com, 
	houlong.wei@mediatek.com, jeesw@melfas.com, jmassot@collabora.com, 
	kernel@collabora.com, krzk+dt@kernel.org, kuba@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, lgirdwood@gmail.com, 
	louisalexis.eyraud@collabora.com, maarten.lankhorst@linux.intel.com, 
	matthias.bgg@gmail.com, mchehab@kernel.org, minghsiu.tsai@mediatek.com, 
	mripard@kernel.org, p.zabel@pengutronix.de, pabeni@redhat.com, 
	robh@kernel.org, sean.wang@kernel.org, simona@ffwll.ch, 
	support.opensource@diasemi.com, tiffany.lin@mediatek.com, tzimmermann@suse.de, 
	yunfei.dong@mediatek.com, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:02=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Aug 21, 2025 at 01:56:24PM +0200, Linus Walleij wrote:
> > Hi Ariel,
> >
> > thanks for your patch!
> >
> > On Wed, Aug 20, 2025 at 7:17=E2=80=AFPM Ariel D'Alessandro
> > <ariel.dalessandro@collabora.com> wrote:
> >
> > > +  ce-gpios:
> > > +    description: GPIO connected to the CE (chip enable) pin of the c=
hip
> > > +    maxItems: 1
> >
> > Mention that this should always have the flag GPIO_ACTIVE_HIGH
> > as this is required by the hardware.
> >
> > Unfortunately we have no YAML syntax for enforcing flags :/
>
> Theoretically there can be an inverter on the line, so from the AP point
> of view the line is active low while from the peripheral POV the pin is
> active high...

Yes, I think someone even proposed adding inverters to the
device tree and was nixed.

It's a matter of phrasing I would say:

"Mention that this should nominally have the flag GPIO_ACTIVE_HIGH
as this is required by the hardware."

s/always/nominally/g

Yours,
Linus Walleij

