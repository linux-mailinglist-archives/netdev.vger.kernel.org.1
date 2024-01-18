Return-Path: <netdev+bounces-64148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE4831677
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2309828646B
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC21200DA;
	Thu, 18 Jan 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocGPD+nV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10462030E
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572501; cv=none; b=BPwCCvfN2dEfF7+/Rnwa9jP1eiorNOfOzDuAsEpO3df+bm71Vr4UiAcMLrfFQnKI4nukheMDOUu8tos+Rt4UuEF1diiA936JTiJld2EmiN1u5Rlx7bUjiP2bp5F9OriFpMnUqSss5kI3HaZ4LRGmNb5RZ/Z2XdspyqC2+7KH/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572501; c=relaxed/simple;
	bh=OHu6eTrt/JUl/pchOcrO1mb6f5C+2xrSrZ6sAdVoRZY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=fo+laPLjgjp47814gR6YMr6U7BFVqv+3pPF6ByV1HGSzlreJoRodrpHbyY5ZYUFKrLsgija1XMw6Axr/UUr9k66+ItQbf0EXVO8GBmRtPVVoI96e8nMqloQyXabA4XXvYA7n3HFVqfRF73hZ8pZQpXAnplOdZMIZnqRkrZBVN/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocGPD+nV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso5239a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705572494; x=1706177294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymalSlLO7RuhGoeHTMVtczq8xlUcreF5NbWPRyxCS+M=;
        b=ocGPD+nVYJb3cK93/JigpIX+oMcl7P1fqFgCK1vqioa9A4JBBm9NYm8VgamgukfDWx
         Rt9TMMsP8LxgXf3FEf3Miwueu9oUxC/cvs9JLjh9k3fGO5fu4kgMcW9AfKeSyce4ljyO
         sRILNGF2sllFrCsNYH17d0AjaTZrRIn15vzUjJCgCA2kJqLqs5kUpIJ9gojs8BAn3Jsv
         zFh4lPdyc2yfV+v+sJsjUQ6s8CNxgbqo3vYCOfq1cX5LYefU283HfyUw9S3creYalF83
         d19IRdM9IqnuSHpISNodJpDPv0UY/YbbMWu2uo9m/QFkJu0CTx7vG88iwKFwhn5mfds+
         6tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705572494; x=1706177294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymalSlLO7RuhGoeHTMVtczq8xlUcreF5NbWPRyxCS+M=;
        b=JyRjs8PuX/xGAU3440sHgCGXI6PJpVofFd6hNnZ0cGjfwSmT9MA+ur3Jld5BGsvQo/
         vnsv/uU9SYjOKMO1O904Dkox4B6BzDmdRJ0qxxVgJSt3ggjrF6rlhyKWq+NzaYik8i+5
         N/+31msqR21VvUei2U4IqL82StazS49Gx3me2mhSYoC+RUhe21rGl1mLNEUytInHb5uY
         srLZp2sDq5ebUxXx1awDSgnC0wfKPlfynWojFLAVme7+6ZzrJVxoAy5rnL9XbEhbcKKt
         ZcsWZ6VcgzBcdycvhj8aUS/kdNwgKejmNmlbEZzPJjykXlFn60YsV0ULGp52PpTady4O
         jSOg==
X-Gm-Message-State: AOJu0Yz8O24FBzXt/Q8rD4dL0c+EVuvmVr0BFLpyIjVbm1QCCNzcAgDh
	i9uQrEyOq3rcR5cBOrk1eFJ/j/7ovFg6zBIHPDQTPak/rAOi99jra+CbGIPf5WO5ScTcDr8gBiA
	n9vol0mPrDY69Jl4xCxXUqyCgs/zsSG55EIY0MtsunFm/vOcco+V4
X-Google-Smtp-Source: AGHT+IGf6TjF1knTceWqeSYWuns8hLf9EYZ8ejkscjXQO7Tbqq0QgCjAmTEnocpf+hlg4qk93S+sVec3KD3YtNVmlFY=
X-Received: by 2002:a05:6402:22d7:b0:557:15d:b784 with SMTP id
 dm23-20020a05640222d700b00557015db784mr40541edb.2.1705572493817; Thu, 18 Jan
 2024 02:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160030.140264-1-pablo@netfilter.org> <20240117160030.140264-15-pablo@netfilter.org>
In-Reply-To: <20240117160030.140264-15-pablo@netfilter.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 11:08:00 +0100
Message-ID: <CANn89iKtpVy1kSSuk_RSGN0R6L+roNJr81ED4+a2SZ2WKzGsng@mail.gmail.com>
Subject: Re: [PATCH net 14/14] netfilter: ipset: fix performance regression in
 swap operation
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:00=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> From: Jozsef Kadlecsik <kadlec@netfilter.org>
>
> The patch "netfilter: ipset: fix race condition between swap/destroy
> and kernel side add/del/test", commit 28628fa9 fixes a race condition.
> But the synchronize_rcu() added to the swap function unnecessarily slows
> it down: it can safely be moved to destroy and use call_rcu() instead.
> Thus we can get back the same performance and preventing the race conditi=
on
> at the same time.
>
> Fixes: 28628fa952fe ("netfilter: ipset: fix race condition between swap/d=
estroy and kernel side add/del/test")
> Link: https://lore.kernel.org/lkml/C0829B10-EAA6-4809-874E-E1E9C05A8D84@a=
utomattic.com/
> Reported-by: Ale Crismani <ale.crismani@automattic.com>
> Reported-by: David Wang <00107082@163.com
> Tested-by: Ale Crismani <ale.crismani@automattic.com>
> Tested-by: David Wang <00107082@163.com
> Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  include/linux/netfilter/ipset/ip_set.h |  2 ++
>  net/netfilter/ipset/ip_set_core.c      | 31 +++++++++++++++++++-------
>  2 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfi=
lter/ipset/ip_set.h
> index e8c350a3ade1..912f750d0bea 100644
> --- a/include/linux/netfilter/ipset/ip_set.h
> +++ b/include/linux/netfilter/ipset/ip_set.h
> @@ -242,6 +242,8 @@ extern void ip_set_type_unregister(struct ip_set_type=
 *set_type);
>
>  /* A generic IP set */
>  struct ip_set {
> +       /* For call_cru in destroy */
> +       struct rcu_head rcu;
>         /* The name of the set */
>         char name[IPSET_MAXNAMELEN];
>         /* Lock protecting the set data */
> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_s=
et_core.c
> index 4c133e06be1d..3bf9bb345809 100644
> --- a/net/netfilter/ipset/ip_set_core.c
> +++ b/net/netfilter/ipset/ip_set_core.c
> @@ -1182,6 +1182,14 @@ ip_set_destroy_set(struct ip_set *set)
>         kfree(set);
>  }
>
> +static void
> +ip_set_destroy_set_rcu(struct rcu_head *head)
> +{
> +       struct ip_set *set =3D container_of(head, struct ip_set, rcu);
> +
> +       ip_set_destroy_set(set);

Calling ip_set_destroy_set() from BH (rcu callbacks) is not working.

I think you should test your patch with LOCKDEP enabled, and/or
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy

