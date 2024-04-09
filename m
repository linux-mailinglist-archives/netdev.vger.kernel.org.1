Return-Path: <netdev+bounces-86328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1068689E675
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3355A1C21137
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4615956E;
	Tue,  9 Apr 2024 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PhaPeq7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160B15920A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706725; cv=none; b=b9VH4YTzXCcjUzNF/Dui/rOTmw5LTx5V9Gve2pyOHduU0c7D2GGO2kczhadmp1tuBoVld5cHy6DdPIz4jPi575JaLQeWAnxtRYLIZkdtO8CxkYWBNIIzxQjySaMfIHtumnqJ4YQZmHWdbpuHvlYCTDOwvHDU9EAJk9qehMZ9PMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706725; c=relaxed/simple;
	bh=Qq+diNbRqesPVsUeS9+r5d1BxtLKXPZJKJcn9dTmJbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dos/jrd04clo30vqC9Q1n1NFqUeKadekMpifiwAwxWK+/8Unfkyyrx4UXP6t4ckNmd3mvWSAhSro3okCeIgxwgWN6utYIsfbMvrr3Kq0hEGiDHqTiYvgnhqUnM81w2upaTA5c0hXzkeyYR9ivrLsRUFbCdlhPSnyj1fmCVh6tTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PhaPeq7n; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d87660d5dbso40946401fa.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712706722; x=1713311522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8Oytyx3kSKE7o9cogwjCjKLNT61KAGB5PlIF5CrqsA=;
        b=PhaPeq7nA1iu2gn7+IJZH1QCab1+k2weXJBEg9OSHDi2ZI2jcT4QkiBLvpQRVSm5YH
         oohWM0Vogu8Y1efOt6PlstHRq31fGMCy4h2A40CBNvXU4XKBsPniNb+ttxdUAv9OzH7e
         vTuL/69LqRFfOSudaT5TTvTjTkOhKY6bhMUVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706722; x=1713311522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8Oytyx3kSKE7o9cogwjCjKLNT61KAGB5PlIF5CrqsA=;
        b=K+oUXroAvgwcodqGwy5IXFVAoPhdq7Bh1puHAGdFXDFQr/hQ76hlRTl1/ZWNCOCBHs
         4b8653rvqH6YjSxFGd4qbwvyG5tQ39uCKsG7vRjRlRj6HNI9HlZ6QJr+J292nhKIrRSw
         NNCZ9aQBT8sv/TQbJLHobXcb75cQVYikSV05PS7nvl2VtmaiEyqVuDEGRnqomYrhcFKN
         2Ksc1GK0rDYQ1MiTaIusvEAK9hBmburh0FygBcsRjXN51rJRL/9tPKyx/TnrWtlZEnMy
         gNIUVoUBHKECXlAARvrII94OBOIzpOH1Tgcf0xZZ2lZjpTvJaS61eTPp1e7xXNPxkWfY
         kjog==
X-Forwarded-Encrypted: i=1; AJvYcCXOiMlW4NLB3jNqRBo0wWwLRWYKTg6OdNw4uI4UP+GGAXE75sBSnocrPGRScxQJp/vc8HhNcarN8Vp7z/tWtlL9eMcTrwXR
X-Gm-Message-State: AOJu0YzG+0r9yRWfJElG6BZzy4eGmPFeLdMkZycPHvFyuW+JwDPGm1Y2
	RPNqYBo+bGC0WNpqYmxwoVSkl35HURYlFHp5Y5Y7Scszg4NhhGXhaz16JiQoQ+U+98kj6ROZWSW
	W0y+1iMKxvUr5GkSleYiwpR6wqUTwj5oAlOdd
X-Google-Smtp-Source: AGHT+IFYC1A2JW1rvb8LovmlBuV4ozEK8S8z365MG/LEXPEBUQ+SAFB95am5fO7Hkx9mcw7gENj8FbIfO1JX+IsQl14=
X-Received: by 2002:a2e:7808:0:b0:2d8:60a4:d0d with SMTP id
 t8-20020a2e7808000000b002d860a40d0dmr672835ljc.53.1712706720937; Tue, 09 Apr
 2024 16:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-2-michael.chan@broadcom.com> <721f07ab-4dc1-4802-957d-1e71524ac31a@intel.com>
In-Reply-To: <721f07ab-4dc1-4802-957d-1e71524ac31a@intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 9 Apr 2024 16:51:49 -0700
Message-ID: <CACKFLi=8wuyNxkmVYQjb2O2Vsb74zVc3QmDVZ9hchdDedY0gMA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] bnxt_en: Skip ethtool RSS context
 configuration in ifdown state
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ca34400615b29b23"

--000000000000ca34400615b29b23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:26=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
>
>
> On 4/9/2024 2:54 PM, Michael Chan wrote:
> > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> >
> > The current implementation requires the ifstate to be up when
> > configuring the RSS contexts.  It will try to fetch the RX ring
> > IDs and will crash if it is in ifdown state.  Return error if
> > !netif_running() to prevent the crash.
> >
> > An improved implementation is in the works to allow RSS contexts
> > to be changed while in ifdown state.
> >
> > Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|se=
t}_rxfh()")
> > Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
>
> Makes sense, though I think you could send this fix directly to net as
> its clearly a bug fix and preventing a crash is good.

This RSS context feature in the driver is new and is only in net-next,
so the patch only applies to net-next.  Thanks.

--000000000000ca34400615b29b23
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPKl26AuUHWyqpSboUbeNAGiDCOVEyof
PSB7CoF6zW3hMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
OTIzNTIwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCeiTy5uPi7TdbKGXzt/HzF790PtHmW/LEpl8EMSmTrM6Iqs0EP
BQJsNIIGQvfNzJzxnZ0EhmIo6jAcP30yuomNL9hhW3kBGf9zsg+mxvvEDFSlecP7R9nHSxgk7BTk
hooGLsy4h7zPCQHURh/IOBxtUK9kKdAE+nrcxqHt/aDJ+ppt7piVeIM6DAdQaUBefJ3wjNhh273w
/drfN333e3aBSABD7b37gZkjNJs9PdQilAVdVPCfyFl4cSRjKJJgt8HwseqUhrV1lXDlKJBh39d3
w502jlC3e1CrUVRi2Q6OOt/jha2hz+ou4NslbHwaLq269RxU3dnQdNmMqhhnGO9h
--000000000000ca34400615b29b23--

