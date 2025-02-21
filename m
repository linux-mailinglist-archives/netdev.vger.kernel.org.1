Return-Path: <netdev+bounces-168389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2CAA3EBF8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 05:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB713B0525
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 04:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDB1C8FB5;
	Fri, 21 Feb 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBLoEv+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA4F9D9
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740113296; cv=none; b=F0M6vD7CaIvsNylcwxlffzVXF1s0turCNldWJFRSJsEe0IPc6IL5PdT7PkDeeutgwy3IbjIk0agfOTAhM6DsGo35YKdMXaJ+hFHBgLzRX3kbTR80SUJKZxfjNwsGnM0du3GcDuWvp+OXvP4S7gECG7ObVyRdNhrHU4Tlxp6aWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740113296; c=relaxed/simple;
	bh=HnLLV8Xoz3cEWe7rWgP+tnI6retSkh35UsyKYABIEZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJSuUFTYxkRqzQeF0aDWjRDTpDRyxvunoJLLDZDj88bZ24C5jpDfdsfQgXEmV7qpdZqPl8JvpJ+Z5ZF0fwPTrRo0M6PbXFxwjG8oCf00AsRhtCJnIEAUJFoj0mVU/OMYm2p2hy4ig/zL4avqdhGVD3fgs4jxVxnDMgSJbUfckUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBLoEv+P; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb999658fbso220295566b.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 20:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740113293; x=1740718093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYDRvUFgg+27kzY0t4ZWGaFmsKLIqPhuM+of3lWU8Vw=;
        b=kBLoEv+P3YaXhJAik7X0ynA3pRIqYn85i/gBb70TbycPZ+I8vJMw+E8cRCKKHO4dbT
         ROj8FYgU5hJFRmsoEuwd+gzXTMzqyzIB9p2ZQKlTKN8ePkmZ2v27ygxa+W3PjqquLpE1
         MF39l9Z5DcXXInO2uY+C8oTz6Fu7u98ADna/od9j/wVFfCWRX4OcGQDCHE+bz+5YYGwX
         BnxryT3LARiAYKrVsg4wAUnXkKSZ2LpF+taIxqEvWhIPyfScTZswxJ1P4mT8MxaNd5e3
         12eCNnxVGSuljKrcn4NDirW5J1jT/3tMWhZZNUjRKUXiaSwB295KQpnSP0W4VSo12IlB
         o6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740113293; x=1740718093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYDRvUFgg+27kzY0t4ZWGaFmsKLIqPhuM+of3lWU8Vw=;
        b=cxGvnr4McJswAuXvict7l/VcMTXq/vDFyd0a5Mt9gbJlHQUY9sp4BEDqO4fsSnpAuL
         t4BdtPv1L8WnAjcYnedlCLHn9D/smwwIwubKxQzcUmL1af/vIhi7zV/tevCnyWgluSH0
         MGYjwoE8oNnBSi9g12oQQqhDNlw+bgP1swTPlWkV0+MuppthCteq2Qm288my20NFhZZP
         OOq6WaKYe6WGzfRN+C4B+OQ99DMvRs7lsasamiC0bfllr1HGg06rO5cHRinN5C7KBJyV
         3JI/u1m8aipuTTN/GzuzKt4PpbR4I8oD1BbHAGboxG1OE0Xff+IYxfK6GfJErYqrE6lC
         9/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4tZ8MKckyUbGYpRyidCegNDz7iIJQMlbQXzYVKEG5lfEphoaXJB5X/a7zhFyBr26tB/wWqw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/K+3Rad2neIRE3mBaJtVIFqVCVcGk8QAjJjfFWHBEq6FTSiC
	eMEI25ZmUVwp+92Gu0CVDpJ9nveFxHPinOFvU0qAueLmM5xjJwC7FKYkweV4fxxd6Dlk8Vye4a3
	Q1vVfgsnCTxCzYTqMhlPgYkh1TbyEhOucmohjFcJfI22EEAmh9zC4Oek=
X-Gm-Gg: ASbGncsxwIfjIEMwt0Nomim09WnFfKvJzY0McZ1WzrSe3bEEltZgIeg6kJgY0rWEEMK
	Z8bpZBl4VPXi9Gr1BFPlufpV8mCt5lmxuME2QReEAte0XZ5TUiMuwK26YhKLtxyaliNhLH3CRXT
	22uncGYpc=
X-Google-Smtp-Source: AGHT+IGAyFhyfo84f/BjymRhE6/rSEl/wJ+Alex/86YrYEvi+fX9VWC70JpeEB87LPeuBsn7U4f6tTKpjSCo5Vezz7I=
X-Received: by 2002:a05:6402:3223:b0:5e0:818a:5f4d with SMTP id
 4fb4d7f45d1cf-5e0b72650b8mr3829844a12.28.1740113292609; Thu, 20 Feb 2025
 20:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204170314.146022-1-atenart@kernel.org> <20250204170314.146022-2-atenart@kernel.org>
In-Reply-To: <20250204170314.146022-2-atenart@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Feb 2025 05:48:00 +0100
X-Gm-Features: AWEUYZlWsuYZXMWhvLd6-8AjHkoopzOWzlwDSoRIkYOnXLu9ZZn9CpSEt_0Taf0
Message-ID: <CANn89i+rpLGkgob=EJ6AKSSrRodvCv0FMMAndK6NCfL5YeGjFA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	stephen@networkplumber.org, gregkh@linuxfoundation.org, 
	maxime.chevallier@bootlin.com, christophe.leroy@csgroup.eu, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:03=E2=80=AFPM Antoine Tenart <atenart@kernel.org> =
wrote:
>
> There is an ABBA deadlock between net device unregistration and sysfs
> files being accessed[1][2]. To prevent this from happening all paths
> taking the rtnl lock after the sysfs one (actually kn->active refcount)
> use rtnl_trylock and return early (using restart_syscall)[3], which can
> make syscalls to spin for a long time when there is contention on the
> rtnl lock[4].
>
> There are not many possibilities to improve the above:
> - Rework the entire net/ locking logic.
> - Invert two locks in one of the paths =E2=80=94 not possible.
>
> But here it's actually possible to drop one of the locks safely: the
> kernfs_node refcount. More details in the code itself, which comes with
> lots of comments.
>
> Note that we check the device is alive in the added sysfs_rtnl_lock
> helper to disallow sysfs operations to run after device dismantle has
> started. This also help keeping the same behavior as before. Because of
> this calls to dev_isalive in sysfs ops were removed.
>
> [1] https://lore.kernel.org/netdev/49A4D5D5.5090602@trash.net/
> [2] https://lore.kernel.org/netdev/m14oyhis31.fsf@fess.ebiederm.org/
> [3] https://lore.kernel.org/netdev/20090226084924.16cb3e08@nehalam/
> [4] https://lore.kernel.org/all/20210928125500.167943-1-atenart@kernel.or=
g/T/
>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  include/linux/rtnetlink.h |   1 +
>  net/core/net-sysfs.c      | 186 +++++++++++++++++++++++++++-----------
>  net/core/rtnetlink.c      |   5 +
>  3 files changed, 139 insertions(+), 53 deletions(-)
>
> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index 4bc2ee0b10b0..ccaaf4c7d5f6 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -43,6 +43,7 @@ extern void rtnl_lock(void);
>  extern void rtnl_unlock(void);
>  extern int rtnl_trylock(void);
>  extern int rtnl_is_locked(void);
> +extern int rtnl_lock_interruptible(void);
>  extern int rtnl_lock_killable(void);
>  extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
>
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 07cb99b114bd..e012234c739a 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -42,6 +42,87 @@ static inline int dev_isalive(const struct net_device =
*dev)
>         return READ_ONCE(dev->reg_state) <=3D NETREG_REGISTERED;
>  }
>
> +/* There is a possible ABBA deadlock between rtnl_lock and kernfs_node->=
active,
> + * when unregistering a net device and accessing associated sysfs files.=
 The
> + * potential deadlock is as follow:
> + *
> + *         CPU 0                                         CPU 1
> + *
> + *    rtnl_lock                                   vfs_read
> + *    unregister_netdevice_many                   kernfs_seq_start
> + *    device_del / kobject_put                      kernfs_get_active (k=
n->active++)
> + *    kernfs_drain                                sysfs_kf_seq_show
> + *    wait_event(                                 rtnl_lock
> + *       kn->active =3D=3D KN_DEACTIVATED_BIAS)       -> waits on CPU 0 =
to release
> + *    -> waits on CPU 1 to decrease kn->active       the rtnl lock.
> + *
> + * The historical fix was to use rtnl_trylock with restart_syscall to ba=
il out
> + * of sysfs operations when the lock couldn't be taken. This fixed the a=
bove
> + * issue as it allowed CPU 1 to bail out of the ABBA situation.
> + *
> + * But it came with performances issues, as syscalls are being restarted=
 in
> + * loops when there was contention on the rtnl lock, with huge slow down=
s in
> + * specific scenarios (e.g. lots of virtual interfaces created and users=
pace
> + * daemons querying their attributes).
> + *
> + * The idea below is to bail out of the active kernfs_node protection
> + * (kn->active) while trying to take the rtnl lock.
> + *
> + * This replaces rtnl_lock() and still has to be used with rtnl_unlock()=
. The
> + * net device is guaranteed to be alive if this returns successfully.
> + */
> +static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
> +                          struct net_device *ndev)
> +{
> +       struct kernfs_node *kn;
> +       int ret =3D 0;
> +
> +       /* First, we hold a reference to the net device as the unregistra=
tion
> +        * path might run in parallel. This will ensure the net device an=
d the
> +        * associated sysfs objects won't be freed while we try to take t=
he rtnl
> +        * lock.
> +        */
> +       dev_hold(ndev);
> +       /* sysfs_break_active_protection was introduced to allow self-rem=
oval of
> +        * devices and their associated sysfs files by bailing out of the
> +        * sysfs/kernfs protection. We do this here to allow the unregist=
ration
> +        * path to complete in parallel. The following takes a reference =
on the
> +        * kobject and the kernfs_node being accessed.
> +        *
> +        * This works because we hold a reference onto the net device and=
 the
> +        * unregistration path will wait for us eventually in netdev_run_=
todo
> +        * (outside an rtnl lock section).
> +        */
> +       kn =3D sysfs_break_active_protection(kobj, attr);
> +       /* We can now try to take the rtnl lock. This can't deadlock us a=
s the
> +        * unregistration path is able to drain sysfs files (kernfs_node)=
 thanks
> +        * to the above dance.
> +        */
> +       if (rtnl_lock_interruptible()) {
> +               ret =3D -ERESTARTSYS;
> +               goto unbreak;
> +       }
> +       /* Check dismantle on the device hasn't started, otherwise deny t=
he
> +        * operation.
> +        */
> +       if (!dev_isalive(ndev)) {
> +               rtnl_unlock();
> +               ret =3D -ENODEV;
> +               goto unbreak;
> +       }
> +       /* We are now sure the device dismantle hasn't started nor that i=
t can
> +        * start before we exit the locking section as we hold the rtnl l=
ock.
> +        * There's no need to keep unbreaking the sysfs protection nor to=
 hold
> +        * a net device reference from that point; that was only needed t=
o take
> +        * the rtnl lock.
> +        */
> +unbreak:
> +       sysfs_unbreak_active_protection(kn);
> +       dev_put(ndev);
> +
> +       return ret;
> +}
> +
>  /* use same locking rules as GIF* ioctl's */
>  static ssize_t netdev_show(const struct device *dev,
>                            struct device_attribute *attr, char *buf,
> @@ -95,14 +176,14 @@ static ssize_t netdev_store(struct device *dev, stru=
ct device_attribute *attr,
>         if (ret)
>                 goto err;
>
> -       if (!rtnl_trylock())
> -               return restart_syscall();
> +       ret =3D sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +       if (ret)
> +               goto err;
> +
> +       ret =3D (*set)(netdev, new);
> +       if (ret =3D=3D 0)
> +               ret =3D len;
>
> -       if (dev_isalive(netdev)) {
> -               ret =3D (*set)(netdev, new);
> -               if (ret =3D=3D 0)
> -                       ret =3D len;
> -       }
>         rtnl_unlock();
>   err:
>         return ret;
> @@ -220,7 +301,7 @@ static ssize_t carrier_store(struct device *dev, stru=
ct device_attribute *attr,
>         struct net_device *netdev =3D to_net_dev(dev);
>
>         /* The check is also done in change_carrier; this helps returning=
 early
> -        * without hitting the trylock/restart in netdev_store.
> +        * without hitting the locking section in netdev_store.
>          */
>         if (!netdev->netdev_ops->ndo_change_carrier)
>                 return -EOPNOTSUPP;
> @@ -234,8 +315,9 @@ static ssize_t carrier_show(struct device *dev,
>         struct net_device *netdev =3D to_net_dev(dev);
>         int ret =3D -EINVAL;
>
> -       if (!rtnl_trylock())
> -               return restart_syscall();
> +       ret =3D sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +       if (ret)
> +               return ret;
>
>         if (netif_running(netdev)) {
>                 /* Synchronize carrier state with link watch,
> @@ -245,8 +327,8 @@ static ssize_t carrier_show(struct device *dev,
>
>                 ret =3D sysfs_emit(buf, fmt_dec, !!netif_carrier_ok(netde=
v));
>         }
> -       rtnl_unlock();
>
> +       rtnl_unlock();
>         return ret;
>  }

There is a difference in behavior though..

# modprobe dummy numdummies=3D1
# ip link sh dev dummy0
17: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode
DEFAULT group default qlen 1000
    link/ether ba:d3:e9:c3:a7:fc brd ff:ff:ff:ff:ff:ff

Old kernels

# cat /sys/class/net/dummy0/carrier
cat: /sys/class/net/dummy0/carrier: Invalid argument

After your patch we have instead an empty string, no error.

# cat /sys/class/net/dummy0/carrier | wc
      0       0       0

Is it ok for you if I submit the following fix ?

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3fe2c521e5740436687f09c572754c5d071038f4..7f9bb4c52d265d6858b82e6bee3=
a735b64a90457
100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -313,12 +313,13 @@ static ssize_t carrier_show(struct device *dev,
                            struct device_attribute *attr, char *buf)
 {
        struct net_device *netdev =3D to_net_dev(dev);
-       int ret =3D -EINVAL;
+       int ret;

        ret =3D sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
        if (ret)
                return ret;

+       ret =3D -EINVAL;
        if (netif_running(netdev)) {
                /* Synchronize carrier state with link watch,
                 * see also rtnl_getlink().

