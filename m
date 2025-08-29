Return-Path: <netdev+bounces-218094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E9B3B13D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 04:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF0B5E58FD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4522157E;
	Fri, 29 Aug 2025 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="II3vDJLI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B712206B8
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436112; cv=none; b=fN0xeGFbx0Wq61BOu0SP5JEDDXPSyVzsRgGMpqZSKIfTneqzr/afrsvPqKaUR58+oD5LRuMmUdVdksAloWZn0DI2DLTRWYzzPtbaC7xbGBFPc8t5KRKFcbDHCp/TCE1LZLiyCYq12FS8EYaigHboMhbXyz0vgADaFS0LgayvIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436112; c=relaxed/simple;
	bh=ELWKVdC+tpZYqRhQPlAMfCNEoh9/N8QqMuEQJA84B4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrybbYb0mmC1LIJMVp1iAMiWVoh8/tosP4rKLFI8CAzGuOcfAcKwBXx/iiUP9U2jxIlGu8w7MJWr6vLAx7lBha8nlBhOw+sC9T+c/h7nBUyEzLXLlH7iwuBK1nTFvoc0R/LD+pisINExp+G+umxLnjZ5l/YC/zrWw5ras761i0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=II3vDJLI; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-327705d0a9bso1502946a91.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436110; x=1757040910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVcaHpQt1z/2C9MgSvfoLkxSoOKFcOVtFe94gXMq03M=;
        b=naqIo/dEmULT21UegNlmbCfbKBsh/7NeYsw15NpBkkqCGWX0IJe+euiamCt+FEZuQB
         t511imyF4xx3mJFWBGh51XrPadr7PaVdqcNqMpF7iZbsixKgi2YRAsfdwLi4n1kVeCJ+
         VM8mrQbUQMQn+tMjZkLilCc3BHcH+EaLvA345g5goeYbm21Xib5btix+xXW0wm0x4LEx
         iUbGiDu7aTtr5oR30jDbpt1k6lnFN6eMJWN7tzAKrMXeXLmkaaqq+XsAipwldQcqbSpg
         vf6g/UuL1jxsybQKFre4UF1ipTs08E8bJYyRo2VY3nicIJEzPrh1tQ4UezBHabH6FKTn
         BNSw==
X-Forwarded-Encrypted: i=1; AJvYcCXX2cxfXMTScDvuhg85FBqVMPbiY8Px4KW/lIZHvujPd7wSeDQLvyVryauI9Vk79cnxSX+RI50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0SVWERWP0UgpdxN/fy0+Rf43AWcQN9OZxWC5EbQr3kxkpYU7
	RV+bc152NIwYHVCQAJlxBn0lBCeVZT2y/JBwBNi4zu6M3M9+tWEWOT+ptNvx1j2eyKLmAjErWjl
	dWKywhkGg1Tt9TAkalAiopPdpmjWskN+dEy7rVGTncZ/OHKQjM1cGJJkCzpHOtdCoOM5it4iGfq
	s+uOI4yxbesQKcPlju8+pcD5rO6LytQ/4VBb29EcfgY2iTcIQIf6yqs5VRKyN6S2Wr6Fr7wgos3
	gETaEdGS1We
X-Gm-Gg: ASbGnctNsYDTGEJ49A3LF2OoqefHw2vd5P1S0JgGfxVECFlGUT1T4jVVwua1oYIpjEL
	RFyEFLlUPnsw1fefQ85uS+d6K6wMXoNvg6lykZIT0Duks+OQR8JNeHBWa/fNfhB1ct2quMe8AYO
	6df9wsMMCSc1o+kDVF0wSERorQjFSslSrxCYuzsmeJqCs39v7Wujkg+u6g+rdXx0U8QSXFst1yh
	7Y+zRHXar+faQwIteDjXWZkySvFDKjB4vzLkPWkj9lZ1pyN0dK6VMxZBMAx8NgkCMmAT4rR/U9j
	tWn6g/I2ZJpY6j89mm1FnUWjUEY2FrTvzsW/VHsIbS5S0ubB8T9XUhGQxeQz+k9qggZVcLJxybo
	/PkzySHtQ/pCJbqe4xSjB6tPTQU1xTcSE+XyUa+Jlyeqe87F0nAsi453KaUvfhWMrN3W/LVpJ7d
	9HU1Y=
X-Google-Smtp-Source: AGHT+IHk65r0vsktnXNeQmvGeTbQ/n1n2kqsLbdgD8UclNI/lBk/fjinGMWQqjQUQ2KOT6lNkFhbAl6VD+sP
X-Received: by 2002:a17:90b:2c86:b0:327:96dd:628f with SMTP id 98e67ed59e1d1-32796dd64f9mr7498834a91.28.1756436110171;
        Thu, 28 Aug 2025 19:55:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4ccd34d7bbsm87549a12.0.2025.08.28.19.55.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 19:55:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-540aad044edso658839e0c.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756436109; x=1757040909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVcaHpQt1z/2C9MgSvfoLkxSoOKFcOVtFe94gXMq03M=;
        b=II3vDJLIgav15gjMGJNHgNt6ISesG8uoa5LLyKsijNyBajv6Q221gJvqUTA7qB6UD1
         p7ecyTb2fHPqKT0jPu4euP7nQ3WDRjTe1C1MWJRVvVV7HisFMGL+dnAMLhIxzRRzWziL
         EGLJw7vdPY/MRmwg+O2KJb7M6+kRqKWXHR1ic=
X-Forwarded-Encrypted: i=1; AJvYcCVjfpO/Y+xaghhR/M9Xdagk63VP3Oie1peJ98TzX3te1vCyvhlP3rz3UAeXmh2Oee6hRLsJxzQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3e8a:b0:4f6:25fd:7ed3 with SMTP id ada2fe7eead31-51d0ecbfb1cmr7830691137.22.1756436109014;
        Thu, 28 Aug 2025 19:55:09 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8a:b0:4f6:25fd:7ed3 with SMTP id
 ada2fe7eead31-51d0ecbfb1cmr7830687137.22.1756436108673; Thu, 28 Aug 2025
 19:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828194856.720112-1-alok.a.tiwari@oracle.com> <CACKFLimOb++PxzBSZcLHP1GQP0wk+hK0XAoXti7DMLtRw4JQAw@mail.gmail.com>
In-Reply-To: <CACKFLimOb++PxzBSZcLHP1GQP0wk+hK0XAoXti7DMLtRw4JQAw@mail.gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Fri, 29 Aug 2025 08:24:55 +0530
X-Gm-Features: Ac12FXzDPD-rb6RKBUBKQ3TH-isgyvXut0XAzV1NSP4mqqvbC75l5Nc6SBlzBtw
Message-ID: <CAOBf=mt4NovRDJHbU_e7XQvvYvDtvLdJmkLDsWhQCKrQ1=jZ-w@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: fix incorrect page count in RX aggr
 ring log
To: Michael Chan <michael.chan@broadcom.com>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005d21ad063d7826c1"

--0000000000005d21ad063d7826c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 6:01=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Thu, Aug 28, 2025 at 12:49=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracl=
e.com> wrote:
> >
> > The warning in bnxt_alloc_one_rx_ring_netmem() reports the number
> > of pages allocated for the RX aggregation ring. However, it
> > mistakenly used bp->rx_ring_size instead of bp->rx_agg_ring_size,
> > leading to confusing or misleading log output.
> >
> > Use the correct bp->rx_agg_ring_size value to fix this.
> >
> > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>
> Please add the Fixes tag since this is a bug fix.  Thanks.

--0000000000005d21ad063d7826c1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEslbdplN9DJkREEKpwgyrGTOaf0
0JkomywlV3+Yn5s5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDgyOTAyNTUwOVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAGc2xLu7k+BN1GDYiFByva/mgMiPa8jflBkFN3wdy7SRO0kC7pXuYA0WFu/XyrTi
F3+FnJvI1mQeeLAD2l+rGlnJrP4/N0s7bi9/i2bpNuZhd5XG2vJycjFCenBkWSOcYMBCQnqEDfvP
9rKZQ3iGsdl7RjurBxOyJTRpERCedTEu/h2cHwCmYz0CGhoRuPG7FZTVm3MvYSo1VJanafYiSf3S
fhXDfJBoOLXlcZQnWGP/+7TWgYJZhgm+EobmX8tvFTmRhlbs6pMkBM4ECF0SV+5dn6W/PTGdlB0D
2o9crCalnMKN3+PldNnX3VpONLShPlcwCm52dsQbSbRe/oITPqg=
--0000000000005d21ad063d7826c1--

