Return-Path: <netdev+bounces-160731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88583A1B002
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3919C188FD6E
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6801D7994;
	Fri, 24 Jan 2025 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fp3d7gD1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82917FE
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737697450; cv=none; b=fsoigdJuQSaRSxOLs0PoT9q3+plYKUpQjIVZQQF/om7UhAoqH07qnvZ4l61mA+3QZt2Rkp77ljUzXOS1iJOgkn8ski9g3lmQ/htsbBP/a3kwVYxgAmqcFkNs9+mCzaF6VoZYWSakHWm/1LjT1v4g0ieKpDnOqtQR9/Zb2qlQLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737697450; c=relaxed/simple;
	bh=idKDdI2vuiYhKb+qWzjhDH5UYo3/uz+dJ1+dmLWgSKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjSs49MSPPLcEBXjE7Rv5+c0+QhxJpLYnrSE/0iOcAo7azQUhmNlDw5J6Eo0W58qF56tfz1GV3ei4eYgT3ftpPdr/MfmtoHao0nWBFy+hlhjavs8vZl4dEenV3sxrQ1JxcYqTIddcfKAViSQCZ1rOojKdwfoO8k7scfNUzpCvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fp3d7gD1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3ea2a5a9fso289531a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 21:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737697446; x=1738302246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWkyqbdwCg1m1v2WCHKqOWk9SDPSS6Vg5MT/NT33BVg=;
        b=Fp3d7gD1B1xye705xMe+6T9FDU4Mxd43RqBEDuHUd/XRfwNFcps0PWj+InjcwpJhQj
         pWcF0zw8kGSJs4yh6Ts31XakLBiVRrTKuZYUyrGbiSfdZry9bLjQfQsQHjWY60AU9PXl
         vSNRZRqBwrKiqHhZBFpRCEwL+pQzNjKko5jsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737697446; x=1738302246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWkyqbdwCg1m1v2WCHKqOWk9SDPSS6Vg5MT/NT33BVg=;
        b=NTqcmEi3Py5T1FEERnHKH1/WU6m7toJspr6nuC+vORAivpgs0PvmRXxfhWSpjjSQDV
         QdRs1bsLcaxdbryix2/V8b6vZKfEaM0iEIVsCjQRwZIMYNYxxTUER6Gs3P+neVX9W3Nt
         UWIbrgbSMjqSqAqeKMlrbQoBY2J2PMJ0ltgAS/s4YfV6k+svpS9QBAzArMSgVQJ56SyD
         KNpVaq8YpodMxClTLhO/01GFKE4goJK9Zhsc2jFJL5pinlr8UimXSVl6savbCP/WndWU
         QtS74IOXX06BWVNO5osb/W1QggC0EvA/L5m+FNQPScsp+QppwENrFXWhRz8ILm2Rq85F
         pUgg==
X-Forwarded-Encrypted: i=1; AJvYcCXwSvQc5XCBWeeAX1gl/qoHIOZsyGWORHY+LJszWTQ+PXQJXEVs7wYY507Omalxqmz4HZt7XXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3hR/niSjxkByixnaj+uY8Yht4umugH/hlUfkFIpAkXn/RmVE
	R+uXB/6Sy/3JmjEPY6g0HGHKhhJ2K16YWoBLYj0fydwZkMryQb3Vuf9iiSweGcgz4m6a1oxH5TJ
	OiwS/wtHp+PoA2WvitDb5uTatxbg/BXOeVoOc
X-Gm-Gg: ASbGncvnwijEhoONV3x+bwV0WziF9/xPHPRUFSMr/gUYS0EabkgeTfUYAkm7t95at4u
	mCwv4Dad75rLEIA6dTm48cPs1Mkt8pbyRt5l7OvK+WMDzYnaZQtqJu5qKVQ+6R6b0
X-Google-Smtp-Source: AGHT+IG8om5394ef2YhXIHIV5BYjpAe63Edw0duenB0hemrZEERz2vjlQ2Gt0plskJU3eLYwjMPZKMVp5o5W9Q58Fjc=
X-Received: by 2002:a05:6402:4304:b0:5d0:214b:96b4 with SMTP id
 4fb4d7f45d1cf-5dbf1a99e71mr3414076a12.1.1737697445962; Thu, 23 Jan 2025
 21:44:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com> <2025012010-manager-dreamlike-b5c1@gregkh>
In-Reply-To: <2025012010-manager-dreamlike-b5c1@gregkh>
From: Keerthana Kalyanasundaram <keerthana.kalyanasundaram@broadcom.com>
Date: Fri, 24 Jan 2025 11:13:53 +0530
X-Gm-Features: AWEUYZl14sxxUrvGIROiiLNwonSq9HEFhbgF5RF-7Gjh_5LnFZtx6naCyPAaJrc
Message-ID: <CAM8uoQ8pb+or9ptdvg6q5MpRskH5Xu8x=rTm-tdcLifDSmQ8=g@mail.gmail.com>
Subject: Re: [PATCH v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating
 setsockopt user input
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com, 
	luiz.dentz@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, syzbot <syzkaller@googlegroups.com>, 
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000461eb062c6d3781"

--0000000000000461eb062c6d3781
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 9:11=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jan 20, 2025 at 06:46:47AM +0000, Keerthana K wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > [ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]
> >
> > syzbot reported rfcomm_sock_setsockopt_old() is copying data without
> > checking user input length.
> >
> > BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
> > include/linux/sockptr.h:49 [inline]
> > BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
> > include/linux/sockptr.h:55 [inline]
> > BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old
> > net/bluetooth/rfcomm/sock.c:632 [inline]
> > BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70
> > net/bluetooth/rfcomm/sock.c:673
> > Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064
> >
> > Fixes: 9f2c8a03fbb3 ("Bluetooth: Replace RFCOMM link mode with security=
 level")
> > Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM conne=
ction setup")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> > ---
> >  net/bluetooth/rfcomm/sock.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
>
> This breaks the build on 5.15.y systems, did you test it?
>
> I'm dropping both patches now, please be more careful.
>
Apologies for the build breakage. I will be more careful in the future.
v5.15.y:
one patch is missing in v5.15.y. I have added that patch
https://lore.kernel.org/stable/20250124053306.5028-1-keerthana.kalyanasunda=
ram@broadcom.com/T/#t
v5.10.y:
No changes needed. you can pick the same patch from the email chain for v5.=
10.y

- Keerthana K

--0000000000000461eb062c6d3781
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGhTCCBG2g
AwIBAgIMD+aKIot+px9krlZuMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDkyM1oXDTI2MTEyOTA2NDkyM1owgcMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEiMCAGA1UEAxMZS2VlcnRoYW5hIEthbHlhbmFz
dW5kYXJhbTE1MDMGCSqGSIb3DQEJARYma2VlcnRoYW5hLmthbHlhbmFzdW5kYXJhbUBicm9hZGNv
bS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCzJUx8cxWWLKOtWyrWjmxtNemY
IAZzJtBCZUu44YcV0VWRTEyy7ETgVKv+gsS31DMOAW6riOQk4Kq1NwaqGpWcNeN4lDbjYNgdsVd+
o9k4EYujmMl0cgM7K7hzNddW+Ay96MU9XKfPz2sgaaEg+yf7Lc4qEJAHoeB0ZjdbljIIRWD7Y/NA
zvboOGCqVTtK/MDNUbO3DM22mnISOsFdyh2D45TWDZTwu4xaGvcSWxLWmvKT/F8eOAs9WQstDJfq
Tmu6blTu87+GvJDl7ve1uoTZ2v8iJJgVmw4FHt60UKs2YygdJ0VyVdlGaqP2t1tRmfUlu7CGVl1p
CsZtHLW+HDLdAgMBAAGjggHnMIIB4zAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGD
MEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2
c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9n
c2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgor
BgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9z
aXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWdu
LmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMDEGA1UdEQQqMCiBJmtlZXJ0aGFuYS5rYWx5YW5h
c3VuZGFyYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAAp
Np5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQHh8+7satHOJPcYL7AeQdvH3LpMDANBgkqhkiG
9w0BAQsFAAOCAgEAYWBk58l2FyT07DXkrrA2hlcTBcEZihWQx8/9g29moMSrBsNjKgfWEAXXBONl
VItnKxTO0LLFBDk0aORtQ77l8a5shNEChWVYr6HaQ4+yEzwgzGmYro7sX9H0WNhPYqGxkaOhvirw
pVpXqJuPEzKRu/cGLsd/0yta4ifC8tbv2NS+/0xF92mVwwFk/drV6gzbXet3UR0Oc4E8X6cuqker
//F6sqQvY8JqD4mfN+FYlRsJMJbaotK+vEh80P3H+DiIl5yMKVsV+IDp7lNqqEr8vp6x1Sd5+kqm
iw/P5dRLJ1fqzim8rqtJ/7qy6A7f9XW26mrfXgopzpH+PpyOWTNn+1WHE3Qsf56FygZkoyRkyNeg
LDRtQlfPVV4VzF2T4Isd4+38Ec+rpHUjh92yzjrf7FL1NWhk9Q7IEFNhX6Ss1VY+qawoyAwq3PCX
N38TFnsqQc+ulwWwKrr/UAidp1h/nDizvfesRK5Iy/qJ+ey9WDm2cuRgn9EKPN4hqc1KVeLWhMS5
2Q76mvXu00vebvmkm8gEOUWX/f/7sJ9OiTxEUFA914opWhBW681OZe8N3qTdG0WpE+Dwuz0tXpzB
QjeGoKexgsMfSRTmaxQT/YnlZiJPM3qfsvSl3wUoJ+GrMGtrszD3Ehg1jbcHkUM/n2fmYA4m1ObI
fGQEpn8e5I0CKl4xggJkMIICYAIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwP5ooi
i36nH2SuVm4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEcnk2xPXtybrdaR3wB2
WS2vjvj/FO5qokIXUORNYhsVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDEyNDA1NDQwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBvKBe0QoVAYeSCNiIJHZoksDwm9qK8wIeSvHJT
i2NZTXTYWk1d4kUlpaQWYiOvgI4lUvJkBOd55fJOp9yzA2+MfB2j+5zejSVdUtaP1adleGquurpU
hAegiGOjorjF3OzQsFvm5BiLAoKTSak3LM0sX+SmEwr317V9HMwuyjG/MK7dacz5lbUY3F+uaYoG
AlMmHGM0nUw/6XuJw91R+rU+X+SOIJ/ANTKL+aqgcGqcuTkpDgb0YC7vXtgvcUOWG371wK1XMxgA
gnnLhhpoE3hUmQs/lK/KHJj7HlwgWtrK8ZrYiCrwnsV6o5a4BDlvay+qYXSoeqEjpJwqLRWOutzo
--0000000000000461eb062c6d3781--

