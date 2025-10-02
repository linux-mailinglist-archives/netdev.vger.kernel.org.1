Return-Path: <netdev+bounces-227606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC052BB3658
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 11:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD927B5F5B
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB882F4A1F;
	Thu,  2 Oct 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PhPfrlHz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F32F0C59
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393660; cv=none; b=FxSm521Dspt+xtwKqAINRbJ8u+yPgIhppmkiw8bD7BrcFTkKnR/Wyo9o47i8nRB3jtSpywCUBFl55MhGtac95fhzO49MMM3Ag0X50snEnRzQqPKyS1qciLUHLwbGkk+o4YrxpUDWfEaHlr2kcg25zzaFpiixM9MT3iNe7k8x91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393660; c=relaxed/simple;
	bh=7ycDDSuJ2KAStp6Q85to/uD09trRhZxWE3wz6mes7GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX+9QYL9b0EhQtsEwLNUGriLwlw1cwKU/rRrOe64noT8R6Qs+X6yMIF+tGg2giFMcZr38cn6FJvxwJgon49vjbPxeW6CP4S5ohBR6Hks+u0vPqHZLYr0omb7ScrVLJVQ3p3xNzAwBHZ4UPFO8Ud4R198FdjVaR4lPB4Oy1CHYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PhPfrlHz; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-27d3540a43fso6605145ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 01:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393658; x=1759998458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ycDDSuJ2KAStp6Q85to/uD09trRhZxWE3wz6mes7GI=;
        b=kC4PHjAn5hh7DWJsinIxY2tCF6RD1qqA/VT4MomxTO3OeeGk2yLXg0W4nLfaPF+/RT
         BKQIuDUuccL4rrTnVI9GDEqliwMyfdrOQfAyOZdEf2dV0sUni5mxWeIj4aJ65rlywMJL
         Arx3OJH5h4Nkg6wumdLl3L15gZ/fRDrbBsE6ExYIgDYhExby28QJQ1MExHjjjjB36lsb
         7wTGVrt405F0snHyzHJlT3dhJG4n/nL7sSgSb5umgrJe5pCkLXYAdmYMeSAWzmKoDSfa
         NV0ZZOCx3SEjVPPeCq11JTGx0ZqRU+EbeYUH4nSpGx+PFjb0R/VofZNtHviHe8L+AmcF
         hPgg==
X-Forwarded-Encrypted: i=1; AJvYcCWO4SumWdkaw7jL55+7SKLRnkjUmRsig0bNvaYxtfN1HXrKAiPlvgbhLbANIyEbKtrtxIPVJrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEx2nzYhJz3Vlwsdu4pRMslTZkFVmC5pXE5rEOMv/VqTjeADQt
	+Url1gKLMvWNKCG0kf4OtyXWPqaMPgwNq/OGqvuP6ahvSmJjwfYud2D8EVeoVl0L/vdG7gYPPjK
	9HuFKwP3tAAFZCMjvgNzMjxx3GFdc1ggdLc1FhcPLRcSwsnZR83VQFjyDwOJiAnMyCsAYnADCb8
	0/cUCsm9UE70wLTZa+5Xw/tFhdHJ7ImToRQRCqtlP5bGBLDMlmKPHor36NYEK9c1NUKymCwJKNi
	dlpuGJbhg8=
X-Gm-Gg: ASbGnctksp+bbxPGrFSpuOH34VLpS8Cr6uuH4DbAnOwivgqp5Wf7fw4nLf/Lg9ROMh+
	EdwXIR3IrMZDGiyDZHy2sRvVZAg44cNnT/HGkvy7i81tNfLx4ibHBtxE3c1qzn3Kv+nvOCjhcEq
	dizxXi6BgUdfU9CKRE9uFry1+N7K0noq6p4luiPIPnpKrEa+VRbq3mZHLFLovLGQkq5ByvNtplB
	ZdklCX6dCfwNwBcsBCnzNc5U/n+0qJmJEa9q+1nnAUBbFpnCrbtx+8XURqaCOIJvVoKvvc2Vl11
	/bUh+WThuF6BUFMeVFiuwlUYylkMjGIjT+fMQWj5NeAziDoQEOzFrwYM+3/gc0A7htQ8TodFdor
	z6YJlB1ZjmGOWdCS0hqWP0/z0QJi1gONTp/b65NbCIa0poZjmjaPdqMmRKD3wuO5pDtdKRlujrz
	MCOAddMcw=
X-Google-Smtp-Source: AGHT+IGJldbjwlSKAZQO8mrP4e7SvYvWsD6Kx+i8zJrKbN+F1b1zsXs0a/qRaexMVwtKDpso1U/YHhTZEckz
X-Received: by 2002:a17:902:f707:b0:273:7d52:e510 with SMTP id d9443c01a7336-28e7f46d1camr77783345ad.58.1759393658046;
        Thu, 02 Oct 2025 01:27:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-28e8d1b123esm1231975ad.65.2025.10.02.01.27.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 01:27:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78117fbda6eso851517b3a.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759393656; x=1759998456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ycDDSuJ2KAStp6Q85to/uD09trRhZxWE3wz6mes7GI=;
        b=PhPfrlHztXVj96RLgYwNFtwfgBqnFenu/t4AgjIThgBVKBEl2NJ259zXwxRFCZN8oM
         vmq0AZVW7S1PrZ/Zs+EEMuKX8obsKKfXNRVTTp50KBaOZWHFqUIKg4X4lcqhmgEQwaIi
         uK6k1EmuavhCZ57mIPRLwMgClM/WoymZajgq0=
X-Forwarded-Encrypted: i=1; AJvYcCX7Kv6BZupoZV8UT9U3KbVQcq6AJV0RCEbcXp1s51chjWtyvfRzg04dVpUClOKHSEzglCHSPV4=@vger.kernel.org
X-Received: by 2002:a05:6a00:c84:b0:781:7e1:a315 with SMTP id d2e1a72fcca58-78af4174bdfmr7379805b3a.22.1759393656288;
        Thu, 02 Oct 2025 01:27:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:c84:b0:781:7e1:a315 with SMTP id
 d2e1a72fcca58-78af4174bdfmr7379785b3a.22.1759393655914; Thu, 02 Oct 2025
 01:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
 <20250927093930.552191-5-pavan.chebbi@broadcom.com> <612f01e5-34f0-486a-ba7f-3a78870edb8e@intel.com>
In-Reply-To: <612f01e5-34f0-486a-ba7f-3a78870edb8e@intel.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 2 Oct 2025 13:57:23 +0530
X-Gm-Features: AS18NWBCkhuBA0494pwU4SpM9YjK7PqC8OhqGLyOEqscWaDWH1t-0RZtas11vyI
Message-ID: <CALs4sv3jcQVycjf1=ds=Vb1phefdG8LcJUTC5BUJSo6kxwhRQg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/5] bnxt_fwctl: Add bnxt fwctl device
To: Dave Jiang <dave.jiang@intel.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, saeedm@nvidia.com, 
	Jonathan.Cameron@huawei.com, davem@davemloft.net, corbet@lwn.net, 
	edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com, leon@kernel.org, 
	kalesh-anakkur.purayil@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ed9c4a064028c188"

--000000000000ed9c4a064028c188
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:04=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> =
wrote:
>
>
>
> On 9/27/25 2:39 AM, Pavan Chebbi wrote:
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
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
> just a minor comment below

Thanks for the review, Dave. Yes, the DMA address holders can be
temporary variables.
I can make that change since I must spin a new revision anyway.

<-->
> I think these 2 don't need to be in bnxtctl_dev and can be temporary vari=
ables. Since they all get freed at the end of the function that uses it.
>
> DJ
>

--000000000000ed9c4a064028c188
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDFQmSF
1DvwulvxL9N+FLT25eKAIjqGuInUG+TyBPbrJjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMDIwODI3MzZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCYKIDnR5iSs+47G77+Fnxa6U9JW8VrJZa2FknFjiyM
J4PWMXGvoaT+mc9p6CaCk03MzM6lW12kTtqzFPPvrmvRdtkDGAyS3GdvXGqmtS5vIPKUbCumvrB9
fMUnkiUMn/RP5g8i0y/WCox23tzaMMVvwU2GScQAMcZSITgR2pkE5fG1qKFYX98dqVSoWe/6z848
9dA/I6gM6xkEwW6hTYY508amQRIbuCqeVJ0/wBpYJbPY/b412MNJb3V2F+BHKG0vbuyvTVIfbN8Q
HZ9pcW1AAew6wl+AKDbmeKTtbUeVq1B27RBTXADzI0slYJosOAH7K3rCR2k6TyzsdAH27I4q
--000000000000ed9c4a064028c188--

