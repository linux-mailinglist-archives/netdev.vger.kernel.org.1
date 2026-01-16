Return-Path: <netdev+bounces-250598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43BD3848D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9D773005187
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DB34D3AD;
	Fri, 16 Jan 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SKSeq0X0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B662040B6
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589033; cv=none; b=ndS8dPgEkhnBcYEghyMIOIg9gXFd8sGr2FMv0Tjs3j2MruzaF/vzRGfjVZv5StngEGsji53e2npLobuyyScAbD47YR1LHxT67Yp7mdhy4/DRsXTb2bJrKz5Vp1E7v3iu27aQHbuI1rrsYtJ3fWQmDdfcmBmX8W0LjDgT95g3Deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589033; c=relaxed/simple;
	bh=SUEaNDxplUOb47LzR5mhKI4o9EKWUvc4rZdS2rofKmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd1ZXmUKib4JZBMYawpW/VPN5GmAJCwpbWdUXjjbX2T/Gt31cB9himpb2Sd/L+3aUADStF6s7G3eeD/6gMPKwn0TtnN6tDClHzi2ph3q9Mna8lz57LZQeb/1stB+y64hNOLo50JatFMK/xS3OGhrwrfsZe+L8qS6GoS2PWJKMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SKSeq0X0; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29f0f875bc5so16733715ad.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768589032; x=1769193832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q71b4JL5fBhpj5AaMBaXZvKZky8nFZWraDOLpMoZEw4=;
        b=DaR/sdaqXNtsh1G2T035fShL6UNAypCNHxged7SZ/hGrqKgx3GCALzlgQn3220IIyu
         gj9YfQKc/YLahLaJ36B0wGuvbPmNBz9V/ZGCKpfXbIzqi680NdJmxvCzMUKt0FxRXT9t
         M8iQIUjuvKpepoGrYJrrGL3JlUrK1ZV/8jUKodexIj1ObPH7+A1yLT3IkNxoVZMMs1Ea
         6A2SyKikdfqnJcB21tuXbA9T8Edpy+mA4n5Of69VmKyZpfbfktYIP/xxG2Inlbz1CGbL
         IZDeZgYfd2TlAG7BRkI5GrTUhJTsv/VKNNYJDZWQwD2SltIDS0UH0TVoRDlJHxkoLJvx
         hjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjq0cvD9gUj+EmNmhSeKXKMKtoS0CzYLuWwIJkQY9ROwJqj1btj1ZaxImvxC/bAuX1PtAfxnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9UiJiFGzxdFUIeqcmuguSxKQZoZJegwLlNhvumDOEarTtnmn
	So8LRWcv7BxMCPtP0mmcZW10jJDCQUiv66zgUh2IrbBnaBG+VuGI9NOqzj2bsstdlUBPt8TlImB
	FuJkJSjb5bJ2xpmyDEcKFkjSiZJHm6ip28HfN8t9b2ZHnpGg5W94X6/pgUfJvVhk0cmLymcwMIF
	XJdfVd28E0q5BN4FkegGyNtbE4wueBnDLld72GxYfIrm9vl8lKU8LgzPIBkbl/33kVxLi3dxxm/
	LUTcrhAiamng+1Chg==
X-Gm-Gg: AY/fxX6TGTQy0Ca66+UDakDT1jH9Hq3Y1pm8F1l986/ZAw+EakJfJEWspOa8YY4PSCm
	wC+9WeNcUXA+vwr0CRTlQzSSlXYpKAkLvtPfUbOpX8MeoDpCYBba8ZUFWGmbBg2nwpNibj0/Flt
	wqde4QKdcp8SUoS+0pI8SV7FR1Z6G0W5voAfuOllZWbG3S5yAwzRvnM16GwvGz8uxGeHyZN2NGp
	E7ysm7NbVrtHFIaGeJfsQ50pB+X+mCVzFs9tr/fNVMHYBS/JCH4JY4UcuJs1bLQpml1bzYoDWnd
	Pyhd7SInRncnBkH9CEFI+CcuhI8ZH7QQ/73U+3tRJbikjHcqdg399HVZzwuIved3aWZDBkk2h4V
	P8LFZ00Py8GNUEZ1/rbMu8yIX5v7V0sYuu+fTNxbyJDVqlPtPinyyLmLAWKa1jZJsBmYnruuIWK
	zXJF4WQ9d1nlgdn5cZkFh7J63SVJAAbgNDJI7a3uU8BhSWsyd8/SZNbw==
X-Received: by 2002:a17:903:2f06:b0:2a0:d34f:aff3 with SMTP id d9443c01a7336-2a7175393bemr41845835ad.18.1768589031653;
        Fri, 16 Jan 2026 10:43:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7191917cfsm3917845ad.36.2026.01.16.10.43.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 10:43:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b6af3eb78dso6897508eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768589030; x=1769193830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q71b4JL5fBhpj5AaMBaXZvKZky8nFZWraDOLpMoZEw4=;
        b=SKSeq0X0LiywwrteBQao411H6W7BCIASOUg+4GUE06IggLAsErhkLL9wf93Dx2JIXt
         4nf3KzZ0u+thK10VLRvirTb0n70r5DmgcySfROzfXhQ2nvcGU+N9go8GuVsZWQG/MWJr
         L+Kd4k9VyRANSzsvwwY0d963k//mdYy+R/Exw=
X-Forwarded-Encrypted: i=1; AJvYcCXCgwyNCkah6+PYnr1drZl2baskqyJHUtmd2rHWH/6oJfIyOYZNW81pFkysNtxJetAknFUpDLA=@vger.kernel.org
X-Received: by 2002:a05:7301:678f:b0:2ae:598e:abe8 with SMTP id 5a478bee46e88-2b6b40d99afmr3336687eec.24.1768589028593;
        Fri, 16 Jan 2026 10:43:48 -0800 (PST)
X-Received: by 2002:a05:7301:678f:b0:2ae:598e:abe8 with SMTP id
 5a478bee46e88-2b6b40d99afmr3336603eec.24.1768589026598; Fri, 16 Jan 2026
 10:43:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-5-bhargava.marreddy@broadcom.com> <81fe0e2e-5f05-4258-b722-7a09e6d99182@redhat.com>
 <CANXQDta2Xn33j+Da_K=7LUHKj-SgMNdKT2wx5W1Z5nFw2uKDhw@mail.gmail.com>
In-Reply-To: <CANXQDta2Xn33j+Da_K=7LUHKj-SgMNdKT2wx5W1Z5nFw2uKDhw@mail.gmail.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Sat, 17 Jan 2026 00:13:33 +0530
X-Gm-Features: AZwV_QhEchiYDY3Egw6FETFvZpLPchyGdQvTz-8QUinUvzks4r_u-oY2TwKMGAU
Message-ID: <CANXQDta1rEDvzAH2akvOHOO=J5SKeYefrigiqx7YGBwv-VF7Dw@mail.gmail.com>
Subject: Re: [v4, net-next 4/7] bng_en: Add TX support
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eabb26064885b87a"

--000000000000eabb26064885b87a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 2:46=E2=80=AFAM Bhargava Chenna Marreddy
<bhargava.marreddy@broadcom.com> wrote:
>
> On Thu, Jan 8, 2026 at 3:39=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> > > +static void __bnge_tx_int(struct bnge_net *bn, struct bnge_tx_ring_i=
nfo *txr,
> > > +                       int budget)
> > > +{
> > > +     u16 hw_cons =3D txr->tx_hw_cons;
> > > +     struct bnge_dev *bd =3D bn->bd;
> > > +     unsigned int tx_bytes =3D 0;
> > > +     unsigned int tx_pkts =3D 0;
> > > +     struct netdev_queue *txq;
> > > +     u16 cons =3D txr->tx_cons;
> > > +     skb_frag_t *frag;
> > > +
> > > +     txq =3D netdev_get_tx_queue(bn->netdev, txr->txq_index);
> > > +
> > > +     while (RING_TX(bn, cons) !=3D hw_cons) {
> > > +             struct bnge_sw_tx_bd *tx_buf;
> > > +             struct sk_buff *skb;
> > > +             int j, last;
> > > +
> > > +             tx_buf =3D &txr->tx_buf_ring[RING_TX(bn, cons)];
> > > +             skb =3D tx_buf->skb;
> > > +             if (unlikely(!skb)) {
> > > +                     bnge_sched_reset_txr(bn, txr, cons);
> > > +                     return;
> > > +             }
> > > +
> > > +             cons =3D NEXT_TX(cons);
> > > +             tx_pkts++;
> > > +             tx_bytes +=3D skb->len;
> > > +             tx_buf->skb =3D NULL;
> > > +
> > > +             dma_unmap_single(bd->dev, dma_unmap_addr(tx_buf, mappin=
g),
> > > +                              skb_headlen(skb), DMA_TO_DEVICE);
> > > +             last =3D tx_buf->nr_frags;
> > > +
> > > +             for (j =3D 0; j < last; j++) {
> > > +                     frag =3D &skb_shinfo(skb)->frags[j];
> > > +                     cons =3D NEXT_TX(cons);
> > > +                     tx_buf =3D &txr->tx_buf_ring[RING_TX(bn, cons)]=
;
> > > +                     netmem_dma_unmap_page_attrs(bd->dev,
> > > +                                                 dma_unmap_addr(tx_b=
uf,
> > > +                                                                mapp=
ing),
> > > +                                                 skb_frag_size(frag)=
,
> > > +                                                 DMA_TO_DEVICE, 0);
> > > +             }
> >
> > There is a similar chunk in bnge_free_tx_skbs(), you could avoid
> > douplication factoring that out in common helper.
>
> Agreed. I'll address this in the next revision.

Hi Paolo,

Re-thinking this: the refactoring is non-trivial and we need to
restructure this part for
PTP/XDP soon anyway. I'll skip it for this series and include it in
the future updates instead.

Thanks,
Bhargava Marreddy

>
> >

--000000000000eabb26064885b87a
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD4Paz4luTEA0Ja+l/gVmikMr03mlvn6FTF2VIfrqtM7TAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTYxODQzNTBaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB3jbbL
k8TX7IrPhhC1ebRu9A6iuh89THEzIl2kwXEaq4xBiaVnn7dR78EmDCWQs3741JjZsFi5ZuK2jzOV
WHXGo0DcmKvlgcgTNQyF0IFq/K7Ws8kdxCkGdBZAM8sWsnuopGqwjCyou7TWiWDIDt84iKPkGx1D
2TVnoEN3wsPXTMSYaLfv79Z5NdAqOSCQ/LxwVcynCA1+OmwZI2Ub3s3uSlm5aYk/EyV8KvNfdXeM
zfa2VN5Dfu9uG6THJfq0eX0zBy0d49QT2k/2ilS0Jwt4z/KljsIkY9pwu1kx1brcG8I60/Bl+GDm
diyKcrdfecPuBtbzoWkdseX9CCkCpoz4
--000000000000eabb26064885b87a--

