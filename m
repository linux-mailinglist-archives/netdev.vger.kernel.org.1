Return-Path: <netdev+bounces-134216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E4E99870B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E052832DD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6941C68B2;
	Thu, 10 Oct 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vgZCHjW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25A2F50
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565376; cv=none; b=AIpsGn8wfAIhAhlegdncuHkwS6aMEi6TAXPr2mg9L5ds8eUMhqkVIA2/hKulzrdfCtEnJLwMmcJohyIEFDXrJf2hZOJXVEDYcND79l8vLUqUvmp2VrKl/i6isRt9dIgIWxI6jOMyPxmDQcAee58pm1doYtygChq8Uspjc+DjTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565376; c=relaxed/simple;
	bh=rv0rrKU7gRyk0NKO0JeA5O2RCxMlG6f7vqoV0WABbQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUTAVHd/T7diO3xJqGd7EkpeNhXIpc+IkhEA3Fo0JY511Cv3VTIBpCBpuFTzFBJ/Q9oczaqdfPf1gAVSt9lBVlPXha6bz6SuI1d+Sq+0rjIkrZL61fZD8mJ7sNrvuZ6ou+XxGQ6Jo1HEw4qtJlRJtxkQxZxUUC+h9ulRUOmExgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vgZCHjW3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a991fedbd04so70358366b.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728565373; x=1729170173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuZHbMJGzxfmzZttOcjargHQO70ppsXalSwJ+3RsVdk=;
        b=vgZCHjW3+afHF8pZnHUDzJ//vgNlc1+peed+HgSif4n5WbQyf2qwz1CnrHhQ9UjNKU
         78FdiKl2vtmd58W40sPS6T5sfKuNHL7QOF5SboZw9N4G0iPtQJe04O/m2PqVkFreq2w/
         0/lS7i7FzwMAiqSIs8HMW4UL/cdD919DnA7YxQ9iL1OwGsHCOqp0jrZQrhFca+9AEwd8
         xhPODR1cruPJ9Hdyb1hpeozn62CGGwjIO66GDzwyuMsJ8qTbbwo06xllrmVVaOXCr7XZ
         mZXTIM80o6sOotKUjo7ovuf2YsiHf56ntLvgdbnqluP44cRmAu0mLapnMcJVDrzO69CR
         Poxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565373; x=1729170173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuZHbMJGzxfmzZttOcjargHQO70ppsXalSwJ+3RsVdk=;
        b=ilLbV2NxrLoowEM6FEiSfMBGhK9CPkX9LJGsg35HwZ9iDuCYbertNfH68qG5xH2k05
         4xsF3eDJnHHeyxAXerauF/R7u1CXxkJiLPc8lgXJCJEMDI2ZRCf+qZ1WlmSUWY8itmxQ
         TqXZ0TMgz759OnwfTkgKIb+0ztySGlWZZBDUB4bjqWtfHTZZjuauQSrIgieMawCypnmo
         6IbKv3OYNqiSF2VH/NpnLs8PhqRLXP/tiF/i+sxErdHXdUZV6wFBMvK6olHVAv08RF+/
         nEHfVdQ9jR9skYjVbywmEiXdbEknaoR0JYInAUNolf+wex2too96Y7ww49oWMFfvjO5m
         P4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU49fSbmLsjl7RjRcsJIEhcnc9CYM8JbTCYpqYHIxWIEdM4TZbXB7hqB8d811db7d2TYtqoK9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZwbMuYHJfdoX88405K0Ltn7buxzEKyphJXx0cliS0U+PL4ca
	PjG7zjYJwhGMks32eNgoAfDRexAuVbGMjhJDaqMB81qVSpc3gxR/eXsxUTnuLPa/coQ1jd33l9m
	6yPTtZMS/ZR9V9loUOSuHI5DunW9jSQ8CE7Dg
X-Google-Smtp-Source: AGHT+IGFQQc5oYWog6GF/4Aqi9c97rwGqSluzEXuYlD9+7pvPURResYuoN2wtxXTHjdqdvWnt7vXVuJz+Ms/scF+LGk=
X-Received: by 2002:a05:6402:34c5:b0:5c9:137b:b81b with SMTP id
 4fb4d7f45d1cf-5c91d6244eamr6334924a12.25.1728565370716; Thu, 10 Oct 2024
 06:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-8-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:02:39 +0200
Message-ID: <CANn89iJU=JcaKqfdARq9aNC+QMoG8B-RjfgqfufYvA_74v6TsA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 07/13] rtnetlink: Protect struct rtnl_link_ops
 with SRCU.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:19=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Once RTNL is replaced with rtnl_net_lock(), we need a mechanism to
> guarantee that rtnl_link_ops is alive during inflight RTM_NEWLINK
> even when its module is being unloaded.
>
> Let's use SRCU to protect rtnl_link_ops.
>
> rtnl_link_ops_get() now iterates link_ops under RCU and returns
> SRCU-protected ops pointer.  The caller must call rtnl_link_ops_put()
> to release the pointer after the use.
>
> Also, __rtnl_link_unregister() unlinks the ops first and calls
> synchronize_srcu() to wait for inflight RTM_NEWLINK requests to
> complete.
>
> Note that link_ops needs to be protected by its dedicated lock
> when RTNL is removed.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/rtnetlink.h |  5 ++-
>  net/core/rtnetlink.c    | 78 +++++++++++++++++++++++++++++------------
>  2 files changed, 60 insertions(+), 23 deletions(-)
>
> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> index b45d57b5968a..c873fd6193ed 100644
> --- a/include/net/rtnetlink.h
> +++ b/include/net/rtnetlink.h
> @@ -3,6 +3,7 @@
>  #define __NET_RTNETLINK_H
>
>  #include <linux/rtnetlink.h>
> +#include <linux/srcu.h>
>  #include <net/netlink.h>
>
>  typedef int (*rtnl_doit_func)(struct sk_buff *, struct nlmsghdr *,
> @@ -47,7 +48,8 @@ static inline int rtnl_msg_family(const struct nlmsghdr=
 *nlh)
>  /**
>   *     struct rtnl_link_ops - rtnetlink link operations
>   *
> - *     @list: Used internally
> + *     @list: Used internally, protected by RTNL and SRCU
> + *     @srcu: Used internally
>   *     @kind: Identifier
>   *     @netns_refund: Physical device, move to init_net on netns exit
>   *     @maxtype: Highest device specific netlink attribute number
> @@ -78,6 +80,7 @@ static inline int rtnl_msg_family(const struct nlmsghdr=
 *nlh)
>   */
>  struct rtnl_link_ops {
>         struct list_head        list;
> +       struct srcu_struct      srcu;
>
>         const char              *kind;
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 24545c5b7e48..7f464554d881 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -456,15 +456,29 @@ EXPORT_SYMBOL_GPL(rtnl_unregister_all);
>
>  static LIST_HEAD(link_ops);
>
> -static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
> +static struct rtnl_link_ops *rtnl_link_ops_get(const char *kind, int *sr=
cu_index)
>  {
> -       const struct rtnl_link_ops *ops;
> +       struct rtnl_link_ops *ops;
>
> -       list_for_each_entry(ops, &link_ops, list) {
> -               if (!strcmp(ops->kind, kind))
> -                       return ops;
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(ops, &link_ops, list) {
> +               if (!strcmp(ops->kind, kind)) {
> +                       *srcu_index =3D srcu_read_lock(&ops->srcu);
> +                       goto unlock;
> +               }
>         }
> -       return NULL;
> +
> +       ops =3D NULL;
> +unlock:
> +       rcu_read_unlock();
> +
> +       return ops;
> +}
> +
> +static void rtnl_link_ops_put(struct rtnl_link_ops *ops, int srcu_index)
> +{
> +       srcu_read_unlock(&ops->srcu, srcu_index);
>  }
>
>  /**
> @@ -479,8 +493,15 @@ static const struct rtnl_link_ops *rtnl_link_ops_get=
(const char *kind)
>   */
>  int __rtnl_link_register(struct rtnl_link_ops *ops)
>  {
> -       if (rtnl_link_ops_get(ops->kind))
> -               return -EEXIST;
> +       struct rtnl_link_ops *tmp;
> +
> +       /* When RTNL is removed, add lock for link_ops. */
> +       ASSERT_RTNL();
> +
> +       list_for_each_entry(tmp, &link_ops, list) {
> +               if (!strcmp(ops->kind, tmp->kind))
> +                       return -EEXIST;
> +       }
>
>         /* The check for alloc/setup is here because if ops
>          * does not have that filled up, it is not possible
> @@ -490,7 +511,9 @@ int __rtnl_link_register(struct rtnl_link_ops *ops)
>         if ((ops->alloc || ops->setup) && !ops->dellink)
>                 ops->dellink =3D unregister_netdevice_queue;
>
> -       list_add_tail(&ops->list, &link_ops);
> +       init_srcu_struct(&ops->srcu);

init_srcu_struct() could fail.

> +       list_add_tail_rcu(&ops->list, &link_ops);
> +
>         return 0;

