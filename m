Return-Path: <netdev+bounces-218051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE24B3AF7E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DF61C8713E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF41494A8;
	Fri, 29 Aug 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M32bz03A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FC13B7A3
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427470; cv=none; b=ITKo9kdI+uWMDahf1MRzAJmoVGGkHSIZPJQbus4aGXwNwUU17jL42prpnpsiQVyoBkwCsqn1LsLQO4ekpduuyaoaIAUy5BtAmwBIXEQkpV/4Cy76+1DMBRBvkaVafhAzAwesGrGP8jgt8cZgvkGodhepWPgTQ3C+Kn405pLjG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427470; c=relaxed/simple;
	bh=CZ/oJkJkLyAsy5WsTMYGzaUScwkT3spkk8a0Y1NxkaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFojSDKp2/5s+E9L4W+2QiMKKP9Qi+/Jw7koU5SICUtuOdbSY9SDgl2+90Q6FLYrsTv0WP4JXNVl38pLJyPpsupI1cqJo5N1pfNwEmxnMDuv/7kQBO4vH4UUqrrQOcYx+EXlP5SEHeN+TkAULLaJzuiTcpkyZn+ues5kmm3sNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M32bz03A; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-323267872f3so1438728a91.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 17:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427467; x=1757032267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4TLfydWyzCoMoU8puEOHMnSfQVomeBDsP2c35XEUTqw=;
        b=GixDq5ARXuA9c2DFpxSzJMmaWASLTTjrUhWhESjLhy0eiRaP5lJGNB/p8B3Go8Pw3u
         6vfhVC/eSs230FHfxhNNfN11Yw5HT8omIJHbCybRVg8XSQCOxGaSL4Lp0N7Sx+vlCMp2
         dhqd267oGDyrhGwAYErUHIvVAFAl7BSPGvwXEnfnyZpMyis88yNB0e3gSOt7m7J7EWch
         9aBoAeU0Q3NvEEc/vU68/+DqHGR58cAbsVaohzpx68naI/7wgO5vXfykfVrH9rqbBEVs
         k9fhljQclg1xLvFaM/r1CDGYHnv4hOzyy2jJKK8AGYdNCMJbzUJZuWVyPJ6EBLJ4/X62
         VsWw==
X-Forwarded-Encrypted: i=1; AJvYcCWKJVZgwhiGUaV8Rt59BtYmgRYtFT7r1dxN19y/xVWPty6spRox/Fto05gvR/Ni4H3CmjhHL4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki0pwBUUAJfhviN6Ftjw8L6is8dHybVqXhYQx1Wft+wZp/Y7U
	zj3K6RvgeXO+u4GR2IWmpwea+2oZs8gtUPe70DXOzeObxXtLjQz5LXSDGCH+vXWlzDi8KLwz/ql
	pDWNgFnBxDP7MjfdCi0Vr0+OUT/J5sMLwb0jk91vimDKY03v/qzbdTKUJsNc4zUBweRaUPY1s4Z
	kZinPNXp2nDh0phEIR4R8ck7w5xZamgxMNHOPnPP91TSFRrNBN5+uZHct9IQGGwMBg2cxPdjLoa
	+pO8oxD8+4=
X-Gm-Gg: ASbGncuCOmCg83IMnP1wisE6gQorNdklNCAbUKvKEmQ3VW2ZpT2A1DSwALBrOvhwaXz
	rzil/WPZl+atNoRXd2xd2KrlobXwnKps0wWwUGdQmD6esivfMZy2TUws/mBbGWDcgNpXpGn8h2R
	9t3l4+25vnlP8TcA+DKfrRhukaPa+e9Q80qyjhmXCWY2Mg+IKOJf4msB50JF1ZgczlPPbdasq6g
	ZhYLj5G6rN0qEeelwUSErZTd+TLxdoWb740xgcexO5b96XC6ZhMlibAu3TucPV7wrWuPsLCV49G
	oVHliAuyK2UZvLfX1OM/aAMOwQgZAANiHamFgJOaDpbfKvO+VcW2cmYXN7CFOVfsamjMCSSAdO5
	0+M9M9djKvoBzqu7MxKNXfAenpiTzDPLAB9yj6nakSZH1Icdqg3FwlTHG3OQ09YsWluGYwc1mZq
	Fz2Q==
X-Google-Smtp-Source: AGHT+IGJYww/7gI94U0eZRqIHoesAPN0fF8hWSCBeCLgTri3wKq6VuaSb8AF0PwKKmL8i9Zdt9m3JgfZV7CI
X-Received: by 2002:a17:90b:17c4:b0:31e:6f0a:6a1a with SMTP id 98e67ed59e1d1-32515e12e55mr31474706a91.3.1756427467194;
        Thu, 28 Aug 2025 17:31:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4ccd34d7bbsm67161a12.0.2025.08.28.17.31.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 17:31:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-61c6d735de8so1574623a12.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756427465; x=1757032265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4TLfydWyzCoMoU8puEOHMnSfQVomeBDsP2c35XEUTqw=;
        b=M32bz03ApBsuQwBFDbKPQqIcr1KmVADVfEB7n9yUXzpZ//GAwIEw7KLXf9LAVZv3sy
         ZJc7xMzOSgOQFJNssATyT7Icx0/MH/oqF7Hdy/Zdqz7CkGClGaxAOcBorN+RK9e/KOiS
         icZm7tDrjtO4VJxCOys17NxpelSPhJOnwDmbs=
X-Forwarded-Encrypted: i=1; AJvYcCXORNKXfGwQ+pnXrnGsMzNn8OktID80m3LdABn/aXeh6FE0q2wYua/hzWgUNNrAGSh2xS5G7Ns=@vger.kernel.org
X-Received: by 2002:a05:6402:268f:b0:61c:7f7e:2f with SMTP id 4fb4d7f45d1cf-61c7f7e2205mr12512608a12.23.1756427464733;
        Thu, 28 Aug 2025 17:31:04 -0700 (PDT)
X-Received: by 2002:a05:6402:268f:b0:61c:7f7e:2f with SMTP id
 4fb4d7f45d1cf-61c7f7e2205mr12512581a12.23.1756427464325; Thu, 28 Aug 2025
 17:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828194856.720112-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250828194856.720112-1-alok.a.tiwari@oracle.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 28 Aug 2025 17:30:52 -0700
X-Gm-Features: Ac12FXwAacgOEl1u0DZYPCcJNtbUQzUaIgCveZmsbUytVdZVXO_eK-cPksTVjWk
Message-ID: <CACKFLimOb++PxzBSZcLHP1GQP0wk+hK0XAoXti7DMLtRw4JQAw@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: fix incorrect page count in RX aggr
 ring log
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020bf1c063d76239f"

--00000000000020bf1c063d76239f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 12:49=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.=
com> wrote:
>
> The warning in bnxt_alloc_one_rx_ring_netmem() reports the number
> of pages allocated for the RX aggregation ring. However, it
> mistakenly used bp->rx_ring_size instead of bp->rx_agg_ring_size,
> leading to confusing or misleading log output.
>
> Use the correct bp->rx_agg_ring_size value to fix this.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Please add the Fixes tag since this is a bug fix.  Thanks.

--00000000000020bf1c063d76239f
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKTq1tPH4JFbvSdxeBW7QMxzVHu84ScE
i6p/BV2ZJfHvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgy
OTAwMzEwNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBACtgASudEZc+u8PYs7YEuEkJ093LmMLZ7MKCK8VXC9TddbjwDzTfxSD27oOJ536Zp3UX
N1jwQqHtU1lpYN51wX1e2hfGR7TZRCQyLk6Ivu6fcmtjqQWZKbdXDxiQnMRbujEGo7blwYCBAUEV
N7dyTutFZv5ezzavHWkCnHQBhQtbEyAYb09w5/WbeVmvk6ld+VbCjrL/YZ05DHsUZGAGggm6q9uj
bnEX3kJBV7upHsvrEa6D41s3OMnyu+sVcB5WIwjceIa/drJd13w4+H7vWxCuCoVfR+v7rv/i3zpd
KtgBynvOqLc1z19aWd7fFe9usS4jAe+Br918EfynS2jG/RM=
--00000000000020bf1c063d76239f--

