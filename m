Return-Path: <netdev+bounces-171103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0216A4B815
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC37C189128D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F91D6DDC;
	Mon,  3 Mar 2025 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hw2OVqlo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C84A3C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985604; cv=none; b=oLcutLUcoK25PQ6K3xgj8eZNMBWiu+0sQCAnG0zajiX/+RF/+0/J+mSg0Uo6mwsCMPtcyQlvq0t0ku0qacwDhLJIcNT1IXNZthDcMEHYtO2ykrdb0ZUXJbNW9eWGPYH7ka82BqPPdHS9tBBaiDsbd07XqPmHk1Ok43NGLGoAo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985604; c=relaxed/simple;
	bh=IRqAZ7CKtLmqGOJXFL7o7wvDwI8zrrkvfN8dH9XrUEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omSYH9Bqwd7mK4JOc0FG8KSu+hRK6at2FNdF8aNkOWWA7bKYfeJnGizzyqe/tYfXgxKAm8ZEqRuMqE3Kk/ImqEtwr864aRbu0GJSz9dIr0rKEIZipX5if26dY25SuaK2hIbB7TYL9y7dF79W7VChu5rwcruINm6Sj54x7FeaHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hw2OVqlo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e55ec94962so551124a12.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 23:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740985601; x=1741590401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydpPPAVVIbczNydhRAMrxedYE6w5x7xRraUtfZ6fRAw=;
        b=Hw2OVqloacYbrSNwvQk4Y5c5CToPr5fhOL34XIVdfOjq1rhlg/18XDsh6L4I7u1Nct
         G6kWbhbZL1a5VURx8whhmMRrqhNroTv+nw67aH4X9YpMKGwRsBCoAn03foY7r6fx2Bbq
         4UQu/Zl97e4g6ewKs2jwRifv7WEn4hDdrzWRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985601; x=1741590401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydpPPAVVIbczNydhRAMrxedYE6w5x7xRraUtfZ6fRAw=;
        b=Gmt3fohL5eN0FPFqRJPozxl+MdERRF1Npg2JFsVz18l57ijHg+KhDPaLTnOLyHJmyj
         Bw3ueslq4Aj0vgfKo76p3gYpTSUgd+PX7iCTOgMKIuRqFP6kXdbtPuBfiJqq1nB2gjtK
         BmaSnjWOgZFsOZhRZpKJ7fdNO2+l3vOU7cIOjuvH/As0EZjFAeCb4iP+rvWkOh8sqaqW
         kfcOyg6Pdwoq7W39BbOZcbngIDtmLi36XNiHor3i8DHkFuEGSpt0Zfc3mVxErZ1n631B
         17a3Ct/VLNXobiViwpCxr5DDCf/sz3jwgh0ffShZucmbrdt2QzmMfr6A1nyc2T6zlDvi
         e0KA==
X-Forwarded-Encrypted: i=1; AJvYcCWQQhFtJTRyGxpwBa88U76AZaJ4NM8YKQWGH1pQcTH6VDwU3uNURUGh5g+b0NxpyFd7SUWLjws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzfxTPAmq2jtB7xKHq793FvawD8+1yuyPSVgOUR57ZO7qHeQO
	5AuHSOKx2YWsCJ3FMzLLa0/Rh1kQeu51X34zE+A9vkZN+ILqA/KAsmKYYC1PHCt47RD6qk+vtEg
	u0uCPGmLoM4lYcFXDxPSt7AAlcSPmq6/8bJ+S
X-Gm-Gg: ASbGncubf6MZhqNxsFzNPpDKUA0WmXfr/tRGprPEZ3Ggeh78AUnR821rAoHtMbhKi4T
	PLIS87H+eF7hroMT6AegqmfGmwWwBeJM7LlfCAxEU2MyzCkeE8C/0QJLsUqNKkJ63FThIDNnAU8
	bEjvQE9Gh4A6av97EY6slXCyRe
X-Google-Smtp-Source: AGHT+IELLTH+Wp1wjlx3qfsnSySIvzFxr66L5+J3DyF/gnSko5enR1K7GDXG7uOkaDyX+HZw0YXPzBclBelGQDLU/z4=
X-Received: by 2002:a05:6402:4603:b0:5e5:4807:5441 with SMTP id
 4fb4d7f45d1cf-5e5480755bfmr2900068a12.30.1740985601425; Sun, 02 Mar 2025
 23:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228012534.3460918-1-kuba@kernel.org> <20250228012534.3460918-8-kuba@kernel.org>
In-Reply-To: <20250228012534.3460918-8-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 2 Mar 2025 23:06:29 -0800
X-Gm-Features: AQ5f1JprpnPcADyBZHf4-kkQ57YUCFlEcHxDctITwt4E0QizDFWlYnbci0JoZCY
Message-ID: <CACKFLikUqFVOkALJXX+_Tx=-hu=82u+ng4rnm7qgSHwiLr=gFw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/9] eth: bnxt: maintain rx pkt/byte stats in SW
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000059ac96062f6accba"

--00000000000059ac96062f6accba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Some workloads want to be able to track bandwidth utilization on
> the scale of 10s of msecs. Updating all HW stats at this rate is
> both hard and wasteful of PCIe bandwidth.
>
> Maintain basic Rx pkt/byte counters in software. ethtool -S will still
> show the HW stats, but qstats and rtnl stats will show SW statistics.
>
> We need to take care of HW-GRO, XDP and VF representors. Per netdev
> qstat definition Rx stats should reflect packets passed to XDP (if
> active, otherwise to the stack). XDP and GRO do not interoperate
> in bnxt, so we need to count the packets in a few places.
> Add a helper and call it where needed.
>
> Do not count VF representor traffic as traffic for the main netdev.
>
> The stats are added towards the end of the struct since ethtool
> code expects existing members to be first.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

The byte counting looks correct except for VLAN packets with the VLAN
tag stripped.  Do we want to count the 4 bytes for the VLAN tag?

--00000000000059ac96062f6accba
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGgWWIY5gHjDF9EGXYzbhSATtOEcMrSz
ogphv9QSR1ULMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMw
MzA3MDY0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCXuLshMIF6dllSRXC5Vi3uj5qfmOPQOpOfjHrgZKMLr5fraloT
EPi0xk9zrKF6DkuhdG5KUdg0G/Q96Xo0ix7lFomM55bHWQD2QkEYPxM7Llc+4+WI1OTnpI9rFiLk
XhGhAiqskvpZrEhmseKHVkrV1s9PYePh2BrnqhaosOA5nAeQsok3YQhFHXdZ+T2lL+sPxs/gTn9y
TwNhrocVsRYVH+lTGPKQ5Cz0gQG4kME+RXRpsxy7Y9Zt+s0pk1YY2fBmtNG6RE7J2u79PyeSu27+
egf+zauOuV9gXKSjrpD/gzhi3zuNC1LHUjvrCFDDAtQKOYGfkI6xrB0xVPtshnNg
--00000000000059ac96062f6accba--

