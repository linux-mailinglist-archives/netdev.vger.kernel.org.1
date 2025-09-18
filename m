Return-Path: <netdev+bounces-224375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD93B84383
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1118841FD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B8287272;
	Thu, 18 Sep 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bTecXaQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6324167F
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192569; cv=none; b=NVVrPn+JZRTiz0QJ5/G1POcnXZeycqJThbwanOlfwMpAUyTkVKMKb+8phtdl85aPkxJWAW9r14EiY7nNH+uoauwBzC6BIExf4zan4euzvrdnxRHcaIqOJ0i/aJhyzgthSZiVq6+hAc/xEaff8jnS+ct4LMCGdQ/du4rUd+A44/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192569; c=relaxed/simple;
	bh=ZUBtVHvkTAY4+B4crK786K2DWksiRXcDIQfYXHLK7oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA5a/Nyg+bX0i3uoD+PfscPw2ExU3M0peW4XaoB6ddE3Qb3MrBNEoMIILMOz0uq0/E+QGKacvR1iuh9a3JvSAjB8yO3dCXTVFhxMk6EfjZH24sRJTUab4uQst1USLCfpvOP3/LtfDVJf/Y9ShqBHsPiFkA2YGHqoItbvaDBF4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bTecXaQ4; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7728815e639so570144b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192567; x=1758797367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tKzXKJ86WWAjRz6O6r+1bHqtyZjWimokstHRSdS6Mg=;
        b=UuoHwSb+IXMkXzLkv4p9GIkTCtrd4cQvC5SPwEJNvuQk5UvyN9qsVwe/gPbzyWtvNZ
         4G9ZLu0RSDYAL3cPTUdWl0y7JPWqrnuZOgl0mNXdSXXIa28iJBlkOHTD+3cl9msGA6o3
         XPmH5M6RvG9/lHAbVSVVvuIp7aZFTAwkhLRLKDtREEpGNj+7/ztjC/TMjNpd9IGxXC/D
         4m1s2Em4tsoAsclOfVmwnwy3E603luMWBdYL2q0s5gbjxxfRWMA4aVcZfvK5LP95/uKK
         BtGCb/22tA53Qk00ZNMDI7laZOAr4TnvWeyLGUBEOS0u+d60XPDneaoskuQAPlPMqHtM
         FORg==
X-Forwarded-Encrypted: i=1; AJvYcCU5RzNnW+5PAzGebACuyx4iqU82UCdme91FCmpSYU8zJWeT1uh6Lxc7WfGXdh1pj6WFtIClPPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxok2X5D+IptC4GJzZl2s3E/lElZBRP80t5JQVFZPVfy8BtvXj0
	2+hUL6dhH9s7ek845tZcB4T0YBrq4SbXIp/+qP2T4BIbbT024HB2ysVziDjns4akKYY1sm+zIID
	ETIqLYFeiz48m60AowcVk/zx9sGd9EJgpXpqod8b2SxbyBatFQq66HILCSLd5MOOWnabdpz6Q8C
	SQQAs/ceUtqEhHC4H0AZ9BKVOBcZzcmaOgvxVurViMotWSAyCMVXJmn/5XdbAA1E1brVtnthFGW
	uWOzq4diZEtT/ZOTQ==
X-Gm-Gg: ASbGncuiMy4w+IRHK/PcjRKWw5c5XSXZ92IMX9N972dWaPJ0eeqYoSC9KKYhZ9a3k7t
	+59t7TBFPA8MeGOESXYKqMiHd68jKdahExem/a/nc79Y6zS4hXLz9JCZKybyZ15b3sGee6SyvuU
	aLRHC8Wx3UoVhx9F0+VVgyDhwXAmlvxnNfd6Ec5A7nqwb707bJOpAaX9nzBdawZ9CYB1z3tPqAV
	JsECd+jx7jF4cXDVMKXBh3Ts8rARba4wzHHyjFz4AsAKAMjXadOy5dTdC1oAnD99qEyuOp3dczr
	RAdwe3Ry46j4OeWYD9Nk/c/Q4r1Kc2NvomCW2ioBvs6QZOMdnjfb06WUVZsxHHpS9c2V0Ltwc6D
	daI9Q25XyeQWlxBeXi3h8xUTQc5XRTZh726QI4IVRF1otDSUz5tobZZ0ptwCNOeeFikvHWRt+h6
	Ibj5Hh4AvM
X-Google-Smtp-Source: AGHT+IGgwKPwkYwBRm0JVcvBOhY0mBXAWYlaSA4gvmcXfIjK9V9Zu1x1UUximPefoX4bbr1c8alVS5IMwP6F
X-Received: by 2002:a05:6a00:2d1e:b0:772:38d0:4fee with SMTP id d2e1a72fcca58-77bf72cb938mr5778846b3a.12.1758192567150;
        Thu, 18 Sep 2025 03:49:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-77cfe669a63sm148255b3a.10.2025.09.18.03.49.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:49:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445806b18aso10441255ad.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758192565; x=1758797365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tKzXKJ86WWAjRz6O6r+1bHqtyZjWimokstHRSdS6Mg=;
        b=bTecXaQ4p6DMIlbjqQfhKH3UGDFLfdw+H8C29OdvMBJubc365E+2zEpjZQj66gtRmh
         iCweaicd6S1MW1wuu6+mlRFWPYyqvRdS+leOPgAEv7n2x8sG1T8T6ozHv9js9Yw2GYl3
         xMU+/ABgCILkrj6SUfNmA6WPORHS/pc3AhrQc=
X-Forwarded-Encrypted: i=1; AJvYcCWKm+8pILwPey2CCXIhHc6pu7TL2fMnqYlf2JTTtcH6q8bPjDYKSAYMOVhUFbKzQzJDz8hSNWE=@vger.kernel.org
X-Received: by 2002:a17:902:e54a:b0:269:6e73:b90a with SMTP id d9443c01a7336-2696e82fe56mr46280565ad.15.1758192565268;
        Thu, 18 Sep 2025 03:49:25 -0700 (PDT)
X-Received: by 2002:a17:902:e54a:b0:269:6e73:b90a with SMTP id
 d9443c01a7336-2696e82fe56mr46280315ad.15.1758192564881; Thu, 18 Sep 2025
 03:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-6-bhargava.marreddy@broadcom.com> <20250916154501.GJ224143@horms.kernel.org>
In-Reply-To: <20250916154501.GJ224143@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 18 Sep 2025 16:19:13 +0530
X-Gm-Features: AS18NWCa_g0UmRvKmRME9ja7yGUskmCB6KsNTvDnDhoSWvGcPCrazrGLA1CN6r8
Message-ID: <CANXQDtanjs=VEMP8Mq+Bq5D_vT=zH3xbo2kc-EBaNkuWJ8T-8A@mail.gmail.com>
Subject: Re: [v7, net-next 05/10] bng_en: Initialise core resources
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 9:15=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 01:05:00AM +0530, Bhargava Marreddy wrote:
> > Add initial settings to all core resources, such as
> > the RX, AGG, TX, CQ, and NQ rings, as well as the VNIC.
> > This will help enable these resources in future patches.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> > ---
> >  .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 213 ++++++++++++++++++
> >  .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  50 ++++
> >  .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
> >  3 files changed, 264 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers=
/net/ethernet/broadcom/bnge/bnge_netdev.c
>
> ...
>
> > +static int bnge_init_tx_rings(struct bnge_net *bn)
> > +{
> > +     int i;
> > +
> > +     bn->tx_wake_thresh =3D max_t(int, bn->tx_ring_size / 2,
> > +                                BNGE_MIN_TX_DESC_CNT);
>
> The use of max_t caught my eye.
>
> And I'm curious to know why tx_wake_thresh is signed.
> I don't see it used in this patchset other than
> being set on the line above.
>
> In any case, I expect that max() can be used instead of max_t() here.

Thanks, I'll address this in the next patch.

>
> > +
> > +     for (i =3D 0; i < bn->bd->tx_nr_rings; i++) {
> > +             struct bnge_tx_ring_info *txr =3D &bn->tx_ring[i];
> > +             struct bnge_ring_struct *ring =3D &txr->tx_ring_struct;
> > +
> > +             ring->fw_ring_id =3D INVALID_HW_RING_ID;
> > +
> > +             netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX,
> > +                                  &txr->bnapi->napi);
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers=
/net/ethernet/broadcom/bnge/bnge_netdev.h
>
> ...
>
> > @@ -176,9 +212,19 @@ struct bnge_net {
> >       u16                             *tx_ring_map;
> >       enum dma_data_direction         rx_dir;
> >
> > +     /* grp_info indexed by napi/nq index */
> > +     struct bnge_ring_grp_info       *grp_info;
> >       struct bnge_vnic_info           *vnic_info;
> >       int                             nr_vnics;
> >       int                             total_irqs;
> > +
> > +     int                     tx_wake_thresh;
> > +     u16                     rx_offset;
> > +     u16                     rx_dma_offset;
> > +
> > +     u8                      rss_hash_key[HW_HASH_KEY_SIZE];
> > +     u8                      rss_hash_key_valid:1;
> > +     u8                      rss_hash_key_updated:1;
> >  };
>
> ...

