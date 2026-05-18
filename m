Return-Path: <netdev+bounces-288950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HA6MzbaCmoA8wQAu9opvQ
	(envelope-from <netdev+bounces-288950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76032569931
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63FE03010532
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC73E4C79;
	Mon, 18 May 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9ZH6Awr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k3tVzoEE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0453D0926
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095481; cv=pass; b=usBNpRniNG6Cg9/c1LE/cY744Oxxi2TE+3/HTMxmhl0rnCk0UC4fEYXbeWgvnqtzH0aKdS/FSrgJi3E+NsAiwB1BU0+HOZ5igw/XERS1hKpBSrJWEaBM5crzL+8zFNxPnWxfBloubaKyT794U5kXvQVjh03idriO5c7NT9MGdF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095481; c=relaxed/simple;
	bh=pG+tBm3rNUsj3+D0Z7NpSXYRdoWRZ+lBHnOTxsv6Ces=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDoRd4PI/+0k2u9bZvxjIs60whnthNSWU2skmahccNOt8rfMW8JwqvBLicgQx8eX4BX8k81Sv9kAl66KYqgvPLAj13CGttaSnHDUYeEGglQ6VO8HRiaO4mrXGZ4TMTWtoATSPAy1+Z4uTOQpvTMcKaaN1b8dBC2v3B+xVn4sZ9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9ZH6Awr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k3tVzoEE; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIsuo6G1zeHZrXC/yEppAd7KHsK25jVZtty/IueYmhU=;
	b=B9ZH6Awrqidyrx0o/tIlkJjGlq0loqiCSSNln6yi7TMOXTSHWUhDFG3m9axZwP7VdyPixM
	RTLF6CyoIT5pSb4FtbTyLK5oBhnL3dYFK/sPUKg+jANlnMhv/OijXcQhXNPJEtOfxkhMpJ
	kOjat+4F9RW+JT3LAxyRVf1enwn+84A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-UKbD2zCZO3a24h0f73bqkg-1; Mon, 18 May 2026 05:11:14 -0400
X-MC-Unique: UKbD2zCZO3a24h0f73bqkg-1
X-Mimecast-MFC-AGG-ID: UKbD2zCZO3a24h0f73bqkg_1779095473
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a8690b9f6eso167656e87.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779095473; cv=none;
        d=google.com; s=arc-20240605;
        b=iaDAXDmc6TrzYseGPW3+h36bDEsuspmpJNa2qVt0rUfcZvHbTiSHau943nS9/4+nLm
         OwRo8kuBd+qf7U/yfFtjcfIRxR6BRktJcWL88hseTtKIV0f3u85w/iSQ23X+Jwy+wOJs
         yRc7jkpc22+rV8vzShpyDz6eJ6dqkoEYbgjdd5ax0FzJQ2XnqHnWd2halSGoik3rSmGK
         wBooq+Qiwz5pWek9IJ6pCKnzJibiFNyv6FHYoJ4K/GJHt+/lSYVO5lMp9z5z7wCMxjTe
         hGCtMDIGWsbQI1KtT1aftlq+o61foD3nMF0hDr2PxPC1oIC6GXZURh7B396ves3kP8cu
         AZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OIsuo6G1zeHZrXC/yEppAd7KHsK25jVZtty/IueYmhU=;
        fh=BUTJYybUiVDiynqbt5zDa+0TdFn3mpc3OIF868bzRco=;
        b=Ke03xmmYDjm47HIrv6EqbEwQrNtVukM6fSsnnyvOzUgsJXlXvF/fPHbsY/lri24LH9
         GSUD4uKdQstPzlWNXBkWG2C+tYVW5h08sKQ4D11xhMiYYIsluuCyhOPP9ZaOCq60ofGy
         tChbDN7LH/shsvwbuXb7mP0dwjo1uR/ABTgYzke4Uw7SXIGe5YpQb9mpLWD5ZmDJYMug
         VZ+RlusXoTU8W1aGAKW57dDvcyFzJ+JFk8BR8KaeOiy5fV5plQPXmG5XbTCF9PLQKQsZ
         5G986jaKem93eqGW9AiP8d8+QKHlS58xKwGszWtWe+i/MvdXmRqBmK8sWxL4puOJs+Fu
         y4Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095473; x=1779700273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIsuo6G1zeHZrXC/yEppAd7KHsK25jVZtty/IueYmhU=;
        b=k3tVzoEEiWbEIJO67slD2lhHqgHNr/+2zFS5BtT2f56oXIwqyVHnrKpPlXfxcTdqQk
         6De3BncctjPg62uJLPVsjCbb5qN6mrhrBhTORdvdj10M8G1K3Lc4QTyTRqmllm+FBS3f
         muivSj7sRhj055p3fE8wKnUDnj7BYXECqgporhKyONSgNtybiqV4gsIkf7QkRbrSk3Wi
         Pl4v3gsV+YbZKj3JFol8ehjifvO9e10XMwjmdc459hwNg2Tdj3pVTmiO0+qBqskkAVkj
         xUoCRpSJOYdthCdcu5TW6+Eza3+R4DCk3OIgd0WlleBWrgrKls36uNpqsnnB0rECLEy/
         7XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095473; x=1779700273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OIsuo6G1zeHZrXC/yEppAd7KHsK25jVZtty/IueYmhU=;
        b=V4PVw/FqgeX7zwryFUWws3Dhem7dTpXhAYCuwKRwsCo4NigZRjbqTB99eNuq4OXedr
         Jh/5TDSBcX60Go2g/3i9gIuUziuQaH0rkUSXc88LeHuJIR14dd7cLZIU6JDjFjMa9y/u
         8wb2z6ZqdhXcVCbhga1VqO7+JLXugqLsUEJuTFFKSwYf7Qm3KCdTBWP4GjFaLLjCdPQQ
         oqbh/V7kUpahZbb7NMaYo6YYsqgf4H+KDxnZXpOCftx/MSYOQF5e7EfxWSTQvqqqLiPI
         x7ZoE1+d0bQHIAOQ7/yEbe9w7Oqu+nhZa/51yNsZzZsmgnWZDpHtyK7ZA28xwfBwubSv
         W3xQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zMBfOlXnBrU9MIBF1HqJy4ftnhreCDabHmXTsMNIfYVx8pZaRpFobi+6dvXJO5ftY2TOoX08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYy3plmGMTm/C205SJJ98XHBjGukMgcwXWBIOQGmTebMbW9fZ
	v3lwE2nabg54b4yuYAnkrik8FuvueHUUfGKXhmOf9Ea0cj1iQgrzkp+AlbpfcmvL+2Pz91fZ0IN
	JP9fXoNR5uwsuMtjSPxg1IOMhGkMHqlqUyYpBsPU7IwM66vAa/ZaFlsVsTItmWIQQFPUzOdc+ms
	6eYylfGnHntRxOXisMf0qsWmIhfonYOAcW
X-Gm-Gg: Acq92OENvH6iAxzXtaXbMnT0K9LByfJQoyrUO7f+2beNCXsbYmlFqVptH8+7CleKesn
	B/VdkeJZBZt24hHNfG6GR/goF8GtSJ3dXs723x+X0GNY5T2SAHgJo5PDWaQ2xPKB9iI9vcUyZoF
	m0LSN7A9k4HgJyZezi6nFYavYf2EYiMjc5NmbZjYZSTeNCDhOIhoNlfLjeElHGwDDHipR4jc/QW
	WjtqA==
X-Received: by 2002:a2e:a801:0:b0:38a:f5a6:9190 with SMTP id 38308e7fff4ca-39561ca33fdmr17953611fa.4.1779095472895;
        Mon, 18 May 2026 02:11:12 -0700 (PDT)
X-Received: by 2002:a2e:a801:0:b0:38a:f5a6:9190 with SMTP id
 38308e7fff4ca-39561ca33fdmr17953381fa.4.1779095472039; Mon, 18 May 2026
 02:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
 <20260203161917.1666696-4-vincent.guittot@linaro.org> <aYNl3yQXNa7SkpH9@shell.armlinux.org.uk>
 <CAKfTPtAAmwjwSJ_5kfARaOns-g5tnXdeGM4s2JOy5vnhNTTXYQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAAmwjwSJ_5kfARaOns-g5tnXdeGM4s2JOy5vnhNTTXYQ@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 18 May 2026 11:11:00 +0200
X-Gm-Features: AVHnY4KO4-AkDI0zoiSWdUN0y8KalCHgbB7gwD_HiPdwgukI8-zRYd45ihuOUgY
Message-ID: <CALE0LRu_6gt=aQ6Z4Q4k-9KNztoE0jOgk767_bJDiucqKA0KQA@mail.gmail.com>
Subject: Re: [PATCH 3/4 v2] phy: s32g: Add serdes xpcs subsystem
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, vkoul@kernel.org, neil.armstrong@linaro.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, 
	s32@nxp.com, p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com, 
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	horms@kernel.org, Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 76032569931
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288950-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eballetb@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,conf.name:url,mail.gmail.com:mid,linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all,

Just in case I missed something.

On Thu, Feb 5, 2026 at 6:03=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>

Is there a new version of this patchset? I tried applying this one on
top of the current mainline, building it as a module, and I received
different build errors:

ERROR: modpost: missing MODULE_LICENSE() in drivers/net/pcs/pcs-nxp-s32g-xp=
cs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in
drivers/net/pcs/pcs-nxp-s32g-xpcs.o
ERROR: modpost: "s32g_xpcs_init"
[drivers/phy/freescale/phy-nxp-s32g-serdes.ko] undefined!
ERROR: modpost: "s32g_xpcs_init_plls"
[drivers/phy/freescale/phy-nxp-s32g-serdes.ko] undefined!
ERROR: modpost: "s32g_xpcs_pre_pcie_2g5"
[drivers/phy/freescale/phy-nxp-s32g-serdes.ko] undefined!
ERROR: modpost: "s32g_xpcs_vreset"
[drivers/phy/freescale/phy-nxp-s32g-serdes.ko] undefined!
ERROR: modpost: "s32g_xpcs_wait_vreset"
[drivers/phy/freescale/phy-nxp-s32g-serdes.ko] undefined!
ERROR: modpost: "s32g_xpcs_reset_rx"
[drivers/phy/freescale/phy-nxp-s32g-serdes.ko] undefined!
ERROR: modpost: "s32g_xpcs_disable_an"
[drivers/phy/freescale/phy-nxp-s32g-serdes.ko] undefined!

Thanks,
 Enric

> On Wed, 4 Feb 2026 at 16:29, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Sorry, I don't have time to finish this review, nor cut down the contex=
t
> > as I normally would do... I'm being bothered on company Slack, which no=
w
> > has the really bloody annoying feature of popping up a window rather th=
an
> > using KDE's notification subsystem, and that steals keyboard focus away
> > from whatever one is trying to do at the time.
> >
> > On Tue, Feb 03, 2026 at 05:19:16PM +0100, Vincent Guittot wrote:
> > > +static bool s32g_xpcs_poll_timeout(struct s32g_xpcs *xpcs, xpcs_poll=
_func_t func,
> > > +                                ktime_t timeout)
> > > +{
> > > +     ktime_t cur =3D ktime_get();
> > > +
> > > +     return func(xpcs) || ktime_after(cur, timeout);
> > > +}
> > > +
> > > +static int s32g_xpcs_wait(struct s32g_xpcs *xpcs, xpcs_poll_func_t f=
unc)
> > > +{
> > > +     ktime_t timeout =3D ktime_add_ms(ktime_get(), XPCS_TIMEOUT_MS);
> > > +
> > > +     spin_until_cond(s32g_xpcs_poll_timeout(xpcs, func, timeout));
> > > +     if (!func(xpcs))
> > > +             return -ETIMEDOUT;
> >
> > XPCS_TIMEOUT_MS is 300ms. spin_until_cond() spins until the condition i=
s
> > true. Do you need to tie up this CPU for up to 300ms? That seems
> > excessive. What is the reason that read_poll_timeout() or similar
> > couldn't be used?
>
> This needs additional tests because some instabilities have been
> reported when using read_poll_timeout in some places
>
> >
> > The advantage of read_poll_timeout() is that it will correctly handle
> > the timeout vs condition being satisfied witout need for special code.
> >
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int s32g_xpcs_wait_bits(struct s32g_xpcs *xpcs, unsigned int =
reg,
> > > +                            unsigned int mask, unsigned int bits)
> > > +{
> > > +     ktime_t cur;
> > > +     ktime_t timeout =3D ktime_add_ms(ktime_get(), XPCS_TIMEOUT_MS);
> > > +
> > > +     spin_until_cond((cur =3D ktime_get(),
> > > +                      (s32g_xpcs_read(xpcs, reg) & mask) =3D=3D bits=
 ||
> > > +                      ktime_after(cur, timeout)));
> > > +     if ((s32g_xpcs_read(xpcs, reg) & mask) !=3D bits)
> > > +             return -ETIMEDOUT;
> >
> > Same here:
> >
> >         return read_poll_timeout(s32g_xpcs_read, val, (val & mask) =3D=
=3D bits,
> >                                  0, XPCS_TIMEOUT_MS, false,
> >                                  xpcs, reg);
> >
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static unsigned int s32g_xpcs_digital_status(struct s32g_xpcs *xpcs)
> > > +{
> > > +     return s32g_xpcs_read(xpcs, VR_MII_DIG_STS);
> > > +}
> > > +
> > > +static int s32g_xpcs_wait_power_good_state(struct s32g_xpcs *xpcs)
> > > +{
> > > +     unsigned int val;
> > > +
> > > +     return read_poll_timeout(s32g_xpcs_digital_status, val,
> > > +                              FIELD_GET(PSEQ_STATE_MASK, val) =3D=3D=
 POWER_GOOD_STATE,
> > > +                              0,
> > > +                              XPCS_TIMEOUT_MS, false, xpcs);
> >
> > This could be:
> >         return read_poll_timeout(s32g_xpcs_read, val,
> >                                  FIELD_GET(PSEQ_STATE_MASK, val) =3D=3D=
 POWER_GOOD_STATE,
> >                                  0, XPCS_TIMEOUT_MS, false,
> >                                  xpcs, VR_MII_DIG_STS);
> >
> > eliminating the need for s32g_xpcs_digital_status().
>
> fair enough
>
> >
> > > +}
> > > +
> > > +void s32g_xpcs_vreset(struct s32g_xpcs *xpcs)
> > > +{
> > > +     /* Step 19 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, VR_RST, VR_RST);
> > > +}
> > > +
> > > +static bool s32g_xpcs_is_not_in_reset(struct s32g_xpcs *xpcs)
> > > +{
> > > +     unsigned int val;
> > > +
> > > +     val =3D s32g_xpcs_read(xpcs, VR_MII_DIG_CTRL1);
> > > +
> > > +     return !(val & VR_RST);
> > > +}
> > > +
> > > +int s32g_xpcs_wait_vreset(struct s32g_xpcs *xpcs)
> > > +{
> > > +     int ret;
> > > +
> > > +     /* Step 20 */
> > > +     ret =3D s32g_xpcs_wait(xpcs, s32g_xpcs_is_not_in_reset);
> > > +     if (ret)
> > > +             dev_err(xpcs->dev, "XPCS%d is in reset\n", xpcs->id);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +int s32g_xpcs_reset_rx(struct s32g_xpcs *xpcs)
> > > +{
> > > +     int ret =3D 0;
> > > +
> > > +     ret =3D s32g_xpcs_wait_power_good_state(xpcs);
> > > +     if (ret) {
> > > +             dev_err(xpcs->dev, "Failed to enter in PGOOD state afte=
r vendor reset\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     /* Step 21 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTRL1,
> > > +                          RX_RST_0, RX_RST_0);
> > > +
> > > +     /* Step 22 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTRL1,
> > > +                          RX_RST_0, 0);
> > > +
> > > +     /* Step 23 */
> > > +     /* Wait until SR_MII_STS[LINK_STS] =3D 1 */
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int s32g_xpcs_ref_clk_sel(struct s32g_xpcs *xpcs,
> > > +                              enum s32g_xpcs_pll ref_pll)
> > > +{
> > > +     switch (ref_pll) {
> > > +     case XPCS_PLLA:
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLL_CMN=
_CTRL,
> > > +                                  MPLLB_SEL_0, 0);
> > > +             xpcs->ref =3D XPCS_PLLA;
> > > +             break;
> > > +     case XPCS_PLLB:
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLL_CMN=
_CTRL,
> > > +                                  MPLLB_SEL_0, MPLLB_SEL_0);
> > > +             xpcs->ref =3D XPCS_PLLB;
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void s32g_xpcs_electrical_configure(struct s32g_xpcs *xpcs)
> > > +{
> > > +     /* Step 2 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_EQ_CTRL0,
> > > +                          TX_EQ_MAIN_MASK, FIELD_PREP(TX_EQ_MAIN_MAS=
K, 0xC));
> >
> > Prefer hex numbers to be lower case.
>
> ok
>
> >
> > > +
> > > +     /* Step 3 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_CONSUMER_10G_TX_TERM_CTRL,
> > > +                          TX0_TERM_MASK, FIELD_PREP(TX0_TERM_MASK, 0=
x4));
> > > +}
> > > +
> > > +static int s32g_xpcs_vco_cfg(struct s32g_xpcs *xpcs, enum s32g_xpcs_=
pll vco_pll)
> > > +{
> > > +     unsigned int vco_ld =3D 0;
> > > +     unsigned int vco_ref =3D 0;
> > > +     unsigned int rx_baud =3D 0;
> > > +     unsigned int tx_baud =3D 0;
> > > +
> > > +     switch (vco_pll) {
> > > +     case XPCS_PLLA:
> > > +             if (xpcs->mhz125) {
> > > +                     vco_ld =3D FIELD_PREP(VCO_LD_VAL_0_MASK, 1360);
> > > +                     vco_ref =3D FIELD_PREP(VCO_REF_LD_0_MASK, 17);
> > > +             } else {
> > > +                     vco_ld =3D FIELD_PREP(VCO_LD_VAL_0_MASK, 1350);
> > > +                     vco_ref =3D FIELD_PREP(VCO_REF_LD_0_MASK, 27);
> > > +             }
> > > +
> > > +             rx_baud =3D FIELD_PREP(RX0_RATE_MASK, RX0_BAUD_DIV_8);
> > > +             tx_baud =3D FIELD_PREP(TX0_RATE_MASK, TX0_BAUD_DIV_4);
> > > +             break;
> > > +     case XPCS_PLLB:
> > > +             if (xpcs->mhz125) {
> > > +                     vco_ld =3D FIELD_PREP(VCO_LD_VAL_0_MASK, 1350);
> > > +                     vco_ref =3D FIELD_PREP(VCO_REF_LD_0_MASK, 27);
> > > +             } else {
> > > +                     vco_ld =3D FIELD_PREP(VCO_LD_VAL_0_MASK, 1344);
> > > +                     vco_ref =3D FIELD_PREP(VCO_REF_LD_0_MASK, 43);
> > > +             }
> > > +
> > > +             rx_baud =3D FIELD_PREP(RX0_RATE_MASK, RX0_BAUD_DIV_2);
> > > +             tx_baud =3D FIELD_PREP(TX0_RATE_MASK, TX0_BAUD_DIV_1);
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_VCO_CAL_LD0,
> > > +                          VCO_LD_VAL_0_MASK, vco_ld);
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_VCO_CAL_REF0,
> > > +                          VCO_REF_LD_0_MASK, vco_ref);
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_RATE_CTRL,
> > > +                          TX0_RATE_MASK, tx_baud);
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_RATE_CTRL,
> > > +                          RX0_RATE_MASK, rx_baud);
> > > +
> > > +     if (vco_pll =3D=3D XPCS_PLLB) {
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_CDR_CTRL=
,
> > > +                                  VCO_LOW_FREQ_0, VCO_LOW_FREQ_0);
> > > +     } else {
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_CDR_CTRL=
,
> > > +                                  VCO_LOW_FREQ_0, 0);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int s32g_xpcs_init_mplla(struct s32g_xpcs *xpcs)
> > > +{
> > > +     unsigned int val;
> > > +
> > > +     if (!xpcs)
> > > +             return -EINVAL;
> > > +
> > > +     /* Step 7 */
> > > +     val =3D 0;
> > > +     if (xpcs->ext_clk)
> > > +             val |=3D REF_USE_PAD;
> > > +
> > > +     if (xpcs->mhz125) {
> > > +             val |=3D REF_MPLLA_DIV2;
> > > +             val |=3D REF_CLK_DIV2;
> > > +             val |=3D FIELD_PREP(REF_RANGE_MASK, RANGE_52_78_MHZ);
> > > +     } else {
> > > +             val |=3D FIELD_PREP(REF_RANGE_MASK, RANGE_26_53_MHZ);
> > > +     }
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_REF_CLK_CTRL,
> > > +                          REF_MPLLA_DIV2 | REF_USE_PAD | REF_RANGE_M=
ASK |
> > > +                          REF_CLK_DIV2, val);
> > > +
> > > +     /* Step 8 */
> > > +     if (xpcs->mhz125)
> > > +             val =3D FIELD_PREP(MLLA_MULTIPLIER_MASK, 80);
> > > +     else
> > > +             val =3D FIELD_PREP(MLLA_MULTIPLIER_MASK, 25);
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLA_CTRL0,
> > > +                          MPLLA_CAL_DISABLE | MLLA_MULTIPLIER_MASK,
> > > +                          val);
> > > +
> > > +     /* Step 9 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLA_CTRL1,
> > > +                          MPLLA_FRACN_CTRL_MASK, 0);
> > > +
> > > +     /* Step 10 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLA_CTRL2,
> > > +                          MPLLA_TX_CLK_DIV_MASK | MPLLA_DIV10_CLK_EN=
,
> > > +                          FIELD_PREP(MPLLA_TX_CLK_DIV_MASK, 1) | MPL=
LA_DIV10_CLK_EN);
> > > +
> > > +     /* Step 11 */
> > > +     if (xpcs->mhz125)
> > > +             val =3D FIELD_PREP(MPLLA_BANDWIDTH_MASK, 43);
> > > +     else
> > > +             val =3D FIELD_PREP(MPLLA_BANDWIDTH_MASK, 357);
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLA_CTRL3,
> > > +                          MPLLA_BANDWIDTH_MASK, val);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int s32g_xpcs_init_mpllb(struct s32g_xpcs *xpcs)
> > > +{
> > > +     unsigned int val;
> > > +
> > > +     if (!xpcs)
> > > +             return -EINVAL;
> > > +
> > > +     /* Step 7 */
> > > +     val =3D 0;
> > > +     if (xpcs->ext_clk)
> > > +             val |=3D REF_USE_PAD;
> > > +
> > > +     if (xpcs->mhz125) {
> > > +             val |=3D REF_MPLLB_DIV2;
> > > +             val |=3D REF_CLK_DIV2;
> > > +             val |=3D FIELD_PREP(REF_RANGE_MASK, RANGE_52_78_MHZ);
> > > +     } else {
> > > +             val |=3D FIELD_PREP(REF_RANGE_MASK, RANGE_26_53_MHZ);
> > > +     }
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_REF_CLK_CTRL,
> > > +                          REF_MPLLB_DIV2 | REF_USE_PAD | REF_RANGE_M=
ASK |
> > > +                          REF_CLK_DIV2, val);
> > > +
> > > +     /* Step 8 */
> > > +     if (xpcs->mhz125)
> > > +             val =3D 125 << MLLB_MULTIPLIER_OFF;
> > > +     else
> > > +             val =3D 39 << MLLB_MULTIPLIER_OFF;
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLB_CTRL0,
> > > +                          MPLLB_CAL_DISABLE | MLLB_MULTIPLIER_MASK,
> > > +                          val);
> > > +
> > > +     /* Step 9 */
> > > +     if (xpcs->mhz125)
> > > +             val =3D FIELD_PREP(MPLLB_FRACN_CTRL_MASK, 0);
> > > +     else
> > > +             val =3D FIELD_PREP(MPLLB_FRACN_CTRL_MASK, 1044);
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLB_CTRL1,
> > > +                          MPLLB_FRACN_CTRL_MASK, val);
> > > +
> > > +     /* Step 10 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MPLLB_CTRL2,
> > > +                          MPLLB_TX_CLK_DIV_MASK | MPLLB_DIV10_CLK_EN=
,
> > > +                          FIELD_PREP(MPLLB_TX_CLK_DIV_MASK, 5) | MPL=
LB_DIV10_CLK_EN);
> > > +
> > > +     /* Step 11 */
> > > +     if (xpcs->mhz125)
> > > +             val =3D FIELD_PREP(MPLLB_BANDWIDTH_MASK, 68);
> > > +     else
> > > +             val =3D FIELD_PREP(MPLLB_BANDWIDTH_MASK, 102);
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_MPLLB_CTRL3,
> > > +                          MPLLB_BANDWIDTH_MASK, val);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void s32g_serdes_pma_high_freq_recovery(struct s32g_xpcs *xpc=
s)
> > > +{
> > > +     /* PCS signal protection, PLL railout recovery */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_DBG_CTRL, SUPPRESS_LOS_DET | =
RX_DT_EN_CTL,
> > > +                          SUPPRESS_LOS_DET | RX_DT_EN_CTL);
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_MISC_CTRL0,
> > > +                          PLL_CTRL, PLL_CTRL);
> > > +}
> > > +
> > > +static void s32g_serdes_pma_configure_tx_eq_post(struct s32g_xpcs *x=
pcs)
> > > +{
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_EQ_CTRL1,
> > > +                          TX_EQ_OVR_RIDE, TX_EQ_OVR_RIDE);
> > > +}
> > > +
> > > +static int s32g_serdes_bifurcation_pll_transit(struct s32g_xpcs *xpc=
s,
> > > +                                            enum s32g_xpcs_pll targe=
t_pll)
> > > +{
> > > +     int ret =3D 0;
> > > +     struct device *dev =3D xpcs->dev;
> > > +
> > > +     /* Configure XPCS speed and VCO */
> > > +     if (target_pll =3D=3D XPCS_PLLA) {
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, EN_2_5G_MO=
DE, 0);
> > > +             s32g_xpcs_vco_cfg(xpcs, XPCS_PLLA);
> > > +     } else {
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
> > > +                                  EN_2_5G_MODE, EN_2_5G_MODE);
> > > +             s32g_xpcs_vco_cfg(xpcs, XPCS_PLLB);
> > > +     }
> >
> > I am really not happy with this driver being
> > PHY_INTERFACE_MODE_SGMII-only but supporting running that at 2.5Gbps.
> > In the kernel, PHY_INTERFACE_MODE_SGMII is strictly _Cisco_ SGMII only,
> > which means the version of it clocked at 1.25GHz, not 3.125GHz.
> >
> > OCSGMII or whatever random name you call it tends to be only supported
> > without inband AN, and we have pushed everyone to adopt
> > PHY_INTERFACE_MODE_2500BASEX for that. Please do the same.
> >
> > Should this SerDes be connected to a SFP cage, it will need to support
> > dynamically switching between Cisco SGMII and 2500BASE-X.
>
> okay, this needs to be checked with SoC Team
>
> >
> > > +
> > > +     /* Signal that clock are not available */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL1,
> > > +                          TX_CLK_RDY_0, 0);
> > > +
> > > +     /* Select PLL reference */
> > > +     if (target_pll =3D=3D XPCS_PLLA)
> > > +             s32g_xpcs_ref_clk_sel(xpcs, XPCS_PLLA);
> > > +     else
> > > +             s32g_xpcs_ref_clk_sel(xpcs, XPCS_PLLB);
> > > +
> > > +     /* Initiate transmitter TX reconfiguration request */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL2,
> > > +                          TX_REQ_0, TX_REQ_0);
> > > +
> > > +     /* Wait for transmitter to reconfigure */
> > > +     ret =3D s32g_xpcs_wait_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTR=
L2,
> > > +                               TX_REQ_0, 0);
> > > +     if (ret) {
> > > +             dev_err(dev, "Switch to TX_REQ_0 failed\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     /* Initiate transmitter RX reconfiguration request */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTRL2,
> > > +                          RX_REQ_0, RX_REQ_0);
> > > +
> > > +     /* Wait for receiver to reconfigure */
> > > +     ret =3D s32g_xpcs_wait_bits(xpcs, VR_MII_GEN5_12G_16G_RX_GENCTR=
L2,
> > > +                               RX_REQ_0, 0);
> > > +     if (ret) {
> > > +             dev_err(dev, "Switch to RX_REQ_0 failed\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     /* Signal that clock are available */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL1,
> > > +                          TX_CLK_RDY_0, TX_CLK_RDY_0);
> > > +
> > > +     /* Flush internal logic */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, INIT, INIT);
> > > +
> > > +     /* Wait for init */
> > > +     ret =3D s32g_xpcs_wait_bits(xpcs, VR_MII_DIG_CTRL1, INIT, 0);
> > > +     if (ret) {
> > > +             dev_err(dev, "XPCS INIT failed\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +/*
> > > + * phylink_pcs_ops
> > > + */
> > > +
> > > +static unsigned int s32cc_phylink_pcs_inband_caps(struct phylink_pcs=
 *pcs,
> > > +                                               phy_interface_t inter=
face)
> > > +{
> > > +     switch (interface) {
> > > +     case PHY_INTERFACE_MODE_SGMII:
> > > +             return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> > > +
> > > +     default:
> > > +             return 0;
> > > +     }
> > > +}
> > > +
> > > +static int s32cc_phylink_pcs_config(struct phylink_pcs *pcs,
> > > +                                 unsigned int neg_mode,
> > > +                                 phy_interface_t interface,
> > > +                                 const unsigned long *advertising,
> > > +                                 bool permit_pause_to_mac)
> > > +{
> > > +     struct s32g_xpcs *xpcs =3D phylink_pcs_to_s32g_xpcs(pcs);
> > > +
> > > +     /* Step 1: Disable SGMII AN */
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL,
> > > +                          MII_AN_INTR_EN,
> > > +                          0);
> > > +
> > > +     if (!(neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED))
> > > +             return 0;
> > > +
> > > +     /* Step 2  */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL,
> > > +                          PCS_MODE_MASK,
> > > +                          FIELD_PREP(PCS_MODE_MASK, PCS_MODE_SGMII))=
;
> > > +
> > > +     /* Step 3 */
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL,
> > > +                          SS13 | SS6,
> > > +                          SS6);
> > > +
> > > +     /* Step 4  */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL,
> > > +                          MII_CTRL,
> > > +                          0);
> > > +     /* Step 5 and 8 */
> > > +     if (xpcs->pcie_shared =3D=3D PCIE_XPCS_2G5) {
> > > +             s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x2faf);
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
> > > +                                  MAC_AUTO_SW, MAC_AUTO_SW);
> > > +     } else {
> > > +             s32g_xpcs_write(xpcs, VR_MII_LINK_TIMER_CTRL, 0x7a1);
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, MAC_AUTO_S=
W, 0);
> > > +     }
> > > +
> > > +     /* Step 6 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1,
> > > +                          CL37_TMR_OVRRIDE, CL37_TMR_OVRRIDE);
> > > +
> > > +     /* Step 7 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL,
> > > +                          MII_AN_INTR_EN,
> > > +                          MII_AN_INTR_EN);
> > > +
> > > +     /* Step 9: Enable SGMII AN */
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, AN_ENABLE);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void s32cc_phylink_pcs_get_state(struct phylink_pcs *pcs, uns=
igned int neg_mode,
> > > +                                     struct phylink_link_state *stat=
e)
> > > +{
> > > +     struct s32g_xpcs *xpcs =3D phylink_pcs_to_s32g_xpcs(pcs);
> > > +     bool ss6, ss13, an_enabled;
> > > +     struct device *dev =3D xpcs->dev;
> > > +     unsigned int val, ss;
> > > +
> > > +     an_enabled =3D (neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED)=
;
> > > +
> > > +     if (an_enabled) {
> > > +             state->link =3D 0;
> > > +             val =3D s32g_xpcs_read(xpcs, VR_MII_AN_INTR_STS);
> > > +
> > > +             /* Interrupt is raised with each SGMII AN that is in ca=
ses
> > > +              * Link down - Every SGMII link timer expire
> > > +              * Link up - Once before link goes up
> > > +              * So either linkup or raised interrupt mean AN was com=
pleted
> > > +              */
> > > +             if ((val & CL37_ANCMPLT_INTR) || (val & CL37_ANSGM_STS_=
LINK)) {
> > > +                     state->an_complete =3D 1;
> > > +                     if (val & CL37_ANSGM_STS_LINK)
> > > +                             state->link =3D 1;
> > > +                     else
> > > +                             return;
> > > +                     if (val & CL37_ANSGM_STS_DUPLEX)
> > > +                             state->duplex =3D DUPLEX_FULL;
> > > +                     else
> > > +                             state->duplex =3D DUPLEX_HALF;
> > > +                     ss =3D FIELD_GET(CL37_ANSGM_STS_SPEED_MASK, val=
);
> > > +             } else {
> > > +                     return;
> > > +             }
> > > +
> > > +     } else {
> > > +             val =3D s32g_xpcs_read(xpcs, SR_MII_STS);
> > > +             state->link =3D !!(val & LINK_STS);
> > > +             state->an_complete =3D 0;
> > > +             state->pause =3D MLO_PAUSE_NONE;
> > > +
> > > +             val =3D s32g_xpcs_read(xpcs, SR_MII_CTRL);
> > > +             if (val & DUPLEX_MODE)
> > > +                     state->duplex =3D DUPLEX_FULL;
> > > +             else
> > > +                     state->duplex =3D DUPLEX_HALF;
> > > +
> > > +             /*
> > > +              * Build similar value as CL37_ANSGM_STS_SPEED with
> > > +              * SS6 and SS13 of SR_MII_CTRL:
> > > +              *   - 0 for 10 Mbps
> > > +              *   - 1 for 100 Mbps
> > > +              *   - 2 for 1000 Mbps
> > > +              */
> > > +             ss6 =3D !!(val & SS6);
> > > +             ss13 =3D !!(val & SS13);
> > > +             ss =3D ss6 << 1 | ss13;
> > > +     }
> > > +
> > > +     switch (ss) {
> > > +     case CL37_ANSGM_10MBPS:
> > > +             state->speed =3D SPEED_10;
> > > +             break;
> > > +     case CL37_ANSGM_100MBPS:
> > > +             state->speed =3D SPEED_100;
> > > +             break;
> > > +     case CL37_ANSGM_1000MBPS:
> > > +             state->speed =3D SPEED_1000;
> > > +             break;
> > > +     default:
> > > +             dev_err(dev, "Failed to interpret the value of SR_MII_C=
TRL\n");
> > > +             break;
> > > +     }
> > > +
> > > +     val =3D s32g_xpcs_read(xpcs, VR_MII_DIG_CTRL1);
> > > +     if ((val & EN_2_5G_MODE) && state->speed =3D=3D SPEED_1000)
> > > +             state->speed =3D SPEED_2500;
> > > +
> > > +     /* Cover SGMII AN inability to distigunish between 1G and 2.5G =
*/
> > > +     if ((val & EN_2_5G_MODE) &&
> > > +         state->speed !=3D SPEED_2500 && an_enabled) {
> > > +             dev_err(dev, "Speed not supported in SGMII AN mode\n");
> > > +     }
> > > +}
> > > +
> > > +static void s32cc_phylink_pcs_link_up(struct phylink_pcs *pcs,
> > > +                                   unsigned int neg_mode,
> > > +                                   phy_interface_t interface, int sp=
eed,
> > > +                                   int duplex)
> > > +{
> > > +     struct s32g_xpcs *xpcs =3D phylink_pcs_to_s32g_xpcs(pcs);
> > > +     struct device *dev =3D xpcs->dev;
> > > +     bool an_enabled =3D (neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENA=
BLED);
> > > +     unsigned int val;
> > > +     int ret;
> > > +
> > > +     dev_dbg(dev, "xpcs_%d: speed=3D%u duplex=3D%d an=3D%d\n", xpcs-=
>id,
> > > +             speed, duplex, an_enabled);
> > > +
> > > +     if (an_enabled)
> > > +             return;
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_AN_INTR_EN, 0);
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_AN_CTRL, MII_CTRL, 0);
> >
> > Haven't you already disabled AN in .pcs_config() ? This method doesn't
> > change the AN enable state, the only time that happens is when
> > .pcs_config() will be called. All other cases of passing neg_mode are
> > merely informational.
>
> Fair enough, this is probably not needed anymore with the changes in .pcs=
_config
>
> >
> > > +
> > > +     if (duplex =3D=3D DUPLEX_FULL)
> > > +             val =3D DUPLEX_MODE;
> > > +     else
> > > +             val =3D 0;
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, val);
> > > +
> > > +     switch (speed) {
> > > +     case SPEED_10:
> > > +             val =3D 0;
> > > +             break;
> > > +     case SPEED_100:
> > > +             val =3D SS13;
> > > +             break;
> > > +     case SPEED_1000:
> > > +             val =3D SS6;
> > > +             break;
> > > +     case SPEED_2500:
> > > +             val =3D SS6;
> > > +             break;
> > > +     default:
> > > +             dev_err(dev, "Speed not supported\n");
> > > +             break;
> > > +     }
> > > +
> > > +     if (speed =3D=3D SPEED_2500) {
> > > +             ret =3D s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_=
PLLB);
> > > +             if (ret)
> > > +                     dev_err(dev, "Switch to PLLB failed\n");
> > > +     } else {
> > > +             ret =3D s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_=
PLLA);
> > > +             if (ret)
> > > +                     dev_err(dev, "Switch to PLLA failed\n");
> > > +     }
> >
> > This is a protocol transition, and isn't something that can be handled
> > here. Cisco SGMII (PHY_INTERFACE_MODE_SGMII) does not support 2500Mbps
> > and phylink will not allow it.
> >
> > See my comments for s32g_serdes_bifurcation_pll_transit().
> >
> > > +
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, SS6 | SS13, val);
> > > +}
> > > +
> > > +static const struct phylink_pcs_ops s32cc_phylink_pcs_ops =3D {
> > > +     .pcs_inband_caps =3D s32cc_phylink_pcs_inband_caps,
> > > +     .pcs_get_state =3D s32cc_phylink_pcs_get_state,
> > > +     .pcs_config =3D s32cc_phylink_pcs_config,
> > > +     .pcs_link_up =3D s32cc_phylink_pcs_link_up,
> > > +};
> > > +
> > > +/*
> > > + * Serdes functions for initializing/configuring/releasing the xpcs
> > > + */
> > > +
> > > +int s32g_xpcs_pre_pcie_2g5(struct s32g_xpcs *xpcs)
> > > +{
> > > +     int ret;
> > > +
> > > +     /* Enable voltage boost */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_GENCTRL1, VBO=
OST_EN_0,
> > > +                          VBOOST_EN_0);
> > > +
> > > +     /* TX rate baud  */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_TX_RATE_CTRL, 0x=
7, 0x0U);
> > > +
> > > +     /* Rx rate baud/2 */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_RX_RATE_CTRL, 0x=
3U, 0x1U);
> > > +
> > > +     /* Set low-frequency operating band */
> > > +     s32g_xpcs_write_bits(xpcs, VR_MII_GEN5_12G_16G_CDR_CTRL, CDR_SS=
C_EN_0,
> > > +                          VCO_LOW_FREQ_0);
> > > +
> > > +     ret =3D s32g_serdes_bifurcation_pll_transit(xpcs, XPCS_PLLB);
> > > +     if (ret)
> > > +             dev_err(xpcs->dev, "Switch to PLLB failed\n");
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +int s32g_xpcs_init_plls(struct s32g_xpcs *xpcs)
> > > +{
> > > +     int ret;
> > > +     struct device *dev =3D xpcs->dev;
> > > +
> > > +     if (!xpcs->ext_clk) {
> > > +             /* Step 1 */
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, BYP_PWRUP,=
 BYP_PWRUP);
> > > +     } else if (xpcs->pcie_shared =3D=3D NOT_SHARED) {
> > > +             ret =3D s32g_xpcs_wait_power_good_state(xpcs);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else if (xpcs->pcie_shared =3D=3D PCIE_XPCS_2G5) {
> > > +             ret =3D s32g_xpcs_wait_power_good_state(xpcs);
> > > +             if (ret)
> > > +                     return ret;
> > > +             /* Configure equalization */
> > > +             s32g_serdes_pma_configure_tx_eq_post(xpcs);
> > > +             s32g_xpcs_electrical_configure(xpcs);
> > > +
> > > +             /* Enable receiver recover */
> > > +             s32g_serdes_pma_high_freq_recovery(xpcs);
> > > +             return 0;
> > > +     }
> > > +
> > > +     s32g_xpcs_electrical_configure(xpcs);
> > > +
> > > +     s32g_xpcs_ref_clk_sel(xpcs, XPCS_PLLA);
> > > +     ret =3D s32g_xpcs_init_mplla(xpcs);
> > > +     if (ret) {
> > > +             dev_err(dev, "Failed to initialize PLLA\n");
> > > +             return ret;
> > > +     }
> > > +     ret =3D s32g_xpcs_init_mpllb(xpcs);
> > > +     if (ret) {
> > > +             dev_err(dev, "Failed to initialize PLLB\n");
> > > +             return ret;
> > > +     }
> > > +     s32g_xpcs_vco_cfg(xpcs, XPCS_PLLA);
> > > +
> > > +     /* Step 18 */
> > > +     if (!xpcs->ext_clk)
> > > +             s32g_xpcs_write_bits(xpcs, VR_MII_DIG_CTRL1, BYP_PWRUP,=
 0);
> > > +
> > > +     /* Will be cleared by Step 19 Vreset */
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, DUPLEX_MOD=
E);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +void s32g_xpcs_disable_an(struct s32g_xpcs *xpcs)
> > > +{
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, DUPLEX_MODE, DUPLEX_MOD=
E);
> > > +     s32g_xpcs_write_bits(xpcs, SR_MII_CTRL, AN_ENABLE, 0);
> > > +}
> >
> > Sorry, but why? You should never override phylink's requests.
>
> Serdes sometimes needs to be reset and the AN is enabled by default
> after the reset and even before pcs_config has been called. This is
> called during the inti of serdes after an ip reset.
> That being said this might not be needed anymore after the change in
> pcs_config that disables AN
>
>
> >
> > > +
> > > +int s32g_xpcs_init(struct s32g_xpcs *xpcs, struct device *dev,
> > > +                unsigned char id, void __iomem *base, bool ext_clk,
> > > +                unsigned long rate, enum s32g_xpcs_shared pcie_share=
d)
> > > +{
> > > +     struct regmap_config conf;
> > > +
> > > +     if (rate !=3D (125 * HZ_PER_MHZ) && rate !=3D (100 * HZ_PER_MHZ=
)) {
> > > +             dev_err(dev, "XPCS cannot operate @%lu HZ\n", rate);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     xpcs->base =3D base;
> > > +     xpcs->ext_clk =3D ext_clk;
> > > +     xpcs->id =3D id;
> > > +     xpcs->dev =3D dev;
> > > +     xpcs->pcie_shared =3D pcie_shared;
> > > +
> > > +     if (rate =3D=3D (125 * HZ_PER_MHZ))
> > > +             xpcs->mhz125 =3D true;
> > > +     else
> > > +             xpcs->mhz125 =3D false;
> > > +
> > > +     conf =3D s32g_xpcs_regmap_config;
> > > +
> > > +     if (!id)
> > > +             conf.name =3D "xpcs0";
> > > +     else
> > > +             conf.name =3D "xpcs1";
> > > +
> > > +     xpcs->regmap =3D devm_regmap_init(dev, NULL, xpcs, &conf);
> > > +     if (IS_ERR(xpcs->regmap))
> > > +             return dev_err_probe(dev, PTR_ERR(xpcs->regmap),
> > > +                                  "Failed to init register amp\n");
> > > +
> > > +     /* Phylink PCS */
> > > +     xpcs->pcs.ops =3D &s32cc_phylink_pcs_ops;
> > > +     xpcs->pcs.poll =3D true;
> > > +     __set_bit(PHY_INTERFACE_MODE_SGMII, xpcs->pcs.supported_interfa=
ces);
> > > +
> > > +     return 0;
> > > +}
> > > diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kc=
onfig
> > > index 45184a3cdd69..bb7f59897faf 100644
> > > --- a/drivers/phy/freescale/Kconfig
> > > +++ b/drivers/phy/freescale/Kconfig
> > > @@ -66,6 +66,7 @@ config PHY_S32G_SERDES
> > >       tristate "NXP S32G SERDES support"
> > >       depends on ARCH_S32 || COMPILE_TEST
> > >       select GENERIC_PHY
> > > +     select REGMAP
> > >       help
> > >         This option enables support for S23G SerDes PHY used for
> > >         PCIe & Ethernet
> > > diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/ph=
y/freescale/phy-nxp-s32g-serdes.c
> > > index 321a80c02be5..f2f7eb5aa327 100644
> > > --- a/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> > > +++ b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> > > @@ -12,12 +12,14 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of_platform.h>
> > >  #include <linux/of_address.h>
> > > +#include <linux/pcs/pcs-nxp-s32g-xpcs.h>
> > >  #include <linux/phy/phy.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/processor.h>
> > >  #include <linux/reset.h>
> > >  #include <linux/units.h>
> > >
> > > +#define S32G_SERDES_XPCS_MAX                 2
> > >  #define S32G_SERDES_MODE_MAX                 5
> > >
> > >  #define EXTERNAL_CLK_NAME                    "ext"
> > > @@ -32,6 +34,52 @@
> > >  #define S32G_PCIE_PHY_MPLLA_CTRL             0x10
> > >  #define  MPLL_STATE                          BIT(30)
> > >
> > > +#define S32G_PCIE_PHY_MPLLB_CTRL             0x14
> > > +#define  MPLLB_SSC_EN                                BIT(1)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_CTRL_SEL           0x18
> > > +#define  EXT_PHY_CTRL_SEL                    BIT(0)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_BS_CTRL            0x1C
> > > +#define  EXT_BS_TX_LOWSWING                  BIT(6)
> > > +#define  EXT_BS_RX_BIGSWING                  BIT(5)
> > > +#define  EXT_BS_RX_LEVEL_MASK                        GENMASK(4, 0)
> > > +
> > > +#define S32G_PCIE_PHY_REF_CLK_CTRL           0x20
> > > +#define  EXT_REF_RANGE_MASK                  GENMASK(5, 3)
> > > +#define  REF_CLK_DIV2_EN                     BIT(2)
> > > +#define  REF_CLK_MPLLB_DIV2_EN                       BIT(1)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_MPLLA_CTRL_1               0x30
> > > +#define  EXT_MPLLA_BANDWIDTH_MASK            GENMASK(15, 0)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_MPLLB_CTRL_1               0x40
> > > +#define  EXT_MPLLB_DIV_MULTIPLIER_MASK               GENMASK(31, 24)
> > > +#define  EXT_MPLLB_DIV_CLK_EN                        BIT(19)
> > > +#define  EXT_MPLLB_DIV8_CLK_EN                       BIT(18)
> > > +#define  EXT_MPLLB_DIV10_CLK_EN                      BIT(16)
> > > +#define  EXT_MPLLB_BANDWIDTH_MASK            GENMASK(15, 0)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_MPLLB_CTRL_2               0x44
> > > +#define  EXT_MPLLB_FRACN_CTRL_MASK           GENMASK(22, 12)
> > > +#define  MPLLB_MULTIPLIER_MASK                       GENMASK(8, 0)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_MPLLB_CTRL_3               0x48
> > > +#define  EXT_MPLLB_WORD_DIV2_EN                      BIT(31)
> > > +#define  EXT_MPLLB_TX_CLK_DIV_MASK           GENMASK(30, 28)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_MISC_CTRL_1                0xA0
> > > +#define  EXT_RX_LOS_THRESHOLD_MASK           GENMASK(7, 1)
> > > +#define  EXT_RX_VREF_CTRL_MASK                       GENMASK(28, 24)
> > > +
> > > +#define S32G_PCIE_PHY_EXT_MISC_CTRL_2                0xA4
> > > +#define  EXT_TX_VBOOST_LVL_MASK                      GENMASK(18, 16)
> > > +#define  EXT_TX_TERM_CTRL_MASK                       GENMASK(26, 24)
> > > +
> > > +#define S32G_PCIE_PHY_XPCS1_RX_OVRD_CTRL     0xD0
> > > +#define  XPCS1_RX_VCO_LD_VAL_MASK            GENMASK(28, 16)
> > > +#define  XPCS1_RX_REF_LD_VAL_MASK            GENMASK(14, 8)
> > > +
> > >  #define S32G_SS_RW_REG_0                     0xF0
> > >  #define  SUBMODE_MASK                                GENMASK(3, 0)
> > >  #define  CLKEN_MASK                          BIT(23)
> > > @@ -44,6 +92,9 @@
> > >
> > >  #define S32G_PHY_REG_DATA                    0x4
> > >
> > > +#define S32G_PHY_RST_CTRL                    0x8
> > > +#define  WARM_RST                            BIT(1)
> > > +
> > >  #define RAWLANE0_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN   0x3019
> > >  #define RAWLANE1_DIG_PCS_XF_RX_EQ_DELTA_IQ_OVRD_IN   0x3119
> > >
> > > @@ -76,16 +127,33 @@ struct s32g_pcie_ctrl {
> > >       bool powered_on;
> > >  };
> > >
> > > +struct s32g_xpcs_ctrl {
> > > +     struct s32g_xpcs *phys[2];
> > > +     void __iomem *base0, *base1;
> > > +};
> > > +
> > >  struct s32g_serdes {
> > >       struct s32g_serdes_ctrl ctrl;
> > >       struct s32g_pcie_ctrl pcie;
> > > +     struct s32g_xpcs_ctrl xpcs;
> > >       struct device *dev;
> > > +     u8 lanes_status;
> > >  };
> > >
> > >  /* PCIe phy subsystem */
> > >
> > >  #define S32G_SERDES_PCIE_FREQ                        (100 * HZ_PER_M=
HZ)
> > >
> > > +static void s32g_pcie_phy_reset(struct s32g_serdes *serdes)
> > > +{
> > > +     u32 val;
> > > +
> > > +     val =3D readl(serdes->pcie.phy_base + S32G_PHY_RST_CTRL);
> > > +     writel(val | WARM_RST, serdes->pcie.phy_base + S32G_PHY_RST_CTR=
L);
> > > +     usleep_range(1000, 1100);
> > > +     writel(val, serdes->pcie.phy_base + S32G_PHY_RST_CTRL);
> > > +}
> > > +
> > >  static int s32g_pcie_check_clk(struct s32g_serdes *serdes)
> > >  {
> > >       struct s32g_serdes_ctrl *sctrl =3D &serdes->ctrl;
> > > @@ -277,6 +345,192 @@ static struct phy *s32g_serdes_phy_xlate(struct=
 device *dev,
> > >       return phy;
> > >  }
> > >
> > > +/* XPCS subsystem */
> > > +
> > > +static int s32g_serdes_xpcs_init(struct s32g_serdes *serdes, int id)
> > > +{
> > > +     struct s32g_serdes_ctrl *ctrl =3D &serdes->ctrl;
> > > +     struct s32g_xpcs_ctrl *xpcs =3D &serdes->xpcs;
> > > +     enum s32g_xpcs_shared shared =3D NOT_SHARED;
> > > +     unsigned long rate =3D ctrl->ref_clk_rate;
> > > +     struct device *dev =3D serdes->dev;
> > > +     void __iomem *base;
> > > +
> > > +     if (!id)
> > > +             base =3D xpcs->base0;
> > > +     else
> > > +             base =3D xpcs->base1;
> > > +
> > > +     if (ctrl->ss_mode =3D=3D 1 || ctrl->ss_mode =3D=3D 2)
> > > +             shared =3D PCIE_XPCS_1G;
> > > +     else if (ctrl->ss_mode =3D=3D 5)
> > > +             shared =3D PCIE_XPCS_2G5;
> > > +
> > > +     return s32g_xpcs_init(xpcs->phys[id], dev, id, base,
> > > +                            ctrl->ext_clk, rate, shared);
> > > +}
> > > +
> > > +static void s32g_serdes_prepare_pma_mode5(struct s32g_serdes *serdes=
)
> > > +{
> > > +     u32 val;
> > > +     /* Configure TX_VBOOST_LVL and TX_TERM_CTRL */
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTR=
L_2);
> > > +     val &=3D ~(EXT_TX_VBOOST_LVL_MASK | EXT_TX_TERM_CTRL_MASK);
> > > +     val |=3D FIELD_PREP(EXT_TX_VBOOST_LVL_MASK, 0x3) |
> > > +             FIELD_PREP(EXT_TX_TERM_CTRL_MASK, 0x4);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_=
2);
> > > +
> > > +     /* Enable phy external control */
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_CTRL_SEL=
);
> > > +     val |=3D EXT_PHY_CTRL_SEL;
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_CTRL_SEL);
> > > +
> > > +     /* Configure ref range, disable PLLB/ref div2 */
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_REF_CLK_CTRL=
);
> > > +     val &=3D ~(REF_CLK_DIV2_EN | REF_CLK_MPLLB_DIV2_EN | EXT_REF_RA=
NGE_MASK);
> > > +     val |=3D FIELD_PREP(EXT_REF_RANGE_MASK, 0x3);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_REF_CLK_CTRL);
> > > +
> > > +     /* Configure multiplier */
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CT=
RL_2);
> > > +     val &=3D ~(MPLLB_MULTIPLIER_MASK | EXT_MPLLB_FRACN_CTRL_MASK | =
BIT(24) | BIT(28));
> > > +     val |=3D FIELD_PREP(MPLLB_MULTIPLIER_MASK, 0x27U) |
> > > +             FIELD_PREP(EXT_MPLLB_FRACN_CTRL_MASK, 0x414);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL=
_2);
> > > +
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_MPLLB_CTRL);
> > > +     val &=3D ~MPLLB_SSC_EN;
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_MPLLB_CTRL);
> > > +
> > > +     /* Configure tx lane division, disable word clock div2*/
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CT=
RL_3);
> > > +     val &=3D ~(EXT_MPLLB_WORD_DIV2_EN | EXT_MPLLB_TX_CLK_DIV_MASK);
> > > +     val |=3D FIELD_PREP(EXT_MPLLB_TX_CLK_DIV_MASK, 0x5);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL=
_3);
> > > +
> > > +     /* Configure bandwidth for filtering and div10*/
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CT=
RL_1);
> > > +     val &=3D ~(EXT_MPLLB_BANDWIDTH_MASK | EXT_MPLLB_DIV_CLK_EN |
> > > +              EXT_MPLLB_DIV8_CLK_EN | EXT_MPLLB_DIV_MULTIPLIER_MASK)=
;
> > > +     val |=3D FIELD_PREP(EXT_MPLLB_BANDWIDTH_MASK, 0x5f) | EXT_MPLLB=
_DIV10_CLK_EN;
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLB_CTRL=
_1);
> > > +
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLA_CT=
RL_1);
> > > +     val &=3D ~(EXT_MPLLA_BANDWIDTH_MASK);
> > > +     val |=3D FIELD_PREP(EXT_MPLLA_BANDWIDTH_MASK, 0xc5);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MPLLA_CTRL=
_1);
> > > +
> > > +     /* Configure VCO */
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_XPCS1_RX_OVR=
D_CTRL);
> > > +     val &=3D ~(XPCS1_RX_VCO_LD_VAL_MASK | XPCS1_RX_REF_LD_VAL_MASK)=
;
> > > +     val |=3D FIELD_PREP(XPCS1_RX_VCO_LD_VAL_MASK, 0x540) |
> > > +             FIELD_PREP(XPCS1_RX_REF_LD_VAL_MASK, 0x2b);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_XPCS1_RX_OVRD_=
CTRL);
> > > +
> > > +     /* Boundary scan control */
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_BS_CTRL)=
;
> > > +     val &=3D ~(EXT_BS_RX_LEVEL_MASK | EXT_BS_TX_LOWSWING);
> > > +     val |=3D FIELD_PREP(EXT_BS_RX_LEVEL_MASK, 0xB) | EXT_BS_RX_BIGS=
WING;
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_BS_CTRL);
> > > +
> > > +     /* Rx loss threshold */
> > > +     val =3D readl(serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTR=
L_1);
> > > +     val &=3D ~(EXT_RX_LOS_THRESHOLD_MASK | EXT_RX_VREF_CTRL_MASK);
> > > +     val |=3D FIELD_PREP(EXT_RX_LOS_THRESHOLD_MASK, 0x3U) |
> > > +             FIELD_PREP(EXT_RX_VREF_CTRL_MASK, 0x11U);
> > > +     writel(val, serdes->ctrl.ss_base + S32G_PCIE_PHY_EXT_MISC_CTRL_=
1);
> > > +}
> > > +
> > > +static int s32g_serdes_enable_mode5(struct s32g_serdes *serdes, stru=
ct s32g_xpcs *xpcs)
> > > +{
> > > +     int ret;
> > > +
> > > +     s32g_serdes_prepare_pma_mode5(serdes);
> > > +
> > > +     ret =3D s32g_xpcs_pre_pcie_2g5(xpcs);
> > > +     if (ret) {
> > > +             dev_err(serdes->dev,
> > > +                     "Failed to prepare SerDes for PCIE & XPCS @ 2G5=
 mode\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     s32g_pcie_phy_reset(serdes);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int s32g_serdes_init_clks(struct s32g_serdes *serdes)
> > > +{
> > > +     struct s32g_serdes_ctrl *ctrl =3D &serdes->ctrl;
> > > +     struct s32g_xpcs_ctrl *xpcs =3D &serdes->xpcs;
> > > +     struct s32g_xpcs *order[2];
> > > +     size_t i;
> > > +     int ret;
> > > +
> > > +     switch (ctrl->ss_mode) {
> > > +     case 0:
> > > +             return 0;
> > > +     case 1:
> > > +             order[0] =3D xpcs->phys[0];
> > > +             order[1] =3D NULL;
> > > +             break;
> > > +     case 2:
> > > +     case 5:
> > > +             order[0] =3D xpcs->phys[1];
> > > +             order[1] =3D NULL;
> > > +             break;
> > > +     case 3:
> > > +             order[0] =3D xpcs->phys[1];
> > > +             order[1] =3D xpcs->phys[0];
> > > +             break;
> > > +     case 4:
> > > +             order[0] =3D xpcs->phys[0];
> > > +             order[1] =3D xpcs->phys[1];
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(order); i++) {
> > > +             if (!order[i])
> > > +                     continue;
> > > +
> > > +             ret =3D s32g_xpcs_init_plls(order[i]);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(order); i++) {
> > > +             if (!order[i])
> > > +                     continue;
> > > +
> > > +             if (ctrl->ss_mode =3D=3D 5) {
> > > +                     ret =3D s32g_serdes_enable_mode5(serdes, order[=
i]);
> > > +                     if (ret)
> > > +                             return ret;
> > > +             } else {
> > > +                     s32g_xpcs_vreset(order[i]);
> > > +             }
> > > +     }
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(order); i++) {
> > > +             if (!order[i])
> > > +                     continue;
> > > +
> > > +             ret =3D s32g_xpcs_wait_vreset(order[i]);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret =3D s32g_xpcs_reset_rx(order[i]);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             s32g_xpcs_disable_an(order[i]);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /* Serdes subsystem */
> > >
> > >  static int s32g_serdes_assert_reset(struct s32g_serdes *serdes)
> > > @@ -331,6 +585,10 @@ static int s32g_serdes_init(struct s32g_serdes *=
serdes)
> > >               return ret;
> > >       }
> > >
> > > +     /*
> > > +      * We have a tight timing for the init sequence and any delay l=
inked to
> > > +      * printk as an example can fail the init after reset
> > > +      */
> > >       ret =3D s32g_serdes_assert_reset(serdes);
> > >       if (ret)
> > >               goto disable_clks;
> > > @@ -363,7 +621,13 @@ static int s32g_serdes_init(struct s32g_serdes *=
serdes)
> > >       dev_info(serdes->dev, "Using mode %d for SerDes subsystem\n",
> > >                ctrl->ss_mode);
> > >
> > > -     return 0;
> > > +     ret =3D s32g_serdes_init_clks(serdes);
> > > +     if (ret) {
> > > +             dev_err(serdes->dev, "XPCS init failed\n");
> > > +             goto disable_clks;
> > > +     }
> > > +
> > > +     return ret;
> > >
> > >  disable_clks:
> > >       clk_bulk_disable_unprepare(serdes->ctrl.nclks,
> > > @@ -449,12 +713,32 @@ static int s32g_serdes_get_pcie_resources(struc=
t platform_device *pdev, struct s
> > >       return 0;
> > >  }
> > >
> > > +static int s32g_serdes_get_xpcs_resources(struct platform_device *pd=
ev, struct s32g_serdes *serdes)
> > > +{
> > > +     struct s32g_xpcs_ctrl *xpcs =3D &serdes->xpcs;
> > > +     struct device *dev =3D &pdev->dev;
> > > +
> > > +     xpcs->base0 =3D devm_platform_ioremap_resource_byname(pdev, "xp=
cs0");
> > > +     if (IS_ERR(xpcs->base0)) {
> > > +             dev_err(dev, "Failed to map 'xpcs0'\n");
> > > +             return PTR_ERR(xpcs->base0);
> > > +     }
> > > +
> > > +     xpcs->base1 =3D devm_platform_ioremap_resource_byname(pdev, "xp=
cs1");
> > > +     if (IS_ERR(xpcs->base1)) {
> > > +             dev_err(dev, "Failed to map 'xpcs1'\n");
> > > +             return PTR_ERR(xpcs->base1);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int s32g2_serdes_create_phy(struct s32g_serdes *serdes, struc=
t device_node *child_node)
> > >  {
> > >       struct s32g_serdes_ctrl *ctrl =3D &serdes->ctrl;
> > >       struct phy_provider *phy_provider;
> > >       struct device *dev =3D serdes->dev;
> > > -     int ss_mode =3D ctrl->ss_mode;
> > > +     int ret, ss_mode =3D ctrl->ss_mode;
> > >       struct phy *phy;
> > >
> > >       if (of_device_is_compatible(child_node, "nxp,s32g2-serdes-pcie-=
phy")) {
> > > @@ -476,6 +760,37 @@ static int s32g2_serdes_create_phy(struct s32g_s=
erdes *serdes, struct device_nod
> > >               if (IS_ERR(phy_provider))
> > >                       return PTR_ERR(phy_provider);
> > >
> > > +     } else if (of_device_is_compatible(child_node, "nxp,s32g2-serde=
s-xpcs")) {
> > > +             struct s32g_xpcs_ctrl *xpcs_ctrl =3D &serdes->xpcs;
> > > +             struct s32g_xpcs *xpcs;
> > > +             int port;
> > > +
> > > +             /* no Ethernet phy lane */
> > > +             if (ss_mode =3D=3D 0)
> > > +                     return 0;
> > > +
> > > +             /* Get XPCS port number connected to the lane */
> > > +             if (of_property_read_u32(child_node, "reg", &port))
> > > +                     return -EINVAL;
> > > +
> > > +             /* XPCS1 is not used */
> > > +             if (ss_mode =3D=3D 1 && port =3D=3D 1)
> > > +                     return -EINVAL;
> > > +
> > > +             /* XPCS0 is not used */
> > > +             if (ss_mode =3D=3D 2 && port =3D=3D 0)
> > > +                     return -EINVAL;
> > > +
> > > +             xpcs =3D devm_kmalloc(dev, sizeof(*xpcs), GFP_KERNEL);
> > > +             if (!xpcs)
> > > +                     return -ENOMEM;
> > > +
> > > +             xpcs_ctrl->phys[port] =3D xpcs;
> > > +
> > > +             ret =3D s32g_serdes_xpcs_init(serdes, port);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > >       } else {
> > >               dev_warn(dev, "Skipping unknown child node %pOFn\n", ch=
ild_node);
> > >       }
> > > @@ -517,6 +832,10 @@ static int s32g_serdes_probe(struct platform_dev=
ice *pdev)
> > >       if (ret)
> > >               return ret;
> > >
> > > +     ret =3D s32g_serdes_get_xpcs_resources(pdev, serdes);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       ret =3D s32g_serdes_parse_lanes(dev, serdes);
> > >       if (ret)
> > >               return ret;
> > > @@ -555,6 +874,57 @@ static int __maybe_unused s32g_serdes_resume(str=
uct device *device)
> > >       return ret;
> > >  }
> > >
> > > +struct phylink_pcs *s32g_serdes_pcs_create(struct device *dev, struc=
t device_node *np)
> > > +{
> > > +     struct platform_device *pdev;
> > > +     struct device_node *pcs_np;
> > > +     struct s32g_serdes *serdes;
> > > +     u32 port;
> > > +
> > > +     if (of_property_read_u32(np, "reg", &port))
> > > +             return ERR_PTR(-EINVAL);
> > > +
> > > +     if (port >=3D S32G_SERDES_XPCS_MAX)
> > > +             return ERR_PTR(-EINVAL);
> > > +
> > > +     /* The PCS pdev is attached to the parent node */
> > > +     pcs_np =3D of_get_parent(np);
> > > +     if (!pcs_np)
> > > +             return ERR_PTR(-ENODEV);
> > > +
> > > +     if (!of_device_is_available(pcs_np)) {
> > > +             of_node_put(pcs_np);
> > > +             return ERR_PTR(-ENODEV);
> > > +     }
> > > +
> > > +     pdev =3D of_find_device_by_node(pcs_np);
> > > +     of_node_put(pcs_np);
> > > +     if (!pdev)
> > > +             return ERR_PTR(-EPROBE_DEFER);
> > > +
> > > +     serdes =3D platform_get_drvdata(pdev);
> > > +     if (!serdes) {
> > > +             put_device(&pdev->dev);
> > > +             return ERR_PTR(-EPROBE_DEFER);
> > > +     }
> > > +
> > > +     if (!serdes->xpcs.phys[port]) {
> > > +             put_device(&pdev->dev);
> > > +             return ERR_PTR(-EPROBE_DEFER);
> > > +     }
> > > +
> > > +     return &serdes->xpcs.phys[port]->pcs;
> > > +}
> > > +EXPORT_SYMBOL(s32g_serdes_pcs_create);
> > > +
> > > +void s32g_serdes_pcs_destroy(struct phylink_pcs *pcs)
> > > +{
> > > +     struct s32g_xpcs *xpcs =3D phylink_pcs_to_s32g_xpcs(pcs);
> > > +
> > > +     put_device(xpcs->dev);
> > > +}
> > > +EXPORT_SYMBOL(s32g_serdes_pcs_destroy);
> > > +
> > >  static const struct of_device_id s32g_serdes_match[] =3D {
> > >       {
> > >               .compatible =3D "nxp,s32g2-serdes",
> > > diff --git a/include/linux/pcs/pcs-nxp-s32g-xpcs.h b/include/linux/pc=
s/pcs-nxp-s32g-xpcs.h
> > > new file mode 100644
> > > index 000000000000..96a0049b93a6
> > > --- /dev/null
> > > +++ b/include/linux/pcs/pcs-nxp-s32g-xpcs.h
> > > @@ -0,0 +1,50 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/**
> > > + * Copyright 2021-2026 NXP
> > > + */
> > > +#ifndef PCS_NXP_S32G_XPCS_H
> > > +#define PCS_NXP_S32G_XPCS_H
> > > +
> > > +#include <linux/phylink.h>
> > > +
> > > +enum s32g_xpcs_shared {
> > > +     NOT_SHARED,
> > > +     PCIE_XPCS_1G,
> > > +     PCIE_XPCS_2G5,
> > > +};
> > > +
> > > +enum s32g_xpcs_pll {
> > > +     XPCS_PLLA,      /* Slow PLL */
> > > +     XPCS_PLLB,      /* Fast PLL */
> > > +};
> > > +
> > > +struct s32g_xpcs {
> > > +     void __iomem *base;
> > > +     struct device *dev;
> > > +     unsigned char id;
> > > +     struct regmap *regmap;
> > > +     enum s32g_xpcs_pll ref;
> > > +     bool ext_clk;
> > > +     bool mhz125;
> > > +     enum s32g_xpcs_shared pcie_shared;
> > > +     struct phylink_pcs pcs;
> > > +};
> > > +
> > > +#define phylink_pcs_to_s32g_xpcs(pl_pcs) \
> > > +     container_of((pl_pcs), struct s32g_xpcs, pcs)
> > > +
> > > +int s32g_xpcs_init(struct s32g_xpcs *xpcs, struct device *dev,
> > > +                unsigned char id, void __iomem *base, bool ext_clk,
> > > +                unsigned long rate, enum s32g_xpcs_shared pcie_share=
d);
> > > +int s32g_xpcs_init_plls(struct s32g_xpcs *xpcs);
> > > +int s32g_xpcs_pre_pcie_2g5(struct s32g_xpcs *xpcs);
> > > +void s32g_xpcs_vreset(struct s32g_xpcs *xpcs);
> > > +int s32g_xpcs_wait_vreset(struct s32g_xpcs *xpcs);
> > > +int s32g_xpcs_reset_rx(struct s32g_xpcs *xpcs);
> > > +void s32g_xpcs_disable_an(struct s32g_xpcs *xpcs);
> > > +
> > > +struct phylink_pcs *s32g_serdes_pcs_create(struct device *dev, struc=
t device_node *np);
> > > +void s32g_serdes_pcs_destroy(struct phylink_pcs *pcs);
> > > +
> > > +#endif /* PCS_NXP_S32G_XPCS_H */
> > > +
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>


