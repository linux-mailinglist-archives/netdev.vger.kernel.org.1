Return-Path: <netdev+bounces-183404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45CA9098C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC2E3B154A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B0215772;
	Wed, 16 Apr 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SJbQILD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4521147A
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823019; cv=none; b=B+SYYSRJzZgnnfrN8vwZRmQWrrf2QMAuwtxpung7TCeAhuGHUjXSh8tpJnplkgfZCtMMjzsBDQ6zP174IaJKYsHzo/VMlQqKdTPVUGD112A0L128kMJFjp3226dws+wn4ZZgfrdU8aqMUfYhR4DOwrELNPyP7qlt1cDznKwT6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823019; c=relaxed/simple;
	bh=lpP7n//8i6BEukh7A545p1D9KIYMHi1D82Ac6RWH7eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1HvzH3H0cTr5r5e+aFrjDdUNycYxD+NGT/1SqztmagDBeiNlt0rlYYgFO78ug2wgE/N+CoZCeEMm6HPjRIFTXAtK6KiWk4rxIfOmvhVFkhtn3zc6A/xE+ps4BdLx4VsuGWaSYv/tXS+t/1tMc+I7wGDVx3eYcW9m9CtNbTluxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SJbQILD+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so10868247a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744823016; x=1745427816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M6AQwEytdu/l5QPGQTRHkY9tngmVUDA9gN8YAg9gGc8=;
        b=SJbQILD+98Dxgby02Sar5aDtaXn0gKlfgFlXFDHl2dfNLB/DTGOaFWxdk/7rz64HIy
         iMsFVyaNAoA27VJyj3ey1GeGzW4c28pq8spGz5MVzY+HYFXBnjRAmhRIRsvZuGHWUT8c
         t5XVid+Gq/ghVlfFXP3d2xIv4f9aqv3i3NbxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744823016; x=1745427816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6AQwEytdu/l5QPGQTRHkY9tngmVUDA9gN8YAg9gGc8=;
        b=cLeF0UN6fEHhVvjLsJBm1s+9EUkVXzD6aUe15KiJpjxDC4K5tJkrEcVjhphPTHvhIS
         LD5M8KfOlRBMsv1m+D5o6YvYUPsh369twE1duV4tRutHua6sLXv/upO+1y3PDESQmtzl
         6CEM2pomlTWBRftke2i/FnwFvktInZsoH/9hDuoZnRGV4nbiLxaJHsHRMZ7mtsIA2D9o
         CkYEIv2rLq6WvIyBSw0E9fTdTiD6DaVUPtWIb6cTXYccGRuso5PurgH3/1Azd4EnMakN
         kraJsywiAq0wdKir7ZSU6mjN3xmx/YhrqLhxUKX8KLZWx/HpiO2BHNfD/SRtBCcaUjwd
         YYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/e7EXY5GwiohV2VTA9W1soQlaU8vtozQHSgOiXcC/xKuR10yxHIBZFlix7myJd5eqhJZu4CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1M71TGy7A/RW089AovZOSqd3F2pzm348MMOcnwwlPRPG5iXPH
	lsZmFt5MCnA1hiL6UbZH639wTU6RvbP9rUm7F97mL4HKesVwYjOmq9zRXPR/Z9js+T98nfbA1Gb
	9DIWdkX+27TazLVf/nPSVUrL26RAaN3wO3MeS
X-Gm-Gg: ASbGncs1jBJsD4IFO+OhFYCiwuQWdK7nUUz23hCjk7gHsgx25KGefwME6d50e4mAwvL
	BxlRJ8L294aPK55cKskueI2JOGI/bJmDaRqAOePXxy3pva8RdWTLjd66eorRj3NgKBf6GzX/I5s
	4DC9Fk27+ofzhGMlmV2ITHe3zAA7Nag34UWQ==
X-Google-Smtp-Source: AGHT+IGfDjVHjjGVpwyI8mwDs84dEdjsxFCJrCHn1gaPQB2GanQYNSPVcp8m64N5f1ZEyD/GPHxqxp7yMNZdafZDtuo=
X-Received: by 2002:a05:6402:278d:b0:5dc:c531:e5c0 with SMTP id
 4fb4d7f45d1cf-5f4b76fc5d8mr2365369a12.27.1744823015436; Wed, 16 Apr 2025
 10:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416150057.3904571-1-vadfed@meta.com>
In-Reply-To: <20250416150057.3904571-1-vadfed@meta.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 16 Apr 2025 10:03:22 -0700
X-Gm-Features: ATxdqUFgKYbXbqIEFSouFtJ3xKYoXGROmhYueC2uOI_EQV8LuW5DJOD_zzFxYwA
Message-ID: <CACKFLin8=vm8MBBFpFgJv2Jw4Vn_m43cvXZUEMTfhgFnjZ+m1w@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: improve TX timestamping FIFO configuration
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001780ce0632e844c3"

--0000000000001780ce0632e844c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 8:01=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> Reconfiguration of netdev may trigger close/open procedure which can
> break FIFO status by adjusting the amount of empty slots for TX
> timestamps. But it is not really needed because timestamps for the
> packets sent over the wire still can be retrieved. On the other side,
> during netdev close procedure any skbs waiting for TX timestamps can be
> leaked because there is no cleaning procedure called. Free skbs waiting
> for TX timestamps when closing netdev.
>
> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX =
packets to 4")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 ++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 23 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
>  3 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index c8e3468eee61..45d178586316 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3517,6 +3517,8 @@ static void bnxt_free_skbs(struct bnxt *bp)
>  {
>         bnxt_free_tx_skbs(bp);
>         bnxt_free_rx_skbs(bp);
> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);

Since these are TX SKBs, it's slightly more logical if we put this in
bnxt_free_tx_skbs().

>  }
>
>  static void bnxt_init_ctx_mem(struct bnxt_ctx_mem_type *ctxm, void *p, i=
nt len)

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index 2d4e19b96ee7..39dc4f1f651a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -794,6 +794,29 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_in=
fo *ptp_info)
>         return HZ;
>  }
>
> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
> +{
> +       struct bnxt_ptp_tx_req *txts_req;
> +       u16 cons =3D ptp->txts_cons;
> +
> +       /* make sure ptp aux worker finished with
> +        * possible BNXT_STATE_OPEN set
> +        */
> +       ptp_cancel_worker_sync(ptp->ptp_clock);
> +
> +       spin_lock_bh(&ptp->ptp_tx_lock);

I think the spinlock is not needed because bnxt_tx_disable() should
have been called already in the close path.

> +       ptp->tx_avail =3D BNXT_MAX_TX_TS;
> +       while (cons !=3D ptp->txts_prod) {
> +               txts_req =3D &ptp->txts_req[cons];
> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
> +                       dev_kfree_skb_any(txts_req->tx_skb);
> +               cons =3D NEXT_TXTS(cons);

I think we can remove the similar code we have in bnxt_ptp_clear().
We should always go through this path before bnxt_ptp_clear().

Thanks for the patch.

--0000000000001780ce0632e844c3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEID5sRLBkqZs0tP6Zza6svp4dFiZNXoLI
8KXLIbNl/fTpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQx
NjE3MDMzNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAJ2KK85arxpzIh2nSLKMkqDV/eZ7lgZX2EUsI5bsVLZxVH6bqSA2V78YulXVZdT9xVWE
sQ7dCoM1EAphPV62u/hqKnFfMynn3HNelIwJxFqPvKGGFEGtXQF78ibKjWUNyijklh43OAn2fLmj
2f1Qf8jGZ7aXyoGwPy9dRyUXx6/qVZWHfeNU02UGE4ASPynV/dQR60uALjrSU+Jry8zN6k/Y4lUU
C9VIOi3A4DLJs0/ohlyQ/AvOSaRXO2DeoPu5nLEjD79XxK588w3oygGRV2U3IHvnBVifBDtYznBM
FS6I/kU61dKQsHH2WsUCGatPbA28oydNLkj8BNrO8k8xZ+8=
--0000000000001780ce0632e844c3--

