Return-Path: <netdev+bounces-224339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08EB83D47
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785BB7A4FDD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731E27A46A;
	Thu, 18 Sep 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WGDETG1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D81F3BA2
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188452; cv=none; b=XWjhySPI8eiXdcRpz0htsDIyqpOnlCKEfUNmkD6/VnBepoeCITlM1KiYXGVPEQZrOce4eMCuLzY5Ac42CnFI0OKCSmZyYbsxc5I0JCGfC16uMZyXzTO8QPWrTkmfxdDcczqpu0qtCMLxEwYcZletpY+T6cQgZDpvxYRLLx58kPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188452; c=relaxed/simple;
	bh=0sACsp0KLHtfTLGX2JAGlXI6ikBKb3ObzjxlqPELtxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRaGOY/R0AItzgprxjzHLfQKq2GfVzD710iQXY1MHcA5opbdy1vOm8ZAYpTps1tc7qQyCnAaFq5dMtVungI3PG+kCV6nstqWVhJbvJAfN3omMmPUhTgq5VSiUiZRRjQqqzJYOOYooZ61cpl/IacqwKw5BlmwiWcxGrlmG5BOpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WGDETG1Q; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-796d68804a0so1098976d6.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188450; x=1758793250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDsrb2+5ITjYFhS9r1ycfOXB12XeKh1LpYumjanSNoY=;
        b=vxYUidV00HUpDzfFFPdHifd/RcAHv1fwgQDe/BBRWpyGjK69NVPJLwUHCekQ0ZZTW+
         DgdcLkoregbOPKV42B6DiB2Is+FzL1WoA0RJcFN2ckgzfYk0Q1pJArvGnUPL5qbPDtoU
         houYF6NzPFTd+XXH5xAwW7wt/43Wqn7L5Sgdg+yjy78XJARa6ckEIB3H/4Joivaf4BG+
         +NSMNrCJ8mKDOiPL6dF/GJhdiI15SK2s1CfgUpjZbw7rkHiwezkdk7Ljp44HpQZDyqux
         0CBKuaUN4Ht0+NYP1p8sP+WkxfHYdgNdJOIjSkyZFGsNaMQapjZHAeRzUMg0LGn2HbyB
         k5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZP/ko53pYolxGUZ11/4B8sChzORmtKZjMrzVfzB4KryEhBDHRaPvzgvb5TlHzFsUwUHmsQZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMWKTf66ubiwZcoXnmENwf3pZfnHcr5cbpNLjYdMCtP+TOYlC
	6BpKA1LpGse1TwbNqJh2yZdxOntOUF6aZ3UUjqhNMMxA55hl6J6jopBQg1i97KQLt9RX5rjLWAu
	6s2bq7GJvkA9vNiheyBS/Y0vnwMJMsGH8uNdelO9P/Kz5Gc3rwgXrHttjgITl3E3/vSmZzbRzaM
	bEqZZtzlpv6j7uEUeF47qei2TYZ44r65KA5SCo9ZDVCVHKFEB0wzIbtfmxJdS2XmDINVvADMYNK
	s//10rkAVC9ELJQWg==
X-Gm-Gg: ASbGncvUUFT6iHtOToZ5wQ3iaSK7NTwg2yCfE4IcVxkKQFOtfn5BbEiYygcxW3MTL4V
	5p7yzVmwWNCT8AMI9jCAAeU2FUQk+Xg2K/CsqfriBTbytN91hAsWb8eUQiAL4PSnWucgw6L4bWM
	QgjKw6oaVEJY72IwLT+RG8jwvEug9/VzYbVycZdPmoaPK6VAyVtAs0QLRQ3/AMGz46bgThPINW9
	417t5fasnoXbh7pMTifvIiZ2w9I1Ar8RoDw4EqOnSjZ5eKVd7xUB4qc7mD3EXgC9WNtzEhU3OkJ
	t9hDQ1F+k9ddk+sLvy+ysS3oIbOwGkOKIJRrIkeeOUy0ZjPvcayF/qHQge1AsjitKq0p0PbysXA
	Pd/u4eY//8S5UKF5K6oGmnegqnc3Op1CBM5nJWS3hQktdqbGLAecm3n3KOtZNvnhyf8vnbsSjaz
	IMlL76QQG0
X-Google-Smtp-Source: AGHT+IFL98FFsHUkL9NxnDx9ALa2arAmp7GL7AWe/6pFvGZ8n64wt5hEaJgd+Fz/gsGjFNfZup435baQ5j9D
X-Received: by 2002:a05:6214:7f1:b0:78f:20d1:b663 with SMTP id 6a1803df08f44-78f20d1bba6mr33317856d6.26.1758188450102;
        Thu, 18 Sep 2025 02:40:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793469313fdsm1429706d6.18.2025.09.18.02.40.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:40:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269a2b255aaso2900165ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758188448; x=1758793248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDsrb2+5ITjYFhS9r1ycfOXB12XeKh1LpYumjanSNoY=;
        b=WGDETG1QJKyUUyQfeMj7tOSNw3sukbN7JdDbMTKVsrQDG+N8RaTxfpQYiXac0oaaz/
         kXP2YkPuxODUSmu/xL6jXo4co4uX9tEThhavWacIZenMj6DDnZK3glBhhs8PDyJWkA5+
         E8ezWrgmTfLZCSdKSFRAn2JoJD8rJKatwAY8g=
X-Forwarded-Encrypted: i=1; AJvYcCVDIjO3m0L3TF8lWCh4Ygjrvd3HeOXJFTNxa4Wx5n+498s4/ozk91PGjtXLE8hXTcV+FYEXcIU=@vger.kernel.org
X-Received: by 2002:a17:903:1108:b0:267:8049:7c7f with SMTP id d9443c01a7336-268118b3f91mr72930375ad.7.1758188448286;
        Thu, 18 Sep 2025 02:40:48 -0700 (PDT)
X-Received: by 2002:a17:903:1108:b0:267:8049:7c7f with SMTP id
 d9443c01a7336-268118b3f91mr72930075ad.7.1758188447928; Thu, 18 Sep 2025
 02:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-4-bhargava.marreddy@broadcom.com> <20250916145457.GH224143@horms.kernel.org>
In-Reply-To: <20250916145457.GH224143@horms.kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 18 Sep 2025 15:10:34 +0530
X-Gm-Features: AS18NWCX-lpBJR8hC0QIL1sxjKZkTXbFo2pihz5iYkhQxAaL_EdOqLDREadfy1A
Message-ID: <CANXQDtZHmVnO3Wa72jyqs6ZTS2tPhTV=WDpRwyyPeHJFx9jadg@mail.gmail.com>
Subject: Re: [v7, net-next 03/10] bng_en: Add initial support for CP and NQ rings
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

On Tue, Sep 16, 2025 at 8:25=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Sep 12, 2025 at 01:04:58AM +0530, Bhargava Marreddy wrote:
> > Allocate CP and NQ related data structures and add support to
> > associate NQ and CQ rings. Also, add the association of NQ, NAPI,
> > and interrupts.
> >
> > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
>
> ...
>
> > +static int bnge_alloc_nq_tree(struct bnge_net *bn)
> > +{
> > +     int i, j, ulp_msix, rc =3D -ENOMEM;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int tcs =3D 1;
> > +
> > +     ulp_msix =3D bnge_aux_get_msix(bd);
> > +     for (i =3D 0, j =3D 0; i < bd->nq_nr_rings; i++) {
> > +             bool sh =3D !!(bd->flags & BNGE_EN_SHARED_CHNL);
> > +             struct bnge_napi *bnapi =3D bn->bnapi[i];
> > +             struct bnge_nq_ring_info *nqr;
> > +             struct bnge_cp_ring_info *cpr;
> > +             struct bnge_ring_struct *ring;
> > +             int cp_count =3D 0, k;
> > +             int rx =3D 0, tx =3D 0;
> > +
> > +             nqr =3D &bnapi->nq_ring;
> > +             nqr->bnapi =3D bnapi;
> > +             ring =3D &nqr->ring_struct;
> > +
> > +             rc =3D bnge_alloc_ring(bd, &ring->ring_mem);
> > +             if (rc)
> > +                     goto err_free_nq_tree;
> > +
> > +             ring->map_idx =3D ulp_msix + i;
> > +
> > +             if (i < bd->rx_nr_rings) {
> > +                     cp_count++;
> > +                     rx =3D 1;
> > +             }
> > +
> > +             if ((sh && i < bd->tx_nr_rings) ||
> > +                 (!sh && i >=3D bd->rx_nr_rings)) {
> > +                     cp_count +=3D tcs;
> > +                     tx =3D 1;
> > +             }
> > +
> > +             nqr->cp_ring_arr =3D kcalloc(cp_count, sizeof(*cpr),
> > +                                        GFP_KERNEL);
> > +             if (!nqr->cp_ring_arr)
>
> I think that rc should be set to a negative return value, say -ENOMEM,
> here. The function returns rc. And as is, rc is 0 at this point.
>
> Flagged by Smatch.

Thanks, Simon. I'll address this in the next patch.

>
> > +                     goto err_free_nq_tree;
> > +
> > +             nqr->cp_ring_count =3D cp_count;
> > +
> > +             for (k =3D 0; k < cp_count; k++) {
> > +                     cpr =3D &nqr->cp_ring_arr[k];
> > +                     rc =3D alloc_one_cp_ring(bn, cpr);
> > +                     if (rc)
> > +                             goto err_free_nq_tree;
> > +
> > +                     cpr->bnapi =3D bnapi;
> > +                     cpr->cp_idx =3D k;
> > +                     if (!k && rx) {
> > +                             bn->rx_ring[i].rx_cpr =3D cpr;
> > +                             cpr->cp_ring_type =3D BNGE_NQ_HDL_TYPE_RX=
;
> > +                     } else {
> > +                             int n, tc =3D k - rx;
> > +
> > +                             n =3D BNGE_TC_TO_RING_BASE(bd, tc) + j;
> > +                             bn->tx_ring[n].tx_cpr =3D cpr;
> > +                             cpr->cp_ring_type =3D BNGE_NQ_HDL_TYPE_TX=
;
> > +                     }
> > +             }
> > +             if (tx)
> > +                     j++;
> > +     }
> > +     return 0;
> > +
> > +err_free_nq_tree:
> > +     bnge_free_nq_tree(bn);
> > +     return rc;
> > +}
> > +
> >  static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
> >  {
> >       return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;

