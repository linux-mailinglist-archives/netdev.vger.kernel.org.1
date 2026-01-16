Return-Path: <netdev+bounces-250577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4868D339C3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9248230638B2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044033CE80;
	Fri, 16 Jan 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B8IIF58r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F293090C9
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582720; cv=none; b=PSR/RcIiOdENbtSo0D4y/nMCO5BJX5v5nfLdcpSn5v7f1/v0bcQJxgH2AU0KHFv4Blwzbyz9jggINWkTmqnmpU4pwR4WEGc3tlwqxJZibkXKwDXLzOuV/XbpZ0xKsFi4BKPfzFn8pk/qP+5Jyh+uAklgwqvs7I8XG7q1Kvby7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582720; c=relaxed/simple;
	bh=Km+0rIBMsKbAVuerygk2i2a9a6JhGTHyZjQ51Z0/j/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8daizwjfTk/bzhfcmiG0Vla+Hv3k417QwjaHT4mcqHMXOTM5wT1IFuL9BcB1KcN7DUdV7sW5WKyLmTb7xQ55Ov/zxP/PHpnOlyAc/gzZo6T7SPL+Gy9tETvK8HdSnyO2/zeQt5NLp7AKzhq6hmjQ1Gn1Fc4rxNIXrNzvtDTcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B8IIF58r; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-501c6665144so22965041cf.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 08:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582718; x=1769187518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uei8DWWPE9IM45xUsHhEVZETziY1XwNV8Ym2J2xd9uU=;
        b=MOmv5lC/mNJkWpEBmE6hZrtW9734pa/XLY5Hxwxs0GvgYL2fjH483Gr9jPuQBZlfNP
         fLsC48U+6sE2M0oJ2dNMgCzOXjs9cMUFwXjxtzj/CqYzgiJLv6hkK7LIzXRTzrxQyXxl
         gl7aqRWzPTQtC16pBMieEyn0PFZXtvCquY1daUhGhJ8Yp31zkvxbawnkai2+5sh5f5sy
         KV/ZCIWRadm03SnSw4WGcIfDHzTCLPq7Pglznmi29YjYh83eDcMiOxrVJteMQdX9weQM
         vqm8pg/IQ6VgZEtukWzXDr0GbhZ2MpV4v67lMp4FQdKZQRhnZUvEYYLmwcyYjcazYb1H
         PG+w==
X-Forwarded-Encrypted: i=1; AJvYcCXBDrQGpz+ximmoHAItA4DSY78REdUqT1LZKO6BU8Krrq5fVVAsPO6Ep8i1GZTNahGqznPiLrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyO+p2pSWv2rOgsDjW3Ci3zAx+S1/sBJ70Cajpsy5Z8tJYOvo
	wAWsEPKO8ezBh1y+GjdQhVp462QAbhyX/KfaBOftGpH4aQcwF+ph8KEeWmi6bqqdTi++YaywhUf
	qbebk+aiVdh8b9N3YFTVN5jur4Dvu8wzZO28ftc0ARDUdlDN2PAifOA4kBSwf3MO5VjqFIEQD41
	ktXB6tor80jVrWwJlyy+B4UpOlx9BeV161oZmPV8yblf4UYng+lZ1GGf+evawZ/XZGksUMae7Xq
	i9pPe8mzEUdFW7cdg==
X-Gm-Gg: AY/fxX7JGdfr743xaW5V51KtupNoWHZXtA4fIsecy2BVYBRiE5Xt2ZPHzrxg//oaEQy
	A/5OWJBP++swfk1DXEy6TG3zQejDHdFBTskXf5BZKgumbVT43KMchTcdE5SwA4I9kykAV6Kvqmv
	2MMjSGhB/xaeUr6wk3lzByYahHAbTQZgPAJN4EUPTu0FmpTld6C4aSKQmuyhhCLCNTuQfITmTyy
	MMoQJxwTDDQZqndWi/uGQpRP+nR/DFI3ruCqrf3JCmZGSWAedCNiuqh+iPJuC/86KLalglg+nTp
	KmslMbfMRJsTux95RaGH/8JNsbtI8uPv8PyteIBg0iV8sbvYki4HP1voRsp/Gy9/ridsGIBeHbg
	HPFJqDC/iEGVRb2G+TtF2STxW9Mjt8kD/eGPST2iND9sRCp60IB78mEd/9m0nQvZahrg05Upvoo
	7q1NqjqxLkBqw2Y/L0vEXmp2Roq+X7VdNGdD3B50+v/NQuLFJYFy8=
X-Received: by 2002:ac8:5d13:0:b0:4ff:b211:6aa6 with SMTP id d75a77b69052e-502a1e08f85mr55056761cf.27.1768582717736;
        Fri, 16 Jan 2026 08:58:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-502a1f129f5sm2263021cf.9.2026.01.16.08.58.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 08:58:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b6a8afb513so2417887eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768582716; x=1769187516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uei8DWWPE9IM45xUsHhEVZETziY1XwNV8Ym2J2xd9uU=;
        b=B8IIF58rZfovqlpTHhYjiXFx2SuTfO/tJ8HQEGX48+tQR+12JcRHixSyj/qSCMhVfh
         YFyadiL+RhKhovB608Gq+DSnkfyjr4KV+dnEcivke8jLEYs/QGTEt4BLYoXDvukAY+yf
         bJh6YmdkO6v7OjWjjaBH/KWA/8hPav87Yv0Fg=
X-Forwarded-Encrypted: i=1; AJvYcCWg90QtXAtj+2nOzvqOSNnqAjH6qQQF2PZk52ALyUpLtfBL39vABjip4BUXlW9Otjg6JexiYdg=@vger.kernel.org
X-Received: by 2002:a05:7300:730a:b0:2b4:5514:38fd with SMTP id 5a478bee46e88-2b6b4e64b45mr2814665eec.20.1768582715027;
        Fri, 16 Jan 2026 08:58:35 -0800 (PST)
X-Received: by 2002:a05:7300:730a:b0:2b4:5514:38fd with SMTP id
 5a478bee46e88-2b6b4e64b45mr2814598eec.20.1768582713020; Fri, 16 Jan 2026
 08:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-3-bhargava.marreddy@broadcom.com> <a3aab7af-3807-4f37-92e0-5ea52df1bd4c@redhat.com>
 <CANXQDtYR6P9+oHXpAzxPk4cE1jSYCFoCbELcWad25h1c6wfmQQ@mail.gmail.com>
In-Reply-To: <CANXQDtYR6P9+oHXpAzxPk4cE1jSYCFoCbELcWad25h1c6wfmQQ@mail.gmail.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 16 Jan 2026 22:28:19 +0530
X-Gm-Features: AZwV_QiWzakK8jsVaA0MEyRyBT6sm8wRwjnlp3pDVEYReWi2tRN6JfUtT-FEs-Q
Message-ID: <CANXQDtaLFQc3XRrLEH2AytcZvkeUdD9AW8=KUwqGQvM+=Q6M2w@mail.gmail.com>
Subject: Re: [v4, net-next 2/7] bng_en: Add RX support
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000099e43006488440b2"

--00000000000099e43006488440b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 1:14=E2=80=AFAM Bhargava Chenna Marreddy
<bhargava.marreddy@broadcom.com> wrote:
>
> On Thu, Jan 8, 2026 at 3:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> > > +
> > > +     dma_sync_single_for_device(bd->dev, mapping, bn->rx_copybreak,
> > > +                                bn->rx_dir);
> >
> > Why is the above needed?
>
> Since the buffer is being reused, the for_device sync hands ownership
> back to the hardware.
> This ensures the memory is ready for the next DMA transfer and
> maintains consistency on non-coherent architectures.
> Any concerns with this?

Thanks, Paolo. You're correct. I took another look and realized the
for_device sync
is redundant here since the CPU only reads the data and hasn't written
to the buffer.
I'll remove this in the next revision.

Thanks,
Bhargava Marreddy

>
> >
> > > +
> > > +     skb_put(skb, len);
> > > +
> > > +     return skb;
> > > +}
> > > +

--00000000000099e43006488440b2
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDddDCglMXWjI7HU8S3C+S+n+McEo5n2Ug4Rh3wtTU+MzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTYxNjU4MzZaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBKCA4W
w47y6dkzqKHN4ghmV1wJ2I+1ediWquyrZcayIDncgF9+hdI36IvJ1rH7J1d02S0jRyNjxrWGz6fI
AzVrNuvNKCPgGJSHsnTlWsKIkZ6jZRfrU5dQd6Y48oRaDU5/dVWF2WYa68lbBixkA8I2YgjHoRmF
NRVo5vhbKHiV1GbPVaTraReqE7TzTUJ2+OwRw40uxRW5cTlj6ZP7UWOwJRlsYEnTfQqAnS97Hxet
xzqECdMCRAoufsgYyJK1PUMa1fjR0jTJ1dG2yNWerwVcP9oXORsJmDmlABxaFdnf6/j4p6NuF8lE
iijEPt4bHjiQoa5CatscrqMOoo8FJOEm
--00000000000099e43006488440b2--

