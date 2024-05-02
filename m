Return-Path: <netdev+bounces-93116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761BD8BA1BE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A519AB22D5C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAD17334D;
	Thu,  2 May 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bBNHe3km"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257C1DDC5
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683389; cv=none; b=eBkfewg5sFpWX6cdOElkrz1eOIdq9LG8mU+NbKopp6CXU7RA7nwHsFu5iVZbXYaR6jOX//amqnh44hOU+DPuc/uAqUxUXhOMu8oEEd6y8P/WeadMRbCycDgpZiV7MNVJoLutbeClzr8aKZHyvwTRtSTMk3a4qUL6aG7K9796w+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683389; c=relaxed/simple;
	bh=y9p8PaiJ2SDP2VrSTrZf5gh8xtbP8xPjlTsbMOtgQ54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9h2c0aGz5yZ3zo9vWotAuvq+dM3OJwYu5lQSGKACpaqde1y4d76ncwhDT5jA7/hKtvRXYvcJhtWS11U+1MNjyMTw+zcvHqWCvC1uQ4GIv0Kj9JGcaFUHWYB8T/PCe+3Kgu9/u2kzkJ7HR34OPmkCL0SUtPKO4u6OoeeKygdlPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bBNHe3km; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5894c1d954so353019866b.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714683386; x=1715288186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKIkmG/q3fvhwM40ScdCbVfME9dinXRnuDCX0swv9ko=;
        b=bBNHe3kmd+j7IrQDhQjUWfafvQtteddjjwyAVqUlkhFesBgEqDwnUdBeUspBAI/dc0
         7/JQr224JCEPQb0KJh+n5lMbNtOOtzb5j5n9P78AmDaJEZP9OBLv4wvA6xN7wy9JJ8wn
         f1duuONIG8/Qc/aQlS1i7HY2UDuzE6v29dLSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714683386; x=1715288186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKIkmG/q3fvhwM40ScdCbVfME9dinXRnuDCX0swv9ko=;
        b=LHbRYCuyHwt0Xa505bPEu/N62VpJtnAodmcSx280hnNNfS/+04xnR7jmAKMlw/Uf9f
         z0ZBvV5INhCfoc4cu/bf6tAjB/MCmgH7E8U51eWQ2bDLNUGrANZVHA9uZVsCO3FwTpSc
         /EbglkMjZexNn/FpldQJwY4XGGP+e4p/bCImHgeNCC+xzuK3lGTF9WMVphO+CBVWR2im
         mxib6cSXWbkzAbsOt2j0UterDW76pJDLWThMT2VXKlg4nlmLLvpvy0zcytfiU8rt24bu
         xJG8aFxHKm8DmQrwCHNyKEHh4kkuGL17OIm2iPJoPGx1KO8eUZTDoYajr8dCfcJXPTFC
         MFrQ==
X-Gm-Message-State: AOJu0YxmTekgLUH+GnqZfUTeKmh4SegIRZBRBnKGMKrsB6N3Mar+9lJ6
	GHtk9RA10uVB5dt6XIyLB3PJy9/xymsJ6HYCceXNgDtgzVIGPa3yoJG46VTnplhoWgR2QWrHDZ7
	YnASwYvF04QgOgLaiWsixYw2NwLA8gvnYN8CsIbJ9PrjzGGM=
X-Google-Smtp-Source: AGHT+IHVwDl/lAfhpmoczKUkUCn/eQ59JHPvqokCGE91VUHPNmkGWCx1Vll+crCSBSY1Ek1rucYqThW2SKbgzBDJ2ik=
X-Received: by 2002:a50:d595:0:b0:572:9d22:eb8c with SMTP id
 v21-20020a50d595000000b005729d22eb8cmr422147edi.15.1714683385530; Thu, 02 May
 2024 13:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502203757.3761827-1-dw@davidwei.uk>
In-Reply-To: <20240502203757.3761827-1-dw@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 2 May 2024 13:56:13 -0700
Message-ID: <CACKFLikqOuJSpn3uZ8rnscOJvB76-cZDXy5OMzjd-GCqEYhHFg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] bnxt: fix bnxt_get_avail_msix() returning
 negative values
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000023425c06177ed612"

--00000000000023425c06177ed612
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 1:38=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> Current net-next/main does not boot for older chipsets e.g. Stratus.
>
> Sample dmesg:
> [   11.368315] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 Able to reserve only 0 out of 9 requested RX rings
> [   11.390181] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 Unable to reserve tx rings
> [   11.438780] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 2nd rings reservation failed.
> [   11.487559] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized):=
 Not enough rings available.
> [   11.506012] bnxt_en 0000:02:00.0: probe with driver bnxt_en failed wit=
h error -12
>
> This is caused by bnxt_get_avail_msix() returning a negative value for
> these chipsets not using the new resource manager i.e. !BNXT_NEW_RM.
> This in turn causes hwr.cp in __bnxt_reserve_rings() to be set to 0.
>
> In the current call stack, __bnxt_reserve_rings() is called from
> bnxt_set_dflt_rings() before bnxt_init_int_mode(). Therefore,
> bp->total_irqs is always 0 and for !BNXT_NEW_RM bnxt_get_avail_msix()
> always returns a negative number.
>
> Historically, MSIX vectors were requested by the RoCE driver during
> run-time and bnxt_get_avail_msix() was used for this purpose. Today,
> RoCE MSIX vectors are statically allocated. bnxt_get_avail_msix() should
> only be called for the BNXT_NEW_RM() case to reserve the MSIX ahead of
> time for RoCE use.
>
> bnxt_get_avail_msix() is also be simplified to handle the BNXT_NEW_RM()
> case only.
>
> v2:
>  - only call bnxt_get_avail_msix() if BNXT_NEW_RM() is used
>  - remove non BNXT_NEW_RM() logic in bnxt_get_avail_msix()
>  - make bnxt_get_avail_msix() static
>
> Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is no=
t registered")
> Signed-off-by: David Wei <dw@davidwei.uk>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--00000000000023425c06177ed612
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHAryaHTM9/e3fNIuGuYAG5LkYxtfefC
xhUqgMOVUCjeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUw
MjIwNTYyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBvEhWYkHLQyHmGiMN8/Ak00Vpz56r2acOmLGPwPmS02Lh60xy9
ysyPlKFgOt8Kznf82Hx3nEJ9JTG25QJrV5HCsweq60xnSZ1yiYCk5SglnH0trJlr4xaIfEqPCale
sNMG+wUE5sceJetRpWhhg50RNy8TJ99YAw6YvNJt8Zhii7sNo/j1FX1vmuHOysaV8rCjWHTdt3tO
CrgeT18roCpwDQoxYq4ytHf0B4+FWSMzyumX1BhKibX//g5QCf5EcZaL+LrMLpAP7MSUi1yulMec
pRwPQS1F5PR56FVrwJO9gyoeE+34dGxyN2q9hFWB6kg/8/0ttSflNxTHIqZ6Hdjw
--00000000000023425c06177ed612--

