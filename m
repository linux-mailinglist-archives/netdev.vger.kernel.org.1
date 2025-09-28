Return-Path: <netdev+bounces-226971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A1BA691E
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F352E3BE716
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94F29BDA5;
	Sun, 28 Sep 2025 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eGOD7CdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0B29A309
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041352; cv=none; b=lxMZK1Nq3Set7Y0YL2+dW1AlcWP59K5yNR7Dw7RbvJvmYW868hif7rQMGZdXlL3UdZzo+5N7ddeHCI86ZEOw4wLwn4IqdujAjmf4EpuI7BzHdgldu7QA3Zy/BPbhv6uyMmeMRPlKFW31/yFViHaU5jqhNn8yQ4GeWhwXm+1/r1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041352; c=relaxed/simple;
	bh=NYDsMt5AhtqcCYf3X/58kNeiJxaXtqC92lWyq/rjLeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuWW4V9GewGSFH3rZm4xNO/Jv8OuHyepXHOKk/H0zJprR2jYnfgNWFyRa7LYzLZy93kkNXNoa1fDBGoVavvWFCjgsYQTlerjHr5NyQ1k4Vl8xw+kg4BTeQ0SQlQKyKwLt0NlDpxBjfOZ3j0J2A9nxRQTdfAUx8DRZRrkCQ9W578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eGOD7CdQ; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-856222505eeso389111385a.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 23:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759041350; x=1759646150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uYpr1JWzwNa92WfaRh0rjMRjl9iPEeVsXpc50jw4kWg=;
        b=lBnFxlpESfKmYlYkqK3FqWV5bguHD/tT63EkHiqdB1NEGzEtqp6mGMgFVimFa6o7oi
         /drkLBjlSgqr3+ewb62x4G+/xFX7F/hbQJN1e80KnYQiaH8pAK68p/QxNN7dep1QGR3P
         uxP3U/M/72lJ0vTKR9TlWkM6/ey5tZWDGyhrHeNCTondw7Eq1DFVaaKJs4d886deyTEQ
         OgFOventOgR98m7l7KLFFkHADd98zp7qXE43cljPx0ywFQeoyjpsnZAWr+9vRIwODBnI
         GbbBZxgpTTxZ1z7sJrLHX6rp8dZ09MBpbyrLrYJravtiU6fkEIjJ0nN18JIUcg08wpkO
         MuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv/BEqD3Z38bLcXQhQBELHeqqfAmJDVXfCIHHDCFBD1gPvYprV4kiD7YkRjqQ8Qb68nyusw7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07Kage7GObtlog1Cqok/nfHMMU6I0+azVkO/lxzumIxFqf7Vp
	yyMw/LoDGoDpm8DUtvdTTGYPf47BZWkFcshJhhn3pi7itwE1QMEKS0U7tRLgj+es+SsGfSOgfHy
	YwUOblehneUzd97R/vr/CnRhfj/DVTGhF30v4F0aOG104LrgbQKBnvqUS/nPhoUBGcFnd8xoeGQ
	4JpPXlmA8HJKIOXU5JSnLB/KpRoMN+NJGk+DQVGEh6vU/g/57L4Q1MBBD7jnewZJZfoubxokRNU
	fCAxGoHb0yFlg==
X-Gm-Gg: ASbGncvf0xP6fbetw9B76WNUKF2F31jOGN4acnH+KJkJ5MsOlridCk5HI/YmQDpzeWz
	SY/Hf9NCODgP4m4nuyOSTTJVcAXsuh7L73KE2Jyp7TZgQwe6OgkuD9vUzH35c+krxDzybHjkgyW
	c2YpoDyUBCKl/ikb0K23bUuXehF01DdgFznRtQ8XdkjaZ1FEIFvcy1z7NmsHJclWg8oGZzrdUs6
	uJmkgiyIxET/2pEW6WyKai6Incycv8LXEeebExGfr+Vj0iuY0TbJnhAWZX/jYBSXCCbADcLloMl
	weNFUvA6LCtCZkG9sAZtWuIlkGGZTOtO+qL5+rWc8pESt9CM+Ykm58UzGB+zHzYrgba6hp9daV2
	Es1LKkhJqiKGcNQOVkkKiGusGj7ZWxCvffR/0WTJu2xMJgoOL+3USEqp4FNF+rFsG7yC30URMwt
	3ySQ==
X-Google-Smtp-Source: AGHT+IGMzvWgMnq6tOPfsKq5JdIU6ugJt3iNsaZ3lZGbbiGko43t7l53dAY1UU9+m2fSYSeh/xYmKFvt4Onz
X-Received: by 2002:a05:620a:461e:b0:860:d32c:3875 with SMTP id af79cd13be357-860d32c3aaemr897973785a.8.1759041349693;
        Sat, 27 Sep 2025 23:35:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-85c2c71a729sm61950685a.4.2025.09.27.23.35.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2025 23:35:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3304def7909so3539966a91.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 23:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759041348; x=1759646148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYpr1JWzwNa92WfaRh0rjMRjl9iPEeVsXpc50jw4kWg=;
        b=eGOD7CdQ0Lu2ggqbYHidbaoaPC9JnvvzqZIy6OPl0+jBWRFB6rGdPN0ETgdLOGoElq
         1F0zuThfvqYGt8Dn3L1jXpwxLqp7WL+fvZmk40/v9Fr0Dwu+ZMN+WOFzKX49JA9DndaS
         TwR6I6HFb4TqFqxnCKuvr4tRaR25E3ukgx/us=
X-Forwarded-Encrypted: i=1; AJvYcCXKq1REuLJ+L7fiZePwce7hZ1c+k3zhKfHJVb789f8SxmB6rfzj8/o59wukonITUfoHdXqJ6oo=@vger.kernel.org
X-Received: by 2002:a17:90b:3ece:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-3342a216f73mr12740742a91.4.1759041347971;
        Sat, 27 Sep 2025 23:35:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3ece:b0:32b:6145:fa63 with SMTP id
 98e67ed59e1d1-3342a216f73mr12740724a91.4.1759041347582; Sat, 27 Sep 2025
 23:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
In-Reply-To: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sun, 28 Sep 2025 12:05:36 +0530
X-Gm-Features: AS18NWCtMZWWymTrYH2XHTXJVD6Zpvr-JKHJ8RwmbsSHvKumW5-Q9SrSjCaqsA8
Message-ID: <CALs4sv0T=AL354Mj2UCQGwaqWAznjDoaPQX=7zLsXz9=WxAiGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/5] bnxt_fwctl: fwctl for Broadcom Netxtreme devices
To: jgg@ziepe.ca, michael.chan@broadcom.com
Cc: dave.jiang@intel.com, saeedm@nvidia.com, Jonathan.Cameron@huawei.com, 
	davem@davemloft.net, corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com, leon@kernel.org, 
	kalesh-anakkur.purayil@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b58d41063fd6bab4"

--000000000000b58d41063fd6bab4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 3:02=E2=80=AFPM Pavan Chebbi <pavan.chebbi@broadcom=
.com> wrote:
>
> Introducing bnxt_fwctl which follows along Jason's work [1].
> It is an aux bus driver that enables fwctl for Broadcom
> NetXtreme 574xx, 575xx and 576xx series chipsets by using
> bnxt driver's capability to talk to devices' firmware.
>
> The first patch moves the ULP definitions to a common place
> inside include/linux/bnxt/. The second and third patches
> refactor and extend the existing bnxt aux bus functions to
> be able to add more than one auxiliary device. The last three
> patches create an additional bnxt aux device, add bnxt_fwctl,
> and the documentation.
>
> [1] https://lore.kernel.org/netdev/0-v5-642aa0c94070+4447f-fwctl_jgg@nvid=
ia.com/
>
> v4: In patch #4, added the missing kfree on error for response
> buffer. Improved documentation in patch #5 based on comments
> from Dave.
>

Dear maintainers, my not-yet-reviewed v4 series is moved to 'Changes Reques=
ted'.
I am not sure if I missed anything. Can you pls help me know!

> v3: Addressed the review comments as below
> Patch #1: Removed redundant common.h [thanks Saeed]
> Patch #2 and #3 merged into a single patch [thanks Jonathan]
> Patch #3: Addressed comments from Jonathan
> Patch #4 and #5: Addressed comments from Jonathan and Dave
>
> v2: In patch #5, fixed a sparse warning where a __le16 was
> degraded to an integer. Also addressed kdoc warnings for
> include/uapi/fwctl/bnxt.h in the same patch.
>
> v1: https://lore.kernel.org/netdev/20250922090851.719913-1-pavan.chebbi@b=
roadcom.com/
>
> The following are changes since commit fec734e8d564d55fb6bd4909ae2e68814d=
21d0a1:
>   Merge tag 'riscv-for-linus-v6.17-rc8' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/riscv/linux
> and are available in the git repository at:
>   https://github.com/pavanchebbi/linux/tree/bnxt_fwctl_v4

--000000000000b58d41063fd6bab4
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAXQ6Y3
upaRa5qtX7hJ1M0CuUiPaxOkSXh0j2/hhzP5WzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTA5MjgwNjM1NDhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCqP3yrEg/MakJMaCv5syAw7jdbmTG+wOQ2liOGuAQb
TqlF+PlruNbsw1J0yABBbCBtctCm8DR4wXe2h+BMQ9/2pfQCP29VJTtIvzh0f2N/Pl1S5PsiNKvb
blV2sNgDJUXbH2jwzc8jjXrI2+OrtOrajXmL+haRBZHXRsQuxRA82MJAReaHTXLgDtjZbL5xNubx
mbGoF3rw6HmE0Bfq3QrtNbrIUrJ3S8GRGA3YfuYUZF/RDqGVvaXf6hlnODLUSuiSlc7usw/qaDlO
NhXfmlE1EoVmDzzFg/jocpyWO/lCv/wfU5qkyp3+koL6IPr9fsq0mwLC1gW5sOqHI8dqP1ZH
--000000000000b58d41063fd6bab4--

