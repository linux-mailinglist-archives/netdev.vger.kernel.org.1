Return-Path: <netdev+bounces-156532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D291A06DA8
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 06:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580E13A6A63
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A264721421B;
	Thu,  9 Jan 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ERXXw+Sy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F02147EC
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736401127; cv=none; b=SHpCRGO2escuWY0B/w5RQDUZbMKAtwQh7DwPLWU5VoEWa7SjODwks0wj6URET0dP0jjoktQjL9LlcQSN6wnh+IrO3Mfe+K9b2BXLcCQoL1feenzBTciTHgux8G+QVT99J1P5QzJxSP4NbmXFFi6lAtXGecNQvXnTHT0O+ia2x5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736401127; c=relaxed/simple;
	bh=SWpfCleByGjLVXzJgNfZWwWIfzV/Y4t5b3xU8oZPToE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4fEh//1jQ1j0C31Jto2s5KrItRkHknvO/YK8A0pLHDln48lbaPCBz38fkIJJ0veD+lQw68rSjRPDDa+TnnYMt3DOh2qfh3Nu/l9TEt6wEgDNkCG9Y8L/6n9OHCxE/mZuAOzAvDqR/lcTZAbaXdeFgUc7Tp0tvii/cR7q1PrKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ERXXw+Sy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so714600a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 21:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736401124; x=1737005924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfPE2MljOFZJ6dHcUidnCDyzZi/YivmM/QCdtrICerQ=;
        b=ERXXw+Sy9uUsq+S8RgezcN0sjcPpBrW0lJFhbLi3KbdW5T2LJMBl7wD3FfFnusrc5p
         sQnoTjNSU4CEWP3reBVSZZTiLNh1sFRiS9YvogjXOKoF5P2BH+Bph5QaUBi8My1dHsbr
         75PCOcbzGKblZMQuarsneYwZByIW3/OUhXorE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736401124; x=1737005924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfPE2MljOFZJ6dHcUidnCDyzZi/YivmM/QCdtrICerQ=;
        b=UaKOgNcTk9yAq5nRva49AbBf/JzcOQhxZey1n97d8zsGIjWHcfFoypmZYYmn0zVQKw
         1YbvnH/X+P4vAtdsRqnzf90XXSlGRmQmoNAeV58qCUqnGjHMeZBdUzCvmyelBR7l3JMU
         BlceL1G+gDLiiSidq4peRtejZ+TkPzE/snLDuWlrZzeextHXsvppGkRu74nxVIYHDLPV
         ZemTLTrgCmqk4VQVcjPO2Jfy0w4wkv0AcgpeKFtC9tLhBdTakDhuakfyoLF5WDjF8sbU
         9SqtEV6KYSE6hhRfjvlC+6FuXjtODE9bcW3NkLNKViuRY0Y8eSAuKhxeoFwCkL7R5n94
         5wBw==
X-Forwarded-Encrypted: i=1; AJvYcCWAmGWv18CSVasGXDBbR/ekLW5iW3U1PijS3CVqkJIaWQBYpgaXOjxf6S11sgQxhinN2znQfW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaH0K6Ob+JceXlfX3+kYS9SjoZqoqOj0Gn360m3ZSc+RuWxqce
	bS9K0vNhLVLVX6xerf5XgKgcu00/JN8cddPiU5uES2S0ggvZKnX1zunYhPsm1QWkiL4pzwUOBwx
	mF5Em1utlIrK1HnWGoVLmwzgN/8WceJqYQQ/j
X-Gm-Gg: ASbGncsEphksI3FY2CsH1d5N+4braNd6CrbjhJigpQQtEWaUelpnDs4fRj0Sm4U1p6K
	LK+XxvF9Tktx2c/cJXBBU4YsW7ZDzAYTqQiAfYg==
X-Google-Smtp-Source: AGHT+IGf5B3S6Q9G8bJ1K7EdW8jx1gI+e8DQaIXpSBxS4cV3qVgFwiVLR43LIWfvgkKgZCGedjQJHHBCmEEqn8vUOe4=
X-Received: by 2002:a05:6402:90e:b0:5d0:d087:6d5b with SMTP id
 4fb4d7f45d1cf-5d972e1c0demr4562118a12.18.1736401123977; Wed, 08 Jan 2025
 21:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109043057.2888953-1-kuba@kernel.org>
In-Reply-To: <20250109043057.2888953-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 8 Jan 2025 21:38:31 -0800
X-Gm-Features: AbW1kvZ0Fr8ThYdITqo-_aPyUjYZhha0Gz_WQ8tIoPXKtecnieKdYCZ8S67HTu0
Message-ID: <CACKFLi=y1Geua16t+u5E-A9iL5mgPNEE_yLTHEeFk0ZkVdBoAw@mail.gmail.com>
Subject: Re: [PATCH net] eth: bnxt: always recalculate features after XDP
 clearing, fix null-deref
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	andrew.gospodarek@broadcom.com, pavan.chebbi@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000340d2d062b3f6407"

--000000000000340d2d062b3f6407
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Recalculate features when XDP is detached.
>
> Before:
>   # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
>   # ip li set dev eth0 xdp off
>   # ethtool -k eth0 | grep gro
>   rx-gro-hw: off [requested on]
>
> After:
>   # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
>   # ip li set dev eth0 xdp off
>   # ethtool -k eth0 | grep gro
>   rx-gro-hw: on
>
> The fact that HW-GRO doesn't get re-enabled automatically is just
> a minor annoyance.

I knew about the annoyance, but didn't know about this possible crash.

> The real issue is that the features will randomly
> come back during another reconfiguration which just happens to invoke
> netdev_update_features(). The driver doesn't handle reconfiguring
> two things at a time very robustly.
>
> Starting with commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
> __bnxt_reserve_rings()") we only reconfigure the RSS hash table
> if the "effective" number of Rx rings has changed. If HW-GRO is
> enabled "effective" number of rings is 2x what user sees.
> So if we are in the bad state, with HW-GRO re-enablement "pending"
> after XDP off, and we lower the rings by / 2 - the HW-GRO rings
> doing 2x and the ethtool -L doing / 2 may cancel each other out,
> and the:
>
>   if (old_rx_rings !=3D bp->hw_resc.resv_rx_rings &&
>
> condition in __bnxt_reserve_rings() will be false.
> The RSS map won't get updated, and we'll crash with:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000168
>   RIP: 0010:__bnxt_hwrm_vnic_set_rss+0x13a/0x1a0
>     bnxt_hwrm_vnic_rss_cfg_p5+0x47/0x180
>     __bnxt_setup_vnic_p5+0x58/0x110
>     bnxt_init_nic+0xb72/0xf50
>     __bnxt_open_nic+0x40d/0xab0
>     bnxt_open_nic+0x2b/0x60
>     ethtool_set_channels+0x18c/0x1d0
>
> As we try to access a freed ring.
>
> The issue is present since XDP support was added, really, but
> prior to commit 98ba1d931f61 ("bnxt_en: Fix RSS logic in
> __bnxt_reserve_rings()") it wasn't causing major issues.
>
> Fixes: 1054aee82321 ("bnxt_en: Use NETIF_F_GRO_HW.")
> Fixes: 98ba1d931f61 ("bnxt_en: Fix RSS logic in __bnxt_reserve_rings()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the patch.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000340d2d062b3f6407
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMtUCDd3urOGaUp1GkciuXo4e+ZK+bh+
6FID+g71H23XMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEw
OTA1Mzg0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBqpcHLIm38BMQ9TqPziqmW+lQv5WUH6j6krvbWhFRlTHdJsIgw
bUcqWNzn/KvK5AwvtIKqpVTBVRb6FzW5xR89s5aC3KV8/dnu5QTbBu3RBwOa0vYIyLtPzdxWbi/V
ZBTo8jhSf0vhC46LxFwJj3i27t2hM28AnW/Uyi+HtaCq1OpmOv7OYZHys+2f5w/e0xh+bwH0WJMX
YkQBjFSJyWqVqS7VpYv2QXN7Qavzg1puPnkkQkxzM8h7tqsTr+1Rrf3GcztVFXQPNbuCGNXW3umD
54Mm7n3qLO1R1jcMFQ6/5e94pNhgNFCdgZtExiPDZUbvxA1LMN2u4JBmKo21TyeE
--000000000000340d2d062b3f6407--

