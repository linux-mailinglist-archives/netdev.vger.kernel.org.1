Return-Path: <netdev+bounces-247815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA79CFED83
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C68DA3273610
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC301349AFF;
	Wed,  7 Jan 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE6e7xD1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91737E302
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801643; cv=none; b=PCJLoXjJi73tJgdiLGIZSLhbq/O5FhmUpxGekfbPCclr1xKhhfIgIgvGjyPogYPmzIUy6CPtv5J0/vR4xZafyJNsSeRAvVg2pWCun52epTzydFvDdGL86Q0rioxs+e3W6uRPBkYV2Qp90vMvvOrgBV3yK1VLZ/2Maum6tHmGC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801643; c=relaxed/simple;
	bh=V3yFCLd9PnVMfu7x+nHp0SpZEvla9oNDdMZsT+rOXik=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=scXu0rovz10GC/Z6x78nSv6Jz4uaOH2KDDh0DzZbjQyQpAxsLRrJ63sMzX4YpHjyHiq5tMbmfk5+8vEwgeC2PyGyRW/lfBKERvS1ekFkCrYh684YDQPvX3RANvcUSKtsen3jX5kk2hWhN3Gp5/xQmPi7bglJKTRZcRm5HCGVIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE6e7xD1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79028cb7f92so23083857b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767801630; x=1768406430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKuJmVtg3asklMBFCrlbhLX2/3v2lEn9vcJXzl+ABfY=;
        b=dE6e7xD1euqcaQLNRahzvCLxF39BO3Rwnx/Hdu2gZhZFq4WajHYTyl0ZdAOVzEU4vf
         7hGnl+0OQvf9wEPvD7LxOtc7oPijkyJIHZ2YegaE+JRwtPhVyx4H1z5bQAmKgo41aD9G
         deXsRvXrTzOxhl6oVOdmGVUIsL3uRJFAHo9ICNtHVBagQIpvhF93rwsfssEfpnDyUzMB
         ciiInBgkry6lWBesFrd4nzFAvXFDYkH2idQ0mhuwZB/j7if6PceIqEGeoXt6S6o0Z4Ni
         n9GXEctiQfeVozs3Qp2/ADLrJI5MEukA/nTd4advhyagPOP1AS4fT7eNJbyT8vEEXpWk
         OacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801630; x=1768406430;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKuJmVtg3asklMBFCrlbhLX2/3v2lEn9vcJXzl+ABfY=;
        b=he2kw7Uo3gGQZq3+ZUmKOdunUTsKTHb3zFOWIvJnMS+gzZucd0BlUOGN8uC/Ct63Se
         mfPGCLaTLS8GsI4Xwq76aQvCWC3X4j9euTLdcNBxaUUpVCz0Ae3mRSEMLqX70fwzAH13
         9lFUuRYC12rK9AJ1k/2xO0KpGFgcKZIM/XBz1NZ9gJm6U/dbtO0U60DxyYYXhYHJ5r7y
         wktgv4jm7QiQBPO0HAWMkuL8CT8JsrSIDfMxeJyOPFQ7UZmfR4rTiBSD0g3AUazFwM55
         DSDYrxVJgk/roXsyRQob4hs/3a87L6tY5nUdxC4qUcGB8gdzkHKCnR/TphG1b3a9+TnK
         5jqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFWO2Rthg2mQlXKYTgUxy/Y89FUo+iBR9/hyHCW8WISka0r5Lpt1sEW463WFnI5iAO4mQ5+Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcNRFD0LXuu43aKN64HON+tmUQdEaXyd+rYiwty1pjt0CnhjR
	Yui3mgtgZEHd8yayXSI4gpfj1IOaJbr/II8/cA9AiXLYWNLudV/S+GnC
X-Gm-Gg: AY/fxX5mdIgj3SuNy5IkghSdnHDBJP4odH7UreRv3k9WCf3vuYckk79fqXxklEmmiUP
	2Jg7sgvzcG3hEWgm2S/VfeVMJyGbqHCAidLHh2skqbECH/QNLc+ZS4JdaFJFDVZFuWEdqS5BTaa
	amFwY+TrPH77ma5T/7dgTtOFyH3WD+hI3wvk9Dz3BQDh0p1WZBqGu/M0/w4rX1YQ6dL98KY/nyF
	N7q4tpq5/aabPRELYVe/iidjTlgghsKzGpE/Uc/XMD7QnCLGP/ZEytHH/wcTh8Q6y7MgJB4jKfX
	FF3GSjAZ2S3wg5k94H/0ECWjXkOIUtYyOAHgvHk1q3rcfzF0DRt/0/tdnLBggn24WAt/KHWQ7d+
	EL72GJW8Q1t0cfSdmxf0G65m6kqvIS3HRxVtyBq8Mx96/X4UEMehQDIdgznDxTZ4oo6VMatc0qg
	di1enOjOnmyALSg67o3nedv1e9F2Gn+p4D8yPsh+yNxbOLV3TnOMn0rk45EKapXpKrg0ykPQ==
X-Google-Smtp-Source: AGHT+IENzg5gdOHTV4hmC7unf9naU5HuQ8dAAid7AZBkkLIIIE805RAtFCRblQ/FhYXDav/dy1Pfwg==
X-Received: by 2002:a05:690c:fc8:b0:790:4bcc:764f with SMTP id 00721157ae682-790b5828109mr29090427b3.55.1767801628394;
        Wed, 07 Jan 2026 08:00:28 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6dcd4asm19864067b3.52.2026.01.07.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:00:27 -0800 (PST)
Date: Wed, 07 Jan 2026 11:00:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "willemb@google.com" <willemb@google.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>
Cc: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Message-ID: <willemdebruijn.kernel.c616acad800d@gmail.com>
In-Reply-To: <1f232ad5c879a30ac94586a56a387d9d48a95765.camel@mediatek.com>
References: <20260106020208.7520-1-shiming.cheng@mediatek.com>
 <willemdebruijn.kernel.f3b2fe8186f4@gmail.com>
 <1f232ad5c879a30ac94586a56a387d9d48a95765.camel@mediatek.com>
Subject: Re: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shiming Cheng (=E6=88=90=E8=AF=97=E6=98=8E) wrote:
> Dear Willem
> =

> frag_list assignment trigger:
> frag_list is assigned to the next skb without to enable device feature
> NETIF_F_GRO_FRAGLIST if head_frag is zero.

Thanks for the trace, so this is a regular GRO packet using
skb_gro_receive that ended up having to use frag_list.

> After packet in fraglist is processed by BPF pull tial, performing GSO
> segmentation directly will cause problems.

That's peculiar. For such packets, there is no expectation that all
frag_list skbs hold an exact segment.

It would be helpful if the stack trace can be extended to show the
line numbers. And/or if you can show the BUG that is being hit in
skb_segment.

I agree that we probably just need to detect such modified packets and
linearize them. But let's get a more detailed root cause first.

> =

> udp_gro_receive_segment
>   skb_gro_receive
>    if (skb->head_frag=3D=3D0)
>      goto merge;
> =

> =

> merge:
>         /* sk ownership - if any - completely transferred to the
> aggregated packet */
>         skb->destructor =3D NULL;
>         skb->sk =3D NULL;
>         delta_truesize =3D skb->truesize;
>         if (offset > headlen) {
>                 unsigned int eat =3D offset - headlen;
> =

>                 skb_frag_off_add(&skbinfo->frags[0], eat);
>                 skb_frag_size_sub(&skbinfo->frags[0], eat);
>                 skb->data_len -=3D eat;
>                 skb->len -=3D eat;
>                 offset =3D headlen;
>         }
> =

>         __skb_pull(skb, offset);
> =

>         if (NAPI_GRO_CB(p)->last =3D=3D p)
>                 skb_shinfo(p)->frag_list =3D skb;   =

>         <<< here frag_list is assigned to the next skb without to
> enable device feature NETIF_F_GRO_FRAGLIST if head_frag is zero
>         else
>                 NAPI_GRO_CB(p)->last->next =3D skb;
>         NAPI_GRO_CB(p)->last =3D skb;
>         __skb_header_release(skb);
>         lp =3D p;
> =

> =

> =

> =

> On Tue, 2026-01-06 at 14:15 -0500, Willem de Bruijn wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > =

> > =

> > Shiming Cheng wrote:
> > > Commit 3382a1ed7f77 ("net: fix udp gso skb_segment after  pull from=

> > > frag_list")
> > > if gso_type is not SKB_GSO_FRAGLIST but skb->head_frag is zero,
> > =

> > What codepath triggers this scenario?
> > =

> > We should make sure that the fix covers all such instances. Likely
> > instances of where some module in the datapath, like a BPF program,
> > modifies a valid skb into one that is not safe to pass to
> > skb_segment.
> > =

> > I don't fully understand yet that skb->head_frag =3D=3D 0 is the only=

> > such condition in scope.
> > =

> > > then detected invalid geometry in frag_list skbs and call
> > > skb_segment. But some packets with modified geometry can also hit
> > > bugs in that code. Instead, linearize all these packets that fail
> > > the basic invariants on gso fraglist skbs. That is more robust.
> > > call stack information, see below.
> > > =

> > > Valid SKB_GSO_FRAGLIST skbs
> > > - consist of two or more segments
> > > - the head_skb holds the protocol headers plus first gso_size
> > > - one or more frag_list skbs hold exactly one segment
> > > - all but the last must be gso_size
> > > =

> > > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can=

> > > modify fraglist skbs, breaking these invariants.
> > > =

> > > In extreme cases they pull one part of data into skb linear. For
> > > UDP,
> > > this  causes three payloads with lengths of (11,11,10) bytes were
> > > pulled tail to become (12,10,10) bytes.
> > > =

> > > The skbs no longer meets the above SKB_GSO_FRAGLIST conditions
> > > because
> > > payload was pulled into head_skb, it needs to be linearized before
> > > pass
> > > to regular skb_segment.
> > =

> > Most of this commit message duplicates the text in commit
> > 3382a1ed7f77
> > ("net: fix udp gso skb_segment after  pull from frag_list"). And
> > somewhat garbles it, as in the first sentence.
> > =

> > But this is a different datapath, not related to SKB_GSO_FRAGLIST.
> > So the fixes tag is also incorrect. The blamed commit fixes an issue
> > with fraglist GRO. This new issue is with skbs that have a fraglist,
> > but not one created with that feature. (the naming is confusing, but
> > fraglist-gro is only one use of the skb frag_list).
> > =

> > >   skb_segment+0xcd0/0xd14
> > >   __udp_gso_segment+0x334/0x5f4
> > >   udp4_ufo_fragment+0x118/0x15c
> > >   inet_gso_segment+0x164/0x338
> > >   skb_mac_gso_segment+0xc4/0x13c
> > >   __skb_gso_segment+0xc4/0x124
> > >   validate_xmit_skb+0x9c/0x2c0
> > >   validate_xmit_skb_list+0x4c/0x80
> > >   sch_direct_xmit+0x70/0x404
> > >   __dev_queue_xmit+0x64c/0xe5c
> > >   neigh_resolve_output+0x178/0x1c4
> > >   ip_finish_output2+0x37c/0x47c
> > >   __ip_finish_output+0x194/0x240
> > >   ip_finish_output+0x20/0xf4
> > >   ip_output+0x100/0x1a0
> > >   NF_HOOK+0xc4/0x16c
> > >   ip_forward+0x314/0x32c
> > >   ip_rcv+0x90/0x118
> > >   __netif_receive_skb+0x74/0x124
> > >   process_backlog+0xe8/0x1a4
> > >   __napi_poll+0x5c/0x1f8
> > >   net_rx_action+0x154/0x314
> > >   handle_softirqs+0x154/0x4b8
> > > =

> > >   [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at
> > > net/core/skbuff.c:4278!
> > >   [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error:
> > > Oops - BUG: 00000000f2000800 [#1]
> > >   [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset:
> > > 0x178cc00000 from 0xffffffc008000000
> > >   [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET:
> > > 0x40000000
> > >   [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005
> > > (nZCv daif +PAN -UAO)
> > >   [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc :
> > > [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
> > >   [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr :
> > > [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
> > >   [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp :
> > > ffffffc008013770
> > > =

> > > Fixes: 3382a1ed7f77 ("net: fix udp gso skb_segment after pull from
> > > frag_list")
> > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > ---
> > >  net/ipv4/udp_offload.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > =

> > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > index 19d0b5b09ffa..606d9ce8c98e 100644
> > > --- a/net/ipv4/udp_offload.c
> > > +++ b/net/ipv4/udp_offload.c
> > > @@ -535,6 +535,12 @@ struct sk_buff *__udp_gso_segment(struct
> > > sk_buff *gso_skb,
> > >                       uh->check =3D ~udp_v4_check(gso_skb->len,
> > >                                                 ip_hdr(gso_skb)-
> > > >saddr,
> > >                                                 ip_hdr(gso_skb)-
> > > >daddr, 0);
> > > +     } else if (skb_shinfo(gso_skb)->frag_list && gso_skb-
> > > >head_frag =3D=3D 0) {
> > > +             if (skb_pagelen(gso_skb) - sizeof(*uh) !=3D
> > > skb_shinfo(gso_skb)->gso_size) {
> > > +                     ret =3D __skb_linearize(gso_skb);
> > > +                     if (ret)
> > > +                             return ERR_PTR(ret);
> > > +             }
> > >       }
> > > =

> > >       skb_pull(gso_skb, sizeof(*uh));
> > > --
> > > 2.45.2
> > > =

> > =

> > =




