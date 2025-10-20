Return-Path: <netdev+bounces-230866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DBBF0BD8
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E0A1897BBD
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259923958C;
	Mon, 20 Oct 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y1mLdgJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C22F6921
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958519; cv=none; b=Ti9xCBd3mx11lJo4XUDcGW2/XPx8JleBZ6YLcvju8yQPjsMXVfNmLHC+PpveVb11WRCioQKu+5htH+i0Gfam6wIXdEDssa9ZoGRAhu+znT0vwOGVmIUIX1C468lWXeB/PJqAgI5XOaD/rwYHZvMfeRuIT+uUcRAnZ0fSx3MdiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958519; c=relaxed/simple;
	bh=rsTJ5m9YdKmuGzFJMdSyDzYl6qTy5VsqPSSuNh/BS+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUFsAUUK6ZA4rirg0fKOPOd3CB0lV7K47BR2JJvslgov6PY2/7pWUllMxAuRhRByZEiw/V7dJNQULebTeppDOQL1yM7yH0e5yGE3KIUmYMKcZ56Aj0lIydRR+xEmme43RKoXJTcmgniv7LrDywtYYAhNwbmJv3lZw8XRnMr/spA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y1mLdgJ/; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-87c1f61ba98so64165886d6.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958517; x=1761563317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/XtvvOv5Ci5+cJ4vjU0jFmT8vRIbwQ6vR6C/eodjmiA=;
        b=G/m2+a29d21Z8YjIXieRhXgLjuH4WqneRns+Nsol3bLE2tMZw9sXnCl+qCfqdecYMB
         usCNHvDAlY1Q4uv6WIAr3Y+cYStT5LsiyklZki+ccHgxR6f+WyBBkXo/yMt/LOhOE+Iv
         AhkMtU5mhwHGMuJoLVXxgKMLi5fPuIrBcnzhGnVAwFg4X8DJhjfjCX1RHJfxz616w3cx
         NXsnoO2Ar58AKo6M96uMuS2DDyoO5t3kcIP3GGfzbUNBO/gZ2AiQX85wFoE8LpxaHoNN
         qiPYxzmSTSwvD6gBaVsheSrSAoIPMunJZRBLosoyBAql3aBM1ZAOTuAL3YwMJwXT9cvW
         snxw==
X-Forwarded-Encrypted: i=1; AJvYcCXF2ZAIE7VrjMieifVkE5eEr6CT9ddiNWNLUEjYd6/DLrV+KJXwH8aKUIfDFUyVZASLZZOaNik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTN53JP5YfCi6FX99b4TyWA0igFDE6TA8jWnb4bDDI4rBMKyrN
	0NwFyEhcecx0TjYfmsxwcZmRmM2tOwdk7C6j1tprZgpJDBtkRcrC4r1mRtQFi5FCmkOuUzt70be
	GKSErYHSKtjUbUeODO5d1+Ll/e/Jx40NGy+h5rTcZgDG/02PoNUPDS1zfe/c3oU6t5wMeybJjcL
	CxC9XCa+KHC/gxy8njCu+pkNAYXKjck00yutoN7hQ0I9lCFgRB2lqQMorqCQzwrgUJrun8lNe7z
	U2rNQ18bXA=
X-Gm-Gg: ASbGncsMgavXsGHE/iFzIoq+vgNteAOACAxbpCUkcEHGCRdPDm1paE/wHfHEZp47DrT
	XJbfn6M4b+KRWqzoa2RvVfJcNoo5qG3D94zLqiNl4kSPy0naHrk+1IBtUJjbfH2SWclwJ5nFIdr
	AEpzH5haVqAjdchPv6+Wl7S/cxpHZJj79dl9u8Z6F4Z5wJZBgUP0iPwc2p2T+/n3l+vNfk+7dJ7
	vFCTZHirgjqbBMa5KnicQIzYP8slLhllBN3n6QD9CtaCoIok8qIqEKjgGEY2I6pt/OwJwO60veZ
	QgMw69+/lfM/zTo898q8gFP6oKilkMtGScFdn+PYdnvz9koTL/pV8oHEffrqXr5WsgdBpqLmiba
	St8ABrsSzbRxLIrcU7fg8ewVadAYdP+tCevCXNFb5OWHfNgKZDxiR1fte1rTIY0CBBaE2JbO+Cs
	jQ6tqRzMHe5MYMBtK42zgbIjPodb7TZToITw==
X-Google-Smtp-Source: AGHT+IG57zPq9AQS7x1AbQ0MIqUprL0KEoc5+nZ5u9UnAF+TvKNe9K54rY8syYj+uZjZ56LOtEBAkKoWPLiG
X-Received: by 2002:a05:6214:319a:b0:87c:2206:2e3d with SMTP id 6a1803df08f44-87c22062f05mr178209606d6.25.1760958516695;
        Mon, 20 Oct 2025 04:08:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87cf5200399sm10079636d6.16.2025.10.20.04.08.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:08:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28e538b5f23so47477925ad.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760958515; x=1761563315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/XtvvOv5Ci5+cJ4vjU0jFmT8vRIbwQ6vR6C/eodjmiA=;
        b=Y1mLdgJ/iov1JtnqaBUwEg/1qSQ736WX29xtWxHCzBPesjXuaoV2s7iQBBW2t1Yleu
         KheEGXva/czeWg/UF7Lj2JH59NHccDOSdtI4zHZURH3qmPbCblg0+3zpu1iGlahm18ev
         u5esU34zA+kG7zn2asAnKveMxIO1MuxvkF8vE=
X-Forwarded-Encrypted: i=1; AJvYcCWcl4Yy89ZIJScaB70VapjZznrQ5HoDIRtbKjHQtXu6csVi5DAyfyj8HgTgxKYmpxHk8/FBM5A=@vger.kernel.org
X-Received: by 2002:a17:903:1a4c:b0:27e:ef09:4ab6 with SMTP id d9443c01a7336-290c99ad18bmr154659625ad.0.1760958514969;
        Mon, 20 Oct 2025 04:08:34 -0700 (PDT)
X-Received: by 2002:a17:903:1a4c:b0:27e:ef09:4ab6 with SMTP id
 d9443c01a7336-290c99ad18bmr154659315ad.0.1760958514588; Mon, 20 Oct 2025
 04:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019225720.898550-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251019225720.898550-1-vadim.fedorenko@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 20 Oct 2025 16:38:22 +0530
X-Gm-Features: AS18NWDoF7jC_oIVB7sXCDO0GHTFxvnxO1ye6D1Tr_CyvCiqDyc2OpciVUzenmc
Message-ID: <CALs4sv3y8Yb+978zUrteNOwj=LP6UdjqFzdtXOL5rUfoxcSGNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] bnxt_en: support PPS in/out on all pins
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c684c20641951a7e"

--000000000000c684c20641951a7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:27=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> Add supported_extts_flags and supported_perout_flags configuration to mak=
e
> the driver complaint with the latest API.
>
> Initialize channel information to 0 to avoid confusing users, because HW
> doesn't actually care about channels.
>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index db81cf6d5289..1425a75de9a1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -952,7 +952,6 @@ static int bnxt_ptp_pps_init(struct bnxt *bp)
>                 snprintf(ptp_info->pin_config[i].name,
>                          sizeof(ptp_info->pin_config[i].name), "bnxt_pps%=
d", i);
>                 ptp_info->pin_config[i].index =3D i;
> -               ptp_info->pin_config[i].chan =3D i;
>                 if (*pin_usg =3D=3D BNXT_PPS_PIN_PPS_IN)
>                         ptp_info->pin_config[i].func =3D PTP_PF_EXTTS;
>                 else if (*pin_usg =3D=3D BNXT_PPS_PIN_PPS_OUT)
> @@ -969,6 +968,8 @@ static int bnxt_ptp_pps_init(struct bnxt *bp)
>         ptp_info->n_per_out =3D 1;
>         ptp_info->pps =3D 1;
>         ptp_info->verify =3D bnxt_ptp_verify;
> +       ptp_info->supported_extts_flags =3D PTP_RISING_EDGE | PTP_STRICT_=
FLAGS;
> +       ptp_info->supported_perout_flags =3D PTP_PEROUT_DUTY_CYCLE;
>
>         return 0;
>  }

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> --
> 2.47.3
>

--000000000000c684c20641951a7e
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCQaD3S
ATlq2vlAIPP4cn7p7jHAJuzhxK/fJuh0mVro3DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMjAxMTA4MzVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB7IgI+B48uCzjzlywg11YDdZeKZyMMctbAu3lIT7gV
wjTmE3yHeIHFaQk/07J+0K7XoCxpxtzuJ2BILMCK2jMEK1x+ZjxdfZGNUepkeqHyMREKgYnew3V3
7F1GrJu0mC8G0rmBdB45gM4E8+0ABP+WfUqqnV0oRNL0PcQ/2iYnaaYCIJx4bJv8oV8KFJB8MNd8
h4vq58ZMfXL5wA2gWe2IItaUyTwhMcvVa7F+0P/ApXYuB+F1HtKKgSse6ghp9HngFtH9Yl24U8IE
OW51SSdc6Jyom/2kc2/rhC/xJIWYwdMb8rVqnPXCn2sFH1pvUxwmIAr+K1CzWXfwvCygbHod
--000000000000c684c20641951a7e--

