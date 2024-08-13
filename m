Return-Path: <netdev+bounces-118135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE4950B08
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C31C1C24D19
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E862557A;
	Tue, 13 Aug 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RX3Bw5v9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3E200AE
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568568; cv=none; b=PVxi6c9uGI3PJaEVuumTIrZuI6hcF2WJRZnyyKEenH5523vDi1MPi6zeANrLPPBWCBM/WiztBxQ7eytlkP1v0rZhZd0ciIAl15aZyNfr5yTaI+Sg6QYuXO3ce6tjVwI3BIG+GJiz5Ca5YIjHAh4D9tvq3Z0sflrBk/i5zfyjYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568568; c=relaxed/simple;
	bh=K8nanJw/e2/tNohnrnQ0v9r0WYh2lUZMsDeWLpJN7HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdwRLqPxhk3ItwiGCuFzO6bsL5LbgY6EYLF4pMqYM6VYD/Xv8vBKhh7QGzYRVQEI7RzhpGftduQtHX4B0Z2pyqtAz1Q3CDe8rsOuSTr+LR4yDFQEHT+uyjSUCDKbgEj7xECKFygBzudN3tdHyKy86Coi/kPv0Ke+FTQRC32aC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RX3Bw5v9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso6653234a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723568565; x=1724173365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xnr+16NjO9gz7nOf2vkfnnCZs9ZFOHBiBtUyKZahsWY=;
        b=RX3Bw5v9JQa6DkRQrcXfWhFh6xG7BI0Fep9wCnXNbOJzO0uDmvah7SF3OxVQJQPq6X
         XFZs0XtZ6ihxT6Bkj/0NOefB7p3I0oq2xMLHwMRmIXS8TBV1K8k4HBPGKTofZRPpy+LD
         YXyid+wMEHvAKcLzpYiHxkFUnvge4Lx/wZxjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568565; x=1724173365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xnr+16NjO9gz7nOf2vkfnnCZs9ZFOHBiBtUyKZahsWY=;
        b=Os/4GR3BA+D8WmTM65GpGgJStWdSRA0/fI5Tj+xK+TEAKlV2++EiQPK9XRb5U9ZhUF
         6B1w+JemJDnqY7ivbZz/FZNLa1GwVuhZBF18/mh6g0siTIo9oF45ddSLpcaA8xiWEIsL
         R+0F2o6e+8BAgm6h9PbIQ5EFztjYYiaPACUhUpS6Kxteg/xK4tzGXzbCO0pNUlr+Jcpy
         4ReJKbBXYJbiiHjhpo5ip5Y42tofHhe2g+yuG0oTbT6aDPPVRzunwi0+Mc1XoMA51Yu7
         x2gaRXUnHTJJg8GeBli0cIoyDwvA+XiQfKKLRXNQ564LtBUDMXqC5LFh2+iNLfSf+VGq
         v1dw==
X-Forwarded-Encrypted: i=1; AJvYcCWCPfUdu89s9sx1tsz1Mv9Ki/PAE0V9JNTDgEeuVQqFVcJ/GBIPnmwbuSha68qLA/QqQaScXubgDDgprbASdFjtjNb3cIdq
X-Gm-Message-State: AOJu0Yzet+u4lD0KzssRc40KYn2bp2IRcdV+uk3WEVfbrcY8EmObO1by
	FfABV/+uRR497+UOb8GqhSQNtpDeABI/NWJmV+R4QyMHI6X4uifllx303eymUUKNRhkNLwMXiit
	7YUSJP+f9piPGrLPpdlb3o+ODg0dsTn/LVPgv
X-Google-Smtp-Source: AGHT+IEUMHnLcX4HwxNxG01jQPJ5SURvsoe9LLbpjxN/t1ry+fpUzMgiRQQql7/aUceuviouNY6LC4cvssabh2gD+D8=
X-Received: by 2002:a05:6402:2089:b0:57c:9da5:fc09 with SMTP id
 4fb4d7f45d1cf-5bea1cac32emr107778a12.23.1723568564729; Tue, 13 Aug 2024
 10:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org> <20240813-bnxt-str-v2-2-872050a157e7@kernel.org>
In-Reply-To: <20240813-bnxt-str-v2-2-872050a157e7@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 13 Aug 2024 10:02:33 -0700
Message-ID: <CACKFLinr9B6iPYhYbPi1uxGSgQ64YTg7zQZhGV6SdpzOkgMgug@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] bnxt_en: avoid truncation of per rx run
 debugfs filename
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	netdev@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000145cea061f9394c6"

--000000000000145cea061f9394c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:33=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> Although it seems unlikely in practice - there would need to be
> rx ring indexes greater than 10^10 - it is theoretically possible
> for the filename of per rx ring debugfs files to be truncated.
>
> This is because although a 16 byte buffer is provided, the length
> of the filename is restricted to 10 bytes. Remove this restriction
> and allow the entire buffer to be used.
>
> Also reduce the buffer to 12 bytes, which is sufficient.
>
> Given that the range of rx ring indexes likely much smaller than the
> maximum range of a 32-bit signed integer, a smaller buffer could be
> used, with some further changes.  But this change seems simple, robust,
> and has minimal stack overhead.
>
> Flagged by gcc-14:
>
>   .../bnxt_debugfs.c: In function 'bnxt_debug_dev_init':
>   drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c:69:30: warning: '%d' =
directive output may be truncated writing between 1 and 11 bytes into a reg=
ion of size 10 [-Wformat-truncation=3D]
>      69 |         snprintf(qname, 10, "%d", ring_idx);
>         |                              ^~
>   In function 'debugfs_dim_ring_init',
>       inlined from 'bnxt_debug_dev_init' at .../bnxt_debugfs.c:87:4:
>   .../bnxt_debugfs.c:69:29: note: directive argument in the range [-21474=
83643, 2147483646]
>      69 |         snprintf(qname, 10, "%d", ring_idx);
>         |                             ^~~~
>   .../bnxt_debugfs.c:69:9: note: 'snprintf' output between 2 and 12 bytes=
 into a destination of size 10
>      69 |         snprintf(qname, 10, "%d", ring_idx);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Compile tested only
>
> Signed-off-by: Simon Horman <horms@kernel.org>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000145cea061f9394c6
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAZQatLDld+MUIv1xxxc89gLLAixa4ms
voRL9nR49HKZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgx
MzE3MDI0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCe7zFqPjXDw5br5IQIZArUqC3AZwarkuTkBGU4bl5vQvQPqNxo
Vmfh4+SZO50kWSOzoJv5ZWQ/N7Sevt5ArARShhImBrjsIpv2Ju8ZbG/ttn5O34Ot1NIb5551y0ov
b1lQag/6Er890B0BcQ6m0dqwufOMhvjJZK7REhQSnM0YQovhG9fFzKrO5M7zbTcXMfp+O7gsVFGb
weYAxDJSq1YvZ8gPFibeAHs+yAfp71F39CkoV3OWHukuX7egPZwu2K4r6VRgppb5IM0e/t5vzIzL
DXvnc7Fnvv7V2OcWBJTq2CwlQCA/UwRmGTd0FA8zAJVW9zqcArjJTRXaK2nlpTL9
--000000000000145cea061f9394c6--

