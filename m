Return-Path: <netdev+bounces-249151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E9D151E3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F414A301C3C9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467730F816;
	Mon, 12 Jan 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gHd2n8b7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDA3254A6
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247095; cv=none; b=pANrfXU9OqOxZ7deoGgTxIMVOKU7SDR9ctaMkEc299SK5pg6hTUzS/JIpwi5IeqHcsqdj2Mmlmcj8Rgf1m6TZlLnnLzhaUIYCc4vT73JtOqZyJyFhHjQgLOCeTAQXEg/fQWPQLhIDGYLmdba3t7x4gyO0s2LdmC6elVxGC5uYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247095; c=relaxed/simple;
	bh=nY7S1bfUipn+1oRBzeHzCHqw+/cMIqpnSLMbjzkLFCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiWLe+lgOHVRD+vb8a6dSmJwK9tv8FplAirahyPC17Vnor9eHK0fX1+2qBXkQm3BtR3OMQrAZ2D7/A23tuO6CQ2lL6qsyXvW1+IRH18h5WktpQFZrgC2Yo9ppvn87UAUS0keub44NMwoNyiSjlY6aAy2iXHM/EKjSb5jgwWOzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gHd2n8b7; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8c15e8b2f1aso700209085a.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247090; x=1768851890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U35yPiCIUQqmOlJBL0BmHWhbZX4EIscywlaQom+nbVM=;
        b=ay8H3COkDxrUikMuVUKue0bciFxeXROMHIDHrh5EC7qvGUgKsmL/1hELwhXgtyFX3v
         AZUmnHX1rmGqWg6mjxmBo0YJrFY6EXGJtGa7ORUuSZdczlyIzFKhfT1tOzxJEIN6AFJi
         UuHq9/32lVJbxymdsOyaqPTZBpzBV6ZyN8/d2DWDcZ6+OJz5/6rxyB0vaPZCkPKFDwz0
         oMVk46MxeiG8chrSYRB91OfCV5P3ovmCoN78ESlpAHq0+q29IiQkkdiLlUdenkzK8g7h
         Ysw1C4IP8pNZfZa7MPoCACf16NvVUfeSFU1K4szxq6H1NuJ4Jj/u0isgCeSdqBjYdZdd
         oM+A==
X-Forwarded-Encrypted: i=1; AJvYcCXCp12q3Bj+Pe5iQyZD3P0f3J8gp16KOT6jdeHF0h6vYBUdmuKRog8RqHl3nbIGyS0RBNEJaEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTe29DeX5qIlbqRj1dqFs1RBAoqp3zh0MZdp8bCqI1rsvnJ5gs
	WcJJ0caP75/ml+GCsTkRrPTBukyy8vywmULEVyin86/rqyDyEoOXyupWlC//NdxUSURBr+b6fMu
	eOTD5Le1zWFhAGilNow0L1Li2/80BcLSa/RRE/PlMfR6rfl4JwAZ/vQCZ/H6H+fGPVRj4Yk9Pds
	V3sXVRkVQ8gxaC1d1P7ADFtUQNMxZEk5IwakOOdLaB/pvvpfp8Y8BfD+ly9zh97UZzdaZxKpdCo
	IKU4fJIPCuVOcqs4g==
X-Gm-Gg: AY/fxX5npr7HqH+ujscQlRSRv7ss9HPxC8gvCYu+TQ3IaiFt+WB/SWLpXxqHU0dkNEi
	L2nm3lWoOWKMFTgW3hH2oDvj9Y8GniQJILHk3yl16tC0ENsWUEo8l4EVdMF0gs4da1KJhKZjG6r
	4ib4plR8KlNvZ55Pi7r4S4YrxrJZGPyPbUVFThEmXT7QGEGPana/18wJvBai4VcYiIiGEYRFamO
	7RRvTIZzupJOM8MaQ4h9+c2LCqMOPZx3JssMtBnb5Ss7rdhdT1RF9VLCX4Dh1zMPqwWzhbQfsWX
	Jnhyn5+rZNnP1BicLSVTLW20oa6E+otRwyD7ymrBTO1D2PtZgiM+uOFN/U0Rc+MtGtw5Ao6nwhx
	ktyS717GKtOVJ3+1V28odTNhiNKiky4qPUs+2Q3AbABjfSJePjLI9PySDCZUJkmZMfYY3dP2dBg
	oDpY8lxGBkOswga6LzBjK95qdwppEzMtHureztuarqALwC2f1VMtxfdg==
X-Google-Smtp-Source: AGHT+IE9dJFbWx0otG8ZyWPOibGp0zqlGjCvh5VEJM10kK6iPnerebcOUdMedUUJXJ3euTR6O/dPOBry+kpl
X-Received: by 2002:a05:622a:4084:b0:4f4:e15d:f220 with SMTP id d75a77b69052e-4ffb4824a19mr239888881cf.25.1768247090011;
        Mon, 12 Jan 2026 11:44:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4ffa8e71920sm5234251cf.9.2026.01.12.11.44.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jan 2026 11:44:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b050acf07dso25072425eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768247089; x=1768851889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U35yPiCIUQqmOlJBL0BmHWhbZX4EIscywlaQom+nbVM=;
        b=gHd2n8b7GzAXCIfV6PqfCxL54gikvPIVkmT5kca9iy6IiPC4InR9R1Wb3CuZmY/rT8
         5KTJ+pyJM0fdBWBL+iPjrAQzhE1tYldmqAhDWsxQ3GRSAZXk+EGcXaq6KSM3EtGpVBqU
         PbrNQzYS5Dhr52ch0SXSmZRzN2hPHKXX98TeA=
X-Forwarded-Encrypted: i=1; AJvYcCV9/FP/ZkQILre7zWlyWH9FZvaP0fGDC8kO6BPFg/yNh6zkRCtZuew6zynIVpDeHReYQaxifsA=@vger.kernel.org
X-Received: by 2002:a05:7301:58ce:b0:2ab:ca55:b762 with SMTP id 5a478bee46e88-2b17d336ba7mr12676565eec.41.1768247088593;
        Mon, 12 Jan 2026 11:44:48 -0800 (PST)
X-Received: by 2002:a05:7301:58ce:b0:2ab:ca55:b762 with SMTP id
 5a478bee46e88-2b17d336ba7mr12676536eec.41.1768247087903; Mon, 12 Jan 2026
 11:44:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-3-bhargava.marreddy@broadcom.com> <a3aab7af-3807-4f37-92e0-5ea52df1bd4c@redhat.com>
In-Reply-To: <a3aab7af-3807-4f37-92e0-5ea52df1bd4c@redhat.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Tue, 13 Jan 2026 01:14:33 +0530
X-Gm-Features: AZwV_QiGeWKCPY6oHvsrTW9XEOyWkldFfQ7oRuDj7VlOO_Z-vA2QxjCoCsPgNfc
Message-ID: <CANXQDtYR6P9+oHXpAzxPk4cE1jSYCFoCbELcWad25h1c6wfmQQ@mail.gmail.com>
Subject: Re: [v4, net-next 2/7] bng_en: Add RX support
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a040210648361b7b"

--000000000000a040210648361b7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers=
/net/ethernet/broadcom/bnge/bnge_hw_def.h
> > new file mode 100644
> > index 000000000000..4da4259095fa
> > --- /dev/null
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> > @@ -0,0 +1,198 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2025 Broadcom */
> > +
> > +#ifndef _BNGE_HW_DEF_H_
> > +#define _BNGE_HW_DEF_H_
> > +
> > +struct tx_bd_ext {
> > +     __le32 tx_bd_hsize_lflags;
> > +     #define TX_BD_FLAGS_TCP_UDP_CHKSUM                      (1 << 0)
>
> Please use BIT()

Simon Horman raised a similar point. However, some hardware BD values
use non-contiguous bits that make BIT() and GENMASK() overly complex.
We believe the current definitions better reflect the hardware spec.
Please let us know if you=E2=80=99d still prefer a different approach.

>
> > +     #define TX_BD_FLAGS_IP_CKSUM                            (1 << 1)
> > +     #define TX_BD_FLAGS_NO_CRC                              (1 << 2)
> > +     #define TX_BD_FLAGS_STAMP                               (1 << 3)
> > +     #define TX_BD_FLAGS_T_IP_CHKSUM                         (1 << 4)
> > +     #define TX_BD_FLAGS_LSO                                 (1 << 5)
> > +     #define TX_BD_FLAGS_IPID_FMT                            (1 << 6)
> > +     #define TX_BD_FLAGS_T_IPID                              (1 << 7)
> > +     #define TX_BD_HSIZE                                     (0xff << =
16)
> > +      #define TX_BD_HSIZE_SHIFT                               16
>
> I'm quite suprised checkpatch does not complain, but the above
> indentation is IMHO quite messy.

Thanks, I=E2=80=99ll fix the indentation (mixing whitespaces and tabs) in t=
he
next version.

>
> please move the macro definition before the struct and avoid mixing
> whitespaces and tabs.

Since these are hardware-defined structs, we kept the #defines with
their members to make the mapping clear.
Any concerns with this?

>
> [...]
> > @@ -1756,6 +1757,78 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn=
)
> >       return rc;
> >  }
> >
> > +static void bnge_disable_int(struct bnge_net *bn)
> > +{
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int i;
> > +
> > +     if (!bn->bnapi)
> > +             return;
> > +
> > +     for (i =3D 0; i < bd->nq_nr_rings; i++) {
> > +             struct bnge_napi *bnapi =3D bn->bnapi[i];
> > +             struct bnge_nq_ring_info *nqr =3D &bnapi->nq_ring;
> > +             struct bnge_ring_struct *ring =3D &nqr->ring_struct;
>
> Please respect the reverse christmas tree above.

Thanks! I=E2=80=99ll fix it in the next revision.

>
> > +
> > +             if (ring->fw_ring_id !=3D INVALID_HW_RING_ID)
> > +                     bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
> > +     }
> > +}
> > +
> > +static void bnge_disable_int_sync(struct bnge_net *bn)
> > +{
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int i;
> > +
> > +     bnge_disable_int(bn);
> > +     for (i =3D 0; i < bd->nq_nr_rings; i++) {
> > +             int map_idx =3D bnge_cp_num_to_irq_num(bn, i);
> > +
> > +             synchronize_irq(bd->irq_tbl[map_idx].vector);
> > +     }
> > +}
> > +
> > +static void bnge_enable_int(struct bnge_net *bn)
> > +{
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int i;
> > +
> > +     for (i =3D 0; i < bd->nq_nr_rings; i++) {
> > +             struct bnge_napi *bnapi =3D bn->bnapi[i];
> > +             struct bnge_nq_ring_info *nqr =3D &bnapi->nq_ring;
>
> Same here

Thanks! I=E2=80=99ll fix it in the next revision.

> > @@ -298,6 +343,10 @@ struct bnge_cp_ring_info {
> >       u8                      cp_idx;
> >       u32                     cp_raw_cons;
> >       struct bnge_db_info     cp_db;
> > +     u8                      had_work_done:1;
> > +     u8                      has_more_work:1;
> > +     u8                      had_nqe_notify:1;
>
> Any special reasons to use bitfields here? `bool` will generate better
> code, and will not change the struct size.

Thanks, I=E2=80=99ll switch these to bool as suggested.

>
> [...]
> > +static struct sk_buff *bnge_copy_skb(struct bnge_napi *bnapi, u8 *data=
,
> > +                                  unsigned int len, dma_addr_t mapping=
)
> > +{
> > +     struct bnge_net *bn =3D bnapi->bn;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     struct sk_buff *skb;
> > +
> > +     skb =3D napi_alloc_skb(&bnapi->napi, len);
> > +     if (!skb)
> > +             return NULL;
> > +
> > +     dma_sync_single_for_cpu(bd->dev, mapping, bn->rx_copybreak,
> > +                             bn->rx_dir);
> > +
> > +     memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
> > +            len + NET_IP_ALIGN);
>
> This works under the assumption that len <=3D  bn->rx_copybreak; why
> syncing the whole 'rx_copybreak' instead of 'len' ?

Good point. syncing the actual packet length is more precise and
avoids unnecessary cache maintenance.
Let us test this on our hardware and get back to you.

>
> > +
> > +     dma_sync_single_for_device(bd->dev, mapping, bn->rx_copybreak,
> > +                                bn->rx_dir);
>
> Why is the above needed?

Since the buffer is being reused, the for_device sync hands ownership
back to the hardware.
This ensures the memory is ready for the next DMA transfer and
maintains consistency on non-coherent architectures.
Any concerns with this?

>
> > +
> > +     skb_put(skb, len);
> > +
> > +     return skb;
> > +}
> > +
> > +static enum pkt_hash_types bnge_rss_ext_op(struct bnge_net *bn,
> > +                                        struct rx_cmp *rxcmp)
> > +{
> > +     u8 ext_op =3D RX_CMP_V3_HASH_TYPE(bn->bd, rxcmp);
> > +
> > +     switch (ext_op) {
> > +     case EXT_OP_INNER_4:
> > +     case EXT_OP_OUTER_4:
> > +     case EXT_OP_INNFL_3:
> > +     case EXT_OP_OUTFL_3:
> > +             return PKT_HASH_TYPE_L4;
> > +     default:
> > +             return PKT_HASH_TYPE_L3;
> > +     }
> > +}
> > +
> > +static struct sk_buff *bnge_rx_vlan(struct sk_buff *skb, u8 cmp_type,
> > +                                 struct rx_cmp *rxcmp,
> > +                                 struct rx_cmp_ext *rxcmp1)
> > +{
> > +     __be16 vlan_proto;
> > +     u16 vtag;
> > +
> > +     if (cmp_type =3D=3D CMP_TYPE_RX_L2_CMP) {
> > +             __le32 flags2 =3D rxcmp1->rx_cmp_flags2;
> > +             u32 meta_data;
> > +
> > +             if (!(flags2 & cpu_to_le32(RX_CMP_FLAGS2_META_FORMAT_VLAN=
)))
> > +                     return skb;
> > +
> > +             meta_data =3D le32_to_cpu(rxcmp1->rx_cmp_meta_data);
> > +             vtag =3D meta_data & RX_CMP_FLAGS2_METADATA_TCI_MASK;
> > +             vlan_proto =3D
> > +                     htons(meta_data >> RX_CMP_FLAGS2_METADATA_TPID_SF=
T);
> > +             if (eth_type_vlan(vlan_proto))
> > +                     __vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
> > +             else
> > +                     goto vlan_err;
> > +     } else if (cmp_type =3D=3D CMP_TYPE_RX_L2_V3_CMP) {
> > +             if (RX_CMP_VLAN_VALID(rxcmp)) {
> > +                     u32 tpid_sel =3D RX_CMP_VLAN_TPID_SEL(rxcmp);
> > +
> > +                     if (tpid_sel =3D=3D RX_CMP_METADATA1_TPID_8021Q)
> > +                             vlan_proto =3D htons(ETH_P_8021Q);
> > +                     else if (tpid_sel =3D=3D RX_CMP_METADATA1_TPID_80=
21AD)
> > +                             vlan_proto =3D htons(ETH_P_8021AD);
> > +                     else
> > +                             goto vlan_err;
> > +                     vtag =3D RX_CMP_METADATA0_TCI(rxcmp1);
> > +                     __vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
> > +             }
> > +     }
> > +     return skb;
> > +
> > +vlan_err:
> > +     skb_mark_for_recycle(skb);
> > +     dev_kfree_skb(skb);
> > +     return NULL;
> > +}
> > +
> > +static struct sk_buff *bnge_rx_skb(struct bnge_net *bn,
> > +                                struct bnge_rx_ring_info *rxr, u16 con=
s,
> > +                                void *data, u8 *data_ptr,
> > +                                dma_addr_t dma_addr,
> > +                                unsigned int offset_and_len)
> > +{
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     u16 prod =3D rxr->rx_prod;
> > +     struct sk_buff *skb;
> > +     int err;
> > +
> > +     err =3D bnge_alloc_rx_data(bn, rxr, prod, GFP_ATOMIC);
> > +     if (unlikely(err)) {
> > +             bnge_reuse_rx_data(rxr, cons, data);
> > +             return NULL;
> > +     }
> > +
> > +     skb =3D napi_build_skb(data, bn->rx_buf_size);
> > +     dma_sync_single_for_cpu(bd->dev, dma_addr, bn->rx_buf_use_size,
> > +                             bn->rx_dir);
>
> Why you need to sync the whole `rx_buf_use_size` instead of the actual
> packet len?

Good point. Let us test this on our hardware and get back to you.

>
> > +     if (!skb) {
> > +             page_pool_free_va(rxr->head_pool, data, true);
> > +             return NULL;
> > +     }
> > +
> > +     skb_mark_for_recycle(skb);
> > +     skb_reserve(skb, bn->rx_offset);
> > +     skb_put(skb, offset_and_len & 0xffff);
>
> It's unclear why you pass 2 different values mangled together and than
> extract only one of them.

Thanks! I=E2=80=99ll fix it in the next revision.

Thanks,
Bhargava Marreddy

>
> /P
>

--000000000000a040210648361b7b
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAr89IvpF0GUnaeRLHO2+a8v63X15lWPc3pBS9OG7IgSTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTIxOTQ0NDlaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAqw48W
Z/Vt8n+IxIbvl3Z8DVKzmgDfL38IVX0NSrK2tHEbM3QTgY3szUWB4mVnt8cclQQ8JwBX8VsBNXiA
5U/yy9uua8yYaoAwKGyURyRGrcRwOCJRN2octEAH6+hiZTxyqlsKBKXiWTTglsTLEyEX45kFpV1U
HF3JYa6Wnmdn0fgYt6HYnZoiUI3EQdCtoc09XHP1/4AgX6H8YmGJD8o21zN0cPcM30IOEZn9fDwQ
JA84WeRNVK1vqiekdz75yKNj4pK633RKUAV33J3zDjmrzX6yXSWb2l0I+rHiAas0jBGzvzvPCWby
ExXgUATN4kp07x1txHtU3iLy39VjuBhR
--000000000000a040210648361b7b--

