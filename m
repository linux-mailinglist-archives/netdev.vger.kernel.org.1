Return-Path: <netdev+bounces-156132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82496A05100
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C21888C8F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512213B2A9;
	Wed,  8 Jan 2025 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KPKuk95p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86736134AB
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304515; cv=none; b=YrmTpUxJSAtnkLDY37JxmxvWopwjLB1UK2seBHmxxkKeeOx1p2huioCqWdSyS5320Fjf7ID6A3GSqShTcbmOH/SNpGjxP5/svCO1FpYV28nWWvXULh/fVLlHigjPsK+jSXK+C+V8jmAZe9gVjU11urc3KeWjOqNwB4591Em257Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304515; c=relaxed/simple;
	bh=anJETctjzfLlfBQl6bXcjQV73Gexx/OcDpx83VMge54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enoIFJiG91XsFXKLQltio4XMztXIamwmFphCJsxsapR3EDyqMe+xTJ5BTxNXSFJXxMxnTvlijjo7mPiIvRJizpnFudsiG46KHj9L/19wukIPDDoo7sVIZERpUS//eXRnX8YkNEeN4NtCecmF+o6t5LmvbyA+xLSGZkG9PdjQnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KPKuk95p; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso29998378a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 18:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736304512; x=1736909312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NdquBNZMgGZyXtO0B4oyhF5pFpRgc46mPFlfdHraIFA=;
        b=KPKuk95pX2AWQvUFW1TulDUcpHF3uoXhNw4SvfnaDm6CK/7UHxS9TaO824kWoFOgyz
         +wOfn5qMouJlkJc5mhphbQwnuU8e0cZbhRHmYYu+lnRshsx3/ch5yjIeiQCmTC8+c9eO
         /WOd5M8umvgzincmaC/ddGuj5GCc3NwUDkFeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736304512; x=1736909312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdquBNZMgGZyXtO0B4oyhF5pFpRgc46mPFlfdHraIFA=;
        b=mUnrDcqSxGBY0ogq1j4CVy+I+KTbm89yV/12HRerN9qCEdfVvYDq4FRyYVLDy1e4qn
         tIJditsUVUmBNvP+06to2xM9G1lgkhVUH5b+Sa/t3FvTwCezkMvTzpuueBvx4fVnerF5
         fYErwVqJJTLImUjpjo/LPYjqr3Y3TGLDLHbTEd9w7eLlyjdxqOquqtX2OKpVwZXlxL+3
         YbT8pUzOGPMo+8DBJWa88GN1uXktNdp0zjkA4yqKgFwIuhA3UKaa2V/fLyWAQANoJHGf
         Sr4S0Gxf1GD0bstmHpxWmEX+WaWfJZLUR9GSwQgxtE+/fc7XcogYghi+fqP7gAGCD2Fp
         L+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVpXEYgIO1x2CewpEvhCXhGO75SRS/xxmSbGrhIqJl8sHs8QozZH5sJtcOlyud5yI8pKXlTlVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpkLotkUv1eQRWUMyFcYKDC1GaBDPW9AeRYY3X65M6ZfqdOm4
	aEkR2XD/KD0diNcOUGm0oHBDphmZ+/g0fosRZW+tuA2ReAL9gQ60LrOZ5pQHto7hNtN1thad0o1
	DpLYLTkFGkBR5n9ZT8AEfa8N6DU0mPU62FgI6
X-Gm-Gg: ASbGnctGfruRGMuRoIY4zOq1KzVPnEevqqHlAST1vS8128QIkNyOtfaLNoFkEnivUPl
	DjBUQRUciTb7dLYNghZW5FjXGsGBDThSM15+J82g=
X-Google-Smtp-Source: AGHT+IHALGptMTJ2rsgtdzyZSlroGMCC59oFCvqUIMsIZkOCMjUTdTdPa02g52IcPFpuG8vqbyAGBFNxhFmGI1TwV8A=
X-Received: by 2002:a05:6402:42c1:b0:5d1:2677:b047 with SMTP id
 4fb4d7f45d1cf-5d972e6e423mr994852a12.28.1736304511838; Tue, 07 Jan 2025
 18:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107190150.1758577-1-anthony.l.nguyen@intel.com> <20250107190150.1758577-4-anthony.l.nguyen@intel.com>
In-Reply-To: <20250107190150.1758577-4-anthony.l.nguyen@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 8 Jan 2025 08:18:19 +0530
X-Gm-Features: AbW1kvZiOFXmYgdeBcRVTJMNlFdaPNn2CF8t3HqQIi32zosdzPCzOeaUkQ0Lygc
Message-ID: <CAH-L+nO=q_Fs50e2ib8PgzHj2xL_borPONEM-reqpOr9RtQSZA@mail.gmail.com>
Subject: Re: [PATCH net 3/3] igc: return early when failing to read EECD register
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	En-Wei Wu <en-wei.wu@canonical.com>, vitaly.lifshits@intel.com, 
	dima.ruinskiy@intel.com, "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac2b43062b28e569"

--000000000000ac2b43062b28e569
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:32=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
> From: En-Wei Wu <en-wei.wu@canonical.com>
>
> When booting with a dock connected, the igc driver may get stuck for ~40
> seconds if PCIe link is lost during initialization.
>
> This happens because the driver access device after EECD register reads
> return all F's, indicating failed reads. Consequently, hw->hw_addr is set
> to NULL, which impacts subsequent rd32() reads. This leads to the driver
> hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
> prevents retrieving the expected value.
>
> To address this, a validation check and a corresponding return value
> catch is added for the EECD register read result. If all F's are
> returned, indicating PCIe link loss, the driver will return -ENXIO
> immediately. This avoids the 40-second hang and significantly improves
> boot time when using a dock with an igc NIC.
>
> Log before the patch:
> [    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCI=
e link lost, device now detached
> [   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_d=
evice) (uninitialized): Driver can't access device - SMBI bit is set.
> [   43.449186] igc 0000:70:00.0: probe with driver igc failed with error =
-13
> [   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity
>
> Log after the patch:
> [    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCI=
e link lost, device now detached
> [    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity
>
> Fixes: ab4056126813 ("igc: Add NVM support")
> Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--000000000000ac2b43062b28e569
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
AQkEMSIEIEmVkzM1oAyj3Nmfve4Fzs0zgVqBpUa8stK1iQ3efuFEMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwODAyNDgzMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCPP8UpvTpL
8EqIDUNp5P5lOnEozMZFO+Yrq0DEok4160djpwwMfCyiJ6fNvIEygs+Kc49LNIFf+lWiBrO7jBtM
mdq2x/f4JNRzXvKjumUqk58plLdQkKrd3D1lSiob10mqd1GiNPTAaPFNOig409RVXvpB0mki+clb
BGws762uOFJ3eWtI2o1P3EyZKhSmY3idUiXm7qlSrMz8NhDFj9Zdk4bmLo3v/FQp27hevcND9ZkM
+rFSu4h+pTmmff5BI7hILR6qFE2zAXg0wZrAZ7NAggewuoVyerFh7PP+diq3kHXn/Q5A6YFbgPOl
Yd9p0yhIUQyCBPYuGA73/3MN2oD9
--000000000000ac2b43062b28e569--

