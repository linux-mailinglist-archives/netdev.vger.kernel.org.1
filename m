Return-Path: <netdev+bounces-142060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF69BD3C2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1662D1C227C2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2118D1E47B6;
	Tue,  5 Nov 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K6YzTIFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67F84D02
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829025; cv=none; b=bBhE3Ja1FeyaWRosFXsv1+GS5UKpzWNwMhpQt+kktS20yxVsqcgcK8GYJhTBkvaj4HioopdadjTsGXHPGkfld8sVeo6jKAEUSFnfnMeBYQAokfJnxChERqELwj+vjc8vmw+H2RfM/UB7/kkeJFUWsreB6oMryAXl53CsZhrYTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829025; c=relaxed/simple;
	bh=tv+QSYVdZt8xdIeRD7FlqxcLyIYjjp3MZVNuADMsQlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIRWoWHNELtGHOwv+ZS9H6kq9pIMztq23fR2JxjdwzwYgVq/lOI/hxPKcna5vj1XIR//6fZXZ/uPcTXUQOikdw0BLfoHsZNiXboGPa73+Kko3smLBvVDxg0J2YvGHiVNRvBpKiNtUbX2QMLcZMiOlvfLqoodNcMo6fLsqg+Xc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K6YzTIFT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so48990a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730829020; x=1731433820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MB2ji4BTtaWFky5q1uEO5vdOdBhfjBoIv3eCxfSHdk=;
        b=K6YzTIFT//7mSUksvlhImZCkJCgKiPNMnASUEMV+LMp7gRj6ZNYXmoYSNqBgpOvhot
         zv6q940JqxuGaB9CguDzQSTBh+Y09wrkb6l7/sYTbkrtdQhtwk+zoZKmBmCtzPKn5BZG
         15mcTeqnp3LTYUoDHNGUghEwiG1ox4KMqjs/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829020; x=1731433820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MB2ji4BTtaWFky5q1uEO5vdOdBhfjBoIv3eCxfSHdk=;
        b=JJzzOzSsT+DOZyZKWnDw1K9cqY55BUyPVXoSiFTQc3PAQSgFCXq+yd7Joxtmz/8aVc
         w8kn8rKNWPbiR5v54+fQvfYq4GsXb/eL/5X/tPs7F6vXLMKpknqVp4g02G3QoXsH94TF
         duq1uUDOc3qAYqhTmtsis8Kk1B7D6sVXD7/A3TsvcLkoIhnH6r5KIL7PPuA6wlznFC+h
         tRD6DvSmkQs+wN3Yt6uIMBr894eU5+ovDQ8M03SDL66Sqk7lSvyjTZRYAQbkVm3ssPEk
         xot+Twc/pWsKpiiJascas/TV4zYRifC4fTucDHmt5QMoDpOu/43BXP7Wyn8CVyC07xHF
         xyRw==
X-Forwarded-Encrypted: i=1; AJvYcCWZdRqS6qOfioZiZWHE7Csx2tuMZNKeZ1OFPft81kUuE/AhFFwkiAs2lRX7IPpOpgnxTqfJPHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13TQzg7YSPc8QmG33gQngJAWCmjLp60wKXJC1u8UM8ONCEGPn
	1VHAGqHqzhR0lLwmogZT0GNq7ZdjvKLoB01k0JA/Sb7m6OOerMcvaigd1Tq9sZmp9nC5H3BBch/
	BibYtzNd9FqRQft6JhGATeypKpJw875ostJMBx38nKdxNsW0=
X-Google-Smtp-Source: AGHT+IGib+ypX3zwZkwOabdH5bZmS1m/H4cuZ/Mt3hXplqrZKWLZr6R7sKDEis3+TsCN8pZI5fvpX5751PHR3+u+NH0=
X-Received: by 2002:a05:6402:514e:b0:5c9:85e8:ec8c with SMTP id
 4fb4d7f45d1cf-5ceabf0d370mr16488181a12.6.1730829020366; Tue, 05 Nov 2024
 09:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730778566.git.dxu@dxuuu.xyz> <1ac93a2836b25f79e7045f8874d9a17875229ffc.1730778566.git.dxu@dxuuu.xyz>
In-Reply-To: <1ac93a2836b25f79e7045f8874d9a17875229ffc.1730778566.git.dxu@dxuuu.xyz>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 5 Nov 2024 09:50:09 -0800
Message-ID: <CACKFLik+Jpm8BoQzG4ZteRyRZHs=APbU2w+N5uNg5ny9=YxOwA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: ethtool: Support unset l4proto
 on ip4/ip6 ntuple rules
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f24dc306262e080c"

--000000000000f24dc306262e080c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 8:13=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Previously, trying to insert an ip4/ip6 ntuple rule with an unset
> l4proto would get rejected with -EOPNOTSUPP. For example, the following
> would fail:
>
>     ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
>
> The reason was that all the l4proto validation was being run despite the
> l4proto mask being set to 0x0. Fix by respecting the mask on l4proto and
> treating a mask of 0x0 as wildcard l4proto.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

I just realized that we don't allow l4_proto 6 and 17 for TCP and UDP.
It's been this way since the feature was added.  I can add it later to
make it more complete.  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000f24dc306262e080c
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBwG06mIZAhHNOVujHzJuEsjO+Lfy7li
lEAGQ3ii+N+oMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
NTE3NTAyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCCH7a4mx9SsbiqPMR+gI3XcnW7Lcz0XJHVEf/LijIdkcJdoh4T
Mcdh6ZDR3ALDNNxhqSXRoBiijxdZJhh7IO8v/on6PsBktiC286GqkqOb/qKTRjXcEScID4MvSUi/
9WKihIU5IQDXJl+fhIwRJVZ5qjk5JEDSM+XXVB0LWl9Z7OkH/C7g9ULeMLUiG3RorjkILbl3XBcn
TOrvutzEhgsfwBoEUSYl3dpEJpHj8L+RVIUg9G3pWSWDG3SHKRfwQyW9EPLPGFCVYaJQfkZgYr/f
0fAxWhzpUI+pufLQ5ny0NWehf95/QvNUjmTGhw495QsGoGVqeNescqI8pP0yMvvh
--000000000000f24dc306262e080c--

