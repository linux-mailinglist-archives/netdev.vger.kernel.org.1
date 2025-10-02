Return-Path: <netdev+bounces-227602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F175FBB33AA
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 10:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1338119E30AA
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49A2F25E1;
	Thu,  2 Oct 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IhN8Wqv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA42F1FE6
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393199; cv=none; b=Zus16ivuQ24g1s8cXxPYYxoQelTD687Y82kp9WdV9tXGqbwjgSfgRoR6Au/rCAW68Z9St3lN6P1mW1H/EY4A/yM+EmoRBeXJ2hAm6VWcvrsqLHxtbbPPm4Amm8NBsoKT4aP9MKzX7pwcchhqc0jZjzJ1ZiJRqG8fMXq/x384kgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393199; c=relaxed/simple;
	bh=O6TvkM/2FWGm93qq4o2sRnSBWIvT5G3uevy/t8vQ+BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAQ0WkKZaPvP3yv0+Wz04ZTAYmd8TRirzGQmHjmdUFDJKs+Hy0LzbCSgoikhMTBV0YZbwmRAPWhPILIfegojDX+G5033QHp9JrNxYw0OLPJitmXzqPPV2cMMec4XcmgCtbdX0ZIh6XByhlX8zg5oqm9AFdIe45nyg7Cyn1W6k5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IhN8Wqv+; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-27c369f8986so7077765ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 01:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393197; x=1759997997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4GLL5higtQjWAWyL1TJchE0N57LbbfXbPv4jOoLis3I=;
        b=Dm52DmecYm3jo0mvNmGDQ3WyU3hxYI8/fEAkPZgnmZ8+FHx64/V5P+QlgqgssXY1j5
         x0a49fIDqneKwUS8NQxI7tj6COHOzpM42940m3X+qp90P09ZYSVTSIsp2nJkzB8UAzWV
         6CB9mwweoXUB1QM0PDcXYzfjt5P9BkNIIccmdcU5N1okbhm2NQG5oiq3gITAAByP9WT+
         rwIjCZvfRne5amnoKzg8XQvjjZOe36YYhrZr623ldtX7T+zZbXzRsKzDFENtSFjjP//L
         XgBeGwMOifY5CyCSihqKd5rqpQFYWNC3u7EBguJyoqWDbrSA5T2LQuWx5HN5GUudZPE4
         j/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQh/rL1CUAU1pK3J+xPtImczrFcjma4K7Mzk6kc5U5L2qaytczDnMLySftY9sP2UKiY72A7Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzodheg4BLTGn5EO0UEV0Z4Ooc64cwlg/Sj+fV7nGdwMAS5xx2g
	hYm4npi8oXNepRorr4j5AxRd6+uxCX1YCFS//bJa7WfQSJM/zPBd4kqPldHGIlgfuBEscQdCkkY
	xFpF6XbV4zdahICrpeyNlHSyVZO9CZup3ZX9FP0wNt4HN13ZytZqK1Y24pNBJMJgc9pOLry9NIQ
	HQ/P2vgKIH37W22x7FV4NDyDW7ZdMxR6tEFObMnkAvl7XR291R2oDBaG2iU+r7B+KbXrggiaCDV
	r7A+2ShIPI=
X-Gm-Gg: ASbGnctz2IcYNBHL5XPz9RGhymmqGKZiEDtBNwvB/C6hi5kn3BNtyMS4wi+UG6oHfOb
	FDp4YQ/WMcVbt0cE7zPGaf8eXquVOj0jJECG4Itvpjo27NbPZGOU9BVJV6VnFWsFJBZQTRBUrVj
	+/HzlryV2zYycZ0bH2xKIg7WEIVWCLNs14C1LNpPQ+14JejESJcA2+/uMKafnMlSufw61gcKGQB
	aQBVAUU6tLK8m33iCPs0DTMqNOhZz9F4VFshxzNcCtwzPxJ5gFg39nhh5vY/V33KO/deC+N23J6
	PVrZXpcbqLC4N6tcwaybIIXsZyf5p6H0Lz2byBGlKzD3f9Cc2dv0kZeUUp0t84ZxdbcVV1SVkIG
	zlI/jetSsSyCpBpk7N5a0ZXgJzLrNypvl4SW326Dsc58FzAQUSP0Uu5tqV/ACAZ33T2XPqmvvQV
	T/ZNJELa0=
X-Google-Smtp-Source: AGHT+IEf7AgX/l2e+SXoZ0n9lLkmHSxeM/aCvTpnEixhZ6p32upV90L4QhHXQ2JYsSlOEVQ08IUdnCF+tsw0
X-Received: by 2002:a17:903:350d:b0:26b:3aab:f6b8 with SMTP id d9443c01a7336-28e7f4444d1mr82181615ad.58.1759393197172;
        Thu, 02 Oct 2025 01:19:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-28e8d1b1b57sm1268235ad.66.2025.10.02.01.19.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 01:19:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso1299918a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759393195; x=1759997995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4GLL5higtQjWAWyL1TJchE0N57LbbfXbPv4jOoLis3I=;
        b=IhN8Wqv+NKpHIGTWeUxaws9BJb0LnxgZddpWHmJ515NYegzrmB/lKTREFef1DHGlxG
         9Nt/g+mJq3q6Jnioni8ecqhe2x6KM79sxETy8IKPkj8/8gTMJPxj1v2q8jO706hWaDQZ
         dxJPz/bbVaUZx9+qXS9cESc6HwwZCyivFWAeU=
X-Forwarded-Encrypted: i=1; AJvYcCUz5xR3l2iH5rylVrMLf7LnuIPJCmOACycK7na926mBShPlXUVesbCxQ28y/uWZzSXUlfkShFA=@vger.kernel.org
X-Received: by 2002:a05:6a21:6b16:b0:2fc:660a:23f0 with SMTP id adf61e73a8af0-321e7e3f594mr9722677637.46.1759393195527;
        Thu, 02 Oct 2025 01:19:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b16:b0:2fc:660a:23f0 with SMTP id
 adf61e73a8af0-321e7e3f594mr9722653637.46.1759393195174; Thu, 02 Oct 2025
 01:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
 <20250922090851.719913-3-pavan.chebbi@broadcom.com> <20250929190601.GC324804@unreal>
In-Reply-To: <20250929190601.GC324804@unreal>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 2 Oct 2025 13:49:43 +0530
X-Gm-Features: AS18NWC2EIqD_d_JOVW8TmijPs5mMgn-sbox26ARRmiCv2JESdSzfruQuocfoXg
Message-ID: <CALs4sv1fgxciFsdxj=5C2HD7HKxHt7Z9t8CNNe6Q+Q6bz-FAKw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] bnxt_en: Refactor aux bus functions to be generic
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com, 
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net, 
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000742b6d064028a640"

--000000000000742b6d064028a640
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:36=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> > index 992eec874345..665850753f90 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> > @@ -27,11 +27,11 @@
> >  #include "bnxt.h"
> >  #include "bnxt_hwrm.h"
> >
> > -static DEFINE_IDA(bnxt_aux_dev_ids);
> > +static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
>
> I would argue that this complexity is not needed, so this and following
> two patches are very questionable.
>
> 1. The desire is to generate IDs inside auxiliary_device_create() functio=
n
> and not create IDA per-driver or like in this case per-auxdevice.

Thanks Leon, this corrects my understanding.

> 2. You are not expected to mix both function pointers and auxdevices
> which pretends to be separate devices with separate drivers. Core code
> shouldn't call to auxdevice to avoid circular dependency. Auxdevice is
> expected to call to core device instead.

I went through the history of how the aux was implemented in bnxt and it's
because we need to space out init and add, the core maintains the pointers
to aux devices. I added additional pointers for the new aux device but I do=
 see
scope to improve my patch to avoid circular calls. I will be back with v5 a=
fter
net-next opens.

>
> Thanks

--000000000000742b6d064028a640
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD/Mgqg
ITtHh2dGBx9EpF4qLlUhiF4tD3ypdLnFq7VCyDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMDIwODE5NTVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB5pI6/Qqam9o+0JM9Wkbgx+MMFQqgeTIf7LCZ+iXX2
l/tsckBJXUlBun4sMAf2c73EkuJs3yU7bQ56+zj9bf18EPokX5SzOLQqh0BpR2QZFihmanRio9S3
qDJOmdO+OAuOt2gSLBOJSZzRkXc/wXUVQJQi0xizwRBnAFS62QrkbfmmUjoEBXo7ELmkS19NJBjV
MwL/PBUJhC+A8U4ZPOT81B3F79ERXKsExUWXbYdjJYi72QzuywHuOnOIZTWeSS/DgkizHrLFUatX
HLcpp5E8YRC2SPuK/f0HFXwcqYKI2G/3izqasSR0a+4fVuYso8ZBuF8fkv2vkEgJEuX0UJS9
--000000000000742b6d064028a640--

