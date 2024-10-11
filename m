Return-Path: <netdev+bounces-134635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09199A9C1
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC54283845
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35919E993;
	Fri, 11 Oct 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFyZQx3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B5196DB1
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667202; cv=none; b=DuA9TPF0kjmEWgmz/jbDkVxS7rqQlORTFo6U4NMcQqCazfbK6BLT36PFQocmzvE9iRmmI+WmGvwjWdDspVcpG/6hD3/SAagysr21L3LK7+66PE3GdXAAkOJqI3o1oio4eBM1jhHo6pjm0AxuZadsLBbJw5eJ7REijrh/cyEcRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667202; c=relaxed/simple;
	bh=eEjFXXOTFhOXOUA4KJuAP5STFCvfIvLh1grp/K9t1ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JfpYZO61EJBLBKJl3hYk10lG/GJjb9RLiroMBeMdmdu5jKR3IBqjYK8hlhQ4HhwtsB0BjxanRQHDAsNCg/wpF3V32J04JQsMUM7r5Z2l6ZHIIARWotTqJaW7BRPdg+ov5AsmnDCuifxq11xWQP2V2MVPW7emyeT40uHsTd31EkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFyZQx3r; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so2021065a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728667198; x=1729271998; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ber8CyTD+AvHRA3Kj4Tfun9HQHpsL1p45md6WLgTTYk=;
        b=bFyZQx3r4NZgCeSDh0e4JxArMkTwBhvFoPIlYvn78MVfDlMpVS4HhsNAAu/qB3+vLG
         lsbCvCQ0ppL5d/O4xf6CDhakDGPmoK0Uqet2VSR3MKXdZGHZL2OIxQXH5GNA/x/vd/+b
         kINbOc+t0QcSYUMTwHr3fJrxW+ys3oRawQs9l7BMDvPNJx2cpZ+V6u80sFeCJt3qyZMo
         AQ6YI/ako8KC/ufWHoSJFbdqMINw+wbI5uIJgdkY28F3W6Yj+K/Pczoc9yNghMxRZSaG
         GW9302TFHoxsuMU2SxQteOqfRWRcJF8+47b9yvQiVQ4YmzOVUc+j7TDpJ7tZoAeFW+Ij
         Gy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728667198; x=1729271998;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ber8CyTD+AvHRA3Kj4Tfun9HQHpsL1p45md6WLgTTYk=;
        b=r1YQnhYlshgM8Go2Nelprvj/vLhwkEKfSoPzV66QU/W0V5iV67IUBpFACCUYOOTX4V
         OcgfSOOUM2PyeEfx7AqvDue5+8rRj/pu7W7aesZutb9CUD2+cJne5vavyWYKoDrdIFRF
         gK6HP7jTheQ4+TtEeoRghahRvuXKZokkApYIlOdBKZNs+fc7I3PuInrukr65z5HnIll6
         OFF7mSp1pDrKwDx95UvrWs4fHhFHtJzD1L7E2tIYNgKSx+uUkeaJhEhf2WVDs0EXvPrk
         acOxszGVlRrPT+E2bocWfdvocXPBwiXSLycVLGLxDzMX/wp2Qput3s75y8VFRU/ROf3H
         9XcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVknw/dnBgy4BT3SGKx5ZBFozOjnDA4uF/M0RfXmKOVD15lm5FheVmqGo2KWEkFw9YfH9WzzDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrBLkYt9Na2qDOzkb8eomkOREIj4a9rEGDyfoQu7x8867Stwu
	oMgkbO8RQDNcXjzCDYYWmUy8jwb5a7DBc9Zk/16raw3ZMA8hVODNLyw8g2sTl9zxTgCeIj1SyN4
	yx9HU60tC8PqlBQ+HlRAfxAxDFhORAo0Plpsh
X-Google-Smtp-Source: AGHT+IFILnj5xftdB94W2u0QB4o+UcJOggyGjGi1UWHNal0GChKR5Yk0kRd5h6nEtqeSi59G2ZS1k+3nXG+D5jBccNo=
X-Received: by 2002:a05:6402:50d3:b0:5c9:3818:35e8 with SMTP id
 4fb4d7f45d1cf-5c948d4b42emr2511779a12.28.1728667198184; Fri, 11 Oct 2024
 10:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-7-jdamato@fastly.com>
 <CANn89iJ1=xA9WGhXAMcCAeacE3pYgqiWjcBdxiWjGPACP-5n_g@mail.gmail.com>
 <20241010081923.7714b268@kernel.org> <CANn89iK_iDY_nTCgqYUk7D_R8k_qu2qQrs2rUAxxAu_ufrzBnw@mail.gmail.com>
 <ZwgDh3O0_95uGAgd@LQ3V64L9R2>
In-Reply-To: <ZwgDh3O0_95uGAgd@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 19:19:47 +0200
Message-ID: <CANn89iL65LPmJbiHVt10JvKXSVMhk-SsTN5xdaZ7MjgXXT4f9w@mail.gmail.com>
Subject: Re: [net-next v5 6/9] netdev-genl: Support setting per-NAPI config values
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	skhawaja@google.com, sdf@fomichev.me, bjorn@rivosinc.com, 
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com, 
	willemdebruijn.kernel@gmail.com, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 6:40=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Thu, Oct 10, 2024 at 05:30:26PM +0200, Eric Dumazet wrote:
> > On Thu, Oct 10, 2024 at 5:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 10 Oct 2024 06:24:54 +0200 Eric Dumazet wrote:
> > > > > +static const struct netlink_range_validation netdev_a_napi_defer=
_hard_irqs_range =3D {
> > > > > +       .max    =3D 2147483647ULL,
> > > >
> > > > Would (u64)INT_MAX  work ?
> > >
> > > I sent a codegen change for this. The codegen is a bit of a mess.
> > >
> > > > > +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_inf=
o *info)
> > > > > +{
> > > > > +       struct napi_struct *napi;
> > > > > +       unsigned int napi_id;
> > > > > +       int err;
> > > > > +
> > > > > +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       napi_id =3D nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> > > > > +
> > > > > +       rtnl_lock();
> > > >
> > > > Hmm.... please see my patch there :
> > > >
> > > >  https://patchwork.kernel.org/project/netdevbpf/patch/2024100923272=
8.107604-2-edumazet@google.com/
> > > >
> > > > Lets not add another rtnl_lock() :/
> > >
> > > It's not as easy since NAPIs can come and go at driver's whim.
> > > I'm quietly hoping we can convert all netdev-nl NAPI accesses
> > > to use the netdev->lock protection I strong-armed Paolo into
> > > adding in his shaper series. But perhaps we can do that after
> > > this series? NAPI GET already takes RTNL lock.
> >
> >
> > napi_by_id() is protected by rcu and its own spinlock ( napi_hash_lock =
)
> > I do not see why rtnl is needed.
> > This will also be a big issue with per netns-RTNL anyway.
>
> I deeply appreciate and respect both of your thoughts on this; I
> will hold off on sending a v6 until a decision is made on this
> particular issue.
>

I do not want to block your series.

Whatever is needed later, I can handle.

