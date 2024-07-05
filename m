Return-Path: <netdev+bounces-109409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F192928681
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB68C2873B0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE801448C6;
	Fri,  5 Jul 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RHioyVrx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4649629
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174557; cv=none; b=E3gwYq9qGQoZRGaSwzpgbUGxMXURjxn9vhIhZB9dZ72XyfWL6JT90PKugjtstg5ejcvFDp/oKT2/D/BI+2+7ksbMSfEcDBnf9saiVdP4QS1pkJM6cuWEt54pCFGH2SPfGSMqN0TBiPQYFczmp3i26CZW+hmcaUuxMcH6IJhc/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174557; c=relaxed/simple;
	bh=tThA9jbct+QZaqXxIQl8O0KtRTSoTpMmVIohRhKH7rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPVzHbeZ5FSjbB8MVtcMeLoy3eP+wsJv35ij3TeX7WNnRx/3ISOpgYx7TmWJ8ph5FgVi2axMPKjO9fccaGsXDqj9MZsxDItFJFf+nIOrmF54Gyc0MgxomNLd0ID12WQkCvJKIyCRM3iitIu+A4cQEfRHdoXM0/yb2iLVuQ8gVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RHioyVrx; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d63332595cso749896b6e.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720174554; x=1720779354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jX9DSjyWF+Dk3l5YkcGb6VUo8noo7pjoBzs/HIb4N4w=;
        b=RHioyVrxhkabMUpftgrVCbiJ3eDlGpEfY9zBaPVKx550zGSHL6UO1rKb0Wp12Pwu44
         wt7rjT97y1J0Hh67U+a9d+9mHdLqrJOUtCeW9YHRZicHzBVu80dTezKjg+W5THA+I8jg
         Cl0FeiWxJQlGZsjXHzGKt0e1uMopmAybTFrBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174554; x=1720779354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jX9DSjyWF+Dk3l5YkcGb6VUo8noo7pjoBzs/HIb4N4w=;
        b=HBLv+MXojhGsKtKZTidtT6nnAk38XC80VLxLPfKRug1KLk77+dh6UKw25rxjXJ8HNj
         qmu/6cPf/w6CibNj/A8jTx38uOGBcr2tbRhZiRZwGEOcabrqqOmYQhlSgSRQX+nooVVj
         yRlcu1+nwfLGtoTbGxKTjDo/4SS0eSRe/rJpj3h15ZYv1taZkMi2w+9yQfXJ+39FZ6sr
         RvQzTDUe+GleEmtagcKexehbN61wE8Ma/GJxIGuY0i971RzO3nOdHRNMWjMWTUA5rFYT
         iO9XhNK4PsUvmQIMtLa7jv4erRmoMFsYiZzuOvF4k5BVmr2NHCn5wYRv02JeiLWOK2kK
         0DTg==
X-Forwarded-Encrypted: i=1; AJvYcCVrmISGbf+CU93Pd6mv7TUAy+0Xxkmn0u5oIB7HVNnO0SxnRcbkQKCagniIjpfcYdq37e8bQqpHNJ/6Ah3QJvtyutG5XmDi
X-Gm-Message-State: AOJu0YxVwi1BzfFXEJf7JBilJkSwfuIXYBVB58+PQ784k/aVCtx/lLet
	nJp3jj6gvI3mWiBplxz90XlU7aipXo3Rb6iwYNtdgou+Da3ekSrQMoAfrxnD3aErJq0CttZrqrT
	CIK+zyr/ed06bDH6vrQnUS2vnI990IDxq4EBV
X-Google-Smtp-Source: AGHT+IEIWdyelYAVx6KcrzyMeLZ2xcXJNGAQc7Ge/+Xzz/SUWUZjGNiW5EowdlxCEmJKgghknEfdOnTP0ywgcyrJ+eM=
X-Received: by 2002:a05:6808:1b27:b0:3d5:5cd4:5a1e with SMTP id
 5614622812f47-3d914c4b2admr4756685b6e.1.1720174554663; Fri, 05 Jul 2024
 03:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705020005.681746-1-kuba@kernel.org>
In-Reply-To: <20240705020005.681746-1-kuba@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 5 Jul 2024 15:45:42 +0530
Message-ID: <CALs4sv3S_G6k7T2R3GGHy-zNqfr6E2aXMQk1crZytqhJxHOY-A@mail.gmail.com>
Subject: Re: [PATCH net] bnxt: fix crashes when reducing ring count with
 active RSS contexts
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, michael.chan@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004d0c6b061c7d59bb"

--0000000000004d0c6b061c7d59bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> bnxt doesn't check if a ring is used by RSS contexts when reducing
> ring count. Core performs a similar check for the drivers for
> the main context, but core doesn't know about additional contexts,
> so it can't validate them. bnxt_fill_hw_rss_tbl_p5() uses ring
> id to index bp->rx_ring[], which without the check may end up
> being out of bounds.
>
>   BUG: KASAN: slab-out-of-bounds in __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
>   Read of size 2 at addr ffff8881c5809618 by task ethtool/31525
>   Call Trace:
>   __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
>    bnxt_hwrm_vnic_rss_cfg_p5+0xf7/0x460
>    __bnxt_setup_vnic_p5+0x12e/0x270
>    __bnxt_open_nic+0x2262/0x2f30
>    bnxt_open_nic+0x5d/0xf0
>    ethnl_set_channels+0x5d4/0xb30
>    ethnl_default_set_doit+0x2f1/0x620
>
> Core does track the additional contexts in net-next, so we can
> move this validation out of the driver as a follow up there.
>
> Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|set}=
_rxfh()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: michael.chan@broadcom.com
> CC: pavan.chebbi@broadcom.com
> CC: kalesh-anakkur.purayil@broadcom.com
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 15 +++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 ++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 220d05e2f6fa..80fce0aaad66 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -6282,6 +6282,21 @@ static u16 bnxt_get_max_rss_ring(struct bnxt *bp)
>         return max_ring;
>  }
>
> +u16 bnxt_get_max_rss_ctx_ring(struct bnxt *bp)
> +{
> +       u16 i, tbl_size, max_ring =3D 0;
> +       struct bnxt_rss_ctx *rss_ctx;
> +
> +       tbl_size =3D bnxt_get_rxfh_indir_size(bp->dev);
> +
> +       list_for_each_entry(rss_ctx, &bp->rss_ctx_list, list) {
> +               for (i =3D 0; i < tbl_size; i++)
> +                       max_ring =3D max(max_ring, rss_ctx->rss_indir_tbl=
[i]);
> +       }
> +
> +       return max_ring;
> +}
> +
>  int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
>  {
>         if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index e46bd11e52b0..3c8826875ceb 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2814,6 +2814,7 @@ int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct =
bnxt_vnic_info *vnic,
>  void bnxt_fill_ipv6_mask(__be32 mask[4]);
>  int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_c=
tx);
>  void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *r=
ss_ctx);
> +u16 bnxt_get_max_rss_ctx_ring(struct bnxt *bp);
>  int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
>  int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
>  int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index bf157f6cc042..4d53ec7adc61 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -961,6 +961,12 @@ static int bnxt_set_channels(struct net_device *dev,
>                 return rc;
>         }
>
> +       if (req_rx_rings < bp->rx_nr_rings &&
> +           req_rx_rings <=3D bnxt_get_max_rss_ctx_ring(bp)) {
> +               netdev_warn(dev, "Can't deactivate rings used by RSS cont=
exts\n");
> +               return -EINVAL;
> +       }
> +
>         if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=3D
>             bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
>             netif_is_rxfh_configured(dev)) {
> --
> 2.45.2
>
Thanks Jakub for the patch. This is much better than my earlier
thought of prioritizing ring change by destroying all the RSS ctxs.
Patch LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000004d0c6b061c7d59bb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBeW3jQwoAuKKbcB7VOHkKqkknMEryNH
05lTDcOPWQNpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcw
NTEwMTU1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBn+0QVKX4uBkR1EA8KqDK+s6HPIea8LL44znSqUnMyGjVAyNJU
laN9OYnUTLeSj8BrZ3yItac8z2U9MpzZ9pJ2Eqp4tacV/iH/VSkteNyGDZMHp8isz7WxZWSR+7KK
su2V10QNRK+nW2E3zB0JIG0E1jzjOKtXtRgi9LP7WWsXuUkHri1qk6mgfLuOv1saYnVbcjFAoN7v
RH5GZ7pzLYmdjvq3xizKifEK7yfEJUCfFJjecKibYDUp457n8LKdHQ90ReQqCSgtFG2xH1Z1OG82
xDss65lRLYF2B1lEMiegQGIibzGHIrdz2N7YO9+MWja8DlnGm1OpqxjP6IgPxgwI
--0000000000004d0c6b061c7d59bb--

