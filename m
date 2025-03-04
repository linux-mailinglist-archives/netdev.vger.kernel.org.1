Return-Path: <netdev+bounces-171839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A763DA4F092
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B39A7A7B0C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6F1F666B;
	Tue,  4 Mar 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cWFCzu3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD01FC7F2
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127614; cv=none; b=hALUhpkQGbP0OLILvahm6/2qJDuI0+qs//L5eFyNUH3TGIbTVRHmKpvcLMuL4KSj+Cau3BuLWdxlWYyWWZ2Wd5p38TPAE0OLt2QopH35tNCvtMPKsepXgmuqZs65LYJivTviNNjxxSgcQm3lzCxY0hm3pLMJHPZzmPFbIrI9UcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127614; c=relaxed/simple;
	bh=OfF7QFDn7nynsDTI2RmRnrcuD2uoQtaB1eWadKUDfHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Enk1/EoeqOR+8ZCMHJN6sBW5C5hEhI8gKuftmDC7QCd6fzmV8b/M5JFGVE5oj2uqNKQr0isgX3WRlWHtjMwx2FrqU9Ktz8YtwOGb2HSxJaEnWycuR6aR2c2zjk7+4zUUiXBx+T44e1GgdchQjuN5EXw+DyVOzy4M962Kx1mDm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cWFCzu3R; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4ebc78da5so9115664a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 14:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741127611; x=1741732411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oc3Ix537qn5xWp0w/YNVbB/o6qiX++vXlgXliCA69Sk=;
        b=cWFCzu3RGxwpS3IOEceADWLBZaRCjYCWzSMcxvl1hHOsmUbw4ii8C35WzMeb5PG66z
         mnYRwwyc7AMdNGmGW6d/5nKBBj6fc98q8mYY4xzMYxCefH/3btj/m3ruvrg/43Wn2DeS
         w9CLabzFmH6sHtT8oMChdCS5TEotyPooOmAdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741127611; x=1741732411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oc3Ix537qn5xWp0w/YNVbB/o6qiX++vXlgXliCA69Sk=;
        b=slx4UDluFirmP+dMbWqZdu2HUKcXqUlmYVkQk7NUt3++rb+HcFWR+Gjv4uzb2hc2d7
         iY0GbF7V9AEdCP8Mpk441N1YGVOxlG74IqrznSgiMCObdkakV45Om21PhhBHIkhmG/sI
         stsC6P7uCcyLPuyQqaEokPNx4fwQvAjiGEUIH4jfOqPEJC5gkIxvwMjTizUuZgSzFBwA
         xDpVyKrfMYQcuiFqbjavNzCFUdNR0gQsob4Mr7BT+Tlkbapc19ZChTXbpgfmdKy742cS
         BqLHHy4NuDAPOcSAfwjeDZZzBwYRl5K6QVGimveirrK5cJOe2hv0vLkmo2p106865IJ3
         SMbw==
X-Forwarded-Encrypted: i=1; AJvYcCUIURexDcnTO272asji6XTRr25my8iFdeej89Lp3+bSrqTvBODbd8rTdq/Y5+BR12R2i36PvxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqDtpOJn5fiFRpv3birOMevfLXZ1pS4GgIvlTrNyOatcItNxi
	zqM2Cndsq5UybkfWSfYHkvu9rTuYhFYIHa3UrjuqeT6HiU9IfgUXyFxtDYb4vcp/dpuHEXX5S+B
	xFIDUmRpaEedrtxIdv9DC2qSFfffaNo5gTKml
X-Gm-Gg: ASbGncuMbzrJXideM7jW78gYR8DsHGMvgbIk3OVr/hxL/h3xj4p9TdT6+ub22Dx8YAk
	dPtHK8+vzqkWz1nT7Tmyw4Da/EMogOODXEtxKLM4k/gWad6NkRAH71V2ulCtKTsaUkBk/A+eUN+
	FoGC2f3uQKOeTO8bgdGqDzqmpENNQ=
X-Google-Smtp-Source: AGHT+IFSrZxP659b3lzGUwbl5YSmLZXFSrbRAwnQUziSFm8m21OUCAyAxDKAK1p3o9fkAW3O96E26qXJnThMWrU25lE=
X-Received: by 2002:a05:6402:5202:b0:5d9:cde9:29c6 with SMTP id
 4fb4d7f45d1cf-5e59f49851cmr757530a12.27.1741127610634; Tue, 04 Mar 2025
 14:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228012534.3460918-1-kuba@kernel.org> <20250228012534.3460918-8-kuba@kernel.org>
 <CACKFLikUqFVOkALJXX+_Tx=-hu=82u+ng4rnm7qgSHwiLr=gFw@mail.gmail.com>
 <20250303143214.7d6cd978@kernel.org> <CACKFLincuu+tqsWmJwSJ4tprf1OVT4BG489c3ZtcR1MM4HB19Q@mail.gmail.com>
In-Reply-To: <CACKFLincuu+tqsWmJwSJ4tprf1OVT4BG489c3ZtcR1MM4HB19Q@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 4 Mar 2025 14:33:18 -0800
X-Gm-Features: AQ5f1Jp5YB7pT103w_R3I8lwBvoKeOhDP9-o9HHpqr4GaJ68St66F7bSLsSLU1A
Message-ID: <CACKFLinCcTHcsGMLRiqFXXPodjscptWpZRi0rzn9g0USn1xg6w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/9] eth: bnxt: maintain rx pkt/byte stats in SW
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c45c35062f8bdca0"

--000000000000c45c35062f8bdca0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:38=E2=80=AFPM Michael Chan <michael.chan@broadcom.=
com> wrote:
>
> On Mon, Mar 3, 2025 at 2:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > Not 100% clear to me. I looked at nfp and a couple of Intel drivers
> > and if I read the code right they don't count VLAN tags if stripped.
> > I suspect that's what most drivers which count in SW will do, simply
> > because it's easier rather than intentional choice by their authors.
> >
> > Happy to change if you have a preference, but to spell it out my
> > understanding is that not counting stripped tags was more comment
> > and that's what I intended to implement here.
>
> I believe our hardware byte counters will count the VLAN tag, but let
> me double check on that to be certain.  I think for consistency, the
> software counters should match the hardware counters.

I've confirmed that our HW will count packet bytes on the network
side.  This means that the VLAN tag will be counted even if it gets
stripped on RX or inserted on TX.  This also means that padding bytes
inserted by the HW will be counted as well.  The driver only pads in
software TX packets less than 52 bytes.

I think it's better for SW stats to match HW stats.  Thanks.

--000000000000c45c35062f8bdca0
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPuO3fdRIKuqN39f4Tv6t+702RFp9fAe
4eOpE1jGA8oMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMw
NDIyMzMzMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAKPJjpzDTTclfF1b9TLmwpTW30BTkkSic9d5e1EhBsu8XtHmMDSksRh3S9U4Ya8L6DET
k4eoSMKL6J9ELbCpJQ3z/u5TsB4hIpLLoP/8BqFMneyaMGNBNOsOKUPnBcqVu8yGOIaUcHnwtJyK
fAvneVB1hD8x0jixkVhhhrd/gtXKYaHgaSjZCw3mQIL98XfAYzeLwY49YoUwIP0ng1J/7UXrnhow
2ojml59SJaI8B7aoDYtZYxzBJEaB/LwOhS8p1r/sem8Z+vuSbRmbfWesrxcaHnfjYtAoyoHOJrBg
VEw2HA26mMfYVjX8kIXWt1SP8RaClT/M9ZGvH6a9V7vt+UU=
--000000000000c45c35062f8bdca0--

