Return-Path: <netdev+bounces-156131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F292A050FD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3984163310
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB3192D77;
	Wed,  8 Jan 2025 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I/AzG8ep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3E2594B9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304417; cv=none; b=R3IVooEnx8kFQa+5sILhLp8tnE4ZOfOO1XzFbesuqvJRqw6y1LNn2NkmRJltQbhTIFnm1ImpH1IHXG7eKbm4ubZjrggP0pHEV6eEWuZhQOl87QmcFbyjL9NUe1Dy1QCHWqo3zQyTjj7aanGZMG2D0XEPAxVGg/98dpsujpGCaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304417; c=relaxed/simple;
	bh=ZvnQu/+9kFbCZV9Qdn7c4Qn7Dc86hN0V252atCQCcww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbwu34BadrdPWnpdYkB6+AOqEjPSwHZrKWddhMXXDVR6YmrCrpIQL1knzqGttaLBclAWQft7u5s913z3Z5GebWuSncPP7KFHKB1y4OoHf0hm+NYfdX0dRES/NiXYIb/ZMD7hdEFjfv4PBANc/qqnlMo902EUUa8A1vIXs/STDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I/AzG8ep; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaef00ab172so1872462766b.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 18:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736304414; x=1736909214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvnQu/+9kFbCZV9Qdn7c4Qn7Dc86hN0V252atCQCcww=;
        b=I/AzG8epbodW/JOhAE/oowGdpwe7jc0eiITL6G8m38krBGGK4h7AIUs6rxfcmN2UtT
         dvpjxpdfpm22rnbjAoJGTH/HTk9Vd4EZwHtk57k/Rn92tlDnpw1jvuom45OctAfDg3YG
         CS4DI19iGCWIamZjSBnbwNXqo9tg6QXB93MEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736304414; x=1736909214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvnQu/+9kFbCZV9Qdn7c4Qn7Dc86hN0V252atCQCcww=;
        b=fwoLY6iRmXaGAzE9ACJUxOIwmYnlQ0gg1v9MAy1J7o3SYNJwJv2STY5TksWILdjCBd
         OnV0gkCcXVaYUhxDz+YOsKiWODU3uFxaNYOctr7oohpQ947BuyqZBpBXcv4uM6oEhMmC
         Xk9MBiemD+2AJZYtsQRLOfa+RCs70oW/vFQLtDIX45gyAUW22ov5wralItbFRoDxdmQx
         ivEz6KcydVx3NHOmfB1dtnffY9loSP0DWu6F0E/It/if7WlRWa5QgLzXEG6U4p4fHrBu
         ModqrnYxjeJJ+ZoLD7nEOdKYLzfFHttBbj8D0+kt0ZPc69fKHcVV659m4GG5jDiHYqOH
         8iFw==
X-Forwarded-Encrypted: i=1; AJvYcCWCs58ClCOo/PqrqRug7KUL9R59hLQSPNWt/o74Mh40oubBAvNPZJf6/M3BA2yrMXvFspLYPG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkukmX1ThAer96ACfHLPupKhFhy3/7xdfNoKs+0VmvWspqOrV
	J2Mwls+Q3KS2W4Orw7+ExBCrXxON/+DwKvlyzlEr9lErd1HEN0lobodwYxC5vuCPj1Lj4jN55pS
	BZD6ZlmPCGxj+C73oxX+MuiUmTbMUbPxj/EZj
X-Gm-Gg: ASbGnctwsDMBOgifsNjIACzW1vTBzjAofujEBEEBzRTy55O3We2TUkVdd2w4pK5iHhB
	Ph976ZORZVyUjaaUxXUIy6iLZVw2exXd74GDkUg0=
X-Google-Smtp-Source: AGHT+IFMBkvTQdqpcYsfFywrHhGB7KsXQI3TcKGnYaaxro4ypX8rRqD+V9cmvPY40PygXi9BmKA2a1r09+btXeMl8LE=
X-Received: by 2002:a05:6402:3596:b0:5d0:ea4f:972f with SMTP id
 4fb4d7f45d1cf-5d972e0b068mr2274740a12.8.1736304414120; Tue, 07 Jan 2025
 18:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107214159.18807-1-johndale@cisco.com> <20250107214159.18807-3-johndale@cisco.com>
In-Reply-To: <20250107214159.18807-3-johndale@cisco.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 8 Jan 2025 08:16:41 +0530
X-Gm-Features: AbW1kvaBiIrOWJudWSA66RtLeGWpJvyjIdFn-ySS6wHD6BdbjalCknfd5ZWPqsQ
Message-ID: <CAH-L+nPvfnV+dhbpGV4J2Pxy53EQyNfbxWeu73cn=KikYh=Y_A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] enic: Obtain the Link speed only after
 the link comes up
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Nelson Escobar <neescoba@cisco.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d868a4062b28df6b"

--000000000000d868a4062b28df6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 3:12=E2=80=AFAM John Daley <johndale@cisco.com> wrot=
e:
>
> The link speed is obtained in the RX adaptive coalescing function. It
> was being called at probe time when the link may not be up. Change the
> call to run after the Link comes up.
>
> The impact of not getting the correct link speed was that the low end of
> the adaptive interrupt range was always being set to 0 which could have
> caused a slight increase in the number of RX interrupts.
>
> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--000000000000d868a4062b28df6b
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
AQkEMSIEIAjQv1fKdI3UqGooOwgfVMqXbcadv/2YD7IBOwiPhlaOMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwODAyNDY1NFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAsJZLcXQne
CGGSIKP2BM+u5fsmMlBrRlChppmICIaprjUqVNxAd/wOhtIfnLB4LjND0VNjmFBEE8aDf6MN5zzn
hAsJQ4y3r0XyGHl6T8qAMIl51n/7rzB0s3acNKUBU5tXIyjk3puzmTEFG2t8TLUJRwy0tuSsswij
flFAYR8rehOkWbCvIcTpWTil1qNOurcROdZyphlCXYsxZ84MzqYZqWO0ndMTXMuJBhjw6MSMfLy+
JrbRDXesGief7N2e6+7A1bCi0Y3gTzkl84KPoAmtylJ4fKvqLOxJr2W2V03fFk0SpTvxjPfsKiL3
+uIcfCnZly/nLshlUhlMshbfPsix
--000000000000d868a4062b28df6b--

