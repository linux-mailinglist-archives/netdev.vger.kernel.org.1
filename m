Return-Path: <netdev+bounces-159614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504ECA1604A
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 06:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481C9162AED
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 05:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286631F5FA;
	Sun, 19 Jan 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e6d8tUlO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF610F9
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737263668; cv=none; b=B0xhtINCKeK9+IN9vSckcPL8m4ZzAoKmgeMGlQl4Adymz0czzYy/yHxcSOMHDm1ntC8ZYpY8xc4UwYv/TQw/U/lMXP7xTT3tKT8pgtzUs9oR0vcSYvpxuzi1v3adIRWxgNKYCaf/2nHohxaKx1I9fcTKLDLgm/X4D3JslMt4rgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737263668; c=relaxed/simple;
	bh=n8Cs/m9Npt6kWEzUJ3m2TOhJ3iH8Y9J3i5YIF32wQYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukPIxuIJcxzrh1+fuyC96TWSWQIVsJT8jDneeCgzi3I3zt80SS96y2slfetWCCabg9AbBNSTmg4Rmg6cJ6FD4186Aq/dHDF8V+lxltzF7Pd67jBPNM5FKrZePGjkt8HheyqdGXNgYCgVdkm9CaEAPZ4FUuf7T4SiLFOaapdb+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e6d8tUlO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so6573158a12.3
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 21:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737263664; x=1737868464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=csOJUWTIYPkEm97B8IOj54DVFqdEGAlFBA+MOBRtzQk=;
        b=e6d8tUlOr0ET4mS1ntRlBxG0vMH/PikPermz6xnszVzgAgKZDbmAVgPRNJZobBQRVy
         yG/QV2JgBbAAL4QXdZL0y1gnlN8xqGrq88dQ601JjnRnmYbTrSvRVm/gKCY3AKWGkITr
         X/SncDU3e4aL/c/URAWAFxBxayaz1ANYo+CtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737263664; x=1737868464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csOJUWTIYPkEm97B8IOj54DVFqdEGAlFBA+MOBRtzQk=;
        b=Fcs5TnHG9Tg9mZuBmhAMQg0tINTkbd19D97a56MXq6N8V+xTkpZgyis+9PNf3Youy1
         2Rl0hFSxYMI1VkrT/hb0rwUkXD/sVzdecE2CMhcr/sD8SprEdOKgiD5FOpZCH+GZjkra
         8zLg0Tgo6CKds9LLbPJFHYodPW36ZUl4pS8w/xyYOPdcN2RvjhcXmH310JBekaepdIBd
         oUmukaCzOJzA6Dnw4L0yhLdjLe96kJucLLePezglYvBDekj3Gl8wraph/ScxC3HVMXsh
         FiK2NPHoZQEEt9Oe87y1MEZUU909OoSPX9irMj1DF1XMjFwsRkLxy6jYi1S01mHXXgOc
         oNhA==
X-Forwarded-Encrypted: i=1; AJvYcCU2mWfxBZ3XsQodpH2wKZsr0dDKmT6Y7Xp3Ggi0u+CkX2rg/nNchu82Ol73LNuykAdmSxGJETc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymLcXlg7M58mSDWjUGbIAteb7t3zUkAXNlefJJFisywGnbPo/i
	iuCzvLiXHCwFmM51PAtX7QyBzEZ/p69skndFFes7vZfAIH3BvkU9Dz5ZXAoTiFSqmgctOJVlGIm
	GxJWSEMdAljZxwbzkgGa86g8VfAMB1S2ZLl1d
X-Gm-Gg: ASbGncuEEqLGZLanCBJU0vA6kUrSTYwB+jkLDZlNazXVgxq7riLtkQzimjvnBzs20UP
	STPRTokg0iyKVHU/aHl5doTNykN/cuZk1v8UqlymCeue7ONl+Ag==
X-Google-Smtp-Source: AGHT+IFcPp9vFYO4IJU4/0f/k5vQ6LfM4+MNeo6GYImvC27Cda6RMlLFSyqIleyjtCX+WMc3YtcuAs4giSUvT1/g3mM=
X-Received: by 2002:a05:6402:13d1:b0:5d1:2377:5ae2 with SMTP id
 4fb4d7f45d1cf-5db7d2e8fecmr6795909a12.7.1737263664452; Sat, 18 Jan 2025
 21:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119020518.1962249-1-kuba@kernel.org>
In-Reply-To: <20250119020518.1962249-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 18 Jan 2025 21:14:12 -0800
X-Gm-Features: AbW1kva5nxTt9VF88pAyfgSSBqYYa62HYODxRubC1Sar-7T2xvAQVRSfhxqSe0M
Message-ID: <CACKFLi=XNv5wA6J-5mqk1uVmiCLgg4s+4j7Nk9_eDsZYLErGNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: fixes for HDS threshold
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, ap420073@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009f3bb0062c0837d6"

--0000000000009f3bb0062c0837d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 6:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Quick follow up on the HDS threshold work, since the merge window
> is upon us.
>
> Fix the bnxt implementation to apply the settings right away,
> because we update the parameters _after_ configuring HW user
> needed to reconfig the device twice to get the settings to stick.
>
> For this I took the liberty of moving the config to a separate
> struct. This follows my original thinking for the queue API.
> It should also fit more neatly into how many drivers which
> support safe config update operate. Drivers can allocate
> new objects using the "pending" struct.
>
> netdevsim:
>
>   KTAP version 1
>   1..7
>   ok 1 hds.get_hds
>   ok 2 hds.get_hds_thresh
>   ok 3 hds.set_hds_disable
>   ok 4 hds.set_hds_enable
>   ok 5 hds.set_hds_thresh_zero
>   ok 6 hds.set_hds_thresh_max
>   ok 7 hds.set_hds_thresh_gt
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> bnxt:
>
>   KTAP version 1
>   1..7
>   ok 1 hds.get_hds
>   ok 2 hds.get_hds_thresh
>   ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the d=
evice
>   ok 4 hds.set_hds_enable
>   ok 5 hds.set_hds_thresh_zero
>   ok 6 hds.set_hds_thresh_max
>   ok 7 hds.set_hds_thresh_gt
>   # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:1 error:0
>
> v2:
>  - make sure we always manipulate cfg_pending under rtnl_lock
>  - split patch 2 into 2+3 for ease of review
> v1: https://lore.kernel.org/20250117194815.1514410-1-kuba@kernel.org

For the series,
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000009f3bb0062c0837d6
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAB2aWejCXSX+mJXyIOVUG+/16f+D+Wg
QX/WZZLzY+RLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEx
OTA1MTQyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAg0hW4QXDvbM1rvYQK+y/MhZjJU4vA5PooeTMBVDqH3lGypfd2
ziBO3nNwrZr0i+VQiaxNWqTwewd2gl3Ak8fjaK+VlFSIC9bQ7pPpDvvmN1epr+RV8uUtktZoUrwE
VVHaPlBu4zZOc01D47cB7UtkNBwK+rXnDY/e0BXF9RWF5XOhNy1nOyXBILpynQZcXxr3YojBKcl+
i/h5cptaMcSIUdqs/y0w6u4xjtglaetnAdIqtWSeZUBSnV9P0+9qXWnuGCwkVqAguANremlPjr5c
O4aPO4NWnCF9gSS481Lp0DaSWzX/SMDUsb1G9cwefA+Pt3wGUyD0Onh5tkz7mFn/
--0000000000009f3bb0062c0837d6--

