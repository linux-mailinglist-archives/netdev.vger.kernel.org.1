Return-Path: <netdev+bounces-131180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61098D12D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEBC1C208B8
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EB1E6306;
	Wed,  2 Oct 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZdlWsou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1122564
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864832; cv=none; b=aMSw/y/bLAjdUv7d+WoW26ilN47YpxpGTC7428lGs2vuIRcNDp6cJTKDzVV61YC5zhgf9pVuQiDh6mOI2/FopI1GYbkWV37dyfk5kEN5hdhoJp/5dtAXab06hKIrqXd+K/gnBcHokYuUvoC4zs+o2h3nKQVVfISD6R+27kdpuVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864832; c=relaxed/simple;
	bh=kGKb9T1nVK0ksaghgzHTyWhqZyvrp9HZZPYJIYu3Nwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoMgJzvOPh2HUJXj7LsznJSJ1XxA0AIrQSvx4aVJlfDJJt2Ke5ujqXcoA84izLbwNwJ4rtelHfdUg86vmb6ldrGofGaQJlI7y72mjxZuuvD6KMdG96dwrngHLCS6XyzYoNzK9nLjoXAYOhrRd0IMoKuMgOMI0DAydYwU4kAL1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZdlWsou; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a0cad8a0a5so33471065ab.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727864830; x=1728469630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYU3UYfq7UzWB1zle0ppv/K80i0k+hERibX3fRiwY6A=;
        b=RZdlWsoucGde1ooRiKQLVc8C1jNQYnWB+OpeBh+QtvmQjzWRzWM3KPPM+P/cfIDfoK
         Qou2La3iPJGnPhIwWAT+p4lZEd+LdsJUdxamC4FsTUwxrrvY5XC2JkkdmdZyWZdoKWf0
         QNFkXh2nQ09fbfM/D2do5QWcR8qhJI65CBukpu3H/+s1vf3fKEcoCeWAatU0mYu3zbsH
         VvI0ZvSCy/90bLVDpBbwT1YHDwihEdjpOo5NzWEw+aldZez4y118yeBM/Zpkz8U1vljv
         gPUZ6sfBIk3v5qgTQ7n2cWwfPpVw6J+CTGmy3aME2M7qUkWSUQvLysdwjxo1DSWEAcke
         LXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727864830; x=1728469630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYU3UYfq7UzWB1zle0ppv/K80i0k+hERibX3fRiwY6A=;
        b=vSNiYvgWp56LatuijP1qJPdgU7lOFEPhze50utgTXvqkvf+h09c/vyachXS5TuFA5o
         iq8Qpm5KdKe5IfXSi9zSKa+d5r0M0DCKR5jJrtYjZuYmEEjVdS4JsflBRw0ue9l9IQ1w
         lZu2jRwXCbisPaiebfb42qBZuJghAojiDUpfkdmTVQ6xtQUopiK2MgFCn0LmqWrrmAcJ
         WEclITTynbAwGfjYBDG0KsuerNzu/witBal8J+SI76E3KDQuHRYKKNy6Uv1fBDiiRuCj
         07rj9GekqEA4qsvixwppp6P/dSNde6ZPaRtGmtzK9MPgTEzyfsLFh6H5qrq4cfBYR/OO
         zK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGHUdZ0jd8BMVN0lxJ/jQ1PFWoxJINfu2eFcZTAaX1coS5MUTthDSD0qfNduAm7NLgX16nRQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKUBbAwpsx6AnQQkwIbTXeJB1hSDoeppNl5kChh+AxnRTtM2K
	udImvxLYCXQYJuMznDevsIDTFxbLA0qxRuBbEAj3dRbZbe7HW3WzSkRRoCUVoQFpMkxwvK+qyIN
	bdqVUJqYbtFOLaPqSzC5xy8DYtuo=
X-Google-Smtp-Source: AGHT+IHeQBgKM20JYyk8dWnw75U0gojEMusbss6w7jeoEsMujrQbd9mrfn330ai52l/IwIezPn0+7p5Z/16N8o/IPaw=
X-Received: by 2002:a92:c24e:0:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a3659568ecmr23889915ab.22.1727864829759; Wed, 02 Oct 2024
 03:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002041844.8243-1-kerneljasonxing@gmail.com> <CANn89iLVRPHQ0TzWWOs8S1hA5Uwck_j=tPAQquv+qDf8bMkmYQ@mail.gmail.com>
In-Reply-To: <CANn89iLVRPHQ0TzWWOs8S1hA5Uwck_j=tPAQquv+qDf8bMkmYQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Oct 2024 19:26:32 +0900
Message-ID: <CAL+tcoA6YCkYvFJkpbmSuT=MVn_81KmJQyMYtojKC5kBFZvqfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net-timestamp: namespacify the sysctl_tstamp_allow_data
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Wed, Oct 2, 2024 at 4:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Oct 2, 2024 at 6:18=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Let it be tuned in per netns by admins.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v2
> > Link: https://lore.kernel.org/all/66fa81b2ddf10_17948d294bb@willemb.c.g=
ooglers.com.notmuch/
> > 1. remove the static global from sock.c
> > 2. reorder the tests
> > 3. I removed the patch [1/3] because I made one mistake
> > 4. I also removed the patch [2/3] because Willem soon will propose a
> > packetdrill test that is better.
> > Now, I only need to write this standalone patch.
> > ---
> >  include/net/netns/core.h   |  1 +
> >  include/net/sock.h         |  2 --
> >  net/core/net_namespace.c   |  1 +
> >  net/core/skbuff.c          |  2 +-
> >  net/core/sock.c            |  2 --
> >  net/core/sysctl_net_core.c | 18 +++++++++---------
> >  6 files changed, 12 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> > index 78214f1b43a2..ef8b3105c632 100644
> > --- a/include/net/netns/core.h
> > +++ b/include/net/netns/core.h
> > @@ -23,6 +23,7 @@ struct netns_core {
> >  #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
> >         struct cpumask *rps_default_mask;
> >  #endif
> > +       int     sysctl_tstamp_allow_data;
> >  };
>
> This adds another hole for no good reason.
> Please put this after sysctl_txrehash.

Thanks for your reminder.

Before this patch:
struct netns_core {
        struct ctl_table_header *  sysctl_hdr;           /*     0   0x8 */
        int                        sysctl_somaxconn;     /*   0x8   0x4 */
        int                        sysctl_optmem_max;    /*   0xc   0x4 */
        u8                         sysctl_txrehash;      /*  0x10   0x1 */

        /* XXX 7 bytes hole, try to pack */

        struct prot_inuse *        prot_inuse;           /*  0x18   0x8 */
        struct cpumask *           rps_default_mask;     /*  0x20   0x8 */

        /* size: 40, cachelines: 1, members: 6 */
        /* sum members: 33, holes: 1, sum holes: 7 */
        /* last cacheline: 40 bytes */
};

After this patch:
struct netns_core {
        struct ctl_table_header *  sysctl_hdr;           /*     0   0x8 */
        int                        sysctl_somaxconn;     /*   0x8   0x4 */
        int                        sysctl_optmem_max;    /*   0xc   0x4 */
        u8                         sysctl_txrehash;      /*  0x10   0x1 */

        /* XXX 7 bytes hole, try to pack */

        struct prot_inuse *        prot_inuse;           /*  0x18   0x8 */
        struct cpumask *           rps_default_mask;     /*  0x20   0x8 */
        int                        sysctl_tstamp_allow_data; /*  0x28   0x4=
 */

        /* size: 48, cachelines: 1, members: 7 */
        /* sum members: 37, holes: 1, sum holes: 7 */
        /* padding: 4 */
        /* last cacheline: 48 bytes */
};

See this line "/* sum members: 37, holes: 1, sum holes: 7 */", so I
don't think I introduce a new hole here.

After trying the suggestion you mentioned, the sum holes decreases from 7 t=
o 3:
struct netns_core {
        struct ctl_table_header *  sysctl_hdr;           /*     0   0x8 */
        int                        sysctl_somaxconn;     /*   0x8   0x4 */
        int                        sysctl_optmem_max;    /*   0xc   0x4 */
        u8                         sysctl_txrehash;      /*  0x10   0x1 */

        /* XXX 3 bytes hole, try to pack */

        int                        sysctl_tstamp_allow_data; /*  0x14   0x4=
 */
        struct prot_inuse *        prot_inuse;           /*  0x18   0x8 */
        struct cpumask *           rps_default_mask;     /*  0x20   0x8 */

        /* size: 40, cachelines: 1, members: 7 */
        /* sum members: 37, holes: 1, sum holes: 3 */
        /* last cacheline: 40 bytes */
};

I will adjust the patch as you said. Thank you, Eric.

Thanks,
Jason

