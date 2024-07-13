Return-Path: <netdev+bounces-111265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA293073E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7277C282407
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01848130485;
	Sat, 13 Jul 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNA03MWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441101BF54
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720901470; cv=none; b=YlVOA3J5Buvu/z0im9QjQfHTuJ4nlm/0JlYMgkdGFRebYDSnmoif97UGkCZQ2gfLVaW5VafL1ehkBzfus4CqWP83emaHbsnPr4CshR2oaN0jjDRk7N48Bub12y1oJp4BnxwfWZ14lxMXNYBTK5zlBcgEEG2SbhYUb5IKsEhyh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720901470; c=relaxed/simple;
	bh=vVWevBuG8qBT9ww7eHfRE+wPCnRFdsZS6+uQD4PnJwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHnWUVPBnhJ17kWPJKZKnjgbY/lqbPNwSsoSeMR2Wf6DhWDEGhjiuQbevZ1wNe9iYgdo+MlS5w11cSnVw/ckrxDo6+iJF/HmrSu+UOzJqR8zaG/q1X9reyWIQoONzOUvCNtoeWGbNk1JiYyHgcJCF9zlKiYJ19b7wgdzRLxjExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNA03MWa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367818349a0so1746565f8f.1
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720901467; x=1721506267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM25Qgx/ayjWmRKdRZYdvX/h31K9G6S9D27+fll+EGw=;
        b=TNA03MWa8ADRWHnPPM3bm5FaMSuraJV3VaylNaV5fEwnJkJPZYPGAFFzgLbknKa009
         Gmcx6wEJUg9Rx3EVZpmTfnm9OGFHCf1YwDfP6CY1D54hZGX6LPn9xd9q9Zf9Q0KwggMq
         6ZzPomvJF0e/X40pQSr0LZ1cSOtPpomGBI+OiRB8vYMWEDl/b2kZF4Tl0P/h2xC50vgo
         jOG194Z5VWBpCWQmwLZcGgX9BR61XySfZdp9F6afAhq8DvN/twmjkWond/ogqr9AlbQo
         IPRUN0fRzOfs10v7wNsRrkTUB2SYzJ6sMnzG/6Y4DT+Dq1J8oqgJ2qEYwOT+MCXHaFC2
         88qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720901467; x=1721506267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM25Qgx/ayjWmRKdRZYdvX/h31K9G6S9D27+fll+EGw=;
        b=u8CI2/yPpBtDaD0a+yeqf0+L8tV5HQZHKIBTeIjVTawiPjmuCkXKr19RLnA/54rRO7
         RvMw+XzMgKtj9Xbqfita0efuaAGwHD3T9ldVNsiiVG2IiVpi1MLsmoQ7CloP1zp7VhDr
         DGD6PjUuoNwnqVaR4lOhjqo3h0im/BMaV82nOjJhBeGmGlrtyLk/zK6zgitGI/sBb1C5
         w/xTKlgijfLKP9RxzMR2zqI56uC+pt0ehEhxp4Ag42B3jeGxwyFCg1Ru1mqCvgK0Twfj
         y281pN7QjHxaCPUJA7pj6w0rniARFDgP6XRGX+JBjBio5Gg0QllzAGrJbSyQfCpD3ojW
         1zzg==
X-Gm-Message-State: AOJu0YwjWpG4ymDfeVX4Ul/NVK9Yak5j6FI3HE/9jL+yK8tZlG+WzsDK
	KKz6V7fXv4SF/PDKMpoTTb1qMq7fRrgRSg8F3iL1jrVTPQGTsMobX+5ryqvz97234/Ak3sWrbbs
	vSgDHBpYFQ5bENeaz9r41360IS4g=
X-Google-Smtp-Source: AGHT+IEHEINlTsyQ/rGqtk8hNY4SBKNhdmK8CNJA+q1xI9GHx9LQisUVjsz4oI9vouKZgj5350mMjgWw48VJzNCE/ag=
X-Received: by 2002:adf:f1c5:0:b0:367:f0d6:24e8 with SMTP id
 ffacd0b85a97d-367f0d62728mr5629654f8f.48.1720901467417; Sat, 13 Jul 2024
 13:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
 <172079936012.1778861.4670986685222676467.stgit@ahduyck-xeon-server.home.arpa>
 <24ac80b6-ee09-4aee-b9f7-162a3377baa3@lunn.ch>
In-Reply-To: <24ac80b6-ee09-4aee-b9f7-162a3377baa3@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 13 Jul 2024 13:10:31 -0700
Message-ID: <CAKgT0UcMsTFSMdz8h0TttyCn1LmPORX7acGyct+uQGtO1C_9EQ@mail.gmail.com>
Subject: Re: [net-next PATCH v5 03/15] eth: fbnic: Allocate core device
 specific structures and devlink interface
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 11:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > +int fbnic_alloc_irqs(struct fbnic_dev *fbd)
> > +{
> > +     unsigned int wanted_irqs =3D FBNIC_NON_NAPI_VECTORS;
> > +     struct pci_dev *pdev =3D to_pci_dev(fbd->dev);
> > +     int num_irqs;
> > +
> > +     wanted_irqs +=3D 1;
> > +     num_irqs =3D pci_alloc_irq_vectors(pdev, FBNIC_NON_NAPI_VECTORS +=
 1,
> > +                                      wanted_irqs, PCI_IRQ_MSIX);
>
> nit picking, but this is a bit odd. Why not:
>
> > +     unsigned int wanted_irqs =3D FBNIC_NON_NAPI_VECTORS + 1;
> > +     num_irqs =3D pci_alloc_irq_vectors(pdev, wanted_irqs,
> > +                                      wanted_irqs, PCI_IRQ_MSIX);

The the min and max diverge once we add NAPI vectors to the equation.
For now it is wanted_irqs +=3D 1 to avoid an issue with wanted_irqs/max
being less than (NON_NAPI_VECTORS + 1)/min.

The final format after patch 7 is:
        wanted_irqs +=3D min_t(unsigned int, num_online_cpus(), FBNIC_MAX_R=
XQS);
        num_irqs =3D pci_alloc_irq_vectors(pdev, FBNIC_NON_NAPI_VECTORS + 1=
,
                                         wanted_irqs, PCI_IRQ_MSIX);

> > +     if (num_irqs < 0) {
> > +             dev_err(fbd->dev, "Failed to allocate MSI-X entries\n");
> > +             return num_irqs;
> > +     }
> > +
> > +     if (num_irqs < wanted_irqs)
> > +             dev_warn(fbd->dev, "Allocated %d IRQs, expected %d\n",
> > +                      num_irqs, wanted_irqs);
>
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/msi/api.c#L206
>
>  * Return: number of allocated vectors (which might be smaller than
>  * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
>  * available, other errnos otherwise.
>
> So i don't think this is possible.
>
>         Andrew

I agree it isn't with the current state. However after adding patch 7
it is definitely possible. This is basically just enabling support for
the NAPI interrupt vectors that will be introduced in patch 7.

