Return-Path: <netdev+bounces-211964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB8B1CBEF
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 20:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16173A7C3E
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A9299928;
	Wed,  6 Aug 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLuBDr8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093812E36E7
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505053; cv=none; b=YdhijVEyNougV/DttSXLf/NF9oc34hn+M6R3iJPuzv8d9g2QuyMUeuI+vHarm1fj+j/3hoUOHcxy1MAkrNAbTmwZGUdXpl6m8rp/w7ypgpZ68XkRd5MDIn/BQECA/rnNfWnfnpkZWEiiJEloKh1uL5ok4AICMorKwsL8kmJNTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505053; c=relaxed/simple;
	bh=vLj+fdJb2Vks5utREQNrEigpGF6KFgjJSUgqIR6F6UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbbDET5vH2UdbG0IxQruMGAwGg3BcgQ+s2Nib4NMX+DfgtWHnJ4u47jL6r4f8LSMt40Fl3IgesJQW8hvSq+WboVGnHYawz3AD7xkEm9Cq6TJrgqUBNgVFZD0VaglgfaD0N4mPmIQ2hmcwUDN8W348AbogEVLnTi27uoAA74OUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLuBDr8R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b7bf0a8d5so922e87.0
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754505050; x=1755109850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TDOublo3Q2tG40X6vbYcBf3dOqybzUDofJqFWP7aQk=;
        b=bLuBDr8R3DPgp9/CRCw6rrvYVEgbPFVcuniJBKND9WjsSe1zGB5Qr2mHPBfRI0Nunp
         Sb4/FzlMyFzB/8PfUAiIot5J7QxNgVCIbgDEOFK/0O4FrXHq9Vve6oR0riPJlP9HK6Nd
         N8URHZYkn3Z+1lF4JjmXOOU5gQg4EQO4kcutvKigOzIzx08di4hHXC663pP84hWhmUip
         BKktcRQmulS1pjpSJW3AvkU2XIgKnAUrNas4UgCwyzAEayP2MOrnLAHDANfTwdgc9bX+
         5ZQ1fXlJlfPiyolSUjnM2cBCLtz9RyI9i2U0tkYyDS5fpvakwxusKGrywlBsMOdj9Efj
         lSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505050; x=1755109850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TDOublo3Q2tG40X6vbYcBf3dOqybzUDofJqFWP7aQk=;
        b=cPcFW5T0R4GatvBbfTvAI/lFbibX62DJnh1hHtaD89o7ADq+mqUOZI3424WqBaL427
         zM7Dw6PXuB69G5lh6Gtrj/Suk5b3pJUfapAljeyvYoWJGPCdfzEMJw1kjEG8IFrSXBed
         xCotZAZ8UhkppigPH2M8V+6AzMm445WQoWqz2EQVHCfJkFsINUpuOhVKNQWdpXg/RXpf
         FoAT+Y3E5V3ITBNW9l0fCxFyPwvPEEq5HBIn/JUrepUdy3qT80d88Gxr5ejE2b9iVvz0
         raVnCk9XK7wOSDDmuD3GxwdM0zSQAFpyMhXyhOCyKR+oi3oDstDwKuEI4LCedZDX/T86
         NCSg==
X-Forwarded-Encrypted: i=1; AJvYcCWMCyTaxW+Mm2leIc66fs1+5Wig8X/wrxcZT4nx3iFpqRPJ87s+iQ7tA+5gt3kP2JAfJMNs3bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBX8ukJHAsU49loWD8fU914fPzZrAftLJUaWHxuhH+PNN+gZs
	CeW7XA9kwzXx8oDtxm8p85EpHywM/EO6q3/k0b7AJt8K8o2+U7sEBTUazqM9Nx16W2rsrrd2OTi
	C7N1zuOFY1xZrMKXnN0o2QhNcAfz20iMu9a6EZDkZ
X-Gm-Gg: ASbGncuEb75ReMydfap3jTvlvs96zF9gR6sLbHQqCjdC0LeXwF7Qt3IpHlBk+Enlcu1
	/gw/JuoWntDc3Zw8qt4DqaPLgy7gz/KCVFEh+5z1Objaw8+Q9cBidbJZTjIxXvNDXjQCAFvA2xM
	F6NXrhR+VMyc//rZdbL34iG5MxZGTPWqGTGfq33haQQxXxGbbziekkoHpQzOICyGPiAsP9WBaX2
	g95uqHnUS/l+cHkvty0oE8Du5GMGALevlLUYBrQKhp7nvH6
X-Google-Smtp-Source: AGHT+IGt/wOJpNx7GnnwYBOLWPcP3IZ20CYAR4HnNGLoquJY9uECaHULv4YoLWdZT3k/01JfdD6rDnK0mvdb6p8RQV0=
X-Received: by 2002:a05:6512:6406:b0:55a:2d72:de56 with SMTP id
 2adb3069b0e04-55cb6ee8ebamr13453e87.5.1754505049986; Wed, 06 Aug 2025
 11:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <ca874424e226417fa174ac015ee62cc0e3092400.1753694914.git.asml.silence@gmail.com>
 <20250801171009.6789bf74@kernel.org> <11caecf8-5b81-49c7-8b73-847033151d51@gmail.com>
 <CAHS8izNc4oAX2n3Uj=rMu_=c2DZNY6L_YNWk24uOp2OgvDom_Q@mail.gmail.com> <20250806111108.33125aa2@kernel.org>
In-Reply-To: <20250806111108.33125aa2@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Aug 2025 11:30:38 -0700
X-Gm-Features: Ac12FXxs3PsW0TDpaFvxbsuRlfuu8IOZMcSAN6tdJGrWWtI1P2KBlk8RG97WhOk
Message-ID: <CAHS8izM-JrPV7R4wk7WnO-Zskb=7gj+HtewoW91cEtsQP1E5rw@mail.gmail.com>
Subject: Re: [RFC v1 21/22] net: parametrise mp open with a queue config
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 6 Aug 2025 09:48:56 -0700 Mina Almasry wrote:
> > iouring zcrx and devmem can configure netdev_rx_queue->rx_buf_len in
> > addition to netdev_rx_queue->mp_params in this scenario.
>
> Did you not read my message or are you disagreeing that the setting
> should be separate and form a hierarchy?

Sorry, I was disagreeing. The flow above seems complicated. I'm
probably missing something that requires this complication. I was
suggesting an approach I find more straightforward. Something like:

```
  nedev_config =3D get_driver_defaults()
  qcfg =3D get_driver_defaults()

  for each setting:
    if qcfg[i].X is set:
       use qcfg[i].X
    else
      use netdev_config.X
```

APIs that set netdev-global attributes could set netdev_config.X. APIs
that set per-queue attributes would set qcfg[i].X (after validating
that the driver supports setting this param on a queue granularity).

With this flow we don't need to duplicate each attribute like
rx-buf-len in 3 different places and have a delicate hierarchy of
serving the config. And we treat mp like any other 'X'. It's just a
setting that exists per-queue but not per netdev.

Although I don't feel strongly here. If you feel the duplication is
warranted please do go ahead1 :-D

--=20
Thanks,
Mina

