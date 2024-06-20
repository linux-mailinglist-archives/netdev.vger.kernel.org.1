Return-Path: <netdev+bounces-105422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A174911168
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A301C21626
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FF1BA094;
	Thu, 20 Jun 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YioOWn6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA61B47B0
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909398; cv=none; b=KU49/MuSCSP6K8i0Vml4ImchlHyffMY7I+xtcqhCsOrjzLGc8e5hVDWoZyAm8IDTy0jvKPuaWyz9zbiRGadrXb5Q/nOoKHgyNUJbtZMD/+g2G8bjn224LE7FfAcSsW4QwrkUBdUZKb2sHJJor/B1MC4Ickk3e93u2bL9VGGUZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909398; c=relaxed/simple;
	bh=EEOS7EIr0oF/SCh1xJIN2qBgUM7JVYx1GF+XZyGF3ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/jX0I1CSPBVbSmIYVKR7EE014wnpz3PgMP6r8viXONSYSohtlAFMxTSaUiWQQENp04DO2HkZIRgalaMUYR902cvYqphvbZLLVNsSufzU40NHDpUwtK5kEz8r1Av8yqShIcV84nlbFiJPQsjyCkHXD/6vmpho8FIzcbfbIbod/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YioOWn6U; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so1722302e87.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718909393; x=1719514193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL9JXgjXmozV00hpz2FPwQ9DP76wRXOzayxL+7uvpKU=;
        b=YioOWn6U9nZ4TX76Ae0wXINNtDpQ1+IHHfpFozSwsfOL8ziC7H+GjS5CnTae7BjWBG
         bBwhUk26MROwxg4eoLZrme09bce9Q8EsWbw6Q6alZBaYiODStCzQYLWJqsGuwnnvokBW
         skeMaPRQ3UAUNnm+jqorQQS+S4251DwqgqveY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909393; x=1719514193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL9JXgjXmozV00hpz2FPwQ9DP76wRXOzayxL+7uvpKU=;
        b=iyuuNXF3WWaHI9AJGlQA5VJkMOHZMjuISahUjMeBAsSPlvRHB8QUvclqemL/c2vYwz
         Xj+kLqLZ7lhxlv2fjPmWZoO0IaEIe/KBneicU62lii9clY1uoYrYJPU8z4tNpZB2Z0q3
         L0Qd/TQouElaARzctzMSsA5JtUNgnwfXtnuTsJleLBeRGra7z7vT1pJDtyJAl00V2+a8
         1gdhhLuuS0kkP9jDBqMAx5SezYaVPttveOYzzynmPMBVpThblC4sJgajqSyRNnjLf5Yd
         3YkLjnnXKbypt8pzcVlPrCxWlyCK6ef2n9pQEOTEMfQbrLHwg7nvu1IiUKPVJ0u/fTC9
         iCpg==
X-Forwarded-Encrypted: i=1; AJvYcCXyS7HBts62T3O3Aybat4m0RtTiS9aDvmxcup4MSZzwR3FEVG3v2bPTpa2ACF1fywyQnZmWqZKzOJFFUeyXfSxFAt3RMxgG
X-Gm-Message-State: AOJu0Yz2M1QohrcEkJhsIMQZGvtstgx1WyS6gYKTqZVQSfVXy+jFBAqv
	VS2UMyAC9XDCeN/RfMBujzQXA8qoxeV4KxTBAilrijdgnbBnxqNq6KvzhYhRfuxXQw7/ayKQjkd
	ddCa/BWFa4h08JfEwMyWDQNoef0LnM4ws0JCf
X-Google-Smtp-Source: AGHT+IGD8CE0uw6+jpXardgoPtrej/5EyEUGjkTiM+TfGEeQBlJlNeDXxliD+R62iK29WVQ9yA6w9M3LXS5jtNT5xcw=
X-Received: by 2002:a05:6512:124a:b0:52c:ab21:7c05 with SMTP id
 2adb3069b0e04-52ccaa599b7mr5856580e87.67.1718909393574; Thu, 20 Jun 2024
 11:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607230146.47222-1-kuntal.nayak@broadcom.com> <ZmmffoZAlP2wRQJL@calendula>
In-Reply-To: <ZmmffoZAlP2wRQJL@calendula>
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
Date: Thu, 20 Jun 2024 11:49:41 -0700
Message-ID: <CAA4K+2b6fAH2jKrxJGV8xHFupS6OkaJAFCtnZqjLvYXHNFA-Xw@mail.gmail.com>
Subject: Re: [PATCH v6.1] netfilter: nf_tables: use timestamp to check for set
 element timeout
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, 
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, kadlec@netfilter.org, fw@strlen.de, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

Thank you for the update and reviewing the patch. We will wait for
your patch to be applied to the LTS and then consume the latest 6.1
kernel.

------



Best regards,

Kuntal

On Wed, Jun 12, 2024 at 6:15=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> Hi,
>
> Thanks for your patch.
>
> rbtree GC chunk is not correct though. In 6.1, GC runs via workqueue,
> so the cached timestamp cannot be used in such case.
>
> Another possibility is to pull in the patch dependency to run GC
> synchronously.
>
> I am preparing a batch of updates for -stable, let me pick up on your
> patch.
>
> Thanks.
>
> On Fri, Jun 07, 2024 at 04:01:46PM -0700, Kuntal Nayak wrote:
> > diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbt=
ree.c
> > index 5bf5572e9..c4c92192c 100644
> > --- a/net/netfilter/nft_set_rbtree.c
> > +++ b/net/netfilter/nft_set_rbtree.c
> [...]
> > @@ -622,12 +624,14 @@ static void nft_rbtree_gc(struct work_struct *wor=
k)
> >       struct nft_set *set;
> >       unsigned int gc_seq;
> >       struct net *net;
> > +     u64 tstamp;
> >
> >       priv =3D container_of(work, struct nft_rbtree, gc_work.work);
> >       set  =3D nft_set_container_of(priv);
> >       net  =3D read_pnet(&set->net);
> >       nft_net =3D nft_pernet(net);
> >       gc_seq  =3D READ_ONCE(nft_net->gc_seq);
> > +     tstamp =3D nft_net_tstamp(net);
> >
> >       if (nft_set_gc_is_pending(set))
> >               goto done;
> > @@ -659,7 +663,7 @@ static void nft_rbtree_gc(struct work_struct *work)
> >                       rbe_end =3D rbe;
> >                       continue;
> >               }
> > -             if (!nft_set_elem_expired(&rbe->ext))
> > +             if (!__nft_set_elem_expired(&rbe->ext, tstamp))
> >                       continue;
> >
> >               nft_set_elem_dead(&rbe->ext);
> > --
> > 2.39.3
> >

