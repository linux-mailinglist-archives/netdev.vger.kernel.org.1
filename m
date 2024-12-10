Return-Path: <netdev+bounces-150600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EA99EADBC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCF0286FBE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A1199E9D;
	Tue, 10 Dec 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xew49WAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AB23DEAC
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825725; cv=none; b=glLlNWos/bQu0u9CDSvlP2tvkKxuPc4RBAYVF7pvVfWdYtg7+4CofcLfTCQ8rNMJpyndMjPemzqur6kOl/rQKuNehMFhhjaanRsWxiM4F2ykaAssZLweVr7qLOx1bo35xp+tQt2s9lnm103/VDRiHBAH3/M7ciGzBxlABr3mSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825725; c=relaxed/simple;
	bh=8qOd+guWZUXL8bXULEXdvhECpXwP8LWDCzHklWULJLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JngFZ5paIcWLTKk04Ugi3HE3yw3Ky17zihlq4vFQ4ZzQaY5jg0KHtNID6BOdU0VK+mKKuGCkKIgtF82hUjISZd3Uzc5NB+/6fM0QAgGHxSTJ3w8IKIosrTWGC8GMEz3skRqTF8dd9OXRinxslH2Fpvjy2HdUy3pN/1eYO4okaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xew49WAV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e3778bffdso3901672e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 02:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733825721; x=1734430521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ROAje7AlwHnMhFx/Ex779EdwyLRpCeV3Ow05SI8e2oE=;
        b=Xew49WAVs/y2gs/aDF5nWMUMTjsTsER6lLhgQCMrUo1HS6KIjjAnbyxvVe8iKP2kJC
         m6oS+O4mDAn+4gW+vEvDBaQC71JaLiNutIMz2Zg9WC6cgfNyAizn7JHmTZA+FYybZj2N
         QEkV6Mkvw/4d57K02WpHLcNziOa6qlFiHc/Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733825721; x=1734430521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROAje7AlwHnMhFx/Ex779EdwyLRpCeV3Ow05SI8e2oE=;
        b=onQZV96r4vSHzd0QPnR3//vJz9tfX9M+F3LiAPdF2ge0IAvD/Xdyp5d2H0SYo2vQF7
         /XUStMGXdNrMyEdSSyiYfDIeDnuKK++OcPaPnxuxFsI9lU77C+aZSN+c3xhAelM2PSOW
         RmMnK9xjp847BhSknzWW/48xNAALYhNiWf7IGOH6KyNs7vgz2UUkx72iwLwlnUe9FoOD
         BoHWy4xonC4rbCa75dEHsEej/i+OIMi0uO5/oScUe+Oac4m0qA2uk7mErOtGr4waWoHx
         fm+Fqv33fhDruLa2COKsgweUm+OG0joNXvssW/RUlCKVFy6A2O/9dmDLqevBbdUYo21O
         S7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6qBrgINyL+VTHFzsb5liU8YxjOlXe2oz5XMv3MK//Mv71iWZ2DrM8X6xi7YVwL0MaCov+n9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YypXli0GL+hEb+7qPABybpCKKdqKn+iFp4aJoRxOHqwzNHJxLnE
	ZUprrGVwXpFqfQkWbB+DRAzyBHtxPZppQG7+bCdZshCfQpx1n8zJbnU7nmBdHtKO13apJ7KnO0D
	BY34gCbUqIxyX09esq4E0vQNVNtEDtxtWPSfM
X-Gm-Gg: ASbGncvaAT+Znazn8q0Oa5L6Yern3RablXTDpds5RcxuOhUMjCPYwrBxVSYFoL4pusT
	pIakvHe7Y8nlt74MWxSxy2ou9DAZ4hmUD5NhD
X-Google-Smtp-Source: AGHT+IFFfq4zEKKCY0WD9PnlgnKlAoTTBo0DfUPDrZPqS+KF4rnJwSQMkPVycQQE6TablzlfzVoZQtgyBLde9XWKTyU=
X-Received: by 2002:a05:6512:3087:b0:540:1b53:d412 with SMTP id
 2adb3069b0e04-54024112eedmr1483373e87.43.1733825721270; Tue, 10 Dec 2024
 02:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6c979914e8706dbe1dedbaf29ffffb0b8d71166.1733822570.git.petrm@nvidia.com>
In-Reply-To: <d6c979914e8706dbe1dedbaf29ffffb0b8d71166.1733822570.git.petrm@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Dec 2024 15:45:10 +0530
Message-ID: <CAH-L+nOCURGD3d_V9FZBJcxCEGG3md7urURmm8Xjm5AAfV63FA@mail.gmail.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: Do not allow mixing
 sample and mirror actions
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com, 
	Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003df1060628e7c213"

--0000000000003df1060628e7c213
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:26=E2=80=AFPM Petr Machata <petrm@nvidia.com> wro=
te:
>
> From: Ido Schimmel <idosch@nvidia.com>
>
> The device does not support multiple mirror actions per rule and the
> driver rejects such configuration:
>
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action m=
irred egress mirror dev swp2 action mirred egress mirror dev swp3
>  Error: mlxsw_spectrum: Multiple mirror actions per rule are not supporte=
d.
>  We have an error talking to the kernel
>
> Internally, the sample action is implemented by the device by mirroring
> to the CPU port. Therefore, mixing sample and mirror actions in a single
> rule does not work correctly and results in the last action effect.
>
> Solve by rejecting such misconfiguration:
>
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action m=
irred egress mirror dev swp2 action sample rate 100 group 1
>  Error: mlxsw_spectrum: Sample action after mirror action is not supporte=
d.
>  We have an error talking to the kernel
>
>  # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action s=
ample rate 100 group 1 action mirred egress mirror dev swp2
>  Error: mlxsw_spectrum: Mirror action after sample action is not supporte=
d.
>  We have an error talking to the kernel
>
> Reported-by: Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

--=20
Regards,
Kalesh AP

--0000000000003df1060628e7c213
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
AQkEMSIEIDebI5b0u1gxiz48Vg7BQlw7FnadSha/AHGLwamExiSPMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIxMDEwMTUyMVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAZOjMVoXyT
HaJ3UNxR4CbxdNw41fCpH83/YDnCEm1EQcb12f+DmazDa71r15t7mKCWRQB0b5kbk02aFhFS5+dC
Uucj5BnAIGnCHHI/CZJKwD/egN6/kibquSJKrYAWZIJbiMNgQ3W7GTD6f80bBh7FkxDDNf4oEIbs
GH8Glzqvzrha+RxqOmlTWpLBRlmpMZcHXy1qYRQI9vzULrN4D7GgqrxtpFxwv07QB3+dK91Ld9PE
ya4MRR+iT11XF7H+d4TC2sU84s/URQY4JDLu707GT1PYvtAPa8KkRM+0diATz/5VF+pMR2A0cGhK
rqBvsIA8wQlY63NQkvFzk4HJSrUe
--0000000000003df1060628e7c213--

