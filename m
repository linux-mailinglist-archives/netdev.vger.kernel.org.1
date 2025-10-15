Return-Path: <netdev+bounces-229453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E40BDC6F8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAD3B4E9AE3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789328D8DA;
	Wed, 15 Oct 2025 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G2fJVwM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987181F790F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501740; cv=none; b=mGJddE3Su7UbzpqDvGdeWUfTyZXA0fBxy/+kUoqosQmXS3qU5nYn9epxi5HVuPSql2uttDqgUxCIcOSwgEglYOESFfGepOuaQ1+IuPCGy+zOQhUTXmGWGqBUaqTW1sIERcdpF9hxqrqPTsTSJAdLvQwKqr3DiYgsD1McUTfDxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501740; c=relaxed/simple;
	bh=9oCcANBXRXfsyaIFn1rD0tGPnkCV9/NhavzGWzFi5e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnppNXEryewcGo5cv/dnkkwXG4hexWzGf0LIxWl3rpjSk+cV5kz+8PSGerXLbMpQuDwCnB8HZTCZrQblNlne33abdIH/4WpFcb7FoaAvFFkkimnk/5y6SQOmm5J93fbOc1Tx+6z4EMxaVjBKhqPOErzwruGq0Bjq7Qr97VetnHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G2fJVwM9; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-78f58f4230cso70565656d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 21:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501737; x=1761106537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n6dzSgauvw3UGw67iV5uc/nB3Zr+db+YYBsDqOMku7w=;
        b=t+3/eq0DH/K3mZuqpkjtH2+dtdsTdG3uRPJIXCaSJeIwev9M+huwCtTkg56GULd5Lh
         9heYc+yHm+0uX3fUgi4NZo6WEewxE6vs1LpKsOKA4aqJauuxdH9jkMpopac/9kkBFgW2
         1jyYezPwF2YxIHhauHkVGExXPfy7JgpgGLljzdmMG0ClJIsVAaSvo53lDa4I1xOwNesX
         GYKTJIE51PhwLsXzv7oOvv5ddnxr5YKi01YRJ1OlXYvseSTYRWqpwaxh0unuuNf0XTo0
         pKQNEYoxsg7roR3DLbTpOob7Ndn7pcHlm3iSnXV08cF1THXy//lU1nWwkHYDoQlvKjhZ
         7uNw==
X-Forwarded-Encrypted: i=1; AJvYcCXvXhgECGCD8LfPXlQvJUI0WJWQ6HApdAI5Rs18DVNlPPzYZV2nbpH8vn5RtFbJ3WRwAlAa3c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHD/O7bZTE460vdhJWKGl03mjcpvUAVBU7j84X1MnpVrcrb389
	PK+USgoit9V5nf1FvBsMZrhAFZaYWaXW2oDh8hyRHgoTMa8nGaXfqZX66yJEDx2cHOxGvpb/UMd
	+XX7WS8gv1sCl6ubaXwgNZ/l7el1HiwgD/38+D/nEQm61j9P6B2TAr8CdnX0MqR9D9lRWrz0bz+
	HcNTf4Ou7Qsa5THrsvk+1emxJJkBTYnK3hdKYWWn95O6cxxqbVNlTVKxc1Hk4G1jPhFahpM2ugS
	EC5+4Tltrg=
X-Gm-Gg: ASbGncudvO1cnzJbO1PQOoIT9MsNdTwd1C7BpSlKSeaXeqUICStWtRsWguqyEjDfSgy
	P6YU8FbHximfPz7o9RfF2Epyka0N6ru1fJA/ftecI8+UyCI797qWuDqqh9sDI2P7XjHAXyWsBaW
	dnz2dx1M1V2Tr6qC6LaVaTK6VdMB3jpDieZ5JNiJWZb98mLvakzAkARpJt942tLZ5HDW5KH4DFa
	peHbm3H3cWEIL4RK71peOX20XTE377DypTzJtUvue4x1Juv01vgl6CrWulz2bOy/fimeYiCQnVd
	TbUATx756M1LrzPu9LCtkeWHV7JLKIRSSdBWTAWGR0A3SNP16QpDyQO9jR5la++fFlaKLoJ2ePj
	LKnLJTgUrKf5YOgfzGefH1wPTGOKRYXR9en+2s0x35luUY9KjNinrv/aMYC2eF3JlAXd8Lb2p0G
	xnLA==
X-Google-Smtp-Source: AGHT+IFhAhRXERUREsGCJYORSxLnSxLmQcdr8F0mnPwh80E5+Fmi4ntCKgFZ3LthM95T5R2gypU99UdwmOIw
X-Received: by 2002:a05:6214:301a:b0:879:e817:ba65 with SMTP id 6a1803df08f44-87b2efe822dmr355139386d6.56.1760501737133;
        Tue, 14 Oct 2025 21:15:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87c01288e1asm1392046d6.17.2025.10.14.21.15.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 21:15:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so9476969a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 21:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760501736; x=1761106536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n6dzSgauvw3UGw67iV5uc/nB3Zr+db+YYBsDqOMku7w=;
        b=G2fJVwM9G43DwBRVNqPNjbIH6MVtDgVqi4aCjELbTWOoO2YmXpADPGRpuIxh0C9DFv
         +VPTpbos0VKOgMLLeLuqYTtl83VDzPOMYWJVxzb0AFvgxmEyL6A3vbSwQ4eyR2tMOH2K
         +Md0YTMi/gsTHqsy1SWYySjIkhJNK8ddX+e8o=
X-Forwarded-Encrypted: i=1; AJvYcCW9uxbvorML1ZR1xuNTvxeLrv+WJXR8K54dXZw8A47JBPLwVBhhjNC4nEsMIEZiF9+6ytwFCTc=@vger.kernel.org
X-Received: by 2002:a17:903:3c68:b0:246:80b1:8c87 with SMTP id d9443c01a7336-290272dfb4fmr334680565ad.43.1760501735652;
        Tue, 14 Oct 2025 21:15:35 -0700 (PDT)
X-Received: by 2002:a17:903:3c68:b0:246:80b1:8c87 with SMTP id
 d9443c01a7336-290272dfb4fmr334680225ad.43.1760501735239; Tue, 14 Oct 2025
 21:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014164736.5890-1-bigalex934@gmail.com>
In-Reply-To: <20251014164736.5890-1-bigalex934@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 15 Oct 2025 09:45:23 +0530
X-Gm-Features: AS18NWAV5Vn9RHYJmX-BnhpIC6ONHWP2lvrrRC0RFSN8dykniWsKO-sQEdwee00
Message-ID: <CALs4sv0KUtxAK2vPh5rOsPG5xpBv3tG979V2KL+ncKh7KYsy1g@mail.gmail.com>
Subject: Re: [PATCH net v2] tg3: prevent use of uninitialized remote_adv and
 local_adv variables
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nithin Nayak Sujir <nsujir@broadcom.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Alexandr Sapozhnikov <alsp705@gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009ae4ca06412ac030"

--0000000000009ae4ca06412ac030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:18=E2=80=AFPM Alexey Simakov <bigalex934@gmail.c=
om> wrote:
>
> Some execution paths that jump to the fiber_setup_done label
> could leave the remote_adv and local_adv variables uninitialized
> and then use it.
>
> Initialize this variables at the point of definition to avoid this.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 85730a631f0c ("tg3: Add SGMII phy support for 5719/5718 serdes")
> Co-developed-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> ---
>
> v2 - remove bogus lines with initialization of variables in function,
> since its initialized at definition point now.
>
> link to v1: https://lore.kernel.org/netdev/20251002091224.11-1-alsp705@gm=
ail.com/
>
>  drivers/net/ethernet/broadcom/tg3.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 7f00ec7fd7b9..d78cafdb2094 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -5803,7 +5803,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, =
bool force_reset)
>         u32 current_speed =3D SPEED_UNKNOWN;
>         u8 current_duplex =3D DUPLEX_UNKNOWN;
>         bool current_link_up =3D false;
> -       u32 local_adv, remote_adv, sgsr;
> +       u32 local_adv =3D 0, remote_adv =3D 0, sgsr;
>
>         if ((tg3_asic_rev(tp) =3D=3D ASIC_REV_5719 ||
>              tg3_asic_rev(tp) =3D=3D ASIC_REV_5720) &&
> @@ -5944,9 +5944,6 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, =
bool force_reset)
>                 else
>                         current_duplex =3D DUPLEX_HALF;
>
> -               local_adv =3D 0;
> -               remote_adv =3D 0;
> -
>                 if (bmcr & BMCR_ANENABLE) {
>                         u32 common;
>
> --
> 2.34.1

--0000000000009ae4ca06412ac030
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBGmVJN
HDKbgCv9R+VKgZ74lo47kA/sJb3X69dNckT/HDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTUwNDE1MzZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC6UVvhd57urxDnl8mm/JSZnQyi22XdQ5g5L8EQpJaL
SKRhno3EKBJN8xMfAOCCCsgLoJ1PaR8fKgKnn/reZyQ2NtfSQU8hrJNt8ObfUdJEeJBca+OJk5lA
p33Hllx6L3cN/uj614SWlTH9SFbnoyZW0lOI37aOi+Heq07z6ycmGVX1zKKjiz/khZBP0KJ0J/A1
27N7JsuQBvBjBkrIcx0fJaBPFA4KbnMrOGbRx8UWpLaOS3AZcIf/Qxp9kGj96U2zsvNwserHrIuO
zq7BERxx3GBrlYpsmvfyG2DlQrGJ2vZTYseIW6QkigWkIy8x+mzfWgpBYJCLk1w0ZwxRmZHn
--0000000000009ae4ca06412ac030--

