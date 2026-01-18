Return-Path: <netdev+bounces-250780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B9D39230
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490DA3016186
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A31E8836;
	Sun, 18 Jan 2026 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZpn7NLF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C01F2BAD
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703290; cv=none; b=l2CS3He/ZV9z1yavv5HMQQFmvnEZq1gKlqKBSqTSVhVIzSMLwswANoqFpr8QWPsbQgg1cbE4d7qFCBdvh3pfCNL6DaCLmz/bnPIRjAh4ylZpCuLZ27q43GO2gZul2Uo4HO5EBP9qXkHbLRVdsN73fO+J+kGzwtPRR+FxMqT8R6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703290; c=relaxed/simple;
	bh=DPAq1O7nJOof+xA1UfT/tKM2pP7S6oxoutl6WzbGZq4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rE+ougy6EqI/MHA0qJ1v2eRuH8YidemHO/i3IXnVy0dvt9outcrHP3iYsSL+1PQGftRiWiuSlmiM6FdFXjcc9HR2q/KGrPPqKkDuFRrZs04h5t6h7HMw7rZMhGBNAM0iMa00Zxa3axwf/mHdk+4DzIX/dmzwmxaYFmu5Gi98FYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZpn7NLF; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-648ff033fb2so2898968d50.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 18:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768703287; x=1769308087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKCwOueIPTxRs7qLLKB/13Cqdlh/v0ac+Rc0Brx6zSM=;
        b=FZpn7NLFgoUnnVO87sHPf4j24E+cMjjy/iSx7ag5U9cxGDibMwAjsiBYty5zqBrzzc
         S1c0He/kAYnQjOf6/E+AIlwncEtmwpaNOlY+kzfBgaZvasqiCFBkJ4c9XVCMydrkUBd/
         Uh6GI4rW9aJ2J8U0SIjIUFNYVln4mEbOqfVKUGHT8XvdsVFsRh6LLhPDOEsHXpRyQDJd
         Ed4UmILAMJwmzn+FYUfPqLpQdreQXrwuul6kf64EC9FQ5tpD2i+wvaDNm5pePm8BxsjV
         P75/CUpVVfNk7mBawzjnato/PojV7jzymnvguwRaML2NXnBgtRZTh26pVpKgiBiSMtHc
         uYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768703287; x=1769308087;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKCwOueIPTxRs7qLLKB/13Cqdlh/v0ac+Rc0Brx6zSM=;
        b=ni6HWVNItOP3iaQoEj4tPJlaEixaLvSXc0zOBSnuYDRIjvAReGDlLjt/o+kDUOgBJy
         tuzRfum3y5vQ/DttupAjvzd1kIIT8+Hb6MCPa9MC/glwDzjzacyH/bqO837uIbbuQizL
         lvkACcos1kXdpk+IP8qxlNYyCM1ufNN2DMbPOn3fLuP19B/RL8KC4puJFc5SqaBG3Pls
         P8lr/HgXXcNLG0OwXFq1qLgeKxujLyfE9RI1FXNPR9SyZKQBw+m+Wf7j5pzM3hVBelIt
         oLbAiHvVjpXrE1v4EmmTCV7X28kP9EEwnLXPpWSY98vNHz+ZMPQdBLguEMW0T1JK9xc8
         mb8A==
X-Forwarded-Encrypted: i=1; AJvYcCWH0quVObQ5ozBQG/EFwhN0tTDLBBD5AUUpiRIAwanH40Y7hRScCYZ8qdjAN/j726ctkxnaAxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93875I8fnQ5pAbSGgG4dMW2RF6azXJLEUvEEpuqNVv3rV+nd4
	DCSHv8L0dnTFfY/ZXExDC2KCcUy9xy38x9qMfTVNkI3l+6vQndYhsXdc
X-Gm-Gg: AY/fxX60AurYYI/S+cAX6Bs97YTszwXU2huOA2z13TgNiOiYXWtrm0ej6MoTbseVVZZ
	o9i5taLMmY8WDOFksirCRbtNtQtZ2c4Vn/9cJDQC6ZBqaUBepZ7+JWZn8/XnWAfeh+R3Viz883a
	98zvFaxW9aLe/hPLJPAptMJsXj6aYUVxEK8ETS0GkpHS+amJVm+6xcNyBqK4hJa8PxtVwyFt6gD
	FeKJMM9rIzbH+TJeTunNFPkfmu+HMEd/39YRlZx3AZ/0AOS7epYBFti5tRuMFvFWP5O8G654jCm
	FKS9KC9h0AyN3kKUsn5KQJ+7LDpsLcNFC12m7/0mYHzOoE6uLoIJtNjZZiHsVIlRBOx8ZeVrrqJ
	at/XnIxDUT7LQLXxuRZXTRL3sTp9zfebJhWmPXZTSu7LrJco65QVXX482UTQQRbc7jOQP4F9/ey
	dnYLwnBWoor5b77koCIZF+Y9cpiZiEgVX3P5diDNrX9UAZIiTDbEYppNHh11an
X-Received: by 2002:a05:690e:118b:b0:646:6a79:7955 with SMTP id 956f58d0204a3-649164f5756mr6539937d50.59.1768703287160;
        Sat, 17 Jan 2026 18:28:07 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64916ffaeb2sm3233234d50.4.2026.01.17.18.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 18:28:06 -0800 (PST)
Date: Sat, 17 Jan 2026 21:28:05 -0500
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
Message-ID: <willemdebruijn.kernel.30b0807bf46c0@gmail.com>
In-Reply-To: <d8762bf19303e28d29bc98e4e0ff1b9b077f22b4.camel@mediatek.com>
References: <20260106020208.7520-1-shiming.cheng@mediatek.com>
 <willemdebruijn.kernel.f3b2fe8186f4@gmail.com>
 <1f232ad5c879a30ac94586a56a387d9d48a95765.camel@mediatek.com>
 <willemdebruijn.kernel.c616acad800d@gmail.com>
 <d8762bf19303e28d29bc98e4e0ff1b9b077f22b4.camel@mediatek.com>
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

> BUG_ON(!list_skb->head_frag);   <<<<<<<< an exception was triggered
> here.
> =

> trigger exception condition:
> 1. TX device scatter-gather: on
> dev features=3D18433 =3D> 100100000000001  =3D> last bit is 1 =3D=3D SG=
 enable =

> 2. skb->head_frag is 1
> 3. udp gro enable
> =

> =

> Because the target device has enabled SG (scatter-gather), and skb-
> >head_frag is 0, the subsequent head cannot be added to frags.
> In other words, when head_frag is 0, the target device is not allowed
> to enable SG (scatter-gather).
> I  still need to reproduce the problem, but from analyzing the code, it=


Do you mean that this happened somewhere (e.g., in production), but
you are not able to trigger it in a synthetic test yet?

(btw small reminder: please don't top post)

> appears that the issue is caused by the target device enabling SG. =


SG is the default. It makes sense that disabling SG disables
skb frags and avoids this part of the code.
 =

> =

> struct sk_buff *skb_segment(struct sk_buff *head_skb,
>                   =

>           netdev_features_t features)
> {
> ...
>         while (pos < offset + len) {
>                         if (i >=3D nfrags) {
>                                 i =3D 0;
>                                 nfrags =3D skb_shinfo(list_skb)-
> >nr_frags;
>                                 frag =3D skb_shinfo(list_skb)->frags;
>                                 frag_skb =3D list_skb;
>                                 if (!skb_headlen(list_skb)) {
>                                         BUG_ON(!nfrags);
>                                 } else {
>                                         BUG_ON(!list_skb-
> >head_frag);   <<<<<<<< an exception was triggered here.
> =

>                                         /* to make room for head_frag.
> */
>                                         i--;
>                                         frag--;

Thanks. So commit 13acc94eff12 ("net: permit skb_segment on head_frag
frag_list skb") extended support for segmenting of list_skb with
frag_list, but only if the head if present is also frag_based.

This is obsure enough that I agree that linearizing such packets is an
okay workaround.

But we may be able to do one better. Disabling sg for this input will
build linear nskbs and avoid this code. At the top of skb_segment.

And such code already exists, refined most recently in commit
9e4b7a99a03a ("net: gso: fix panic on frag_list with mixed head alloc
types"). Did you observe this on a recent kernel? If not, which
version?

What kind of BPF program are you running, especially which functions
does it call that might change skb geometry. All such functions in
net/core/filter. set SKB_GSO_DODGY, which will make skb_segment enter
this check branch.


Re: your patch

+	} else if (skb_shinfo(gso_skb)->frag_list && gso_skb->head_frag =3D=3D =
0) {

The issue here is that list_skb->head_frag =3D=3D 0, not gso_skb. Not sur=
e
that gso_skb->head_frag =3D=3D 0 implies list_skb->head_frag =3D=3D 0.


+		if (skb_pagelen(gso_skb) - sizeof(*uh) !=3D skb_shinfo(gso_skb)->gso_s=
ize) {

This is copied but AFAIK not relevant here.

>                                 }
>                                 if (skb_orphan_frags(frag_skb,
> GFP_ATOMIC) ||
>                                     skb_zerocopy_clone(nskb, frag_skb,
>                                                        GFP_ATOMIC))
>                                         goto err;
> =

>                                 list_skb =3D list_skb->next;
>                         }
> =

> }
> =

> #0  0xffffffa17e5b4184 in skb_segment (head_skb=3D<optimized out>,
> features=3D<optimized out>)
>     at ../../../../../../kernel-4.19/net/core/skbuff.c:3774
> #1  0xffffffa17e68a4b0 in __udp_gso_segment
> (gso_skb=3D0xffffffde2973fe00, features=3D18433)
>     at ../../../../../../kernel-4.19/net/ipv4/udp_offload.c:215
> #2  0xffffffa17e68ad90 in udp4_ufo_fragment (skb=3D0xffffffde2973fe00,
> features=3D18433)
>     at ../../../../../../kernel-4.19/net/ipv4/udp_offload.c:316
> #3  0xffffffa17e694e04 in inet_gso_segment (skb=3D0xffffffde2973fe00,
> features=3D18433)
>     at ../../../../../../kernel-4.19/net/ipv4/af_inet.c:1342
> #4  0xffffffa17e5c4b48 in skb_mac_gso_segment (skb=3D0xffffffde2973fe00=
,
> features=3D18433)
> =

> =

> On Wed, 2026-01-07 at 11:00 -0500, Willem de Bruijn wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > =

> > =

> > Shiming Cheng (=E6=88=90=E8=AF=97=E6=98=8E) wrote:
> > > Dear Willem
> > > =

> > > frag_list assignment trigger:
> > > frag_list is assigned to the next skb without to enable device
> > > feature
> > > NETIF_F_GRO_FRAGLIST if head_frag is zero.
> > =

> > Thanks for the trace, so this is a regular GRO packet using
> > skb_gro_receive that ended up having to use frag_list.
> > =

> > > After packet in fraglist is processed by BPF pull tial, performing
> > > GSO
> > > segmentation directly will cause problems.
> > =

> > That's peculiar. For such packets, there is no expectation that all
> > frag_list skbs hold an exact segment.
> > =

> > It would be helpful if the stack trace can be extended to show the
> > line numbers. And/or if you can show the BUG that is being hit in
> > skb_segment.
> > =

> > I agree that we probably just need to detect such modified packets
> > and
> > linearize them. But let's get a more detailed root cause first.
> > =

> > > =

> > > udp_gro_receive_segment
> > >   skb_gro_receive
> > >    if (skb->head_frag=3D=3D0)
> > >      goto merge;
> > > =

> > > =

> > > merge:
> > >         /* sk ownership - if any - completely transferred to the
> > > aggregated packet */
> > >         skb->destructor =3D NULL;
> > >         skb->sk =3D NULL;
> > >         delta_truesize =3D skb->truesize;
> > >         if (offset > headlen) {
> > >                 unsigned int eat =3D offset - headlen;
> > > =

> > >                 skb_frag_off_add(&skbinfo->frags[0], eat);
> > >                 skb_frag_size_sub(&skbinfo->frags[0], eat);
> > >                 skb->data_len -=3D eat;
> > >                 skb->len -=3D eat;
> > >                 offset =3D headlen;
> > >         }
> > > =

> > >         __skb_pull(skb, offset);
> > > =

> > >         if (NAPI_GRO_CB(p)->last =3D=3D p)
> > >                 skb_shinfo(p)->frag_list =3D skb;
> > >         <<< here frag_list is assigned to the next skb without to
> > > enable device feature NETIF_F_GRO_FRAGLIST if head_frag is zero
> > >         else
> > >                 NAPI_GRO_CB(p)->last->next =3D skb;
> > >         NAPI_GRO_CB(p)->last =3D skb;
> > >         __skb_header_release(skb);
> > >         lp =3D p;
> > > =

> > > =

> > > =

> > > =

> > > On Tue, 2026-01-06 at 14:15 -0500, Willem de Bruijn wrote:
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > > =

> > > > =

> > > > Shiming Cheng wrote:
> > > > > Commit 3382a1ed7f77 ("net: fix udp gso skb_segment after  pull
> > > > > from
> > > > > frag_list")
> > > > > if gso_type is not SKB_GSO_FRAGLIST but skb->head_frag is zero,=

> > > > =

> > > > What codepath triggers this scenario?
> > > > =

> > > > We should make sure that the fix covers all such instances.
> > > > Likely
> > > > instances of where some module in the datapath, like a BPF
> > > > program,
> > > > modifies a valid skb into one that is not safe to pass to
> > > > skb_segment.
> > > > =

> > > > I don't fully understand yet that skb->head_frag =3D=3D 0 is the =
only
> > > > such condition in scope.
> > > > =

> > > > > then detected invalid geometry in frag_list skbs and call
> > > > > skb_segment. But some packets with modified geometry can also
> > > > > hit
> > > > > bugs in that code. Instead, linearize all these packets that
> > > > > fail
> > > > > the basic invariants on gso fraglist skbs. That is more robust.=

> > > > > call stack information, see below.
> > > > > =

> > > > > Valid SKB_GSO_FRAGLIST skbs
> > > > > - consist of two or more segments
> > > > > - the head_skb holds the protocol headers plus first gso_size
> > > > > - one or more frag_list skbs hold exactly one segment
> > > > > - all but the last must be gso_size
> > > > > =

> > > > > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data)=

> > > > > can
> > > > > modify fraglist skbs, breaking these invariants.
> > > > > =

> > > > > In extreme cases they pull one part of data into skb linear.
> > > > > For
> > > > > UDP,
> > > > > this  causes three payloads with lengths of (11,11,10) bytes
> > > > > were
> > > > > pulled tail to become (12,10,10) bytes.
> > > > > =

> > > > > The skbs no longer meets the above SKB_GSO_FRAGLIST conditions
> > > > > because
> > > > > payload was pulled into head_skb, it needs to be linearized
> > > > > before
> > > > > pass
> > > > > to regular skb_segment.
> > > > =

> > > > Most of this commit message duplicates the text in commit
> > > > 3382a1ed7f77
> > > > ("net: fix udp gso skb_segment after  pull from frag_list"). And
> > > > somewhat garbles it, as in the first sentence.
> > > > =

> > > > But this is a different datapath, not related to
> > > > SKB_GSO_FRAGLIST.
> > > > So the fixes tag is also incorrect. The blamed commit fixes an
> > > > issue
> > > > with fraglist GRO. This new issue is with skbs that have a
> > > > fraglist,
> > > > but not one created with that feature. (the naming is confusing,
> > > > but
> > > > fraglist-gro is only one use of the skb frag_list).
> > > > =

> > > > >   skb_segment+0xcd0/0xd14
> > > > >   __udp_gso_segment+0x334/0x5f4
> > > > >   udp4_ufo_fragment+0x118/0x15c
> > > > >   inet_gso_segment+0x164/0x338
> > > > >   skb_mac_gso_segment+0xc4/0x13c
> > > > >   __skb_gso_segment+0xc4/0x124
> > > > >   validate_xmit_skb+0x9c/0x2c0
> > > > >   validate_xmit_skb_list+0x4c/0x80
> > > > >   sch_direct_xmit+0x70/0x404
> > > > >   __dev_queue_xmit+0x64c/0xe5c
> > > > >   neigh_resolve_output+0x178/0x1c4
> > > > >   ip_finish_output2+0x37c/0x47c
> > > > >   __ip_finish_output+0x194/0x240
> > > > >   ip_finish_output+0x20/0xf4
> > > > >   ip_output+0x100/0x1a0
> > > > >   NF_HOOK+0xc4/0x16c
> > > > >   ip_forward+0x314/0x32c
> > > > >   ip_rcv+0x90/0x118
> > > > >   __netif_receive_skb+0x74/0x124
> > > > >   process_backlog+0xe8/0x1a4
> > > > >   __napi_poll+0x5c/0x1f8
> > > > >   net_rx_action+0x154/0x314
> > > > >   handle_softirqs+0x154/0x4b8
> > > > > =

> > > > >   [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at
> > > > > net/core/skbuff.c:4278!
> > > > >   [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error:=

> > > > > Oops - BUG: 00000000f2000800 [#1]
> > > > >   [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset:=

> > > > > 0x178cc00000 from 0xffffffc008000000
> > > > >   [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET:
> > > > > 0x40000000
> > > > >   [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate:
> > > > > 60400005
> > > > > (nZCv daif +PAN -UAO)
> > > > >   [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc :
> > > > > [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
> > > > >   [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr :
> > > > > [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
> > > > >   [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp :
> > > > > ffffffc008013770
> > > > > =

> > > > > Fixes: 3382a1ed7f77 ("net: fix udp gso skb_segment after pull
> > > > > from
> > > > > frag_list")
> > > > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > > > ---
> > > > >  net/ipv4/udp_offload.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > > =

> > > > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > > > index 19d0b5b09ffa..606d9ce8c98e 100644
> > > > > --- a/net/ipv4/udp_offload.c
> > > > > +++ b/net/ipv4/udp_offload.c
> > > > > @@ -535,6 +535,12 @@ struct sk_buff *__udp_gso_segment(struct
> > > > > sk_buff *gso_skb,
> > > > >                       uh->check =3D ~udp_v4_check(gso_skb->len,=

> > > > >                                                 ip_hdr(gso_skb)=

> > > > > -
> > > > > > saddr,
> > > > > =

> > > > >                                                 ip_hdr(gso_skb)=

> > > > > -
> > > > > > daddr, 0);
> > > > > =

> > > > > +     } else if (skb_shinfo(gso_skb)->frag_list && gso_skb-
> > > > > > head_frag =3D=3D 0) {
> > > > > =

> > > > > +             if (skb_pagelen(gso_skb) - sizeof(*uh) !=3D
> > > > > skb_shinfo(gso_skb)->gso_size) {
> > > > > +                     ret =3D __skb_linearize(gso_skb);
> > > > > +                     if (ret)
> > > > > +                             return ERR_PTR(ret);
> > > > > +             }
> > > > >       }
> > > > > =

> > > > >       skb_pull(gso_skb, sizeof(*uh));
> > > > > --
> > > > > 2.45.2
> > > > > =

> > > > =

> > > > =

> > =

> > =




