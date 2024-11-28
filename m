Return-Path: <netdev+bounces-147675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9469DB1F9
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 04:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F3B167622
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 03:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03672450F2;
	Thu, 28 Nov 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="At9aGgDW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090CB2563
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732765602; cv=none; b=qEmrE8Puoia8TaLdiGYt5zrlB8KaBMjRuDpupfjIK9F8tgwewThfiWtNCRYJAQEQryshMwYWqwNnLyfWG+VZ2sAQLatL3DOFWU1nsNnuv6qge/SGQO6eUf8P1iTLkG3np9B1Sxl1PEIn7lbv+saMuJ+9eEs+f00SNhanPav+6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732765602; c=relaxed/simple;
	bh=ADx2TS92wmVyg6J3tnW33YJtWMLenL+oAmfh+CovahE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0DTZ1unNsBHVI2qlZKNIPpbd7xj7EkX0RYmxmlCiDpZV5JWunv3WAhuEWSQ/gibrpHhKQXMipSHnQbkT+BkDvBOsdClrPtBsaNW88kN5IkYSV2+ERru/6bK7Ge/uM5XjFS9+kxWUAPM7cBkSRftwRKUWWedbJVOkteEn5WGbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=At9aGgDW; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4aef1e4c3e7so101199137.2
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 19:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732765600; x=1733370400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxvioe+rSkySXEvXFXjfZZC1j521t0KLXwYi3VWGiMc=;
        b=At9aGgDWDpw12vHeRanLuugPJEWw2sk/X3hYXxYPcEqekDfZjIBz6FFGn6KbgeUMAt
         q0dCe3wvCvkxScaxa7d4iCrkpyIFfBuhcHBI1pEymcC/thy2XUVdT1ssmHlcaqel3fDH
         T64LNGeVXTHs4COZSFcN9OIycHlHd9FlDg/G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732765600; x=1733370400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hxvioe+rSkySXEvXFXjfZZC1j521t0KLXwYi3VWGiMc=;
        b=ceVR8oRLFLi9oBJwtS9NkAD44Uand5P7R/hUHWMapjYamcoAA8r/MnG3pWtVxFY9Oj
         ++jsY+eRoKAqxg6hMeQy8kJhqdWTo6EAGXwtBWn75voyDbI/hS5iqTVpGlHInDIYQV+F
         3uxax9qm+IlCRwHDo6pkMfBwDjVFeCCggThe13XyuYxmnFCrFtyJ8x9WSv9KvgXPRwoq
         5yNN2LVoS1WRUkYslXsn8FVMQORPRABoosOgZCfJoIyEYil77u3G6h6WxqlSGkLV0/S7
         qSam6eUV3nijdV/6t3MJYg+ZA3lPQW40WyvCagEtkLvQr5VId70emN7zjLkU7uz40Teu
         b76w==
X-Gm-Message-State: AOJu0YzjF6izsCVxq7Ls8OgNf+q9q18oQE4doeeQxK2K+V259t0Ycx9k
	RcVv51HQvKglHNXdibW/7VJ4qOEarYG/FS86ZT40ItixJM0BQPCU4guTKuk+sjotY0j+FTlb+o6
	nFUx7X6a6DNBZxGgluFcY6/uoyiAwWtHukl5C
X-Gm-Gg: ASbGncu5ljERAu7YzBrhJq87FEwaGRuwQduVc6Okqp6C6KwpTboZrE9RvmSHT+J8a5c
	32n5lRh7ctOp4HA9I6/KHpBw7TNwQLYCB
X-Google-Smtp-Source: AGHT+IHBQsrWOJvw9pyz6EqgYuI5ajFXO8Tmxzperf5Js7HMrGHV4gMutndNI5KJxX9ea5D3UJkoHK9B22BjaujPcgU=
X-Received: by 2002:a05:6102:374f:b0:4af:4adf:8d80 with SMTP id
 ada2fe7eead31-4af4adf902bmr4984359137.18.1732765599841; Wed, 27 Nov 2024
 19:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127223855.3496785-1-dw@davidwei.uk> <20241127223855.3496785-4-dw@davidwei.uk>
In-Reply-To: <20241127223855.3496785-4-dw@davidwei.uk>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 28 Nov 2024 09:16:27 +0530
Message-ID: <CAOBf=muU_fTz-qN=BvNFoGT+h8pykmWe0WX-7tw0ska=hEk=og@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] bnxt_en: handle tpa_info in queue API implementation
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000134de70627f0ee6d"

--000000000000134de70627f0ee6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 4:09=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
> page pool for header frags, which may be distinct from the existing pool
> for the aggregation ring. Add support for this head_pool in the queue
> API.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 9b079bce1423..08c7d3049562 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15382,15 +15382,25 @@ static int bnxt_queue_mem_alloc(struct net_devi=
ce *dev, void *qmem, int idx)
>                         goto err_free_rx_agg_ring;
>         }
>
> +       if (bp->flags & BNXT_FLAG_TPA) {
> +               rc =3D bnxt_alloc_one_tpa_info(bp, clone);
> +               if (rc)
> +                       goto err_free_tpa_info;
> +       }
> +
>         bnxt_init_one_rx_ring_rxbd(bp, clone);
>         bnxt_init_one_rx_agg_ring_rxbd(bp, clone);
>
>         bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
>         if (bp->flags & BNXT_FLAG_AGG_RINGS)
>                 bnxt_alloc_one_rx_ring_page(bp, clone, idx);
> +       if (bp->flags & BNXT_FLAG_TPA)
> +               bnxt_alloc_one_tpa_info_data(bp, clone);
>
>         return 0;
>
> +err_free_tpa_info:
> +       bnxt_free_one_tpa_info(bp, clone);
>  err_free_rx_agg_ring:
>         bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>  err_free_rx_ring:
> @@ -15398,9 +15408,11 @@ static int bnxt_queue_mem_alloc(struct net_devic=
e *dev, void *qmem, int idx)
>  err_rxq_info_unreg:
>         xdp_rxq_info_unreg(&clone->xdp_rxq);
>  err_page_pool_destroy:
> -       clone->page_pool->p.napi =3D NULL;
>         page_pool_destroy(clone->page_pool);
> +       if (clone->page_pool !=3D clone->head_pool)
Just curious, why is this check needed everywhere? Is there a case
where the 2 page pools can be the same ? I thought either there is a
page_pool for the header frags or none at all ?
> +               page_pool_destroy(clone->head_pool);
>         clone->page_pool =3D NULL;
> +       clone->head_pool =3D NULL;
>         return rc;
>  }
>
> @@ -15410,13 +15422,15 @@ static void bnxt_queue_mem_free(struct net_devi=
ce *dev, void *qmem)
>         struct bnxt *bp =3D netdev_priv(dev);
>         struct bnxt_ring_struct *ring;
>
> -       bnxt_free_one_rx_ring(bp, rxr);
> -       bnxt_free_one_rx_agg_ring(bp, rxr);
> +       bnxt_free_one_rx_ring_skbs(bp, rxr);
>
>         xdp_rxq_info_unreg(&rxr->xdp_rxq);
>
>         page_pool_destroy(rxr->page_pool);
> +       if (rxr->page_pool !=3D rxr->head_pool)
> +               page_pool_destroy(rxr->head_pool);
>         rxr->page_pool =3D NULL;
> +       rxr->head_pool =3D NULL;
>
>         ring =3D &rxr->rx_ring_struct;
>         bnxt_free_ring(bp, &ring->ring_mem);
> @@ -15498,7 +15512,10 @@ static int bnxt_queue_start(struct net_device *d=
ev, void *qmem, int idx)
>         rxr->rx_agg_prod =3D clone->rx_agg_prod;
>         rxr->rx_sw_agg_prod =3D clone->rx_sw_agg_prod;
>         rxr->rx_next_cons =3D clone->rx_next_cons;
> +       rxr->rx_tpa =3D clone->rx_tpa;
> +       rxr->rx_tpa_idx_map =3D clone->rx_tpa_idx_map;
>         rxr->page_pool =3D clone->page_pool;
> +       rxr->head_pool =3D clone->head_pool;
>         rxr->xdp_rxq =3D clone->xdp_rxq;
>
>         bnxt_copy_rx_ring(bp, rxr, clone);
> @@ -15557,6 +15574,8 @@ static int bnxt_queue_stop(struct net_device *dev=
, void *qmem, int idx)
>         bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>         rxr->rx_next_cons =3D 0;
>         page_pool_disable_direct_recycling(rxr->page_pool);
> +       if (rxr->page_pool !=3D rxr->head_pool)
> +               page_pool_disable_direct_recycling(rxr->head_pool);
>
>         memcpy(qmem, rxr, sizeof(*rxr));
>         bnxt_init_rx_ring_struct(bp, qmem);
> --
> 2.43.5
>

--000000000000134de70627f0ee6d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIWSRUiFRHGHNT/XqTN4Ep2Fuxir
lSFiunA1rHYpJJm0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MTEyODAzNDY0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAhRuxiNK4u0MyqKd8yCIRa1uU8JoaLp41gcOJvfSVppzZ0
W7QpbLeR7EFEK2xFrUv156YOkwLStKP/o7BmiSZiE5NjZoN0PblSz+cCczimDz4l+IYHrgGq/tSF
Z5Udwaoi+5ORiZE1v+2vQTEwwuVHk5KAHaXKS4TikTLF3r4E5TK22Hcw+NaFKhIgxcDbGGF5rXSr
aY/vt3VfZ7dktnpnmeQ3STAhBfwEWVtUiZ1AT6Cy0BzcgA8N0wH3rYOyzOZRzdt4fbKg71BoSfLh
bUcQNQ4dSy38bWIzg+eXB8QCvH7DJGSrifrkx2NXhnLzWcdyfzPyAzBIKcB9Dqd1V0uY
--000000000000134de70627f0ee6d--

