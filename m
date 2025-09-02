Return-Path: <netdev+bounces-219089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A743B3FBDA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432F51653DF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0532EDD5E;
	Tue,  2 Sep 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PU97DOyp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB81280338
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807722; cv=none; b=H11zh/hGVDrIsiWPkpvqz2ZNwfuEtcOohVi0a7MftPGC5nyBLsS+Kl9+2XJkNG8q5TlbkJVLMuHTJehK0oItmlWrvuE4aZ7v02BcmfccCi/Nb2enMKacMR4WlFYqbFKPRsqDg/AYO/rj2w2Yll9fOJOjxO3tmxvgu4dmlDMMhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807722; c=relaxed/simple;
	bh=vqu2Wj6Euh++p9Po39fHBf+0LxU3uvqnDgeLlKQHxK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwfwyMPjR8InBZtnyppKKqVegGa9UbrRg+1feqS0s4fLadyCX2dQASflWDT7aLa0GgmnCcLv383Ne9NAL3rL+OnowvngOQl+Dc7NIdEWPhTUy5OHfXgcox5W2VH7c0k76grctd6+dl/Yxho/X4OGagQwl4XuthfhgTDpUN7I46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PU97DOyp; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-61bd4ad64c7so1579156eaf.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 03:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807719; x=1757412519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OlR++GjefWTHnI+HzQz77zO9mb0DUFzY3jiZoYM0u+M=;
        b=ZRgn44Rkx18tLxKTeQTA+4Ak06rRZfxg01039+DsouzuEJ41zbzFjvVhJhRHabzqQl
         3VUsq8qGH96NXOgJjRuOf68NFe2MIxBdmeVujGQEyvGdY7frOE8iuzKrCrEPNLbNDpIp
         zUyrEUP0+LUuweKy/q4dKBXqNQY01aT+a9gGeBX0IkQg0BiasJX2ceNJ2NUGnkENYV6e
         kpjF0/Ofj8V1Oo8Qj07O4BP5VbpBIaNTTyoi1X0cnyogK89wcWbaa++BLIMxk+GFCUad
         dvoRkCBdMO4nw34s+atQrUFExrK1jXaSbXZy9c7BB36q/YtKCN9oGunZejpokXtIxMXr
         KEwQ==
X-Gm-Message-State: AOJu0Yxgvo+TgNR3G4WDyQxVt6NSLSqucUaFmtM2x+5P8pSgT6N8GgL2
	UFPxTxgaYR8+2ECImg9tI2/XCsMT0SPfji8zxZBy1v2GAT6DXSJHanC2igz2leJJL5pkm3v3D3I
	bQ1iyKtCxk52pA5ZtOIk/dloRAeNoUANd35N0gn/s4ab8gq2sWZu1L2J5md14nSOrhDsFCUPYHo
	HxL9knyXBsG3wKZRWx8m9y2Ps8jxxxNxqZlYuFS87hgjvrgOLl5PMJ4r7pFy3zX4x9Fj7+rDY1a
	djVHwhE
X-Gm-Gg: ASbGncunXmWKIhy+kIZaukjcUXcB2lvR0HNluBQKCmLBYNfxN3OsZmlp1HLra/LGHAt
	2GzBJ8A9Tf0Gc9s3lpBSOTLHOoVHERP3DdRYpkUNHyvRJZ/VftIhxAYTH5iUME79ci89NfnqbPb
	IS+KJ6Y6k+8in1dqlEIdXokQnmKsepcEM9/uMbX/BVp68AizLuZEgxJ7dpmHV+uNWs4IPP2CSST
	/Bap9rzGtB8yg5em5nwefTpxWEmwz+3+2GmsPWkWAJwHgNc/0GTuCQWbIj6PfOjhs0MESKj625Q
	QYNoQIFGucsVcWPulPRYjxLZQgkwYNCZFT4umE+2gJ+/l10tBYO5VjuRoFbecTLPg9nBSAwU0WR
	W98rB4pJpRjHY6L5hwOafGvVGJiZegyPjIK9y5ZK1tfF5WuQGw3aU+50XUGiqp8M+8ANcAUL3
X-Google-Smtp-Source: AGHT+IEN0wvtoC63OBvEEtmctpoaoDSQ9mc554lITEShwSkcrRAfROVYMPg/MWUGq9WLG+JLAVNT21gwQOF9
X-Received: by 2002:a05:6808:22a0:b0:437:d236:1dd1 with SMTP id 5614622812f47-437f7d056a3mr6054922b6e.20.1756807719410;
        Tue, 02 Sep 2025 03:08:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8f082e90sm492728173.8.2025.09.02.03.08.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:08:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54499b68d0fso365700e0c.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756807718; x=1757412518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OlR++GjefWTHnI+HzQz77zO9mb0DUFzY3jiZoYM0u+M=;
        b=PU97DOypwrn9Shp+9R+1SPj9MexevLpxdjt+YvoLgcFysiN+F6RsLKrYM13GUfVMDU
         v4mEQju//dIseJJi+L+KGt1VoTojzuZWCqZJfuH/i/RJrFEX2/0ohWBRSvAj95MRG3RQ
         WZUaiUYKOonbRnRkuLndHh7pDpDAA7imjjRTM=
X-Received: by 2002:a05:6102:441e:b0:4e6:a338:a421 with SMTP id ada2fe7eead31-52b19534c68mr2533038137.6.1756807718589;
        Tue, 02 Sep 2025 03:08:38 -0700 (PDT)
X-Received: by 2002:a05:6102:441e:b0:4e6:a338:a421 with SMTP id
 ada2fe7eead31-52b19534c68mr2533032137.6.1756807718044; Tue, 02 Sep 2025
 03:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821110323.974367-1-ajay.kaher@broadcom.com>
In-Reply-To: <20250821110323.974367-1-ajay.kaher@broadcom.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Tue, 2 Sep 2025 15:38:24 +0530
X-Gm-Features: Ac12FXzRcQynGFneSwr3u3LMGdh8rUGfSYYsMLtnKHkHQr1Rvj5PZHOTc_Pf4L0
Message-ID: <CAD2QZ9YtE-cEFCu5-uEv4qs8UO5wAVyRPU5gonpR53DW=F8r-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
To: davem@davemloft.net, nick.shi@broadcom.com, alexey.makhalov@broadcom.com, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com, 
	krzysztof.kozlowski@linaro.org, rafael.j.wysocki@intel.com, 
	Borislav Petkov <bp@alien8.de>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, florian.fainelli@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, tapas.kundu@broadcom.com, 
	shubham-sg.gupta@broadcom.com, karen.wang@broadcom.com, 
	hari-krishna.ginka@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000005ff3a063dceacdd"

--00000000000005ff3a063dceacdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David, It would be helpful if you could take some time to review these patc=
hes
and share your feedback.

- Ajay

On Thu, Aug 21, 2025 at 4:46=E2=80=AFPM Ajay Kaher <ajay.kaher@broadcom.com=
> wrote:
>
> This series provides:
>
> - implementation of PTP clock adjustments ops for ptp_vmw driver to
> adjust its time and frequency, allowing time transfer from a virtual
> machine to the underlying hypervisor.
>
> - add a module parameter probe_hv_port that allows ptp_vmw driver to
> be loaded even when ACPI is disabled, by directly probing for the
> device using VMware hypervisor port commands.
>
> Ajay Kaher (2):
>   ptp/ptp_vmw: Implement PTP clock adjustments ops
>   ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
>
>  drivers/ptp/ptp_vmw.c | 110 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 88 insertions(+), 22 deletions(-)
>
> --
> 2.40.4
>

--00000000000005ff3a063dceacdd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fEfjRz/Z5b6J+pnCj2dzb2Wir3qx4rt1/aShjQasncmTZ0r8rOk2G3RmKolDmTmWPMeCgzL2KeQs
QRXTsKFFi0np4iUyWo+MDCofsswor1HkoXwlmoIAdrFL+cw3qvOowpOB0pe3+G1rWNvJvYsOAzG6
2a8X0kwMSTEGjJgAX+jQjqwdP8C4ZxmE7n236E9GiM8kfhFFAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2FqYXkua2FoZXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkdXtSp1Dzqn1C33ctprG/
nnkbNDANBgkqhkiG9w0BAQsFAAOCAgEAQbg6h5rEci8mKF65wFYkl7cvu+zaAia4d24Ef/05x2/P
WAuBmkkDNwevol3iJzQNwlOuR4yR0sZchzw7mXSsqBhq1dgSNbReQ0qJU0YWze48y5rGlyZvCB1Q
Z8FbyfrHGx4ZQJcjB1zeXJqqW6DPE5O8XOw+xTEKzIQxJFLgBF71RT5Jg4kJIY560kzMLBYKzS1f
7fRmy20PR3frP6J2SwKPhNCsXVDP3t0KC5dUnlUf/1Ux2sVe/6G8+G7lBCG3A1TaN4j9woYHN7Y/
U0LCVM46Gf7bFsu7RzwcrKtSOnfJ3Fs7V+IWCrTMvbCSQylAy3+BMkMGFZ0WwtXNLxbYIEhKAZmH
npugOtDKS6j4LkLxkHr/dTYZvfdOXZXTIlz8qTfkTKw4ES4KW3EGzfnRZCL2VD27/GAtt0hwPWrY
HL087+VQLA9RUVdfnigRjZOPWo//78ZaDd9PPWbLKqa6EIboR2nSV5miF9fQinDnxToBGplQEcXG
WwCF8syc/0n0xzLlb/IOwxmkzMizN/3/vVp5eGh64OGdhSwzZDBQuVS08Wgfd3nVHT6zh1F0jBgZ
ACv82jjjtABB+Tg1VZ0vcRr5ZzTC1WylB7ik6soemgWAgbrQfhNh0uHr9jq+NAbTA4wqUK6gA5LP
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILcQ
0Q1DO+Q3eXcf6awvPDyEPsgJWkBo4xt1qCTc/8AOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDkwMjEwMDgzOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAETR07p8KX7gzPzKz13YK9RKSW+44q/0oqEGLOZG
M530ZxQ9S+iB6iuBTVPaiTVoCEBooDuCDBgOMCJS/Rp+T7DwUEmwygs+LlXePZ7z6Ep2bFkaep51
A2/ccFASrJZs2Ts4ZMG7a+sjYIN1R8zvmZNQPR5ROcyl6zPwvG4eGeiHe3sVi2BG0VcB2n9auJln
vIA2z0FXTnmJukiLELUdNQNNO3g57cyWpIQEaigBMveI6nPfZSLfCeO3/9dyiMDUo6+RvFWqOj9Y
LnTw0or6fwjAlq2moauYMnXEsjTWOHSXGAJonBR62u+ClwpVVYRXJBKEF09PA4QHAQErIFpH/gQ=
--00000000000005ff3a063dceacdd--

