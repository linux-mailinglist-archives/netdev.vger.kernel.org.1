Return-Path: <netdev+bounces-134317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA745998BA6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263CA1C26807
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A741CCEE3;
	Thu, 10 Oct 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y28o5JOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440DC441D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574241; cv=none; b=R2dNvfoFBpZLiIZNdhXMWCS0Oczr5BbC0M7eELVw9iVQzIrRrm0EPy721xOatUc8K1m5R2KRx7F4T+q2Mlhg1xoMHvhFgKvKOp2k4x7LNnTh+qxMNHoVJTCDV9ljM5CsuM1bCqQnNUfdsiJ3t3Bg4KFNi/dm2uMYegyV8QCurGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574241; c=relaxed/simple;
	bh=5IOX7FxQwxjC3mvxRhvOYPkl5nm1OGYylQ14DBcLyLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luFuxPEgzOtNq/zVVNZTjyVVMygAZkd6pXxgXUGhXyWcG8HcSIdYcVu4g2HAN/Fvj6fHdNLr9Tj4tHNOIVKCH2X85W/p0Hcf3o3zZmcwDfN86e9IjKV5R4AZrkd7bCIujlt8nVAFahksyagY8Xu/Ivlhd7Wgok/Z6NXhckrvukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y28o5JOo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so1186636a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728574238; x=1729179038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mwCSYpgr9vQNHEWealZYY4kqQDRjCOUEotDuCTgtRk=;
        b=y28o5JOoz7Y1gS9ehOHx/vYTgnLHfW0x3mXCsxl2x3HZvTlQAs+luRtxOrcxqKZFq7
         LhcI5wOZXkCEwUEhpnquU1lSBRgiJMZvq2K3zLCpe0qZtCIavBNxW6Rn8nmlf7JPpgDN
         ixzSlx1YgxvlEASKassVQ3FsFazKFxpnAd/fN4mwMZ0I1iWlRu4bIFRtSazb7S/1IU/A
         09bvUut3HHPE9pwl79kP+AxhuvEZvI4RFqkCCaZgAUrnxLRQ8LDCDyro9Ze++aRU1bZV
         K6lYHVo3xXxE09EJv3Xp/JvbRtIhp7IY/KgVfjX8Chh6APAT/TrEfxXDbTeHxU2x0b4g
         IZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574239; x=1729179039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mwCSYpgr9vQNHEWealZYY4kqQDRjCOUEotDuCTgtRk=;
        b=FI0XBRF7MW583OErbSfDnkrEfE6MIvDqmmTj3UeYktIAoytam5a1amyqayh8/1j0Aq
         EGnqLxxfs1TL+2lgua9RXlHdSCK4Mjo2c0TWClLn7r1ksXlZ14veJdQswZLBdDWWypiH
         lsECOtADS5UcP7rkexOBx1g+sep+OMXU38r+Mwa/DmVSBfTGJD1h8xnszbLmu7/ld5zu
         zNjUIqfp2E+bPcrnG7jeNshzTOCxII1CbOJtARioVfgMtKAURZZXcLZwUwcONXsvb5rX
         EY33wIhrYjQYvMWRe9u5/rC9YquS7aTeuRDWFD4bESC0zkERI68n0rO1RIPNBOqdV/z6
         a6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUcfnv0ATu2P/qoOWxm5DYS7boL72VVEIJYtriNlSCztntzNBcSCsLp7ymQwdPTYK0MTE9iX2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBeHJOE+i9LDuNioxLa86312CPVT0Ru3MJPoTkXmYNX5IlHyzk
	RKKN3DBBGZ7SQ27dcycaiubTy4tDzXzk6Ol6u4zGImxzOFkIZCaILCM/zvrAC7TpnPBDzK+QCPI
	UBOzrvmNr2R6t5A4vj8UNiuZEzfq9zHXnN3he
X-Google-Smtp-Source: AGHT+IGH92vSYq1uHIAbNQkPnhT529UhmqKl2DvtGKmBgkIU1jYDv20vl73weke8g55yaEyRykW4FbyfRWM+Ed6yq1E=
X-Received: by 2002:a05:6402:4402:b0:5c9:1f1f:8317 with SMTP id
 4fb4d7f45d1cf-5c91f1f86ccmr5319668a12.26.1728574238326; Thu, 10 Oct 2024
 08:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-7-jdamato@fastly.com>
 <CANn89iJ1=xA9WGhXAMcCAeacE3pYgqiWjcBdxiWjGPACP-5n_g@mail.gmail.com> <20241010081923.7714b268@kernel.org>
In-Reply-To: <20241010081923.7714b268@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 17:30:26 +0200
Message-ID: <CANn89iK_iDY_nTCgqYUk7D_R8k_qu2qQrs2rUAxxAu_ufrzBnw@mail.gmail.com>
Subject: Re: [net-next v5 6/9] netdev-genl: Support setting per-NAPI config values
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	skhawaja@google.com, sdf@fomichev.me, bjorn@rivosinc.com, 
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com, 
	willemdebruijn.kernel@gmail.com, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 5:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 10 Oct 2024 06:24:54 +0200 Eric Dumazet wrote:
> > > +static const struct netlink_range_validation netdev_a_napi_defer_har=
d_irqs_range =3D {
> > > +       .max    =3D 2147483647ULL,
> >
> > Would (u64)INT_MAX  work ?
>
> I sent a codegen change for this. The codegen is a bit of a mess.
>
> > > +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *i=
nfo)
> > > +{
> > > +       struct napi_struct *napi;
> > > +       unsigned int napi_id;
> > > +       int err;
> > > +
> > > +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> > > +               return -EINVAL;
> > > +
> > > +       napi_id =3D nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> > > +
> > > +       rtnl_lock();
> >
> > Hmm.... please see my patch there :
> >
> >  https://patchwork.kernel.org/project/netdevbpf/patch/20241009232728.10=
7604-2-edumazet@google.com/
> >
> > Lets not add another rtnl_lock() :/
>
> It's not as easy since NAPIs can come and go at driver's whim.
> I'm quietly hoping we can convert all netdev-nl NAPI accesses
> to use the netdev->lock protection I strong-armed Paolo into
> adding in his shaper series. But perhaps we can do that after
> this series? NAPI GET already takes RTNL lock.


napi_by_id() is protected by rcu and its own spinlock ( napi_hash_lock )
I do not see why rtnl is needed.
This will also be a big issue with per netns-RTNL anyway.

