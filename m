Return-Path: <netdev+bounces-156133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E271AA05101
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6013A21A7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB41465AD;
	Wed,  8 Jan 2025 02:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C8pz7o4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883832594B9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304581; cv=none; b=ZebGCGKtHglVSNXbpR/cF+wn9f8+mYvjMwldCuU5za+tQArgNb/XSF7KJcFnXn1/AfEnmTAKzF3mBJlqgUGBLVcmCNIvlGozyVpsz0k9hnD71NEYaGMiQ0XyrYd1YdZqrXCwPKnNLCX+w8s6vcABmIhSCBjdr7IxIZad+LptXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304581; c=relaxed/simple;
	bh=ebckDzFqPOtMy4sfbU0Ddp9HUxuWyIP8VBwLFZ9MeuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPrrtEbetb0pa0P/vE2LKNJVu4pLPAMuUMdgMEmo5C/i2Fa4e02RP3xTrZzI8yq0lxFSGJ3UOI//KKYxR9JmxbJgiw85NuRnr4G8ROcQMVnkhzzuYJoFT9MEANivm++/B35A9M804QCbmvVEXLFJ8kasA/+p24lcQgU26w9Q5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C8pz7o4R; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so21999499a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 18:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736304578; x=1736909378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EwDOCplWp1+pqzk5zqMM2J/5sA70eM/zyHpd5vsb4CQ=;
        b=C8pz7o4RngVlsQCHwelf3Z6V2KjUYWl6/d6a0Ie3uG3n7oDW4iVZWANuHaayTjVp8Y
         HJ0kR4itUpOnIzHJqvsUEXlRuPVbsmpXW2opEf2i26CbJpc/rvlSdQW88w+YwTAWeAF9
         kvIb7pkPDZKm8RhviOuZP40d1tIIc4zkautxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736304578; x=1736909378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwDOCplWp1+pqzk5zqMM2J/5sA70eM/zyHpd5vsb4CQ=;
        b=JBEGBQbW9nM5njxLhW1zXiMIrvyreP5KFPPvfID7qk9QsydycFkY93Y3qssbBxfzb3
         qZEs/LGFGAgQoqR3HTC9619kiOQQmT0P7IFJv778cxGE7BQxrI6cwp2S0nO4r9jOH+MG
         Ow8kZL0GMovsg7LKvAv58iF6oe5HNNoeGjWSUAR4z3e8nQEwWS9mPCZLJWoIt+SqCzML
         FjBDmgKztknOgkJi6e9qJdFCsWqPbbBdoX9dN50ykSnPm6kkNR5olJJcOSTwFeATXEV0
         OLRfq/S+PVHk9jIRrFbzoMAflquLR39IlceSrv2LQNgNO2toa77tPFYagPFwe0cc3mOd
         83wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHd8JMHhpM12TEThgZVnrfVd/8Pn4mQsNs+gPokU5NvTFTaIechV6TnxP+aXS/lzzTEW2to9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuN7+F4HWkRI+4WynVvz3qgz41c5YyPe/Fl7wpelxPDe1wLhre
	hdQ7QBDkTlyRxUpkFC4sfG75rYBXGxCQg060lEcd/eW7ZvfPPV2fe3o1Wx1zAB2eT68V0K6P/Vw
	M2BlE5Z6W2B1tkh1c3BC/gdSw14doWOuVVIGK
X-Gm-Gg: ASbGncsjWgvMRoX2IKQa8Xrc/IF8KEEcZosmTe5wwtpXhrUJ+xyedphKmMlvvJiOyoy
	3BySdUVFgr1sLPBJjFZcPrxDvWD4lRLxhJOmYKQM=
X-Google-Smtp-Source: AGHT+IG6QQbtjQxjTBqYXYpeWiyNL3DyYlNhLdZ3y8FcPPNTM6Tta/a8t3a0SVN1xZ/80B5uV0jIpGttO0FPo6+iv5g=
X-Received: by 2002:a05:6402:210a:b0:5d9:a54:f8b4 with SMTP id
 4fb4d7f45d1cf-5d972e06cbcmr814780a12.11.1736304576442; Tue, 07 Jan 2025
 18:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107190150.1758577-1-anthony.l.nguyen@intel.com> <20250107190150.1758577-3-anthony.l.nguyen@intel.com>
In-Reply-To: <20250107190150.1758577-3-anthony.l.nguyen@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 8 Jan 2025 08:19:24 +0530
X-Gm-Features: AbW1kvY7FvsWBaj8P0Fvt4efQZ5SYxNY2c5eSYNHr3llRLOmQ2BQWWIUGAFoxxQ
Message-ID: <CAH-L+nNWP_s38ES4OToAdQf2wj5WevteRj=mpa97FK84f+4_ZA@mail.gmail.com>
Subject: Re: [PATCH net 2/3] ice: fix incorrect PHY settings for 100 GB/s
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	Przemyslaw Korba <przemyslaw.korba@intel.com>, richardcochran@gmail.com, 
	jacob.e.keller@intel.com, pmenzel@molgen.mpg.de, olteanv@gmail.com, 
	Milena Olech <milena.olech@intel.com>, Rinitha S <sx.rinitha@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009be5b2062b28e9ef"

--0000000000009be5b2062b28e9ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:32=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
> From: Przemyslaw Korba <przemyslaw.korba@intel.com>
>
> ptp4l application reports too high offset when ran on E823 device
> with a 100GB/s link. Those values cannot go under 100ns, like in a
> working case when using 100 GB/s cable.
>
> This is due to incorrect frequency settings on the PHY clocks for
> 100 GB/s speed. Changes are introduced to align with the internal
> hardware documentation, and correctly initialize frequency in PHY
> clocks with the frequency values that are in our HW spec.
>
> To reproduce the issue run ptp4l as a Time Receiver on E823 device,
> and observe the offset, which will never approach values seen
> in the PTP working case.
>
> Reproduction output:
> ptp4l -i enp137s0f3 -m -2 -s -f /etc/ptp4l_8275.conf
> ptp4l[5278.775]: master offset      12470 s2 freq  +41288 path delay -300=
2
> ptp4l[5278.837]: master offset      10525 s2 freq  +39202 path delay -300=
2
> ptp4l[5278.900]: master offset     -24840 s2 freq  -20130 path delay -300=
2
> ptp4l[5278.963]: master offset      10597 s2 freq  +37908 path delay -300=
2
> ptp4l[5279.025]: master offset       8883 s2 freq  +36031 path delay -300=
2
> ptp4l[5279.088]: master offset       7267 s2 freq  +34151 path delay -300=
2
> ptp4l[5279.150]: master offset       5771 s2 freq  +32316 path delay -300=
2
> ptp4l[5279.213]: master offset       4388 s2 freq  +30526 path delay -300=
2
> ptp4l[5279.275]: master offset     -30434 s2 freq  -28485 path delay -300=
2
> ptp4l[5279.338]: master offset     -28041 s2 freq  -27412 path delay -300=
2
> ptp4l[5279.400]: master offset       7870 s2 freq  +31118 path delay -300=
2
>
> Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel=
)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--0000000000009be5b2062b28e9ef
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
AQkEMSIEIDRh1fty1LVXmmmVxe8+yQAMluQnsFoZiXjs28XcPBMSMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwODAyNDkzOFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDBNevy7ldQ
XBHMe3OecKuWJ/fggPn0BoKSnmeJVP6SXjr32HNllLY4+SpOdtiFFfz5GJiWK0V/KZ8QGT/jvY9x
1tW9rllii+p6qGLMj9MgJQkr/Uu9gKlb9SyuDObDhg6LqgPENmf54ohbt6F+QaNTzG+xRbSsZx6p
cUNGgYPggoWNG4Vk04dzl21ZIojAQBwEAri1hTkmeVYrsqHW8YNe6Jem7h3Bn4EGOViV2QISNvpJ
BKOuwQVB/898BicWoFgNl9RKhUIG4BhIP8Sc3di2lkhEr4YtyA8G1YBiMcNOoZFeLrD8bLM3AxRR
SNYOugMqtJe0BweIhVmF/E1Y60Qa
--0000000000009be5b2062b28e9ef--

