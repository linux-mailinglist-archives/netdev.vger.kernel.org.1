Return-Path: <netdev+bounces-236173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A6C39325
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 07:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA53A34DBDE
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 06:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483262D978B;
	Thu,  6 Nov 2025 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h01DhykP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A21917CD
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408868; cv=none; b=UHnXEACW7m0eRNeTp/M3bIXPzjqwB5tLlvGTUpiYmC0UMyLaCWEVjvFCONwSz4ebdVLArZoFz3WQvnLOmS7ozolDaLRuDv3vNLNZUQJ/77SGejb6VbPE8hI01x5ppccooBts4r2Wtm9YW/M3x6k1DF9woAWly/1Y2+FCZW35leI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408868; c=relaxed/simple;
	bh=lCNNVwI0SG8GlOPmPhtF5DGxcz3NtsYVOoGxojD1XOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnrkvmlaTF40E0ohxnLqprENn12NbEj/rRU5fTfH6lxUv0mBepb/IKyJ09LEajUypHZ5oK2TYkpz861defBFoQp927KPzSj3EtK1lWymUI1lFXh+a++J6DG9A7z/ZM3PabtM4wsHk0pa3fbQWnsZ0VexUH/zLBP7n6WgbROPQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h01DhykP; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-94880a46f3fso3529239f.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 22:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762408866; x=1763013666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBDrfVCPV9UDuaCd3lbJ5pszosQLoNSpLpTTcdGZR84=;
        b=Yf1vzuLT6orHVA5vP+vg+/AGNl9i8okQD/ziwuc7071TNvCtxw6aK6ZBTXD2sTDpkG
         4T1X01kF0pGsUVr9+kH7b8ZU46cN1Y5kVULidKOs1bo660/74GJvTo8PSCEs0CbrvXGn
         cjz3irlrUl8rNoQiZz1ddDITO2dTqaZ9abKXXUWLmsVL07F+lU6PR+6fuwdYVHpqJZRK
         8mGZ+bdpZ7WnG4Lfw0C1ZDqjQiUfq8tqXvtJ/Uczvap9uk2wjr2ib11J8DjA5a0B+Tzx
         HH3LPXAGxp2ozOcf55x4Cxx0P65RPMOdbwxM2oOVcISrt68hPpmnXSFH15QZ8fQPcNgP
         Ca3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPI6EAN+zhzApX+GAM/8QkWDYV3vPcfS5tjKTWQNPaDeuDYY5niX29tH5E6kLm7vwsl14W+hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxD31RoK5+JfU1ioPTmWK71UlxlH8MApB7kcbBRMOR5CPrelbK
	jegA8lncoS0A2nfvs+sJCDEJGQ2NaOgaSS0ZZ4RSTZE+x1NhMyxPAhqdtr+anGNpezw4rKAzjs7
	BevirqdIFwM1ceZtUI/j/s+CyHPYD4IGJLtbJElXs9iigzsO5nycwQ/Cn0MlHvupiO3Gp2WFQtn
	a73BJCBnK48KH4SyZQ9ytMMTlggb4Ahkh9353LXxNYoLOxdWgx6jRXF0QvOS77jDZg9IsM353N4
	HQW4PK9T0I=
X-Gm-Gg: ASbGncsSZ4MnWVs/JQAMdWa2kogtdmwgpsWfS4pSn4kKjWfKO23iTszj5fgrpJXk4dR
	xht+1siKxjpAwtMd0vQsVU3jTJBo33m3tv0y9hswWkIcgdZJr4gA9A3YQat3TI1mHYEpA9DCdeR
	+eNSrXtdSgJNiSEmh8oRlsfz2FQt4Ws3tMYuNGWBy7DB3o2Irakcgu7Sz7A9pjwJ5AE8X60RIpA
	mySs3keG+WQMxhZWZxInJypdAIIVs3ZpABwlLjErujZ/6m07BwgkXOowIhx9hL/5XGK7KtCx0Yg
	zmJMxRd0azczrCqj/DuC6CcE7zNOjEfyf3Vwm6QFzrmbLjiZ4eEqs1y2ljSh0X7bJhMLit4XrV5
	dOXdyw79LZMFOLWMzo9Up6UC0y0GUnMyyXC+YqYSoOwW2pX37XcWmIrt8ah4oi4eyb0wVfISDbn
	Qy3p3yhVWeWnxJ2hPz3MhFOYc0Bpvy9p4Vig==
X-Google-Smtp-Source: AGHT+IEcjEPhbSDoJ/COLR/XT0gPNrSbVoyqfA9eVFZhUC+eAsN5PYVGJT85PJr69J/BONwq8mahjYGbBfkb
X-Received: by 2002:a05:6e02:3c82:b0:433:2844:111e with SMTP id e9e14a558f8ab-4334079a241mr89305805ab.14.1762408865614;
        Wed, 05 Nov 2025 22:01:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f4cf4bfsm1188185ab.34.2025.11.05.22.01.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Nov 2025 22:01:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b72761ab959so153485166b.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 22:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762408863; x=1763013663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rBDrfVCPV9UDuaCd3lbJ5pszosQLoNSpLpTTcdGZR84=;
        b=h01DhykPXby2e8KOf7RzIgVa7mGHTX6CmrJIpsdrON1I9JIMpeccmITRCvsXPXfJCn
         OXOHod+bMB4MUj60QeV0gZ27RdA0RKfB8Fji0W3nI7VAT1uF1AzwZjiIS60H0NXGSCo4
         jBjvrn6XCDZZ88h24N2NMe688op0rsKycK7oo=
X-Forwarded-Encrypted: i=1; AJvYcCXMojAtf3JbhZcI1SCgTINP8Bkavi9BbrxlAef04HP1Vh1fewK2lBDLTVDNVW/sKgRlsttPeDA=@vger.kernel.org
X-Received: by 2002:a17:907:72d6:b0:b70:47e8:9eec with SMTP id a640c23a62f3a-b726515dcbcmr671878566b.12.1762408862868;
        Wed, 05 Nov 2025 22:01:02 -0800 (PST)
X-Received: by 2002:a17:907:72d6:b0:b70:47e8:9eec with SMTP id
 a640c23a62f3a-b726515dcbcmr671876366b.12.1762408862419; Wed, 05 Nov 2025
 22:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
 <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com> <20251105170145.461c8f11@kernel.org>
In-Reply-To: <20251105170145.461c8f11@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 5 Nov 2025 22:00:50 -0800
X-Gm-Features: AWmQ_bkdbX4PBkxmfmDwcd8kg-addj9GoQ_2T0ts66VM8exsDHcl-JIUl1Co6CI
Message-ID: <CACKFLi=W3ra-sQyAAwekJc6u9aGZ1vV2g44EUF1XYyhCDbBmZw@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004096260642e6ca97"

--0000000000004096260642e6ca97
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 5:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 5 Nov 2025 11:05:34 -0800 Michael Chan wrote:
> > The existing code to use num_online_cpus() is actually not correct.
> > This is more correct:
> >
> > return min(netif_get_num_default_rss_queues(), tp->rxq_max);
> >
> > I think when netif_get_num_default_rss_queues() was used to replace
> > num_online_cpus(), tg3_get_rxnfc() was not properly converted.
>
> All true, but perhaps we want to do that change as a follow up?
> Someone may show up later insisting that fewer queues cases
> a regression for their workload..

Sure, we can fix this separately.  This returned value here when
!netif_running() really won't change the ring count when it becomes
netif_running().  tg3_open() will call tg3_enable_msix() which will
set it to netif_get_num_default_rss_queues() regardless of what value
we return here.  IOW, fixing it should not cause any change in the
number of default rings.

Anyway,
Reviewed-by: Michael Chan <michael.chan@broadcom.com>


>
> The sensitivity to default queue count was why we didn't change most
> of the drivers when netif_get_num_default_rss_queues() got reworked
> to a more sane default than 8.

--0000000000004096260642e6ca97
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAvg2yw
NQ9LMNBEqewi18pouaYV4/uQWY97+TiCuqzzAzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTExMDYwNjAxMDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBfalTabN6jdtL5wG/swAuetF86bDxS0Ef3AVDwebQ0
5fEjLDHwdjEtE8yBRy/XsQtPtMhyzw0ZqvfusjkpudEZIqGeEmlj1r2/25Nj8MxKMI3G2pbX29+c
Kj6zEslMkP879qJ+42AOOx0rXcsa9y8pes6zRPX+3p4pJw9WzVhfztfdHXV2eibtiXoBdxLdk9W/
C0dlH4E/leAJ6crXev77Euze3PdHXIZ8Tc4KIe/P/GTFi6un/H1d6tFJxXsio5BQuttSRejljOb3
pH8Y7R16htJnmiA/d0/sQKiB6r/QYx9RsLRwSzGKX8G3F0iw4knA68CUhtG/3Wqkxr66xuZi
--0000000000004096260642e6ca97--

