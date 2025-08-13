Return-Path: <netdev+bounces-213129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55804B23D11
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2B7581152
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691F4685;
	Wed, 13 Aug 2025 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnsMid0H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8672C0F89
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045331; cv=none; b=qUSDMgQmAN5wFEQJRq6ictE0rdki5wf8eP/2D0OhL5PSkqLcv5+pC5OonVRSURrt20JBUjAe1c92v1ArFQu4JoexbotQ7rMDA1KcT3qvU1zVwZ9Ou2yEgJt7j3V6RaoDGJtbHXAqLBekT/GDOf0ZDy7RDThIvcCoC9a90U1SeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045331; c=relaxed/simple;
	bh=6PXNIz/7XfMvt1SqTuAJpezeqbKcOiQvJZfJkj1tHlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9HkIfAk6EWhiAuRvaO8d8ysUqpXOd47uKQGyku+cyJaSDPiwcLPIstHGrOx4JgFH06KcoqOdArYOAHKz1VU3uc8x0A0n/567f3B8LQeBoIISYzUzirtab12ZJFJtl9P4DBhEooNXUTlKNad2e6nPRmJln3IEsgwaM4TijKD95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnsMid0H; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-879c737bc03so151330639f.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755045329; x=1755650129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZE850cHcxA42tkC6rSziIjkShOIH4fUX6GWfF2o1Do=;
        b=PnsMid0HsER//AcW6yd+dSClm5lV9MdQFZctaNmu67TbsBbofHh+w/Uz5KStzhGEqh
         NLF+yhLtG4dut5F3fWolvHWvgHtzf76dR/Kn4oveHluXu82Fwvis3yWaoKZLnqhVwqLU
         r126DtpYIjCysmlro/eVdaUDvj5wGUXuZ97KUj1mRFOib9ysbmXcPBMQE7TL8M9pYxQr
         P1lU1c59RCTGxxFDeZqCf2i8ayeAJ35++QzhNYfDWKThUuKJLBQfQSzH3VSLZIMF8H/B
         /SHjG2UzT+8NrIq1alCVmNA4hAmX23vEh9+5AhaqFAGBhXq3LOcKupvY3XDd3HJZT+gR
         OvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045329; x=1755650129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZE850cHcxA42tkC6rSziIjkShOIH4fUX6GWfF2o1Do=;
        b=k8GoqTDiOVgG3DPVAxjE8oZ93SikSw3bK/Am73fj+NnfqJzQTP3G0kpfQWgpJfUsLt
         z4igypbBP6YpMgbIpRVAteyQYkbeGFdWP5MKSFPi4DMOEhKQuG2brcAr5r82zrMZ29RG
         7xFMSsPcTsITrm711+RdSJj6oJTNfDj2WLIbitF2kjA/n69Thb9wCq2ufGOctkWxSie+
         AstrjYfwqosVVkKZcxyqF54DsWlV1/RDvivzc28dugh3Qz5wKBOegUSICnkmfEIJJCr3
         ewR/YBEzXq+JxJA0UGPF2/iAF67Zd+zy+MFCQcI5InWL+AsOLZnLhac+lsaQmAJlxLn7
         vIgw==
X-Forwarded-Encrypted: i=1; AJvYcCXZH+inupYJRCatp+dk5RNKl4zLhPY4LV4uumibs7pBNtU1VZDHKzSma4fh7uD7i41R2Zen4+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMP7aCjmksqaCvz3XvL/jF7w7UvQmxvRnRkJC3gC7JjNcdozjN
	qMZc2BBOZglJyuSOWZYJ+dZDw/pZe4Qx+ZJQkS30wjcvc213ZQPS36bckMzAfjrWq/aidJLHOtM
	SgbJ8YTbUhRfWcso79t5R6CdNuEKN4ig=
X-Gm-Gg: ASbGnctiUryN4mYtP6Xa2ze1Ll4nP4/sWKta0ydeAALIiofXlbMdHWgVVpu6BZ0IC0/
	3wJ0kHlaXevEZPttigkG4pEYxmjYCVRqzslyPeoB03iXVXclcmdGgZFf5CvcZ/Y/7Xec1Dg7BEg
	PjuhhNNnWgv7FuwULU5kKUZZRTGFdZxwvKAMbsDs+Bqq2BbBM6E9hKBOrcX586bNqh4kYCLXBix
	NEH04s=
X-Google-Smtp-Source: AGHT+IGNhApSylNhif5bi0LBKjDMOGVL3P0LOVLl4XdVysv0taJHy+61fO/tffUMSHPhBe4SeUU+9Fwmmbe9efi93/w=
X-Received: by 2002:a05:6602:c85:b0:881:8bc8:b02d with SMTP id
 ca18e2360f4ac-8842969fd9dmr251224839f.12.1755045328762; Tue, 12 Aug 2025
 17:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
 <20250812075504.60498-4-kerneljasonxing@gmail.com> <aJtg0gsR6paO22eQ@boxer>
In-Reply-To: <aJtg0gsR6paO22eQ@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Aug 2025 08:34:52 +0800
X-Gm-Features: Ac12FXxyDzIzfAG-vV__5xs4GvdEbej64C7rDCBw4XMjRL9S7cY6385YSYFUzc0
Message-ID: <CAL+tcoAGq1DhjF42qYH_yVPf9PqmMknn79WF2SncXFJmP0fDhg@mail.gmail.com>
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

Hi Maciej,

On Tue, Aug 12, 2025 at 11:42=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Aug 12, 2025 at 03:55:04PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
>
> Hi Jason,
>
> patches should be targetted at iwl-next as these are improvements, not
> fixes.

Oh, right.

>
> > Like what i40e driver initially did in commit 3106c580fb7cf
> > ("i40e: Use batched xsk Tx interfaces to increase performance"), use
> > the batched xsk feature to transmit packets.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > In this version, I still choose use the current implementation. Last
> > time at the first glance, I agreed 'i' is useless but it is not.
> > https://lore.kernel.org/intel-wired-lan/CAL+tcoADu-ZZewsZzGDaL7NugxFTWO=
_Q+7WsLHs3Mx-XHjJnyg@mail.gmail.com/
>
> dare to share the performance improvement (if any, in the current form)?

I tested the whole series, sorry, no actual improvement could be seen
through xdpsock. Not even with the first series. :(

>
> also you have not mentioned in v1->v2 that you dropped the setting of
> xdp_zc_max_segs, which is a step in a correct path.

Oops, I blindly dropped the last patch without carefully checking it.
Thanks for showing me.

I set it as four for ixgbe. I'm not that sure if there is any theory
behind setting this value?

>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 106 +++++++++++++------
> >  1 file changed, 72 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net=
/ethernet/intel/ixgbe/ixgbe_xsk.c
> > index f3d3f5c1cdc7..9fe2c4bf8bc5 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > @@ -2,12 +2,15 @@
> >  /* Copyright(c) 2018 Intel Corporation. */
> >
> >  #include <linux/bpf_trace.h>
> > +#include <linux/unroll.h>
> >  #include <net/xdp_sock_drv.h>
> >  #include <net/xdp.h>
> >
> >  #include "ixgbe.h"
> >  #include "ixgbe_txrx_common.h"
> >
> > +#define PKTS_PER_BATCH 4
> > +
> >  struct xsk_buff_pool *ixgbe_xsk_pool(struct ixgbe_adapter *adapter,
> >                                    struct ixgbe_ring *ring)
> >  {
> > @@ -388,58 +391,93 @@ void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *r=
x_ring)
> >       }
> >  }
> >
> > -static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int bu=
dget)
> > +static void ixgbe_set_rs_bit(struct ixgbe_ring *xdp_ring)
> > +{
> > +     u16 ntu =3D xdp_ring->next_to_use ? xdp_ring->next_to_use - 1 : x=
dp_ring->count - 1;
> > +     union ixgbe_adv_tx_desc *tx_desc;
> > +
> > +     tx_desc =3D IXGBE_TX_DESC(xdp_ring, ntu);
> > +     tx_desc->read.cmd_type_len |=3D cpu_to_le32(IXGBE_TXD_CMD_RS);
>
> you have not addressed the descriptor cleaning path which makes this
> change rather pointless or even the driver behavior is broken.

Are you referring to 'while (ntc !=3D ntu) {}' in
ixgbe_clean_xdp_tx_irq()? But I see no difference between that part
and the similar part 'for (i =3D 0; i < completed_frames; i++) {}' in
i40e_clean_xdp_tx_irq()

>
> point of such change is to limit the interrupts raised by HW once it is
> done with sending the descriptor. you still walk the descs one-by-one in
> ixgbe_clean_xdp_tx_irq().

Sorry, I must be missing something important. In my view only at the
end of ixgbe_xmit_zc(), ixgbe always kicks the hardware through
ixgbe_xdp_ring_update_tail() before/after this series.

As to 'one-by-one', I see i40e also handles like that in 'for (i =3D 0;
i < completed_frames; i++)' in i40e_clean_xdp_tx_irq(). Ice does this
in ice_clean_xdp_irq_zc()?

Could you shed some light on this? Thanks in advance!

Thanks,
Jason

>
> > +}
> > +
> > +static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_des=
c *desc,
> > +                        int i)
> > +
> >  {
> >       struct xsk_buff_pool *pool =3D xdp_ring->xsk_pool;
> >       union ixgbe_adv_tx_desc *tx_desc =3D NULL;
> >       struct ixgbe_tx_buffer *tx_bi;
> > -     struct xdp_desc desc;
> >       dma_addr_t dma;
> >       u32 cmd_type;
> >
> > -     if (!budget)
> > -             return true;
> > +     dma =3D xsk_buff_raw_get_dma(pool, desc[i].addr);
> > +     xsk_buff_raw_dma_sync_for_device(pool, dma, desc[i].len);
> >
> > -     while (likely(budget)) {
> > -             if (!netif_carrier_ok(xdp_ring->netdev))
> > -                     break;
> > +     tx_bi =3D &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
> > +     tx_bi->bytecount =3D desc[i].len;
> > +     tx_bi->xdpf =3D NULL;
> > +     tx_bi->gso_segs =3D 1;
> >
> > -             if (!xsk_tx_peek_desc(pool, &desc))
> > -                     break;
> > +     tx_desc =3D IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
> > +     tx_desc->read.buffer_addr =3D cpu_to_le64(dma);
> >
> > -             dma =3D xsk_buff_raw_get_dma(pool, desc.addr);
> > -             xsk_buff_raw_dma_sync_for_device(pool, dma, desc.len);
> > +     cmd_type =3D IXGBE_ADVTXD_DTYP_DATA |
> > +                IXGBE_ADVTXD_DCMD_DEXT |
> > +                IXGBE_ADVTXD_DCMD_IFCS;
> > +     cmd_type |=3D desc[i].len | IXGBE_TXD_CMD_EOP;
> > +     tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
> > +     tx_desc->read.olinfo_status =3D
> > +             cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> >
> > -             tx_bi =3D &xdp_ring->tx_buffer_info[xdp_ring->next_to_use=
];
> > -             tx_bi->bytecount =3D desc.len;
> > -             tx_bi->xdpf =3D NULL;
> > -             tx_bi->gso_segs =3D 1;
> > +     xdp_ring->next_to_use++;
> > +}
> >
> > -             tx_desc =3D IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use=
);
> > -             tx_desc->read.buffer_addr =3D cpu_to_le64(dma);
> > +static void ixgbe_xmit_pkt_batch(struct ixgbe_ring *xdp_ring, struct x=
dp_desc *desc)
> > +{
> > +     u32 i;
> >
> > -             /* put descriptor type bits */
> > -             cmd_type =3D IXGBE_ADVTXD_DTYP_DATA |
> > -                        IXGBE_ADVTXD_DCMD_DEXT |
> > -                        IXGBE_ADVTXD_DCMD_IFCS;
> > -             cmd_type |=3D desc.len | IXGBE_TXD_CMD;
> > -             tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
> > -             tx_desc->read.olinfo_status =3D
> > -                     cpu_to_le32(desc.len << IXGBE_ADVTXD_PAYLEN_SHIFT=
);
> > +     unrolled_count(PKTS_PER_BATCH)
> > +     for (i =3D 0; i < PKTS_PER_BATCH; i++)
> > +             ixgbe_xmit_pkt(xdp_ring, desc, i);
> > +}
> >
> > -             xdp_ring->next_to_use++;
> > -             if (xdp_ring->next_to_use =3D=3D xdp_ring->count)
> > -                     xdp_ring->next_to_use =3D 0;
> > +static void ixgbe_fill_tx_hw_ring(struct ixgbe_ring *xdp_ring,
> > +                               struct xdp_desc *descs, u32 nb_pkts)
> > +{
> > +     u32 batched, leftover, i;
> > +
> > +     batched =3D nb_pkts & ~(PKTS_PER_BATCH - 1);
> > +     leftover =3D nb_pkts & (PKTS_PER_BATCH - 1);
> > +     for (i =3D 0; i < batched; i +=3D PKTS_PER_BATCH)
> > +             ixgbe_xmit_pkt_batch(xdp_ring, &descs[i]);
> > +     for (i =3D batched; i < batched + leftover; i++)
> > +             ixgbe_xmit_pkt(xdp_ring, &descs[i], 0);
> > +}
> >
> > -             budget--;
> > -     }
> > +static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int bu=
dget)
> > +{
> > +     struct xdp_desc *descs =3D xdp_ring->xsk_pool->tx_descs;
> > +     u32 nb_pkts, nb_processed =3D 0;
> >
> > -     if (tx_desc) {
> > -             ixgbe_xdp_ring_update_tail(xdp_ring);
> > -             xsk_tx_release(pool);
> > +     if (!netif_carrier_ok(xdp_ring->netdev))
> > +             return true;
> > +
> > +     nb_pkts =3D xsk_tx_peek_release_desc_batch(xdp_ring->xsk_pool, bu=
dget);
> > +     if (!nb_pkts)
> > +             return true;
> > +
> > +     if (xdp_ring->next_to_use + nb_pkts >=3D xdp_ring->count) {
> > +             nb_processed =3D xdp_ring->count - xdp_ring->next_to_use;
> > +             ixgbe_fill_tx_hw_ring(xdp_ring, descs, nb_processed);
> > +             xdp_ring->next_to_use =3D 0;
> >       }
> >
> > -     return !!budget;
> > +     ixgbe_fill_tx_hw_ring(xdp_ring, &descs[nb_processed], nb_pkts - n=
b_processed);
> > +
> > +     ixgbe_set_rs_bit(xdp_ring);
> > +     ixgbe_xdp_ring_update_tail(xdp_ring);
> > +
> > +     return nb_pkts < budget;
> >  }
> >
> >  static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
> > --
> > 2.41.3
> >

