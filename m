Return-Path: <netdev+bounces-165299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5AA31840
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9A83A5B27
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA213267AE6;
	Tue, 11 Feb 2025 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VWh/ACyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720B267AEF
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310615; cv=none; b=f1gfowb39Y6klyGN5hu7S3nqI2x02Q/QQkceXkaXzxeo+unQ9M7PLCa+9NXhmFnliyil3stiKUXfE+KVBsSM4Fxn0f2RHCP3hbJ/Mb7b/T3OQArfBUcM76AHrYAV51eZAOqWtbe4ABuInrGXxGF6rEOW/+r7bQ/LdKRgIeyL6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310615; c=relaxed/simple;
	bh=VqrquspBbjAeGnlwRcQ3UwHnOkAC3qirS1ruLF5CeL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGlI2ITkiexPRNHL5Mg7yXW3ed5Hifqj9DkpifhwNuanyFBLXOwusJ5KJ0QVvgIrJzRiIzs9Hi7HEBaHiHOdaRonsv8DXMXCZb4btN6QWkVdXV2AJjVgQ3prQqkD3Z6KEwOHL7+sAFzdrcR6geK0RfFo1HVliQkY0Ygf0xvX1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VWh/ACyd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de6e26db8eso5945876a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739310612; x=1739915412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9zpj7a207xfHJI84vy45kQeSW1RsKzcJUfvmslLnsU=;
        b=VWh/ACydUzJgD0qr/PskV175y5N4wmGdjBbSNHnPTnMcTkSeANa5j9pKI72iXl5RkB
         X1LJcx0R7CeRcepCHGlT0geLJQo6xmoNUKXCnxAnJ1Jvyi2XhtzFPsS5/vvXHkxgICKn
         2vL13qyEnamxMgrwcN0whOa6t3M4t80U67giU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739310612; x=1739915412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9zpj7a207xfHJI84vy45kQeSW1RsKzcJUfvmslLnsU=;
        b=TmvqcL2ttr8d0mZxxGe2cQ8cGCgFRe08fJ5EmLVLLm23tJALBmFWIPWtAMepI/MsQs
         tEJ0bCEUNS/uz7B90mEf2gZT+Tnog5obZA+sjOsZXwt9zGCL9zzsj1HSPPe9sKQQhSFQ
         hAFSRTVouIMlEgGqjV/i4gYMC8+QPzzmh1Dklj46r3OcI0/DvwvxzX1rleTRhjLcaMJi
         28xpuPOTR6R0zBhGA70pJKTXR2gfiJAk6UpDPSF7brPYk1vp7lGNBmmQhMUprN3b1sp1
         AZeB7NVP/K6SpPceTW1jHaZIzpiz3R0XN1skLrootIvCO0WwrhOPgRzaltrclsn1xV8o
         +DNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRpfLim1Jau8WhLLfLoHiig9Tbhz3ePZgS/hkel/uu3/8ZgfbLKhAQug5YEjN/yk7/l5XvT8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YygiAtKbtjd0DRYxxXP4nJHMHgHSwDnKVStdRzvRXPzk1J/3E62
	BLXUhpJAk0q0xH+JxGMYjaxl1+2IfFmS6a0d4bA3/OwUg917PjzUNAKJB5pB/AieqIJ7g1Wc925
	ZptTA3h124gHs3U6UOJFvwM6KeGpSLlqD1Lrj
X-Gm-Gg: ASbGncumrIb5kt+mTI6QzdasqGEgR86ciWrTeVtaHteQ8Yfb/fFXOOberl8feeV1oKI
	VJz6i/b4h5kevgvWMUKsImBysfl8iguIxbqXZxWCGxRAZMLVADTx3VG4Q2cH9fNVukVYh9S1WGg
	==
X-Google-Smtp-Source: AGHT+IEzvdTZ+3wC0JFomO+Y1YcTp3JMALq7QICio9ze2LjI5UWqTTzlxPG97BiGyYin/NtNxUDFynl62Ff5J1FY1fc=
X-Received: by 2002:a17:907:6e91:b0:ab6:dbd2:df78 with SMTP id
 a640c23a62f3a-ab7f347aaf2mr50256766b.35.1739310612150; Tue, 11 Feb 2025
 13:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211152658.1094-1-vulab@iscas.ac.cn>
In-Reply-To: <20250211152658.1094-1-vulab@iscas.ac.cn>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 11 Feb 2025 13:50:00 -0800
X-Gm-Features: AWEUYZlJqZ96vEuKDUCMsd8-UPzDZ02JbqtPzsALouB03yo92Anu8Iuy1KGd6xk
Message-ID: <CACKFLikfW2yLUmZpJPE=npeUi-LBaDyNFVVPt_FA+4bYdhvEEQ@mail.gmail.com>
Subject: Re: [PATCH] tg3: Check return value of tg3_nvram_lock before
 resetting lock
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000377bf4062de4cf2c"

--000000000000377bf4062de4cf2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:27=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> The current code does not check the return value of tg3_nvram_lock before
> resetting the lock count (tp->nvram_lock_cnt =3D 0). This is dangerous
> because if tg3_nvram_lock fails, the lock state may be inconsistent,
> leading to potential race conditions or undefined behavior.
>
> This patch adds a check for the return value of tg3_nvram_lock. If the
> function fails, the error is propagated to the caller, ensuring that
> the lock state remains consistent.
>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 9cc8db10a8d6..851d19b3f43c 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -9160,7 +9160,9 @@ static int tg3_chip_reset(struct tg3 *tp)
>         if (!pci_device_is_present(tp->pdev))
>                 return -ENODEV;
>
> -       tg3_nvram_lock(tp);
> +       err =3D tg3_nvram_lock(tp);
> +       if (err)
> +               return err;

It is correct not to check the return value here since we are about to
reset the chip.  The nvram lock is a hardware arbitration lock that is
granted by the hardware.  If the hardware is in a bad state, we may
not get the lock but we should still proceed to reset.  A few lines
below this we reset the tp->nvram_lock_cnt to 0 so it is safe.

--000000000000377bf4062de4cf2c
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEXFQiBL1KvNsYmT3Cv0bk6hhnvfjpQ8
03eCBam28pY4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIx
MTIxNTAxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAocveK3vct7udWabwpYKIaR1LaffIvWY34JHwuxxbf4+G3YrMN
vLSqqOXWyGunSGQrWgMYN0n0HQ7qBaDnegW2K+Fi8/87oEbSXeieV2MItgpIVhzCDYZ0439REttN
E3zPo+u73s3VJL+6A6suQDpIckrPmiDo5WxaupeUMZ+sTpShgNXUstYj2tUml1V2F5wmvlDQIoos
GCzkm4Ux5wWvAVi771t1gu59wb1KScay/7zs8yvnhfHdQvpkDtbnm5+A/OurintmBiVD88c8cYsg
2Zf0851YIy4//CigNHC7lVVlfs1BIrWFWszvXn7ROTkoDgml3LSJm0aPIXzpgddr
--000000000000377bf4062de4cf2c--

