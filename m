Return-Path: <netdev+bounces-165107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44524A3076F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010CE3A1E8D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F81F1528;
	Tue, 11 Feb 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6iQA2g0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641C1E5B7B
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267026; cv=none; b=D4HEXzAT8ctorg6oCpX/GXKh4q9UgnzDj9I1DQ5/jXWXT3GEn5CiL3591klNm4kd1fxpiQo9N0HOQQMLndVzLnl8PK3Pe3xBMRYspQnaqrb4SXw4zZrrFHym3hs2wMF04UJDDCrDxvalr0bxmMMHseEaLDueSMRJ3mUbCP2RYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267026; c=relaxed/simple;
	bh=vk4W20xbpGweFTXRSKs81HFikUaTomCTDkaX3vPBPOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohDHavGurmKBkLjT28nPNXokEcbC3OaF2baAIL6LqddP7R3EYsRvi2wrKNdlYANyeZFYUDf2O2/RFifYCSy9Myv0ojLPibYpGFBadcRC6S3amTAyFVitlemHf/KRUC5Vlqeq+Vsyw0JEmYutUHmEVEKQFduUNGWhWz00ATddE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6iQA2g0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so8607292a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739267022; x=1739871822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snrAbmeFxwrUyNPCEQkRjQMxWlnokRgrS39qm/uZYHg=;
        b=m6iQA2g0az+++hwtkGh1FQ3R3D4COsJkQucmRSACMYLum2dvu8r3TuxyOo/MpVZN9F
         2ZZTXChYI0HXXtJnVno8J3aL5FoUukAbhUa9mUhtRa0j5jwYWPb077kW7cgIWmPIUdOq
         3CEkBWz1p0Y+QuNxoQ6rLlPCEiEp52rn9beq9YF2x7SG1ggx8a73mBsi47deB12vtqnR
         9fuKevuvmBaUY4hXkYYClJwd983H9zfX2Hz5fUON60i45/4Sc04fV5/z2U9bcxz87C9P
         6yA65C1+QXEMZI+ZR/B6U+1684PzIADUsB0KNEb6gcF6bZTu1YrL3o62jDeBVkSBBrZM
         iYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739267022; x=1739871822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snrAbmeFxwrUyNPCEQkRjQMxWlnokRgrS39qm/uZYHg=;
        b=F/lLp9xT+fdVNjwHAtAMm+vk6mWPZjclETLk+Zkqf8Y5G5ur6OFjdeDpih87ntBW6c
         50DWiGRkHsUTLzN24QejyPzChltRa80RQf73Jgcvtr4kIkvrNjhwuk2u9cDGT9/CP1fn
         veMXkMZOjXeyVYksMMcoXGMwnuZJylrnc9OWK5iND/HQlEy5os7RHmXKmPbnIaEJv3gz
         S9MKHjR+s5uoOl8OCVHaX+5o/eZoCDVwDCtjFxBHxmiaWuYTV6cVYgf7cJESKz1fX84R
         9yXPASYF2yjncjyS9pXzHjFK/z7NqsKaF4tgo/NQ1+Ka5zJAvA9Q1ntMRjRtGLATIltW
         rCYg==
X-Forwarded-Encrypted: i=1; AJvYcCVPvb/oQWPTbjN4HcN9PHUAV88A5k8WwUD4FHnGIk1qx2EOC+CR8hKzgFYRsOzS/aSFhLIEuxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzue7IRH46mDrx/eNq9B2ki38rh/CcFBaIkJjPG+FAhZOUdnTmf
	PpdxlVFSrjLI8bDiL+4fVpwJeO/C9+sXkNsPDv8fMzJrEn5Q5llvkD3PmFjo2C9zYhY9h1gfbVt
	7An/lBrS70hF0zSC6PfymepeOHmZyrATuCvEv
X-Gm-Gg: ASbGncv5G3vyPmBJOaXqNpeuFQOj2IFAOZh3TRmpuKh1auSDQgf9Z424+rz2by3hgTz
	+tZgPmeJqmKLI/IPQmgcW+/6aCWRuTE0hotCYVZYASpnsdwkwG1ZdfAWrWuH6i5+ZtJbFyGA=
X-Google-Smtp-Source: AGHT+IGledyecWfOD/F91C1rRW2S52F0qOcrXK+ArJwBlZxIsPMAeidkBERyYOBqb4IFko5hl9sJkEfSstrxix/Lsso=
X-Received: by 2002:a05:6402:1ecf:b0:5dc:796f:fc86 with SMTP id
 4fb4d7f45d1cf-5de4501880amr47156858a12.16.1739267022283; Tue, 11 Feb 2025
 01:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211051217.12613-1-kuniyu@amazon.com> <20250211051217.12613-2-kuniyu@amazon.com>
In-Reply-To: <20250211051217.12613-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 10:43:30 +0100
X-Gm-Features: AWEUYZmdLJxSYafxD3V_AxBVlesvXrVwHxk5U_REm6WNLUwC0pBUERSGsBC82Lc
Message-ID: <CANn89i+oUCt2VGvrbrweniTendZFEh+nwS=uonc004-aPkWy-Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Yael Chemla <ychemla@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:13=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> After the cited commit, dev_net(dev) is fetched before holding RTNL
> and passed to __unregister_netdevice_notifier_net().
>
> However, dev_net(dev) might be different after holding RTNL.
>
> In the reported case [0], while removing a VF device, its netns was
> being dismantled and the VF was moved to init_net.
>
> So the following sequence is basically illegal when dev was fetched
> without lookup:
>
>   net =3D dev_net(dev);
>   rtnl_net_lock(net);
>
> Let's use a new helper rtnl_net_dev_lock() to fix the race.
>
> It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
> dev_net_rcu(dev) is changed after rtnl_net_lock().
>
>

> Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevic=
e_notifier_dev_net().")
> Reported-by: Yael Chemla <ychemla@nvidia.com>
> Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09b=
c3@nvidia.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v3:
>   * Bump net->passive instead of maybe_get_net()
>   * Remove msleep(1) loop
>   * Use rcu_access_pointer() instead of rcu_read_lock().
>
> v2:
>   * Use dev_net_rcu().
>   * Use msleep(1) instead of cond_resched() after maybe_get_net()
>   * Remove cond_resched() after net_eq() check
>
> v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.c=
om/
> ---
>  net/core/dev.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 55e356a68db6..1248fb368e78 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2070,6 +2070,35 @@ static void __move_netdevice_notifier_net(struct n=
et *src_net,
>         __register_netdevice_notifier_net(dst_net, nb, true);
>  }
>
> +static void rtnl_net_dev_lock(struct net_device *dev)
> +{
> +       struct net *net;
> +

#ifdef CONFIG_NET_NS
> +again:
#endif

> +       /* netns might be being dismantled. */
> +       rcu_read_lock();
> +       net =3D dev_net_rcu(dev);
> +       refcount_inc(&net->passive);
> +       rcu_read_unlock();
> +
> +       rtnl_net_lock(net);
> +

#ifdef CONFIG_NET_NS

> +       /* dev might have been moved to another netns. */
> +       if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> +               rtnl_net_unlock(net);
> +               net_drop_ns(net);
> +               goto again;
> +       }

#endif

Or perhaps not use net_drop_ns() and rename/export net_free() to
net_passive_dec() ?


diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 7ba1402ca7796663bed3373b1a0c6a0249cd1599..62d1a1c39547bd5cca71082b817=
2d453b56a96db
100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -297,7 +297,7 @@ static inline int check_net(const struct net *net)
 }

 void net_drop_ns(void *);
-
+void net_passive_dec(struct net *net);
 #else

 static inline struct net *get_net(struct net *net)
@@ -326,6 +326,11 @@ static inline int check_net(const struct net *net)
 }

 #define net_drop_ns NULL
+static inline void net_passive_dec(struct net *net)
+{
+       refcount_dec(&net->passive);
+}
+
 #endif

 /* Returns true if the netns initialization is completed successfully */
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index cb39a12b2f8295c605f08b5589932932150a1644..4303f2a4926243e2c0ff0c03873=
83cd8e0658019
100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -464,7 +464,7 @@ static void net_complete_free(void)

 }

-static void net_free(struct net *net)
+void net_passive_dec(struct net *net)
 {
        if (refcount_dec_and_test(&net->passive)) {
                kfree(rcu_access_pointer(net->gen));
@@ -482,7 +482,7 @@ void net_drop_ns(void *p)
        struct net *net =3D (struct net *)p;

        if (net)
-               net_free(net);
+               net_passive_dec(net);
 }

 struct net *copy_net_ns(unsigned long flags,
@@ -523,7 +523,7 @@ struct net *copy_net_ns(unsigned long flags,
                key_remove_domain(net->key_domain);
 #endif
                put_user_ns(user_ns);
-               net_free(net);
+               net_passive_dec(net);
 dec_ucounts:
                dec_net_namespaces(ucounts);
                return ERR_PTR(rv);
@@ -672,7 +672,7 @@ static void cleanup_net(struct work_struct *work)
                key_remove_domain(net->key_domain);
 #endif
                put_user_ns(net->user_ns);
-               net_free(net);
+               net_passive_dec(net);
        }
        cleanup_net_task =3D NULL;
 }

