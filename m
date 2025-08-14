Return-Path: <netdev+bounces-213532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9CB2585F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549501C04F52
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F92710A1F;
	Thu, 14 Aug 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJS9CBR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E02FF64D
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131640; cv=none; b=qV2wCEE259MZ+Jp9bjFTYM25GBqnyIxD6jdD3W0cTJnOglvEHT5UyPV+42gbzrgSasnkHBZWq7ymrPRIyTOZXzqqs4uVMNMvIIws7D60F7+HTC+WU+6m5MMEyo+srYJbsJzjt1bdcqtwTiaJrcxX4xJ8png3tsSUi2SI04TwP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131640; c=relaxed/simple;
	bh=Y9M3Y6Xfj1LurTdy9YGuGG72NYG5WnUyk2b6lAnOTrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzUPlRigpygRwMC7rBu6EaMG6AQHJevlSAE6Ct5N2Ec8GkmshH2Zr0dokTNcsIpsXTFF0wy/oHuCVDqyEPRbJPTs1Y9rmvM5b8MkcAk5sEl97/o+JWFa9GbGFZYCrzBuTpcpVZhhAeuosh2RFEZZQA+7+7boG9r0xyk2W7JJBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJS9CBR3; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e571d40088so1276345ab.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755131637; x=1755736437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWRL0yvRLw+HWZc5+rldo2UC0zZtFic0t8vaTUjoURc=;
        b=GJS9CBR3buHrj23MEmrZtyMmbRaJK49bXqaq+7G2FP+8IKNBf0zrlM4CO0WJ70qj2d
         qp1u2LpvUJVj93PysBCCOzTDBy/ho+2pc0X8NoGAhRd2ZF+/xzfMwEPtJ2j3FR+1WPhc
         bxRX49Ck0YDGtnUIGQmLlqq7abn5n33kf7gR0BUQA6uDWT2d8HCcQ7J9elDsYbCal8f2
         6fhA9NqosHELLSLIJ3kEf43cgSN+Xb0T8LMZLlZfSKZOHhRstmyh4aOvV5yhoSwk47AO
         xpn8JHmHqEoftwWbArXjajbD1xpSH0bNLtzbSD2LUyb5VCO8IPEId1+geGSFSTgsn7lH
         8/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755131637; x=1755736437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWRL0yvRLw+HWZc5+rldo2UC0zZtFic0t8vaTUjoURc=;
        b=gxRoc2/XPwwi3dISkA3TsOCKAHb0/Blis5o7MUnoEW34VPDm966Fd/Ka7BEh24avbp
         +iAkD3bejDQMqrhBILtmC/9xADuNy7I8wLPShgrf6Jhvcrcs3Whpi/Nhd5ZIcHq51YQQ
         LIxwPXBN4rU4g+NYHIfoxZcC0S6nKdcAV8mpuKMItVxaO+lgmi7mrJCUJ20PcYE4gJ/1
         eId3Jp03sqoneVzF+EDH0Yce7FIOIcSEdfG3DgCuv/aceWPgL2wOsZspDOslVgxEsTdW
         72biEvoz++x/a1NtRKpUWECoQdwGM50Cqa4ltV0B4N8boXNp3y1M3hi6arhFn6VmceZN
         bu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUXawzYxq2gnfgFX31mCtYjH0PrQ1AuXH47kHYgPhxzX/O24zrN86kYaN8XVUVmVMfK8DOCYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWVaziGBAnCnywwMgNZ8HouJ2NsrBMN++sE5tOv88H5XuJmbC
	e3lD8lFQB9h/8VZjckd3anNlcCGFK8rKjIiyayu4S0OodM2fUR0WzWUqEDOs4qu7Iq3JjHFueOc
	Mv5JNJtfdrovRY8iWCOIzZ+n2P3v+F7A=
X-Gm-Gg: ASbGncvVfYMM1LzJzu7kFkTZb0usD7jxu2nF24jDS2Zu5V42Ee7POU1QCeKhOCWyPnq
	VSPpMIQ+4WQ+6austTNytqSQ5hlFZpZxlppmqpSdRJUC1hMLXPo1ldbHxWFU+oQejWgNJrV5OAS
	TJSHziYTr2/E47MKMWayQgFk1TyBhlkppQf4f0L16a17vriuHIDegDkGAfECLeRHnGqbqQdfOD6
	CWbmUg=
X-Google-Smtp-Source: AGHT+IEKnF67Wj3kFQRPW4QIMVtxk50Qleoibrw/iPkN3/yxV/MJhq6yiRlxORVlyLswpy8WUlKs9z/vkKsTt8Tzp/E=
X-Received: by 2002:a05:6e02:184c:b0:3e5:4ca1:b4ba with SMTP id
 e9e14a558f8ab-3e571e5c12amr16683015ab.21.1755131637072; Wed, 13 Aug 2025
 17:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
 <20250812075504.60498-4-kerneljasonxing@gmail.com> <aJtg0gsR6paO22eQ@boxer>
 <CAL+tcoAGq1DhjF42qYH_yVPf9PqmMknn79WF2SncXFJmP0fDhg@mail.gmail.com> <aJzUqg5m3sKPWDe0@boxer>
In-Reply-To: <aJzUqg5m3sKPWDe0@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 14 Aug 2025 08:33:20 +0800
X-Gm-Features: Ac12FXwcv2p-1O0Bnl_6z-OTJunZGPvvbkLVbhfXRr0fI7LQtvzYqQsVi54a5s8
Message-ID: <CAL+tcoCC8yVS9R9bky4XatgJmX4bzrV8Pio6+jwyMSmKo0UiSw@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2 3/3] ixgbe: xsk: support batched xsk Tx
 interfaces to increase performance
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, sdf@fomichev.me, 
	larysa.zaremba@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:09=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Aug 13, 2025 at 08:34:52AM +0800, Jason Xing wrote:
> > Hi Maciej,
> >
> > On Tue, Aug 12, 2025 at 11:42=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Tue, Aug 12, 2025 at 03:55:04PM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > >
> > > Hi Jason,
> > >
> > > patches should be targetted at iwl-next as these are improvements, no=
t
> > > fixes.
> >
> > Oh, right.
> >
> > >
> > > > Like what i40e driver initially did in commit 3106c580fb7cf
> > > > ("i40e: Use batched xsk Tx interfaces to increase performance"), us=
e
> > > > the batched xsk feature to transmit packets.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > In this version, I still choose use the current implementation. Las=
t
> > > > time at the first glance, I agreed 'i' is useless but it is not.
> > > > https://lore.kernel.org/intel-wired-lan/CAL+tcoADu-ZZewsZzGDaL7Nugx=
FTWO_Q+7WsLHs3Mx-XHjJnyg@mail.gmail.com/
> > >
> > > dare to share the performance improvement (if any, in the current for=
m)?
> >
> > I tested the whole series, sorry, no actual improvement could be seen
> > through xdpsock. Not even with the first series. :(
>
> So if i were you i would hesitate with posting it :P in the past batching

(I'm definitely not an intel nic expert but still willing to write
some codes on the driver side. I need to study more.)

> approaches always yielded performance gain.

No, I still assume no better numbers can be seen with xdpsock even
with further tweaks. Especially yesterday I saw the zerocopy mode
already hit 70% of full speed, which means in all likelihood that is
the bottleneck. That is also the answer to what you questioned in that
patch[0]. Zerocopy mode for most advanced NICs must be much better for
copy mode except for ixgbe, somehow standing for the maximum
throughput of af_xdp.

[0]: https://lore.kernel.org/all/CAL+tcoAst1xs=3DxCLykUoj1=3DVj-0LtVyK-qrcD=
yoy4mQrHgW1kg@mail.gmail.com/

>
> >
> > >
> > > also you have not mentioned in v1->v2 that you dropped the setting of
> > > xdp_zc_max_segs, which is a step in a correct path.

In v1, you asked me to give up the multi buffer function[1] so I did
it. Yesterday, I wrongly corrected myself and made me think
xdp_zc_max_segs is related to the batch process.

IIUC, you have these multi buffer patches locally or you decided to
accomplish them?

[1]: https://lore.kernel.org/intel-wired-lan/aINVrP8vrxIkxhZr@boxer/

> >
> > Oops, I blindly dropped the last patch without carefully checking it.
> > Thanks for showing me.
> >
> > I set it as four for ixgbe. I'm not that sure if there is any theory
> > behind setting this value?
>
> you're confusing two different things. xdp_zc_max_segs is related to
> multi-buffer support in xsk zc whereas you're referring to loop unrolling
> counter.

No, actually I'm confusing the idea behind the value of xdp_zc_max_segs.

>
> >
> > >
> > > > ---
> > > >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 106 +++++++++++++--=
----
> > > >  1 file changed, 72 insertions(+), 34 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers=
/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > index f3d3f5c1cdc7..9fe2c4bf8bc5 100644
> > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > @@ -2,12 +2,15 @@
> > > >  /* Copyright(c) 2018 Intel Corporation. */
> > > >
> > > >  #include <linux/bpf_trace.h>
> > > > +#include <linux/unroll.h>
> > > >  #include <net/xdp_sock_drv.h>
> > > >  #include <net/xdp.h>
> > > >
> > > >  #include "ixgbe.h"
> > > >  #include "ixgbe_txrx_common.h"
> > > >
> > > > +#define PKTS_PER_BATCH 4
> > > > +
> > > >  struct xsk_buff_pool *ixgbe_xsk_pool(struct ixgbe_adapter *adapter=
,
> > > >                                    struct ixgbe_ring *ring)
> > > >  {
> > > > @@ -388,58 +391,93 @@ void ixgbe_xsk_clean_rx_ring(struct ixgbe_rin=
g *rx_ring)
> > > >       }
> > > >  }
> > > >
> > > > -static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned in=
t budget)
> > > > +static void ixgbe_set_rs_bit(struct ixgbe_ring *xdp_ring)
> > > > +{
> > > > +     u16 ntu =3D xdp_ring->next_to_use ? xdp_ring->next_to_use - 1=
 : xdp_ring->count - 1;
> > > > +     union ixgbe_adv_tx_desc *tx_desc;
> > > > +
> > > > +     tx_desc =3D IXGBE_TX_DESC(xdp_ring, ntu);
> > > > +     tx_desc->read.cmd_type_len |=3D cpu_to_le32(IXGBE_TXD_CMD_RS)=
;
> > >
> > > you have not addressed the descriptor cleaning path which makes this
> > > change rather pointless or even the driver behavior is broken.
> >
> > Are you referring to 'while (ntc !=3D ntu) {}' in
> > ixgbe_clean_xdp_tx_irq()? But I see no difference between that part
> > and the similar part 'for (i =3D 0; i < completed_frames; i++) {}' in
> > i40e_clean_xdp_tx_irq()
>
>         if (likely(!tx_ring->xdp_tx_active)) {
>                 xsk_frames =3D completed_frames;
>                 goto skip;
>         }

Thanks for the instruction. I will append a patch similar to this[2]
into the series. It's exactly the one that helps ramping up speed.

[2]:
commit 5574ff7b7b3d864556173bf822796593451a6b8c
Author: Magnus Karlsson <magnus.karlsson@intel.com>
Date:   Tue Jun 23 11:44:16 2020 +0200

    i40e: optimize AF_XDP Tx completion path

    Improve the performance of the AF_XDP zero-copy Tx completion
    path. When there are no XDP buffers being sent using XDP_TX or
    XDP_REDIRECT, we do not have go through the SW ring to clean up any
    entries since the AF_XDP path does not use these. In these cases, just
    fast forward the next-to-use counter and skip going through the SW
    ring. The limit on the maximum number of entries to complete is also
    removed since the algorithm is now O(1). To simplify the code path, the
    maximum number of entries to complete for the XDP path is therefore
    also increased from 256 to 512 (the default number of Tx HW
    descriptors). This should be fine since the completion in the XDP path
    is faster than in the SKB path that has 256 as the maximum number.

> >
> > >
> > > point of such change is to limit the interrupts raised by HW once it =
is
> > > done with sending the descriptor. you still walk the descs one-by-one=
 in
> > > ixgbe_clean_xdp_tx_irq().
> >
> > Sorry, I must be missing something important. In my view only at the
> > end of ixgbe_xmit_zc(), ixgbe always kicks the hardware through
> > ixgbe_xdp_ring_update_tail() before/after this series.
> >
> > As to 'one-by-one', I see i40e also handles like that in 'for (i =3D 0;
> > i < completed_frames; i++)' in i40e_clean_xdp_tx_irq(). Ice does this
> > in ice_clean_xdp_irq_zc()?
>
> i40e does not look up DD bit from descriptor. plus this loop you refer to
> is taken only when (see above) xdp_tx_active is not 0 (meaning that there
> have been some XDP_TX action on queue and we have to clean the buffer in =
a
> different way).

I think until now I know what to do next: implement xdp_tx_active function.

>
> in general i would advise to look at ice as i40e writes back the tx ring
> head which is used in cleaning logic. ice does not have this feature,
> neither does ixgbe.

Thanks. I will also dig into those datasheets that are all I have.

Thanks,
Jason

