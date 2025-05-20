Return-Path: <netdev+bounces-191996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C0ABE264
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 20:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E581BA6806
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C8280306;
	Tue, 20 May 2025 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ERXI1VxD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AE1E25EB
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764920; cv=none; b=BgCFEesIR7SoPeDITC7zrQrGX1oXta6E8hpBqwlSdCWi2svL+2Ss5DJYNIAoHx0GJYisiNJFiQs2vtOn73A2WpW6BZUw5nXizTGhs1QsEoqVEu25HOggX1bO8p8k02ehqfEEP4wwglZYVopSBeS2zG7V8Z+T6UT8gKsMyfm+uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764920; c=relaxed/simple;
	bh=Bk+RJCAA4vzZ3ZrFSarf4rmyiVEUR6q6FEuGqEjvPjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FClzJu9/QXG2bLMIZE1nXPiX8FZFB5MbbolvG/X8/Kj4QUOMsBtXuo9Uq73ls1Pcsq22CaO/VKBCqyfrxhh/mMpF4R9nx798sccUeXoGtlzt2XgJFqVwTLP0tldBBfoNt6iV4JPc2Ju0ppsBTZu6Z6IURlZLGeVnSwj8AvlpInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ERXI1VxD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad56e993ae9so482228966b.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747764916; x=1748369716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk+RJCAA4vzZ3ZrFSarf4rmyiVEUR6q6FEuGqEjvPjM=;
        b=ERXI1VxD/G2PfXYQ3QXEvSdTe7XsYrW2bKo2MlVYlFp6rK6eeLOBZlC1rxu+cShyYY
         /TGWlX+SAV8ekhp5QzpFdDhlIPu21fpkxjZSvwpXommpmOt97RcOfYAvIoZzq6E+pgdX
         3D9HSmRC6N1QhOi0FWwYrbZnh94Eyh4G02LoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747764916; x=1748369716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk+RJCAA4vzZ3ZrFSarf4rmyiVEUR6q6FEuGqEjvPjM=;
        b=UTVaPfpwN8+fAsZWzk7b4RjbDGp4gq6UQajUDl13kuxNCLe4VfA+6eTCnnu298h2Z3
         M1gOWffItoXukHa9Pqt6hHkxqwGXVQ2UGOWvdDr+ypKyOyBdZGCFFRvbSTzJGgtIIUuC
         lnTwBgX7kQkMMALJbvU7XQSrPu/BKh5U4qzEyUA/+6fVoTTce9svC8j7E72easnHfI55
         9x8qsT7oDji8ckJH/pgo5vWBOOXrgB3XYj77fQ6lOirNJHlrvwKOox7HVoW833scauUN
         EkCM3TfSBVZSlEomjxv0KaYQRAiWZ6CT5ZBsdp6qNzpvL+641YwXd33tMV6eMFmTEdqM
         GpGg==
X-Forwarded-Encrypted: i=1; AJvYcCWBm6w4VKQ1/w1GcQ1i1lolmzkB9om0MiLsx22AwkZ/30gwl/BdVxqAiEI+wSkjG8s00WnuRqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnF3BU5kFudU5WgcFo0Ka1eniqmeWcI3f36PVyYVfUF0+cR7S9
	VWInB1QQinAIzNGGtFDoeeYT4oBtWSto8109mWXcE8HdWgS3ky6iNE5zTJdQSd1C5XIwuFz9sLd
	iJIdZ70UO7FBRA0EenLnO5OY802YdbRlZXyIRWYDG
X-Gm-Gg: ASbGncs0BN5sECt0IsWbu39rYhgqZrjjdtCk8bDn1oVdhU9BLW4LNYgSVhl8jiWAz5u
	oil0xm6gt8hD8nn0ZZV/wuSQoBw91XjRBKksnLDq+O+lcZA9vXpXELUBct6mjwG0fbINhTabTOv
	C4r6MJNcv38QQwWzBAMofrT5cTCHAvhi10kA==
X-Google-Smtp-Source: AGHT+IH2vPwJz0sjM3C3YxrR93NrEDGYZaDSkItPACV0OvjxE5jvyshItlpPZG+ubzTI4L4eAqrEu2ipor8Wnjfy3i0=
X-Received: by 2002:a17:907:d0c:b0:ad2:24e5:27c9 with SMTP id
 a640c23a62f3a-ad536dce79fmr1364806066b.44.1747764915563; Tue, 20 May 2025
 11:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520071155.2462843-1-ap420073@gmail.com>
In-Reply-To: <20250520071155.2462843-1-ap420073@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 20 May 2025 11:15:03 -0700
X-Gm-Features: AX0GCFvmrHawgYSQUasyIb42hosa50fYd6YYiZTO5ev6CSOnKU8LrPFCfslqR6U
Message-ID: <CACKFLinam==HdSB1KHRitGByAXNGW9awmfyu_jRasjA-qKmCHQ@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: fix deadlock when xdp is attached or detached
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, jdamato@fastly.com, martin.lau@kernel.org, 
	hramamurthy@google.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f831640635953a6a"

--000000000000f831640635953a6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:12=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> When xdp is attached or detached, dev->ndo_bpf() is called by
> do_setlink(), and it acquires netdev_lock() if needed.
> Unlike other drivers, the bnxt driver is protected by netdev_lock while
> xdp is attached/detached because it sets dev->request_ops_lock to true.
>
> So, the bnxt_xdp(), that is callback of ->ndo_bpf should not acquire
> netdev_lock().
> But the xdp_features_{set | clear}_redirect_target() was changed to
> acquire netdev_lock() internally.
> It causes a deadlock.
> To fix this problem, bnxt driver should use
> xdp_features_{set | clear}_redirect_target_locked() instead.

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000f831640635953a6a
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBE+Am21F3VsHugPWez2fjoP5VyiXFJi
EYuLSzr1Vv0/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUy
MDE4MTUxNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBADhxNXp59w/i2XVk7J+gfn7a6sPFfP9cwx9HR1/U9Q3z9u+TN2GJdVCitQtODrqTjuKl
THMg9wEgyu8evwzNU0x9/jFx/DBMleJOogQpxVtClWwDaZ0dyDynpQaCacrTnSguI9ARXgpOFZxu
UZLg1FhQ9HRMSB7gfEb/dN1QYmJ5rk9MCrJ2PMg/m8uEelWAzrGvqTZigd6QQ6ot3sAiYLs5e5MG
iaSvqxfJ5Ne0fiPy0hNnQIYAn5BuZC0WpSeK1A0dDPvUY8Ii77z1SUpursoFEyDf80eSsFCwBsLD
VY7zTdA2KbgoAggAT9AkYvE4bJXhLhXgkP2lhyicI9kHwcc=
--000000000000f831640635953a6a--

