Return-Path: <netdev+bounces-168390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA21A3EBFE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 05:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5360B177EDE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 04:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A561F4299;
	Fri, 21 Feb 2025 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHoF/F07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00728F9D9
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740113672; cv=none; b=q0l9lF6ldJ0cMRJ4K7fJDr5WfnonKefzd5Td7ogElUXf9QXQgsc2ckKu08tYqt+YlisfJJcqI7VTNT8HjZ54pbzc0t7M3aPxf/CxsDVi9y+ex/wHah1RAI14v6o00wQk8kdwJvge5zyA3QN0mScJiONrnX20GRc6FjOyAqmkpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740113672; c=relaxed/simple;
	bh=oLvabpzRcaOm0i0DM1putcqQDtX5lkEYm77wRFKsQ2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw8wdvj0uuf0w/vykZjrcn9PuDxnrfqGjltF/s4/z4LlOdhqk4tZTO4MdOxu64HF73m6dZjCbLWUy3AMMNi+yFcLsXlqUEPu/9nfJlaL5eZcG2FVIVm6fJ8HUfKL12K/lIxlAiiIxtbNkJp1detT/jiD9pKNmbWavU9tb8maTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHoF/F07; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so3157460a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 20:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740113668; x=1740718468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZabtbTJPUry+P3DkOPYTwpCY4bP+oOF7yTJjbaBI0YM=;
        b=IHoF/F07C9QdNyggqHqgsq2AGXCTlEndCsX9SW7LvO3Z3paZKR/hfM0CKtNOrqtBsh
         q9+evitwMZji2928831cK+y6XiN2zGG6f0FJHMXh/S8+vX4DhOWdMgIoyb1Ub8hNGoCk
         luFV1Scy3LcY7k3fDIFuZduRfTxP/kJXdgeKBxLogHn643cfYcp6+/us+ctJZ/6Gnixi
         L3ubFiFHcuDIhIJlEonJRKEKby639pBPl6hlmsm09w1D4LBpKgWrlXkfJZH+KUja2ABB
         Tnz01n/DkKPZK8zPoKvXcd+pz25pnT7Y5EWjl7cs8U3SxKCx4QXAIBgo0cQZmT4KgL7Y
         gKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740113668; x=1740718468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZabtbTJPUry+P3DkOPYTwpCY4bP+oOF7yTJjbaBI0YM=;
        b=G2OzOJwB4VFj0S/AV0VN+6rfMcH5DXXDkAwclBOEZUzpjssXeYJwspKtW+cZBTuWeR
         +1fCu/si/k/XDRLf7RBSi/UnkNdTlRnVBsg1JljX8CqDXa5H8CqNWSRT1Y8o2F+waOuS
         XlMi65cplZHpquxW+YNl9hdIWjKu42Yp/QkxU+Xwh0/LZZm5e9XZkLvyCq8EtnBbROap
         2srSUn3f1dBUvBxqyk3/v1A+uSX7WLT8+fBaceEU68+W1sIeMp1H8hg8e4d2Yg72O7A0
         C3oaetaHWeCe/v04KsbCmV/EJE44oFJXBBiCYI2dEN5wz7RDXWnRK0KXM6rrgn1itlTf
         rOIA==
X-Forwarded-Encrypted: i=1; AJvYcCUwRDrVQJS7iSke1gOx48VhE2sPaGC8Z++i/l//bI7sUSn/RymqFS9Lvs8+Bgxna3N1dxMLDnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwUHpfn7LXblWZ06/x9md2kHzy6dmvqsLJzOSvqltAuyJpsF7
	7vcBC55P4PDNxw1SfaUOIDUcViLjalzoSD6E7s3IQN1D8hQoYI8bQ8QfO4/VRjGMqUtkgm0e5NK
	pbl2gzPZHpl3G8J/1sJtXfbF0VB3pgSNIhcao
X-Gm-Gg: ASbGncuiF8H/AH6q/jMM67Jd7wcmJQm4fmZplemLIatmeLJ1hPJT6BWjn1XDFaeyUpO
	lnsh8SstGT5TnnI2qh8BexcVokmfsMb2B6dLGeEcM6gC5wfyBV9odvr3OfRm1k/8Im0GpGRjalH
	cd4H7/VKI=
X-Google-Smtp-Source: AGHT+IEe5m6hbcXuxiYiFRcN2tiiVdbB4o1R4koCOLea6I3VqrdRl1LZUKxd/N/I7eq/XXe1bSGqlpAvGqLoe7ePXVQ=
X-Received: by 2002:a05:6402:4495:b0:5df:5188:11cc with SMTP id
 4fb4d7f45d1cf-5e0b722a27dmr1117327a12.20.1740113668047; Thu, 20 Feb 2025
 20:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204170314.146022-1-atenart@kernel.org> <20250204170314.146022-2-atenart@kernel.org>
 <CANn89i+rpLGkgob=EJ6AKSSrRodvCv0FMMAndK6NCfL5YeGjFA@mail.gmail.com>
In-Reply-To: <CANn89i+rpLGkgob=EJ6AKSSrRodvCv0FMMAndK6NCfL5YeGjFA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Feb 2025 05:54:17 +0100
X-Gm-Features: AWEUYZliAr_tDIxmjbhc6A8xoGSYTKfa46Vwd-DtVNiswyHK5zYmDmqE8M1DqoQ
Message-ID: <CANn89i+3cY8-S9mVyn+mZx1Pk7ghp0gXLjpg==7KS0v3yhNyXw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	stephen@networkplumber.org, gregkh@linuxfoundation.org, 
	maxime.chevallier@bootlin.com, christophe.leroy@csgroup.eu, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:48=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Feb 4, 2025 at 6:03=E2=80=AFPM Antoine Tenart <atenart@kernel.org=
> wrote:
> >
> > There is an ABBA deadlock between net device unregistration and sysfs
> > files being accessed[1][2]. To prevent this from happening all paths
> > taking the rtnl lock after the sysfs one (actually kn->active refcount)
> > use rtnl_trylock and return early (using restart_syscall)[3], which can
> > make syscalls to spin for a long time when there is contention on the
> > rtnl lock[4].
> >
> > There are not many possibilities to improve the above:
> > - Rework the entire net/ locking logic.
> > - Invert two locks in one of the paths =E2=80=94 not possible.
> >
> > But here it's actually possible to drop one of the locks safely: the
> > kernfs_node refcount. More details in the code itself, which comes with
> > lots of comments.
> >
> > Note that we check the device is alive in the added sysfs_rtnl_lock
> > helper to disallow sysfs operations to run after device dismantle has
> > started. This also help keeping the same behavior as before. Because of
> > this calls to dev_isalive in sysfs ops were removed.
> >
> > [1] https://lore.kernel.org/netdev/49A4D5D5.5090602@trash.net/
> > [2] https://lore.kernel.org/netdev/m14oyhis31.fsf@fess.ebiederm.org/
> > [3] https://lore.kernel.org/netdev/20090226084924.16cb3e08@nehalam/
> > [4] https://lore.kernel.org/all/20210928125500.167943-1-atenart@kernel.=
org/T/
> >
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> > ---
> >  include/linux/rtnetlink.h |   1 +
> >  net/core/net-sysfs.c      | 186 +++++++++++++++++++++++++++-----------
> >  net/core/rtnetlink.c      |   5 +
> >  3 files changed, 139 insertions(+), 53 deletions(-)
> >
> > diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> > index 4bc2ee0b10b0..ccaaf4c7d5f6 100644
> > --- a/include/linux/rtnetlink.h
> > +++ b/include/linux/rtnetlink.h
> > @@ -43,6 +43,7 @@ extern void rtnl_lock(void);
> >  extern void rtnl_unlock(void);
> >  extern int rtnl_trylock(void);
> >  extern int rtnl_is_locked(void);
> > +extern int rtnl_lock_interruptible(void);
> >  extern int rtnl_lock_killable(void);
> >  extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
> >
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index 07cb99b114bd..e012234c739a 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -42,6 +42,87 @@ static inline int dev_isalive(const struct net_devic=
e *dev)
> >         return READ_ONCE(dev->reg_state) <=3D NETREG_REGISTERED;
> >  }
> >
> > +/* There is a possible ABBA deadlock between rtnl_lock and kernfs_node=
->active,
> > + * when unregistering a net device and accessing associated sysfs file=
s. The
> > + * potential deadlock is as follow:
> > + *
> > + *         CPU 0                                         CPU 1
> > + *
> > + *    rtnl_lock                                   vfs_read
> > + *    unregister_netdevice_many                   kernfs_seq_start
> > + *    device_del / kobject_put                      kernfs_get_active =
(kn->active++)
> > + *    kernfs_drain                                sysfs_kf_seq_show
> > + *    wait_event(                                 rtnl_lock
> > + *       kn->active =3D=3D KN_DEACTIVATED_BIAS)       -> waits on CPU =
0 to release
> > + *    -> waits on CPU 1 to decrease kn->active       the rtnl lock.
> > + *
> > + * The historical fix was to use rtnl_trylock with restart_syscall to =
bail out
> > + * of sysfs operations when the lock couldn't be taken. This fixed the=
 above
> > + * issue as it allowed CPU 1 to bail out of the ABBA situation.
> > + *
> > + * But it came with performances issues, as syscalls are being restart=
ed in
> > + * loops when there was contention on the rtnl lock, with huge slow do=
wns in
> > + * specific scenarios (e.g. lots of virtual interfaces created and use=
rspace
> > + * daemons querying their attributes).
> > + *
> > + * The idea below is to bail out of the active kernfs_node protection
> > + * (kn->active) while trying to take the rtnl lock.
> > + *
> > + * This replaces rtnl_lock() and still has to be used with rtnl_unlock=
(). The
> > + * net device is guaranteed to be alive if this returns successfully.
> > + */
> > +static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *att=
r,
> > +                          struct net_device *ndev)
> > +{
> > +       struct kernfs_node *kn;
> > +       int ret =3D 0;
> > +
> > +       /* First, we hold a reference to the net device as the unregist=
ration
> > +        * path might run in parallel. This will ensure the net device =
and the
> > +        * associated sysfs objects won't be freed while we try to take=
 the rtnl
> > +        * lock.
> > +        */
> > +       dev_hold(ndev);
> > +       /* sysfs_break_active_protection was introduced to allow self-r=
emoval of
> > +        * devices and their associated sysfs files by bailing out of t=
he
> > +        * sysfs/kernfs protection. We do this here to allow the unregi=
stration
> > +        * path to complete in parallel. The following takes a referenc=
e on the
> > +        * kobject and the kernfs_node being accessed.
> > +        *
> > +        * This works because we hold a reference onto the net device a=
nd the
> > +        * unregistration path will wait for us eventually in netdev_ru=
n_todo
> > +        * (outside an rtnl lock section).
> > +        */
> > +       kn =3D sysfs_break_active_protection(kobj, attr);
> > +       /* We can now try to take the rtnl lock. This can't deadlock us=
 as the
> > +        * unregistration path is able to drain sysfs files (kernfs_nod=
e) thanks
> > +        * to the above dance.
> > +        */
> > +       if (rtnl_lock_interruptible()) {
> > +               ret =3D -ERESTARTSYS;
> > +               goto unbreak;
> > +       }
> > +       /* Check dismantle on the device hasn't started, otherwise deny=
 the
> > +        * operation.
> > +        */
> > +       if (!dev_isalive(ndev)) {
> > +               rtnl_unlock();
> > +               ret =3D -ENODEV;
> > +               goto unbreak;
> > +       }
> > +       /* We are now sure the device dismantle hasn't started nor that=
 it can
> > +        * start before we exit the locking section as we hold the rtnl=
 lock.
> > +        * There's no need to keep unbreaking the sysfs protection nor =
to hold
> > +        * a net device reference from that point; that was only needed=
 to take
> > +        * the rtnl lock.
> > +        */
> > +unbreak:
> > +       sysfs_unbreak_active_protection(kn);
> > +       dev_put(ndev);
> > +
> > +       return ret;
> > +}
> > +
> >  /* use same locking rules as GIF* ioctl's */
> >  static ssize_t netdev_show(const struct device *dev,
> >                            struct device_attribute *attr, char *buf,
> > @@ -95,14 +176,14 @@ static ssize_t netdev_store(struct device *dev, st=
ruct device_attribute *attr,
> >         if (ret)
> >                 goto err;
> >
> > -       if (!rtnl_trylock())
> > -               return restart_syscall();
> > +       ret =3D sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> > +       if (ret)
> > +               goto err;
> > +
> > +       ret =3D (*set)(netdev, new);
> > +       if (ret =3D=3D 0)
> > +               ret =3D len;
> >
> > -       if (dev_isalive(netdev)) {
> > -               ret =3D (*set)(netdev, new);
> > -               if (ret =3D=3D 0)
> > -                       ret =3D len;
> > -       }
> >         rtnl_unlock();
> >   err:
> >         return ret;
> > @@ -220,7 +301,7 @@ static ssize_t carrier_store(struct device *dev, st=
ruct device_attribute *attr,
> >         struct net_device *netdev =3D to_net_dev(dev);
> >
> >         /* The check is also done in change_carrier; this helps returni=
ng early
> > -        * without hitting the trylock/restart in netdev_store.
> > +        * without hitting the locking section in netdev_store.
> >          */
> >         if (!netdev->netdev_ops->ndo_change_carrier)
> >                 return -EOPNOTSUPP;
> > @@ -234,8 +315,9 @@ static ssize_t carrier_show(struct device *dev,
> >         struct net_device *netdev =3D to_net_dev(dev);
> >         int ret =3D -EINVAL;
> >
> > -       if (!rtnl_trylock())
> > -               return restart_syscall();
> > +       ret =3D sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> > +       if (ret)
> > +               return ret;
> >
> >         if (netif_running(netdev)) {
> >                 /* Synchronize carrier state with link watch,
> > @@ -245,8 +327,8 @@ static ssize_t carrier_show(struct device *dev,
> >
> >                 ret =3D sysfs_emit(buf, fmt_dec, !!netif_carrier_ok(net=
dev));
> >         }
> > -       rtnl_unlock();
> >
> > +       rtnl_unlock();
> >         return ret;
> >  }
>
> There is a difference in behavior though..
>
> # modprobe dummy numdummies=3D1
> # ip link sh dev dummy0
> 17: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode
> DEFAULT group default qlen 1000
>     link/ether ba:d3:e9:c3:a7:fc brd ff:ff:ff:ff:ff:ff
>
> Old kernels
>
> # cat /sys/class/net/dummy0/carrier
> cat: /sys/class/net/dummy0/carrier: Invalid argument
>
> After your patch we have instead an empty string, no error.
>
> # cat /sys/class/net/dummy0/carrier | wc
>       0       0       0
>
> Is it ok for you if I submit the following fix ?
>
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 3fe2c521e5740436687f09c572754c5d071038f4..7f9bb4c52d265d6858b82e6be=
e3a735b64a90457
> 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -313,12 +313,13 @@ static ssize_t carrier_show(struct device *dev,
>                             struct device_attribute *attr, char *buf)
>  {
>         struct net_device *netdev =3D to_net_dev(dev);
> -       int ret =3D -EINVAL;
> +       int ret;
>
>         ret =3D sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
>         if (ret)
>                 return ret;
>
> +       ret =3D -EINVAL;
>         if (netif_running(netdev)) {
>                 /* Synchronize carrier state with link watch,
>                  * see also rtnl_getlink().

(same change needed in speed_show(), duplex_show(), ...)

