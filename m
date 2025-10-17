Return-Path: <netdev+bounces-230289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E4BE63B1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D6F19A435F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 03:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB32EB854;
	Fri, 17 Oct 2025 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z2qnHhsC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDE2EACE0
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672720; cv=none; b=f4IGcucjeL9vHjO7lIyBieK9tf/cR2SDSiGzoQebFEfvbYmEOqOZR18R44o++3ZnTmPtn7a2zUB6E8LM7697c2KIFDNEoZj2RN6dOVKHgubpWfa6/of8dmkjspOBJSRL58ae+wSf7F6hjytTD/dW2VkZocwBPWO9qbqGglQOVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672720; c=relaxed/simple;
	bh=xPScBEo79fjtnbzghX8e/yfGl38EuoQdluRg+1rJxmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3+wFtN2mlSTzh3IA8MdKf4y3HU4u0kHJKixecwG/G6QIe7+7VDvOGxm9JKvSOaHNE9xp4AI91F8+jn0Kna3WDK+8pdglxeZxxXnS7OOWq9hS37yx7lcnuSdA0cdARH1+35raZmAI/jIY49sIrgGZ2i7qXsz17RvenmlhYgo3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z2qnHhsC; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-4242bb22132so13113815ab.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672718; x=1761277518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bNrH0bUqETFjA0tABt+WMMp8ULfp+El37KqFBPxGk5Q=;
        b=xPgj8rBSKNftKqWtaeeb80aG51jFwo5TCPSrrh3ccEE0SCvhNlGRSA4gOTjyBPf8VK
         5zSLDZrtDgvCe4WvxrU9z4xYfwNJSmIg2l29Zns+atwnKmS5EV0D8vmIzVXMr8k+L2HE
         T4xQmmX/BmmX/n+dSK5SPuxY6N3Wd4UeWn2oVBWYxb/1A+ryQB4cGM5eIWupc0zXuBvD
         1xws/WhljWumMOrSfgBvpKZSpzL+idhem3BWIO8KE95KFCtzugnqyNb5xS7KBMW4LG82
         Psqk7huLZqS963nnVRQMy1IgluXIQhSSR1Pb2c1VSN97ZQIetich/BF4/sPt1slrltoj
         dsNA==
X-Forwarded-Encrypted: i=1; AJvYcCU46uArJKf2u+Gx7zI9nI6INEbZHKwjzOi0Fp4VNxhxN8G2dCHRrgyLmRcUbfk6ZYMlytS18DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgiFVAMfSt7qjhKYtHuu0J5FL9oy/6q0T1bTsOMv9O3ZuTjgK
	MXSWhp6ug5Mi+7Eu5dV4Of6k2rbLEKDkfPLMnWJlGzaJK7NaxLUEBXPS237H8FUBot5RIfNFxz4
	ORPrfmYuFR7uGZiqXYoEfZ7X8PQqJUh52CFeEvshlFY/SAjEYtC25L+qKw0IlQuAz7wtxTTELHR
	UpwJAy26UBQswL9g/fdqmWElueOc5mDf/dC7NE4qmAlkp1lmMvK/6LWCEBNvrZ4NGrHR4PzRd70
	j9C1/EkRHpaZQ==
X-Gm-Gg: ASbGncuzcvjUKYJx0VkP+aS7vRsWbyK5tLJfvIl5YMfHP4nrM7xNIlHkqzVxy6cwJI4
	uNGhJ77WR++/gYbB73smSruoBbTyJ2cI4VXrfJzzTytSi66nEkYoDf8fpPnWW5v1wQtsFxphv9w
	EAL2jv+fH5eTG88Un6/lqoWvnwg0QEauUInfKV/gavH/n6ZveKKfaIyKLCfme7VXR00sxGTXyu9
	EmVH3RGOEpsHt8E7vTehftlyS7zhkngzHzP87LBbTvYRrBalBsqKKiH87m8Nz2eQXY26mlqcRoS
	8jTdJKQuRo+BApZfTqiTvS+5jMntAn/DkehQObj/XrM18EHABimY7JjDMgjiBxbW5owNr3zxE3B
	ePGgCqL5hE4aYSjhHU+kaU57J5cSVMEVAS3Wk+RwCFtCCqP3RrLpwJV8Y9TSZijZtaHnkMu2Zv6
	lPJmTk8J4NF4kLgIZ1bLZnMshsMvQZRTcf+Tiz
X-Google-Smtp-Source: AGHT+IFrsQZ6cwEy75URP5dCY0YWn76Fey840VeZBrjs1jNwFdV5sHf1Mc8yT4k/8zLajp9d0P6HMa4c8LT9
X-Received: by 2002:a05:6e02:b49:b0:42f:91aa:50df with SMTP id e9e14a558f8ab-430c529230dmr38744825ab.30.1760672717938;
        Thu, 16 Oct 2025 20:45:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5a76f599f37sm117361173.19.2025.10.16.20.45.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Oct 2025 20:45:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269880a7bd9so19072145ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760672716; x=1761277516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNrH0bUqETFjA0tABt+WMMp8ULfp+El37KqFBPxGk5Q=;
        b=Z2qnHhsC1d8cLhoEF4L1JiWGk52Wf0AA3yh1F0cOWS/4gclXEN9uEou8cYpMNQ5cvW
         tpswPtenjIOYkqsEVOASjWJj1ieKWARy856A7he9TmeFdDoyJS6L0R0gB3Rt6xz26miw
         /IlqNVQQpfGubLkCIW192vQgPzJMjg6WzegKs=
X-Forwarded-Encrypted: i=1; AJvYcCUJyL53dG6e966ASwWQUCvsaA08SK41p/5axZLLGHC/Ai2JwWo1TkAn8SW/eKFHVXqXun95vGc=@vger.kernel.org
X-Received: by 2002:a17:902:e88e:b0:248:ff5a:b768 with SMTP id d9443c01a7336-290c9cf35ccmr20163085ad.10.1760672716459;
        Thu, 16 Oct 2025 20:45:16 -0700 (PDT)
X-Received: by 2002:a17:902:e88e:b0:248:ff5a:b768 with SMTP id
 d9443c01a7336-290c9cf35ccmr20162915ad.10.1760672716123; Thu, 16 Oct 2025
 20:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 17 Oct 2025 09:15:06 +0530
X-Gm-Features: AS18NWDfEyWeO0_xWd77X-ufrZAjusTj0LmYVeMyeNNsZ6m_ZaDF76NwqQLGCzY
Message-ID: <CALs4sv2gcHTpGRhZOPQqd+JrNnL05xLFYWB3uaznNbcGt=x03A@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: support PPS in/out on all pins
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d9a26c0641528faa"

--000000000000d9a26c0641528faa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 3:54=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> n_ext_ts and n_per_out from ptp_clock_caps are checked as a max number
> of pins rather than max number of active pins.

I am not 100pc sure. How is n_pins going to be different then?
https://elixir.bootlin.com/linux/v6.17/source/include/linux/ptp_clock_kerne=
l.h#L69

>
> supported_extts_flags and supported_perout_flags have to be added as
> well to make the driver complaint with the latest API.
>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index db81cf6d5289..c9b7df669415 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -965,10 +965,12 @@ static int bnxt_ptp_pps_init(struct bnxt *bp)
>         hwrm_req_drop(bp, req);
>
>         /* Only 1 each of ext_ts and per_out pins is available in HW */
> -       ptp_info->n_ext_ts =3D 1;
> -       ptp_info->n_per_out =3D 1;
> +       ptp_info->n_ext_ts =3D pps_info->num_pins;
> +       ptp_info->n_per_out =3D pps_info->num_pins;
>         ptp_info->pps =3D 1;
>         ptp_info->verify =3D bnxt_ptp_verify;
> +       ptp_info->supported_extts_flags =3D PTP_RISING_EDGE | PTP_STRICT_=
FLAGS;
> +       ptp_info->supported_perout_flags =3D PTP_PEROUT_DUTY_CYCLE;
>
>         return 0;
>  }
> --
> 2.47.3
>

--000000000000d9a26c0641528faa
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAoOp7r
7YEgs+wbdd5cR8+yvBtvQSjrGa8iKmPmVAw3nzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTcwMzQ1MTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBG+o2asiVDmTNpfsoalXAGv+5UzmzafTie0x4cXZHy
pFGZwVP9Bbqb56mB61QVmh/hRTXQ4ei6sck3+4RXeiIm2YQwU9h5bubA5VrG0HmPzrRxzXhbO8+B
wcxk22u8w2w3WVWycMowUX2pgFEnZpXGfw3KfkuR28FwKhVZCiVQJF78v7z2tYwV1KjjNlAuY5ho
Si9AnscvyxmizmggLoRynXT561+gsN/LugJrCFaep9bBB5VpsqcfaN5eyjhFlg0NvQdFwT8jZAlg
SSCcVLMexpbO8vv2UBRvM1hhb7Ux9/i8ra3OXg6GmUcN1e4LBn3MAyA/wV9aw/QQev+dtENs
--000000000000d9a26c0641528faa--

