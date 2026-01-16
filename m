Return-Path: <netdev+bounces-250575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB99D33956
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4788B30EC0B3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC52934321C;
	Fri, 16 Jan 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WImMs3qt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AD39B4BB
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582058; cv=pass; b=JIF0oIsJjp7HvqFw1iL/y2d669c9do7GuzviStUKcmg74w/IGBgu+KvRnP3a4KdtlTOZEvyxdAr8T25Fl8gkQYHzOhq3VqxZtBSq2wDQnCmmzeWnLoereJUIZrc8VgYE0MjERBfIzIYA0c6YbeM5QU89MZ1mJSC7CP/GRRl2W08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582058; c=relaxed/simple;
	bh=qAyTWEJ8ohRYJ3hpIlJNB1kL5zfWdNJ3V8LCGdAUR40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9WnIDyQF1mvrjU0K0GB9IGs6gYY/Sg6RP7RlBHxMrzwPtaZN6K9FcBwAY/8K9uQ9LK2bePpbRjdYQclvnaLDJ/AgzLPSgpscDI9GPBzJLPah55T1VseOAguIjLijMiXdVnhvaMpQ0/mAXoiNN7QXN5T8bwdIh8tbFTTh40H94A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WImMs3qt; arc=pass smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-79088484065so22348657b3.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 08:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582045; x=1769186845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMb0WALZwGjuAmZYuZw5xk7g954FJD/GgrC+LeF4kjA=;
        b=LjHfvk+Re4Iw7/Kx4NP7H1eGJoYo9h0J77l/T4TEK8FuxFNff4fa77NhBXX4TR/rsS
         MCOq+pbp9kvvp5Qi8PFRGXGx02cyAG5v6L9p2AvZ62/avlQBxflnepp1XGtRqYbUXCCq
         GO2Xr/rDxHdx463SAzHp8eGlLJ7c8wuDuuFyioarAlGvI28WQg2TaxITrdqc37prl6Kg
         An+HaX9mGcLeBgPnMDVh3U7pT1oTN9Nl4BE9cImQefjmXGOUFxuZFAAzqaljLoVOtyxl
         h/mRMXNHQ7hhkSGCBvytkT4O+Y9PDJnDoISfztbZna6CDQqSaEYLmpopbtF8bpTQX4DT
         uejw==
X-Forwarded-Encrypted: i=2; AJvYcCWcphvRD2FEiWNUOB1TZD2csmlCIiwaQQxiCAemdF/xuZHHpkUq23YmLwdzc/ERE6jqfOa1nrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QVLflmVvclH/B8w9ZZBORnT5N5I/ALXjBLIXkrucLwXBbwDH
	kP9AHU9UuV3josSoYkZ9jPVmKnMI7SK0fgk9Z40B3Olz72+uf3cjAug0GqsmomJOHAWyTGctjaK
	vkxRX2djVFfx/U1QTGFZKt8/1TLA1eRdEDeUVAgf5OScoOmrJQ93IkbgPIesZXFTVsHnR3IfV1F
	PH40R+/F4smJAO4B6fQHnXsVtr48TxuFinsKlEWgANAjMz/6X83uxGN9Nsw47+vvL6VKiXW9gIH
	93o8aaKdrpxZbW7pA==
X-Gm-Gg: AY/fxX4tmAni+0ixOQrGgUswaykZ90FK1o+9QhkIHPtQ+jvEIQUaR9Fu8dCC+GJ6fDw
	lCEY07457y5pLuUZjKAuMPguU4QF/E8wfScoqqR9imoLIfvVXp8aFL1SWoF1MKxufjy4LX+SaAN
	ApQt7+z8rAUvdjW8SKgT8tS8jrkS3L4xHncApEHrOG1AAOhjqQ9D8D+ONfZU46tmSnLGUzJ1JRx
	ou3q/4Bllq1GtWpn49upartCzSNJLIv8j4Sa/J1l2BnyCvvqUntEc+azKHWVHXPqITkI8vH+QrS
	kF2OBdFe3jQsLHC+eXVgYSkRRKRvljQb5AZQ8OWp7HyKIkcKD/gMlQ7dmoMqfNTvjYqEe60aIFN
	rhi3czMqDOEJrr0G9g2BYMX4XwMT/TfOgYNrrtdiOI0OxoBHD3bTJPo8ferrGZGNImid/ZkPh0q
	FwamBFQ5nAX6gCjwONivfQBlfQcglrBzm2Tkk0FHrrrYP4q/mdrHzgdg==
X-Received: by 2002:a05:690c:45c7:b0:788:e74:b267 with SMTP id 00721157ae682-793c54053e0mr64160607b3.65.1768582044537;
        Fri, 16 Jan 2026 08:47:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-793c67137a2sm1586347b3.14.2026.01.16.08.47.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 08:47:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-123377038f9so7172549c88.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 08:47:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768582043; cv=none;
        d=google.com; s=arc-20240605;
        b=Z3VYlYjhReCTLUIYmDF2iD3JQ41Nl867mkp7wvUTx140OL2En2Hb/darJeXfjxri63
         zrGMJnwf47HGGE2OepHlhbTjt8G3ORCaxV0pfPR1zrpLlKXfO4WXQad0qEgxAcSXbqIL
         Z5MrGHDLJWIe98ywEmGLWtLaJE8zwpgcnseK15FtYyONYqQS4zWAngrlYtOUFdTs23hW
         lJ6PEQqVIWHdlZpewq2DVGQpv3Tpz6+ezZLE6V3Y78EQl99CpzUim0G3LQWlHE2Jza2g
         pr+UsWX1keAxDXSWoNDVpnXlHh8IqhdWcIl4EZJ3jbPUYB4XbGAwBn/W5budy/C1OYDO
         zvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SMb0WALZwGjuAmZYuZw5xk7g954FJD/GgrC+LeF4kjA=;
        fh=9VaF3Ij+3H32vvNgXkMXtMXadYfH1oVFWJYLlk5CoSA=;
        b=TZ58rpW++464XqQ15ZUQOeL0wF/U2wK2iOnj4Laxr80gJwzDSkosjN7I5GMGRaxJF9
         3PvwV+5lnc4jFFwaY6YyCBOoKQqf8d7PEsAldTTkWntG+9dN9qWMUSoP4Y8uL7OHrWIw
         ZpiPcCfwi3iqgAYXVsYGKmu9KP7vBvWK6QQCKMLCg0M49ONwCkhT6F+PlQdhVGakGSMv
         j25SvXlGwGoNWus7rvAFP0Ez5Uz0GmGcsbT7EA6aZYlIvA8IFyiznm+xyFz2Q1oc1lP7
         1fpcx3w9pSPCD4oAOnAjPjzDOaWc5AtXX6iSSOHtknkgTxFunRV8I999L5FGPnh0yoKC
         Ybwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768582043; x=1769186843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMb0WALZwGjuAmZYuZw5xk7g954FJD/GgrC+LeF4kjA=;
        b=WImMs3qt1bynYd8LzsLCaSbyaWPQW7gEb8IypDDu7QRazYBc7EBcHj92WNxUCi9wN9
         7EiwEJEItMYsC3ye2gIPbJTfvF1CQcs3Injz1UEsMTph/cv0lWPMl+TjYnNxdVaTtB1X
         h5DfcUVFQvYAuC/fAALzFvdZhod2FKguigzcU=
X-Forwarded-Encrypted: i=1; AJvYcCVqAc3vNhCKiXBOdts9Ae/3RYSsRxveA8POTbqAJEHLcRYM2gXK0Wgrr54Tn+1N73mRxlSRo8o=@vger.kernel.org
X-Received: by 2002:a05:7022:221a:b0:119:e56b:c73d with SMTP id a92af1059eb24-1244a6d7e40mr3611280c88.2.1768582043243;
        Fri, 16 Jan 2026 08:47:23 -0800 (PST)
X-Received: by 2002:a05:7022:221a:b0:119:e56b:c73d with SMTP id
 a92af1059eb24-1244a6d7e40mr3611259c88.2.1768582042798; Fri, 16 Jan 2026
 08:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-3-bhargava.marreddy@broadcom.com> <a3aab7af-3807-4f37-92e0-5ea52df1bd4c@redhat.com>
 <CANXQDtYR6P9+oHXpAzxPk4cE1jSYCFoCbELcWad25h1c6wfmQQ@mail.gmail.com> <ec0dc3cd-687a-4612-89d9-3c5cdd093ad0@lunn.ch>
In-Reply-To: <ec0dc3cd-687a-4612-89d9-3c5cdd093ad0@lunn.ch>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 16 Jan 2026 22:17:08 +0530
X-Gm-Features: AZwV_QgW-bSPabsY_SiI1_VMLJi9X2NtH6YD9EKakCPxabxH2-VyIIUFWJwvL0s
Message-ID: <CANXQDtabZu+Jyg57a5z_YAkbST6Wjuf_0-PQRAZR5NHXWsg2Sw@mail.gmail.com>
Subject: Re: [v4, net-next 2/7] bng_en: Add RX support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000075e42306488418dd"

--00000000000075e42306488418dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 2:41=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jan 13, 2026 at 01:14:33AM +0530, Bhargava Chenna Marreddy wrote:
> > On Thu, Jan 8, 2026 at 3:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> > > > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/dri=
vers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> > > > new file mode 100644
> > > > index 000000000000..4da4259095fa
> > > > --- /dev/null
> > > > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> > > > @@ -0,0 +1,198 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/* Copyright (c) 2025 Broadcom */
> > > > +
> > > > +#ifndef _BNGE_HW_DEF_H_
> > > > +#define _BNGE_HW_DEF_H_
> > > > +
> > > > +struct tx_bd_ext {
> > > > +     __le32 tx_bd_hsize_lflags;
> > > > +     #define TX_BD_FLAGS_TCP_UDP_CHKSUM                      (1 <<=
 0)
> > >
> > > Please use BIT()
> >
> > Simon Horman raised a similar point. However, some hardware BD values
> > use non-contiguous bits that make BIT() and GENMASK() overly complex.
> > We believe the current definitions better reflect the hardware spec.
> > Please let us know if you=E2=80=99d still prefer a different approach.
>
> You probably want to use BIT() for all fields which are
> contiguous. Doing something different then marks the other fields are
> somehow special and need treating with care.

Thanks, Andrew. Will address in the next version.

>
> > > > +     #define TX_BD_FLAGS_IP_CKSUM                            (1 <<=
 1)
> > > > +     #define TX_BD_FLAGS_NO_CRC                              (1 <<=
 2)
> > > > +     #define TX_BD_FLAGS_STAMP                               (1 <<=
 3)
> > > > +     #define TX_BD_FLAGS_T_IP_CHKSUM                         (1 <<=
 4)
> > > > +     #define TX_BD_FLAGS_LSO                                 (1 <<=
 5)
> > > > +     #define TX_BD_FLAGS_IPID_FMT                            (1 <<=
 6)
> > > > +     #define TX_BD_FLAGS_T_IPID                              (1 <<=
 7)
> > > > +     #define TX_BD_HSIZE                                     (0xff=
 << 16)
> > > > +      #define TX_BD_HSIZE_SHIFT                               16
> > >
> > > I'm quite suprised checkpatch does not complain, but the above
> > > indentation is IMHO quite messy.
>
> > > please move the macro definition before the struct and avoid mixing
> > > whitespaces and tabs.
> >
> > Since these are hardware-defined structs, we kept the #defines with
> > their members to make the mapping clear.
> > Any concerns with this?

Ack. Will fix it in the next spin.

>
> The names should make it clear. The structure member can be called
> tx_bd_flags, and the bits are TX_BD_FLAGS_IP_CKSUM etc.
>
> > > > +static struct sk_buff *bnge_copy_skb(struct bnge_napi *bnapi, u8 *=
data,
> > > > +                                  unsigned int len, dma_addr_t map=
ping)
> > > > +{
> > > > +     struct bnge_net *bn =3D bnapi->bn;
> > > > +     struct bnge_dev *bd =3D bn->bd;
> > > > +     struct sk_buff *skb;
> > > > +
> > > > +     skb =3D napi_alloc_skb(&bnapi->napi, len);
> > > > +     if (!skb)
> > > > +             return NULL;
> > > > +
> > > > +     dma_sync_single_for_cpu(bd->dev, mapping, bn->rx_copybreak,
> > > > +                             bn->rx_dir);
> > > > +
> > > > +     memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
> > > > +            len + NET_IP_ALIGN);
> > >
> > > This works under the assumption that len <=3D  bn->rx_copybreak; why
> > > syncing the whole 'rx_copybreak' instead of 'len' ?
> >
> > Good point. syncing the actual packet length is more precise and
> > avoids unnecessary cache maintenance.
> > Let us test this on our hardware and get back to you.
>
> When i did this for the FEC, i got a nice performance boost.

Thanks for sharing the results, will fix it in next spin.

Thanks,
Bhargava Marreddy

>
>      Andrew

--00000000000075e42306488418dd
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDARWi78VXvwphJPZimNUZoYJ72AmuBpWwJsSzUqDlAkjAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTYxNjQ3MjNaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAb2o4l
pThhW22a8XQmsJwCuTVQU1Y2PkDdnolJLOXqD+/NkdnkYl29jcmdEu9SZC5ldsRtHgcFWLtTZgtr
sXTlNXFy63fo116NS3pmaac8o/cKweiakqnjw0lEtuqCKbWEKJjfvBMJpSrSRldhV0kQneoi+I8v
a9MhpAIkS89mQAJHNSZ6ahwr869HC4XzllTJKhQ5KOG2s4Dw+Q/R0Xj8s+sgN//V45Z46NwL0quE
x/hWj8ns5E3Rpnrz+63GNdB4t9TrgKfahqluL+WrideMuKr/R74WKHtpXgG0lEtxRJcSnoXUbABK
ifyrsTnthT32JYnwVbjlN86OXTI6yIw6
--00000000000075e42306488418dd--

