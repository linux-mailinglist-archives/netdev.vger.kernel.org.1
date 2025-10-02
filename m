Return-Path: <netdev+bounces-227607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A0BB350F
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 10:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15065545CE9
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237A62EA461;
	Thu,  2 Oct 2025 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MABi2FWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1502EA754
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393797; cv=none; b=eRwZUUisepPGUJKGevAEnR67WYGWFKum0M50VJs0vrS0dqVXlkh5zVRWgXmy+QrLZOHSsZ6yCzR8BwrhkRbcX5DQOsohiwI4pmXSL1QyNevZweuLN1nYdSG4iLaiekb3Uxzqy9JR1JNbfUYk5romh7FKuyMJ8KxzPs+fMX8x4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393797; c=relaxed/simple;
	bh=/9K1PBcQwq11suocDwVRQk2cM9OxGRXwVH/BPSXBkSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwjUi+zrSxdfez7UkAic5wwNc/PqwGJUgcSoHj/fSu0TnOgNS/RqQ+4KTmBELcRuMgLNJuLlbV72CAmIYQame+hsa2Qz3uSwKFOmQzn3ByZ1GHFbns64tn7D6WGFbZ0Hb5AhaKQ+q7nX9KvcWjHok/Zraw/egry7ZvlrvteZ9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MABi2FWH; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-938de0df471so63220939f.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 01:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393794; x=1759998594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/9K1PBcQwq11suocDwVRQk2cM9OxGRXwVH/BPSXBkSg=;
        b=vG8URNaqykhahcR0dnf8FZhBj7U+1XjJBt+RWYpjUEUvUnvw6ELFzpuDHPXajgcY72
         2JwtythZF95TGursgK6lAcxL+eyhVedWxgnEgBUZHZqvKiv0TX63vv4al/Qmk8DmX2NF
         iDqqqnGrp54MlMfA1WoBe00VWzFkP2RlG82FeDckeoyWzwi2gd+zNQHNZPvkt9Q01AlU
         peSH4q/Ge9iOAaxO10NZQNbejzU4kV0ZOWmwe+gCtKAy2EO74gdtBk1DCOuWKLGRhvZ1
         S9TWQbBQbno4Rfc+P1QUvvwhVFVBb4hG0lxftEzaQUK47Zry+J13lPwhklLa1cYlsqti
         Ta7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbvBJrlEuYErWNCvs199YMCU9clmgQHRwl+fy6aPxasZB/upzo1/q/YxZPhvYMnIphLonhU3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoWMHCztySovBO8eb01zU2soANLMaIhSRUzm/XX9rYp8U+cFzB
	jcUuNoGB8MOqsENdwc8ed/rAtXpxEoaNi3nK/QikvtaYDtiRpPAjoZ8ciQ1VMNCciDS3tgWxCeN
	yPXL25f4GyCmOHrROfB/Bob1wqDZAkZbuG682p2xkpnqEmmRd1iqveZV1qjAaVN/05ypA9kKPeC
	Dcw38Xp1Yrh6EM4gCv/yPXZZVdnAvD4e0rea7ylNhquMT2RNnNwBrxTZCQz7FvhYymBAe45MP8h
	76Ibmb14sQ=
X-Gm-Gg: ASbGncsGrAepS10y68Y6WQ1sARIIr6knba/DD+rNpZ/l8Id3TTg5AQoC0gCLkLExw/N
	9gCr/RLEd6SSMUZ95xXD7dFRiz29oSpDnlh6Ae1P+3CvhIefTrkOmlXcyhrudaKerRng4VqiXV4
	7200/XEskG1ZRIgbGgVF4AqO2F/rcgcKKhgDI+rjewCcbiekMFxiQtBl9hDzpBUKubDJcGQCNue
	PTnvNJl55lA9EHS9mmv13KKBhqYKNf8mJ8aPeG9V5oCbJygHUraTIUUX1IG6Hbt5R4naWcFpwwU
	r2aRb5NmU00mhr+MQGfVpZJwOptPN49gtUM5Qi0rWeS2ljnl9ABYxJNAmKh5iK4J5E66J44YU4D
	l9DSEVFXMGBR6WFe7NOEo4fl+hUXw1ku2nvTpAfQUEnejnPvDGvU2GKmM8ApxMl+5txfdoWBXxu
	C55w==
X-Google-Smtp-Source: AGHT+IEIbrn+1pU1mhTyddG3i7MPBhD4ci4MDZ9fgSAwMlbtKhvWjeHzkLlZ/16IOqcxRdYws7gDJG6RsSoD
X-Received: by 2002:a05:6602:360c:b0:920:87f9:5da8 with SMTP id ca18e2360f4ac-937af261542mr787571239f.13.1759393794608;
        Thu, 02 Oct 2025 01:29:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-93a85624c16sm7852639f.15.2025.10.02.01.29.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 01:29:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so1170988a91.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759393793; x=1759998593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9K1PBcQwq11suocDwVRQk2cM9OxGRXwVH/BPSXBkSg=;
        b=MABi2FWHvmPq+sYBAefHtzcl7K1fheoGoaStihXw61Rd3BJb7jBJWJzOsLG7zCzUVf
         HV4SLSdT17hjipvpy7dDBz7ukkaYGDvkhWI2FOlnr48EDyTGDlnqvidaUcRMk+xvDCoz
         YmGiDit4TQpHbv+31+RU17N7sM5OZNs5OqNt4=
X-Forwarded-Encrypted: i=1; AJvYcCWpAK4V3oonKNBD6zE5CZht2IW0YVTfOWATtAoXj8nvv20mdvKe5lre+tPHeEyMxtmqLdCTzKE=@vger.kernel.org
X-Received: by 2002:a17:90b:38c1:b0:330:a228:d32 with SMTP id 98e67ed59e1d1-339a6eac266mr7981924a91.10.1759393793109;
        Thu, 02 Oct 2025 01:29:53 -0700 (PDT)
X-Received: by 2002:a17:90b:38c1:b0:330:a228:d32 with SMTP id
 98e67ed59e1d1-339a6eac266mr7981899a91.10.1759393792681; Thu, 02 Oct 2025
 01:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
 <20250927093930.552191-5-pavan.chebbi@broadcom.com> <20251001160332.00000bbf@huawei.com>
In-Reply-To: <20251001160332.00000bbf@huawei.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 2 Oct 2025 13:59:40 +0530
X-Gm-Features: AS18NWC_KCst3sg04VCDDqJ6ZhD_ZK1tW7DyGtibeMJ1PuJqy_sN13lVkH0OoBQ
Message-ID: <CALs4sv1_gTr=ay0JcKwyVVoNUvFu_9CnT+D+tU+J20OoGUmN+w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/5] bnxt_fwctl: Add bnxt fwctl device
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com, 
	saeedm@nvidia.com, davem@davemloft.net, corbet@lwn.net, edumazet@google.com, 
	gospo@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, selvin.xavier@broadcom.com, 
	leon@kernel.org, kalesh-anakkur.purayil@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000014648f064028ca2c"

--00000000000014648f064028ca2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:33=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Sat, 27 Sep 2025 02:39:29 -0700
> Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>
> > Create bnxt_fwctl device. This will bind to bnxt's aux device.
> > On the upper edge, it will register with the fwctl subsystem.
> > It will make use of bnxt's ULP functions to send FW commands.
> >
> > Also move 'bnxt_aux_priv' definition required by bnxt_fwctl
> > from bnxt.h to ulp.h.
> >
> > Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>
> A few minor things inline.
>
> J

Thanks Jonathan for the additional comments. I will address them in
the next revision after
net-next opens.

--00000000000014648f064028ca2c
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDyLHTZ
Frn5bsc7NeYdJDNYpq6KJ9eEZnkyFcG2YugUdDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMDIwODI5NTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCHGRWsYH+WMEh7/etIFUp9ORbLNgC/Dm8Ky9jM2v30
mSPUN4NdepTFuxx4Sg+HQyEP2puigJPNnUIjN67OFjkzIwEP0FtELzYDuI/7zrqdCxHS1sgW6jTj
nwfrSN+jmXHrX9J/SYdbeLDOG8WWt52jCOdzuH/+cs7VNo+YYI47XReHepV//QlCJEnGlCCyOb+I
WFZhZqUoTHxQhs7L01ivyshOyPi4EONVbt8YFcZA8tncb3icaxizvmHDyweURgrS7JidSUpoAaVH
RTQpYU8/+nPivE5+PEHbuK19Y6Gk48Tz8WRIHqyHQLBUVL0hiTB/qKrPahBkctEf7L7hVgv+
--00000000000014648f064028ca2c--

