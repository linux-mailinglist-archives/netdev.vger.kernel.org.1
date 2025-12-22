Return-Path: <netdev+bounces-245777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0CCD7697
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 00:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701BA301F27A
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873A3128A9;
	Mon, 22 Dec 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMD2HgiA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7B1A9FBC
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444428; cv=pass; b=Npvxb/VGf0C2x/1eKbdnoiMnlEWznshTtqjIQslSFSpzfzsBMGAC2zoIHUa170x27IrQ3MRWT+flg9edDW3kxK3d4/G6ADOnGUA+nPoAaxbCZtWghKjz5biZT8NBKYmR+eglrtuBMp9N9vxQyuOqJNCLj3M86npoJ90MJ62vbFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444428; c=relaxed/simple;
	bh=NNVVY4Keo0ZlYz/N9p6/UToaHmJPGciEr6zVPCPklgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlcDw1HwycG+YnHlcRJKSoyYapT+13zRjMfrGAO/GnLxXU/gK9SVm5chW2llusuQmgEZaKiaF2WheAfYeAW6xVr8BuBVHcxke0qUBNVRU+FtPkKP27OFOY2SkNEZxmV3g4z6B9ohWaXZb97f/lYeYiVRmcwlGwh+LvFzy3eBUeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMD2HgiA; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957eeb9d8aso26108e87.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 15:00:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766444424; cv=none;
        d=google.com; s=arc-20240605;
        b=MNJXIDXBnpAPOq/ST3Nz0K3++oT7vySH0EkIw84TkWI3DvdsE1RAPDSam2Q+nzt+yR
         EHvGDMIWZQ1Lo85EFtAhytrqJFcdTitYOq7GJx0HoeQtiIIWxgh2zhcpOAOQ/qojLQvm
         AM6fA/VjDks82u2ge8Wb0VpAdQuc4LWMy5I+6Z6pIcMUk5JPDfa89GLNk6IRJFy7w55L
         mEqSwzJE4tIs+rEZTrrijO6WwpOQQjGLi97XofOPTq3+kDjFsPYD1Xa0mjuWByGJHmz6
         77EJcWv+SFdUp/xxsu/9U/aZzi4IyYMTtD3v+xJ2ye2MjvmMMkd7nSLiBL5VSUIUMgpB
         Dn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GiffbNV/tBskPZdgVWnbq8D6KwPgfDWsmkGacg7NIk=;
        fh=3ts7cXz/DEzRqVOpc+infopmkC+b2+mSQ06EapHOsZU=;
        b=TipJVKd5ZqaYuCzMAsgWaBOAtjzOcft4oshBiKWB/csLhKyqPGgeagr0CmBn9/Gt2S
         tXSNNvGCvRIDLZ/x2EToSxhEH82J1SWTRxEHVz2VfvncFQX4mBNzx/IafVqwQW+ziZUm
         wtdizGjFC7MbmcoHU9iKu2V02qPyKMYo9MzuXOifyt+YcUg4G33OSGnA/miJOH8K0dL8
         8c16A6C2RBVQmoxEefcM3fYNEep4Vj9z6HVrEIBKU8+uzOtBmXe/pVyV5ur8GdqvP6Hb
         hKyczf6bc0raYWHLn9hjptxMCAoLs7YsiOz1KNuHor3FHyjdXmuUKMs9eQcldIfdISSV
         H1Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766444424; x=1767049224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GiffbNV/tBskPZdgVWnbq8D6KwPgfDWsmkGacg7NIk=;
        b=lMD2HgiAlhgl5O8Lt8co9ufkZSMXN4lov1zZ2yOBbJ6e32iH1UAI/bALUl4pab0rPF
         0tn0W/WoZcTRy2CHYHRG156i9kMipIbiiQ6Pmkmi620Hiq1lwfrk+7ZAWHldTLUR7tRz
         zb4VSLNU42gCC8b+246Zx0h2LKJyQBzNE2z+vl4j9mm3mK9M/2hoWRGgsgaeBebPAUcQ
         YmovxaRS0OXv2pP6WVXd0WV5cPlNMDR0S7G3ol6cyiIIjaAICXSAUnN+4ZOeqGDKb6E5
         pfk2SfXpyIJ4a2KtvmUiZUjBiUkZ00pri9kOkiO+jFaHDrn294aygbSGZ7KXI98Xm6zy
         6/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766444424; x=1767049224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GiffbNV/tBskPZdgVWnbq8D6KwPgfDWsmkGacg7NIk=;
        b=wLfPDLdHAMvJshWV1gJgsa05m0XxY1Xypy9JEf2Kx/qwNI8cpk+wPmnay9VyBhzdNn
         MxT/gfHj1SdLDHaLIDAVM2/Sb7d80hyxKaHW/ZWffziuY9/P/Of7De//pQNhSi0KX+4V
         UloUpF7WOpasm4aeQiYY2becldHzH/U7ogsNbfDNXUInLdq9zXD36SXffVox98MhB2e4
         VxgA8OJhHlWsf1iXFzemRD61uH+qL2Yj1HN1l0fN7/Xyslffpz5P0FKC4urSvxaljCIk
         9wxIafstq5NgqQyJSWEavoiZ67ak4cFIFdw2lLbSQORvn7JfB+j8Q1gdBZXvpw4ssGxl
         XOlg==
X-Gm-Message-State: AOJu0YwE25ycATpQkJ5Xb6BoQKRtbBzDcC873v4lcAN+DZxUNkXv65BX
	jrpiaZuE1L1DjA/smZsKz9Lwo2cPIp3y7A5Td5L+g7gwZJptW76E9YS7n/Ftt0Ffnwzanglmz90
	kD/ATMvF3WYSGIFAK/zcKRoXeaiVVIM1Zk/Ny9TmO
X-Gm-Gg: AY/fxX584HRlaMOC99PNMP8bQg3+cYavZ14DZQ4CapsBuiJZQcReEy/YddEC+HlJ7RJ
	vr30AvzGhXRtMDrs3yUNFC6sHqBgIVYG6ECEfps8aYzz4jC3YKBtyYoHeFihIdHR5Dgdb/FYag7
	DBqCF0nl/+uWlIu1gqirSPYwl3W20QFDshdQEXCwFYqgcqBIgtuqGqxNpOMtq54OG/VFQuubaZ2
	x6yOrJoEkC6ZCFFPuyDd9PHPC5jkPSYgGUq3E1nbyRVoSXkOxNU2oO3YX3+GNnobVwkXI4=
X-Google-Smtp-Source: AGHT+IFolDyi0gmcjOW3uPfmwLAvnys6fHTRSXsP7uqs5Jry5LkM+oYjXghvf2oLx1lTxeVLVgcdbG0gyQNcQI3f1Yk=
X-Received: by 2002:ac2:5dc6:0:b0:597:d6db:98fa with SMTP id
 2adb3069b0e04-59a1e6108c0mr182015e87.8.1766444423439; Mon, 22 Dec 2025
 15:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219202957.2309698-1-almasrymina@google.com> <870f89e4-aec2-4eb2-8a93-c80484866c6d@intel.com>
In-Reply-To: <870f89e4-aec2-4eb2-8a93-c80484866c6d@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 22 Dec 2025 15:00:11 -0800
X-Gm-Features: AQt7F2ou44GOcMewwcH4dPpJ1kZw_YlLZCYqXqchupAuxd4xBlvlogJgJKpaZLg
Message-ID: <CAHS8izOOyGTYkMct=VJM8jHmzQgXR7y143erxfMvkPOkVJrXJg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:55=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Mina Almasry <almasrymina@google.com>
> Date: Fri, 19 Dec 2025 20:29:54 +0000
>
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > The logic is similar to idpf_rx_hwtstamp, but the data is exported
> > as a BPF kfunc instead of appended to an skb.
> >
> > A idpf_queue_has(PTP, rxq) condition is added to check the queue
> > supports PTP similar to idpf_rx_process_skb_fields.
> >
> > Cc: intel-wired-lan@lists.osuosl.org
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >
> > ---
> >
> > v3: https://lore.kernel.org/netdev/20251218022948.3288897-1-almasrymina=
@google.com/
> > - Do the idpf_queue_has(PTP) check before we read qw1 (lobakin)
> > - Fix _qw1 not copying over ts_low on on !__LIBETH_WORD_ACCESS systems
> >   (AI)
> >
> > v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina=
@google.com/
> > - Fixed alphabetical ordering
> > - Use the xdp desc type instead of virtchnl one (required some added
> >   helpers)
> >
> > ---
> >  drivers/net/ethernet/intel/idpf/xdp.c | 31 +++++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/idpf/xdp.h | 22 ++++++++++++++++++-
> >  2 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethern=
et/intel/idpf/xdp.c
> > index 958d16f87424..0916d201bf98 100644
> > --- a/drivers/net/ethernet/intel/idpf/xdp.c
> > +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (C) 2025 Intel Corporation */
> >
> >  #include "idpf.h"
> > +#include "idpf_ptp.h"
> >  #include "idpf_virtchnl.h"
> >  #include "xdp.h"
> >  #include "xsk.h"
> > @@ -391,8 +392,38 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md =
*ctx, u32 *hash,
> >                                   pt);
> >  }
> >
> > +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *time=
stamp)
> > +{
> > +     const struct libeth_xdp_buff *xdp =3D (typeof(xdp))ctx;
> > +     struct idpf_xdp_rx_desc desc __uninitialized;
> > +     const struct idpf_rx_queue *rxq;
> > +     u64 cached_time, ts_ns;
> > +     u32 ts_high;
> > +
> > +     rxq =3D libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> > +
> > +     if (!idpf_queue_has(PTP, rxq))
> > +             return -ENODATA;
> > +
> > +     idpf_xdp_get_qw1(&desc, xdp->desc);
> > +
> > +     if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID)=
)
> > +             return -ENODATA;
> > +
> > +     cached_time =3D READ_ONCE(rxq->cached_phc_time);
> > +
> > +     idpf_xdp_get_qw3(&desc, xdp->desc);
> > +
> > +     ts_high =3D idpf_xdp_rx_ts_high(&desc);
> > +     ts_ns =3D idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high)=
;
> > +
> > +     *timestamp =3D ts_ns;
> > +     return 0;
> > +}
> > +
> >  static const struct xdp_metadata_ops idpf_xdpmo =3D {
> >       .xmo_rx_hash            =3D idpf_xdpmo_rx_hash,
> > +     .xmo_rx_timestamp       =3D idpf_xdpmo_rx_timestamp,
> >  };
> >
> >  void idpf_xdp_set_features(const struct idpf_vport *vport)
> > diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethern=
et/intel/idpf/xdp.h
> > index 479f5ef3c604..9daae445bde4 100644
> > --- a/drivers/net/ethernet/intel/idpf/xdp.h
> > +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> > @@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
> >       aligned_u64             qw1;
> >  #define IDPF_XDP_RX_BUF              GENMASK_ULL(47, 32)
> >  #define IDPF_XDP_RX_EOP              BIT_ULL(1)
> > +#define IDPF_XDP_RX_TS_LOW   GENMASK_ULL(31, 24)
> >
> >       aligned_u64             qw2;
> >  #define IDPF_XDP_RX_HASH     GENMASK_ULL(31, 0)
> >
> >       aligned_u64             qw3;
> > +#define IDPF_XDP_RX_TS_HIGH  GENMASK_ULL(63, 32)
> >  } __aligned(4 * sizeof(u64));
> >  static_assert(sizeof(struct idpf_xdp_rx_desc) =3D=3D
> >             sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
> > @@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) =3D=
=3D
> >  #define idpf_xdp_rx_buf(desc)        FIELD_GET(IDPF_XDP_RX_BUF, (desc)=
->qw1)
> >  #define idpf_xdp_rx_eop(desc)        !!((desc)->qw1 & IDPF_XDP_RX_EOP)
> >  #define idpf_xdp_rx_hash(desc)       FIELD_GET(IDPF_XDP_RX_HASH, (desc=
)->qw2)
> > +#define idpf_xdp_rx_ts_low(desc)     FIELD_GET(IDPF_XDP_RX_TS_LOW, (de=
sc)->qw1)
> > +#define idpf_xdp_rx_ts_high(desc)    FIELD_GET(IDPF_XDP_RX_TS_HIGH, (d=
esc)->qw3)
> >
> >  static inline void
> >  idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
> > @@ -149,7 +153,10 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
> >       desc->qw1 =3D ((const typeof(desc))rxd)->qw1;
> >  #else
> >       desc->qw1 =3D ((u64)le16_to_cpu(rxd->buf_id) << 32) |
> > -                 rxd->status_err0_qw1;
> > +                     ((u64)rxd->ts_low << 24) |
> > +                     ((u64)rxd->fflags1 << 16) |
> > +                     ((u64)rxd->status_err1 << 8) |
>
> I'm not sure you need casts to u64 here. Pls rebuild without them and
> check the objdiff / compiler warnings.
> It's required for buf_id as we shift by 32.
>

The compiler does not warn if I drop the u64 casts, but are you sure
you want them dropped? You're already doing u64 casts in all the
entries that you bit-shift in qw0 and qw2. It makes the code clearer
imo. But up to you.

> > +                     rxd->status_err0_qw1;
>
> Why did you replace the proper indentation with two tabs in all 4 lines
> above?
>

Sure, will fix.

--=20
Thanks,
Mina

