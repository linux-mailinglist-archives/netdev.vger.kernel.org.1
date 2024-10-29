Return-Path: <netdev+bounces-140108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234B9B53C1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0201F216E4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E93192B74;
	Tue, 29 Oct 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BvRJo+xH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74F192B63
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234064; cv=none; b=TcMG6K6ZJc63qp1fpNPwREGByVRUzQaR0a+t2mUANu3RfCK6U2CavYmkyTuykw7NY/HWMEGN8D5l6T+dD1kP0UUb1+kqEjApZgpBCozlecTtFZEGZ2VqhDWZax1N5tkOXQw1aWVDTqqyeQ6+GJtZ02G3ATAp8zaxQ+nOFHHP7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234064; c=relaxed/simple;
	bh=ycXWQOPuXSXNUZhPB0W7YiCumGKQV2gK4Q2KIkO1KO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+TTB9WL0QBdGGHMh9GVtLYOzWz8dJGN0FSdmoU42m+uHCKODXYSkTYmesDvWuyOjMHWOTmX3Nz7vR2Xb43BXQrALkzQvETx1mYkK12jPYVh7kkrxW5IpyieY+H5fszACPcvwYmtxAOH5w7Yr2BLYEIxU6DwzsYTYEYyIEkBoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BvRJo+xH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so388348a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730234060; x=1730838860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jy0qWhSaOZw+fbzcYd5YI4s697b6vK5qUxKgKorJvSE=;
        b=BvRJo+xH8p+95Bak3nk8PBLaWi9KNXReB0m4qp8tQLJ8UQIF59vA8yEHuDoyy0BMCX
         S7AL20+CVteeHIXzcsC1/lk754DhBVzUnKs7sMyoRAA29E9MiDjZM3SxHuwnd7KFB2fk
         AlsymMBLyyqr+Mpsjv4LFNAq2/oZIiN9rOicU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234060; x=1730838860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy0qWhSaOZw+fbzcYd5YI4s697b6vK5qUxKgKorJvSE=;
        b=AnXnk8O1UmwSV5Yi1wpwg1cFzpsTo8qv188k5LhKmAOL4riaX5khB4iwBVPlYkYMJC
         hvAIQIkUeUBT1tTHtH/WkDdg+KYyuvaKsBi1lqxZ/R/Nx62QwdMVhniHAIBHcPpoK5qO
         gHuiLfT4HAVSuxiynwBidZlMbPKQy7R5xdZQX2BscRh9vDLRuGy3SRvkVWkP5yTs8NuQ
         X/oRw7gAbaOSr77n6cDKUl2lfJtyYsToLhscBZMT4DQWBXFYRAPwd/Ug5IPJLd5NlonH
         4wxABm4d29VSfeRLWp/Hd93rt63FHrKrzAQBxnOaVqFxfT8ikuq5RPNVwgh0gMdyVUAx
         3oxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcv7t7anwuuKqL1w0dlNgoXnvlxNKHFO+9RX7E3BLk9nzfvXa3/NCsLTnT5KvdfrWVH575CdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDqR3JJw427u9NqXsqZagcz5OKTDBGIT78RHqIFdqnCpnRnxD
	RrC3bSi1Utop0TUfW8mxt1AsGZoo7jPxxqMSSg6+zXZzEYHGVDjT/Dy7c5PRZDWJoycOBpzEbXL
	swCM6qvISzeuLUKxyzSpexuJkqgV9s6KHdfwaatKq+LVFstWBEQ==
X-Google-Smtp-Source: AGHT+IFSgSggAFtnFeW6DKtGc1lhy0WQZvmkQ5hF1MIsR4F9jqQGyNB2YleSWznP7sO0VL+ZDQ0nEgXVzq/VF10tobQ=
X-Received: by 2002:a05:6402:274a:b0:5c8:bbc3:9dff with SMTP id
 4fb4d7f45d1cf-5cd2900fdfcmr3229569a12.5.1730234060247; Tue, 29 Oct 2024
 13:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028185723.4065146-1-vadfed@meta.com> <20241028185723.4065146-2-vadfed@meta.com>
In-Reply-To: <20241028185723.4065146-2-vadfed@meta.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 29 Oct 2024 13:34:08 -0700
Message-ID: <CACKFLimm96szzQd5AowWy-sQyfCKdoBCLgr5P68vOn6n0WKjWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: replace PTP spinlock with seqlock
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008f20d90625a382ff"

--0000000000008f20d90625a382ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:57=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> =
wrote:
>
> We can see high contention on ptp_lock while doing RX timestamping
> on high packet rates over several queues. Spinlock is not effecient
> to protect timecounter for RX timestamps when reads are the most
> usual operations and writes are only occasional. It's better to use
> seqlock in such cases.
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v3:
> - remove unused variable
> v2:
> - use read_excl lock to serialize reg access with FW reset
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 +++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 73 ++++++-------------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 14 +++-
>  3 files changed, 46 insertions(+), 60 deletions(-)
>

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index 820c7e83e586..5ab52f7a282d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -67,19 +67,21 @@ static int bnxt_ptp_settime(struct ptp_clock_info *pt=
p_info,
>         if (BNXT_PTP_USE_RTC(ptp->bp))
>                 return bnxt_ptp_cfg_settime(ptp->bp, ns);
>
> -       spin_lock_irqsave(&ptp->ptp_lock, flags);
> +       write_seqlock_irqsave(&ptp->ptp_lock, flags);
>         timecounter_init(&ptp->tc, &ptp->cc, ns);
> -       spin_unlock_irqrestore(&ptp->ptp_lock, flags);
> +       write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
>         return 0;
>  }
>
> -/* Caller holds ptp_lock */
>  static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp=
 *sts,
>                             u64 *ns)
>  {
>         struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
>         u32 high_before, high_now, low;
> +       unsigned long flags;
>
> +       /* We have to serialize reg access and FW reset */
> +       read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
>         if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))

I think we need read_sequnlock_excl_irqrestore() here before returning.

>                 return -EIO;
>
> @@ -93,6 +95,7 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp=
_system_timestamp *sts,
>                 low =3D readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
>                 ptp_read_system_postts(sts);
>         }
> +       read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
>         *ns =3D ((u64)high_now << 32) | low;
>
>         return 0;

--0000000000008f20d90625a382ff
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAucG9XuydvwJcw3UNjijRgPutUQyp1u
M56ZLrtjAo2HMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAy
OTIwMzQyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB1ZhyhmTvljOCKsA+1grOzKLF5xSYbQl6h7grjMtcwPXNeSeEI
gKg4LUfGP/REq/ppJDmgagr0t/HCQWU42ZUanVM2Y0A6wVJI6caDuazpAPLPP0UEDWTCng7NVPSf
zK2dDqcXEIvJHyNTPoYtCVX1qmUu89SeriutFX3FCBUe0guefzic4xAOUfP6blg35l7Gvq9VxsNw
+ciNpwfItgsepAoeha5zJeeSZ9nGkliylpL3qWkeau5/Nj5OEDUklteW5w6S7XmJoWM+/jL0Cthx
c+QXyHftDOyht5/ZX75Q6NEml1i4pcS7zF7MT/2dW3QzUVXePK/64ZTR6bHPfSnt
--0000000000008f20d90625a382ff--

