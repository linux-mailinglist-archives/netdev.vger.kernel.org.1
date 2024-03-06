Return-Path: <netdev+bounces-77941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A44873824
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EAC1C20BF4
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1D6131E27;
	Wed,  6 Mar 2024 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLTZrmP3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C599131735
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733126; cv=none; b=AfjJpbl8tg9DM1aU48y2UHh8j8zMXbUkqstoozdv3G69gI5hAUUklLJ6FmcAfvtCUzN+ZJzlTXWso9ZppPVcdRfxMyGS137lxLEkEK0NPIY4nIgW0SJdtZMEVcC6S/dEb+WGksZYXvrLEQwR9bylTFuLE6R6/F+q4fctVmTtN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733126; c=relaxed/simple;
	bh=Pxuf4kWuWzCb907EKPmxfs1oR1d6VL2ka9aNysDX23s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7hT2/Rbk+LNPW/0Dy7+3Lcn7359Ox1x1uqsN6Sncla0sp0QaqNnc8Y7EMb1KdWCWIpCH31u1otdkxBPFLihh1s1P7PxE1+Zsawo4lYMUWDOJWNtSeNekp/PGI8D5zgNk2QHhKLlRqzyKhasV8gXDdeRHUnQOu1y+whHp42lI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLTZrmP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709733123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7Yd3qo5csWtOP+JW348rWjfTnDZ/UW2hhiQwJnJC6s=;
	b=PLTZrmP3e48J++7hQkUF7hlt/GvLr5Y6zJkDGkce+YBTzl+4BjieKOp+y515qGOk/mTygO
	tHHQm5PcvjPtiqAurkKE5ciJhGp9Hi4Gl1xAIiR/oraMbw/b13I0WbUyNxXXxJAH8bYfsm
	VOODy8/+TDpt8YQ5YQW/x+zIkjHbMQU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Ao07IsZzPpuAzqW8w17ZGA-1; Wed, 06 Mar 2024 08:52:00 -0500
X-MC-Unique: Ao07IsZzPpuAzqW8w17ZGA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d2a43ca538so4678031fa.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 05:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709733119; x=1710337919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7Yd3qo5csWtOP+JW348rWjfTnDZ/UW2hhiQwJnJC6s=;
        b=F2WqDikM+9yyyQPV1/areWO79uBCkRFXirE7eB6cWhqGybyGTQCuTH5K2VvIeymdI5
         RYmNsljsCP34yiEEwPnOROu3lXWwk+mniHm3/Qp6DNAuddTSN0ArfTaILk7Hy/GVnz4c
         dMlIwSNZY1i8SSsV9h8f8Hc5bsdJU+5Z9hgyRTJrCABFD4z3NM0GGbK9lavrYDmguKoR
         v2C8dbQDLI2s55pYXptEpi0cGxv9oSqdVlO+iVj355vjchjCvXDe5p9FvcWbJLAWhUMZ
         oJk1vEODCo/s72hEuiIqiUL4PcWehwKD+Er3pswOmKE9BvDhJJ7QP/x04PONuecdWcEZ
         tQMg==
X-Forwarded-Encrypted: i=1; AJvYcCUnwTb3nYhVyEo3euR8qwioTBOshtE5BefFYqSAGaiYqQEeHBcmFg1h/fYlxg9fbCeYrlOmxfOaG9DoLZXrzKSumQ4p13QW
X-Gm-Message-State: AOJu0YyBosyZyD8pJS7q6OqxpO0cRN72g+OK1lpHvBi4x02MSNGc7bHp
	jG+39JJUYbVBej2LIfEqPx5/krhu696zPmJhfLmmzda5j6pJHmtZVR2kzMMRfQLS8nipMCCbd7+
	oJHCAZC4LAWaDw9OzFwPr+UP7ZVFjn/yQvAFB/DouRjLl77RFRuorjBLx8DY/rZkh2b8r9mA0wh
	2m0ZEDelZQBKl1o7vzo4F4sg4+L0RL
X-Received: by 2002:a2e:9942:0:b0:2d2:c7f5:fae2 with SMTP id r2-20020a2e9942000000b002d2c7f5fae2mr1781863ljj.26.1709733118771;
        Wed, 06 Mar 2024 05:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0kxlPv7MKqvikorSw89RvO/D/lU1MbiJt2PjJ3n+6LW2N2RMRt0xyRaqK0m7jiit7OlWGsi0pF9XihXhWeL0=
X-Received: by 2002:a2e:9942:0:b0:2d2:c7f5:fae2 with SMTP id
 r2-20020a2e9942000000b002d2c7f5fae2mr1781850ljj.26.1709733118291; Wed, 06 Mar
 2024 05:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228163840.6667-1-pchelkin@ispras.ru> <CAK-6q+i4v94uF9BEeZ0zNWtutOn35pzstiY7jMBetCJ0PHOD3w@mail.gmail.com>
 <95eecd55-378c-4a55-96d8-fa74ec59e76a-pchelkin@ispras.ru>
In-Reply-To: <95eecd55-378c-4a55-96d8-fa74ec59e76a-pchelkin@ispras.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 6 Mar 2024 08:51:47 -0500
Message-ID: <CAK-6q+gwfVdVtezj+v982KQH+oUg=4F_-27Fczq-K5iVuY3MSA@mail.gmail.com>
Subject: Re: Re: [PATCH wpan] mac802154: fix llsec key resources release in mac802154_llsec_key_del
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 4, 2024 at 2:25=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru> =
wrote:
>
> Hello Alexander,
>
> Thanks for review!
>
> On 24/03/03 06:19PM, Alexander Aring wrote:
> > Hi,
> >
> > On Wed, Feb 28, 2024 at 11:44=E2=80=AFAM Fedor Pchelkin <pchelkin@ispra=
s.ru> wrote:
> > >
> > > mac802154_llsec_key_del() can free resources of a key directly withou=
t
> > > following the RCU rules for waiting before the end of a grace period.=
 This
> > > may lead to use-after-free in case llsec_lookup_key() is traversing t=
he
> > > list of keys in parallel with a key deletion:
> > >
> > > refcount_t: addition on 0; use-after-free.
> > > WARNING: CPU: 4 PID: 16000 at lib/refcount.c:25 refcount_warn_saturat=
e+0x162/0x2a0
> > > Modules linked in:
> > > CPU: 4 PID: 16000 Comm: wpan-ping Not tainted 6.7.0 #19
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-de=
bian-1.16.2-1 04/01/2014
> > > RIP: 0010:refcount_warn_saturate+0x162/0x2a0
> > > Call Trace:
> > >  <TASK>
> > >  llsec_lookup_key.isra.0+0x890/0x9e0
> > >  mac802154_llsec_encrypt+0x30c/0x9c0
> > >  ieee802154_subif_start_xmit+0x24/0x1e0
> > >  dev_hard_start_xmit+0x13e/0x690
> > >  sch_direct_xmit+0x2ae/0xbc0
> > >  __dev_queue_xmit+0x11dd/0x3c20
> > >  dgram_sendmsg+0x90b/0xd60
> > >  __sys_sendto+0x466/0x4c0
> > >  __x64_sys_sendto+0xe0/0x1c0
> > >  do_syscall_64+0x45/0xf0
> > >  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > >
> > > Also, ieee802154_llsec_key_entry structures are not freed by
> > > mac802154_llsec_key_del():
> > >
> > > unreferenced object 0xffff8880613b6980 (size 64):
> > >   comm "iwpan", pid 2176, jiffies 4294761134 (age 60.475s)
> > >   hex dump (first 32 bytes):
> > >     78 0d 8f 18 80 88 ff ff 22 01 00 00 00 00 ad de  x.......".......
> > >     00 00 00 00 00 00 00 00 03 00 cd ab 00 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff81dcfa62>] __kmem_cache_alloc_node+0x1e2/0x2d0
> > >     [<ffffffff81c43865>] kmalloc_trace+0x25/0xc0
> > >     [<ffffffff88968b09>] mac802154_llsec_key_add+0xac9/0xcf0
> > >     [<ffffffff8896e41a>] ieee802154_add_llsec_key+0x5a/0x80
> > >     [<ffffffff8892adc6>] nl802154_add_llsec_key+0x426/0x5b0
> > >     [<ffffffff86ff293e>] genl_family_rcv_msg_doit+0x1fe/0x2f0
> > >     [<ffffffff86ff46d1>] genl_rcv_msg+0x531/0x7d0
> > >     [<ffffffff86fee7a9>] netlink_rcv_skb+0x169/0x440
> > >     [<ffffffff86ff1d88>] genl_rcv+0x28/0x40
> > >     [<ffffffff86fec15c>] netlink_unicast+0x53c/0x820
> > >     [<ffffffff86fecd8b>] netlink_sendmsg+0x93b/0xe60
> > >     [<ffffffff86b91b35>] ____sys_sendmsg+0xac5/0xca0
> > >     [<ffffffff86b9c3dd>] ___sys_sendmsg+0x11d/0x1c0
> > >     [<ffffffff86b9c65a>] __sys_sendmsg+0xfa/0x1d0
> > >     [<ffffffff88eadbf5>] do_syscall_64+0x45/0xf0
> > >     [<ffffffff890000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > >
> > > Handle the proper resource release in the RCU callback function
> > > mac802154_llsec_key_del_rcu().
> > >
> > > Note that if llsec_lookup_key() finds a key, it gets a refcount via
> > > llsec_key_get() and locally copies key id from key_entry (which is a
> > > list element). So it's safe to call llsec_key_put() and free the list
> > > entry after the RCU grace period elapses.
> > >
> > > Found by Linux Verification Center (linuxtesting.org).
> > >
> > > Fixes: 5d637d5aabd8 ("mac802154: add llsec structures and mutators")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > > ---
> > > Should the patch be targeted to "net" tree directly?
> > >
> > >  include/net/cfg802154.h |  1 +
> > >  net/mac802154/llsec.c   | 18 +++++++++++++-----
> > >  2 files changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index cd95711b12b8..76d2cd2e2b30 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -401,6 +401,7 @@ struct ieee802154_llsec_key {
> > >
> > >  struct ieee802154_llsec_key_entry {
> > >         struct list_head list;
> > > +       struct rcu_head rcu;
> > >
> > >         struct ieee802154_llsec_key_id id;
> > >         struct ieee802154_llsec_key *key;
> > > diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> > > index 8d2eabc71bbe..f13b07ebfb98 100644
> > > --- a/net/mac802154/llsec.c
> > > +++ b/net/mac802154/llsec.c
> > > @@ -265,19 +265,27 @@ int mac802154_llsec_key_add(struct mac802154_ll=
sec *sec,
> > >         return -ENOMEM;
> > >  }
> > >
> > > +static void mac802154_llsec_key_del_rcu(struct rcu_head *rcu)
> > > +{
> > > +       struct ieee802154_llsec_key_entry *pos;
> > > +       struct mac802154_llsec_key *mkey;
> > > +
> > > +       pos =3D container_of(rcu, struct ieee802154_llsec_key_entry, =
rcu);
> > > +       mkey =3D container_of(pos->key, struct mac802154_llsec_key, k=
ey);
> > > +
> > > +       llsec_key_put(mkey);
> > > +       kfree_sensitive(pos);
> >
> > I don't think this kfree is right, "struct ieee802154_llsec_key_entry"
> > is declared as "non pointer" in "struct mac802154_llsec_key". The
> > memory that is part of "struct ieee802154_llsec_key_entry" should be
> > freed when llsec_key_put(), llsec_key_release() hits.
> >
> > Or is there something I am missing here?
>
> `struct ieee802154_llsec_key_entry` is not included into any other
> struct. It is a standalone entity describing an entry in the
> `ieee802154_llsec_table.keys` list.
>
> Maybe you are confusing it with `struct ieee802154_llsec_key`?
>

Yes, I was confused about "ieee802154_llsec_key_entry" vs
"ieee802154_llsec_key".

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex


