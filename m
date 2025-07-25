Return-Path: <netdev+bounces-210053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A3B11F9E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964D0AE1723
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19B1957FC;
	Fri, 25 Jul 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/6pi6zo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7612E36EC
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451610; cv=none; b=JQpfxhgzFIUtiZyG0IXeTBGDvjvG4cR0w79c6e4F16rV9xuVdeJ+6U3dVWPY5Bef9f1dbSa33/R5Oc+3z1LcKGanOKfFsV9NlXsBsLe/GmXIQQbXTXEuGbSdyRS5fEv7gugNLUQ2DrsPTx75Ivj14OGDVLrnaxorj/3sgLPe+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451610; c=relaxed/simple;
	bh=mSDg1GQamFsjMossvkdrmxraz/XzbhlY0Z87GkuJcGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr4rizM4djPXuMw7vU2DXOjU2FchR0pY5XQckiimIpnmCFX/c4PFJSnA0KSAdDFA7jeboqRObBeg2Zs/p+r5lM+DKSXyJm5qptxth0oXSI0Z59XDedOOJi5pYbDpE2uogIGlJbO/wxkWYJXM4B19cxhuuUY7H3FV1DFWrXhxxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/6pi6zo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso21309051cf.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753451608; x=1754056408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1hAqeYCy6aPtsdaD+a95FJh5xJrvRSfxYY035KZ700=;
        b=t/6pi6zoCsS8h5gpWMkrh+4YjYMsmFXKuyVUf1ekJ5wuV45hwhvcBs075vXjWoF1MA
         mseRhluBGxaCardzo4XhLcSytjwqzC4ZIL1LIMcg+/2biIHBqC08U5yCWzG634DA7ygL
         WybuPAY5/8DorpgnpObC0FZCJA2A0dJXtRs5m/kcIrtjMKlm/2UTO0k0aBrpuqldO5DO
         0U+0nKyn1yVEWOJt/Z1ifDXq9JMjRMzsqYFgkUVkIAhB0SnOXZxUADF5HPlz8Bd0OCc4
         kZf91b5cs/DGxuXGRHVEB/SPC32yOjoZ2waX8/j4XaA68sM1jUh1ZXPwmc5KoyUSGnnb
         hN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753451608; x=1754056408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1hAqeYCy6aPtsdaD+a95FJh5xJrvRSfxYY035KZ700=;
        b=JbKUwFRJC/b6fbiRakpJcgNbbxOqldFBUs1hkC3JS5yCdp/aXLODIx61PuEIx9y7Sc
         rzv4Bz+R8LfL6Bdb2I5dvlmhSKLeaNv63nZvLFS1Q4UO7AXFzgCYU+EBPxiC3tvoqY43
         wmclsOcFnmstdBKjixhev9RMCv8ADDtxb9g3UTzO452U5RMLquyLEhptLX+ETISsavQY
         SOkfCNrRNAwomRJxT6Y9M1eGles2C4R0YzeSLfegGjN1kIgumi2InAtKYqkDF2nbp1L/
         clZLN/fA7Hz9tyaZgRDf+c/hAhkVt65s5AdVApF1XsB/yTg7EARX8X6oji3Q1HGmEaSj
         eDOw==
X-Forwarded-Encrypted: i=1; AJvYcCWrrGa75uHy/4YQGgcQf7Q+O1JuQ3DUS+hij1pCpygt47GkXOxHusXlWfLtwoIVlIug9ZA0jMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+jQmvxs8t6pO2S1ehk1ijrTehhZ5K2joxOgSfvTgZub/jPsO
	1eeuWs8Ze2nXj7i1ipLf4v9sPSPLBGHC2xDT7IXM+VwaxyZrltEHJbQxdKhuqX0jMLuk2Rb4ujL
	TzU39yRG6Y3xhBeLxjoiDyWDAJdKBlU6ZwIYmF5GzIus6i65lroWAh1QMeFM=
X-Gm-Gg: ASbGncvs2aFJyFBI5pMC9lsJks//L8xpYv+oLS0s9clzjKvyK8MZETthrDUAH1Gk1EK
	VTU8qOpI0Hu69kyhihUhoWteTy33d+/hq3R2YKVamguLLb+AKnmOopU+x5mkGy+3NiOLWzgXTs8
	MltY3I/QzHneUDUoW7IdJCZd6PbEqUtFFeAfeA5ntBXzzGzgcMLDVutUhMJ86D9QR9hr6Ptxvaq
	Dg99B1HBsdAdJ2I/A==
X-Google-Smtp-Source: AGHT+IHOtPZYCcL27DWaCXqhxuZHZ+IobaaCtR9TWuGSz7vT8EhbM2oy7hS2Ze67n30F2CECD1rIf8wpevlL6Pbpo9o=
X-Received: by 2002:ac8:5804:0:b0:4ab:5d26:db8a with SMTP id
 d75a77b69052e-4ae8e878ec5mr23365041cf.18.1753451607204; Fri, 25 Jul 2025
 06:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725133311.143814-2-fourier.thomas@gmail.com>
In-Reply-To: <20250725133311.143814-2-fourier.thomas@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Jul 2025 06:53:16 -0700
X-Gm-Features: Ac12FXz9f_T46FZr6oWHnYPdE1FCnEu_6iCpQgTJrXvhchKkQWpnlpbZ97hSA3c
Message-ID: <CANn89iJW+4xLsTGU6LU4Y=amciL5Kni=wS1uTKy-wC8pCwNDGQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: nixge: Add missing check after DMA map
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Moritz Fischer <mdf@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 6:34=E2=80=AFAM Thomas Fourier <fourier.thomas@gmai=
l.com> wrote:
>
> The DMA map functions can fail and should be tested for errors.
>
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Inst=
ruments XGE netdev")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/ni/nixge.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/ni=
xge.c
> index 230d5ff99dd7..027e53023007 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -334,6 +334,10 @@ static int nixge_hw_dma_bd_init(struct net_device *n=
dev)
>                 phys =3D dma_map_single(ndev->dev.parent, skb->data,
>                                       NIXGE_MAX_JUMBO_FRAME_SIZE,
>                                       DMA_FROM_DEVICE);
> +               if (dma_mapping_error(ndev->dev.parent, phys)) {
> +                       dev_kfree_skb_any(skb);
> +                       goto out;
> +               }
>
>                 nixge_hw_dma_bd_set_phys(&priv->rx_bd_v[i], phys);
>
> @@ -645,8 +649,8 @@ static int nixge_recv(struct net_device *ndev, int bu=
dget)
>                                           NIXGE_MAX_JUMBO_FRAME_SIZE,
>                                           DMA_FROM_DEVICE);
>                 if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
> -                       /* FIXME: bail out and clean up */
> -                       netdev_err(ndev, "Failed to map ...\n");
> +                       dev_kfree_skb_any(new_skb);
> +                       return packets;

Note that this error (and the possible failed
netdev_alloc_skb_ip_align() at line 641) can leave the queue in a
frozen state,
because of a missing

nixge_dma_write_desc_reg(priv, XAXIDMA_RX_TDESC_OFFSET, tail_p);

Not sure if this driver is actively used...

