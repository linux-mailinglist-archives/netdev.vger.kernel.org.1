Return-Path: <netdev+bounces-239833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB2C6CDE8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F4414ECE0D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8742EC569;
	Wed, 19 Nov 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aO92Udtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF781ACEDE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763532526; cv=none; b=QJX9bP2kUrUzsNPnXCmBpAGqwqEvxQZleKFF4D/fcIvhJmrrkK6ap5rJP4KXMtTmJjyNY6b+knu60lU9paIIsW2QFxJF7CBIi/xn/T/vFOsmwolfxFO++cbRGJ0ybLhgiwouQ13/komH1bxm4tM/y1YjiaTuI9OG/hU5YYplUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763532526; c=relaxed/simple;
	bh=L2aL+dg6WNwBJSAe5YQ3A7tgCg+2JwA1Vhuruj4wEUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0Jgzpy+kTtu+LSw7nz2XHhHnjVX6U2f76G4f1S0kVhBgavhMvvoLucJEECgi+NzP6pRNG3upDhnQJa4ks6MTXeFlQfO8I2Bbm6UDTzW0uylgQYMZhVUg/04n3Mv4g1jovYzeSfyp3Oa1fpF4oddwAu1e2J0OuVZIJ5+BjTsST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aO92Udtk; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so6303587b3a.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763532525; x=1764137325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgcVscQv5elPLhKxKeG6h3ww2ShFuRXN9ySPCFPoezI=;
        b=KrsgEELZqbcdSVbZuXlPTCxMY0zT+WBAZ2Hn81c0pGLC+fsW6Nr4Il2EkUqSyfI9t0
         qIjQZikFXPSWN7BP+MkC8coBWebuqfDPjkwfZimcseLZ2euGMkGc68XR/dFEtaVrwUWI
         sKWGfhfaL8UFGjCSh57wXtjYkjNAx3UWxJtvt7MO3ocSbpyTmU+TM2+AQi5pmTj4KsJp
         Qg1N04gYLr5qJpD6V2s9ZGky2UsXgZkYtbvNuNpj+YXjnDQFnevQze4YGNODiSWw8ha4
         gRmfPRXTw5xhfWwZuknAdPY0kGt+Yd/G7iTI724svFsSVQVndV5YZpRHE06nBVwKK5n5
         9ePg==
X-Forwarded-Encrypted: i=1; AJvYcCXiOjbGp8rXm9JJlaiG8GQrQl+45KeX9+euFjnbAazSsM8x0HEPCHAgmQT9AwZ8g9HOaeTjTUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNI3dChxwCJreUYOkU3gWWJ6GI05JrS5AYktfKrrsIZ7oA9V1B
	YDwI3r/lMpRySxDGjsHMs/z7j6F7JKx5uitF+aMleWEVCuZy8+ADOo8/Vk1pLIuETD1l5WTH03T
	P33HXe/dHynlIMxEhCcAz5F4LYjZQdErzJmIxQNe7CkNfTuMo9CNZW4nxV3EnUWoemTbxXoDNR6
	kp5USnIAghFbhAiZMXc1P5JJbbuNFp3lc/bSG6A+fz6EWLMdWR0JddNQLD9idwWCTWwZVM7VsUT
	/NxIcJEYve6SvZwAg==
X-Gm-Gg: ASbGncvFVfxeszctq/kkA5p8pwkl7NF1Pk5Fis/4T1aXarMaxUh79RTySR4NyzURaCo
	rwr10D7Tl7WKpTNJENDHVxP1cSxpee0H53GynEy2zqLB4zuw+0dGcUtzYc50CVDTxQ0Ljmc1NDh
	mtg3aJvMEvEeiYGO2aLhFl1WfnLYPj0a/s3hNyDAbIj/mtUYpi8iYE/9MdoX7dWFctQgIwJXgzf
	qb607DAQginq+/wxGI33ulKM+3VRnfddse4YVBOcfIJcv7JHFuwFWiB9AV2tWp8DhHZIrnYQC7P
	fFJhQ1GW5/AEIm7Glu3BvGaSIx0D3CZ5Pe8ir5sw73Z4/sxgzReoBnFw6iYyZuD6DYAhegs565M
	gKt2taD5j39aQkIvjPd+6uCMZxECpuJCX4hw6sA1iC6CnKvanVjVo6UvvEb/Ld7haah8+88nDhz
	y0/eHsgNunkaFhXEdzs4paDF12Xuw4rteQSr8sV8GYTM197FkPLqxfHA==
X-Google-Smtp-Source: AGHT+IGT2QSsMOeXQKxEr9T2bnjQcDFNtMwfjVAJ0nrXvhOtWDF+iMKRxFj23Ojt/0Ku03JolxAKU9SeC8q6
X-Received: by 2002:a05:7022:b90d:b0:11b:8fc9:9f5d with SMTP id a92af1059eb24-11b8fc9ae93mr3739131c88.30.1763532524358;
        Tue, 18 Nov 2025 22:08:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11bb154e6e2sm1240985c88.7.2025.11.18.22.08.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2025 22:08:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bc4e9808b69so6687135a12.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763532522; x=1764137322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HgcVscQv5elPLhKxKeG6h3ww2ShFuRXN9ySPCFPoezI=;
        b=aO92Udtk1W7y/rAeST05wXOfuW09bdEqUVdZ9LGb5QkzswxdSZjpD0i0TtOhNobqp6
         45pusCw/J+6tFnCCac78MB7jCvMoT1HjOjkTM14Q+1XaTbyXv9VkCIV3kd7ko0q+Q76l
         ZD9uHRjxMtxeUz7w8sI7KG41naS63FkCV0Yls=
X-Forwarded-Encrypted: i=1; AJvYcCVwGtFhHa+NURp0vs5sJeXK39C+KG6NsawdVutBqT3PvvY1inpZX+K6f2PdyeomyVTJ+/8vfLw=@vger.kernel.org
X-Received: by 2002:a05:7300:a54c:b0:2a4:3593:6463 with SMTP id 5a478bee46e88-2a4abb1cf85mr9399082eec.19.1763532522486;
        Tue, 18 Nov 2025 22:08:42 -0800 (PST)
X-Received: by 2002:a05:7300:a54c:b0:2a4:3593:6463 with SMTP id
 5a478bee46e88-2a4abb1cf85mr9399062eec.19.1763532521889; Tue, 18 Nov 2025
 22:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-10-bhargava.marreddy@broadcom.com> <49930724-74b8-41fe-8f5c-482afc976b82@lunn.ch>
In-Reply-To: <49930724-74b8-41fe-8f5c-482afc976b82@lunn.ch>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Wed, 19 Nov 2025 11:38:27 +0530
X-Gm-Features: AWmQ_bmhTL-ugdLACWQ9Lvw4UTqJgbfKE_qXobJyefLOoxRjjq-dfQzAhBNDMEI
Message-ID: <CANXQDtb5XuLKOOorCMYDUpVz6aFuQgvmQZ4pS6RJGkAgeM8n1A@mail.gmail.com>
Subject: Re: [v2, net-next 09/12] bng_en: Add ethtool link settings and
 capabilities support
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000941c4e0643ec69ef"

--000000000000941c4e0643ec69ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 2:38=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +
> > +     if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE)) {
> > +             linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> > +                              lk_ksettings->link_modes.supported);
> > +             linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > +                              lk_ksettings->link_modes.supported);
> > +     }
> > +
> > +     if (link_info->support_auto_speeds || link_info->support_auto_spe=
eds2 ||
> > +         link_info->support_pam4_auto_speeds)
> > +             linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> > +                              lk_ksettings->link_modes.supported);
>
> autoneg is more than speed. In fact, 1000BaseX only works are 1G, no
> link speed negotiation, but you can negotiate pause. Do any of the
> link modes you support work like this?

All the speeds we support can be auto-negotiated. We don't see any
cases like 1000Base-X.
Do you see any issue with the above setting autoneg?

>
> > +     /* Note ETHTOOL_LINK_MODE_10baseT_Half_BIT =3D=3D 0 is a legal Li=
nux
> > +      * link mode, but since no such devices exist
>
> 10BaseT Half devices definitely do exist, and there are actually more
> appearing in the automotive field.

Our devices don't support 10baseT_Half, will fix the comment.

Thanks,
Bhargava Marreddy

>
>
>     Andrew
>
> ---
> pw-bot: cr

--000000000000941c4e0643ec69ef
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBbSJ7/ObU8h+rlqgU15/zfBKI4TYE42n8z46YyJ/hJrTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMTkwNjA4NDJaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBv+WHC
040ypLJB2BXE7KIXicLdAnUzHFwsDpz2uVP4CSDH9ztNjuJJ5aMdwm2lVcqIk1OdzVdfA8k4953m
pNOUf7kotL6YOfJfwuT0z1D7bET3CbB2fFWkf0pLd+75Ah7bv8aAvrkmkdW4Ljt7CHJNAGg53+rU
SAfpdGaZEOz//g6j6aY8PEObU1js7f5m3sHEyS3AKIk8xw5BlqmwOVeczWvtJCYwCEfLqRaFcgtP
v729VWSepk1AaherJKnog3jm0CJ1wgH6oH9qgYHNQ4CymIPbltdhk/6aBpO/1uYe5mozUfuKt7aU
r/69ltw14pxwNjpaQBB+r6xn/PBjZEq5
--000000000000941c4e0643ec69ef--

