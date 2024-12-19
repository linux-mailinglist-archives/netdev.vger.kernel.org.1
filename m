Return-Path: <netdev+bounces-153492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50759F83F6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59284188C961
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772141AA783;
	Thu, 19 Dec 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EMaPJqdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8531AA1E6
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635938; cv=none; b=OrXSkeUmQ5dUhsq49CSgV+HEguzwYrfrSNmAoHSbBDAoYBg7rJpdQPvYO+yiKwCbgW8uChMcOf/6HryezVvrUTVrYeomposeAOv/oND5n7BNPbumfM8VlKXEQnQzwYHKa4xwsKMrNcvKbAEXyGkwtrpDcLBjZlp/r/sULkirFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635938; c=relaxed/simple;
	bh=DbIBhouzPkeaVD6z2aSIgR0InD8Bm6yffeg767P4hOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYLSHqDIk5jiLLZECRu7hd340OPX8vRWIw7j3f6yPp6+4g9izmGwsVJ9n6X0zNea6KzGgAExY5KeVcJxzEsFKImohU9qxRBX7gkTk5oCHnzyVzQITVLKwdyEAnSgvnLqaivYJnZkEqiukAJdcmacHBHGUFv4xIsdLk1bThRAfV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EMaPJqdQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e44654ae3so168836266b.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734635935; x=1735240735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzC4w2tF/UstaaZEQKzuv4EYSuPpu28tra0J9EOi4nU=;
        b=EMaPJqdQN+GSjvyyZpjYQ+q/1JiqE4UpDJFwO2JCTshnVe+Jrm6Q2cE7+jzLGN5QuK
         NFQQhIe4SHnQhhzLG0Cf4TJkjiT7PrQO9OJfRh/RrL7+qjfbVFIeKEGEpP7n9ubggoo1
         A5dicE4yZLPH2bd+r1S4uQC6cjZTSy+JJmMg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635935; x=1735240735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzC4w2tF/UstaaZEQKzuv4EYSuPpu28tra0J9EOi4nU=;
        b=jWmISQJYIJW978Ek4INTC3X8Alh28uZEMj8073An+R99HQR+LI03QAuT1v3SyLoPUq
         VDxHnvkC9PP5whxGTznrEQQOszyj1+4m8xN6f4DnmLcjEytmI+9V4UDEawp0OtTaO7Lc
         7g6kDb7lPttaASfsHQ4GLW1j/wjxgSpD1qX49EZfWLnpcjeDYqgMPAd4QALOq062IZGm
         o7Dc1qDBATz3h0wJqKIYsRZAcYLV8HYcfNrtto3a+b2bHWlB+a0+G1ds0WXU1uvNIdiP
         b4ARXf8uu9DIqu3Oqcv2Iibv6QkkeQPrN/yh/id2/FXx3pL23i/7Q/jZk/DnNlkrnRVD
         Loiw==
X-Forwarded-Encrypted: i=1; AJvYcCW5NoVAyjR2ukKoz1zAsBwPDwRoL8g6Kry6aD5O5wZ8UCOXjWahiQumtVxOM/MdA2fU9f5Tqvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+zUo/cgNbYKOBEt7oJ8SS0hIgSMPeaiOnkJKJwhX5vFx3T/4
	AKaFa5UxQlrwguUrGSK7vwzx1DgpQYQdvHIhwwGE3qG+BbwSCtKfhjHaxrFAmD2jogrRvS1z0p1
	PTAQ1QOt+AL9EYndQhXPPFqvW/kxrs+A5V7dl
X-Gm-Gg: ASbGncudGIoFHsoUY2BARIkEpBfK0d6wrh0qGwmN26wK6xLxwSr/K08evgu2M+up4NJ
	3UJ2ozhzU7yPmueOrftobRTJMlUzKu/69UEPGF14=
X-Google-Smtp-Source: AGHT+IHw0vhBrWGPHlQI0KhhmcxrgbBaLTfKOKabUK8YUtueekL2ioFdXepc7OX1bQzH771b0CT/z9MHTGZ9pqh2RLM=
X-Received: by 2002:a17:907:3e8c:b0:aa6:1c6a:30a1 with SMTP id
 a640c23a62f3a-aabf47a0c1amr867963266b.32.1734635934638; Thu, 19 Dec 2024
 11:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
 <20241217182620.2454075-6-michael.chan@broadcom.com> <20241218191346.5c974cb5@kernel.org>
 <CACKFLimq7juLHbEs9gbuzRm7mFGvD62RsgrXdxr-fmj5e+zBbw@mail.gmail.com>
 <20241219065953.73e08f77@kernel.org> <CACKFLi=xTy+tohqOVM1wek5Qxf8b5JrLhXAHmbobitxZF=rGmA@mail.gmail.com>
In-Reply-To: <CACKFLi=xTy+tohqOVM1wek5Qxf8b5JrLhXAHmbobitxZF=rGmA@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 19 Dec 2024 11:18:42 -0800
Message-ID: <CACKFLi=cjSA3kC-9tZTGwKzumC5JAZ-+50=iLyro4pgeQ5SfHA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_en: Skip reading PXP registers
 during ethtool -d if unsupported
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bafab40629a46672"

--000000000000bafab40629a46672
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:53=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Thu, Dec 19, 2024 at 6:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 18 Dec 2024 22:57:09 -0800 Michael Chan wrote:
> > > The existing bnxt.c in userspace since 2020 always assumes that the
> > > beginning part always contains the PXP register block regardless of
> > > regs->version as long as the register length >=3D the length of the
> > > register block.  I guess we didn't anticipate that this PXP block
> > > would ever be changed or FW would disallow reading it.
> >
> > So if you bumped the version the existing userspace wouldn't care but
> > then you _could_ follow up and update user space to ignore these
> > registers when version is 1?
>
> Sure, will do.

Actually, it's not that easy.  We already use version 1 to indicate
that there are PCIe stats following the PXP registers.  To make this
work, version will have to be used as flags.

Userspace bnxt.c can detect valid PXP registers in a different way.
If certain non-zero PXP registers are returned as zeros, we know the
PXP register block is not valid and can skip displaying it.

--000000000000bafab40629a46672
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIf/n46UPry6y4LW+1dTt/iVCff7sA5t
szXAznBrkvEQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIx
OTE5MTg1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAUgbBQcpb8qSON5cw01p/RH7pv9kcDVPx3uNnmYdEQJuM5Iwmy
S9hq58VAuYkr4Z37//yRBs5hdKHgGN9EvQkQOOb0B9L6A4N87ggLCh+CFs1ztSdBRTj35qEiYcy2
XdnEqU7Hs/du8nm1e9+MsnVvv435xBP+gjOTOjgG8cVc38cykYx2cZKh6EjQb9R7Rpx/jhc1o/us
eak5xS2im+58iNewxSbuhKQLdCqiya1581qKtkC+skAsniAFkbi77C5P7LYEF8iDjGkGOXm2p9f1
H8HrFqylq48TvOWglCLr8115PjnYg9puAH5vYsq6GVVeMV1PVmcUisaIJxnSLPb1
--000000000000bafab40629a46672--

