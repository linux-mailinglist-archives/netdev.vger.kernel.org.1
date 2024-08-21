Return-Path: <netdev+bounces-120577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25493959CAD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E141F21B87
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FA01662E9;
	Wed, 21 Aug 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADA8eyfK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A41E4A6;
	Wed, 21 Aug 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245349; cv=none; b=W7XtysCVlOfSVNbv2bIK4z8kGvV4dJNJMhB9u8VAgu1ztVZL3IRTwx9VLwikAkFOMOHSHnhl7/SiVwBq/tGwyYuHyUDGKb1eHkkB4mEzszbT2PbcDMVhjeRM6SPO8PdwFI1fTnlFo01bQi4MotyXgIUPtBK/ZVPSaNW838Ss2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245349; c=relaxed/simple;
	bh=oCNseJu1oVOwi0Sw13GWojhDjnP+oaE40buNaPrwiIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pw1hGtuwQNN+a6frm15P+F6R2LaVDfkFe1ZhQzOqjr6QzQYieZUGd7zCqpEnCUZuqPuJV3sVYeLikvAms20U6UDvs69cLoCl/qwNdm1E4YaeLaYWNA2DW97hrpROEGKhtXfjd/MI72A3EJ4cmQkW6HPEunVoAVq2MnWPFH4K19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADA8eyfK; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e16518785c2so1877471276.1;
        Wed, 21 Aug 2024 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724245347; x=1724850147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8JMlEkkGkcT8DbSa/JgcLoqosvKmqa7Vif2q4dbzDc=;
        b=ADA8eyfKx3WzINmAopZmXXgi1RieJon72iVuplfq8V+90FztvgqRjb3xEYjAUZkRLT
         CAV76pmOxMoq6ljz82UQvWfo5J8xpvtw71UYzevFviq8LEaasY8cHdZxhCZ23M3wH1TB
         NEZHN2C5o8JDcrYpzbdhAnyzJmp/XWINbpVHwonHRUMeKwG6zpk4vbZk2fWmSaWZt6eb
         CdO14v5TJx5q3cNxdhCziTmwkaWEimms888n5QhWn5ga/JhyuhwpdYdv0KgYR7ylmcBv
         x5AW4SFIPDCA0fg4EmlxstpnQv9w/C9bwMfO4KP0qS8eSxgg+81McCGuP7RaQj+Sj6v1
         O4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724245347; x=1724850147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8JMlEkkGkcT8DbSa/JgcLoqosvKmqa7Vif2q4dbzDc=;
        b=N1U3YL49DzlPqejnXDa8rvOeUiI2T7hhuGQKEl9loFqJjbmBuzNnOSYs7qckbv16yq
         k9442+zuY36CXzgRufRaUnXYw39FB/gmH4YKd6dVOSGCzLAzppkbwBH8pazPbM1AFKSA
         G8rKtjHWHMdgxpGq3oCmk3aAoBBbNBhH3jTBqzQo9KfzGXBOXD93uhmQqPfPcfiyeglg
         IOn7dDcaWAnbQVPcTYVYSZrfZzjUQwxlp6OsLaifJY/jCgj7TL1uFR0do+iDKPORUnX+
         lVHBJ6wXuJGqCc1xsyy+Wie2WgA8wkgat3QhzqcEayTbFJLq3lY3YTI4RexSTMkj1P4d
         nLig==
X-Forwarded-Encrypted: i=1; AJvYcCVhyGCXRUNbHXqrEHLnYZ1IThlm5NN+B7f/QAtm+Cc+tLSdzQSrKwZIcvmQ91cbPvWCkILkcrjc@vger.kernel.org, AJvYcCXhLuP/NyqoSoPajjh/ETBrnhKlkr+tm+diZT8kQgLof2EmOPLKjT6PV58GOYflCAf8hsoXSG+AoGVUca0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv87k3jp+StABL/2IiEXAJW7JqDkPVLTSuJowFWuwjjuCGc11g
	n27B/x/D6czNzMRcELdeyIAWFxsIb01PK60pUMUzaMdlYU/SzFpKRyKGtyAS1LY8XeSm4NY/wAE
	2t4iFECW7FdYuY8ci9isDALr7Yjk=
X-Google-Smtp-Source: AGHT+IElh1u85daxbEguq3pTKjBgv6FSvo7NBWkZhnDkxJnF2X7Kunet3ejp2sMViHkY5+S9+CpZKjFE8yvGMiU05J4=
X-Received: by 2002:a05:6902:102e:b0:e11:7db3:974c with SMTP id
 3f1490d57ef6-e166552fc37mr2882904276.35.1724245346354; Wed, 21 Aug 2024
 06:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-9-dongml2@chinatelecom.cn> <ZsSNFMyN-MivgkKU@shredder.mtl.com>
In-Reply-To: <ZsSNFMyN-MivgkKU@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Aug 2024 21:02:22 +0800
Message-ID: <CADxym3asqw=EErQdUNdLCRhF+L-rp-1LET-LCK3v1TLUE4FJEA@mail.gmail.com>
Subject: Re: [PATCH net-next 08/10] net: vxlan: add drop reasons support to vxlan_xmit_one()
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:33=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, Aug 15, 2024 at 08:43:00PM +0800, Menglong Dong wrote:
> > diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> > index da30cb4a9ed9..542f391b1273 100644
> > --- a/drivers/net/vxlan/drop.h
> > +++ b/drivers/net/vxlan/drop.h
> > @@ -14,6 +14,7 @@
> >       R(VXLAN_DROP_MAC)                       \
> >       R(VXLAN_DROP_TXINFO)                    \
> >       R(VXLAN_DROP_REMOTE)                    \
> > +     R(VXLAN_DROP_REMOTE_IP)                 \
> >       /* deliberate comment for trailing \ */
> >
> >  enum vxlan_drop_reason {
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index 22e2bf532ac3..c1bae120727f 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -2375,6 +2375,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct n=
et_device *dev,
> >       bool xnet =3D !net_eq(vxlan->net, dev_net(vxlan->dev));
> >       bool no_eth_encap;
> >       __be32 vni =3D 0;
> > +     SKB_DR(reason);
> >
> >       no_eth_encap =3D flags & VXLAN_F_GPE && skb->protocol !=3D htons(=
ETH_P_TEB);
> >       if (!skb_vlan_inet_prepare(skb, no_eth_encap))
> > @@ -2396,6 +2397,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct n=
et_device *dev,
> >                                                  default_vni, true);
> >                               return;
> >                       }
> > +                     reason =3D (u32)VXLAN_DROP_REMOTE_IP;
>
> This looks quite obscure to me. I didn't know you can add 0.0.0.0 as
> remote and I'm not sure what is the use case. Personally I wouldn't
> bother with this reason.
>

I know. I'm hesitant about this commit, as I don't find a case
for this dropping, and the remote seems can't be 0.0.0.0.
I add this reason as the code drops the packet here.

Enn...I will abandon this commit.

Thanks!
Menglong Dong

> >                       goto drop;
> >               }

