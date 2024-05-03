Return-Path: <netdev+bounces-93192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420028BA802
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEF81F21380
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0145139CF1;
	Fri,  3 May 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iJyz60oM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BAB1474CF
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722260; cv=none; b=ANYadycyKafODIUkXshJ+jobRvACUmSAWbdkmJc7pLm+FwRfvpbTGF1w32q0PuozKXE6PZLexCMS5HhsQ40Ckfm/tXciXXM79eAY90K7ZHUm5PriX1PslXWXeU/YbPcuhIR26SCnoA2X9wRj9xFkLRVKP1dF9nkitAJPRAXUAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722260; c=relaxed/simple;
	bh=2zRAqAVRpoB8VovR5yi3XXB5XFTz7TdQO1H+uK96JJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxqx/ltBW6JK0SpB0A14ouro0UeqyWfnkUdrZqTTkg6/vF+DDftwWpW4l+4aLVy77xSkoTqtChdWfrb/QzI71MM4edfWPggAZqzfINY8Ne8/RnzVnu5BSeblzd3Y12PiPN/nuyIZgNIZWRDGde0xJOWNN2jMhuXu2yZapOYuJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iJyz60oM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBCB9424A0
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714722255;
	bh=HQocY+zIiybxmg572V2oftlBH1WtE88jZjblSyh+67E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=iJyz60oM3SH1R7K98X9ir0hOYo345rqXnopVU6w4o9PWnv6IeOLWhHBV3HbRssaHZ
	 eTwxTOgvjP2/6BJKT+5HflAIYmctcXnpFQUzrk0Y9m8Fo6UQFZa/x3Wv3lUrj76WpZ
	 XTqygFJfj7Nb2Bi0Vm0iRLjXAZkDRWfkU8+FW9ZyhLRVQyXH3KLC6fLZ8UlbxX2dG+
	 DFrQmPj4nqpqST9vYaSkDnBF8qIHf3rPTi///h4SJkwsRUdMpTpViEzr+WQeGWB6/T
	 7QpYnJN38s7Hq1xc2eOKpwmDi/HtWfoLXriH025XfIB0C8hKBJSlXfodlZVPTDxpAA
	 Zy94NoZqT/CWQ==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34dce5456c3so1946072f8f.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 00:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714722255; x=1715327055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQocY+zIiybxmg572V2oftlBH1WtE88jZjblSyh+67E=;
        b=mplZZx9bFDkOCmRj0kFa4BhbiLc4Ksd5GC4slOr4NzCJF7UsdvPyGtnQBhRCRyOV7n
         Eu5A92tXYxwCWwfU2cX8hP1Aenuuc35d0j1BcQm7iluCOogdkHq/uc0nENd4faEHnnw1
         dpQARdsXpUP880DkIrk1k064HOtaZYCbyMZ1Y0uy8fK2sRNMDJzBuJqstDwSBw9NkS32
         VCNrkbqzQfwnCKqCJ0KL8yZmESip2UjDObdaSPG8f6U37oKKzErK9rk0ljOw1PbKWulQ
         rD71hsJO2zH9eGqMv3q4tabYPoadhy7DBYEMU68d3Yk5EITRZz6D+IlzeMRmerVZV5B+
         Bk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIFllFb+2bQUM6/e0n/180CvIH+JvWMMB+uhv2mN6XzuNrrk/p4UfQXUsxckAPdi87RnLqibi0RUi8a61a7WTZpLCsp6Pp
X-Gm-Message-State: AOJu0YwqMbyBw2bEBdrdLo3XccB1IH0RNJQbHjRsDamo343H7QPdux5V
	V1Ffijpwm3kj7+fhuJUivcfOkfEeQ5ftRoRqk01rffIXikk3rZJBKHer2NfjG2DyWk1P4w8349M
	THeob63jLONK8h+FgVzFH9K8B4QMF+JOr8Ti+g0Q40b2pooB/hYWYaYjzMoP67dG/ixflrr54un
	AfbTJaqTkew+cSmDgEcSnb3n3MALOESs67k9hC9FsCPyzv
X-Received: by 2002:a05:6000:112:b0:34c:fd73:55d with SMTP id o18-20020a056000011200b0034cfd73055dmr1722869wrx.70.1714722255534;
        Fri, 03 May 2024 00:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHShT4u1aVmW6SGvB2TY5tSgwQwi7lin2dyXVmQGaomNM8W6zmFoTjKiJLXEOTsSv0jrb2dbsuiZNCqCaVckFY=
X-Received: by 2002:a05:6000:112:b0:34c:fd73:55d with SMTP id
 o18-20020a056000011200b0034cfd73055dmr1722849wrx.70.1714722255134; Fri, 03
 May 2024 00:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502091215.13068-1-en-wei.wu@canonical.com> <4bd85100-0f3d-4e38-973c-e6938f304dde@molgen.mpg.de>
In-Reply-To: <4bd85100-0f3d-4e38-973c-e6938f304dde@molgen.mpg.de>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Fri, 3 May 2024 15:44:04 +0800
Message-ID: <CAMqyJG3mD0bcPoZg5ay-3PqgPvCR1OaraE6X00kH1QRTE3XNMw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: fix link fluctuations problem
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org, 
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Paul Menzel,

Thank you for your quick response.

> Do you mean ho*t*-plugging?
> Increas*ing*?

Yes, sorry about the misspelling.

> Could you please document what NICs you saw this
Yes. I saw this in Intel I219-LM. I haven't seen this bug on other NICs.

> and if it is documented in any datasheet/errata?
No, we couldn't find any datasheet/errata documenting this.

> Does this have any downsides on systems with non-buggy hardware?
No, I've tested other non-buggy hardwares (like I219-V) and it has no
effect on them.

>Could you please split this hunk into a separate patch?
Sure! I'll send the v2 patchset soon.

> Are there any other  public bug reports and discussions you could referen=
ce?
No. We have an internal private bug report but it cannot be exposed to
the public.

Thank you for your time.

On Fri, 3 May 2024 at 13:34, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> [Fix address jesse.brandeburg@intel.co*m*]
>
>
> Dear Ricky,
>
>
> Thank you for your patch.
>
>
> Am 02.05.24 um 11:12 schrieb Ricky Wu:
> > As described in https://bugzilla.kernel.org/show_bug.cgi?id=3D218642,
> > some e1000e NIC reports link up -> link down -> link up when hog-pluggi=
ng
>
> Do you mean ho*t*-plugging?
>
> > the Ethernet cable.
> >
> > The problem is because the unstable behavior of Link Status bit in
> > PHY Status Register of some e1000e NIC. When we re-plug the cable,
> > the e1000e_phy_has_link_generic() (called after the Link-Status-Changed
> > interrupt) has read this bit with 1->0->1 (1=3Dlink up, 0=3Dlink down)
> > and e1000e reports it to net device layer respectively.
>
> Wow. I guess this was =E2=80=9Cfun=E2=80=9D to debug. Could you please do=
cument, what
> NICs you saw this, and if it is documented in any datasheet/errata?
>
> > This patch solves the problem by passing polling delays on
> > e1000e_phy_has_link_generic() so that it will not get the unstable
> > states of Link Status bit.
>
> Does this have any downsides on systems with non-buggy hardware?
>
> > Also, the sleep codes in e1000e_phy_has_link_generic() only take
> > effect when error occurs reading the MII register. Moving these codes
> > forward to the beginning of the loop so that the polling delays passed
> > into this function can take effect on any situation.
>
> Could you please split this hunk into a separate patch?
>
> Should it Fixes: tag be added?
>
> Are there any other  public bug reports and discussions you could referen=
ce?
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218642
>
> > Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/ich8lan.c |  5 ++++-
> >   drivers/net/ethernet/intel/e1000e/phy.c     | 10 ++++++----
> >   2 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/=
ethernet/intel/e1000e/ich8lan.c
> > index f9e94be36e97..c462aa6e6dee 100644
> > --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> > +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> > @@ -1427,8 +1427,11 @@ static s32 e1000_check_for_copper_link_ich8lan(s=
truct e1000_hw *hw)
> >       /* First we want to see if the MII Status Register reports
> >        * link.  If so, then we want to get the current speed/duplex
> >        * of the PHY.
> > +      * Some PHYs have link fluctuations with the instability of
> > +      * Link Status bit (BMSR_LSTATUS) in MII Status Register.
> > +      * Increase the iteration times and delay solves the problem.
>
> Increas*ing*?
>
> >        */
> > -     ret_val =3D e1000e_phy_has_link_generic(hw, 1, 0, &link);
> > +     ret_val =3D e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT,=
 100000, &link);
>
> Could you please document how 100000 was chosen?
>
> >       if (ret_val)
> >               goto out;
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethe=
rnet/intel/e1000e/phy.c
> > index 93544f1cc2a5..ef056363d721 100644
> > --- a/drivers/net/ethernet/intel/e1000e/phy.c
> > +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> > @@ -1776,7 +1776,13 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw =
*hw, u32 iterations,
> >       u16 i, phy_status;
> >
> >       *success =3D false;
> > +
> >       for (i =3D 0; i < iterations; i++) {
> > +             if (usec_interval >=3D 1000)
> > +                     msleep(usec_interval / 1000);
> > +             else
> > +                     udelay(usec_interval);
> > +
> >               /* Some PHYs require the MII_BMSR register to be read
> >                * twice due to the link bit being sticky.  No harm doing
> >                * it across the board.
> > @@ -1799,10 +1805,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw =
*hw, u32 iterations,
> >                       *success =3D true;
> >                       break;
> >               }
> > -             if (usec_interval >=3D 1000)
> > -                     msleep(usec_interval / 1000);
> > -             else
> > -                     udelay(usec_interval);
> >       }
> >
> >       return ret_val;

