Return-Path: <netdev+bounces-147331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B269D91CE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 07:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B340F286044
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B515575F;
	Tue, 26 Nov 2024 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T3UlxoIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2C1684A4
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602716; cv=none; b=IK067SGnM3BU1pt5UMGA6xS8WHzBQNkZ7BTbWQnNa8WjExDoMIf8gexPN/sU7I4ZRlVN61Tc6CnGz3GUlzATf/xX/T7rYI8QkPp9RqTu79t3L60jFdj/CHKagma9G7+go3xYEE7O5fBGH35NATyGinIwApLms4Xt+DIWKVKfORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602716; c=relaxed/simple;
	bh=zYjd1KWhVM4FRGm8C7YtweAcvjV0Jc6aN/HYIfW2VuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOFSQ//Pe9lCCG5ckwy9Sg4mcx3zQZpC6hMGZgqxFRAfb/rpnvVPb+sS3aVKfR2y8n6j9GzUMo1cVd/pQhP87SB4tAQSvks+rg9v/uD+FqHqzOYb5nj0WNEJ2gxNVnk+9dyepWL6Wg+LFbZrRuszR2XYFa+0kWqXSWBW3ATro+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T3UlxoIW; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4aef56c5cf9so936349137.0
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732602713; x=1733207513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zscTyqrf7IZG8l5V+1fuf03gKjB0quLyn3srN3XZ254=;
        b=T3UlxoIWfny/MqFk7in0N+EFE1o/6kcHg7P94m7SIOef/4fHTLhqiawYZItdNGIX+7
         iPnhb/2lxUcpQX96HicSGB64VY8tAr+eqKaVh0rJ8huYyOcO/dZUXje2W104pvPoQQMP
         hfhF0eGFE/fuNn2/PsBe2WkBTMp2RMd65l4Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732602713; x=1733207513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zscTyqrf7IZG8l5V+1fuf03gKjB0quLyn3srN3XZ254=;
        b=kaReDSMOBFl0nDU94Ie5qFjOa/jkb7YXfH7zzmbsUmavREULnoSNJtw0VzPWNiKwKm
         orj+krgnvcihrSZB1ufvNXHF9Ly9L87aO4fQuOJGJDBWZ6syO/q7hdmBH3z62/shUlZA
         lIflK8dKVHb+DIsBlAE0cqSW1fEcfpl66JKRRiH2ONmatjWGqPqZXLyLlEKWavsjXX3k
         6jm5l9nqujszSgQNqg/HxqkvEH+lqQv/V/yoRk/j0H7qkuQyyTNUkzDibfwGHsA7RGSO
         spjo8D3iHKfw6iGaKmn8ldHmZQteF6sulNexH5xLhyXlndS55v/Mjf1I1EoD43DpUWPd
         7D3g==
X-Gm-Message-State: AOJu0Yw/haN/iEiDX1vmK75Ul+Qzu0OrasXQuL2ITSQy5HlSJ9fgsMBw
	ExXHuhUjvbc8ZiwTus1tB564eY3eiIfmTSc6y0vtOCa+d++6n8g++woB1IWh69lMIBK3T66mIQz
	9KeR8mziSRp5JjhOgB7KeL6VYB2Nue0I1l7ozzRbNQzuPIg8=
X-Gm-Gg: ASbGnctJaI+Rt1iHdNsmIBatOASCJsmPfxT9wh7ajKEstSl78GVJDH+fiioUbuLiwIg
	t01il1C4t+Jxnzg10F9lqDKd20M2yvSr7
X-Google-Smtp-Source: AGHT+IGo2IUGy6n4YrQcy08QiD3NnT/2eOdNO3tWjARoACstCiWNIJIevsyMOeq0fq7yy0bQoGkn8GQodS5vSBT11hE=
X-Received: by 2002:a05:6102:32c9:b0:4ad:4e83:92be with SMTP id
 ada2fe7eead31-4addcbf254fmr14365037137.13.1732602713269; Mon, 25 Nov 2024
 22:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125042412.2865764-1-dw@davidwei.uk> <20241125042412.2865764-3-dw@davidwei.uk>
In-Reply-To: <20241125042412.2865764-3-dw@davidwei.uk>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 26 Nov 2024 12:01:42 +0530
Message-ID: <CAOBf=muRZ2SDeadY8Sjass8tZ3xM5iCYeJjEMDLgCZXnCoLOcg@mail.gmail.com>
Subject: Re: [PATCH net v1 2/3] bnxt_en: refactor bnxt_alloc_rx_rings() to
 call bnxt_alloc_rx_agg_bmap()
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000467db80627cb0199"

--000000000000467db80627cb0199
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 9:54=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> Refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap() for
> allocating rx_agg_bmap.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++-------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index b2cc8df22241..294d21cdaeb7 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3768,6 +3768,19 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp=
,
>         return PTR_ERR(pool);
>  }
>
> +static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_i=
nfo *rxr)
> +{
> +       u16 mem_size;
> +
> +       rxr->rx_agg_bmap_size =3D bp->rx_agg_ring_mask + 1;
> +       mem_size =3D rxr->rx_agg_bmap_size / 8;
> +       rxr->rx_agg_bmap =3D kzalloc(mem_size, GFP_KERNEL);
> +       if (!rxr->rx_agg_bmap)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
>  static int bnxt_alloc_rx_rings(struct bnxt *bp)
>  {
>         int numa_node =3D dev_to_node(&bp->pdev->dev);
> @@ -3812,19 +3825,15 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
>
>                 ring->grp_idx =3D i;
>                 if (agg_rings) {
> -                       u16 mem_size;
> -
>                         ring =3D &rxr->rx_agg_ring_struct;
>                         rc =3D bnxt_alloc_ring(bp, &ring->ring_mem);
>                         if (rc)
>                                 return rc;
>
>                         ring->grp_idx =3D i;
> -                       rxr->rx_agg_bmap_size =3D bp->rx_agg_ring_mask + =
1;
> -                       mem_size =3D rxr->rx_agg_bmap_size / 8;
> -                       rxr->rx_agg_bmap =3D kzalloc(mem_size, GFP_KERNEL=
);
> -                       if (!rxr->rx_agg_bmap)
> -                               return -ENOMEM;
> +                       rc =3D bnxt_alloc_rx_agg_bmap(bp, rxr);
> +                       if (rc)
> +                               return rc;
>                 }
>         }
>         if (bp->flags & BNXT_FLAG_TPA)
> @@ -15321,19 +15330,6 @@ static const struct netdev_stat_ops bnxt_stat_op=
s =3D {
>         .get_base_stats         =3D bnxt_get_base_stats,
>  };
>
> -static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_i=
nfo *rxr)
> -{
> -       u16 mem_size;
> -
> -       rxr->rx_agg_bmap_size =3D bp->rx_agg_ring_mask + 1;
> -       mem_size =3D rxr->rx_agg_bmap_size / 8;
> -       rxr->rx_agg_bmap =3D kzalloc(mem_size, GFP_KERNEL);
> -       if (!rxr->rx_agg_bmap)
> -               return -ENOMEM;
> -
> -       return 0;
> -}
> -
>  static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int =
idx)
>  {
>         struct bnxt_rx_ring_info *rxr, *clone;
> --
> 2.43.5
>
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000467db80627cb0199
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGkD1Lta9dPtaVS29vi6TJU6DSCj
tOOEoX7sPLdK3F3FMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MTEyNjA2MzE1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBKB3JSZrq4uZ1VRFkd+F77afwNCTtv8STSENorAaF/9xdV
jEyLGu3XaHyyfWdm0tBSY+2Q0VBLX6DGhFGTEfcd0/hdK5KOCg623vc213EzJ+FnKqy/IxUg4U0d
ANJ59Qz0rH43vpdAEZ9+gqSBsaW6KbBbVI7ggUcyg3JdyLCskJuWxHK+WSpIpCODZ7jN3VfR54sh
R/hFOGBZGjczpre22mPsnZmpJZmu8qY893z0F08j5IvuJiLw8wsIgNXINQJk79GyM/E4QG5Oh+zC
nALZymJW7hQ3HdqFL1TJvYd4nrXByhUBnOTevbLwKI45yO8GN3sTh94lW5myqGj/YnUy
--000000000000467db80627cb0199--

