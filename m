Return-Path: <netdev+bounces-161550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB6A22419
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 19:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA277A1FB0
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868A1E04BD;
	Wed, 29 Jan 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cAH0NdeQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8A18FDC5
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176144; cv=none; b=X6pbGQ25okrcT6B4gvJyWndBU0PiCLlRJfgfL04B4w8SXLohhCLnEz477DPIPAkfdPluVt1OwELfOf2pw9k5npYrTWjWDaFVmmV4qm9zAchqSHttzxq4y3FukDNVtdAIK481iiXL5su8e80xBmKeXiJDsyCye91+ghCcW5DJJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176144; c=relaxed/simple;
	bh=N4koXEDVJX4u7gMv+QO5mI+P58Bs4HhHntv7hILs/yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNs4xtuC67z6Zjxw/5RJ7zAWkZHybfyniy8RcLz6MmY+TjvVFXOi2nfXvyknoJKSnZVj4xH2NI+e7GL8Ou5X+Mc+jnSyg5etn0frLk96gwSbi65tTZgVzakfTp00nlwLJ7oz5lWtLeDwjSSeEjKAff2Z12nY4gOj4+77wKC1NMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cAH0NdeQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso14090538a12.3
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738176141; x=1738780941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MUUcShDgslbY9kB3UNtBEr+cRzaSyqc7Uzrfp1h9/aU=;
        b=cAH0NdeQfpUa1MaF61FOl9gSMJyFLJKwHYWiHWfMio0WjiAbd1qIOHMkOVPc00Cpje
         ESuM7/pODEDNyoNbK+s5gVY+NAP0yiulwjoDV5OkBu4xUVtqA1vTosBKikVyt2+nxii9
         9WQcQnG47g2UNWHHrVuZh1OCJ7zLwrx84eLGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176141; x=1738780941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUUcShDgslbY9kB3UNtBEr+cRzaSyqc7Uzrfp1h9/aU=;
        b=bvcqJQscxk2tXNR7tJ8p14/WdwS649Uy7UL+dIrBMxbZXgOc9M1a5HIXllfAAFYKMy
         bWxNtlwzSPWZ2hpD02rsoE14TAZPk7suP9DRoO9axJ/9eeRh/RB/7stTkeL2T/oLng7K
         Cg9n+iNokbmChb6Mjq4GVqKpL7GzTxX62oJaRVgGkPTIulpwsAn3Qu6msJQpbmtjbwJt
         0WPpjVmdGLPuTgUEhUXnbWAExc/Sq2VyDj6PwA/wtwQ+Ns8CTR52903XpRb400XxWl3w
         ofIQsjTAaTp6xepgkgkPbqn7WgcE7SFiRQzaLJT5Th6d514fO3yajymmMrBVrmRJ36Ta
         Cjuw==
X-Forwarded-Encrypted: i=1; AJvYcCWd371gNQOVdKOyNGHhscNyiB9m7+KUAPMov87Y2RbWYNvqA5LxMN9ziFMTuPOL7ayrH4XFnzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN86fYvYayjfXlyR86vv4S/KAM+8WqdXQGMzqdg3+QsBPckFKe
	mfLXfnOOFvHFhEMCl8CEdvUNpRV4NlsrOFAObrsQcd8hna9/WVPL/fWAEroctni72/ZtzcfgUVJ
	vPv4/+RxMktfnJRPK+q+taEjFhs//axHTzGoB
X-Gm-Gg: ASbGncsnlyplztNbr08ftIKm+nnKRoFOf3v5XzWgPpBtl36BXMrCpPa8INv82mnD3qK
	0oH0dxwD7ingt6JFMGQjeICpSR1KWXS3IVVOKVhS6RH/Rx7PRp1ga6+y4dKjuesjINA247UAI+g
	==
X-Google-Smtp-Source: AGHT+IEJm4CnwXZ86fNgpCnY0OF8ubS4/YXovD+J4zuMAVV6DAlJ2nZ4YLRYappoIqh9vM86Jm/tppsJHxzfTXcwvGE=
X-Received: by 2002:a05:6402:34d2:b0:5d9:82bc:ad06 with SMTP id
 4fb4d7f45d1cf-5dc5efb83e9mr4507952a12.3.1738176141201; Wed, 29 Jan 2025
 10:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117-frisky-macho-bustard-e92632@leitao> <CACKFLik4bdefMtUe_CjKcQuekadPj+kqExUnNrim2qiyyhG-QQ@mail.gmail.com>
 <20250129-quiet-ermine-of-growth-0ee6b6@leitao>
In-Reply-To: <20250129-quiet-ermine-of-growth-0ee6b6@leitao>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 29 Jan 2025 10:42:10 -0800
X-Gm-Features: AWEUYZnb7TvkjcJhc2cCXc3V9KZybfSPry0G2PjWIBpxwE5kK_HJQUiw-v54muo
Message-ID: <CACKFLikOO=kDKpLrntgvvc4AOpk9bvps29mu4T4x+C6a3e=hhw@mail.gmail.com>
Subject: Re: bnxt_en: NETDEV WATCHDOG in 6.13-rc7
To: Breno Leitao <leitao@debian.org>
Cc: pavan.chebbi@broadcom.com, netdev@vger.kernel.org, kuba@kernel.org, 
	kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000791d60062cdcabd6"

--000000000000791d60062cdcabd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 9:12=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
> On Fri, Jan 17, 2025 at 09:44:12AM -0800, Michael Chan wrote:
> > On Fri, Jan 17, 2025 at 4:08=E2=80=AFAM Breno Leitao <leitao@debian.org=
> wrote:
> > > Full log at https://pastebin.com/4pWmaayt
> > >
> >
> > I will take a closer look at the full log today.  Thanks.
>
> Thanks. Have you had a chance to look at it?
>
> Do you suggest anything I can do on my side to get more data?
>

Sorry for the delay.  The device is 57452 which is Stratus.  The dmesg
shows that you have 9 channels and all 9 channels failed the ring free
operations for all the associated rings (TX, RX, RX AGG) during TX
timeout reset.  And this fails repeatedly for every timeout.

Let me ask the lab to set up a Stratus system and try to reproduce the
issue.  I think that's the best way to move forward.  I will get back
to you when I have some updates.  Thanks.

--000000000000791d60062cdcabd6
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIODI4LQjdHvbGZGvNmDrfGLnrHzjxQHk
rRfpiJcrmMO6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEy
OTE4NDIyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBJJZnt89hkFkt3ZYm0bg6QopgWJkIq5y7N9vvyd/Pk/yxtNqzl
ZfhX4emTy1OyU6GSY6OPi7d+jVWMSoNnzEru0D14O+jw8ebuWI1bDJa2V+FvXUyESso2upf5oYG7
dKzQbPcBXzKq+dd6Lyd56nRf0Hq2nuDnmHnNC67oWOOQpy605vP4LwBsCPP2Tp3FBZIMI1p2H4ZR
QELk+BQqUjCW/umx8rp8846z3b9OgG35I/ZYHPpoBGZwNQZMcakHs5ERnrpDASdBeomN75Pu6C41
NjrCNrw68bfYaIoWjy4sJUco/B38VkWQcVpuo6QwkY+aPwcI8AljA/mRx7YuT2o8
--000000000000791d60062cdcabd6--

