Return-Path: <netdev+bounces-167195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186C6A39107
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CBB3B3AEE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EBB14B08E;
	Tue, 18 Feb 2025 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PTyOVPcw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AD13D28F
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847336; cv=none; b=JrEk260WyvpW4/AWhQsYgPAgBiZXy4OCdpU08+RqR7my7fNzWk6DeFPFVpuEY7/6pXdtE180Rjx74xPsZuduuRm2kug2T+z4d6Bwt8QiFwKBWXvtMeMCtSCguxS40a781CnZONmMZiRrk9HQGEUtAQwJ1FjZZ/bZd7zbXaP04To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847336; c=relaxed/simple;
	bh=3mmFOOnjSGJKYzYpFQLjSJIUolvxnP2YlFc0V3dUp/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZzBwVfHAaduG743pThdFdYg9jOi/BjPDkzs2TUBdK1uCjYjuSb/Orafhuqn9LPKeF3NBnIuUTdB0P2XRh7LGbtGGDHU0LhrQgcgHQ0jSWYBpc6tMrXsjn5ipACeYFhFwPwnS/1r01iDC7TCtNeR4/FE7POoA6EO+/Z4EtcIVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PTyOVPcw; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8622c3be2f4so1310986241.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739847334; x=1740452134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XiOwT67oXPnFz1Rr3IxYnTV0PUqvvnxeK11HtBQeTcE=;
        b=PTyOVPcwF/4LzxSyy0/2O5yEfF84gaNTA+hM55nDDsNr28dCT8EcahJqhrjZY7mSIq
         D0ePOGk3gYmWcjSySjxod/Qm04ZF8bsdW4QQolMLeLRajc0Wwy+ifgK3wsoYJxlOMjrF
         7DBFwZmCIJpGjF0GXwOnXRuMi9jcy6mCCd3LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739847334; x=1740452134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiOwT67oXPnFz1Rr3IxYnTV0PUqvvnxeK11HtBQeTcE=;
        b=SHpMtSQv6qh9n1XSsGelLGiATHgAOB7ftKJgWTEGUMz/xZaFwEEjDpSgEw/kkBg1Rn
         szEZMMq4YEyM8jXKn8MmjJ3ym3iflgfxqW2AS+EpL+jGRwP3aylEJHZW0gRPYxq3+bOm
         k3pa/PyQg5Cy8zojHh2D1mfC3xWmGUDN1jXOdDpV3WTx97wRF/cRpXIvy+Rfw1XxWmpW
         O+HTr5Eze40JER8iR0uBOcnUaGpE2lBKjQmJeLRbvQ9Lgbko/SvkdpugyjNW7FKdgMb6
         O24+0QG7PHWzpIp+uXdTm01Yp1oLji+r95zobRVaPTpiGVA6kKlaZRcz6XQqDdWA2e6f
         2ePA==
X-Forwarded-Encrypted: i=1; AJvYcCUBAx8hNEG9Qg3OZKipsOFaoCauiPVotraw0uzgRnygdLZ9h2IFxTmo/Ej1oB1g0ZRWhBjw/T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisFxIlhhZ7JL0pzMHv6JkL83dqGsj8Reni5vfT9vRVKL7Wi9j
	AKRTRIhyv/w9VdGCCzZIZX6A/8XiU3dLcvOwoj/dLI+eqtwxE3M4RM4nTC+XJeshxvTtEfD6sFf
	Pir75KY7QIYC8B3Dj9BnnpHJkzJc7Mlgn+kZb
X-Gm-Gg: ASbGncsxh6i1009fh2cdmiVY2AA/+nThyjXKhbRHThC/8J53Qi8LgPo/egYM+0XHYaT
	yf7Rp9/JWJ8heIBzlwAqg0oSqh7xGdnWG6nJVPGcazsTT4MhRVYtSZe7e5J284Lrh3fcflPCaQA
	==
X-Google-Smtp-Source: AGHT+IGpGG8tXtx0rVGHJZPy0YojNhFRAk4Bqh2lko7fcQlVMhgtPLObuwjP6KDVLiyzhiglcVQxN2ES+VazSjUoYKA=
X-Received: by 2002:a05:6102:e11:b0:4bb:dfd8:4187 with SMTP id
 ada2fe7eead31-4bd3fd92e1amr6286607137.13.1739847334110; Mon, 17 Feb 2025
 18:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
In-Reply-To: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 18 Feb 2025 08:25:22 +0530
X-Gm-Features: AWEUYZkJAgMAX58qvZMqeG7z-FDL1XGb5IWneysgwSzSt2QIwV6Scz_UTiYe49M
Message-ID: <CAH-L+nNXaM+P_1-HuE-w3XoCMraGA+4RhCm8L63LmHVmstXeCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: Remove redundant variable declaration in __dev_change_flags()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, andrew@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000541e1d062e61c6ad"

--000000000000541e1d062e61c6ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:21=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The old_flags variable is declared twice in __dev_change_flags(),
> causing a shadow variable warning. This patch fixes the issue by
> removing the redundant declaration, reusing the existing old_flags
> variable instead.
>
>         net/core/dev.c:9225:16: warning: declaration shadows a local vari=
able [-Wshadow]
>         9225 |                 unsigned int old_flags =3D dev->flags;
>         |                              ^
>         net/core/dev.c:9185:15: note: previous declaration is here
>         9185 |         unsigned int old_flags =3D dev->flags;
>         |                      ^
>         1 warning generated.
>
> Remove the redundant inner declaration and reuse the existing old_flags
> variable since its value is not needed outside the if block, and it is
> safe to reuse the variable. This eliminates the warning while
> maintaining the same functionality.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

--=20
Regards,
Kalesh AP

--000000000000541e1d062e61c6ad
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
AQkEMSIEIDIqgi5GM5Lky8YgEff+joOz+AQT6oU6QFKYZpkJSJCYMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIxODAyNTUzNFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCGYniX0OeQ
IC7l73mrtE243J+k4ZdwsDHUlqh/3eQRB6QpaCwPjo7mgupPYbbbXwDdwOUmW1rsAr56vdWMquXI
CHpMwm2Gvi7PhotwQRxntWnCwFyzzIUEFG61wZMkwzgDp0mKd+7+FFl6d/qGRMXLfhZdk97geBeL
voB02hq4Q1wWQxzzVWLNF4biEAk1Ve4rgwoVpgoOhYnaGIkLkN7marRcCK9Cqug+IdoKm5MFRVfK
JITlnBoJySWkbXkoigQV3FBoz4Aq2UEpY3dDns5ckmGPYlhIff19+4iojgWrqkpTtOdc+uqQ2mOk
4PP+KAx7xNiUu9UIa3hPnUTZeBty
--000000000000541e1d062e61c6ad--

