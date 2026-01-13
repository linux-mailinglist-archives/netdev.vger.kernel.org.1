Return-Path: <netdev+bounces-249334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D7CD16D64
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E52306327E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11836920D;
	Tue, 13 Jan 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DyGztIb9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81132862D
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285441; cv=none; b=YUU+Ez4IGHkTA2Z7asrWe/my0DYKIPc/F3PtVNR+3RB10yw1h5+T7rnn/MPr0pyeSojTMOMiql4HlkHi162V018p6NoN0Veob2iYjl6fB8BqfBR2CZ1Y+N3cmZMeBnADcWYhlRlGBaDVTYPsMy9TL16zvM9GYbLGndiWrGltFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285441; c=relaxed/simple;
	bh=x3KYNRs0iKU3AkgFF81LvchJyKlkkcAHbZNJgTG+t4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rql2CKXxocp5KJW39HLHUZ001OSft/86S4EL2SAUV0R9caYLfetLNwqD37tXKx8OI/Kz8EzTsQHSs5roxdIMYhxThzrxXlnmk0ExbGoUjuWgCZ4tOCM7Ivt2uvnWmOeJWBbGVHBtSvocwd54eZV+Kh/0FcFx/Hcj08Pu1giAmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DyGztIb9; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-78fc4425b6bso71231157b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 22:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285439; x=1768890239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3psj9pSAsxVTK8ciXM73PnGjKwKxuGHBK/Az5zYNqIM=;
        b=Z48ZtQWAcHzkQgGnUlMXKJP65Lb8213RxL7a+0PGJR2kbUgtswx6/0Cb52RUk4vipq
         cXuuvkR2lw8SLtFM4tyBmF0D4SPxlkYly+C/Op+YKqO+AwoDS+9Ek37hs/ijH0xnVQbh
         mHwIbNkfUkdPaqWElUsWjWLfBLNRtueezNUwlYFkzGsWTMsOVCZrC35Vi9iJ1ymT+su+
         9Oy3iSh6PonVvsQdqp4vSfQwtTna0oVdE/ov98KQsaDN4bPbJYEj8ENtw152Mice7sQ3
         Vo5IMY7TR2b9j/7mk3OP2E0kt5VfKw5DQAfrRWaNkHv+z7TmgfK7zJHtfuJvnJxdodgu
         JWSA==
X-Forwarded-Encrypted: i=1; AJvYcCXl9LrfCi6Zs8qd4FGbyGYgGdg9ohSfCWkJAqcNLQ3ZpquHCleaEdWp9eu78yNQI04jZ3wRpRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1RYHy8UtScwvYs62Sa7yL+oQgL2eGA5aHOeQZFoVGBTU2o5e
	SF+fDFEsJ/8YNzmuJPHCI9F1TMjWmCYu2VR6LKkwq4+oHU4dKc0jaWAqqwZMzLY67ACIRj1+H6T
	NEuUOFN5Jh4Nu9yBGKQlaBsSaLwvt0s7zF4DozgItXh7m0zYyNR9IvbuWHjni9v98VqCWuNAOq4
	sxVIg8ILUyjIc9x8t280xe6LQRVOpQjN/9YsubLwMPKHIsvOsj2V5h6X3U2gHAA1dxLk/X1dO0D
	wkUvIc4F28=
X-Gm-Gg: AY/fxX5NXK3uDBsA0foKip0cSjn++/3DgZaNT/5HKV7X2yWQI+UhLRlUqBcxim1ygtp
	0D1HhR4r1wbCuuziSSJuFXo9/23T5CDSfBZR/L8ULznYBcyvdD/iddNcJ7iXuiHQ8V8HOG0hl/i
	4Gt9fsP86n88MbJMTIy9CSMmD6aisRMQ0QBft6ik53W9zwq4lSyY8SK/NVcKdU7n3GbDAbRqc+7
	6trj6eKtuXjObJ5Bzr/yxFnI8HrsliJ9ycsFKokAAj3sTaLfJyNXQSo5wGZRv9sntUNNtExj9WL
	RG/8uOMfkKawzjHkHbbb7ww4bT7G18j864I6dDXL6WBtqPOZopvLnvh8xKMUBAOMKaki6MUbhhX
	EIp73Y7NLsaKfAeglSoIztIq98uyifuleOp/ZNw4AnO+hoVozpax9/z4bQyK9oq/gICe+/kSTI8
	FaZKA4VbSFmJXIX3jfNUqU1xNndSiQkXIvlhyUnt/WW/zut/c=
X-Google-Smtp-Source: AGHT+IGgTECCVmz8pnv0bjc3LkdzfRqYjU68/GwRV4YvPF1E0hzltjgruYrRXBT5NyDGQ1tNFe0ImGLgP8as
X-Received: by 2002:a05:690e:b8e:b0:644:79c0:4880 with SMTP id 956f58d0204a3-64716d0967amr13522021d50.95.1768285438953;
        Mon, 12 Jan 2026 22:23:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa584803sm15290047b3.9.2026.01.12.22.23.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:23:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0c495fc7aso77068575ad.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 22:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768285438; x=1768890238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3psj9pSAsxVTK8ciXM73PnGjKwKxuGHBK/Az5zYNqIM=;
        b=DyGztIb9woJnwjfu/Q6mS2KvvK2JTy4k8hND6hsV9gAho93iHqUDfAmv1I0nJj0Q0C
         ZKDYLEF0CnVPKmu3tWEIkZZgmI7BrtVvCEmWja2cKt4OkTOynfxxVhJ8pXHXKNvBmj99
         4oBimxiXAu4qeD/k8QyAYN9PIKCSDwsDmgU2Y=
X-Forwarded-Encrypted: i=1; AJvYcCU8FflyUSWjYkrNhf71xBXsnSy6JkwJc1Ibgqvl6tIk4nXypWvi1MXR9haklMN01aojTSaIxpg=@vger.kernel.org
X-Received: by 2002:a17:902:ea09:b0:295:738f:73fe with SMTP id d9443c01a7336-2a3ee4ab6a2mr205354135ad.30.1768285437759;
        Mon, 12 Jan 2026 22:23:57 -0800 (PST)
X-Received: by 2002:a17:902:ea09:b0:295:738f:73fe with SMTP id
 d9443c01a7336-2a3ee4ab6a2mr205353965ad.30.1768285437391; Mon, 12 Jan 2026
 22:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113171633.1536cc74@canb.auug.org.au>
In-Reply-To: <20260113171633.1536cc74@canb.auug.org.au>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 13 Jan 2026 11:53:44 +0530
X-Gm-Features: AZwV_QgmwfjK96KfYE_odaRjQ1Bs7BfmEzG6xtHf9WOJoiSWLFAJDWxrksbRLv0
Message-ID: <CALs4sv1vBg-QCcAW-mnu5zCmghPN-Ok_V-JV5G6nPV9StJ=6Gg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Michael Chan <michael.chan@broadcom.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000065741006483f093e"

--00000000000065741006483f093e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:46=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (powerpc
> allyesconfig) failed like this:

Thanks for the report. Yes, kernel test robot also reported it. We
will send a patch fixing it ASAP.

>
> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: In function 'bnxt_ptp_init=
':
> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1141:13: error: implicit de=
claration of function 'boot_cpu_has'; did you mean 'boot_cpu_init'? [-Wimpl=
icit-function-declaration]
>  1141 |             boot_cpu_has(X86_FEATURE_ART))
>       |             ^~~~~~~~~~~~
>       |             boot_cpu_init
> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1141:26: error: 'X86_FEATUR=
E_ART' undeclared (first use in this function); did you mean 'X86_FEATURE_A=
NY'?
>  1141 |             boot_cpu_has(X86_FEATURE_ART))
>       |                          ^~~~~~~~~~~~~~~
>       |                          X86_FEATURE_ANY
> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1141:26: note: each undecla=
red identifier is reported only once for each function it appears in
>
> Caused by commit
>
>   c470195b989f ("bnxt_en: Add PTP .getcrosststamp() interface to get devi=
ce/host times")
>
> boot_cpu_has() only exists for X86 ...
>
> I have applied the folloring hack for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 13 Jan 2026 16:51:58 +1100
> Subject: [PATCH] fix up for "bnxt_en: Add PTP .getcrosststamp() interface=
 to
>  get device/host times"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index 75ad385f5f79..20f5a9f38fee 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -882,6 +882,7 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi=
 *bnapi,
>         }
>  }
>
> +#ifdef X86_FEATURE_ART
>  static int bnxt_phc_get_syncdevicetime(ktime_t *device,
>                                        struct system_counterval_t *system=
,
>                                        void *ctx)
> @@ -924,6 +925,7 @@ static int bnxt_ptp_getcrosststamp(struct ptp_clock_i=
nfo *ptp_info,
>         return get_device_system_crosststamp(bnxt_phc_get_syncdevicetime,
>                                              ptp, NULL, xtstamp);
>  }
> +#endif
>
>  static const struct ptp_clock_info bnxt_ptp_caps =3D {
>         .owner          =3D THIS_MODULE,
> @@ -1137,9 +1139,11 @@ int bnxt_ptp_init(struct bnxt *bp)
>                 if (bnxt_ptp_pps_init(bp))
>                         netdev_err(bp->dev, "1pps not initialized, contin=
uing without 1pps support\n");
>         }
> +#ifdef X86_FEATURE_ART
>         if ((bp->fw_cap & BNXT_FW_CAP_PTP_PTM) && pcie_ptm_enabled(bp->pd=
ev) &&
>             boot_cpu_has(X86_FEATURE_ART))
>                 ptp->ptp_info.getcrosststamp =3D bnxt_ptp_getcrosststamp;
> +#endif
>
>         ptp->ptp_clock =3D ptp_clock_register(&ptp->ptp_info, &bp->pdev->=
dev);
>         if (IS_ERR(ptp->ptp_clock)) {
> --
> 2.52.0
>
>
>
> --
> Cheers,
> Stephen Rothwell

--00000000000065741006483f093e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAfwqIw
LfaW0fleOg5kusiThuxG6bPLB5/jXBmxEYxyXzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMTMwNjIzNThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCY2c6C/9PoaBIxqMfurdjIWaT2ugzP0muhp5HXkzWo
Sczc2E2r8D2/16aI6VEkzSnjSZAk6eFAzanhi1g1uhoYwme6+MNeuGv58kN1dCmtGOLZbhnYBoU1
kMeTFVKiVJAC/sdmWWoS8dThll5W2+j3fBI457FF1s2xtzf/7WBiHt6X+Qm6/NePcv0f/Z7FUROE
lMJJbXNInu3G1CNSR9KoKpCyANN4Qd81HE/oK6k2oy+Sx066YHZaBQ0LGEirjFSEYxKqdQ0iNtmk
+mc3Pwo69WfyhYQCNb0dZbUksvnZA92hfIUCANx8LeKAl2xOCtw54pBE90lRWqwmWSx7VYsD
--00000000000065741006483f093e--

