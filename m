Return-Path: <netdev+bounces-230488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF2BE91AE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC61E4070D9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C2A369998;
	Fri, 17 Oct 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PEm6P+FM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9A2F6911
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710103; cv=none; b=Hhp4Na536xZT9EamqDIsN4KvDVzcBebQFbUxMI3i9HMkQMT1j1p80hXjiYaqATFWrBoQyvjdY3c0f9TgXpHgIb/qmkX6t+bjyt4817OOCKzmQw0+Equ6Sw/dlUEGVbcic6aqJ5I9ozLoJPzP8j4pJx2KbK4cYNWrEF22dFleblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710103; c=relaxed/simple;
	bh=HDIwo7ElB6ek4TmnWLMN+Q1ZiK0TvAI4BzIS1Cr2Ht8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S64a68/zT1CDndboFL9M7LsNGlJDHx1NfNl6dAz4+LEo8pOwu8xCH8FRyYIM4T4tqm9WL2z6yhV75MwQC7KGMiluDUpiO1kZ5xbmRK94qdywfPeCgMYLiED/w4SEAnEhxpsqvnd49Q2ZdwnzsX/PLHviiUMjoPoST8GQ4++5qoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PEm6P+FM; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-269639879c3so18487575ad.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710101; x=1761314901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HDIwo7ElB6ek4TmnWLMN+Q1ZiK0TvAI4BzIS1Cr2Ht8=;
        b=Amm2teV0rzWoXyXIZ1qsM0IbaqYWpREC2ivMFql/HIS70V5/lSBgLj3ARrOMPdZZlr
         i/df5Jq7Yjun15Uga0ukaBsdzMObQgxS+FBk07XWP+CHpiZZQnKB5IzEWe1x4M+WQmf5
         iJyp7RvCQJX772brq+2zLj/5q5baCJORs5S9lvXQ8nnj26nS7JwAYAMsOLpmJL0QxB7V
         2rNe1PKzGkcoLmrpywVM3rMdWhlLlX37K4xh83CnyUnFJSOcw4eU7II7Qq16MEaaaRtd
         FIVUkJWMej97sBPpfqfZ4eZxlLeoLY+nQfgKzGTvRMUFTSzUITDjszJf4wsBTE7XuvpS
         tgUA==
X-Forwarded-Encrypted: i=1; AJvYcCX0y/FrAGlxn1vsA68dMCQnr59QlqH0VELhOWNTaqkzQDJ5sgS/nQsbO7MPxCTJNwPk9qtkq8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3/6MmEdRbfApGNTS+K2RphIqeGrw1XQ8tAXRHrFmvSGe9IaX
	KPrRVTTRCKbGpgZcg/omKJClXxdaGCKO5SlRuwK9NIQXvu2uDaua5CH+tkjMD8RvDYa//O2i1EY
	UpQUWmEqQbV+60qqFIr1wzeGu4YfRbiibUq2FxZYXbFV8EJwEM0YSW0vW96mxJ6s+iarcAPvL7u
	EpAH3Uxr2BPXHo1UBfDcE78MgxTu7tUC0FHKQWh0XKVhmgPJbpRsACpRI0N3lgAF9IZ60ucoRYF
	Nv/8zh+mdGqiw==
X-Gm-Gg: ASbGnctGNXBsrfWkxq2hbsX9c1tcFbqYys/5DR7JNujNoIKg70BBM5gPTDinegCn71Z
	HMI1GA2SAI6bKxAd4U0doGo6ttvs+lgPxk944qXY0EJ7a1z3Ttx6nb1LtrihE59TVHHifFvnYuL
	37Dnj5ah2odfBrOpn7Awh8Lr6gaAa5+y+5fIxMA3R0gpUd/BclVPBEELrLETP7Rp8V75AazGlnz
	RUPPG0SqR0ZRk8jBDwoDXzvTLtzkPF5/1XEgjT9stIRhASwHv3o2YD4BBcB7GPbu2iItgoTUkaB
	HS0kl9D/ek8/nqlKUMRvX2DR6ZL8qhF9XsilMPvCv+vjE86yzY6WN3Oy0eBYaNZbWi1bkcev/Z8
	goYpWxqvBDid2+pZYtKJdgelG9FgyWFVy8wjs5jXgeFmHSSEVOj/ygHMHsav7QPJKiO3Oe9rzqK
	a2rY4aT5VBTU3kzuaGb8pTqpPP71MiSWuGNynD
X-Google-Smtp-Source: AGHT+IFk3HRAkRoQIoJfnqA+K7frRBVTWR+Vir+Zja5k/JeJuUgl38THOe/suHPxmbQXcy1JsBU/FQ6uMOJQ
X-Received: by 2002:a17:903:19e5:b0:265:89c:251b with SMTP id d9443c01a7336-290caf8519dmr46083615ad.29.1760710100426;
        Fri, 17 Oct 2025 07:08:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29099ab9965sm6487155ad.63.2025.10.17.07.08.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Oct 2025 07:08:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5516e33800so2746706a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760710098; x=1761314898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HDIwo7ElB6ek4TmnWLMN+Q1ZiK0TvAI4BzIS1Cr2Ht8=;
        b=PEm6P+FMMRUBTOhs68u/qhGNP0GPKx9Ccm7HJgvikkkPrmHHeQ3ULz5cNr8e04h6oF
         FPr7TGRXWQ+1Hv0fjbyXGzMyYXEIJZJj6JmrL+68NUSYa50RbO48DHxx6ahQn9stclJ6
         KC9NQKPSSH5Y0Fy0t6iEse/k+nQ/k36jZ+xFU=
X-Forwarded-Encrypted: i=1; AJvYcCVDQprzUnoUr5D7mGbRWgAchlNThaDbRxgmutKANe01V3qU3CwuxdjsDfQO4LliFGLP1YKRXLA=@vger.kernel.org
X-Received: by 2002:a17:903:b0e:b0:290:c76f:d2ac with SMTP id d9443c01a7336-290cb65c5dbmr48013655ad.43.1760710098499;
        Fri, 17 Oct 2025 07:08:18 -0700 (PDT)
X-Received: by 2002:a17:903:b0e:b0:290:c76f:d2ac with SMTP id
 d9443c01a7336-290cb65c5dbmr48013185ad.43.1760710097961; Fri, 17 Oct 2025
 07:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
 <CALs4sv2gcHTpGRhZOPQqd+JrNnL05xLFYWB3uaznNbcGt=x03A@mail.gmail.com>
 <20f633b9-8a49-4240-8cb8-00309081ab73@linux.dev> <CALs4sv0ehFVMMB2HPqUkGnv5iRW-VYKpeFf3QtRDgThVH=XQYQ@mail.gmail.com>
 <f1c42ecd-57c0-4cea-906e-aebcd583944a@linux.dev>
In-Reply-To: <f1c42ecd-57c0-4cea-906e-aebcd583944a@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 17 Oct 2025 19:38:07 +0530
X-Gm-Features: AS18NWBw1qrRmSVmMyY0MOrLxAan7c4EW_yx9S3u5a-DfwSeNOXHjb7zFODbl8E
Message-ID: <CALs4sv3OV-VVYS7oy1akiZdQncsmqY+hqds7NLeiy3oh3Awz8w@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: support PPS in/out on all pins
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ffd2b306415b43f9"

--000000000000ffd2b306415b43f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 4:10=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 17/10/2025 10:15, Pavan Chebbi wrote:
> > On Fri, Oct 17, 2025 at 2:21=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 17.10.2025 04:45, Pavan Chebbi wrote:
> >>> On Fri, Oct 17, 2025 at 3:54=E2=80=AFAM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> n_ext_ts and n_per_out from ptp_clock_caps are checked as a max numb=
er
> >>>> of pins rather than max number of active pins.
> >>>
> >>> I am not 100pc sure. How is n_pins going to be different then?
> >>> https://elixir.bootlin.com/linux/v6.17/source/include/linux/ptp_clock=
_kernel.h#L69
> >>
> >> So in general it's more for the case where HW has pins connected throu=
gh mux to
> >> the DPLL channels. According to the bnxt_ptp_cfg_pin() bnxt HW has pin=
s
> >> hardwired to channels and NVM has pre-defined configuration of pins' f=
unctions.
> >>
> >> [host ~]# ./testptp -d /dev/ptp2 -l
> >> name bnxt_pps0 index 0 func 0 chan 0
> >> name bnxt_pps1 index 1 func 0 chan 1
> >> name bnxt_pps2 index 2 func 0 chan 2
> >> name bnxt_pps3 index 3 func 0 chan 3
> >>
> >> without the change user cannot configure EXTTS or PEROUT function on p=
ins
> >> 1-3 preserving channels 1-3 on them.
> >>
> >> The user can actually use channel 0 on every pin because bnxt driver d=
oesn't
> >> care about channels at all, but it's a bit confusing that it sets up d=
ifferent
> >> channels during init phase.
> >
> > You are right that we don't care about the channels. So I think
> > ideally it should have been set to 0 for all the pins.
> > Does that not make a better fix? Meaning to say, we don't care about
> > the channel but/therefore please use 0 for all pins.
> > What I am not sure about the proposed change in your patch is that it
> > may be overriding the definition of the n_ext_ts and n_per_out in
> > order to provide flexibility to users to change channels, no?
>
> Well, yeah, the overriding exists, but that's mostly the artifact of not
> so flexible API. But I agree, we can improve init part to make it clear.
> But one more thing has just come to my mind - is it
> really possible to configure PPS-in/PPS-out on pins 0-1?
> AFAIU, there are functions assigned to each pin, which can only be
> enabled or disabled by the user-space app, and in this case
> bnxt_ptp_verify() should be improved to validate function per pin,
> right?
>
The pin config was really flexible because we implemented it first for
575xx chipsets. We could remap the functions on Thor1.
With 576xx, what you are saying is true. The pin functions are fixed.
If the user is aware of the functions, then it's not a problem.
But yes, because there is verify() available, we can always validate.
So we can improve the bnxt_ptp_verify()

--000000000000ffd2b306415b43f9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBD79Rt
TKRZxvBeRZ8qVJt5X/nWJk5NQj0iHFuRY6uwfTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTcxNDA4MThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCfLEJdozCPCP/ZbtFVIfbRw+XmMWSlSFeE1sd41xNa
bJnkH3Vi2i/vhXFvl6DBJIp9k0V7hcLmJbVNnVaP00Z1z7mevKzU0F73qob+EWPEAdWgLA4BfKbb
ZfQGiyGhBSaFgQiJfrs+05pkGcixGTnOnFdbULL2usB1pZdqhn5bIOPIWGk72I8kdiQ8W6kYBuzu
JOIH+Xt2b0xw4s+tVnN2QQ7PW8Th8oQTxUNUZ/ZRkCFPCOr3uVDjProp7u0EGufbQca6SxhUtpAG
ZWYpvEl6TjoLEoqN5NMNTr62uirNtfamKamvw1eUss53Ot1rjpa2a1MStx3cwOC08QWSrb+a
--000000000000ffd2b306415b43f9--

