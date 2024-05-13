Return-Path: <netdev+bounces-95920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889708C3D71
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8061C2137E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5906147C8E;
	Mon, 13 May 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VCcXT8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10863146D4E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589663; cv=none; b=oNTpgu5+qEp6PFLu7XTCW3WwQkdN4jQopiTqRj2JmQXgxyORLz856s1jo//yw96KdJykU7WgrlqtgnPSFauZGbxJeePz9xFkvaTXazgIMuISIWI+XRPISuukTzRnn/kUFbIMH2zikIDBR2VbPl592UyzKPyclyFU/GB76Ib4zuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589663; c=relaxed/simple;
	bh=6Qe+Z4SzpwQnD/xZduFUuZ+qeUgZmflyk3fkh5lZ93s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uu4LzNywYMI7ZCliGlerPit5BGgwLxgVh6qSfnn1Mhrr967abI8ZkvfQSgnf21T1MaAKngK9cbUvAUfH0DiQJ7WpoKb6Dn8DojwziPLBSxXevFWnwzGvsbUq+MDvmUfmHqT5Z+poJijziFXKZyOQ03mKi9CmY5AUiMEOqFjvGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VCcXT8/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso9483a12.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715589660; x=1716194460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSDRwv7jk6IAgHWtX5wD76uWRnyIu2E9jN3RV77i0HQ=;
        b=3VCcXT8/uQ5qKRowowrKsBuK0rDnIpewljbIwCzj6lgnZfLB8UC/cfoxOzNo51+8Ln
         PXWMN5w5mISm/Qiey2V9CxpgDNZ3128DDReiKBjTBwmARoaL2PpqjVr2/lFz2yxRwong
         fLp3NsCTR+TzrLCtI0bLTdima0Pg9/RY7YP1shMX/+LTKgYetS++xOMzDJCd5Ubo5uMx
         TbnjUoMM6hw4OI4vRpIkyUpb+S5dEYwoLBaXk7et8bkXR7avQ++1eQ5UCjZNDBtIEHB2
         lwvf2eBKYLgAivaFOaL/yu2Dw4UYvQkWttdMsAwNvR1ue3tlvqsri9d1FGbBgdST41Pa
         uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715589660; x=1716194460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSDRwv7jk6IAgHWtX5wD76uWRnyIu2E9jN3RV77i0HQ=;
        b=sMUCpceI2G15lP0RP5s0rifL1RN5bpURCEgPq2UAVYSzPBdUAU4WH5I0m+SrRLDBWm
         ec8l0ScDIAFBF9kDamEC7pqYiUhtXQKmvn3dTxgNDI/xFsxMQBT+aMrwQESgsz73Vmrv
         ReQD6eL2/XIThrYEAl2leJzYH0+LDGJ9icGpOLr4u5W8r8Zln+gfhndLwNitvizyNV4c
         nCJB30XJptQ3ZQC2EaLAxTpHghBgI6ny+hfq9tNOZBkvNWa2JDF9a7d+pJInr9WQFNlm
         itH/ha0cBcdwQY/bfQKEX4pPotQUC881HJlAjBm+3p03hAA/na29VHDrmWMkRBrG7WJV
         vhWA==
X-Forwarded-Encrypted: i=1; AJvYcCVBV7niRL3cIzJvGKMbq9eNcbaiLUzZ0UxXnImyJEEmneamgG0VCM70fEQjF3YbIHZekxNl1oFZjI+pkYOSGHbLeCIZW3Nx
X-Gm-Message-State: AOJu0YyFOPNwniYim3ZrgOjnc4UhCSkwx5IjHqOJD6HJbqVCnUl0/pXT
	XqZbOAiHSWOkbmWfxagnnwXolmzEWtDvqR8tqWfwIAx+FbBgAU7LjtiMm2kKe7IEfh1m06BElvL
	Yy4cNfQQ8aBRv7p3WvWxGAenzqo55VxkNHZdv
X-Google-Smtp-Source: AGHT+IG57BWFXudd7m8JcDciNBmtXJbh5+hfFHuyw1l+yn/mpSNaGi+yGRv/Cgp0O9O0ywU03d4iur9Dsc9F5E9hlnM=
X-Received: by 2002:a05:6402:2153:b0:572:5597:8f89 with SMTP id
 4fb4d7f45d1cf-57443d30921mr260807a12.6.1715589660140; Mon, 13 May 2024
 01:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513015127.961360-1-wei.fang@nxp.com> <CANn89i+EQDCFrhC3mN8g2k=KFpaKtrDusgaUo9zBvv0JCw8eYg@mail.gmail.com>
 <PAXPR04MB85100C1A06253C0AE1EB36C288E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB85100C1A06253C0AE1EB36C288E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 May 2024 10:40:46 +0200
Message-ID: <CANn89i+0xtG5hg2LsGvNOueCAkOac_UccXWq-Eeqt1a40EkqBA@mail.gmail.com>
Subject: Re: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 9:53=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Eric Dumazet <edumazet@google.com>
> > Sent: 2024=E5=B9=B45=E6=9C=8813=E6=97=A5 15:29
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com; Shenwei
> > Wang <shenwei.wang@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > richardcochran@gmail.com; andrew@lunn.ch; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH net] net: fec: avoid lock evasion when reading pps_=
enable
> >
> > On Mon, May 13, 2024 at 4:02=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wro=
te:
> > >
> > > The assignment of pps_enable is protected by tmreg_lock, but the read
> > > operation of pps_enable is not. So the Coverity tool reports a lock
> > > evasion warning which may cause data race to occur when running in a
> > > multithread environment. Although this issue is almost impossible to
> > > occur, we'd better fix it, at least it seems more logically
> > > reasonable, and it also prevents Coverity from continuing to issue wa=
rnings.
> > >
> > > Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp
> > > clock")
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > >  drivers/net/ethernet/freescale/fec_ptp.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> > > b/drivers/net/ethernet/freescale/fec_ptp.c
> > > index 181d9bfbee22..8d37274a3fb0 100644
> > > --- a/drivers/net/ethernet/freescale/fec_ptp.c
> > > +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> > > @@ -104,14 +104,16 @@ static int fec_ptp_enable_pps(struct
> > fec_enet_private *fep, uint enable)
> > >         struct timespec64 ts;
> > >         u64 ns;
> > >
> > > -       if (fep->pps_enable =3D=3D enable)
> > > -               return 0;
> > > -
> > >         fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
> > >         fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
> >
> > Why are these writes left without the spinlock protection ?
> For fec driver, the pps_channel and the reload_period of PPS request
> are always fixed, and they were also not protected by the lock in the
> original code.

If this is the case, please move this initialization elsewhere, so
that we can be absolutely sure of the  claim.

I see fep->reload_period being overwritten in this file, I do not see
clear evidence this is all safe.

