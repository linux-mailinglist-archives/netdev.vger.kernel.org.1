Return-Path: <netdev+bounces-172788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47DA56002
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 06:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535161895713
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 05:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770D2940D;
	Fri,  7 Mar 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HnD1HDGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC218BFF
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325416; cv=none; b=Y2Rc1rMJyLm7KmvOkbfNwxIuCn05BhykECTzZmlMrPRK5wIZkwiUL8JXqAFsREHe6582rNEMNFwqDtXb4OZu5gAt1b/HFgbOlOiz3bWsGo6bhXKArbdJNPDkq9h/Cdg9Ic6FS93x14a6j/IqaxnE0d61TDRtfXoe+DVQ+iimieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325416; c=relaxed/simple;
	bh=LlKf3tkF+OyHIiNSLi5BcVne10mp1gBFsNmvwqplMX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJxwcbPNU2iwoikUdA7uwrxpxvlfYhw6wxwG+hd9mOvJWQezkOXQO7dpPxQMIADgGAjAkI8J/jeZ1MMQglNqQisU/5fuzD2spNMG1nByCl2waJajA4iORwXpzj3T6hXppldgi9owYdqTkxeoWclzo2sdBgPIjVzziD+j6yuFoWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HnD1HDGq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so2670342a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 21:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741325412; x=1741930212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5OdEEX0A1E7fB+WrQ2xLELoD20zZW71WkQ5tEB3gbLc=;
        b=HnD1HDGqkUM6ZgjI6JxF7zoGhhFMDuLqQrf9ftK5Q0DY98l0QTp++P0HfX/HtxRGVX
         NwiE36x9QOke4BgzCibVvXHasSMuueQ/HDgU3KEcbVGErKq+eU7ZiWOlYeY2i8DV0702
         2L9VO5Arsq/VjAHddibIQ/H1UgtY+i10nV4d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741325412; x=1741930212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OdEEX0A1E7fB+WrQ2xLELoD20zZW71WkQ5tEB3gbLc=;
        b=Yr2vtGNaS4I3GhsrUHUknqXmNRxVc6j4engu/W/V7mniccubKInW7jSQADgyY6oy3U
         QyGuqLMZ5KScngF7cxcSqnbkjoiGHfGkqBkBaOt/E+4M5ne1MhI8Ysz/DnlpD9xNcS/i
         2uL+KApfHNtGV7uP5SgkTGiEUo2qIGytR7MI7d20r9YG7Pzg2eUwwSOjKcu+MFuKoFAc
         5l3PF0g0krN/aLtMLBazAbKT46FJ6pKBsnDWtVUv+WgTOF1ytra6yGGtXzzTZGKcQOQe
         XbnQtwBF6wm5Z3JAnl/lai6gJOiwxcDdRLEMudSREx5dnQJwFrF0Mv1ia1Zv/uVui/cg
         jJPg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Cac0VyB5xp2pAlxuz4HHLzSkbEM4ucy4J4G5kGGbYY1TuR2DT1r43vod7+gWuDQn6t/wpUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vMeFzeEWYdUjTrxlE/AEXgEd3SM5OWQPAzmF3Ui8iesIhhMp
	Wc9pbvm9JZLdVKCd3oL8fH2c81jinJqzhAlurTu4AHE+Iqsdw5gxKXwZPXaNwtDydql8K3wvPbE
	wBZv34mDQcYFQ4QM5DE8fh8aHitjwxhtXktda
X-Gm-Gg: ASbGncu5s5IRJTthKerAzcClv3Vh9gyioomQEq9v0yZRh4gLe5bgkG3xKXKDVxTQFxu
	RrONzLyddtpa+pIOUQKyxjdgofcy74MSr673EUDJ4hIc8nBzpc/g+UUKWWDH3IIsk1mFkU4an77
	um4o6716hDqWxIaQzr5c0ojtmJ
X-Google-Smtp-Source: AGHT+IF9px7PYEw8/fYDYFOnHAN6uDxRRBi9sUQuW2XnN9Fy841zOZNT79h/k2WSgiqiuiRe5WLc7VrVsJjhOdra57U=
X-Received: by 2002:a05:6402:35c3:b0:5e4:d5f2:9748 with SMTP id
 4fb4d7f45d1cf-5e5e24b39damr2288931a12.27.1741325412496; Thu, 06 Mar 2025
 21:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305225215.1567043-1-kuba@kernel.org> <CAMArcTWwuQ0F5-oVGVt9j-juqyrVibQObpG1Jvqfjc17CxS7Bg@mail.gmail.com>
 <20250306072459.658ca8eb@kernel.org> <CACKFLimCb_=c+RUr1mwXe3DAJe6Mg2DK9yYPCqRHtCLGVaGVPA@mail.gmail.com>
 <CAMArcTXYF5gV+_ukWcE9=_yfyXuNZ99t07CVcQde2n5x0SsH-g@mail.gmail.com>
In-Reply-To: <CAMArcTXYF5gV+_ukWcE9=_yfyXuNZ99t07CVcQde2n5x0SsH-g@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 6 Mar 2025 21:30:00 -0800
X-Gm-Features: AQ5f1Jo-TcPNWleZe7fRGMP6tUnSlmNb_A2OJ6H5w-D3oyE4DyZ1Pr3_VzXczh8
Message-ID: <CACKFLimQTjLwWyhw4ODD1VM2iW1eCeX1VqpU5ocRm9QRxMHR5w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/10] eth: bnxt: maintain basic pkt/byte
 counters in SW
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000abd9e6062fb9ea67"

--000000000000abd9e6062fb9ea67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 9:26=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> On Fri, Mar 7, 2025 at 4:25=E2=80=AFAM Michael Chan <michael.chan@broadco=
m.com> wrote:
> > Yes, we can check if (!bp->bnapi) and return early.
>
> Hi Jakub and Michael,
> Thanks a lot for the review!
>
> I checked that early return if the interface is down, It works well
> without any problem.
> So if you're okay with it, I would like to add this fix to my current pat=
chset.
> https://lore.kernel.org/netdev/20250306072422.3303386-1-ap420073@gmail.co=
m
>

Yes, please go ahead and add it.  Thanks.

--000000000000abd9e6062fb9ea67
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIO6/Zsj6PxD/lC+rmDeIFHzCVszbEPnh
TzL0h3xf5GybMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMw
NzA1MzAxMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAHyuKkzg3pGAaM+J/E0rdoZyOOpQXBmetbEyCIT3KNo5vBbspHRXmJrjlMfRN/JX/aNS
TmEaPvyIu547hPiM+iVjBa034z3rnQp4NIYy472bFC06sT6hHlcv70Xr3KqB4ZtHOOjU82Q0QTP1
IGholmJo4winOoSjl7QLMZb9l3z5hFazlLK4itYUOZRnH+jTsJN+/Ti9NCMz9/XBT72eNz41HV9A
LXw0o7sFabbrye3YrVQ40CkDR9Yw3fQzjXRw2wI2kkhvY0yVBS72ZyWk66BTenQRPya3zFCLNcAR
Ponhh1EG6yBXauKoZKP9xQ48V08EGHLk69e2226cnxBOPwo=
--000000000000abd9e6062fb9ea67--

