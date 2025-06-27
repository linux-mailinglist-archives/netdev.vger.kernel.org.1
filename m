Return-Path: <netdev+bounces-201771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56BAEAF2E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10341895137
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293102153C7;
	Fri, 27 Jun 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vt6F/1ak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4A1E32D6
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006914; cv=none; b=jIsarXbGufZc4XT1m9pyzbiPnhch/X3+vcVX4wXI5GQoSvrsCBnw61IrRG6v4rDVj0U9Veaew/XFDXItFg6lK4cRZMhZm97DLS/teUMg+Xmcw1hNPRc/AEIPpgYEvNRQ6oJV2jIygX97Al/AuDsvrPH+dD008riTIDV9xuNCIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006914; c=relaxed/simple;
	bh=l6qX99MhCqG98QfKqTCJrF5kBv7HyAPN8n5ekIrVPhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRJDyI1abbgJJ5apqsfeQRYZA+fKNDjB1z6Xp4lid0s0FpaLWjqnAAhN8XGui+lTt64UZby2W/gsMaQUu+StHmdNwuWFssISarbQwJbxM8iYJ5MLZ2DWCOdo2bOdppcjULKWmmFOfc4miO9iMoy2/qyY59h+ny67DbNggQ9m/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vt6F/1ak; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so3070104a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 23:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751006911; x=1751611711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Bjltdz1lFkGUG8QRNuySX7hafkmDLH3kbEjCdYz/c=;
        b=Vt6F/1akC9+BEdkeuqIS1i6Ifvq90+XKXqAp7/cAQuyGVEoFp6xYluz7dZNq3h8Md0
         mpombwkL6vMfaR9+wP2+KO5JQGTG8b+1VegQRzerHBsgcVtGQbt5hctkawYPDNm4nAJO
         5H9AGeLRmGBiwBDLXiXvJH9+rPmD8IhnQPjbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751006911; x=1751611711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1Bjltdz1lFkGUG8QRNuySX7hafkmDLH3kbEjCdYz/c=;
        b=qLKwpKURwzUWmn1tgR/ac8TDWEUb9VM/v9PUexheCbeVPE95Wiaai1TAzOkP+F5cJI
         HR9GPxEXyMigmDgWolowX5OFjpEwNHmZUdXqj1/5ZeXA2H48XPxmQt0IenUaZa/w2WJ5
         RPZBi8XGjOhvQEbVsoD5zo+v5lfEiAjV3Xv4ywqphx+sr160Ej+envx5VnxQ5whFrI7q
         vuE67Rl7yWm6AF9oPMQR3ygBhgfLvNICjykAXF6Q+Aywp0asogOJK/2yHK+fiOipgZ30
         Ue2Uc5m0lNd94ZbTWf8Qy29LuMVNEjsBaxYtDLPwSs+QioIgd8BMAj9PGOptIZPFcoU2
         TW9A==
X-Forwarded-Encrypted: i=1; AJvYcCWmakujb260PtdT28qO8wUC68V+NhAk0c2oOY0rNpe+682lUWEBFPZS1Yoju6K/tkoUe0x5p4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz999AJKm19+jaJ1WazHwJq0qJVP784SiAWXfTZ42qAYwn4Trkw
	pJ1T5VVuCphKjWSe9GjSwVBv29iWF+xOYaM3+b1i7ZrUu9E6voVr1O3vgZkY/QI+FfSp3hgMcYf
	zfLcImZ94uNXv0IusFaHV17/W9cN+LthbEazG7KNOwhbKqDd9S+c=
X-Gm-Gg: ASbGncvs+BAW6ankceXE2TPgwAYlLCFjUKuJDOF9kbmc+1zZvg30cOWhHWceQH7T1U0
	U2RwQm0iUeX6kezIVD+noBCJgeOfY+OaGVvq4rhrwPbs9enfRTMbIXChXgKAD0vt+6QTCVy8g0M
	KFtpR78nQzEwWZ4keIl3J4Qw0PNXkj/7Nc5qbT4Fe6VHE=
X-Google-Smtp-Source: AGHT+IHMtSG4ms2IEsTTUm7aS+TvNtb8qRlHTvG9yTcMIjoueIj5rhepMV0tjkIJvlafHXaUPvaOrFRsiGBi1J+6YfQ=
X-Received: by 2002:a17:907:d8b:b0:ae0:ca8e:5561 with SMTP id
 a640c23a62f3a-ae34fd5c8c5mr198514266b.13.1751006910617; Thu, 26 Jun 2025
 23:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626165441.4125047-1-kuba@kernel.org> <CACKFLin2y=Y1s3ge8kfdi-qHGfoQr9S3BwOUCSKTCu6q8Y6D1Q@mail.gmail.com>
 <20250626154029.22cd5d2d@kernel.org>
In-Reply-To: <20250626154029.22cd5d2d@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 26 Jun 2025 23:48:18 -0700
X-Gm-Features: Ac12FXzW816W49lqHlBxFZC_tXVQsx0KKQhAB0nasJxVg7FQWF-qV7Qw0Z_saFU
Message-ID: <CACKFLikrdeF=sp4U9zT_3LgsQuS9PQcoPmTdiBLT3G4fGrvi2w@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: take page size into account for page
 pool recycling rings
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eebd5d063888102d"

--000000000000eebd5d063888102d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 3:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 26 Jun 2025 14:52:17 -0700 Michael Chan wrote:
> > >  {
> > > +       const unsigned int agg_size_fac =3D PAGE_SIZE / BNXT_RX_PAGE_=
SIZE;
> > > +       const unsigned int rx_size_fac =3D PAGE_SIZE / SZ_4K;
> > >         struct page_pool_params pp =3D { 0 };
> > >         struct page_pool *pool;
> > >
> > > -       pp.pool_size =3D bp->rx_agg_ring_size;
> > > +       pp.pool_size =3D bp->rx_agg_ring_size / agg_size_fac;
> >
> > The bp->rx_agg_ring_size has already taken the system PAGE_SIZE into
> > consideration to some extent in bnxt_set_ring_params().  The
> > jumbo_factor and agg_factor will be smaller when PAGE_SIZE is larger.
> > Will this overcompensate?
>
> My understanding is basically that bnxt_set_ring_params() operates
> on BNXT_RX_PAGE_SIZE so it takes care of 4k .. 32k range pretty well.
> But for 64k pages we will use 32k buffers, so 2 agg ring entries
> per system page. If our heuristic is that we want the same number
> of pages on the device ring as in the pp cache we should divide
> the cache size by two. Hope that makes sense.

Ah, got it.  agg_size_fac will be at most 2 when PAGE_SIZE is 64K.

>
> My initial temptation was to say that agg ring is always shown to
> the user in 4kB units, regardless of system page. The driver would
> divide and multiply the parameter in the ethtool callbacks. Otherwise
> even with this patch existing configs for bnxt have to be adjusted
> based on system page size :( But I suspect you may have existing users
> on systems with 64kB pages, so this would be too risky? WDYT?

Agreed.  Too risky and too confusing.  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000eebd5d063888102d
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMvmHvawndSlG6XMrdnYd1xCXJpZbxH5
dFCoEjz0ZhYrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYy
NzA2NDgzMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAAirh1z41AKVoGbGVnyFhHSY2JL9UFYqv7N5uSMRdL2sMbT5tmqfRcVm4wvjI0/+vCaJ
sx5c3e/zfYwiw3kZQyTtPlO5m0vRm33DtzKexcIjqFmMtssDCRyMkljn/zw0zUfSEcLr7iAUQVav
v9BX+LMpLc5QQgYBfp+mIuoKUrXHEet7dp7Wr3UafJ6qhu+NXvz4zTY6OJr+qW1D3SunfB9/m482
e6E6qJBxsJfqsv/YqPDJqrz4Feb74nHQLTvschxjzV6rwth6G/EpMf94TUtEUGFl9ua2PG2F0o/4
gKuQznK+sfgb+roX86Ku9TAAW5fpvirxP0KZ5LUGdLTQ0iA=
--000000000000eebd5d063888102d--

