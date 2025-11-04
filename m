Return-Path: <netdev+bounces-235615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B09C33494
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B57C18C4947
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC531352E;
	Tue,  4 Nov 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIkxGOym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34D2D3EF1
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296269; cv=none; b=dp8SQgar1Yu67q6cFyg5Fb5bLfFEDMdGfB8HVs8am+E3Jv0qTaptoapk03WWAr2D0ggW3/dvbctHzg6yUCGbjFJLEv5hmTEIzDYZTtxeCYuu486KI5slIhFpxmmoH3ojAyASCC87p9WS8nNIIZMtg0SF8Di2wGZX3acIv7S2vYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296269; c=relaxed/simple;
	bh=eS3W7k+HnJ8OI3vn+W3JIleiJDBojcLDGWPm/+QiQZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DG/pZZJMGvF3KKFniIp8TF6Fck4i6JHbQE6xcA4G1qhec0TXIFabEKdF6+0ZcxL2QV9H3lLl2A8vnMULY0oj+YeewOY8QT3mdF/MmewEuUCUep89PvzVOe/hs/lppvuXylTgFiGfZ51zqOg84kidDS0kvf/nIz8iY5ThdmoyT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIkxGOym; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso330071a91.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762296267; x=1762901067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiDvzC489Q/yYinLktNcmGSgFp1iqEtljNgNWh7um/4=;
        b=tIkxGOymd+zUoF2TLPB6bC5Nq07g/LZsPmD6rOvw4jCOZ8qDxv8628Oz359BHEjVrW
         RjqvKPhGCP3PdAc7I1fCOGtfuAQl3V1Jr6G4bt8FR+Pu/InsVx7tDS1qIJrraAC0jco5
         yAUy9D52SoEM16Jk4RiX1FwU0FqcLUTnlwrbzTKSNw94+xTO2uc8vqmLoyYW7a3V8SgY
         Gf6O1KHuphNovd3/SzLWmTklsfl5uW0TZzffNPru+NCZMeZGzgOWnrws4S62sarTim49
         +ILSg4aWL6cgYHpD+V7EeEgSpDwNRxjTF7uAb1szy5XO4LniE+/gKfES5G/XGEnO0btD
         VaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296267; x=1762901067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiDvzC489Q/yYinLktNcmGSgFp1iqEtljNgNWh7um/4=;
        b=tJbW0H4lgEvskHBIJcniQiLS75HD7mUOiMXCJwBACnpiZFDJ1mdZwPGNg2GAubQS8U
         vJyR2E6UFBiuobUVmZx/TULFhu5V1WVJf8cl91hEVfYYXaNE84A/+NToO8U/csm74/D0
         y+B5ap6Nj9abuq2xb896cOC1VH/Qsx4bsAtdQjMvY1NJYNq9oHDHkZeeHf0zgUqzaRq+
         1WXkOoUz/aP0gXpsql1v1jUOfzNqGrT21tlYqUgOANikEfLzYH72dYqfC1xLUhs/tolI
         GAc6jlbVgo9XwxAH5ssrL1Vcw2056oDGxgRvgsMMv8n6GzoQU6czazVZLGPMs6BMx7tU
         W9kw==
X-Gm-Message-State: AOJu0YykdkmYn3Ed0r/M0s+zgmBOdQVS27dr0Wmm6OaEpCMn6kRNr8aU
	FyyxoMdmkwOP6cWAwS6Vm6PMyn+pI2LUDhlzs+E0OKUH2FGZ+U5mXLuvcfyy3PKifNhD74YodjE
	pF145hhabniinZQDxslkzTAwlaf/dq58SoBQrgy+g
X-Gm-Gg: ASbGncsXdOdZ3vIzGU15z0WJ+pjR/lbDNxOjpBNDu1hSMZnXCTx1ON4OrjBOB7ntqR5
	cZNuei997aeh3KZ4H1oMUErK7W7mtJHkjN2D3jN8AlSTFqKQmBWbyUCGdqeuyAsU8+JVx4ewQUT
	Mg0QquvCh1JDWJlX8NSr69gQ7rAHu1TXPFQGKTaai+cJNgON0HoeMd0wWNlguufuE7UA8a50HIy
	bHRj67/FsYk0JEd7CCpSDU/UzWd+sGnYEI8xX03ocvTJv+9eQv74dlxjscVmzbbfaVKWszU+WGZ
	FWxbW1nv5YgYAQ==
X-Google-Smtp-Source: AGHT+IEyIyhxPHY+ZpDB21zqn18n6CTXncejgAvnBv3OB2nsCPYwEViQzPqA0FzGhM2pLVwRlD2jnu0wGoSpqflhq3o=
X-Received: by 2002:a05:6a20:9392:b0:2d7:1689:e3bb with SMTP id
 adf61e73a8af0-34e2964310amr5766821637.22.1762296266857; Tue, 04 Nov 2025
 14:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104221348.4163417-1-florian.fainelli@broadcom.com> <20251104221348.4163417-2-florian.fainelli@broadcom.com>
In-Reply-To: <20251104221348.4163417-2-florian.fainelli@broadcom.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Nov 2025 14:44:15 -0800
X-Gm-Features: AWmQ_bl-3Inyd_3hEG3iiOv3rQ_M1VvkP2XiWHdbuk5Yb9KMUmLUqM-smX_7X64
Message-ID: <CAAVpQUAXPadkvRa7Rdo-_bQOpH5XRr+GST4cdv6G-be=SQ5sAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: Allow disabling pause on panic
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Antoine Tenart <atenart@kernel.org>, Yajun Deng <yajun.deng@linux.dev>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:13=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> Development devices on a lab network might be subject to kernel panics
> and if they have pause frame generation enabled, once the kernel panics,
> the Ethernet controller stops being serviced. This can create a flood of
> pause frames that certain switches are unable to handle resulting a
> completle paralysis of the network because they broadcast to other
> stations on that same network segment.
>
> To accomodate for such situation introduce a
> /sys/class/net/<device>/disable_pause_on_panic knob which will disable
> Ethernet pause frame generation upon kernel panic.
>
> Note that device driver wishing to make use of that feature need to
> implement ethtool_ops::set_pauseparam_panic to specifically deal with
> that atomic context.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/ABI/testing/sysfs-class-net | 16 +++++
>  include/linux/ethtool.h                   |  3 +
>  include/linux/netdevice.h                 |  1 +
>  net/core/net-sysfs.c                      | 34 ++++++++++
>  net/ethernet/Makefile                     |  3 +-
>  net/ethernet/pause_panic.c                | 81 +++++++++++++++++++++++
>  6 files changed, 137 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethernet/pause_panic.c
>
> diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/AB=
I/testing/sysfs-class-net
> index ebf21beba846..f762ce439203 100644
> --- a/Documentation/ABI/testing/sysfs-class-net
> +++ b/Documentation/ABI/testing/sysfs-class-net
> @@ -352,3 +352,19 @@ Description:
>                 0  threaded mode disabled for this dev
>                 1  threaded mode enabled for this dev
>                 =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +What:          /sys/class/net/<iface>/disable_pause_on_panic
> +Date:          Nov 2025
> +KernelVersion: 6.20
> +Contact:       netdev@vger.kernel.org
> +Description:
> +               Boolean value to control whether to disable pause frame
> +               generation on panic. This is helpful in environments wher=
e
> +               the link partner may incorrect respond to pause frames (e=
.g.:
> +               improperly configured Ethernet switches)
> +
> +               Possible values:
> +               =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +               0  threaded mode disabled for this dev
> +               1  threaded mode enabled for this dev

nit: These lines need to be updated.


> +               =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index c2d8b4ec62eb..e014d0f2a5ac 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -956,6 +956,8 @@ struct kernel_ethtool_ts_info {
>   * @get_pauseparam: Report pause parameters
>   * @set_pauseparam: Set pause parameters.  Returns a negative error code
>   *     or zero.
> + * @set_pauseparam_panic: Set pause parameters while in a panic context.=
 This
> + *     call is not allowed to sleep. Returns a negative error code or ze=
ro.
>   * @self_test: Run specified self-tests
>   * @get_strings: Return a set of strings that describe the requested obj=
ects
>   * @set_phys_id: Identify the physical devices, e.g. by flashing an LED
> @@ -1170,6 +1172,7 @@ struct ethtool_ops {
>                                   struct ethtool_pauseparam*);
>         int     (*set_pauseparam)(struct net_device *,
>                                   struct ethtool_pauseparam*);
> +       void    (*set_pauseparam_panic)(struct net_device *);
>         void    (*self_test)(struct net_device *, struct ethtool_test *, =
u64 *);
>         void    (*get_strings)(struct net_device *, u32 stringset, u8 *);
>         int     (*set_phys_id)(struct net_device *, enum ethtool_phys_id_=
state);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e808071dbb7d..2d4b07693745 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2441,6 +2441,7 @@ struct net_device {
>         bool                    proto_down;
>         bool                    irq_affinity_auto;
>         bool                    rx_cpu_rmap_auto;
> +       bool                    disable_pause_on_panic;
>
>         /* priv_flags_slow, ungrouped to save space */
>         unsigned long           see_all_hwtstamp_requests:1;
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index ca878525ad7c..c01dc3e200d8 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -770,6 +770,39 @@ static ssize_t threaded_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(threaded);
>
> +static ssize_t disable_pause_on_panic_show(struct device *dev,
> +                                           struct device_attribute *attr=
,
> +                                           char *buf)
> +{
> +       struct net_device *ndev =3D to_net_dev(dev);
> +       ssize_t ret =3D -EINVAL;
> +
> +       rcu_read_lock();
> +       if (dev_isalive(ndev))
> +               ret =3D sysfs_emit(buf, fmt_dec, READ_ONCE(ndev->disable_=
pause_on_panic));
> +       rcu_read_unlock();
> +
> +       return ret;
> +}
> +
> +static int modify_disable_pause_on_panic(struct net_device *dev, unsigne=
d long val)
> +{
> +       if (val !=3D 0 && val !=3D 1)
> +               return -EINVAL;

Should we validate !ops->set_pauseparam_panic here
rather than disable_pause_on_device() ?

ops =3D dev->ethtool_ops;
if (!ops || !ops->set_pauseparam_panic)
    return -EOPNOTSUPP;


> +
> +       WRITE_ONCE(dev->disable_pause_on_panic, val);
> +
> +       return 0;
> +}
> +
> +static ssize_t disable_pause_on_panic_store(struct device *dev,
> +                                            struct device_attribute *att=
r,
> +                                            const char *buf, size_t len)
> +{
> +       return netdev_store(dev, attr, buf, len, modify_disable_pause_on_=
panic);
> +}
> +static DEVICE_ATTR_RW(disable_pause_on_panic);
> +
>  static struct attribute *net_class_attrs[] __ro_after_init =3D {
>         &dev_attr_netdev_group.attr,
>         &dev_attr_type.attr,
> @@ -800,6 +833,7 @@ static struct attribute *net_class_attrs[] __ro_after=
_init =3D {
>         &dev_attr_carrier_up_count.attr,
>         &dev_attr_carrier_down_count.attr,
>         &dev_attr_threaded.attr,
> +       &dev_attr_disable_pause_on_panic.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(net_class);
> diff --git a/net/ethernet/Makefile b/net/ethernet/Makefile
> index e03eff94e0db..9b1f3ff8695a 100644
> --- a/net/ethernet/Makefile
> +++ b/net/ethernet/Makefile
> @@ -3,4 +3,5 @@
>  # Makefile for the Linux Ethernet layer.
>  #
>
> -obj-y                                  +=3D eth.o
> +obj-y                                  +=3D eth.o \
> +                                          pause_panic.o
> diff --git a/net/ethernet/pause_panic.c b/net/ethernet/pause_panic.c
> new file mode 100644
> index 000000000000..8ef61eb768a0
> --- /dev/null
> +++ b/net/ethernet/pause_panic.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ethernet pause disable on panic handler
> + *
> + * This module provides per-device control via sysfs to disable Ethernet=
 flow
> + * control (pause frames) on individual Ethernet devices when the kernel=
 panics.
> + * Each device can be configured via /sys/class/net/<device>/disable_pau=
se_on_panic.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/panic_notifier.h>
> +#include <linux/netdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/notifier.h>
> +#include <linux/if_ether.h>
> +#include <net/net_namespace.h>
> +
> +/*
> + * Disable pause/flow control on a single Ethernet device.
> + */
> +static void disable_pause_on_device(struct net_device *dev)
> +{
> +       const struct ethtool_ops *ops;
> +
> +       /* Only proceed if this device has the flag enabled */
> +       if (!READ_ONCE(dev->disable_pause_on_panic))
> +               return;
> +
> +       ops =3D dev->ethtool_ops;
> +       if (!ops || !ops->set_pauseparam_panic)
> +               return;
> +
> +       /*
> +        * In panic context, we're in atomic context and cannot sleep.
> +        */
> +       ops->set_pauseparam_panic(dev);
> +}
> +
> +/*
> + * Panic notifier to disable pause frames on all Ethernet devices.
> + * Called in atomic context during kernel panic.
> + */
> +static int eth_pause_panic_handler(struct notifier_block *this,
> +                                       unsigned long event, void *ptr)
> +{
> +       struct net_device *dev;
> +
> +       /*
> +        * Iterate over all network devices in the init namespace.
> +        * In panic context, we cannot acquire locks that might sleep,
> +        * so we use RCU iteration.
> +        * Each device will check its own disable_pause_on_panic flag.
> +        */
> +       rcu_read_lock();
> +       for_each_netdev_rcu(&init_net, dev) {
> +               /* Reference count might not be available in panic */
> +               if (!dev)
> +                       continue;

This seems unnecessary unless while() + next_net_device_rcu()
is used instead of for_each_netdev_rcu().

Or are we assuming that something could overwrite NULL to
dev->dev_list.next and panic ?


> +
> +               disable_pause_on_device(dev);
> +       }
> +       rcu_read_unlock();
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block eth_pause_panic_notifier =3D {
> +       .notifier_call =3D eth_pause_panic_handler,
> +       .priority =3D INT_MAX, /* Run as late as possible */
> +};
> +
> +static int __init eth_pause_panic_init(void)
> +{
> +       /* Register panic notifier */
> +       atomic_notifier_chain_register(&panic_notifier_list,
> +                                      &eth_pause_panic_notifier);
> +
> +       return 0;
> +}
> +device_initcall(eth_pause_panic_init);
> --
> 2.34.1
>

