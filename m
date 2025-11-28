Return-Path: <netdev+bounces-242614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DEEC92E8D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02323346670
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A124C676;
	Fri, 28 Nov 2025 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FtNCMOJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D31FC8
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764354593; cv=none; b=Vx5ofJSNC9XsDPE/z7zKLbpR1pmXwTx0AyvZbzF8J4TtWgETbMHQ6xdc9mXHXIq4zcm3YGzNLPW7a76d2eOe4eqcHCVnksJrDxxtD2npuA+7w2t2b6QInOs53wvwgu01kesjx5Xf2iqGRc6gbVPhIUEZLi7RrMNlEewmJZLPmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764354593; c=relaxed/simple;
	bh=4QgqImkiWQ7DjAiJXoO38BdsVGFgG9PGxkyrZCr6AVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvOdZelV4klMePjroBXE1+BX3MsXbr2540+MmjNIxJggG90GAZ9wB+QG8UZdurR1eqr5ChbAS/ZU98lkteEhWX+K1sLnHDeTn3Wfe4lteLhJhBeG4NbVBVJjaREfsBGojBSwaFjAQZPMJpKKGpI26DnWT+EreaRxld8hHb7rNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FtNCMOJk; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso172018985a.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 10:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764354591; x=1764959391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIHEOW4Dzti0q+UKXwx+mdE9db9PU7VXCt7uQ7QgzkE=;
        b=OIOFu13F9wEqVVxnb1KMDeXHM63IGK2FASP09ph3DePO/uY5ijvhoCyiWdck8Ar5Oq
         X98y0zHQa7FsZB990PUhTRrUOWU2/LnnwgAvUBMYWWr+zwVsLXKRMHsGbx/tFsnK4n2A
         /lukuCvIt66W64QHDpRVd7n3qvPl7K7xxOYvb04snmTgybE95K6gOzrjQ2LitTOme09n
         rvZkNpZTsqkwsjh7n0/xfAZ4ODvGRn/SqgQim+4jRL8tJDeSJ6ZYnxi3sMhtirSgpDY4
         4k4lVudkbqz1aVvTc9We1irm3lQZ5YJAzFbgs1InxP2ImbbfUOFwdW/smhBJYdlKbdo5
         tyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi7rjDM4ULHfQ2U8iuSiAPm4eBenIVluyq6LeOVNgPKLVKjPO0Wo8FL8ajFJajcBQtPD+dIVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywimu1GWZYV4pZR8FLC65YfaKNM+L1OvApKPJsOKztsveoJSwjo
	wktUafYmM9hXyZsuodpWdnfiEiqYFZeg/AffLx0IHfVluiMn/HDy0vl4s4PBJCszktwqujCZyxo
	+rrTBxSrFYYQwB0hpR4XyDObYaBKO0QyPtnuRCDL73CZl+DjWdmlhoNLPvchbOkD5pEi4rF3vxp
	0o/ii0Gto60Gl9z4dgXO7htuH3+dLLqMnt02PnZ+DU2VWoSqswS/8nS2+07gTeh+8K3qjabPoGM
	xszwwvRnVyxJ3Tak8mE
X-Gm-Gg: ASbGncuiA/2uCXMBYpldTzXWrMXc08oBodIGmfp8I00L3XmUtL2WTaVvlWYb8mxbYc5
	kqCJuICDbHqTrwRut4sfr+aCtSEKLqNgyNHNnr3u1fUjObD6YQC0BVqdYSdaEnE+Hxr0QXTz/tl
	bXbFGoHmiKTypPfr4ezF1EHA1h7kX4rT9a0RNmNtIyEDFRQ61ByioCkpBHxpBhX/xiuRLU42L5L
	6+o4yqcomT5wJY0+BOVLgJOkxLm2gRw6mPA4NIcgRTl2DBqyiVNLP+6Cgfd4vYwbxkPWszrsQn0
	ZLN4elxyrBy3H4Alwnfth56E+PvYHspQhx9IWm6tc7p02gcFfV7PR0OytNMfIOJpqbid2qWEkBU
	KIANxMrcKyZWtH6n0FFHSwfoQT7Dft4dn5n7VGIpVWRmrMwAr5iNNTytBX9G9MLJjstdEc/zfAv
	D6xITtG37W2gBKfqjF0Tq8lv9qAmosVnru6rOfQeUcUHrD+Pk8dNc=
X-Google-Smtp-Source: AGHT+IFpDdmZxE1e8AtkvsAG/BltuyZDc/vushZTV5EzV1JnddmR4p4uHVtk05zIbSUwO+Lf0zjzCIZBmrkV
X-Received: by 2002:a05:620a:190e:b0:8b2:e990:5122 with SMTP id af79cd13be357-8b33bdcb27emr3558495585a.21.1764354590654;
        Fri, 28 Nov 2025 10:29:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8b52998ff30sm50225685a.1.2025.11.28.10.29.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Nov 2025 10:29:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2a467c4e74bso3687208eec.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764354589; x=1764959389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bIHEOW4Dzti0q+UKXwx+mdE9db9PU7VXCt7uQ7QgzkE=;
        b=FtNCMOJkEvC7rBTQAVkscDKvmNH7j/mct8EziBUUFQwBnm9+trnWD72BhpIG8H81HN
         UwIkiHMMwXC+XYEB63/FhDaynmvzZjuFROK3YEcTPccFNgASWnl7rIf4xgNMZFzIa0ex
         n5loowDb+W+dapXcvLdNkgXBpaPJ97Frjiz7o=
X-Forwarded-Encrypted: i=1; AJvYcCW8kFBP27p1YZ16ehP4ve/k6IZijiA1/X1jVswgIyOwY7NAWGfZJp38VfQnmIN6a4yULJZFh9I=@vger.kernel.org
X-Received: by 2002:a05:693c:8111:b0:2a7:760:2b49 with SMTP id 5a478bee46e88-2a7185a6559mr14035047eec.7.1764354588955;
        Fri, 28 Nov 2025 10:29:48 -0800 (PST)
X-Received: by 2002:a05:693c:8111:b0:2a7:760:2b49 with SMTP id
 5a478bee46e88-2a7185a6559mr14035033eec.7.1764354588485; Fri, 28 Nov 2025
 10:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
 <20251126194931.455830-11-bhargava.marreddy@broadcom.com> <20251127191335.60097c86@kernel.org>
In-Reply-To: <20251127191335.60097c86@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 28 Nov 2025 23:59:34 +0530
X-Gm-Features: AWmQ_blDyNeH12f1hZQqPfh7BtpT0lFPJLtr5bWcGl2hivQnQQmoAsuf5baH3X4
Message-ID: <CANXQDtYy2JziaaVi=Cqt+gAJNt4NjFFs8NbhrS=RBV61ORwinA@mail.gmail.com>
Subject: Re: [v3, net-next 10/12] bng_en: Add initial support for ethtool
 stats display
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008f4ab20644abd04f"

--0000000000008f4ab20644abd04f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 8:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 27 Nov 2025 01:19:29 +0530 Bhargava Marreddy wrote:
> > +static const char * const bnge_ring_rx_stats_str[] =3D {
> > +     "rx_ucast_packets",
> > +     "rx_mcast_packets",
> > +     "rx_bcast_packets",
> > +     "rx_discards",
> > +     "rx_errors",
> > +     "rx_ucast_bytes",
> > +     "rx_mcast_bytes",
> > +     "rx_bcast_bytes",
> > +};
> > +
> > +static const char * const bnge_ring_tx_stats_str[] =3D {
> > +     "tx_ucast_packets",
> > +     "tx_mcast_packets",
> > +     "tx_bcast_packets",
> > +     "tx_errors",
> > +     "tx_discards",
> > +     "tx_ucast_bytes",
> > +     "tx_mcast_bytes",
> > +     "tx_bcast_bytes",
> > +};
> > +
> > +static const char * const bnge_ring_tpa_stats_str[] =3D {
> > +     "tpa_packets",
> > +     "tpa_bytes",
> > +     "tpa_events",
> > +     "tpa_aborts",
> > +};
> > +
> > +static const char * const bnge_ring_tpa2_stats_str[] =3D {
> > +     "rx_tpa_eligible_pkt",
> > +     "rx_tpa_eligible_bytes",
> > +     "rx_tpa_pkt",
> > +     "rx_tpa_bytes",
> > +     "rx_tpa_errors",
> > +     "rx_tpa_events",
> > +};
> > +
> > +static const char * const bnge_rx_sw_stats_str[] =3D {
> > +     "rx_l4_csum_errors",
> > +     "rx_resets",
> > +     "rx_buf_errors",
> > +};
>
> We do not allow duplicating standard stats in ethtool -S any more.

There are several hw counters ring-level, function-level, port-level
etc. which we
currently expose via ethtool exactly as is.
For the standard stats (via .ndo_get_stats64), we usually add
individual ring-level
and port-level counters.

Same stat string we see on both ethtool and standard will be populated
with different counters.

For Ex:
In the case of ethtool, rx_errors =3D ctx_hw_stats->rx_error_pkts;
    # ethtool  -S eno12399np0 | grep rx_errors
         [0]: rx_errors: 0
         [1]: rx_errors: 0

In the case of standard, rx_errors =3D (rx_false_carrier_frames + rx_jbr_fr=
ames);
    # cat /sys/devices/pci0000:21/0000:21:01.0/0000:22:00.1/net/eno12409np1=
/statistics/rx_errors
    0

Do you think ethtool and standard stats should have different
stat=E2=80=91strings rather than matching?

Thanks,
Bhargava Marreddy

--0000000000008f4ab20644abd04f
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC61YKVAfdi18d2qqC+XGRwELNBoy3AHZ+nds8/LrP3/TAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMjgxODI5NDlaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCMuKzD
Edi0REZlfOnmTkQtwmdaKm7yq3h6rhjnVqgJifsxR2cwTsgjfTCEqtuojzUikzGNVvhVOEY2894U
Gp3BVv05ph8tWfxfopWkZ5yjlL1UNfhDs8dH0l+g2lLZSQfCAqDXtXl5qXBMTs20uTiXvSaBSkeP
tGxiHMa3tP3v2ZFi8vFAtjxs53/IzPiz5ESshZVNEKiZdIM6GPtiD8wtA9a0GkKkytKi5y3q/Gl0
snLmDrXdebsV5OyBF/iWJoepSbPQp2i6YcaECxZAupEnNgtiVC+YTU7mJZEQtIYSBif4LrBzIqAt
aHLIuqqD30Zk9S0jmvz3TQdquuHdZnQr
--0000000000008f4ab20644abd04f--

