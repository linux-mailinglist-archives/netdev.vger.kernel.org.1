Return-Path: <netdev+bounces-131181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561E98D13C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C9F1F21FFD
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B411CEE8C;
	Wed,  2 Oct 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mg99wq2p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF819F411
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865010; cv=none; b=BtGoxMF3xKJK2lbVcYUFXlcsQzJTIA1x20n8Djj9sMPzUZXhiVGnIp149IwPvcNRELTzskqXVPrFM9HFqrVgFmQdnJDdzAsF0R9XVU0i5nhIgSoB7MXkY6EedWGuyKVbPEx3P3VoVV3AVBfSy5gxtPYqlGnOokPDvF3xI4UNHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865010; c=relaxed/simple;
	bh=3KtMErPbUORk0gi/pVF+G5onLyWubADV0qzxibLAA9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNRkLujTnG/+LH/rsFlNsDR/qh6luYWGI3w2fynkuexgFfDW3OJOcRmfHefBrWdegvi1GHQIeuA1yR7wGK4WZE49FPnwbCfBgsXVaRPUJI6fTm8l4/PyxiRF7mApDFM4woLbU9UulRzG76Oam0AuRYHT4c71MQuPEXTI8CZPFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mg99wq2p; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so4828290a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727865007; x=1728469807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xNP//aqN50/n/1vN79BgZWUhqjvjJj81UsRURKsrok=;
        b=Mg99wq2pd9MuX+BKA5HKh5y/ryfZ7mVyULc1Lii+ad+eNAFyhnjT/SxNHO0KSI3/9a
         p9553jLoBNzNQz0EHyJRl7f1PfGSuIxTkkeqVBfzMjaaRIKj1uBIi5e6TgZTrTR3EmVc
         Rs/MIY/kj5dZAPZqzABCTfR0lndbpCSM0SJALjpPSx3Ecq/corSno/kvJ0hMqrNdu1w0
         JrojrE20Wg/STDTH1l1YvwxnrF/rPThd43l3VdSKhpG9XtagaVuKHKnnVc/Rfx+/viYf
         8ZnafidCIgkjGMXDEV5wdfBvkoBgRaW1zh1+utrPGh7ljMt5f76y/Y5YU4wowbc1d/OK
         RwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727865007; x=1728469807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xNP//aqN50/n/1vN79BgZWUhqjvjJj81UsRURKsrok=;
        b=SkoWWPfjvfCV7F+MWWxiMH7lTnhf+A50POz4H6g0dnuQA00NNKNh75R/mdl8CJGW/P
         LVxjKtt3SvPY5Alo8by9MVq1CZPTkbKjN4iu6gyYKMh4yUFfBojoOUioEqKhNhvcVlgm
         GR2+YDMtA0c5MaEcuxi9T9JlD6zqkToCLIeSXbD/a4lUYdshgFwlNQq16ZFHdPAHU0Sv
         AdU3ymi/PP0m+6pA31OkrdEqY13F5yKGVZjSohIqf20Dodytip/zGg1KrR4wEwIcSQos
         NEn3dIfZL+jf0AVu91VwfW2qU/8IP3ZJPzm1njIxSaTyRk/y8/YI2s9/0AwGeJH2iKXa
         5S0g==
X-Forwarded-Encrypted: i=1; AJvYcCXDsIcz6RfYEi0IYUcrFFtee7kpjh9PmwdQi8ULB7Zv1X++P7G1srh5rY+636QJfrkkM77tVg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymR0JcwCVh8TxDN6H1Z/4KwQeue33N40Koo/+g8Yk/H/tpSzib
	kquwDfYC4Zo0aP89Z17l8tQrb4GczFat1YOT6KMwuFaNX0BiWl4z8RUK8/tsGbCM/uRJdCOQyLo
	SIDlR5eLL/bkDxSTXx73mPh8Rav7VMQFskYVg
X-Google-Smtp-Source: AGHT+IHkpYrjjnPVio26e3oFWVJx5GHb3g5HzTPkNScoupat43WqGYuMW8YVFS6XMiaWWT7fumRLsRfo+KwCL6Y91J0=
X-Received: by 2002:a05:6402:34d4:b0:5c8:8626:e41 with SMTP id
 4fb4d7f45d1cf-5c8b18ad41bmr1712168a12.4.1727865007067; Wed, 02 Oct 2024
 03:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002041844.8243-1-kerneljasonxing@gmail.com>
 <CANn89iLVRPHQ0TzWWOs8S1hA5Uwck_j=tPAQquv+qDf8bMkmYQ@mail.gmail.com> <CAL+tcoA6YCkYvFJkpbmSuT=MVn_81KmJQyMYtojKC5kBFZvqfw@mail.gmail.com>
In-Reply-To: <CAL+tcoA6YCkYvFJkpbmSuT=MVn_81KmJQyMYtojKC5kBFZvqfw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 12:29:53 +0200
Message-ID: <CANn89iKr2J3S-Oni9VT0-C5K0EOFdnX8eR_aRueNx2R+0f8fKA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net-timestamp: namespacify the sysctl_tstamp_allow_data
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:27=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Wed, Oct 2, 2024 at 4:41=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Oct 2, 2024 at 6:18=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Let it be tuned in per netns by admins.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > v2
> > > Link: https://lore.kernel.org/all/66fa81b2ddf10_17948d294bb@willemb.c=
.googlers.com.notmuch/
> > > 1. remove the static global from sock.c
> > > 2. reorder the tests
> > > 3. I removed the patch [1/3] because I made one mistake
> > > 4. I also removed the patch [2/3] because Willem soon will propose a
> > > packetdrill test that is better.
> > > Now, I only need to write this standalone patch.
> > > ---
> > >  include/net/netns/core.h   |  1 +
> > >  include/net/sock.h         |  2 --
> > >  net/core/net_namespace.c   |  1 +
> > >  net/core/skbuff.c          |  2 +-
> > >  net/core/sock.c            |  2 --
> > >  net/core/sysctl_net_core.c | 18 +++++++++---------
> > >  6 files changed, 12 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> > > index 78214f1b43a2..ef8b3105c632 100644
> > > --- a/include/net/netns/core.h
> > > +++ b/include/net/netns/core.h
> > > @@ -23,6 +23,7 @@ struct netns_core {
> > >  #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
> > >         struct cpumask *rps_default_mask;
> > >  #endif
> > > +       int     sysctl_tstamp_allow_data;
> > >  };
> >
> > This adds another hole for no good reason.
> > Please put this after sysctl_txrehash.
>
> Thanks for your reminder.
>
> Before this patch:
> struct netns_core {
>         struct ctl_table_header *  sysctl_hdr;           /*     0   0x8 *=
/
>         int                        sysctl_somaxconn;     /*   0x8   0x4 *=
/
>         int                        sysctl_optmem_max;    /*   0xc   0x4 *=
/
>         u8                         sysctl_txrehash;      /*  0x10   0x1 *=
/
>
>         /* XXX 7 bytes hole, try to pack */
>
>         struct prot_inuse *        prot_inuse;           /*  0x18   0x8 *=
/
>         struct cpumask *           rps_default_mask;     /*  0x20   0x8 *=
/
>
>         /* size: 40, cachelines: 1, members: 6 */
>         /* sum members: 33, holes: 1, sum holes: 7 */
>         /* last cacheline: 40 bytes */
> };
>
> After this patch:
> struct netns_core {
>         struct ctl_table_header *  sysctl_hdr;           /*     0   0x8 *=
/
>         int                        sysctl_somaxconn;     /*   0x8   0x4 *=
/
>         int                        sysctl_optmem_max;    /*   0xc   0x4 *=
/
>         u8                         sysctl_txrehash;      /*  0x10   0x1 *=
/
>
>         /* XXX 7 bytes hole, try to pack */
>
>         struct prot_inuse *        prot_inuse;           /*  0x18   0x8 *=
/
>         struct cpumask *           rps_default_mask;     /*  0x20   0x8 *=
/
>         int                        sysctl_tstamp_allow_data; /*  0x28   0=
x4 */
>
>         /* size: 48, cachelines: 1, members: 7 */
>         /* sum members: 37, holes: 1, sum holes: 7 */
>         /* padding: 4 */
>         /* last cacheline: 48 bytes */
> };
>
> See this line "/* sum members: 37, holes: 1, sum holes: 7 */", so I
> don't think I introduce a new hole here.

You certainly did.  /* padding: 4 */

Overall size grew by 8 bytes, while adding one 4 byte field.

>
> After trying the suggestion you mentioned, the sum holes decreases from 7=
 to 3:
> struct netns_core {
>         struct ctl_table_header *  sysctl_hdr;           /*     0   0x8 *=
/
>         int                        sysctl_somaxconn;     /*   0x8   0x4 *=
/
>         int                        sysctl_optmem_max;    /*   0xc   0x4 *=
/
>         u8                         sysctl_txrehash;      /*  0x10   0x1 *=
/
>
>         /* XXX 3 bytes hole, try to pack */
>
>         int                        sysctl_tstamp_allow_data; /*  0x14   0=
x4 */
>         struct prot_inuse *        prot_inuse;           /*  0x18   0x8 *=
/
>         struct cpumask *           rps_default_mask;     /*  0x20   0x8 *=
/
>
>         /* size: 40, cachelines: 1, members: 7 */
>         /* sum members: 37, holes: 1, sum holes: 3 */
>         /* last cacheline: 40 bytes */
> };
>
> I will adjust the patch as you said. Thank you, Eric.
>
> Thanks,
> Jason

