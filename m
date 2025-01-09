Return-Path: <netdev+bounces-156533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E58A06DBE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 06:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA953A1F82
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE80214203;
	Thu,  9 Jan 2025 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="etV2AQ+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD41FFC7C
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736401899; cv=none; b=OVvOR0job3w2W/bLQYnY+tiFnKTGNu55tLQP1wsFzkInOkhA3KZaDu+0plkJqZZm9MT9XTAH/O4XlvP+RFkEWiE/Uv+El2TYxDtyc0Ewg7tiLB9XpOBTWCevihuYGNGwUwk70+YAluMfvbMq74aqT0mwxW1q/UmCzpE02DDt+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736401899; c=relaxed/simple;
	bh=V86FxyJDEPj4kTKtDOjnT6heuhBlkfxx6pFbIvB3Fso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0+pCaw6PLprCBrjVsWJzw3Pv7N7ikOtYm+WutCXNHe1vJT5BFl0I5ctBCeiS3YaW1jusCDtG165Fp77rFPiSW97lfCOG1ShXaba4HbVeio1CqUxX5XVPqOzqQFfSqM1YeKTbxdJZQB1gFC60JoEnNZYkLQ4m5kEs4bTkIFfeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=etV2AQ+L; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4b24d969db1so151093137.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 21:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736401897; x=1737006697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8WuYIBY1lKNh6Q5elJOIQEJpVXU8rmpy3MoFiQr2n/s=;
        b=etV2AQ+LP5NbDoE8QQNh6NZiBTJsK5dIjdhXQZZiizw6zDpCbyQntyamUPrWg6q4iz
         slx0/hY9fPEU/399MypbZUz+/9qh9deq1RhQHSyEzdzv1CmqMvBCgt8hyDXlnjK1w1/t
         4wC6JWSLYN/5QsB4FHe2ooe6fRS7xJz1TvWtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736401897; x=1737006697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WuYIBY1lKNh6Q5elJOIQEJpVXU8rmpy3MoFiQr2n/s=;
        b=T8XAt6EL8UAHyD6vTlU5uysDDlhZADJfDnxc3vZXqmVClCkOtf9YgOPnm6/bVTjx1P
         LXEWcmxWjF2U5S6i93qzJ1hGvg7r3KyJkFkJrW9EbrvpKg7co+25xyUeQayabAgc2M9+
         CQDzly33rzgAe7C3K+z6Rg050air+Kdf0ChW1cJhbSBepVM1N44cvlptHHYWR/RubY8a
         9FKArrduOeWmC/AKd1NFqNaylyu6GChRIRKGkWi2ZsQpsVo6MUwwgoPF8aaHCfI30KOE
         e1WhnthoA8TodijUC2ecZnrdWRKU0uTI9CiMN9ottXRnPHcWRH0598Yn36UIs31h8Es4
         vIbg==
X-Forwarded-Encrypted: i=1; AJvYcCXW6UYrjnmcQxwlQwzYGR+qCuyiIwDJqgZCIgJT3yQIKeHMQHkCMNdwDzRcYKeBltxmIMyNVfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzldO6iLffVemeFOUZJqs6WFf4mN+iOM/iFk5uHbxlfVfj9foQW
	6WGs3X4KbyJkY8XQKqSJAvOB0iJFS0tSeMtd1JTM33YjKQ+sD2kB56nVrv1CZKQV15mp/Um6759
	cXc5uJssj6YCx8UgBYFuS2v6Vurmxtzcl23Ub
X-Gm-Gg: ASbGncvKowf7w4TDk2tod2CkFVvyJwklqOJN76JQNn77fQbCvtVLHzEdqkcho48CaVm
	pAJqW8dbzd+URclK+unOAVMX4Msk+SDxpM3zSYf4=
X-Google-Smtp-Source: AGHT+IGSQrHU5SVLfoyfZIzW/tcZJ63V6azcswxQxplOW6tYxSuBi8OFLm2+WEopPuzKpfXX7rQgADCyOxUulLokZ88=
X-Received: by 2002:a05:6102:5108:b0:4b2:75a3:2267 with SMTP id
 ada2fe7eead31-4b3d0f94d7amr3563513137.10.1736401896855; Wed, 08 Jan 2025
 21:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109043057.2888953-1-kuba@kernel.org>
In-Reply-To: <20250109043057.2888953-1-kuba@kernel.org>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 9 Jan 2025 11:21:24 +0530
X-Gm-Features: AbW1kvaMOf8_uC_ZMF1z919DN_qp5GnGH985IGHKBVKw1UQwRtcfEvM3O7cK2gc
Message-ID: <CAOBf=msVHdy+bJ0yRdZDinBjSaw6yqTvXRG54pk0t1kNm_V5rg@mail.gmail.com>
Subject: Re: [PATCH net] eth: bnxt: always recalculate features after XDP
 clearing, fix null-deref
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, andrew.gospodarek@broadcom.com, 
	pavan.chebbi@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000043f737062b3f92d0"

--00000000000043f737062b3f92d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 10:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Recalculate features when XDP is detached.
>
> Before:
>   # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
>   # ip li set dev eth0 xdp off
>   # ethtool -k eth0 | grep gro
>   rx-gro-hw: off [requested on]
>
> After:
>   # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
>   # ip li set dev eth0 xdp off
>   # ethtool -k eth0 | grep gro
>   rx-gro-hw: on
>
> The fact that HW-GRO doesn't get re-enabled automatically is just
> a minor annoyance. The real issue is that the features will randomly
> come back during another reconfiguration which just happens to invoke
> netdev_update_features(). The driver doesn't handle reconfiguring
> two things at a time very robustly.
>
> Starting with commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
> __bnxt_reserve_rings()") we only reconfigure the RSS hash table
> if the "effective" number of Rx rings has changed. If HW-GRO is
> enabled "effective" number of rings is 2x what user sees.
> So if we are in the bad state, with HW-GRO re-enablement "pending"
> after XDP off, and we lower the rings by / 2 - the HW-GRO rings
> doing 2x and the ethtool -L doing / 2 may cancel each other out,
> and the:
>
>   if (old_rx_rings !=3D bp->hw_resc.resv_rx_rings &&
>
> condition in __bnxt_reserve_rings() will be false.
> The RSS map won't get updated, and we'll crash with:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000168
>   RIP: 0010:__bnxt_hwrm_vnic_set_rss+0x13a/0x1a0
>     bnxt_hwrm_vnic_rss_cfg_p5+0x47/0x180
>     __bnxt_setup_vnic_p5+0x58/0x110
>     bnxt_init_nic+0xb72/0xf50
>     __bnxt_open_nic+0x40d/0xab0
>     bnxt_open_nic+0x2b/0x60
>     ethtool_set_channels+0x18c/0x1d0
>
> As we try to access a freed ring.
>
> The issue is present since XDP support was added, really, but
> prior to commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
> __bnxt_reserve_rings()") it wasn't causing major issues.
>
> Fixes: 1054aee82321 ("bnxt_en: Use NETIF_F_GRO_HW.")
> Fixes: 98ba1d931f61 ("bnxt_en: Fix RSS logic in __bnxt_reserve_rings()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: michael.chan@broadcom.com
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: andrew.gospodarek@broadcom.com
> CC: pavan.chebbi@broadcom.com
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++++++----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  7 ------
>  3 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index aeaa74f03046..b6f844cac80e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4708,7 +4708,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
>  /* Changing allocation mode of RX rings.
>   * TODO: Update when extending xdp_rxq_info to support allocation modes.
>   */
> -int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
> +static void __bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
>  {
>         struct net_device *dev =3D bp->dev;
>
> @@ -4729,15 +4729,30 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool pa=
ge_mode)
>                         bp->rx_skb_func =3D bnxt_rx_page_skb;
>                 }
>                 bp->rx_dir =3D DMA_BIDIRECTIONAL;
> -               /* Disable LRO or GRO_HW */
> -               netdev_update_features(dev);
>         } else {
>                 dev->max_mtu =3D bp->max_mtu;
>                 bp->flags &=3D ~BNXT_FLAG_RX_PAGE_MODE;
>                 bp->rx_dir =3D DMA_FROM_DEVICE;
>                 bp->rx_skb_func =3D bnxt_rx_skb;
>         }
> -       return 0;
> +}
> +
> +void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
> +{
> +       __bnxt_set_rx_skb_mode(bp, page_mode);
> +
> +       if (!page_mode) {
> +               int rx, tx;
> +
> +               bnxt_get_max_rings(bp, &rx, &tx, true);
> +               if (rx > 1) {
> +                       bp->flags &=3D ~BNXT_FLAG_NO_AGG_RINGS;
> +                       bp->dev->hw_features |=3D NETIF_F_LRO;
> +               }
> +       }
> +
> +       /* Update LRO and GRO_HW availability */
> +       netdev_update_features(bp->dev);
>  }
>
>  static void bnxt_free_vnic_attributes(struct bnxt *bp)
> @@ -16214,7 +16229,7 @@ static int bnxt_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>         if (bp->max_fltr < BNXT_MAX_FLTR)
>                 bp->max_fltr =3D BNXT_MAX_FLTR;
>         bnxt_init_l2_fltr_tbl(bp);
> -       bnxt_set_rx_skb_mode(bp, false);
> +       __bnxt_set_rx_skb_mode(bp, false);
>         bnxt_set_tpa_flags(bp);
>         bnxt_set_ring_params(bp);
>         bnxt_rdma_aux_device_init(bp);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 7df7a2233307..f11ed59203d9 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2846,7 +2846,7 @@ u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_i=
dx);
>  bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
>  void bnxt_set_tpa_flags(struct bnxt *bp);
>  void bnxt_set_ring_params(struct bnxt *);
> -int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
> +void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
>  void bnxt_insert_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr=
);
>  void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *flt=
r);
>  int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_xdp.c
> index f88b641533fc..dc51dce209d5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -422,15 +422,8 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_=
prog *prog)
>                 bnxt_set_rx_skb_mode(bp, true);
>                 xdp_features_set_redirect_target(dev, true);
>         } else {
> -               int rx, tx;
> -
>                 xdp_features_clear_redirect_target(dev);
>                 bnxt_set_rx_skb_mode(bp, false);
> -               bnxt_get_max_rings(bp, &rx, &tx, true);
> -               if (rx > 1) {
> -                       bp->flags &=3D ~BNXT_FLAG_NO_AGG_RINGS;
> -                       bp->dev->hw_features |=3D NETIF_F_LRO;
> -               }
>         }
>         bp->tx_nr_rings_xdp =3D tx_xdp;
>         bp->tx_nr_rings =3D bp->tx_nr_rings_per_tc * tc + tx_xdp;
> --
> 2.47.1
>
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--00000000000043f737062b3f92d0
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILwBZ6QvsEIZiOi8MTJfyHomhlt5
2tR47+I3OWlNqyRvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDEwOTA1NTEzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQC1puyjhYVQf2vkoYIxrjAyfpV25wO7GyE+7jvmedr4FtZO
7zMDv5ShlEf1D3lW9Nrb1fUA19vY7q3S2qTruEOrl4QWS8qvTbxXCv2QY1pIeNazpdIHadY1fErv
zKxu8UcBkX4Dz6dC90A4Uyf7zcT9yHpXsVXYX26oDsvsrGfieS6cTT0u4qHFnN1A3JfVUsiVdf7B
QU0P284iemQzxcx4I6VH5F9chlg+bd8Uzr5rLRTBy82l9QUCw5DKfc8lTZmd53+HIkF3NPrbuCf7
Snpia8tcPyJiCbNdqAPQpH/sVhIUYP6iBLJxkgi0FJNiZ1LDcYNxNWgGVkGqrwIukBIR
--00000000000043f737062b3f92d0--

