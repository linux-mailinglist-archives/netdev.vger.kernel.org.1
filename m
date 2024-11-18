Return-Path: <netdev+bounces-145901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9A9D147C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C6B283399
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D418EFDE;
	Mon, 18 Nov 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBWrcm9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A21E4AE;
	Mon, 18 Nov 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943909; cv=none; b=BoQsyWJcEovdqaRL8RueznQ10baIdG56Kzj03eHDiwQBq4vYkifLXhIrUW07JIeF4kHTWSmLDEpGlv3i/VbJwgqMy8i1EmWlTYf+VBm9tlwvT7dmj8pATksYpn5GQ7RivcJEksgfccYcTljOc7JGR9aNxwzuGThmY7GtF5yAuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943909; c=relaxed/simple;
	bh=58pF8/sIcd2FNvKZOrZfShXWmxtDqwnvs41vF1xsquU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1JHliLaK2rHurGZdvrrSkRfMpPgnpSS5dKER4Sz5I8DyqKdgOhabvCk4mcVOXzNnv+gNZ7k1QMJaVxP0NafkCOYFoYSnA6o5kwdTBwtEfPJUpubI9Do1c8MChBIWDuhq1eaiHNiBVGldvkJbXbIdIUt+kHScbOw6NINMohDhco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBWrcm9P; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa4b439c5e8so205638366b.2;
        Mon, 18 Nov 2024 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731943906; x=1732548706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw/1qGh5ohzLWgLgNM6CDpJXmjefLG/ujqJoYqDtUZs=;
        b=IBWrcm9P3RMrkZsNFQho1zqKyIu/XQcTy8qs9GzylqDnO1c7xGn9Ffw5f+zAQtI2Dz
         3iINODX4cFH29I6xEpU4ooynUZ8MLdGDOcxMYODhd6b2O9/tQwdp84BZHdv/1rcPSbWr
         +cpjdygnyzKM7BDAhBwlFeIkWZb3TB2E3BjKzmBtwiBsoWnWS2ywC5cKTxw+kSg7uNNS
         DAAocT+RPl+j9V67cKf9a3jkEMqgqsZjCnTevPtP+8J+c1Naym9rmPwz8sgovbWUgNwa
         fm/PNWB5DP5VG11EQMXY0hKYx498WqIhALDyHc7aTKu5lkL5X+UDMFbLelsnTT9eoMmO
         YyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943906; x=1732548706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw/1qGh5ohzLWgLgNM6CDpJXmjefLG/ujqJoYqDtUZs=;
        b=EYP13RqXM2u9Uf2f/bXlPTa6BfS/ru+nC1Qxe+tRBMnvJDO5fxnnMpazk0TyTP5Kdy
         UmCIYKAIkV5MmnzGxeZo+Szfe+Z1gCdWg60jJ0E6ZVYSi4Alb1fGGsal9iuZ03FLUclk
         hK6IPs6cCkBysx83RUsIRnHZ1VFx3cAW/RUUpZk/hor+nXGz9lfy9P5fPu+MKW866lVD
         3n8kjsXoYhKYaKTCMLhhjxlwCVnqrlFBz5UyeDJoAQbxpQiJraOzTv/YiZXM85ep4yZt
         lH0y2ZLpiqor7iqt4kSLJHMNRjx908DvvL5NoSHgs5g521USmWyC7R/AmNJcMPkJyqXe
         Fu+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9r69zsMYs15+oj0cT5Dziua8DG1VMKbeKkyX+tBQeoDhwlU+BW7Xnq/Ezd+uCTVudzsHumxqG@vger.kernel.org, AJvYcCX7+4+styeQ0AaIblcSQxu0R0BdgtJczY/ls3BspmOEGD2gQuneXKiZ+tGFswRJk4aaoambPNuukq7J4gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJC5IknhC/p80bifnCFP/ZI0gkTfJAXFziPjiDU+WXCM/avin
	AQTsUYH4BUBbknB4Pz8o6I+x2dEhWYNM+qH0lTRi/F2Fk4HwC4yrQto0g5ZuCR29gk9nNjXrfwl
	MY8WJLxMM7AFv+ty64GpY/lrEzuE=
X-Google-Smtp-Source: AGHT+IGsmZV1czLsmQeetU4aE8qdHXm8OOkvfWDhGcxZObWmiJSWEncxWC3eTrjbiF4kNcONb+frNm6vgyXskzjfXVo=
X-Received: by 2002:a17:907:96ab:b0:a9a:4e7d:b0a1 with SMTP id
 a640c23a62f3a-aa4835539b1mr1029351166b.49.1731943906272; Mon, 18 Nov 2024
 07:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113200001.3567479-1-bjohannesmeyer@gmail.com> <20241114193855.058f337f@kernel.org>
In-Reply-To: <20241114193855.058f337f@kernel.org>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Mon, 18 Nov 2024 08:31:35 -0700
Message-ID: <CAOZ5it3cgGB6D8jsFp2oRCY5DpO5hoomsi-OvP+55R2cfwkGgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] vmxnet3: Fix inconsistent DMA accesses
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andy King <acking@vmware.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raphael Isemann <teemperor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> But committing patch 1 just
> to completely revert it in patch 2 seems a little odd.

Indeed, this was a poor choice on my part. I suppose the correct way
to do this would be to submit them separately (as opposed to as a
series)? I.e.: (i) one patch to start adding the synchronization
operations (in case `adapter` should indeed be in a DMA region), and
(ii) a second patch to remove `adapter` from a DMA region? Based on
the feedback, I can submit a V2 patch for either (i) or (ii).

> Also trivial note, please checkpatch with --strict --max-line-length=3D80

Thanks for the feedback.

-Brian

On Thu, Nov 14, 2024 at 8:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Nov 2024 20:59:59 +0100 Brian Johannesmeyer wrote:
> > We found hundreds of inconsistent DMA accesses in the VMXNET3 driver. T=
his
> > patch series aims to fix them. (For a nice summary of the rules around
> > accessing streaming DMA --- which, if violated, result in inconsistent
> > accesses --- see Figure 4a of this paper [0]).
> >
> > The inconsistent accesses occur because the `adapter` object is mapped =
into
> > streaming DMA. However, when it is mapped into streaming DMA, it is the=
n
> > "owned" by the device. Hence, any access to `adapter` thereafter, if no=
t
> > preceded by a CPU-synchronization operation (e.g.,
> > `dma_sync_single_for_cpu()`), may cause unexpected hardware behaviors.
> >
> > This patch series consists of two patches:
> > - Patch 1 adds synchronization operations into `vmxnet3_probe_device()`=
, to
> >   mitigate the inconsistent accesses when `adapter` is initialized.
> > However, this unfortunately does not mitigate all inconsistent accesses=
 to
> > it, because `adapter` is accessed elsewhere in the driver without prope=
r
> > synchronization.
> > - Patch 2 removes `adapter` from streaming DMA, which entirely mitigate=
s
> >   the inconsistent accesses to it. It is not clear to me why `adapter` =
was
> > mapped into DMA in the first place (in [1]), because it seems that befo=
re
> > [1], it was not mapped into DMA. (However, I am not very familiar with =
the
> > VMXNET3 internals, so someone is welcome to correct me here). Alternati=
vely
> > --- if `adapter` should indeed remain mapped in DMA --- then
> > synchronization operations should be added throughout the driver code (=
as
> > Patch 1 begins to do).
>
> I guess we need to hear from vmxnet3 maintainers to know whether DMA
> mapping is necessary for this virt device. But committing patch 1 just
> to completely revert it in patch 2 seems a little odd.
>
> Also trivial note, please checkpatch with --strict --max-line-length=3D80
> --
> pw-bot: cr

