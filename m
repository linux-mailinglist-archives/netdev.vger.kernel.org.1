Return-Path: <netdev+bounces-133945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E567299788C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8491C21504
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9011E282E;
	Wed,  9 Oct 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d1klbw4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBE185949
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513436; cv=none; b=c3Q0Q3XAgyd656Rr+3jdKbfeYVyqg3lKWTgKhmxTs287bRMEvTuaCRsTgO9gkHX1/r3sdlIRQka++yTZZhiglE5oT0UWWuk/u2YMxC3xYQcMfFu+IUkQnulbx7/W4KQ445XXWdUyTVXVfvDmId8qUkbyqqlb6ebIGjeShay1JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513436; c=relaxed/simple;
	bh=HDnfZrWE1Px8hpsm/g2XLlT+3Gkd0A8Un7hzh8e4U+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaJsJTpdhv2RzUzwm5uHrSahFLhUXCuz4NtkJRzn/O3jpcU9raxJT4c3CJmz6mY2ogEBHhw0bA7Mpx6NOu1fg8o/YzcTH1ApWPY/k0oa/TDYxtO3oT4BnIOcRv6MJwyN3cEK/GDa1Nht0V8f7H2t85VgKvP6qD6GQlJM2NlFK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d1klbw4R; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a993a6348e0so18983666b.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728513432; x=1729118232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2o26BlLcF2XXnU0FLNvHUIL9hQ1b0y0WSAOErGUPj7s=;
        b=d1klbw4R0gwCNz9beaXlMtY59bdXOkp9p39jrL6TDc1MoYhC7dwy8Itz1Jy/ypA0Yp
         NZlDJdJuC2vuhDfxCnTKA6S0mHnqZauO47Pqh43qQbXYNHbUmOfx4ZucvsRMcVgEmo6I
         YGAy8dkzMHDWc2kT5OuUY4hNrYS501tpINDHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728513432; x=1729118232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o26BlLcF2XXnU0FLNvHUIL9hQ1b0y0WSAOErGUPj7s=;
        b=uCqdxJUZPJ2ngb6mJ4ojDDZ4B9Hh8JDF7vn4YFOuX8lCceVczHJMhvwmYPw+ibtTMH
         uckOAi+RUyK1bl4czauMcbBIlllyYPS+4c7IWWPCJHZG86sa4mc6erg6GWWDLyw6wigI
         fcDqGHse8u5i57OzkP3U01siFz9iDh2OOHgQrRPDwPYKI73vxqTeH4wpcSePHHaUoIlm
         TAdi/p23CbVL1fhaJ3O2MlvM61Hc0sXkuIbD1yBXJASg1OwgrZj9sDxljFFpwXVH2hho
         r2pzdyEjEJBXHvUMYKpgfVvbgD1v1Ae1mNnEcMWWtB830bPbl0N08VTtOjkH7ERrIAAY
         LokA==
X-Gm-Message-State: AOJu0Yzm0H0PVnOacjErVRlsZPlcxD1w8n/Nu5GbQNXHVKdz9wnaju9N
	zExpTvYUK5i7FERnTSQ2D0kLpkTjhd0H4x8y7IYbDkT0J+fLQ1vHELFAfEQu4eUvqeHqD1tleU8
	d7vmtv9Zk0/2dKFv8SBays7NXK3IquYUrthKw
X-Google-Smtp-Source: AGHT+IEARU/d1avivKsEP20FI9lwifazKhVrFWA/ndg3ezif0mpNK2OoPSiTN2v0Km+nFtYplV5XaABrc7etUwOq6LY=
X-Received: by 2002:a05:6402:510f:b0:5c9:21aa:b145 with SMTP id
 4fb4d7f45d1cf-5c921aab83amr3143078a12.36.1728513431953; Wed, 09 Oct 2024
 15:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009175509.31753-1-jdamato@fastly.com> <20241009175509.31753-3-jdamato@fastly.com>
In-Reply-To: <20241009175509.31753-3-jdamato@fastly.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 9 Oct 2024 15:36:59 -0700
Message-ID: <CACKFLimL=x_KQeyOy_2FLcew=TFD0MjvKJbH_BaydCEG_Oa0Cw@mail.gmail.com>
Subject: Re: [net-next v4 2/2] tg3: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pavan.chebbi@broadcom.com, 
	Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020352c062412e579"

--00000000000020352c062412e579
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:55=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Link queues to NAPIs using the netdev-genl API so this information is
> queryable.
>
> First, test with the default setting on my tg3 NIC at boot with 1 TX
> queue:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
>
> [{'id': 0, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'}]
>

This is correct.  When TSS is not enabled (1 TX ring only), the TX
ring uses NAPI 0 and the RSS RX rings use NAPI 1, 2, 3, 4.

> Now, adjust the number of TX queues to be 4 via ethtool:
>
> $ sudo ethtool -L eth0 tx 4
> $ sudo ethtool -l eth0 | tail -5
> Current hardware settings:
> RX:             4
> TX:             4
> Other:          n/a
> Combined:       n/a
>
> Despite "Combined: n/a" in the ethtool output, /proc/interrupts shows
> the tg3 has renamed the IRQs to be combined:
>
> 343: [...] eth0-0
> 344: [...] eth0-txrx-1
> 345: [...] eth0-txrx-2
> 346: [...] eth0-txrx-3
> 347: [...] eth0-txrx-4
>
> Now query this via netlink to ensure the queues are linked properly to
> their NAPIs:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8960, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8961, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8962, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8963, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8960, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8961, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8962, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8963, 'type': 'tx'}]
>

This is also correct after reviewing the driver code.  When TSS is
enabled, NAPI 0 is no longer used for any TX ring.  All TSS and RSS
rings start from NAPI 1.  NAPI 0 is only used for link change and
other error interrupts.

> As you can see above, id 0 for both TX and RX share a NAPI, NAPI ID
> 8960, and so on for each queue index up to 3.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--00000000000020352c062412e579
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGu8llsUBlw5bdRuY2EsjxvVhpCoE12Q
ZsuBC3qyT3VHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAw
OTIyMzcxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA+uxdMuC6EG67B1quat9vFtk+aRu9X6pVWMVNE+oGLWH1XcK7u
BDPf0a1JwdcXLVr2UCuEiv8ma6/FffzuVfQruS5Vt7GlwNhtgpseqMErObOUKTV0CemMZ1Dvrz9c
y2rmPisA3n+wSD6HcSe1GD+xc9Fl53/oiHGwhU9dd6yay835b3sRKLqQIvBYjk5Dmk4oqI928+8X
0KfVVEvUFXvuCtFuI6/I8SPoVPT7a5mNa6RBEQuua9QOy1cIOBGc98VYHIqepc57xfnOHPKzPjQn
MM/sBOwtwzScF5D6y1i4H+rRyvAls8QxmY+Qrkg2RRqxxvT+GsSDddMAaYqARkTe
--00000000000020352c062412e579--

