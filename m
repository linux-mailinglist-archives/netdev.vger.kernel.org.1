Return-Path: <netdev+bounces-183843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACCA92356
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415C618850E3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF40254840;
	Thu, 17 Apr 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fJqcpYs6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79142248AE
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909301; cv=none; b=NHCPgtFbSSS0uJlsNZSTgG/Eez2tyWBl+A+gxTK7ESdFgaMeFEkyL4IpAHNEw/BYBxc7fTrTaXr/meMPf5vACpyWE1UXpox5uQG6pizrgLzM5Ejn062yVig78YKv0CwwQ5bmJpeMXLumKyaGKPkQ5etpC1Vcpax1kjrHbbYpc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909301; c=relaxed/simple;
	bh=uqZSnGNm/cMOcfyw75sF0WAfZ1GDCO+V7Y31zgIN3l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Agqc+plEQ5FtVkBt7wte/GffpaZWHGy/QuNk0U4K2IRmfkTY4aBFNoGYOJhfCTUPa5GVNs8a0P6xLOjuCORA8/xnFPFYz+LqfWdwEN83B9eYGxx4NyCF0OzG/Yun2emVCVCKR5OYssRAJyxJ2dgqNKMKBkTOPj5tocFoFKXYo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fJqcpYs6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso713239a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744909298; x=1745514098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uqZSnGNm/cMOcfyw75sF0WAfZ1GDCO+V7Y31zgIN3l0=;
        b=fJqcpYs6QYEunPQ36dc9Jf5B0mS05+Fz87dE14GSv+8TEdA+fZs6yfjBOToE1n7XBw
         +NMltNtqu8f+60IP4B8f5Qyb+b+LVa/vPHydGPHH0LjGlT/wEdyt1NP7G7k6NFXXQVru
         PcSfZrH+WC3nM3ddL4vLbEAAXWTIVyEVZVKoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909298; x=1745514098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqZSnGNm/cMOcfyw75sF0WAfZ1GDCO+V7Y31zgIN3l0=;
        b=M7MtKKT7BD3Q1Rg8fE0ZmIT6OzN/eVj8Qur1kBEtcOsKTxB4kR7zgCJDc4rLXs7VZl
         hVWMpcyfD+GyJc+PqMvZkPUbgakgy28W8tmORdfPebjeeehkLIm1L83FI0TVvSUIff9z
         9Kr5v0kOjlEKsF/rg7p5lVSD4fy0qfuqaXs42wLRKoUKExfwC/VupB1CxdZh8AxI5vb8
         b8vr12bIPcwqMSzMSDc3+t0UkFgWfSdn45PbjNKgT/iotkPKeC3rbBIVubiTiejfQUBo
         H3UN9ussk2+iCF1nmdd2AU3shBYxrasxF4qRSkoXnRvmoIkwiHfcIaPd3YC+/RcHfCPf
         IKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq8p2OueJ0VqBJfGbt+lMl4VCP3nkXv8n9l1dhYRVt9y1UpdoMBsg6cYSeyxCKLJPSX0rxR48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqq5E0sAQXLXDiB1dI+6kM9rOKREmp2QgjYrY4DJFsLrVm+oDp
	Z3VQnbHW5nGmN1yPCodIGMmqHHn6fhJ8qZjJ7WFb9G6pf+4vDxF8R4Hr5ROaQrxP6/nZWjYgPz8
	6Gw82AjwPR3kNIQqdZvOxylK/PVfbMvG0laSLHSHiSPutSnk=
X-Gm-Gg: ASbGnctnfo1MN/ZbArhO9C7jd3tvfWofg48blvTPnwNXeJC/3ZHHqlrBsEe86y/O/NL
	zP30Um8r6THvqukYsvA6HkRYn30aMddb0ecO+NlsWmC1gOMirq9PHOCmqencMXvuO1zEdcWQDDy
	7OtdsYz0STGvOuQq8MG5bownY=
X-Google-Smtp-Source: AGHT+IGjgodQ1BE4/jJWJr/FrsPV3xqXIjzN6XjHo5HrGpnDad/JmBy+r4DvZHhTKJOQazNr5G9OpYMi8CVfcFiS3yk=
X-Received: by 2002:a05:6402:1e89:b0:5f0:9eb3:8e71 with SMTP id
 4fb4d7f45d1cf-5f625f1caddmr61939a12.27.1744909282676; Thu, 17 Apr 2025
 10:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417160141.4091537-1-vadfed@meta.com>
In-Reply-To: <20250417160141.4091537-1-vadfed@meta.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 17 Apr 2025 10:01:10 -0700
X-Gm-Features: ATxdqUFMhD5UJTU4xZ_l_hDBNF8usohj-yUjaY2T3CvTzmF_wPcpbAN6gI4ej3M
Message-ID: <CACKFLimNTRh_n0xNq0-PtmLRPquY7EDBDouQTYUKoSzrE2DPHw@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: improve TX timestamping FIFO configuration
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>, 
	netdev@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e6d4610632fc5a95"

--000000000000e6d4610632fc5a95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 9:01=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> Reconfiguration of netdev may trigger close/open procedure which can
> break FIFO status by adjusting the amount of empty slots for TX
> timestamps. But it is not really needed because timestamps for the
> packets sent over the wire still can be retrieved. On the other side,
> during netdev close procedure any skbs waiting for TX timestamps can be
> leaked because there is no cleaning procedure called. Free skbs waiting
> for TX timestamps when closing netdev.
>
> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX =
packets to 4")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v1 -> v2:
> * move clearing of TS skbs to bnxt_free_tx_skbs
> * remove spinlock as no TX is possible after bnxt_tx_disable()
> * remove extra FIFO clearing in bnxt_ptp_clear()
> ---

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000e6d4610632fc5a95
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPVdyjw/MHtel5PmIb3W4usvlrPUFxME
WlbuFcxsxFFVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQx
NzE3MDEzOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAGDz8fjmiZ3GAh+9OW/io+hW0cg2NUNxXDz/UtKaMUue5Q0DlTvrQrD3Aphbs4n4AK1K
+lN3b0mtHHLJ6mib7UzP3fX+0HCrNRuO+8GiVy1BWgTKwV095cxE2ALcyUfruXbLkoGdVJtgPhFn
GMuleAzyh6Ig5pPCimVvlwgxneDIO3mLr5ODxmbzOANB//di4/LzAJQYE6dra5S/hCg1AIE1Wqi4
XhhuUQHbPkfBZNiEh4tXkwglufvrq6OQ6o1tIMw0ARik2zVa/urRdU/ZVTIQfU4IMuaaqz8OyIYy
ZL9mVJ8NvcEj8B9FaUNQs08u2bkOKB3zLROygLgXlKdBp9o=
--000000000000e6d4610632fc5a95--

