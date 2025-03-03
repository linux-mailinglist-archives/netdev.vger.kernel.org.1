Return-Path: <netdev+bounces-171104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17156A4B81E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD116D775
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246671E9B12;
	Mon,  3 Mar 2025 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T92x/fZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329E1E98FF
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985722; cv=none; b=IFrBET78sRoy+eEQ8XM5UJ6ocC8t+cz7QPz5X14R3/W/7p0jIg8TteC0Cm+EFPlu/7nHga5fdBV0EdPzHOy93qewlT0l2JaI1CG4PM2kxUYLplwbrd4+ywDbiaX7FfnmV+bW8lpXhDcc3+whVJvXtd0l4julIXnv0sAjpCToLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985722; c=relaxed/simple;
	bh=hxHueSEf1h7DWhnfjvMAFcUeBNI7wz1SFWUHRZHSG3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkUsay2s+XepIXpxDh6Ixq2y98zqBK19uD4HYKXSLri+2mDCZn8zELDzaxDKopqOqAVtAqz5yt2YYFcF2i8UwPeByL/EJA8XW7tD3X3oFNOSnXwkuEducWTMGP5+3th64wKWqGUNldqXIbkSdH73oPFQsp3cVWtq/+vXA9DmI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T92x/fZT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso1470747a12.2
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 23:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740985718; x=1741590518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hxHueSEf1h7DWhnfjvMAFcUeBNI7wz1SFWUHRZHSG3A=;
        b=T92x/fZTwO0xkQ9ROkHbWi+mo2Jc0Z5rGk6gH9z2fQJVZEFx5w2pfA5bnO9f/1C0y6
         GbVBvX3LA+n9WNqbzSdGzwpb4kzlmLES9REPrXqNpl+8ME8LRS5ftZislPAihpIWQxw/
         FXLPSbxRl86QWMpcQtZ5Un6HY6EYpaNtxZY9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985718; x=1741590518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxHueSEf1h7DWhnfjvMAFcUeBNI7wz1SFWUHRZHSG3A=;
        b=KMkmyIqGWOip1gRYRfj/SDThBwB80hSDWG/5EAs4wLbZCwaNFYTsh1fcP1sGWcwKrz
         L8fuKR0IKAfPbyNH8H13J7Ztb/8a+yE7kkSNEMzwHwVVrNQWW/KvofVpEIXN/pnRuf+I
         azor3Ll5cqv7zGIKd9hLba4fcq+EhXVCk/NvD32NLOZYk6OzHkvlDPkwWjTyvt/F85wQ
         9qSHTmjMsS/H2IQkBYPtdZ2GdlzKw2qxSjUCbF9JMh0Jvzv8cTWRZfXH2R68GX5Bkfew
         Wikpk9vfWv7gvkMkRx39WzhNo9lIPg9pwSE9bKeiWttMOdXi0ZX2v5fthOUuqAml2TxC
         tzZA==
X-Forwarded-Encrypted: i=1; AJvYcCVK6JFpy+3GeZgcG9sBlBn2lD4bpvjP4tgcu3fTWSShZJak/6MqBjoT2SXAUvXKjALwpmoEX6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZL2vwY5ojigCGfgjxl9V2j3lXQj6Ld/Q3qryQaZNJg7HIUd+
	qhMUuNJYll9bwSnnZUmoVkoYMJNAHXVC+V/MRBm/k2bDkmy31CzIqwCPo0oA7ImVd+hOqEgs6Om
	+S1GKr4uSfXH9FSqbdAdhGB2/dwC/LrZdp1M9
X-Gm-Gg: ASbGncv0YvP1ZWHOKWkPi4P57W1zPIqbpX3Hz8/D0bjEjg9oD5JmWkr3AFn7+hDCBOp
	vCv4UckXaJYTeqmQpIzH/LfLog13/o6igwfF4sc5oPAcLcAUsEKhm9d9H2OKoZaleVmWwHEXGvu
	ms6dG6x8sJEUQ5kcjdn1GIVCoB
X-Google-Smtp-Source: AGHT+IFCwBZSHhghBeD2u5RC498o+bHYl6FTcUG4WpHkgIGfYvwsk5DqEsPX14/wCzapMrZ3NvNtrvdN+UVQcX1kIO0=
X-Received: by 2002:a05:6402:2692:b0:5e0:60ed:f355 with SMTP id
 4fb4d7f45d1cf-5e4d6b0df3amr12853108a12.18.1740985718648; Sun, 02 Mar 2025
 23:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228012534.3460918-1-kuba@kernel.org> <20250228012534.3460918-9-kuba@kernel.org>
In-Reply-To: <20250228012534.3460918-9-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 2 Mar 2025 23:08:26 -0800
X-Gm-Features: AQ5f1Jo-JxnDzo-7VUmIOUNbCgZOXstTvrv91oLPgjhcEAiiZREbaHbXIewE-KI
Message-ID: <CACKFLimSmPkuckkOxi+N15DVWHwVEP5hr4qCF-su_uJEdidD-A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 8/9] eth: bnxt: maintain tx pkt/byte stats in SW
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005673d7062f6ad343"

--0000000000005673d7062f6ad343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Some workloads want to be able to track bandwidth utilization on
> the scale of 10s of msecs. Updating all HW stats at this rate is
> both hard and wasteful of PCIe bandwidth.
>
> Maintain basic Tx pkt/byte counters in software. ethtool -S will still
> show the HW stats, but qstats and rtnl stats will show SW statistics.
>
> We need to take care of TSO and VF representors, record relevant
> state in tx_buf to avoid touching potentially cold skb. Use existing
> holes in the struct (no size change). Note that according to TX_BD_HSIZE
> max header size is 255, so u8 should be enough.
>
> It's not obvious whether VF representor traffic should be counted,
> on one hand it doesn't belong to the local interface. On the other
> it does go thru normal queuing so Qdisc will show it. I opted to
> _not_ count it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Same VLAN comment for TX.

--0000000000005673d7062f6ad343
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBnkXO0wMSfX1a6xWs/Wa6ss2WMcB+pH
CIRi+XFqA0/7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMw
MzA3MDgzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBOg9NhyZQCDAGyvO1WWPnf2HhBh36AqexW47LNrHei99AfQCLB
iu9LxUD6Iv4PxmvIMdmiC59S5S/RbHHvavzd1lgV8A+rAaw5aDfNYXj0z46JjxkszlreMNMHjW2l
4v9vWpQYDeNRH9TabJ+WCoRlsSnRiUYRPD/3XQJ2d8kQ9M0XI9Nhb/iNN4+k6RkCZXNYbCbYnbkl
WLCs/za2ne7wwpJFJXVVjibfolpBstMIQJP5VC2LDXcxkdQQe5l8TPI7pgFFuaT9KBMdca3mMZzS
P1nC6O0m50rFmPdlc18ru48BwNNsFdY72suTsyl/EIczrJbOiR4iZ055Fw1Gxqo2
--0000000000005673d7062f6ad343--

