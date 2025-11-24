Return-Path: <netdev+bounces-241253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A00C82079
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10C24349EBC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3E31A7F7;
	Mon, 24 Nov 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fHCXTo92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83062317715
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007630; cv=none; b=CN5lOkop+ND6iglvoapl3ckkUF+7TuUIesvlJ2JMRCpdFjHJbLBh5bJRNXBmXpD1Dra/A823oavBoQ+lHV9FDMOl1NZhUzW7DIx04QgHE+cGwFw4i21WKmoAaIPtnnvk6Tp2J3FVCCMYYOK808TU4k3X0ItJWYemAp60lOlUoHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007630; c=relaxed/simple;
	bh=W8BbDdC56O0ALwatcJkSczIbbg4eGpJX+7Zz6Gqo3IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNLWu3GLi0qmfSKhg1+vaB6vMHscmVEfUZzxkFFOeJqi0Q6+frebSSOvEVBobD0aJ8OgZCrfhdP02baDM2mALJfyXTbuFRNkDr4By05qWH6pRjX5yibZukG8u9+mT9pk311sZtQwcppFgMbASEitRlqHii6PXsuw60pDdAmzIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fHCXTo92; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-298145fe27eso73539655ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764007629; x=1764612429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah9nL4cglUgX4OlpNVsCi2wM3K72FqSy/8Az12CiNZQ=;
        b=Y/rgNtb1NP5oLKcxRD690+dnh/QKFdE+X4tgFmPRk1+71PQIdpjreh8kEjU5Ee5/wM
         ++CPj35hzR87PmXZNJj/P6z7y7ZKENOoPykeVudu/MCjSLWQNJRBKYF+uSqJDP4CwurH
         wtunO8utwOPARSiZTjYAMHN43Z4sOQEIRtApCiFZCaB434s5w/Glv8z0M7oph6Rf83FX
         esasu1nQdv0sNtMer50uqfQVSEZDfrmH8UoH641PlSC4en4u8xLk59xaLt0U3ff2wUCk
         /d4Z1SaOdcaJTqHeprDRUvuDXUyY7/aJ8tqQer9L/o0UHcQgeF76hGXMynf9c1yJrxzb
         WtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtNLNaf2XLIpvpRsjVj7HB1cYIxTqY3fevn00xf+hYE9OYkPeokE3HBLqoE7sL3gmxbiSD0SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHMwa8JJAK7sqdVzqa1xg7sBuZu41nQsYBnhtHsrXXY1X6rVR
	n8H3I9HrFeO8e+O784dAmyP3L0dpi4Ax8x8yYOg35xhk6+NrvG4dTS3cwPNNfIBERXjKyCD0dik
	vhyiphAQVYJq4yiIHDirnmjG+xMavMxzcqAYs/WVnICzsWpuJt+GtXPmtfa9WFPo0RIGEt1XJFT
	mz2uAePBKExI0e4QXjTY5tHyYUKsfPdpTWf41I4kR66FNV2CwMlYy8VeKJsNzE07TAO/SJaYjOg
	35tzma/9mGRxk2yya7I
X-Gm-Gg: ASbGncvM78HHLRu41gpcaOS26EQgfJYzTIXR4XqkYJV2BUgJ9dNfL+IRwLMBAdj3Eqf
	hetZfPeOD+oREvNoOARzAfMQFO3hJIO8ieJU2FXftCPoVMe/KWZea4m8YYdRsAz4qD4P0fZx2yv
	7+g00fT3UC5CCklGXdsXSmXNBy7KYLRyTCOoWXRWDQ0PPjuWlKQxwOrTDngAlHByv5ajUdZ/FAX
	zFXNYNFxgktaZdnHPfuC7E1ZoisRXrNZ9cZfB9XeNOkk4ihZS2huL7tivfo2XkAYenywT4uawTD
	iXzC8m5As/6mK/PEQ/mT711msCFN0zMg7nU41QY36hl8Bz3meYFZh34I3Z/PkG1SDCqsVgt7q92
	Yl9YP8ljlBZA93xiWAZw0CQSJN8CQnl0+q3qctxRF55fDjm3bB1U1FPVH17VbMR+apxuA/aXsQO
	EmA/QyXuetwdy8UegkSv8b/M5HS3mzEjy8x0o3n3iRrDou6ZNAxDU=
X-Google-Smtp-Source: AGHT+IF0RbJqnC9i4NX84k6QNXTmPJOzDnJkXMjZKTVx4yisSFDXlRIfSFtRAP3K2Hd49bTBm5Vm0bFPEEJo
X-Received: by 2002:a17:902:c945:b0:298:616a:bae9 with SMTP id d9443c01a7336-29b6bf19ed8mr157175115ad.28.1764007628530;
        Mon, 24 Nov 2025 10:07:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-bd75def6815sm591562a12.2.2025.11.24.10.07.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2025 10:07:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99f6516262so14427154a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764007626; x=1764612426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah9nL4cglUgX4OlpNVsCi2wM3K72FqSy/8Az12CiNZQ=;
        b=fHCXTo92Lum6P1uxVI5AYAOQOrRyNyky3/W8K75BSWpOQHbkuKxU4MBE8IF3q1xsdn
         +5oHlTn06RQdPxpk+Lj9GOX6EeJzmuu3odUKOpb9TCHQ8+hBD6ToFgiSsjiAYdzJ3uuk
         fCtqxTzPrvDJ0RpoiQKKS6Y2AAkbiP2qt6WZk=
X-Forwarded-Encrypted: i=1; AJvYcCVORfTK4sCFjyVTc80RRh1cP7x83oRKHekZkDumJNA98pP4/maw9tgPbsxLYzTftaNpANmv9mw=@vger.kernel.org
X-Received: by 2002:a05:7300:3a97:b0:2a4:787e:57a8 with SMTP id 5a478bee46e88-2a9418c344amr5453eec.36.1764007626533;
        Mon, 24 Nov 2025 10:07:06 -0800 (PST)
X-Received: by 2002:a05:7300:3a97:b0:2a4:787e:57a8 with SMTP id
 5a478bee46e88-2a9418c344amr5438eec.36.1764007626024; Mon, 24 Nov 2025
 10:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-8-bhargava.marreddy@broadcom.com> <b8e79877-0fd1-457c-84cd-84442bf70b47@oracle.com>
In-Reply-To: <b8e79877-0fd1-457c-84cd-84442bf70b47@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Mon, 24 Nov 2025 23:36:52 +0530
X-Gm-Features: AWmQ_bkZk0oDyetIpg_hwWntaD1vgRgeqNe7YI-YtpIe_QOaP-49DVubPRaX7sM
Message-ID: <CANXQDtYWCH291PE-6vUJJTO4moU23SJnLv4gVrba97CG6UdV8g@mail.gmail.com>
Subject: Re: [External] : [v2, net-next 07/12] bng_en: Add TPA related functions
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fc8b9706445b0716"

--000000000000fc8b9706445b0716
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 5:58=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 11/15/2025 1:22 AM, Bhargava Marreddy wrote:
> > +#define TPA_END_AGG_ID(rx_tpa_end)                                   \
> > +     ((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &           \
> > +      RX_TPA_END_CMP_AGG_ID) >> RX_TPA_END_CMP_AGG_ID_SHIFT)
> > +
> > +#define TPA_END_TPA_SEGS(rx_tpa_end)                                 \
> > +     ((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &           \
> > +      RX_TPA_END_CMP_TPA_SEGS) >> RX_TPA_END_CMP_TPA_SEGS_SHIFT)
> > +
> > +#define RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO                        =
       \
> > +     cpu_to_le32(RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO &          \
> > +                 RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS)
>
> why ANY_GRO mark with &, how does this match GRO type
> similar code present in bnxt.

AND=E2=80=90ing GRO_JUMBO and GRO_HDS gives a non-zero result (the GRO bit
overlaps), so ANY_GRO is correct.

Thanks,
Bhargava Marreddy

>
> > +
> > +#define TPA_END_GRO(rx_tpa_end)                                       =
       \
> > +     ((rx_tpa_end)->rx_tpa_end_cmp_len_flags_type &                  \
> > +      RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO)
> > +
> > +#define TPA_END_GRO_TS(rx_tpa_end)                                   \
> > +     (!!((rx_tpa_end)->rx_tpa_end_cmp_tsdelta &                      \
> > +         cpu_to_le32(RX_TPA_END_GRO_TS)))
> > +
> > +struct rx_tpa_end_cmp_ext {
> > +     __le32 rx_tpa_end_cmp_dup_acks;
> > +     #define RX_TPA_END_CMP_TPA_DUP_ACKS                     (0xf << 0=
)
> > +     #define RX_TPA_END_CMP_PAYLOAD_OFFSET_P5                (0xff << =
16)
> > +      #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT_P5          16
> > +     #define RX_TPA_END_CMP_AGG_BUFS_P5                      (0xff << =
24)
> > +      #define RX_TPA_END_CMP_AGG_BUFS_SHIFT_P5                24
> > +
>
>
> Thanks,
> Alok

--000000000000fc8b9706445b0716
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCj+Lf8714eg/weOhoYAkoBEDqBJqYA3a8Q19EUkYc7djAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMjQxODA3MDZaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAQYCa8
o08uwlGNuW6o0c2SRaFe+nicymr2HHxlxPSwTukgWm1l9NuEI/CCh4qjQgtRLont78GSF44bP8Oz
p3HemOIXDdIfZM6is9NpIsClTg3mjvVhxbWNKQjn1WD5s6PvJLoFWiC0f5DoVZAo3GHafQPWNVwF
5BhBgceciFvvwKGs+JxoPJT8FnywAEc1z/mOoFYfSTDJ5Zaj/29Wz0J5R4qlQz20xq6GxUsYcNC8
aJ/TlKCTqHHDOT16bSI6cVutZmUhw4oiG3tnOQ3IHa7DO8D0q1UaKQgqYc0QA/uBeRICKszKQLCr
YwuilvePpRC5pafzmRkfax3DrUIplIfz
--000000000000fc8b9706445b0716--

