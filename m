Return-Path: <netdev+bounces-74370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0B8610CF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF81C22D8A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9C7B3EC;
	Fri, 23 Feb 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="poWIoIql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD176911
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689121; cv=none; b=NWqzoQWfrymj0dF/dcpvd7CFKPdIhBBI5SxQCFISHrP1nFTFm0D7tRsomdUvHbGhvmRhQ80Rt4N6vke1mcBme0GhZ+amp32W89RjWe6OWzO9zExNczn9FexopQGW2cAD3VJcP+foMrRD/sgAydQP0zRC2cge0HDz6BaSKkogrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689121; c=relaxed/simple;
	bh=FylTJ++B/n6H2zyHxqfzANN03BUj8e6Bp6L0ZEIhjJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlPSzxgMdzKYCiw7xevO6Ep2SK0U1QX2WAxbvOj0vDmbz28auxAgW2S7/w1/yN+7gajVzROODlhqvh9+wO6IHqwS/0WvbjUrreGx+tik7p85RPiZU4xzF9eTJ3/qZWE2unPTn1QzJj75I+DmmtRHObMHMEA4SSAvo0ZJgvg292E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=poWIoIql; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso9062a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708689117; x=1709293917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Var6gPm6T29AIfIUAF/QmAjVkyu4NTjJo7DYGn3TAnA=;
        b=poWIoIqlS+CnHVQTqhfSCcGniCrWnBS6d5D5kdAAmWvemeXHenR7X7JoNnBX0MPojd
         bISwkAYTWlX0GXsiX+GTCSWwwc0tTYtapb+mPctPwuYY5lgNWx2jKINAqo/krOseWyyl
         NoRD/Cr77zjgntg1exz5o6+QbKvWfyNfPYlMTtXNwbXyzkSHLjLelEZ/ycq5As7x7SgA
         +OZdBK7sQSCwv81FsyezRPnS0E2yoLt/s6F0GwqwsP1bhOcshbOkxI3j3M1poMik2NV9
         fkm5hXB6+4FNujn0Z/QqTotJ9A+B4kzTqn7tH3jbaRWPg/Ls5sO93W5l/3Z9ZSrEGMXg
         GAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708689117; x=1709293917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Var6gPm6T29AIfIUAF/QmAjVkyu4NTjJo7DYGn3TAnA=;
        b=CeM6U/BaA2nm3Q7wpq29IXA3AsdKL7sv7dNYDvwxI2hHYtZd3rn7Is+GwSm3jTSiQw
         FTV0ciPMC6zuMvS7cS08OiJY4dlbQuEtCYAEv8mtRHMfn2qyQrmbWesbZSn/034MWWsp
         m2qQQm0xe4WZqNPJAe4emsJ0J8fP4kqZipdcWtPO8qHIdVAddgPGiCgLDe5Eg1zuf3PL
         cRwEEu197y9jJzn0UY34+C+g3AQkkm04kButXz6HHJC0H97+OCB1+qspI9T5cHpvS4VP
         ludG147y4zNv//MxqP51d0dpZgmz32pcuMXiJGVvwJxtjnVnT0d6VLHhltF5TLV69DbQ
         BPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUpZOrOE1X0Q7r+A6KhT8svPizRX/u+CPIYMSgs/SMnwhzdNZ1pK2seux1UruBY9SeEN9/Yfi5GBpNkdQGbgBjcaHRmrW9e
X-Gm-Message-State: AOJu0YzXjMySKAOK6AcIs/O832MdHq7W8EWTwmcMQnhu+eSoBgfYvTdq
	wYxmNIWF/9s5QBaNJ9LdnWPhrj9cSHZxnkK1mhXTJW451PEWmHBCsit2TuHGmfoe+qIfembmhCL
	l5EUQVf9MMow572hwzxJW6qAc3Usmy0BzMVuj
X-Google-Smtp-Source: AGHT+IEw6pOzr1BoDTqcPUexKYc7fmcG7Javop0zNKWuOtIVpcnRX0rXnhzAmgzrcTEYUaOoHrvq4nOZ5PSQuNR9glk=
X-Received: by 2002:a50:cdcc:0:b0:560:1a1:eb8d with SMTP id
 h12-20020a50cdcc000000b0056001a1eb8dmr584697edj.7.1708689117130; Fri, 23 Feb
 2024 03:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222164851.2534749-1-edumazet@google.com> <ZdhemRFgWb7WldEM@nanopsycho>
In-Reply-To: <ZdhemRFgWb7WldEM@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 12:51:43 +0100
Message-ID: <CANn89iJaykUZ0iOCB+-6CzFk0fNHpHUjLLOUx6sgQkLj7=NZLQ@mail.gmail.com>
Subject: Re: [PATCH net] dpll: rely on rcu for netdev_dpll_pin()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jiri Pirko <jiri@nvidia.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:00=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Feb 22, 2024 at 05:48:51PM CET, edumazet@google.com wrote:
> >This fixes a possible UAF in if_nlmsg_size(),
> >which can run without RTNL.
> >
> >Add rcu protection to "struct dpll_pin"
> >
> >Note: This looks possible to no longer acquire RTNL in
> >netdev_dpll_pin_assign().
>
> Yeah, looks like no longer needed. Will you do a follow-up for net-next
> once this is applied to -net?

Absolutely, this came while I was working on my RTNL->RCU conversion
of "ip l" in net-next.



>
>
> >
> >Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Jiri Pirko <jiri@nvidia.com>
> >Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >---
> > drivers/dpll/dpll_core.c  |  2 +-
> > drivers/dpll/dpll_core.h  |  2 ++
> > include/linux/dpll.h      | 11 +++++++++++
> > include/linux/netdevice.h | 11 +----------
> > net/core/dev.c            |  2 +-
> > net/core/rtnetlink.c      |  2 ++
> > 6 files changed, 18 insertions(+), 12 deletions(-)
> >
> >diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> >index 5152bd1b0daf599869195e81805fbb2709dbe6b4..4c2bb27c99fe4e517b0d92c4=
ae3db83a679c7d11 100644
> >--- a/drivers/dpll/dpll_core.c
> >+++ b/drivers/dpll/dpll_core.c
> >@@ -564,7 +564,7 @@ void dpll_pin_put(struct dpll_pin *pin)
> >               xa_destroy(&pin->parent_refs);
> >               xa_erase(&dpll_pin_xa, pin->id);
> >               dpll_pin_prop_free(&pin->prop);
> >-              kfree(pin);
> >+              kfree_rcu(pin, rcu);
> >       }
> >       mutex_unlock(&dpll_lock);
> > }
> >diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> >index 717f715015c742238d5585fddc5cd267fbb0db9f..2b6d8ef1cdf36cff24328e49=
7c49d667659dd0e6 100644
> >--- a/drivers/dpll/dpll_core.h
> >+++ b/drivers/dpll/dpll_core.h
> >@@ -47,6 +47,7 @@ struct dpll_device {
> >  * @prop:             pin properties copied from the registerer
> >  * @rclk_dev_name:    holds name of device when pin can recover clock f=
rom it
> >  * @refcount:         refcount
> >+ * @rcu:              rcu_head for kfree_rcu()
> >  **/
> > struct dpll_pin {
> >       u32 id;
> >@@ -57,6 +58,7 @@ struct dpll_pin {
> >       struct xarray parent_refs;
> >       struct dpll_pin_properties prop;
> >       refcount_t refcount;
> >+      struct rcu_head rcu;
> > };
> >
> > /**
> >diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> >index 9cf896ea1d4122f3bc7094e46a5af81b999937dc..4ec2fe9caf5a3f284afd0cfe=
4fc7c2bf42cbbc60 100644
> >--- a/include/linux/dpll.h
> >+++ b/include/linux/dpll.h
> >@@ -10,6 +10,8 @@
> > #include <uapi/linux/dpll.h>
> > #include <linux/device.h>
> > #include <linux/netlink.h>
> >+#include <linux/netdevice.h>
> >+#include <linux/rtnetlink.h>
> >
> > struct dpll_device;
> > struct dpll_pin;
> >@@ -167,4 +169,13 @@ int dpll_device_change_ntf(struct dpll_device *dpll=
);
> >
> > int dpll_pin_change_ntf(struct dpll_pin *pin);
> >
> >+static inline struct dpll_pin *netdev_dpll_pin(const struct net_device =
*dev)
> >+{
> >+#if IS_ENABLED(CONFIG_DPLL)
> >+      return rcu_dereference_rtnl(dev->dpll_pin);
> >+#else
> >+      return NULL;
> >+#endif
>
> Why you moved netdev_dpll_pin() here?

Because of the rcu_dereference_rtnl() call, not available to
include/linux/netdevice.h

Adding the missing include would have been more painful.
include/linux/netdevice.h being included everywhere and being bloated alrea=
dy,
I think moving netdev_dpll_pin() helper in  dpll.h is better (should
not increase compile time for the kernel)

>
>
> >+}
> >+
> > #endif
> >diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >index ef7bfbb9849733fa7f1f097ba53a36a68cc3384b..a9c973b92294bb110cf3cd33=
6485972127b01b58 100644
> >--- a/include/linux/netdevice.h
> >+++ b/include/linux/netdevice.h
> >@@ -2469,7 +2469,7 @@ struct net_device {
> >       struct devlink_port     *devlink_port;
> >
> > #if IS_ENABLED(CONFIG_DPLL)
> >-      struct dpll_pin         *dpll_pin;
> >+      struct dpll_pin __rcu   *dpll_pin;
> > #endif
> > #if IS_ENABLED(CONFIG_PAGE_POOL)
> >       /** @page_pools: page pools created for this netdevice */
> >@@ -4035,15 +4035,6 @@ bool netdev_port_same_parent_id(struct net_device=
 *a, struct net_device *b);
> > void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_=
pin);
> > void netdev_dpll_pin_clear(struct net_device *dev);
> >
> >-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device =
*dev)
> >-{
> >-#if IS_ENABLED(CONFIG_DPLL)
> >-      return dev->dpll_pin;
> >-#else
> >-      return NULL;
> >-#endif
> >-}
> >-
> > struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_=
device *dev, bool *again);
> > struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_dev=
ice *dev,
> >                                   struct netdev_queue *txq, int *ret);
> >diff --git a/net/core/dev.c b/net/core/dev.c
> >index 73a0219730075e666c4f11f668a50dbf9f9afa97..0230391c78f71e22d3c0e925=
ff8d3d792aa54a32 100644
> >--- a/net/core/dev.c
> >+++ b/net/core/dev.c
> >@@ -9078,7 +9078,7 @@ static void netdev_dpll_pin_assign(struct net_devi=
ce *dev, struct dpll_pin *dpll
> > {
> > #if IS_ENABLED(CONFIG_DPLL)
> >       rtnl_lock();
> >-      dev->dpll_pin =3D dpll_pin;
> >+      rcu_assign_pointer(dev->dpll_pin, dpll_pin);
> >       rtnl_unlock();
> > #endif
> > }
> >diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> >index 9c4f427f3a5057b52ec05405e8b15b8ca2246b4b..6239aa62a29cb8752a53e3f7=
5a48a1e2fdd3b0ec 100644
> >--- a/net/core/rtnetlink.c
> >+++ b/net/core/rtnetlink.c
> >@@ -1057,7 +1057,9 @@ static size_t rtnl_dpll_pin_size(const struct net_=
device *dev)
> > {
> >       size_t size =3D nla_total_size(0); /* nest IFLA_DPLL_PIN */
> >
> >+      rcu_read_lock();
>
> Why do you need to take the rcu read lock here? Isn't this called
> with either rtnl held of rcu read lock held?
>
> And if you need to take rcu read lock here, why you use
> rcu_dereference_rtnl() instead of rcu_dereference() in
> netdev_dpll_pin()?

This is because I discovered the issue while working on net-next tree,
and basically had to fix the bug in net tree, I had to prune my WIP to
get to the fix.

You are right, the rcu_read_lock() is not really needed here.

