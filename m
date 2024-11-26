Return-Path: <netdev+bounces-147330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4DC9D91CA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 07:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77C9164DCF
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 06:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9969D31;
	Tue, 26 Nov 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NueduGRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8510940
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602669; cv=none; b=Rh3giWP8LvCh1qqeQlpUGIpv9LTaUPg0KdTS6GrBPignaF0fKiVYrf5Ep9E6mh1GDWO2Z2xdpdzgoFCm+PelagICEbzRvAaSR0r6OCor9g4W2HKsWecaVaTXfpFOEc6/ord8CRJDJoI23jSSTLsmrnb6Ykah/AsP746eqHyW478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602669; c=relaxed/simple;
	bh=ifyKNTHyzlftTzQIIUF/nSQrtM5pnGEGArNh948fmKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msoDaa87NBH4fSj10gwwzw13zDdKtakkt2+9A7x250mVCPqSiNxw4EcEt6BWsoyalltEluJP+B8jrBTDsvXT1iAT6OiiLhFpWYS9aXkRgekOVLUSZRdf22xIMfzQBSkG3kFnOi3+UmWYz5nvw/orL348o9EksCWW44vVHs0kRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NueduGRu; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4ad564437edso2179451137.1
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 22:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732602666; x=1733207466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VeYr50zAyav3xAlvso4ygPe7Qgtaus6L9v5H8dj22wE=;
        b=NueduGRuQScSwdbyg15FsJkKCliR3Ih68rF7MlaTmCQ7HtLJAVw1NuS04RZpZUv4y1
         YlExotNJP7xMWL+PJ7k5lmHmFWBoa6ivw1RZMBB/jR9pYkc6Mu5D7izEQndPLp5ktq82
         AXWrYNLrbOwmTwo4dDCV8zUCFtCh9ZC1sx3EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732602666; x=1733207466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeYr50zAyav3xAlvso4ygPe7Qgtaus6L9v5H8dj22wE=;
        b=jV5oX401KY4sxEEcTx+J82t/LLpdY399m2d7XNe4U0DJweOCthoYqfoyRMDE8fGjwV
         V0j6ZdOz3vEYDu7Yk8fcYwatgurdJ4O9e2cjNzBsnrUBjarAHBVzd+in7Qk+JCxPkI9T
         Iv5OW01YLbNNuj6j5L7RqdNYerINv7qVZa/OvO8HUFIIXyo45B/4KIkh8sUA6dI5YhEk
         yM9DlWq7Zo/Oy8gkGWKIDtikvuIf3On1y4G3xOAG3J+OFaID5IaHYTayvvgr2B0r/Bpi
         Oor4NzDJ/625OqqZoEvt/Vy8Bywp7FnUMMBayEkpvoHgStOxsQU34bKpauWtROd6AfZk
         LL3A==
X-Gm-Message-State: AOJu0YxzXxJFKL9+OuImYTGaHk19JnzEUWY5AGx+F9I1JS7UVimir++r
	uQhyROVRKe1VeL76h/C282eDKtJS1V9rh2CSFpSLU5vYwkyyadmdhrg6SJ+2cVg09BBPdGbeu3D
	buK20Ekv+fd1Gzdk7u8M/uBwwMZFYlGTqqjN0
X-Gm-Gg: ASbGncu6M6L4zPohgvNQKNIrD73/a/MmslBf17k6KOhIVSKIWcUwKRdvIYbFM1z1KON
	YShKn6e79NNQ5Amh9XC3v564tOiT3A39b
X-Google-Smtp-Source: AGHT+IGIaA7lTwVkw0SP1sqGvXO5QRR5Ja46Kngi61GDIdqqJXjzyc6I8cuCatm7vu9bNt1hgNrcxWgyEV/1qZ1Xq1I=
X-Received: by 2002:a05:6102:3e23:b0:4af:f45:d360 with SMTP id
 ada2fe7eead31-4af35ea8901mr2661401137.5.1732602665808; Mon, 25 Nov 2024
 22:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125042412.2865764-1-dw@davidwei.uk> <20241125042412.2865764-2-dw@davidwei.uk>
In-Reply-To: <20241125042412.2865764-2-dw@davidwei.uk>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 26 Nov 2024 12:00:54 +0530
Message-ID: <CAOBf=mvEEHeLP4CF76b7ip2VHz82V+c23trCkVeArjP9iJ0sfg@mail.gmail.com>
Subject: Re: [PATCH net v1 1/3] bnxt_en: refactor tpa_info alloc/free into helpers
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000731a3e0627cafe8d"

--000000000000731a3e0627cafe8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 9:54=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> Refactor bnxt_rx_ring_info->tpa_info operations into helpers that work
> on a single tpa_info in prep for queue API using them.
>
> There are 2 pairs of operations:
>
> * bnxt_alloc_one_tpa_info()
> * bnxt_free_one_tpa_info()
>
> These alloc/free the tpa_info array itself.
>
> * bnxt_alloc_one_tpa_info_data()
> * bnxt_free_one_tpa_info_data()
>
> These alloc/free the frags stored in tpa_info array.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 148 ++++++++++++++--------
>  1 file changed, 95 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 5f7bdafcf05d..b2cc8df22241 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3421,15 +3421,11 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt=
 *bp, struct bnxt_rx_ring_info
>         }
>  }
>
> -static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
> +static void bnxt_free_one_tpa_info_data(struct bnxt *bp,
> +                                       struct bnxt_rx_ring_info *rxr)
>  {
> -       struct bnxt_rx_ring_info *rxr =3D &bp->rx_ring[ring_nr];
> -       struct bnxt_tpa_idx_map *map;
>         int i;
>
> -       if (!rxr->rx_tpa)
> -               goto skip_rx_tpa_free;
> -
>         for (i =3D 0; i < bp->max_tpa; i++) {
>                 struct bnxt_tpa_info *tpa_info =3D &rxr->rx_tpa[i];
>                 u8 *data =3D tpa_info->data;
> @@ -3440,6 +3436,17 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt=
 *bp, int ring_nr)
>                 tpa_info->data =3D NULL;
>                 page_pool_free_va(rxr->head_pool, data, false);
>         }
> +}
> +
> +static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp,
> +                                      struct bnxt_rx_ring_info *rxr)
> +{
> +       struct bnxt_tpa_idx_map *map;
> +
> +       if (!rxr->rx_tpa)
> +               goto skip_rx_tpa_free;
> +
> +       bnxt_free_one_tpa_info_data(bp, rxr);
>
>  skip_rx_tpa_free:
>         if (!rxr->rx_buf_ring)
> @@ -3461,13 +3468,17 @@ static void bnxt_free_one_rx_ring_skbs(struct bnx=
t *bp, int ring_nr)
>
>  static void bnxt_free_rx_skbs(struct bnxt *bp)
>  {
> +       struct bnxt_rx_ring_info *rxr;
>         int i;
>
>         if (!bp->rx_ring)
>                 return;
>
> -       for (i =3D 0; i < bp->rx_nr_rings; i++)
> -               bnxt_free_one_rx_ring_skbs(bp, i);
> +       for (i =3D 0; i < bp->rx_nr_rings; i++) {
> +               rxr =3D &bp->rx_ring[i];
> +
> +               bnxt_free_one_rx_ring_skbs(bp, rxr);
Minor nit; Could avoid a declaration and an assignment here by
directly calling this API with the 2nd param set to &bp->rx_ring[i] ?
> +       }
>  }
>
>  static void bnxt_free_skbs(struct bnxt *bp)
> @@ -3608,29 +3619,64 @@ static int bnxt_alloc_ring(struct bnxt *bp, struc=
t bnxt_ring_mem_info *rmem)
>         return 0;
>  }
>
> +static void bnxt_free_one_tpa_info(struct bnxt *bp,
> +                                  struct bnxt_rx_ring_info *rxr)
> +{
> +       int i;
> +
> +       kfree(rxr->rx_tpa_idx_map);
> +       rxr->rx_tpa_idx_map =3D NULL;
> +       if (rxr->rx_tpa) {
> +               for (i =3D 0; i < bp->max_tpa; i++) {
> +                       kfree(rxr->rx_tpa[i].agg_arr);
> +                       rxr->rx_tpa[i].agg_arr =3D NULL;
> +               }
> +       }
> +       kfree(rxr->rx_tpa);
> +       rxr->rx_tpa =3D NULL;
> +}
> +
>  static void bnxt_free_tpa_info(struct bnxt *bp)
>  {
> -       int i, j;
> +       int i;
>
>         for (i =3D 0; i < bp->rx_nr_rings; i++) {
>                 struct bnxt_rx_ring_info *rxr =3D &bp->rx_ring[i];
>
> -               kfree(rxr->rx_tpa_idx_map);
> -               rxr->rx_tpa_idx_map =3D NULL;
> -               if (rxr->rx_tpa) {
> -                       for (j =3D 0; j < bp->max_tpa; j++) {
> -                               kfree(rxr->rx_tpa[j].agg_arr);
> -                               rxr->rx_tpa[j].agg_arr =3D NULL;
> -                       }
> -               }
> -               kfree(rxr->rx_tpa);
> -               rxr->rx_tpa =3D NULL;
> +               bnxt_free_one_tpa_info(bp, rxr);
> +       }
> +}
> +
> +static int bnxt_alloc_one_tpa_info(struct bnxt *bp,
> +                                  struct bnxt_rx_ring_info *rxr)
> +{
> +       struct rx_agg_cmp *agg;
> +       int i;
> +
> +       rxr->rx_tpa =3D kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info)=
,
> +                             GFP_KERNEL);
> +       if (!rxr->rx_tpa)
> +               return -ENOMEM;
> +
> +       if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
> +               return 0;
> +       for (i =3D 0; i < bp->max_tpa; i++) {
> +               agg =3D kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
> +               if (!agg)
> +                       return -ENOMEM;
> +               rxr->rx_tpa[i].agg_arr =3D agg;
>         }
> +       rxr->rx_tpa_idx_map =3D kzalloc(sizeof(*rxr->rx_tpa_idx_map),
> +                                     GFP_KERNEL);
> +       if (!rxr->rx_tpa_idx_map)
> +               return -ENOMEM;
> +
> +       return 0;
>  }
>
>  static int bnxt_alloc_tpa_info(struct bnxt *bp)
>  {
> -       int i, j;
> +       int i, rc;
>
>         bp->max_tpa =3D MAX_TPA;
>         if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> @@ -3641,25 +3687,10 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
>
>         for (i =3D 0; i < bp->rx_nr_rings; i++) {
>                 struct bnxt_rx_ring_info *rxr =3D &bp->rx_ring[i];
> -               struct rx_agg_cmp *agg;
>
> -               rxr->rx_tpa =3D kcalloc(bp->max_tpa, sizeof(struct bnxt_t=
pa_info),
> -                                     GFP_KERNEL);
> -               if (!rxr->rx_tpa)
> -                       return -ENOMEM;
> -
> -               if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
> -                       continue;
> -               for (j =3D 0; j < bp->max_tpa; j++) {
> -                       agg =3D kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_=
KERNEL);
> -                       if (!agg)
> -                               return -ENOMEM;
> -                       rxr->rx_tpa[j].agg_arr =3D agg;
> -               }
> -               rxr->rx_tpa_idx_map =3D kzalloc(sizeof(*rxr->rx_tpa_idx_m=
ap),
> -                                             GFP_KERNEL);
> -               if (!rxr->rx_tpa_idx_map)
> -                       return -ENOMEM;
> +               rc =3D bnxt_alloc_one_tpa_info(bp, rxr);
> +               if (rc)
> +                       return rc;
>         }
>         return 0;
>  }
> @@ -4268,10 +4299,31 @@ static void bnxt_alloc_one_rx_ring_page(struct bn=
xt *bp,
>         rxr->rx_agg_prod =3D prod;
>  }
>
> +static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
> +                                       struct bnxt_rx_ring_info *rxr)
> +{
> +       dma_addr_t mapping;
> +       u8 *data;
> +       int i;
> +
> +       for (i =3D 0; i < bp->max_tpa; i++) {
> +               data =3D __bnxt_alloc_rx_frag(bp, &mapping, rxr,
> +                                           GFP_KERNEL);
> +               if (!data)
> +                       return -ENOMEM;
> +
> +               rxr->rx_tpa[i].data =3D data;
> +               rxr->rx_tpa[i].data_ptr =3D data + bp->rx_offset;
> +               rxr->rx_tpa[i].mapping =3D mapping;
> +       }
> +
> +       return 0;
> +}
> +
>  static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
>  {
>         struct bnxt_rx_ring_info *rxr =3D &bp->rx_ring[ring_nr];
> -       int i;
> +       int rc;
>
>         bnxt_alloc_one_rx_ring_skb(bp, rxr, ring_nr);
>
> @@ -4281,19 +4333,9 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp,=
 int ring_nr)
>         bnxt_alloc_one_rx_ring_page(bp, rxr, ring_nr);
>
>         if (rxr->rx_tpa) {
> -               dma_addr_t mapping;
> -               u8 *data;
> -
> -               for (i =3D 0; i < bp->max_tpa; i++) {
> -                       data =3D __bnxt_alloc_rx_frag(bp, &mapping, rxr,
> -                                                   GFP_KERNEL);
> -                       if (!data)
> -                               return -ENOMEM;
> -
> -                       rxr->rx_tpa[i].data =3D data;
> -                       rxr->rx_tpa[i].data_ptr =3D data + bp->rx_offset;
> -                       rxr->rx_tpa[i].mapping =3D mapping;
> -               }
> +               rc =3D bnxt_alloc_one_tpa_info_data(bp, rxr);
> +               if (rc)
> +                       return rc;
>         }
>         return 0;
>  }
> @@ -13657,7 +13699,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
>                         bnxt_reset_task(bp, true);
>                         break;
>                 }
> -               bnxt_free_one_rx_ring_skbs(bp, i);
> +               bnxt_free_one_rx_ring_skbs(bp, rxr);
>                 rxr->rx_prod =3D 0;
>                 rxr->rx_agg_prod =3D 0;
>                 rxr->rx_sw_agg_prod =3D 0;
> --
> 2.43.5
>
>
Other than the one minor suggestion, LGTM otherwise

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000731a3e0627cafe8d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDHrACvo11BjSxMYbtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDJaFw0yNTA5MTAwODE4NDJaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVNvbW5hdGggS290dXIxKTAnBgkqhkiG9w0B
CQEWGnNvbW5hdGgua290dXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAwSM6HryOBKGRppHga4G18QnbgnWFlW7A7HePfwcVN3QOMgkXq0EfqT2hd3VAX9Dgoi2U
JeG28tGwAJpNxAD+aAlL0MVG7D4IcsTW9MrBzUGFMBpeUqG+81YWwUNqxL47kkNHZU5ecEbaUto9
ochP8uGU16ud4wv60eNK59ZvoBDzhc5Po2bEQxrJ5c8V5JHX1K2czTnR6IH6aPmycffF/qHXfWHN
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE+WrYMD8XwRqemINwIqy+UmUmUF
90DTwGgZBbr69I7WMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MTEyNjA2MzEwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAIt4Bs0FOLlM4Z/sIRgpPInxQ3+0HDebn3qlSuCI4OxSTr
KShEqnyRRpFFdOvDrA5z42mvQjWSyHACiJBgH34ZXV0Rlp8Dr3NhyBkv6EOpOwrCE8cao7QuRqSP
1ym7WnpVgRuGSuFJcXh3jXgRZ4MErYksdl86qbzs+CdJqOUpHqFtlJ3lDmCqUP5LQ9lfwVizDnOC
mwqKOQVQKE9MTO2y1pZ9rMs3gtkOCs1KVE3oYGwdlDJ5XY8SG+zCvttPUCOSG7SK74AG90xkoShP
tpAXR71BVBRp5BINTi/i9DByxIcyPiQapHioOxStWivU2n3bFGBF1Fwo+9HkOq0pBmhS
--000000000000731a3e0627cafe8d--

