Return-Path: <netdev+bounces-102031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D2490125F
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5081F21ED4
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A23179663;
	Sat,  8 Jun 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eqQZnguh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8BB178386
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717861255; cv=none; b=rzldakU9pcP6wdazM73G8ES57ylUlt/nks2IGB0GTULrz+H2KrQG3v1ocT59C4Jl5Jz9stfFdzHeQB90ELerzXh8WSWe5IZvWILvIBpavV3XJALgASEeHdieQ25jjHGznZOZmRRoZJ0l1ZsnUkMd9CaH+ebojoohSCMFRCMk5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717861255; c=relaxed/simple;
	bh=it+bTnjP74xGPZsbBmRUiHS/UkL0J2wyDvXSRtW4TX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqygUoreD+BhNnOsSkFlBAn8+Q5D4b0GWc50I1ItVloDi7RqwOekt1qwJE79tZHYzGCBe3oqBchZw5Rt/+7G5w996luhU2JN6RquT9x6ArYuXxcO/BLUmxxizXy8Hw3QSDTdQYs9fi41LRAxc1DG3mZKglyH5x7O5pIem+j/xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eqQZnguh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c68327d1aso1001034a12.3
        for <netdev@vger.kernel.org>; Sat, 08 Jun 2024 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717861252; x=1718466052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULa9ybBv71Nzmk4dniDIdFhWLJI0ud0qtuzbbXopS0M=;
        b=eqQZnguhAF8kxuRfNcrInNtSw0ZyjbDWR6ZF/n6btkTjrTKyXIm7XDAoXXcptJi5bu
         v3J3u8yUhALjisa+dR/myW3nopO5X3TgpA9Uipz5TdbdPjubVGB9XB6p3X/JJzcpwILr
         2+pnSNkmc1WcMQ9xDLPpusR83Tlx21kho0BPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717861252; x=1718466052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULa9ybBv71Nzmk4dniDIdFhWLJI0ud0qtuzbbXopS0M=;
        b=XuHRl+I98BBgNMs7oO2t/e9lyugk2xFWh+iW09QHLGk60LzoOu9p/QlH3urfNf5pT9
         CpzDb2t0LYxPWNJeTl9J8cKZ7R/Z3eheCKaah/U2ipL6hk0ELdjxIccKGABYzfqgCOLy
         Rp+lPpFu+FHkJN/RG19dtBayjvLVG2OHc4M19/rcEZOAbIFeRoHbK/Cyk0s30Fv4ZQDz
         3DOy+saq22MPsNBviwDK/kdVDaPp1BeZ0jHvDTOzj6zxtOrlQMulXNqjdimTUXouHqia
         hyx/eJk4iJKodv5lLA+GvKMB8Jf1+WjLLMyJRyepnCNEuxjGKbxN/Yl/Nhk9Xe97DstB
         n6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOvEcQOamMGBlAfGVfYRE8orb0Ni2Huj6H7voPB1IN02j+PqPPir9VscJCslLd9WlMubSHBrp9Yzcc30zRnGN4XvHnM3px
X-Gm-Message-State: AOJu0YwO0yk4eG/oVvBboHt4SR0bUlohC5Gn7gkLcJSOuUJ9vMEIPGFq
	SHbttmW85mwc0R1xD1lqNINQlsDKT5pqHj4KjIt13BgzuDnSimR7BccIFNvcj/fz4Be+W+Ov/C/
	1HAEBPHGVM9sVqcrGvruLffdsQYPO84HUMUeV
X-Google-Smtp-Source: AGHT+IE5Jw2EhNXDkZPQL38iDzkE2JtsiHFNIi0Ne0naujILOrEaSoEVjx/r3a2YAbIRN5r/83/aRCFau9FLcBG7Uys=
X-Received: by 2002:a50:9fad:0:b0:57c:6b68:3ba8 with SMTP id
 4fb4d7f45d1cf-57c6b6840acmr1299039a12.12.1717861252116; Sat, 08 Jun 2024
 08:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607070613.12156-1-amishin@t-argos.ru>
In-Reply-To: <20240607070613.12156-1-amishin@t-argos.ru>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 8 Jun 2024 08:40:40 -0700
Message-ID: <CACKFLimTo8EZwhV2qGs07O9B=BuCGrrC7x3HECorTet1wrsbsw@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Adjust logging of firmware messages in case
 of released token in __hwrm_send()
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Edwin Peer <edwin.peer@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bf21f1061a62bd2c"

--000000000000bf21f1061a62bd2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 12:08=E2=80=AFAM Aleksandr Mishin <amishin@t-argos.r=
u> wrote:
>
> In case of token is released due to token->state =3D=3D BNXT_HWRM_DEFERRE=
D,
> released token (set to NULL) is used in log messages. This issue is
> expected to be prevented by HWRM_ERR_CODE_PF_UNAVAILABLE error code. But
> this error code is returned by recent firmware. So some firmware may not
> return it. This may lead to NULL pointer dereference.
> Adjust this issue by adding token pointer check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 8fa4219dba8e ("bnxt_en: add dynamic debug support for HWRM message=
s")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net=
/ethernet/broadcom/bnxt/bnxt_hwrm.c
> index 1df3d56cc4b5..14585ac476c8 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> @@ -678,7 +678,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_h=
wrm_ctx *ctx)
>         if (rc =3D=3D HWRM_ERR_CODE_BUSY && !(ctx->flags & BNXT_HWRM_CTX_=
SILENT))
>                 netdev_warn(bp->dev, "FW returned busy, hwrm req_type 0x%=
x\n",
>                             req_type);
> -       else if (rc && rc !=3D HWRM_ERR_CODE_PF_UNAVAILABLE)
> +       else if (rc && token && rc !=3D HWRM_ERR_CODE_PF_UNAVAILABLE)
>                 hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0=
x%x\n",
>                          req_type, token->seq_id, rc);

Thanks for the patch.  I think doing this will be better to preserve
the error message:

hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
        req_type, le16_to_cpu(ctx->req->seq_id), rc);

The seq id is saved in ctx->req so we can use it.

--000000000000bf21f1061a62bd2c
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIF/l0QwcneNEbCDcjBX5pP0agifb5sj
9Vr20n80XbBOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYw
ODE1NDA1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCxDxG4bv1vrhb9mYZwSrKDxvzLaHOJ3EXig6N78Z1RXCYGIzrT
vvC2Kl+fmf5KiD9ehj6/tMBBCQ9JMTk0rmvnU5YLpthA286xWz2Lo5+aIK1qgHsNMdF0aGntMgbV
aYeHiZku8NqYWfO5G+7H9jt90owJoZUDh6zPDyzLaKMv9LPxbgu/DFXrU1+33SVScHZf5gXMjH0D
7HvqUL4CN5Lgj7cs+n+y/pJuxJ5A9STl4ud2SJWuAppbzraKPk5mRD99q9m/av7s6hMen3hh928V
S6CYnJf8Ipa/ewRtMunmCnXmZRbkfI1QP9l+41FqZMv15Mf2IDvnrqTC0mw6RU1Y
--000000000000bf21f1061a62bd2c--

