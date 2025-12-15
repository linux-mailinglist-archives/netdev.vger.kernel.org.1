Return-Path: <netdev+bounces-244703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D137CBD550
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF5933009802
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1415332B9B9;
	Mon, 15 Dec 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Notw49fS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737332B9A7
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793653; cv=none; b=IqQAy5ZuEtbSP833T9Ze1OraCUnFynDRlO55OhfNY+UbXtHqReSMba6C0R1a56LUhtrTUzhGBK01wK6jfniJIl2kfKyF0n2XM0g69coQIhHpMd4/QwLCC6azkSPtE5d/8/Uylj7O/LSEJ5+WzFnr2aw4A1rpwZuERV/LAG6JuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793653; c=relaxed/simple;
	bh=UCmi+uzYHpH5Jxunw7SnHu8fNYdxhf4+8auqvetdG7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtw1PtYawDnmJ4MtUhHsSTI3OLZgfasX+Ws5Agj7wWawdqRTYDHt32QrKiRcbJfQcCkMfirRHnV0IItTiBF5xjFpqLG+3//BmhuIbyqRNXlC61a7PZIZxpzvmrcd51U5S/t/pMCiNlTSNu9FBU6mDNcRk3RBmioLC261meXaFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Notw49fS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c33f74b72so28641877b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765793650; x=1766398450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2uvfnyz5Z7GW6ituDG/dQ2mDs4+Loxw5XUcvSkmoEA=;
        b=Notw49fSagsQKHUF2Hk3wPsDSF5pTIuoeG2yjiS/KmOmTAJ7uvT/a85zthjk7l0eEz
         C8ycAFtw6TvAih1bwOoYISloaie8CflI9u52JmZ4jLKA/Cv14d9KpejoLMDj2/OpWf63
         bDV2xcNnLCmrPu9JXZZWjONk6yTjV3m6HyYcGbqyIHZUiPaX79Lilm9IOXuGiNVzAmPn
         USje0VJwb9CkFkW5+ZmZTiGMyARcCJiBNGuG/wXr5teM/Sanuy2ZmLAtczVTEEqmBp/+
         D+ilLtRRV45ExEOSvjLqp1+8CaXR+2EbhZOrctSWgJ6KkjptJQAj6rGzQRB6DbXsrBK0
         t2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765793650; x=1766398450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2uvfnyz5Z7GW6ituDG/dQ2mDs4+Loxw5XUcvSkmoEA=;
        b=hZaCAImVZliLh3fkTJoEFyBXalguHGn9gWD5gCQ1Rvl7rmLJcwYUZ1+Tr4fZwbQrD0
         lPbIGRXZdPgDYLRtB6euPTsMP30kf72YRaAWjbgMc2hef3UzmLGMdhpLOfgO1ZuK/f4+
         cxsu1uR5G+Tac8nx6V6SZMsYxmSaYqH5a4JJRxxFNLGk1Tm9pb8IRFEfIb1/FtjOE0hj
         0q2R9uh55UyDD3PDT/sipbKJfmra2IgvNCa7qjkuNx14C06JuptpEYOkfrV0WbsEIVXi
         A3ZaMQSadEyM3dZz4Im3ulzC+p70dlaHAqhoV6e4o8Y8AaC17IvVT0PEmspeK9T90X0O
         Dnkg==
X-Gm-Message-State: AOJu0YzD+St4intIewL8hTzZoM5Kf58wcUbIq9jFCK6gCcBYFZdZNNWJ
	Lv7zEa2ZLOEBq2oW0rtffVjYaJdHyjvm6zjhyVqYOoiShlf/W60YccRQNsgjJbL8dirRZTtHnXL
	9qGFpoEqJG7oWwLOi+K71V2fYOBJYgFo=
X-Gm-Gg: AY/fxX7wh1aoACOyyxynmRnJ8UdjMWF+sOaPaECFmAbgEtmdv7d8u3kFloRbLzv/eF5
	jvV9t/qvEAQ4bREZVnDuQH7q7iaoMJHfuJCK8+s7qrC5Ho+sTfQTg08N3yT51CjOTHm9ajPJI2a
	QB9RkD0EyFo4kSfCi1XdzqiF6j2+nsCVelza2wiErIFGRA61UylrRgxJdHjPLwlZfcUxuIf3fuH
	VDZWOD+gpIHgUd6N70QBDwX9czaIP9kSVuEeBWl4xjTYnZm/ncBFE3Vo5BJyGyM+05hXw==
X-Google-Smtp-Source: AGHT+IHMcclZhIZfYNC57hwORsDEH1+5BI+S2vXZwkqwxV8AEmFWYXmiIrte9QEDXZk8C3eH2l96yau6CX6PqCFiy0o=
X-Received: by 2002:a05:690c:22c9:b0:788:ee99:f125 with SMTP id
 00721157ae682-78e66d4d420mr92785127b3.2.1765793649937; Mon, 15 Dec 2025
 02:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251214182449.3900190-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251214182449.3900190-1-vladimir.oltean@nxp.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 15 Dec 2025 11:13:58 +0100
X-Gm-Features: AQt7F2rm82AVMCvWLBQ_M88vNhCTDrflGhPJZJ9dJilfUZz8ku4cs_7R1D8ba_4
Message-ID: <CAOiHx==MmOsF4aeBf8zbEaHgN59Q4b=FMUEvLdJC9xXfFa5FLA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: properly keep track of conduit reference
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ma Ke <make24@iscas.ac.cn>, 
	Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 14, 2025 at 7:25=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> Problem description
> -------------------
>
> DSA has a mumbo-jumbo of reference handling of the conduit net device
> and its kobject which, sadly, is just wrong and doesn't make sense.
>
> There are two distinct problems.
>
> 1. The OF path, which uses of_find_net_device_by_node(), never releases
>    the elevated refcount on the conduit's kobject. Nominally, the OF and
>    non-OF paths should have identical code paths, and it is already
>    suspicious that dsa_dev_to_net_device() has a put_device() call which
>    is missing in dsa_port_parse_of(), but we can actually even verify
>    that an issue exists. With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, if we run
>    this command "before" and "after" applying this patch:
>
> (unbind the conduit driver for net device eno2)
> echo 0000:00:00.2 > /sys/bus/pci/drivers/fsl_enetc/unbind
>
> we see these lines in the output diff which appear only with the patch
> applied:
>
> kobject: 'eno2' (ffff002009a3a6b8): kobject_release, parent 0000000000000=
000 (delayed 1000)
> kobject: '109' (ffff0020099d59a0): kobject_release, parent 00000000000000=
00 (delayed 1000)
>
> 2. After we find the conduit interface one way (OF) or another (non-OF),
>    it can get unregistered at any time, and DSA remains with a long-lived=
,
>    but in this case stale, cpu_dp->conduit pointer. Holding the net
>    device's underlying kobject isn't actually of much help, it just
>    prevents it from being freed (but we never need that kobject
>    directly). What helps us to prevent the net device from being
>    unregistered is the parallel netdev reference mechanism (dev_hold()
>    and dev_put()).
>
> Actually we actually use that netdev tracker mechanism implicitly on
> user ports since commit 2f1e8ea726e9 ("net: dsa: link interfaces with
> the DSA master to get rid of lockdep warnings"), via netdev_upper_dev_lin=
k().
> But time still passes at DSA switch probe time between the initial
> of_find_net_device_by_node() code and the user port creation time, time
> during which the conduit could unregister itself and DSA wouldn't know
> about it.
>
> So we have to run of_find_net_device_by_node() under rtnl_lock() to
> prevent that from happening, and release the lock only with the netdev
> tracker having acquired the reference.
>
> Do we need to keep the reference until dsa_unregister_switch() /
> dsa_switch_shutdown()?
> 1: Maybe yes. A switch device will still be registered even if all user
>    ports failed to probe, see commit 86f8b1c01a0a ("net: dsa: Do not
>    make user port errors fatal"), and the cpu_dp->conduit pointers
>    remain valid.  I haven't audited all call paths to see whether they
>    will actually use the conduit in lack of any user port, but if they
>    do, it seems safer to not rely on user ports for that reference.
> 2. Definitely yes. We support changing the conduit which a user port is
>    associated to, and we can get into a situation where we've moved all
>    user ports away from a conduit, thus no longer hold any reference to
>    it via the net device tracker. But we shouldn't let it go nonetheless
>    - see the next change in relation to dsa_tree_find_first_conduit()
>    and LAG conduits which disappear.
>    We have to be prepared to return to the physical conduit, so the CPU
>    port must explicitly keep another reference to it. This is also to
>    say: the user ports and their CPU ports may not always keep a
>    reference to the same conduit net device, and both are needed.
>
> As for the conduit's kobject for the /sys/class/net/ entry, we don't
> care about it, we can release it as soon as we hold the net device
> object itself.
>
> History and blame attribution
> -----------------------------
>
> The code has been refactored so many times, it is very difficult to
> follow and properly attribute a blame, but I'll try to make a short
> history which I hope to be correct.
>
> We have two distinct probing paths:
> - one for OF, introduced in 2016 in commit 83c0afaec7b7 ("net: dsa: Add
>   new binding implementation")
> - one for non-OF, introduced in 2017 in commit 71e0bbde0d88 ("net: dsa:
>   Add support for platform data")
>
> These are both complete rewrites of the original probing paths (which
> used struct dsa_switch_driver and other weird stuff, instead of regular
> devices on their respective buses for register access, like MDIO, SPI,
> I2C etc):
> - one for OF, introduced in 2013 in commit 5e95329b701c ("dsa: add
>   device tree bindings to register DSA switches")
> - one for non-OF, introduced in 2015 in commit 91da11f870f0 ("net:
>   Distributed Switch Architecture protocol support")
>
> except for tiny bits and pieces like dsa_dev_to_net_device() which were
> seemingly carried over since the original commit, and used to this day.
>
> The point is that the original probing paths received a fix in 2015 in
> the form of commit 679fb46c5785 ("net: dsa: Add missing master netdev
> dev_put() calls"), but the fix never made it into the "new" (dsa2)
> probing paths that can still be traced to today, and the fixed probing
> path was later deleted in 2019 in commit 93e86b3bc842 ("net: dsa: Remove
> legacy probing support").
>
> That is to say, the new probing paths were never quite correct in this
> area.
>
> The existence of the legacy probing support which was deleted in 2019
> explains why dsa_dev_to_net_device() returns a conduit with elevated
> refcount (because it was supposed to be released during
> dsa_remove_dst()). After the removal of the legacy code, the only user
> of dsa_dev_to_net_device() calls dev_put(conduit) immediately after this
> function returns. This pattern makes no sense today, and can only be
> interpreted historically to understand why dev_hold() was there in the
> first place.
>
> Change details
> --------------
>
> Today we have a better netdev tracking infrastructure which we should
> use. It belongs in common code (dsa_port_parse_cpu()), which shows that
> the OF and non-OF code paths aren't actually so different.
>
> When dsa_port_parse_cpu() or any subsequent function during setup fails,
> dsa_switch_release_ports() will be called. However, dsa_port_parse_cpu()
> may fail prior to us assigning cpu_dp->conduit and bumping the reference.
> So we have to test for the conduit being NULL prior to calling
> netdev_put().
>
> There have still been so many transformations to the code since the
> blamed commits (rename master -> conduit, commit 0650bf52b31f ("net:
> dsa: be compatible with masters which unregister on shutdown")), that it
> only makes sense to fix the code using the best methods available today
> and see how it can be backported to stable later. I suspect the fix
> cannot even be backported to kernels which lack dsa_switch_shutdown(),
> and I suspect this is also maybe why the long-lived conduit reference
> didn't make it into the new DSA probing paths at the time (problems
> during shutdown).
>
> Because dsa_dev_to_net_device() has a single call site and has to be
> changed anyway, the logic was just absorbed into the non-OF
> dsa_port_parse().

Largely matches my observations.

>
> Tested on the ocelot/felix switch and on dsa_loop, both on the NXP
> LS1028A with CONFIG_DEBUG_KOBJECT_RELEASE=3Dy.

Also tested on b53, but since it neither has multiple conduits nor LAG
support (yet), the testing was very limited.

Two minor nits/comments though ...

>
> Reported-by: Ma Ke <make24@iscas.ac.cn>
> Closes: https://lore.kernel.org/netdev/20251214131204.4684-1-make24@iscas=
.ac.cn/
> Fixes: 83c0afaec7b7 ("net: dsa: Add new binding implementation")
> Fixes: 71e0bbde0d88 ("net: dsa: Add support for platform data")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  include/net/dsa.h |  1 +
>  net/dsa/dsa.c     | 53 +++++++++++++++++++++++++----------------------
>  2 files changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index cced1a866757..6b2b5ed64ea4 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -302,6 +302,7 @@ struct dsa_port {
>         struct devlink_port     devlink_port;
>         struct phylink          *pl;
>         struct phylink_config   pl_config;
> +       netdevice_tracker       conduit_tracker;
>         struct dsa_lag          *lag;
>         struct net_device       *hsr_dev;
>
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index a20efabe778f..ac7900113d2b 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -1221,6 +1221,7 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, =
struct net_device *conduit,
>                 dst->tag_ops =3D tag_ops;
>         }
>
> +       netdev_hold(conduit, &dp->conduit_tracker, GFP_KERNEL);
>         dp->conduit =3D conduit;
>         dp->type =3D DSA_PORT_TYPE_CPU;
>         dsa_port_set_tag_protocol(dp, dst->tag_ops);
> @@ -1253,14 +1254,21 @@ static int dsa_port_parse_of(struct dsa_port *dp,=
 struct device_node *dn)
>         if (ethernet) {
>                 struct net_device *conduit;
>                 const char *user_protocol;
> +               int err;
>
> +               rtnl_lock();
>                 conduit =3D of_find_net_device_by_node(ethernet);
>                 of_node_put(ethernet);
> -               if (!conduit)
> +               if (!conduit) {
> +                       rtnl_unlock();
>                         return -EPROBE_DEFER;
> +               }
>
>                 user_protocol =3D of_get_property(dn, "dsa-tag-protocol",=
 NULL);

Maybe move this to before the rtnl_lock()? Not sure if this makes a
difference (avoiding a lookup for netdev not yet there vs avoiding a
lookup under rtnl lock).

> -               return dsa_port_parse_cpu(dp, conduit, user_protocol);
> +               err =3D dsa_port_parse_cpu(dp, conduit, user_protocol);
> +               put_device(&conduit->dev);
> +               rtnl_unlock();
> +               return err;
>         }
>
>         if (link)
> @@ -1393,37 +1401,27 @@ static struct device *dev_find_class(struct devic=
e *parent, char *class)
>         return device_find_child(parent, class, dev_is_class);
>  }
>
> -static struct net_device *dsa_dev_to_net_device(struct device *dev)
> -{
> -       struct device *d;
> -
> -       d =3D dev_find_class(dev, "net");
> -       if (d !=3D NULL) {
> -               struct net_device *nd;
> -
> -               nd =3D to_net_dev(d);
> -               dev_hold(nd);
> -               put_device(d);
> -
> -               return nd;
> -       }
> -
> -       return NULL;
> -}
> -
>  static int dsa_port_parse(struct dsa_port *dp, const char *name,
>                           struct device *dev)
>  {
>         if (!strcmp(name, "cpu")) {
>                 struct net_device *conduit;
> +               struct device *d;
> +               int err;
>
> -               conduit =3D dsa_dev_to_net_device(dev);
> -               if (!conduit)
> +               rtnl_lock();
> +               d =3D dev_find_class(dev, "net");
> +               if (!d) {
> +                       rtnl_unlock();
>                         return -EPROBE_DEFER;
> +               }
>
> -               dev_put(conduit);
> +               conduit =3D to_net_dev(d);
>
> -               return dsa_port_parse_cpu(dp, conduit, NULL);
> +               err =3D dsa_port_parse_cpu(dp, conduit, NULL);
> +               put_device(d);
> +               rtnl_unlock();
> +               return err;
>         }
>
>         if (!strcmp(name, "dsa"))
> @@ -1491,6 +1489,9 @@ static void dsa_switch_release_ports(struct dsa_swi=
tch *ds)
>         struct dsa_vlan *v, *n;
>
>         dsa_switch_for_each_port_safe(dp, next, ds) {
> +               if (dsa_port_is_cpu(dp) && dp->conduit)
> +                       netdev_put(dp->conduit, &dp->conduit_tracker);
> +
>                 /* These are either entries that upper layers lost track =
of
>                  * (probably due to bugs), or installed through interface=
s
>                  * where one does not necessarily have to remove them, li=
ke
> @@ -1635,8 +1636,10 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
>         /* Disconnect from further netdevice notifiers on the conduit,
>          * since netdev_uses_dsa() will now return false.
>          */
> -       dsa_switch_for_each_cpu_port(dp, ds)
> +       dsa_switch_for_each_cpu_port(dp, ds) {
> +               netdev_put(dp->conduit, &dp->conduit_tracker);
>                 dp->conduit->dsa_ptr =3D NULL;

We should probably call netdev_put() only after clearing
dp->conduit->ds_ptr, not before.

With that addressed,

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

> +       }
>
>         rtnl_unlock();
>  out:
> --
> 2.43.0
>

