Return-Path: <netdev+bounces-157582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C9AA0AEA9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 987357A36F6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2022F230D09;
	Mon, 13 Jan 2025 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QhV8J9Qw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7713C1F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745292; cv=none; b=HLFGh/gdtJIOEz5HyDz6oytc7IYvs/IY6yvmcIr5Y2FyRz754avEtHHvuXI0qWPpQhS/1kjdFNHUSDMGjYXUatLhdT8wu9vhE98+QFENxrxyyFnm39s+UqDkcZGz/b8+kZPJ+6RvRxHfhd6OrUGsis50xq+p+4nvr4T4NV+g7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745292; c=relaxed/simple;
	bh=XXD+e0X4pPIFXHErIte6RAI78mSu9GArqqZPOWPHdiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kfhr6YnigjpF7Su5ACJx+nCnVGtK0i10s9lqge9pxP/OCe3fs9AS+XFv0WmaySsu3X3G2TEhW3YygC7FsFAP7PVNyuAQgveREJgZ2+Ptm1lNhHYVIZnlRjkdzBCCgrNRKYd5h54PkmGxCSp8y3Cg9RUJ3BXsfVPVSut1NRm+j40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QhV8J9Qw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso5294293a91.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 21:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736745290; x=1737350090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ne8Au6Y087TyITaG5i1cUWumOGI+JT9oxlVH9DNStmo=;
        b=QhV8J9QwuXJ0tcdNWAYUGqF4sCQOFNVRyFo/aXA/lfUvAywdeQ1K9c8jHFwt1zg82/
         iyP8wLJRE9he6hd37tVz4HkgkqjvRtFyGohC4CxOHHiYZV88XJjVo+fFwHTikFLb9zYp
         gX0HjuG6XDNpy83P3PM779VdDLQSAct0nDBkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745290; x=1737350090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ne8Au6Y087TyITaG5i1cUWumOGI+JT9oxlVH9DNStmo=;
        b=k5A8847BSsNif3Ie2NxccblLwPXdUdPjeHhEuwCm6lBkxlBfrniZW43teB5xaeuyYM
         0CiOJGvTLBdiAjncShsW+NkPgmUzSJduMIj39X/5BdCQ7+7EW6Hxl6DU7RkEnN8m5wzZ
         OtxrF6hjo+w/UDewTOVNwKpcu/qCPwM2Qs2NSTV+pvBppVy/Y1WU8mJsO9r74SF9Zz+Y
         akGh83iQiDygaznftqsK38qNII1M536qWaKTPusYbJCvp2n5mNym7Yf2qUowTx2dHmU4
         CIeLbZXn6jbCNRFhJ7au6hAI/KxcwH2su23pi6i5eivSfiSI9JDpLEwO7xg3WcxmBq+u
         R07Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhUpR0Sa0GI0GghTIjv1kbC9RU12hWwkB4g/KKnerLuXaRTzk2YRr/3CtUCZ0M3m2Izyf/Dmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojshMJGkIrhmTkRbZXVgk3Kn3IsqjQZVDegx8FLTWWUGu7Juq
	rs8IanIJqxSoBibXZ2UWy3n4WGMYc7VVU8HYOcix4ELF7eUkNjNLQMDDbUk0ylcyLBHknUykFX+
	UYB/zxZUrC4WdwmOwdkDDV4zU6EsMEhpqRygs
X-Gm-Gg: ASbGncvf5xAk4/fbLb9WGRMAOwq0+BGzl5N4/qmucvRjmUsQvs+l2ZLSwCLV/KyIRV4
	EgVfPc4WJ1+QGHYiKUbpcLlRlaFtClfmkpJYYNEQ=
X-Google-Smtp-Source: AGHT+IHIiuXHIEZ6bXDJ4vGL364/S0FLENY4s+KzjElAnjiFMVBlQ6uuMeNXHjJu5t1g8Hrskdc5ZhwomrxDQVjMp7Y=
X-Received: by 2002:a17:90a:d00c:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f548f1d783mr27966143a91.29.1736745289902; Sun, 12 Jan 2025
 21:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111065955.3698801-1-kuba@kernel.org>
In-Reply-To: <20250111065955.3698801-1-kuba@kernel.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 13 Jan 2025 10:44:37 +0530
X-Gm-Features: AbW1kvYvhjEP-vtm1h27M4OWDk-Q9Ikr0YSER_3cjPQXZg9YczMA1kM2zMkSSuI
Message-ID: <CAH-L+nNX-3ervNe-P-a+CA8=nuYkt88QfRbpXsTtpvgXqqzZtA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: un-export init_dummy_netdev()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000015f1a8062b8f8696"

--00000000000015f1a8062b8f8696
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 12:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> There are no in-tree module callers of init_dummy_netdev(), AFAICT.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1a90ed8cc6cc..23e7f6a3925b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10782,7 +10782,6 @@ void init_dummy_netdev(struct net_device *dev)
>         memset(dev, 0, sizeof(struct net_device));
>         init_dummy_netdev_core(dev);
>  }
> -EXPORT_SYMBOL_GPL(init_dummy_netdev);
>
>  /**
>   *     register_netdev - register a network device
> --
> 2.47.1
>
>
I can see that "net/xfrm/xfrm_input.c" and "net/mptcp/protocol.c" are
invoking init_dummy_netdev() in the init routines.

--=20
Regards,
Kalesh AP

--00000000000015f1a8062b8f8696
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIIya+Uff9gtjRYa8Fvmx5sR63f+cKIKJJDcJTHqYjQUNMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDExMzA1MTQ1MFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAyaGDTJ1D2
MwHkkSvE6ORO7qghabV9GTheNKpIiEYcuS887dAZmbJRGhQsTKOBg+dHX5sa1/LBwUiLq3ppVG59
IwCnmis7c2MrvnmtCzFxONt4gHYxoQRDX80/DdLqJh89cXEXYKQXml0npKFNIZa9jz7t57CrFkLa
e1Q51j5EtoirGDermoWEELEH/1PGHcdbd9B85dGmubpWA/R70iZdRraWOnetT9T0tp1cGvyDGuUQ
ZaRlC0D8NTT+Xr9bxReZfrXwGVlhu6LJz2Jz7g+TEFLDeNf89OkviqccRq8PEO2Eln20Za1cFVVF
glXwgZBt60jHasUWLCTS26TKc5Jk
--00000000000015f1a8062b8f8696--

