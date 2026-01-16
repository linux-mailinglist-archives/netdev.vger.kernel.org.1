Return-Path: <netdev+bounces-250596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF94D38454
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451F330DF3F7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F73A0B3C;
	Fri, 16 Jan 2026 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZSYx8qim"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F613A0B0E
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588102; cv=pass; b=rgBgxZ09eABgVCEHN7bhAYBqrrKbZP3zV5eJW9Cankw1FsR6B4xbyBiQZ6VLz5Yzo+/w7yZlTGxmaFi4DBPZ79Y8IAhCIlEN8+Ck1kjHzZ7e+UX3LsXl+lnXsIAyPfdOMU5+mruOHvsAFfenWtF2Z5gNP6dB4g8j2Y5TgHvQ4+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588102; c=relaxed/simple;
	bh=hEiHJCHCH7MnmxgD1OXRlUTQsh6q0pRvW5KIqdoOKRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APpW2S5+NdDpgeq0nbJAjtvoGPwOh43bhzRZx8unnvHZGTHYYcrX1uZ7RTX9S5EoZcj6UzIed4QVMa2qMRiJwplPPABa2+L6v+j/5btvKjJ7vYQgc1eYYG3NYhHmDokonC8kixWqZTzb3bJkgAJtlj5aY00mF7c3ixqsOJS+AaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZSYx8qim; arc=pass smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-1233b172f02so2879913c88.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768588100; x=1769192900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJ9Eel68dNCh0Xj1/0IOTNDmRZhCIQTRYkrG2DmCreU=;
        b=DfskLYg7SbGvUAGHwfxyyG8xHoR52AxnzDwCG8xGKXq8cyMTobhIkePS4nopXUYOo3
         cjd1S33iOnSjcSXR1JjXlWgJsWr07IRYkColZqE7TVUMjFFBmsXoi4ze2O1mOiAed4qs
         IOhU9ULLvL63J7MyfTUB8pS92pSbWLcTbOCzVQ3oKS/2kGSBde1vreuZw6Vwpwj75rEe
         sv6IgOjQEIi4sxzQjIuQoRbSqkLprOHQ0vLCRC/sAuhHTV6cyKpnNY6awJiCJy0lh2vQ
         8Jav0yCwFlkDiVeGV3pkd0X+wXvK4TSBatENcERE6EUHbE3yVzuV0TP9/vHUX8MaY/jf
         S/XQ==
X-Forwarded-Encrypted: i=2; AJvYcCUnIMXTQWLQUHAo2lbBNhp8tGWDt29MpZBt38JHYlJZaEQ4NV9TZFFQRRHvSFbW/HoDLT3OOzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOvn3G0T5zZpk6ntSo1bCJAs+ifQYlYcMR17moGheufdV0Ulz
	yeMTLQr+NURw3Oqxi5d5iPNpyhsClasGofUtzFJZp6c46uYaqHxK5GzZ+RW6Kp1OaJXU2qr7WzN
	yGF5+qqmxErFsNT+NgjIAAexYnVZiKkKk3KbaZ22EyCHHU9HwsFY6c3MPi7Oi2usc0+wv0QekLZ
	74GVTToaaGRzqTIUcE5amFd4FUibEIGHiDVBNiOcxnHRDyVVlTFI0Wnawb2zkeakFqtStdKB55E
	96e7WEnSEnp3fGgyQ==
X-Gm-Gg: AY/fxX4Ii/B+iUPwBqaNUb+CH0FdmYiZ6OebB/1AOJElPXzp2dKPth2KpYWo/RT1Utg
	cFVXh/X024xaNh6VU67g2vtsD72ln6e9p/HtuQRoBpfCM9XOoijCL6KWEG5XBCgOXrXbrAS5bkU
	22AKMBHJFTiFL35qefp3pha61jeRCRw7GOHjX5RZCqfEVU/pKnjUzXJBE8LQHhpBVwgVxQ2fsMJ
	/XdvfZa+NHJ6YiT1Gt1RdCtjwoaU5t+iyJRSb0fXjW013EbGRE2jzo/0v3Zbfq0YjSve0lwZSCa
	zYwwdFgO/JUCeOOcRV82tDqn9gihIIdTMmWVl8Fpk3Ds5vWqdqHGTe7xL5/qng9uhM60dUK3TQe
	kRMxfLkNW3nSavArsy/Z6EWJkE3NaLkOaQhYERQWA+sOjD3njw9vPNeyCOHkJQMtM97KtAv3c+S
	oWH43l+nvXl2SO+nOwGSeRdtzhBAXYTBGfU4SkqeURk20yWtnQ0oBs8g==
X-Received: by 2002:a05:7022:914:b0:11b:7dcd:ca9a with SMTP id a92af1059eb24-1244a744f0fmr3598237c88.34.1768588099652;
        Fri, 16 Jan 2026 10:28:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1244a893bf1sm723908c88.0.2026.01.16.10.28.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 10:28:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b21d136010so3803709eec.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:28:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768588098; cv=none;
        d=google.com; s=arc-20240605;
        b=kBiceOT/rDcUmgFgqI/6L1rcjWwLx59InaU8QZJMbqZDDtZ2YX4PtgIDDS3goyjhi7
         ICnU7QTcYPG5rgYLRtuvrDfcSe8SUwgM9wpPeNu5S8puJ4v/YFdun01eAwkLXZh9lOC+
         7Rzo4H2wFHPBeSQ9y99IZix3pBHd4RwpyRC9gSrEU827OUPSnOf6ykUYXKC+MT4fvOOh
         vgYzDY6oUfwbuZE+3QfdGevCAKZJv43CAGuOGsb+BQMvIH+uV24is+SVWJfGUi5qwKfs
         geUwpwV13rH9kOsEIic55i/hgkHCbVsqSTBVcNLNQCVvT4+Mfc1locSMnyA0FMj9s+hg
         2ZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JJ9Eel68dNCh0Xj1/0IOTNDmRZhCIQTRYkrG2DmCreU=;
        fh=7kLfm4GSJ4oudBcCqdgm1hmgaJ7zlC1P0JK4wYwtfUQ=;
        b=YmxI70gdnrULNmdujmVjPj0I2KHXuyVw5AaslDQ9BWYnw8vDivaUi0kDfPpzc97WRy
         0SPT06RuW6yQ+HU+2MHpXwQoBNFBv3Cuax6HO4AzDn+4usLbNEo8Ol+ihdWYXN6dJjv8
         4LCDsUbPofyQxh2+SRVhE9WcS9OYFaKg7g+sUhOfvYFhO/Y7kKYz4AvoXYO34pNq+pCc
         /rlqPUK18HBcZG2f51Unr8izk42DbxrS/hw/AJ9L58nU+vT0Y25sKZxSJnIldmpS5R7A
         ZklUEp4kp8Ci+YJPCZSWbpWuikcXzQmwRvuRXAzq94TkB3map+5AqtrNlNv8IqWWNAEz
         IxtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768588098; x=1769192898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ9Eel68dNCh0Xj1/0IOTNDmRZhCIQTRYkrG2DmCreU=;
        b=ZSYx8qimbGhpkyN7X9weoVD+bIWFxN74nzR7OEMKE4epAZQJekoVkAKej0sbisb2pQ
         IZjP9weisvDCXbLQFX1pjmUn7dFygNehU9bXl8TZOYMJXsJmttleI14dlm+pDrZ+Tn2I
         Fxdt//2mD4xcaimZcrtrCwgcDT70iSrfFlCvI=
X-Forwarded-Encrypted: i=1; AJvYcCWGjFzCWwhAUl8jc1zphX92uatUk6s4ePZkXfqT70NvlwZ4xEvwyJogoXctIKY45QrFEUD/2Os=@vger.kernel.org
X-Received: by 2002:a05:7300:c86:b0:2a4:3592:c60b with SMTP id 5a478bee46e88-2b6b40ca597mr3185210eec.28.1768588096388;
        Fri, 16 Jan 2026 10:28:16 -0800 (PST)
X-Received: by 2002:a05:7300:c86:b0:2a4:3592:c60b with SMTP id
 5a478bee46e88-2b6b40ca597mr3185108eec.28.1768588094331; Fri, 16 Jan 2026
 10:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-3-bhargava.marreddy@broadcom.com> <fdbab5d5-63e1-49ef-a5a0-95903a469fd9@oracle.com>
In-Reply-To: <fdbab5d5-63e1-49ef-a5a0-95903a469fd9@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 16 Jan 2026 23:58:01 +0530
X-Gm-Features: AZwV_QgivoXR31HpRGDxTfcJGNp9qpPfNTXsCHTEvxJJSihwZWuOPokMu_zt_Xk
Message-ID: <CANXQDtaKPerCir9PGddZ3YDf-0MhjtBu4hXgRew93Xj42V2bzA@mail.gmail.com>
Subject: Re: [v4, net-next 2/7] bng_en: Add RX support
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005c042a0648858164"

--0000000000005c042a0648858164
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:36=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.=
com> wrote:
>
>
>
> On 1/5/2026 12:51 PM, Bhargava Marreddy wrote:
> > Add support to receive packet using NAPI, build and deliver the skb
> > to stack. With help of meta data available in completions, fill the
> > appropriate information in skb.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> > ---
> >   drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
> >   .../net/ethernet/broadcom/bnge/bnge_hw_def.h  | 198 ++++++
> >   .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 113 +++-
> >   .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  60 +-
> >   .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 573 +++++++++++++++++=
+
> >   .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  90 +++
> >   6 files changed, 1016 insertions(+), 21 deletions(-)
> >   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> >   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> >   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> >
> > +
> > +static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_i=
nfo *cpr,
> > +                         int budget)
> > +{
> > +     struct bnge_napi *bnapi =3D cpr->bnapi;
> > +     u32 raw_cons =3D cpr->cp_raw_cons;
> > +     struct tx_cmp *txcmp;
> > +     int rx_pkts =3D 0;
> > +     u8 event =3D 0;
> > +     u32 cons;
> > +
> > +     cpr->has_more_work =3D 0;
> > +     cpr->had_work_done =3D 1;
> > +     while (1) {
> > +             u8 cmp_type;
> > +             int rc;
> > +
> > +             cons =3D RING_CMP(bn, raw_cons);
> > +             txcmp =3D &cpr->desc_ring[CP_RING(cons)][CP_IDX(cons)];
> > +
> > +             if (!TX_CMP_VALID(bn, txcmp, raw_cons))
> > +                     break;
> > +
> > +             /* The valid test of the entry must be done first before
> > +              * reading any further.
> > +              */
> > +             dma_rmb();
> > +             cmp_type =3D TX_CMP_TYPE(txcmp);
> > +             if (cmp_type =3D=3D CMP_TYPE_TX_L2_CMP ||
> > +                 cmp_type =3D=3D CMP_TYPE_TX_L2_COAL_CMP) {
> > +                     /*
> > +                      * Tx Compl Processng
>
> typo -> Processng

Thanks, Alok. I will fix the typo in the next spin.

>
> > +                      */
> > +             } else if (cmp_type >=3D CMP_TYPE_RX_L2_CMP &&
> > +                        cmp_type <=3D CMP_TYPE_RX_L2_TPA_START_V3_CMP)=
 {
> > +                     if (likely(budget))
> > +                             rc =3D bnge_rx_pkt(bn, cpr, &raw_cons, &e=
vent);
> > +                     else
> > +                             rc =3D bnge_force_rx_discard(bn, cpr, &ra=
w_cons,
> > +                                                        &event);
> > +                     if (likely(rc >=3D 0))
> > +                             rx_pkts +=3D rc;
> > +                     /* Increment rx_pkts when rc is -ENOMEM to count =
towards
> > +                      * the NAPI budget.  Otherwise, we may potentiall=
y loop
> > +                      * here forever if we consistently cannot allocat=
e
> > +                      * buffers.
> > +                      */
> > +                     else if (rc =3D=3D -ENOMEM && budget)
> > +                             rx_pkts++;
> > +                     else if (rc =3D=3D -EBUSY)  /* partial completion=
 */
> > +                             break;
> > +             }
> > +
> > +             raw_cons =3D NEXT_RAW_CMP(raw_cons);
> > +
> > +             if (rx_pkts && rx_pkts =3D=3D budget) {
> > +                     cpr->has_more_work =3D 1;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     cpr->cp_raw_cons =3D raw_cons;
> > +     bnapi->events |=3D event;
> > +     return rx_pkts;
> > +}
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/n=
et/ethernet/broadcom/bnge/bnge_txrx.h
> > new file mode 100644
> > index 000000000000..b13081b0eb79
> > --- /dev/null
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2025 Broadcom */
> > +
> > +#ifndef _BNGE_TXRX_H_
> > +#define _BNGE_TXRX_H_
> > +
> > +#include <linux/bnxt/hsi.h>
> > +#include "bnge_netdev.h"
> > +
> > +#define BNGE_MIN_PKT_SIZE    52
> > +
> > +#define TX_OPAQUE_IDX_MASK   0x0000ffff
> > +#define TX_OPAQUE_BDS_MASK   0x00ff0000
> > +#define TX_OPAQUE_BDS_SHIFT  16
> > +#define TX_OPAQUE_RING_MASK  0xff000000
> > +#define TX_OPAQUE_RING_SHIFT 24
> > +
> > +#define SET_TX_OPAQUE(bn, txr, idx, bds)                             \
> > +     (((txr)->tx_napi_idx << TX_OPAQUE_RING_SHIFT) |                 \
> > +      ((bds) << TX_OPAQUE_BDS_SHIFT) | ((idx) & (bn)->tx_ring_mask))
> > +
> > +#define TX_OPAQUE_IDX(opq)   ((opq) & TX_OPAQUE_IDX_MASK)
> > +#define TX_OPAQUE_RING(opq)  (((opq) & TX_OPAQUE_RING_MASK) >>       \
> > +                              TX_OPAQUE_RING_SHIFT)
> > +#define TX_OPAQUE_BDS(opq)   (((opq) & TX_OPAQUE_BDS_MASK) >>        \
> > +                              TX_OPAQUE_BDS_SHIFT)
> > +#define TX_OPAQUE_PROD(bn, opq)      ((TX_OPAQUE_IDX(opq) + TX_OPAQUE_=
BDS(opq)) &\
> > +                              (bn)->tx_ring_mask)
> > +
> > +/* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1.  We need one=
 extra
> > + * BD because the first TX BD is always a long BD.
> > + */
> > +#define BNGE_MIN_TX_DESC_CNT         (MAX_SKB_FRAGS + 2)
> > +
> > +#define RX_RING(bn, x)       (((x) & (bn)->rx_ring_mask) >> (BNGE_PAGE=
_SHIFT - 4))
> > +#define RX_AGG_RING(bn, x)   (((x) & (bn)->rx_agg_ring_mask) >>      \
> > +                              (BNGE_PAGE_SHIFT - 4))
> > +#define RX_IDX(x)    ((x) & (RX_DESC_CNT - 1))
> > +
> > +#define TX_RING(bn, x)       (((x) & (bn)->tx_ring_mask) >> (BNGE_PAGE=
_SHIFT - 4))
> > +#define TX_IDX(x)    ((x) & (TX_DESC_CNT - 1))
> > +
> > +#define CP_RING(x)   (((x) & ~(CP_DESC_CNT - 1)) >> (BNGE_PAGE_SHIFT -=
 4))
> > +#define CP_IDX(x)    ((x) & (CP_DESC_CNT - 1))
> > +
> > +#define TX_CMP_VALID(bn, txcmp, raw_cons)                            \
> > +     (!!((txcmp)->tx_cmp_errors_v & cpu_to_le32(TX_CMP_V)) =3D=3D     =
   \
> > +      !((raw_cons) & (bn)->cp_bit))
> > +
> > +#define RX_CMP_VALID(rxcmp1, raw_cons)                                =
       \
> > +     (!!((rxcmp1)->rx_cmp_cfa_code_errors_v2 & cpu_to_le32(RX_CMP_V)) =
=3D=3D\
> > +      !((raw_cons) & (bn)->cp_bit))
>
> bn is not defined in macro

Ack, I will fix it in the next spin.

Thanks,
Bhargava Marreddy

>
> > +
> > +#define RX_AGG_CMP_VALID(bn, agg, raw_cons)                  \
> > +     (!!((agg)->rx_agg_cmp_v & cpu_to_le32(RX_AGG_CMP_V)) =3D=3D \
> > +      !((raw_cons) & (bn)->cp_bit))
> > +
> > +#define NQ_CMP_VALID(bn, nqcmp, raw_cons)                            \
> > +     (!!((nqcmp)->v & cpu_to_le32(NQ_CN_V)) =3D=3D !((raw_cons) & (bn)=
->cp_bit))
> > +
> > +#define TX_CMP_TYPE(txcmp)                                   \
> > +     (le32_to_cpu((txcmp)->tx_cmp_flags_type) & CMP_TYPE)
> > +
>
> Thanks,
> Alok

--0000000000005c042a0648858164
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDmXDm/sanpIusepLAOfzbS0KUAUkSRAg2CYZLpUha6wjAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTYxODI4MThaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCqFmTZ
YzYTPrROkJVmodI7glccFPZ916qLhnJkuBF9ns0pUeqz4uusykUhPivhQeEG4wgjK+cm0Zwv0hzg
e92167/RKkfwrMRbbBTnFTYuHm8dvJ+c47rPmu5Q76hdkbgooqrWUmedUbgCdmT7gcGy9G2/xzV6
qSwbdmMdqLjQ1YcRADz2OdzgyVXhE30LzBH/rXouvuRJNsebtcD7Pf92OFm6dSEl9YZB2MmBejiR
ZklwrtWqmuauICweyC2J+Ua2UhfErcW3GHt9lH1ZhMS7cVpn7ONk6PwoCO+jL5FsOX5xkKWOH29j
Vms5fdvKAwq/A4b4TPUdtpn8r8yMy24M
--0000000000005c042a0648858164--

