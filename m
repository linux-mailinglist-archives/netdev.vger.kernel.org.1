Return-Path: <netdev+bounces-114493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69E942B98
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED7F1C20BDB
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826621A8C14;
	Wed, 31 Jul 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaU/SYwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1E18DF88;
	Wed, 31 Jul 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420395; cv=none; b=WwGHC373G6O/mxiSgugvB1pZe0RImd411AeozCJuIfMyX+czUDbrwgqLUI0YddspWb8bLfxc9e2h9DARbglHcsRm/mEAv/6Y+GKFbsbsSio3SdYOBG31IdCdOOZVM4Iau1YOUVoR7susetOVHBlgw5T5N64w0/smRrG7FaYbun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420395; c=relaxed/simple;
	bh=2aP4oXKRSb1MJfT9SOjWQtkkP0myhMnarRsFUG+F0Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE197l8HEwhW4opgaK9NBTcwHOVCf6xk28hg/unxKiIKLFiY+cNyHUDopjjL2UKZ+dAxS6Sy3csEg074BHPXFesvfpwWjw4OLX5Zy64w0E6UXCcciG633Fo1kKgICpqmVOBU/SHujQhwo9T0QPAP9wsCgROWCvW7sqkVWBtM4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaU/SYwQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso72242631fa.2;
        Wed, 31 Jul 2024 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722420391; x=1723025191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEN4u/tG/J9UeLM5/XA8rih5Bz4G8k8tK8+kNzb5VJw=;
        b=jaU/SYwQa8Tl7H/6Ejko7FpnVUvG3+/G2sc2kzedWjdgAXfGHGBL9b9j+1xS+/lmvN
         tygeJxAqBgDoyxhvIapq3NcKtWVFmiylYlJsjOOI+GtZirzVmGS8b1lHel2e9p2MWERB
         6yYlWadmPH8nOMMEHu5GFdPgaqDHBT5u8F/e79C8kPPPetTIncLUGakM7v7L44ZD4g0O
         gfUN5FxAad/5QE647hPPRcQp5JHE8XyDDC3Wl67QVCFhEtxwd5RZoXW32rqyLej4dQV5
         9hDTpiZanN9x+yuJ0EcPQXbbjxcQH/p91FLyOxvIgNUiFl4gFVlOdap4Gf+vyiDfFJ2d
         64mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722420391; x=1723025191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEN4u/tG/J9UeLM5/XA8rih5Bz4G8k8tK8+kNzb5VJw=;
        b=DJtaydM0vmhUH5MAi87THnQvUihwhounsByL6bGV34CDeghkYo6Lr0R8IBi13vMyxN
         KxSYFD7b9kOQV8UosE9XGDCAk342r8z7cultZ/neyVe/3rdnBx0SIWg+UwIuay0ka1/t
         2IbmHRDOsoXV1yKdh362O2CQmQqrBQhmHfr6MrUZ4lvqDziLefP/w5pLB2xta+X+GtC/
         CoXBces6vPcC4bd4nqePNEw3Jx7PY8WfrC+u0YsHvX/vQOMRY/2JJY0L8K/tUTOfmm3F
         3c8bDcRMBFaqO3Yu/M4qe0Kf2rGQ44tFhfR8lMTlWKdzrhX4oor0S15QGrokMJFaAotu
         UFgA==
X-Forwarded-Encrypted: i=1; AJvYcCVtQuNkVchfn0T29XTuR/2hyp7tXJgV+orSBd/gxX9Z44mYEmGIHvrWDJe92Kk8kAk9DjHRGzF8yadXfKDG24+iDA7IK6CWPQXwpZ78
X-Gm-Message-State: AOJu0YzHNvYSvnZJ1ifMAoloNSoc13RvPzIMiv9cGRXDPLICWWX2vNP5
	2LKR2z/CDrulhKLTl/6mtf1XhMD/iiWZad6+DwTxLZR38Heq16PMK4AJEIBEPKPfyC4rN8he610
	nq3+oOFnOK1sHscjWtK/kCA+tSBc=
X-Google-Smtp-Source: AGHT+IFZQRojJ0JPS68j3Im1vIhiOEmnvTfRefcVEMIHivBnyXs78fRkjUxc5nPb/dc6vE63XeQ3IfA1oyx3Tx8ODXQ=
X-Received: by 2002:a2e:3c0a:0:b0:2ee:87e9:319d with SMTP id
 38308e7fff4ca-2f12ee2ffb6mr101960371fa.48.1722420390293; Wed, 31 Jul 2024
 03:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125856.7321-1-ubizjak@gmail.com> <20240731093516.GR1967603@kernel.org>
In-Reply-To: <20240731093516.GR1967603@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 31 Jul 2024 12:06:18 +0200
Message-ID: <CAFULd4aye+mGTV1CJp5Coq0Qr2DvwOezpd5-hxWbF4-xR5aj_Q@mail.gmail.com>
Subject: Re: [PATCH] net/chelsio/libcxgb: Add __percpu annotations to libcxgb_ppm.c
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:35=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, Jul 30, 2024 at 02:58:19PM +0200, Uros Bizjak wrote:
> > Compiling libcxgb_ppm.c results in several sparse warnings:
> >
> > libcxgb_ppm.c:368:15: warning: incorrect type in assignment (different =
address spaces)
> > libcxgb_ppm.c:368:15:    expected struct cxgbi_ppm_pool *pools
> > libcxgb_ppm.c:368:15:    got void [noderef] __percpu *_res
> > libcxgb_ppm.c:374:48: warning: incorrect type in initializer (different=
 address spaces)
> > libcxgb_ppm.c:374:48:    expected void const [noderef] __percpu *__vpp_=
verify
> > libcxgb_ppm.c:374:48:    got struct cxgbi_ppm_pool *
> > libcxgb_ppm.c:484:19: warning: incorrect type in assignment (different =
address spaces)
> > libcxgb_ppm.c:484:19:    expected struct cxgbi_ppm_pool [noderef] __per=
cpu *pool
> > libcxgb_ppm.c:484:19:    got struct cxgbi_ppm_pool *[assigned] pool
> > libcxgb_ppm.c:511:21: warning: incorrect type in argument 1 (different =
address spaces)
> > libcxgb_ppm.c:511:21:    expected void [noderef] __percpu *__pdata
> > libcxgb_ppm.c:511:21:    got struct cxgbi_ppm_pool *[assigned] pool
> >
> > Add __percpu annotation to *pools and *pool percpu pointers and to
> > ppm_alloc_cpu_pool() function that returns percpu pointer to fix
> > these warnings.
> >
> > Compile tested only, but there is no difference in the resulting object=
 file.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drive=
rs/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> > index 854d87e1125c..01d776113500 100644
> > --- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> > +++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> > @@ -342,10 +342,10 @@ int cxgbi_ppm_release(struct cxgbi_ppm *ppm)
> >  }
> >  EXPORT_SYMBOL(cxgbi_ppm_release);
> >
> > -static struct cxgbi_ppm_pool *ppm_alloc_cpu_pool(unsigned int *total,
> > -                                              unsigned int *pcpu_ppmax=
)
> > +static struct cxgbi_ppm_pool __percpu *ppm_alloc_cpu_pool(unsigned int=
 *total,
> > +                                                       unsigned int *p=
cpu_ppmax)
>
> Let's keep to less than 80 columns wide, as is still preferred for
> Networking code. Perhaps in this case:
>
> static struct cxgbi_ppm_pool __percpu *
> ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)

Hm, the original is exactly what sparse dumped, IMO code dumps should
be left as they were dumped.

> Also, I do observe that this is an old driver, so the value
> of cleaning it is perhaps limited.

It broke my strict percpu checker with allyesconfig. Fixing it was
trivial and resulted in no object code changes.

> But the above aside, this looks good to me.

Thanks,
Uros.

