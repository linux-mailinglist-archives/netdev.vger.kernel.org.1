Return-Path: <netdev+bounces-152412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6859F3DBD
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58E9163ACA
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6F1D5CD9;
	Mon, 16 Dec 2024 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XMYU+o6I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3041CDFD3
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389301; cv=none; b=LqTRWHBy1MTXOQQhChSgA4/hh68kXN8UzoIW1amNGGnM2IGyfJ6rgeQphC3mBZX83wNJAwfLvzXJzXzbRFTpsl+dB3zlCDr0vjJkB+IUTe/X2Ji9E7HBG+ZvH1CJS6hjTwaXp95KUbbMpzjcYrClrioaiV3MyPfqczQrjnmbjzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389301; c=relaxed/simple;
	bh=JKURWtaLPmCmLFx3AwoXAoMOQkQl7bMWEcvkXmwvEWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBqyeaN7hwTXal86ilgb4Ipu+PTINBSArvnqZ9DeZk8tnWMYSIgt6OuroQlI/k4PyrsnBCXEJegSwPz2BYDi2PGYbbUOucu+bj8wstczSdQuqqX2Tro/mfDrohUDBMwxHDdJa3Nhz59UsGHsjqIx2wnfg/ZNFvqQ5+IpITfieMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XMYU+o6I; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso8323665a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734389298; x=1734994098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy3wVQNABJHiPmaARAkv6/PzNckXXZBuTvJIMc4muiY=;
        b=XMYU+o6IavKrY7aQGU6agAOSue4ERvcBV9JL0lSEyjZ5TlX1klUoqUm/jOIC159Lsi
         g662HPWB1xNXe9rZ8IyzmIJIzqjvtvEc9J4qKtHhjvByhd9T7868+cxtEbo3jA1an1yp
         K2BKFMflJP62+fgWyfjdeAsl3craiLgjjwcw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734389298; x=1734994098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xy3wVQNABJHiPmaARAkv6/PzNckXXZBuTvJIMc4muiY=;
        b=agROLJJqbyxxgMXtj1pf2BIYpggy1Wwa2WQJB6WAZy7QH5WJ5DestuHdR72gWa40sy
         tN1g1tmrvcb24/5sqdFRiiI/xO/fIMCrxO8lbMZiPYwumnntaiprh0JITK5MyPII4rMF
         D/8r1iAHpJPzdKKH535U3zx6wrLOMvQGBRzmwDI/ELhzayjlWdgr1+/fiDxvIJ+4Ahe5
         cu4X65UowZqYI4jyIXuSEGyKWjOVih2VyxWKnzx7cTMjXztHs/9A6j08wosYX+dEnA8b
         SXW2PZeCIllmAKKwnb2S6Oh9apVXWOBEpSVy7x3cOlDRCgvrnxuGILqCaZprPRclh2ip
         pWRg==
X-Forwarded-Encrypted: i=1; AJvYcCXwEDDGmYCiSCtXU7qKbvjOZ1WARGhl+LI/2zK19A/ye+n+e5qokM9bjrBxnCUX8Sl7A7D9jfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpU+4iWRuaXpQYGBdnGPS9ZjokD+qYTfVdAplcHkBfz4dq2qZK
	7ZygFvZqF4GniWB0V79mdfFhNN0hUAs/pnIUpYER/BVAEz570ZdNtQEljVtXcphSy9swFP+mtK+
	tZVjyrGKXYKEvLrkPVm11CZ6jGi2qDCnF4MsN
X-Gm-Gg: ASbGncuJQ8N+WL2HM4lIdQNgAI909LTO0ZJ7CNc+TcZZbeDw/KcTwjUiH1ftTEEfeNP
	GMwHPD+FBqKPLSo8kCg6c+FHswqADYw+Upvrny/E=
X-Google-Smtp-Source: AGHT+IGihIOOTWJd8VDESzq31aMW3PaXMcyiko5Q9GjGIgv1tBkVN5AJwHJ1Hc8nwsNRplKDC3sbRzt453VmQU42kAY=
X-Received: by 2002:a05:6402:34d6:b0:5d6:3716:950e with SMTP id
 4fb4d7f45d1cf-5d7d55979camr820527a12.11.1734389297833; Mon, 16 Dec 2024
 14:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204041022.56512-1-dw@davidwei.uk> <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com> <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
 <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com> <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
 <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com> <2d7f6fe0-9205-4eaf-bc43-dc36b14925a4@davidwei.uk>
In-Reply-To: <2d7f6fe0-9205-4eaf-bc43-dc36b14925a4@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 16 Dec 2024 14:48:06 -0800
Message-ID: <CACKFLim-QG2j6rG6h+_Abwd-tzfQ7_nOunWkeAn==1JoqpT4dg@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API implementation
To: David Wei <dw@davidwei.uk>
Cc: Somnath Kotur <somnath.kotur@broadcom.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	netdev@vger.kernel.org, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000004a0ca06296afa85"

--00000000000004a0ca06296afa85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:41=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-12-11 09:11, Michael Chan wrote:
> > Yeah, I think it makes sense to add napi_disable().  Thanks.
>
> Michael, Som. I can't add napi_disable()/enable() because the NAPI
> instance is shared between the Rx and Tx queues. If I disable a NAPI
> instance, then it affects the corresponding Tx queue because it is not
> quiesced. Only the Rx queue is quiesced indirectly by preventhing the HW
> from receiving packets via the call to bnxt_hwrm_vnic_update().
>
> The other implementation of queue API (gve) will quiesce all queues for
> an individual queue stop/start operation. To call
> napi_disable()/enable() I believe we will need the same thing for bnxt.

Som is working on a set of driver patches to make
queue_stop/queue_start work for the AMD PCIe TPH feature.  He will
have to disable and re-enable the TX queue for TPH to work.  I think
we can just include the napi_disable()/napi_enable() in Som's patches
then.  Thanks.

--00000000000004a0ca06296afa85
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE7dSECCpsFKZ7778+tGi68LlAgre/nq
qXvgCvB8lDZ4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIx
NjIyNDgxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQASNAEDud0j6dLBUTNJNblZSNUMHUquYLwZ+i0k8A+S1JACTBG9
q2GY2aXs966RWEAblgy8ajLpi3fWi6dQHzRtsnOgdWoSidPmRFwaMSG31kFBRNglbv3frBuwpi9e
HHmPkEJ+A3N110uoGeEE7KkqU0Au/dUmXy+mnIsfuuFdOtyIB/eqa73Gv4T1QP0hvXO90AYgB8ch
gXNwRpwoL97TY+TzO/DM1y6LEVCszI5fEN5WbRn8X8mN0FxmbAHEfJRVf29gPG7MeMqGtJSA+RkD
hGcGRheYvXkuL3uq4o882ydWr+dJqo6JyBfxxhajXGiWRUteiPY4YFIr60I6aUya
--00000000000004a0ca06296afa85--

