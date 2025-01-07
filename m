Return-Path: <netdev+bounces-156029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E97A04B33
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F5E1887049
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69541155300;
	Tue,  7 Jan 2025 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoCOuEPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A26A95C
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282816; cv=none; b=HdD9KfUvjdsx9tSiBgfOoPB00c1hrpD24AILNkQuDAYJBWh81Wo7YMkx9bmlaDvU/ZKJHCFWeMzehuU11RRdRZtCvtbeYYTE4H/f19xYyhmcpysqbpVdXvT14y4JVfVUWL4WBraIuEN/PRzP0pv9+QPKK38gCus3K3OJfHBlAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282816; c=relaxed/simple;
	bh=twM8qqh8ph9f3CqzD80Pz4Bv+uF7sT+VMmxzx6FL1rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK5LHU8C90UGAN5uugZL5X+Evrpb0fAUf8qsMeX/hhXD3E+Hm2oPRrUN+kDP0eJPvbFoK7PKi4Aoupq86wkk2N2zGhuQz9+2ZfhBWVPcuWw97bzubLOuDJ7U1UKoNZJeaWujXAQQ9RIefOqdFUZ9T1lC6kvJrwqySzb4ToLM5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoCOuEPJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso31646137a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736282813; x=1736887613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHD2ZkgNmmecwEumN8Mr4H0cuTGt/2anHKyAmS5nhdE=;
        b=EoCOuEPJxhepsgZKWy/LMCk2y2XiHSSJHJ9xOtEVFk2cR9yku/SKLG3b2uqALlOB8f
         34jQGWGHPyolfQBJjqZcMxuR3ODFdwvuXbkMs2N7U1Xv2pZsCzDFBuXTSdLfZqY3Sdtc
         QPlqAytnQjrH5p2R90zlqkqVzzi4QiHmP5u2mPRVCJ6ZEI7z+NhpA5yDI3DkxGtVPs35
         5LNVvG7ppfZ9ZNx7RRLYC8y1wbTBmS+rrSKHi9NJp7Lbp/lIHW3UFL80AGAHmAkthvbl
         PFpHBCgsjGGuAO2mRyvMyIH1Ku0da0o9iWeWqSny3Fl22f8S0Sd3B3ue80yoO+enUB8+
         QjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282813; x=1736887613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHD2ZkgNmmecwEumN8Mr4H0cuTGt/2anHKyAmS5nhdE=;
        b=kayOjOU6X2Vx5ID9xnTnLA2ilBLnDuKwTxwNgR5XJHLMNPbExwMkQh7fkFMrkY90nG
         4XrbIgGQQNdQ9e6w1sL/r5WJWNHN4gmcZ1xHMx+u74H0Hu09qnJQtaCBzzwdeQdYozH6
         smpdG59HvmwVB0Jcno7CuzzGOUT6IhAwUn9sAmuQrlIdOfUTzkJoIy39guXhfz2W8gAE
         AZpx4dZDOIs0FxLyjuUwLQ9c6s7M2Mdu6M7+1ZBhZBdUdUWyagQsHIE86j8Vc35wx5Ta
         TU0hMNpACgLh/Dq0xuykl/sWGw+gBV7LPC8U8ANq4vsY85XUreIOyzFiC9qmho7jgSKh
         tqYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCXDDZnWuyJuknd/hDCAolhNROC2YkfLtE5ei2b/Ukl5Uwuin5v0sYThStEd/iPPnFNe/iVpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydwjIAOMudNX6f2GlgSEDoh2L7Q6L/LJo5iLlHEYFgBxwJjd2U
	12f5HS/9M5FLDFerpXrrymvjarBa9sjxHokopm5W6InOHUMAnK8RozuKS4vmS9PYm7n3U0oWfFw
	ZfHORQoQPz0M7ezxUE4g8WkdUVBx03WhX5SszlZWX/Z1AdnuX/OiO
X-Gm-Gg: ASbGncvUfrh8HE98k4Sn50RKgpNIkPqddcNI+Gd2nCa/dHe8ULj1swtR4br9XO3eObS
	EVbMRZT1sb9mgftA1NEElMS4lcVnMW0HCL8Wg/Q==
X-Google-Smtp-Source: AGHT+IEs9aVhbcWUpfIkQDUgYG1L71snr/Xl0jUo5Kqfg+LKX0C57t04oZ2u84YZWQgqsOLXM734KEYowFvfUo/jURY=
X-Received: by 2002:a05:6402:320b:b0:5d0:cfdd:2ac1 with SMTP id
 4fb4d7f45d1cf-5d972dfcbcfmr268160a12.6.1736282812724; Tue, 07 Jan 2025
 12:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107173838.1130187-1-edumazet@google.com> <20250107121148.7054518d@kernel.org>
 <CANn89iJkxX1d-SKN6WVJST=5X7KqXdJ+OKcCVDEFCedJ7ArSig@mail.gmail.com>
In-Reply-To: <CANn89iJkxX1d-SKN6WVJST=5X7KqXdJ+OKcCVDEFCedJ7ArSig@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Jan 2025 21:46:41 +0100
X-Gm-Features: AbW1kvZowGTW2XsyS-P1mH-3I3hj8vsL3y9s9hUxQp70UYWLXnWntvkcbs0DXvM
Message-ID: <CANn89i+dN11K7EushTwsT0tchEytceTWHqiB23KqrYvfauRjWg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: reduce RTNL pressure in unregister_netdevice()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Jan 7, 2025 at 9:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue,  7 Jan 2025 17:38:34 +0000 Eric Dumazet wrote:
> > > One major source of RTNL contention resides in unregister_netdevice()
> > >
> > > Due to RCU protection of various network structures, and
> > > unregister_netdevice() being a synchronous function,
> > > it is calling potentially slow functions while holding RTNL.
> > >
> > > I think we can release RTNL in two points, so that three
> > > slow functions are called while RTNL can be used
> > > by other threads.
> >
> > I think we'll need:
> >
> > diff --git a/net/devlink/port.c b/net/devlink/port.c
> > index 939081a0e615..cdfa22453a55 100644
> > --- a/net/devlink/port.c
> > +++ b/net/devlink/port.c
> > @@ -1311,6 +1311,7 @@ int devlink_port_netdevice_event(struct notifier_=
block *nb,
> >                 __devlink_port_type_set(devlink_port, devlink_port->typ=
e,
> >                                         netdev);
> >                 break;
> > +       case NETDEV_UNREGISTERING:
>
> Not sure I follow ?
>
> >         case NETDEV_UNREGISTER:
> >                 if (devlink_net(devlink) !=3D dev_net(netdev))
> >                         return NOTIFY_OK;
> >
> >
> > There is no other way to speed things up? Use RT prio for the work?
> > Maybe WRITE_ONCE() a special handler into backlog.poll, and schedule it=
?
> >
> > I'm not gonna stand in your way but in general re-taking caller locks
> > in a callee is a bit ugly :(
>
> We might restrict this stuff to cleanup_net() caller only, we know the
> netns are disappearing
> and that no other thread can mess with them.

ie something like:

diff --git a/net/core/dev.c b/net/core/dev.c
index 9e93b13b9a76bd256d93d05a13d21dca883d6ab8..a555e82adbeda90672c72700e92=
35a5d271be8fd
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11414,6 +11414,23 @@ struct net_device *alloc_netdev_dummy(int sizeof_p=
riv)
 }
 EXPORT_SYMBOL_GPL(alloc_netdev_dummy);

+static bool from_cleanup_net(void)
+{
+       return current =3D=3D cleanup_net_task;
+}
+
+static void rtnl_drop_if_cleanup(void)
+{
+       if (from_cleanup_net())
+               __rtnl_unlock();
+}
+
+static void rtnl_acquire_if_cleanup(void)
+{
+       if (from_cleanup_net())
+               rtnl_lock();
+}
+
 /**
  *     synchronize_net -  Synchronize with packet receive processing
  *
@@ -11423,7 +11440,7 @@ EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
 void synchronize_net(void)
 {
        might_sleep();
-       if (current =3D=3D cleanup_net_task || rtnl_is_locked())
+       if (from_cleanup_net() || rtnl_is_locked())
                synchronize_rcu_expedited();
        else
                synchronize_rcu();
@@ -11527,10 +11544,10 @@ void unregister_netdevice_many_notify(struct
list_head *head,
                WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
        }

-       __rtnl_unlock();
+       rtnl_drop_if_cleanup();
        flush_all_backlogs();
        synchronize_net();
-       rtnl_lock();
+       rnl_acquire_if_cleanup();

        list_for_each_entry(dev, head, unreg_list) {
                struct sk_buff *skb =3D NULL;
@@ -11590,9 +11607,9 @@ void unregister_netdevice_many_notify(struct
list_head *head,
 #endif
        }

-       __rtnl_unlock();
+       rtnl_drop_if_cleanup();
        synchronize_net();
-       rtnl_lock();
+       rnl_acquire_if_cleanup();

        list_for_each_entry(dev, head, unreg_list) {
                netdev_put(dev, &dev->dev_registered_tracker);

