Return-Path: <netdev+bounces-135406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821F99DBEE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1165BB21805
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946C156F30;
	Tue, 15 Oct 2024 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVXbgdHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A72156C40;
	Tue, 15 Oct 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957342; cv=none; b=eYuIxyjZPJVK4sSbAm3PE8/MldIRpLKCxu7cRHi+Wrh4hmBLnGDpsAC3s+yeGsC3/l7avFaQDsLs567D1V0s3vYXV/CQZjlPeodcp1vKgweJf/E/8JX14n33G4nALHijbYTrsjpXSanE6PHEImfrkH0zMTaMcY/N8K64dijnF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957342; c=relaxed/simple;
	bh=DM7a1CGfKtDxyz/KOOYehbWVMXU/1JLpdOAKi0rkUe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VF7VcdIttAGBHyxZqCTy6KGrgh9iyqOrpadfZ1sPUXLjgx5ltY3HBNPvEOg5ixXJTZLqqXE3KL6WeYVVZIGzS8z0XjwfddvGFlsYlW8+ssf7IuUXSCSpd7fDqjUju6cDPtSgMuQwclnieqm2dYRnQ5LQKWd6peCDi2lA1XhzijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVXbgdHs; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e2e41bd08bso50313927b3.2;
        Mon, 14 Oct 2024 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728957339; x=1729562139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQHynSk+TGPwk975UzGx2hiDb6Ij1y1by+5kqLU/s4g=;
        b=LVXbgdHson+FqiVeTCi5QI9kxbd+ESuebXgtaVaQFsJS42ncJDZ/0lOkmIUPesTMXU
         xAw1d2QWvajNeEKOquFNCuTLOVZnv8itra2UoxbVgyADeezcOHxR41bx+jLnCPHIZj30
         NclzJ3zTLgNXJcENc6E/wui/1ift4DZQTMXArZi201RuoCWxkxe0+kv+6w9JfZapmfRB
         NO4d4uZVPpHAyBqXA6+w7Hi9cbL0crkFBLrOS2CooT1XmgVyoUBQmW0Uf2nWK1KvQqzF
         9HFs0o6j9y3oG2cTudGKKeyJrk+fC7gE0YnPVfqRNJ6r1jMl0RTHfBBRqKHHKHM8k70n
         z6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728957339; x=1729562139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQHynSk+TGPwk975UzGx2hiDb6Ij1y1by+5kqLU/s4g=;
        b=e6Z280xwnprtj/RHzjQl/4eXlnKsgBVhi+3QggJy9AUb6JwlXg5Bgd8p7BsVS15pDR
         6jjFGuYFhRds0txSRO6IOaGcxGi7BmfjmCx9ZT5ho8imcvUx7I9NogXVt60xTEVvYSYu
         njO3QG5h8Uw5/L2sgCud7YAs9FuguDTDfYxBio8qosl+HthbYT+sQw3EMsaU+OKK4B8V
         gH2PgUoLbiOuVy92t2hzb+2VD1m2cWwIWygCFGanry6uxVvdow+7Efv4v1cOEkYj6o27
         JJhNKVIzXq9RJtzXxuTcT41I/uWu+9CaUuQ5XfacnxJO7W8vrS1IuamkvCTWL5W0+9TC
         ndRA==
X-Forwarded-Encrypted: i=1; AJvYcCVIhckuI63Ix3BPFJIaujQHhAUpWJfINTk2PZ+4zUW/pZ+Qfb2dUGHhkFuINfCUsMlkP+mHq138@vger.kernel.org, AJvYcCX8prDqMuzqHzy5RXSsND7Kp7T0kiWaAakLHGjGgSbAqxzXY2uzeq/Nf5AqRPtNOdZMqG7IPUX60IQvKGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/81OAXeAUuFnir1+hkXHjw0Je/ilIlC/tBpzWyQgtc53wh86Q
	VGypTA72/FXVHC2uNbqaAw5tUUSTszhPgdXG1HGR2iJ7dwt7C3l38cPF0tTXRrNbmTsrl8tTMMs
	mLu/YKznur6faXEAyuzzfsnth8o0=
X-Google-Smtp-Source: AGHT+IEVtP/rrgxKTWfJ5xT6Asy25uJs+Mj+/cIC3Qkep5p33ak9DVjFpxxWfnBV03ktv/Pr8f6FBeITm1sslePxnKA=
X-Received: by 2002:a05:690c:9a06:b0:6e3:1903:5608 with SMTP id
 00721157ae682-6e36415dabcmr79398177b3.21.1728957339210; Mon, 14 Oct 2024
 18:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-9-dongml2@chinatelecom.cn> <ZwvAVvGFju94UmxN@shredder.mtl.com>
 <CADxym3Yjv6uDicfsog_sP9iWmr_Ay+ZsyZTrMoVdufTA2BnGOg@mail.gmail.com> <Zw09Gs26YDUniCI4@shredder.mtl.com>
In-Reply-To: <Zw09Gs26YDUniCI4@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 15 Oct 2024 09:55:39 +0800
Message-ID: <CADxym3YHMOe8VfO0sPr8rPOBL+KhT2_DBoby5HUkBDNDOZCtYw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:47=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Mon, Oct 14, 2024 at 08:35:57PM +0800, Menglong Dong wrote:
> > On Sun, Oct 13, 2024 at 8:43=E2=80=AFPM Ido Schimmel <idosch@nvidia.com=
> wrote:
> > >
> > > On Wed, Oct 09, 2024 at 10:28:26AM +0800, Menglong Dong wrote:
> > > > Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Follow=
ing
> > > > new skb drop reasons are introduced for vxlan:
> > > >
> > > > /* no remote found for xmit */
> > > > SKB_DROP_REASON_VXLAN_NO_REMOTE
> > > > /* packet without necessary metadata reached a device which is
> > > >  * in "external" mode
> > > >  */
> > > > SKB_DROP_REASON_TUNNEL_TXINFO
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > Reviewed-by: Simon Horman <horms@kernel.org>
> > >
> > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> > >
> > > The first reason might be useful for the bridge driver as well when
> > > there are no ports to forward the packet to (because of egress filter=
ing
> > > for example), but we can make it more generic if / when the bridge
> > > driver is annotated.
> >
> > You are right. As we already need a new version, so we can
> > do something for this patch too. As you said, maybe we can rename the
> > reason VXLAN_NO_REMOTE to NO_REMOTE for more generic
> > usage?
>
> "NO_REMOTE" is not really applicable to the bridge driver as there are
> no remotes, but bridge ports. I'm fine with keeping it as is for now and
> changing it later if / when needed.

Okay!

