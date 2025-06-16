Return-Path: <netdev+bounces-198264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6C6ADBBA2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC381887403
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F99205AB6;
	Mon, 16 Jun 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HNxJp6Wz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E31EDA3C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107670; cv=none; b=HwbwDPtgi88EU9RlPPIN20/5XIRjkS8yrIlpnq3PM45pVesg1dargw4YEZx4fSJ+PunpRoZamXULxrwfHIItD+uvLViNLFsBJ9HYod8m+tLBbyUv13ystz1w3E0yqgVWDGm5BijtqDS3Nj9A2ANskRnUegRazZzXVjSJoZlbpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107670; c=relaxed/simple;
	bh=gCeVWgLQMR69h7vHTepn+50aTl9zuA1Isf2nxVfRdKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl/HLR4zMzznEjzFk7Avi+dnJpCsoEg6/W9Od5L8AQ5GakxgjtcP5SpHSK8ocgQahcpBkDbcrVOlTG9cmVUbUiiD4De/B7re/+0sexJxN6+W1zYr2hd8uYrsG5Imgv9d2+YX2RyggaoEpDH/S1KKy2rYBswJbCxN8aBgcUoMnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HNxJp6Wz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad891bb0957so884382966b.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750107667; x=1750712467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XrEoIrsKnmaoS32WPbPAUmClpaV3t0C2lFZZe+/jTXo=;
        b=HNxJp6WzJ8kwz05x3xMXjdnwqJW4jKNWvZYVU48OrBrm9NW2Ve+oJqTiNrqb1K+Itr
         PfUFDyVLue5Ds+L3LaU1GgfMD/OWe5r90odn5vS8dv/eyGnbsr8FDFAIcOWjmh9cYIN5
         wSwH9O+UKXv4WqyG8KFjFLCT7S7pU5EGMoVfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107667; x=1750712467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrEoIrsKnmaoS32WPbPAUmClpaV3t0C2lFZZe+/jTXo=;
        b=Icb3qNSekjHT1v6lEKHVpxPGT1oMe25eVSlEiwmDPANMVIEl+o+i39wkGlA/klKoLj
         5bxTarcRlkUZhw4+9vCgTBqqz0hEJ3LLPA9UPAuQR3BD1JAhEpAbWMtv6epQdfC9D3YO
         sDk2MC27dKHXlbicaVoW3EVU5reyW8H/SBUWk+M4Bx0N9ReGK/VXfzJDIdjjeuYOi1Oz
         2uNkOrCwFowRJ/OvhRPEtytf7nlQXeCkbrUBDBicJJeodZMNWJ/14hjudydPHml0e7y0
         Sozw1ELUGGsSEbJ528QRnOk7Y9ZxbS6wyUO5zmaRqQ8mhVHXkZRayXI56LGnLErEWELI
         uoQg==
X-Forwarded-Encrypted: i=1; AJvYcCVtNhV//47KWecf9yPT7huLoSJU6m8RABI6Qe8rFK++CCQdXMsZGeuT0TqPMeIbOAnnA82ZVOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTgyVO1IUg+WNFD2mYPfPBTJ7ywb4mcHvtBNmYd4EMKM47+lx
	wFCB3M2kVZQMQqVI6JUHDJ/VcCT/EHvetfFaZcIFM1iM4hEqxJ+6b2t+XKjzEu/9ympSzgsA+ui
	XLKDlyBEcNlmg9OkcP3PaLUIUEDh1WzTrbi8OK6dM
X-Gm-Gg: ASbGncv0JC0Hmxwrp3MgAwMG4QXujcdOzbSnBbeDrIV9jH8CMECogqOjxlgztVoGMm9
	tWilGPUUielXg0d95DnbFSp9LPW3gC96Hp+GxYPjcHJ3t+/Ex0+mzZt5UpzDqY8C8eFRg9maxEs
	g4yi39FFBclLrU+iwtqjwn7hDy221MfCZsAP7ky3X1uAZZ
X-Google-Smtp-Source: AGHT+IEtKiWbRcUzHIDF3To+KzT5zsXEHl8bHAkW6O83GZguJeuJVigXEqakcFSHzKSe//y88IU6HaeqeVNp4Jz77M0=
X-Received: by 2002:a17:907:d78a:b0:adb:3509:b459 with SMTP id
 a640c23a62f3a-adfad329678mr1169167766b.19.1750107666954; Mon, 16 Jun 2025
 14:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613231841.377988-1-michael.chan@broadcom.com>
 <20250613231841.377988-4-michael.chan@broadcom.com> <20250616133855.GA6187@horms.kernel.org>
 <CACKFLimACdMBNZ2v-zpJ5=H1JdyWfLjN_0SqXkPe9waacq=GiQ@mail.gmail.com> <20250616134828.703eafe5@kernel.org>
In-Reply-To: <20250616134828.703eafe5@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 16 Jun 2025 14:00:55 -0700
X-Gm-Features: AX0GCFu5S7WIpcQ1vVfC6nQ9-nUlrERHbbj3z7R0PR4eGeU4MvhQoMCcByuq8ZQ
Message-ID: <CACKFLikmNZGCsA7Step=z06VwiFqqwO_dLD6QsmK8f8V6TBabw@mail.gmail.com>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts
 on queue reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d457810637b6b1da"

--000000000000d457810637b6b1da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> I think the phrasing of the commit message could be better, but the fix
> is correct as is. We were shutting down just the main vNIC, now we shut
> down all the vNICs to which the queue belongs.
>
> It's not an "optimization" in the sense of an improvement to status quo,
> IIUC Pavan means that shutting down the vNIC is still not 100% correct
> for single queue reset, but best we can do with current FW.

Correct.  This is the best we can do at the moment to limit the scope
of the reset.  In the future with new FW, we should be able to limit
the traffic disruption to only the queue being reset for any vNIC.

> If we were
> to split this into 2 changes, I don't think those changes would form a
> logical progression: reset vNIC 0 (current) -> reset all (net) -> reset
> the correct set of vNICs (net-next).. ?
>

Agreed.  This progression is not ideal.

--000000000000d457810637b6b1da
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKq+zcksvPaoCgIrGm4sZPna0p2Rvl6C
FtKyZm67pGISMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYx
NjIxMDEwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBABhfaeunT/moXLfzcKkTPo1RKHT5KwJX8vH0Ex2fApTD8bFhq6L4lOpGFNAcTunU5Yc4
Ef8nX1eIzmC54YT4E3M0HlZsGA0U/035I6L7VSqo+NhJtPZSXjN2Bo9eti9yEWPUlOXsfBxPma+5
DWN2BucWr6wQ4fg5Da56p2Vzl+mGelAw3Y2Lv0csvA/kfuwPKc+mAMXXrIlvt6i++q03K6ssJ8fk
xFpHE60TWHWC3aOlh23ae3hopBckkrx91ewba9KKhk52Uy+Jgk6XYTv7bBIzCb7ZIlRW5N29SpGS
0/IvR6PTRyArfqOSlVodS87pw1uWORDvkfjpVZaM6PFOx7Y=
--000000000000d457810637b6b1da--

