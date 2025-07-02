Return-Path: <netdev+bounces-203089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A9AF07CD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13754252F1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0B13B298;
	Wed,  2 Jul 2025 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgcS+X/F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2E1C6B4
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418733; cv=none; b=k7T9Tiqr5hc1bZ94xMwvyhC5cshS4nRKOfBhbL1UJrYY7vXmIRGEMHD8z0gWxwzp37fGApqV7hUDoJuEbyn8hfbsU/hDcMaiNwuCUFS/zqvqZwuUR+eA2aOHTdzs+eacpOY3BuEtMEaiyPHE14lftX5wlp2qSJ4p5EAOGtzvtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418733; c=relaxed/simple;
	bh=tIHpRxPr6KrTjv+tRpSrdHkAL1h2W7zDf93K8Y5Jf4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eU5Hk5O5+5znti5i5IWkSTEMWG+SL0H0AkX4EFDTeUzEm26QPXxvfnx+YLC1UCvHp7TixbkB+fSb+9XNmrgpCKPbFvSuu4+5ZDiIYa559+2cm7gzu69YUaHPPDEJTjnNjTzuMePxWclt5cQ+t7WjOtnqpkT7+8n7Sn2L1cm+DW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgcS+X/F; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso12546245ab.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418731; x=1752023531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40Ol6OgS1IWwtBlLR+q+C5SHoZRjfsmd6m18u528RnI=;
        b=lgcS+X/FaEHPV9Iq9oQfUJxTuj4Tc3V0tPsubw3nY8z7Dhpdh062IsdokfheRJUaXG
         0iaDYxyX0ghp2PJUdbmSaHveFiqo+tNBVd/jJLbWO7bTAO9Fe3spm2tiAICS59UWkBKY
         q6cJF5zYOPpM7Y8CqiU3Z7Pd/L/UqHRv8pc2jGP37DSCSNaw8YizWk+aA2en5ERjwSqY
         26ycX0lsP1vu9NbZvTY9xbY/KDTbNDCa/wZGcXWGWwnZxdjoYI5dVrECW6w77FETog4V
         iPOKsa5kuLadhiRAW1G9fo8FmcMPMa4CfgE3lIsTNT1WQZ7s0YTyNpu0lUzQSt3L+5s2
         8m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418731; x=1752023531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40Ol6OgS1IWwtBlLR+q+C5SHoZRjfsmd6m18u528RnI=;
        b=xE+b4o1mDQziVXy933MXS0FIn4eF4yuNJcJOo9GkDpYMC8013IsGRZqjfctJIiN7y4
         eqTcIgi8QbNqZ06ip+TQjtY9lOxCm/NASx7dW959Axnhl2FEJIESypQaqL14wDAAdheV
         P0fWKV8TvgDBfOnxHPUVD5k0ijPJGpMwbbVaCfue4iIHz9jKroV2Nfco9GWiqv4mNGot
         NP58SqQXGsJNb9nj8fJblS/wftNUOctEjpGT59k7xcnlbf8J0cNlxaV8q6W3eMEuelOs
         zl2rmYpr9HYBjUNw5qBJxwb74U+ZY4SCRN+eUefj4kjJOZR2ePHeaFxAtlpPPCa0zUHg
         0F3A==
X-Forwarded-Encrypted: i=1; AJvYcCVd0lvOdQ3S9trwbTuHqP6ozmMYdFz3vb92Mai1RbSlkgk1c5FTlaJuLJky1b13YW9rmCkQSss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/w2f5pCEbG07M0hXRZUa5JA5MajfoFg65Dw/NybwOLyo65E95
	AXTFl6CMLW+6TydLWQdqhHLwRJQJbZT5ilUAXE0womIavJtL25HW9F8lQxOz2ABQJX9Z4io/ZL8
	6I57THwg9x3cq7tugF1IL3NOQLELEhns=
X-Gm-Gg: ASbGnctl90suBN994XXyWrpFbUdRWfJD792a+PGF2TWpDwFGJMzGzDT1od72V18PPR/
	lQSki/uqajOt/L7qfAKEDJTYnkIcHNFGYJzFo/AjLf6Nqmn8McNX/bQkpJubOwPsPncT8v74KKl
	+JykCdY1RiYskWIfZB3YFAAg8Ztoz4AO2ycSVIbd03uQ==
X-Google-Smtp-Source: AGHT+IE2FWTAiyARTy92ULI6zk0pZxhNprq3g7ffe/o5i20QBzgD3keulA5+g65TXtPpJyhMwcVtp4vBRS1NRQOnWlI=
X-Received: by 2002:a05:6e02:1c08:b0:3e0:546c:bdc3 with SMTP id
 e9e14a558f8ab-3e054ac7ddcmr10519975ab.11.1751418731035; Tue, 01 Jul 2025
 18:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629003616.23688-1-kerneljasonxing@gmail.com>
 <20250630110953.GD41770@horms.kernel.org> <CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
 <20250701171501.32e77315@kernel.org> <CAL+tcoAfV+P3579_uM4mikMkNK4L2dMx0EuXNnTeLwZ3-7Po2Q@mail.gmail.com>
 <20250701175607.35f2a544@kernel.org> <CAL+tcoBu_jo5Nhv-4gRomwfOpN+Y_Ny+QJ6p1dk87gQ==YX-Mg@mail.gmail.com>
In-Reply-To: <CAL+tcoBu_jo5Nhv-4gRomwfOpN+Y_Ny+QJ6p1dk87gQ==YX-Mg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Jul 2025 09:11:35 +0800
X-Gm-Features: Ac12FXyU9J9F62qi7RmBzbm2j_CWwKOftedo0lVsOznd7zYkuj4WnV9DbHOClQQ
Message-ID: <CAL+tcoA8+gGaOhAC4p743Ah9fVbmVwk8AT8zHH7SpFr2-pmm=A@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Jul 2, 2025 at 8:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 2 Jul 2025 08:47:08 +0800 Jason Xing wrote:
> > > >  static int bnxt_request_irq(struct bnxt *bp)
> > > >  {
> > > > +       struct cpu_rmap *rmap =3D NULL;
> > > >         int i, j, rc =3D 0;
> > > >         unsigned long flags =3D 0;
> > > > -#ifdef CONFIG_RFS_ACCEL
> > > > -       struct cpu_rmap *rmap;
> > > > -#endif
> > >
> > > Sorry, Jakub. I failed to see the positive point of this kind of
> > > change comparatively.
> >
> > Like Simon said -- fewer #ifdefs leads to fewer bugs of this nature.
>
> Agree on this point.
>
> > Or do you mean that you don't understand how my fix works?

Oh, thanks to the word 'fix' you mentioned. It seems that I'm supposed
to add Fixes: tag...

