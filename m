Return-Path: <netdev+bounces-86326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960589E665
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A541F21F92
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20129158DCB;
	Tue,  9 Apr 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hlr1s1cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006E158DC4
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706535; cv=none; b=jmNOgg3fLhNmduvMRfRPPapEfE9WshLM5bl1jHDJjUl/9Omk/UZ/1qUVMtJHp7iucCFHmC9bhvtTSfO7YN1Hvep2pzLBpMg/uPw2G+gaOmj/F/z2FSqHtRmfYpfRF0w1OcEllBweg+A1p54fTBxd8HoFfo/yEtQWHhCd8KYI7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706535; c=relaxed/simple;
	bh=At4DK1qE1BkU/xM3kLTUbAWv2Nx2P2QT4utgptDGL/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVp3dPdzAtBXGBmUJL5LvOTfbDE/GgZwe7+oMaEe9/n9LnGRdapqD/+tX0CWxYzO7+IuUhhCrOeWDJITQ9KnWt/Qu3dSaC/ZDz2kCgmIipxkuAjUtscQoU3QaHvPXZ9oLeTYj3uTf/FK14d50TfYIdC2EFDQ725gDfRHHJE2kys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hlr1s1cz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so3298438a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712706531; x=1713311331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/3FQ1ZgS5KREnnOihXyzobIh9aGK1IokUUNnAHgy1tg=;
        b=Hlr1s1czNFu0oVcSu7581YKXL+wTjfhLWfEvTSVNqdxLXfB5qKBcSRzLtTGv48+OaF
         VSuuN17zFoWIfaCXr9jkXEFSrW5FfxBbLCHbyuskZtJxvBZOGa+chNsJQKDFZF6t9pOA
         Gfe2SDdqQzkS+Ws+ko62Nr1UVibVxm9vJhEXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706531; x=1713311331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3FQ1ZgS5KREnnOihXyzobIh9aGK1IokUUNnAHgy1tg=;
        b=CrQ3aA4PdpfMxA0jSWWQ1UJwf0XWEOCeAvxBsuulvCVFBC9pdgeaaJ5PiANszDg6vj
         N+92Ek5UKn+DzUWTyapfGd1mYGMAeoHEeNAI78O3MAgDa0WwKe417OrOJy6jCRM7jutV
         KdAN7RmHcYxYK8RBQMMfYt6506I5Dmm13xlZXVKgn5ednwkdTGte4zTgpf/cHgnXhJd5
         r9+zRN+Jg4gHv0JmpgJfueGZDnsDtn8ycIS8UT786c1nGEFOIHGDwztKms+qCpHOVsG1
         QlP5ltTi4EQ6jbZ09LZU1XrTMCrDoBb29ELnXpeSuBkUPlo/Fc02mC1Ko80E0dHvnYQ1
         RV0g==
X-Forwarded-Encrypted: i=1; AJvYcCUTetfD78IT8dmxJqc1S6FOymYSuy32v6/KUO2mzA1iDyIyBMaP4PVg+uN8zAq6pgRdsztnDfiWKUXvDdL3VuG2TqGF48Fl
X-Gm-Message-State: AOJu0YxzvzU2etMe+93JQGRPmt5innIfHrdoRKz5eeSxkQVqvVhhIXH8
	MayKA9U6dxseaixJD8v3L+yU7de4xJtu/MWP5smGy3dW86GZ3YyrcnPIkMeE0HH8YdO/8lixvXa
	MjEpXvwTZO6OE8TyjMTPkNPb+FCDjHUpTUIsW
X-Google-Smtp-Source: AGHT+IFp6rpEZmbrxSE7Gir93w2K08ErIZwujDn6DYstB69j3hVVZviRkgW1eXLIAFkoxppZ+Jp74sfQnWW0N8aunAk=
X-Received: by 2002:a50:d656:0:b0:56e:246b:2896 with SMTP id
 c22-20020a50d656000000b0056e246b2896mr709020edj.3.1712706530588; Tue, 09 Apr
 2024 16:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-6-michael.chan@broadcom.com> <7f4f5a1f-1320-4082-bfe2-6b1eb422e37b@intel.com>
In-Reply-To: <7f4f5a1f-1320-4082-bfe2-6b1eb422e37b@intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 9 Apr 2024 16:48:38 -0700
Message-ID: <CACKFLi=m1jKw18p7QnZ3FV1Bg+5quQ8pt3gEYrZfmaS8+8Ptiw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/7] bnxt_en: Change MSIX/NQs allocation policy
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, Vikas Gupta <vikas.gupta@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006e98c80615b2901e"

--0000000000006e98c80615b2901e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:40=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
>
>
> On 4/9/2024 2:54 PM, Michael Chan wrote:
> > From: Vikas Gupta <vikas.gupta@broadcom.com>
> >
> > The existing scheme sets aside a number of MSIX/NQs for the RoCE
> > driver whether the RoCE driver is registered or not.  This scheme
> > is not flexible and limits the resources available for the L2 rings
> > if RoCE is never used.
> >
> > Modify the scheme so that the RoCE MSIX/NQs can be used by the L2
> > driver if they are not used for RoCE.  The MSIX/NQs are now
> > represented by 3 fields.  bp->ulp_num_msix_want contains the
> > desired default value, edev->ulp_num_msix_vec contains the
> > available value (but not necessarily in use), and
> > ulp_tbl->msix_requested contains the actual value in use by RoCE.
> >
> > The L2 driver can dip into edev->ulp_num_msix_vec if necessary.
> >
> > We need to add rtnl_lock() back in bnxt_register_dev() and
> > bnxt_unregister_dev() to synchronize the MSIX usage between L2 and
> > RoCE.
> >
> > Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
>
> Whats the behavior if the L2 driver dips into this pool and then RoCE is
> enabled later?

Thanks for the review.  If the user increases the L2 rings or enables
XDP which will cause the driver to allocate a new set of XDP TX rings,
it can now use the RoCE MSIX if needed and if they are not in use.

>
> I guess RoCE would fail to get the resources it needs, but then system
> administrator could re-configure the L2 device to use fewer resources?

If the above simply reduces the RoCE MSIX, the RoCE driver can still
operate with fewer MSIX.  If the above has reduced the MSIX below the
minimum required for RoCE, then RoCE will fail to initialize.  At that
point, the user can reduce the L2 rings and reload the RoCE driver.

--0000000000006e98c80615b2901e
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEUSo8mCaLG92wyQnduaQQ+ql0KUVPTv
tCUq6btc9sAxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
OTIzNDg1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAZwrnP78sz4HG2VU9maApD6Zk4VYA9FvmGFQRyq4GvHN2UmieG
SvSuH1gLhw3mcw2fgfyqAJStiept+JEj478PrAUp/Si5vIfZmZr6Tv/CNkwgTERmlI/D8FY+5mkO
hgfJnI2D4rtvqEk8E8lFHNYSAgfu7oyWcLZLifQNVzxk0NPKDAC99jx9NrQ9+DPsHYdEclazS1aP
0yh/zhodFkwwtmHkhGYmQYPJ8mOAqs8ll2WYUMi0qCNbm5DTAc4qGhdk1LUlOGV4qMrDJRS9AZle
pJwAjRpi3wT0MUZsEKIbVCQCFTUj02C9eDnzq+sa6r5zaIFQXFwJ7ZeobEXDg1iW
--0000000000006e98c80615b2901e--

