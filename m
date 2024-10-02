Return-Path: <netdev+bounces-131182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB67F98D162
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A10B2379C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05861E6DFF;
	Wed,  2 Oct 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QadvYnHu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883D1C3314
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865330; cv=none; b=QU1T00lPwAeGdl2k8lrax/ZZgHG6OQoqGnjWdYAkVzByikE/XRytPnQusPu8gsdto1Hvx7gge7PbK7DPi3A9z9nLvkQ0i0em+DmFQRqTehipgnq85yFLB5lQb1MER2I1jl9YQDDBvf3OzalNDWb+SmjThLGn2+DsFMf8X2x21z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865330; c=relaxed/simple;
	bh=e+IfClOX/8cdB6OunRhs22gvO+EPzi78kUFkdBENzgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSXX4HzaAq4NlOVFSbhb/uJhva5B3MstAZ89S+IjlnSyqGg0y220KTpaTaiaNhYY05HdYD96EeIUrvJZGxX3TGpE9afNsplpHVYUYcfeu3CGfw0cLus1YRpJX/lzssWfTe+3pCZK6aS1d+i7+SJ0Hi7TnfRYknWLxnxV1XZ2Kys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QadvYnHu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a2759a1b71so33115795ab.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727865328; x=1728470128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f1Xq55pOIJfRgtbPG9FWMxUApUNA4e/TnT1IgAjjiI=;
        b=QadvYnHurbGdrP5k1LQGMz8cePdhpmFCcbt8dg+/y43c6SP2QUbb+uCb4vh7/bR2vi
         RCnK7It2UHHUnnOUo9+w31Rd6bht+7jSKdd7pG8R1NiBCvx8aikWwpc6WmznGyWyK2oZ
         YLkOhXPwkNPs+VxNM2BxVpUYdJJ0BDBsBZKQydhXk9eILFzt/AmIGz2nfKVVV/vH83eZ
         2R6Sx/Kn2yFhbp7Z2orohhiOPn7jXqPBCkT7oVDKBNHXldVD3BmeY6TRHCxrbHm96TFx
         S2VIuV9p5Bt1MhMNRNMO/I+vmdNr0GykPaZVnrVucUq6Y3ubAiYkIilENhfEzVZEeM7C
         ov/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727865328; x=1728470128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f1Xq55pOIJfRgtbPG9FWMxUApUNA4e/TnT1IgAjjiI=;
        b=uHLizPlvKtyAFxz48t1Or0csC8k/XIbntPQa7k+3Ty1+4EzXCra+eN7WPW3jOKduPL
         4R0NcplJzlHRXdGAq4zw1L3vp4f6C0NKzwzgIDpeqzXS3kyZltEn3Hk8knhaYhtNbRrf
         Y5jMlqyRkfiXBJaYdfAk33TI031HmgXdSZr6sDPhiob9A/wRcqASYJLdnU4SF7iHf9lz
         Hq6QU71ie5pKU1pcrsbk28+Zt3Z+kdapfdZ9KdUXH3U1zN6iqxAB7mDnlVBOns2eQuHA
         TRq5rOZy/a3rDM8NyErQlqs9wWaGVE6pURnhCo1/OQGQ+Rb58+lnDUdPqKCRkw4nHjc9
         831g==
X-Forwarded-Encrypted: i=1; AJvYcCUwcX3swcM5+qiCvhQOSlXKjZbKsGRa9qx2CVKk7Rz2SB6IREvMfh9/cPhybcaZWfVNZPqflNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeD/p98wI2KqriuTG4r4XdRTx1Iv74mJBf3BU4HDQH2BPeY44
	9+v6jqqQrUkbRb+AbjJ8LhdByWNil0ZAA++rtJ/Q3sq3TjJM13MNVuXTfH1yut9fUo2ssA9RiHE
	uFU2vTZq40UUoCIAYWWYgf1JFSYQ=
X-Google-Smtp-Source: AGHT+IGS02yxGNsqSuQR49IfnRABcScTtAkXlYJoTGVfUdBYgBuCb06StAgoJaO3JAcngwVNgghflywAadW8ampHcXA=
X-Received: by 2002:a05:6e02:180b:b0:39f:60d7:813b with SMTP id
 e9e14a558f8ab-3a365954717mr23617715ab.22.1727865328353; Wed, 02 Oct 2024
 03:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002041844.8243-1-kerneljasonxing@gmail.com>
 <CANn89iLVRPHQ0TzWWOs8S1hA5Uwck_j=tPAQquv+qDf8bMkmYQ@mail.gmail.com>
 <CAL+tcoA6YCkYvFJkpbmSuT=MVn_81KmJQyMYtojKC5kBFZvqfw@mail.gmail.com> <CANn89iKr2J3S-Oni9VT0-C5K0EOFdnX8eR_aRueNx2R+0f8fKA@mail.gmail.com>
In-Reply-To: <CANn89iKr2J3S-Oni9VT0-C5K0EOFdnX8eR_aRueNx2R+0f8fKA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Oct 2024 19:34:52 +0900
Message-ID: <CAL+tcoAeN_CpW6BBZ5HHGUEzNFT8e-m0uQLaapR=i6yWdeEKww@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net-timestamp: namespacify the sysctl_tstamp_allow_data
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 7:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Oct 2, 2024 at 12:27=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Wed, Oct 2, 2024 at 4:41=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Wed, Oct 2, 2024 at 6:18=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Let it be tuned in per netns by admins.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > v2
> > > > Link: https://lore.kernel.org/all/66fa81b2ddf10_17948d294bb@willemb=
.c.googlers.com.notmuch/
> > > > 1. remove the static global from sock.c
> > > > 2. reorder the tests
> > > > 3. I removed the patch [1/3] because I made one mistake
> > > > 4. I also removed the patch [2/3] because Willem soon will propose =
a
> > > > packetdrill test that is better.
> > > > Now, I only need to write this standalone patch.
> > > > ---
> > > >  include/net/netns/core.h   |  1 +
> > > >  include/net/sock.h         |  2 --
> > > >  net/core/net_namespace.c   |  1 +
> > > >  net/core/skbuff.c          |  2 +-
> > > >  net/core/sock.c            |  2 --
> > > >  net/core/sysctl_net_core.c | 18 +++++++++---------
> > > >  6 files changed, 12 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> > > > index 78214f1b43a2..ef8b3105c632 100644
> > > > --- a/include/net/netns/core.h
> > > > +++ b/include/net/netns/core.h
> > > > @@ -23,6 +23,7 @@ struct netns_core {
> > > >  #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
> > > >         struct cpumask *rps_default_mask;
> > > >  #endif
> > > > +       int     sysctl_tstamp_allow_data;
> > > >  };
> > >
> > > This adds another hole for no good reason.
> > > Please put this after sysctl_txrehash.
> >
> > Thanks for your reminder.
> >
> > Before this patch:
> > struct netns_core {
> >         struct ctl_table_header *  sysctl_hdr;           /*     0   0x8=
 */
> >         int                        sysctl_somaxconn;     /*   0x8   0x4=
 */
> >         int                        sysctl_optmem_max;    /*   0xc   0x4=
 */
> >         u8                         sysctl_txrehash;      /*  0x10   0x1=
 */
> >
> >         /* XXX 7 bytes hole, try to pack */
> >
> >         struct prot_inuse *        prot_inuse;           /*  0x18   0x8=
 */
> >         struct cpumask *           rps_default_mask;     /*  0x20   0x8=
 */
> >
> >         /* size: 40, cachelines: 1, members: 6 */
> >         /* sum members: 33, holes: 1, sum holes: 7 */
> >         /* last cacheline: 40 bytes */
> > };
> >
> > After this patch:
> > struct netns_core {
> >         struct ctl_table_header *  sysctl_hdr;           /*     0   0x8=
 */
> >         int                        sysctl_somaxconn;     /*   0x8   0x4=
 */
> >         int                        sysctl_optmem_max;    /*   0xc   0x4=
 */
> >         u8                         sysctl_txrehash;      /*  0x10   0x1=
 */
> >
> >         /* XXX 7 bytes hole, try to pack */
> >
> >         struct prot_inuse *        prot_inuse;           /*  0x18   0x8=
 */
> >         struct cpumask *           rps_default_mask;     /*  0x20   0x8=
 */
> >         int                        sysctl_tstamp_allow_data; /*  0x28  =
 0x4 */
> >
> >         /* size: 48, cachelines: 1, members: 7 */
> >         /* sum members: 37, holes: 1, sum holes: 7 */
> >         /* padding: 4 */
> >         /* last cacheline: 48 bytes */
> > };
> >
> > See this line "/* sum members: 37, holes: 1, sum holes: 7 */", so I
> > don't think I introduce a new hole here.
>
> You certainly did.  /* padding: 4 */
>
> Overall size grew by 8 bytes, while adding one 4 byte field.

Oh, I learned. Thanks for your instructions.

