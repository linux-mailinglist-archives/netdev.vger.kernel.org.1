Return-Path: <netdev+bounces-99898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2E8D6EF8
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756D2284B6C
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6F913DDA2;
	Sat,  1 Jun 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTrfWa2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BF13D635
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717231595; cv=none; b=qyzVriWl8ssxTWJp3kITkuwTA2ymGNO5h2X0sLEuOw3qL6xx6KPzbpwu2/jXgnnBj20b1I5Gl1fMoV44r5ptXkGhQviqwWbVOqucAn9/8DC6dmOzHuWJ0W5OwHOxFa5ra5F2BrRuxYrh0u//RkJFkb5wvqavGaW91qxSGfmmItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717231595; c=relaxed/simple;
	bh=n39P43ilSKNrAL3vLU0xZC6c1odihG0/bwgLoJaJ2iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2nsXx8LjNjLjDZHtCCGij2yCW/81OXMxbDnIVJrR/GgeaYDHJKO0X7+V/+3qpS9wGxV2uSsCeKi5PvvGFA1Ml3o3CcrRpnoOMVTEptllkiuBuoEhnVBrnoZMbnOAM8hb38bZakTFcSPVhQWEIZjht/6q60CMCJIJeQGyDCszmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTrfWa2q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41fef5dda72so25415e9.1
        for <netdev@vger.kernel.org>; Sat, 01 Jun 2024 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717231591; x=1717836391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkCBwJFH3FQQjhEGVUSmMAPZxzATBED22vdUBPssCpo=;
        b=BTrfWa2qXiEnnSTagMvpJxdLxWXertmX+lgnjbPkpRdI1VJFf9zRpawk6NFhtcIXGV
         CzsLA/9nSccUt4UbktXZrhhyiNI8dHVA7O/HQiHIKKMl9ipKE5ujNCl6bWW+VoEi1np4
         HzaFoMgwgKHMbY4B4wYZsGIATcNFkBYuIHLkZi5CRskRudExzGqiw1hJRRNzhFfnSViV
         1xdi2H76l8jBBF+fN2r2tBlcOE/Qu7Vv3pxwbEGnRjB57OeUSTXwuDmzwLHRR+lyuYGr
         Ypbre2YEWeENeHXw0RQMuGmXl/7QyWHGB9QXf75l4wuP5TTEh8ohXNrwn/fLv8yqCQta
         yJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717231591; x=1717836391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkCBwJFH3FQQjhEGVUSmMAPZxzATBED22vdUBPssCpo=;
        b=F1b4KMUa1XjUEkhH8Gs7DXVbF+2pKG9SoLRbWnJLEHxxOyhl/EpaAfhNk0r8IQ7roJ
         5EQWOJfPT/mmK4dn2XlKDrxuqnqoXCYYwCKKLtZarxFOouc5fGYTzYHbW4Nay7GtT1ye
         6m9Sdx1go+/Tyg/yYdBPF402TloiyQYZHf8PfOxgiewn6S5qjt7vPekYN6r0tCeJcqJQ
         bwcQ0la2iX1ch0QMu5Y88AjCF/vVI3IZoj6WyqlmwVEH8kQvtC82vBGpQQUXJ+mv7bMc
         BxEKduEnKMA42smeVKNS5ph7uYbzuKFEI/BNf39CgnI5QHKjbayVUTm94nmMA4lHJTsA
         8BGA==
X-Forwarded-Encrypted: i=1; AJvYcCUsk6p/YlpfjmOChT2HDGsFUZCh9UF5ANlhnAQkzC8iMvZ2NpvbAUTsf56vHY4hS4nOx2k3q5w+nJtGNNS5cFa5WtK00XhV
X-Gm-Message-State: AOJu0YzNVJ35jk7dJx6CrJVfrxMqx4XIS+KnVeZVuv6rlLzKvkIVDhft
	yOrSZAlgYCZ1Gb9SSRMnZc2Sl87R37glCBX39YL1Ilh5ZbGCiBm7wu6OMGVbyzopkkLUrHHh5G6
	K3YIXxqFKvHzsAuphr86h1javUkuHGsOnPnzJn3nxPysIj6VLHh6N
X-Google-Smtp-Source: AGHT+IGqcSxJEUtmpYkzXz1v9dsUIixWDloYhRg4yMzs1O1FPjmhoX1qHONtxeNkzCEYdabvfw1JGy2vc4W7BCuX++8=
X-Received: by 2002:a05:600c:19c8:b0:41f:9dd0:7169 with SMTP id
 5b1f17b1804b1-42134ed2115mr1168505e9.2.1717231591043; Sat, 01 Jun 2024
 01:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529111844.13330-1-petrm@nvidia.com> <20240529111844.13330-3-petrm@nvidia.com>
In-Reply-To: <20240529111844.13330-3-petrm@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 1 Jun 2024 10:46:16 +0200
Message-ID: <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 1:21=E2=80=AFPM Petr Machata <petrm@nvidia.com> wro=
te:
>
> When calculating hashes for the purpose of multipath forwarding, both IPv=
4
> and IPv6 code currently fall back on flow_hash_from_keys(). That uses a
> randomly-generated seed. That's a fine choice by default, but unfortunate=
ly
> some deployments may need a tighter control over the seed used.
>
> In this patch, make the seed configurable by adding a new sysctl key,
> net.ipv4.fib_multipath_hash_seed to control the seed. This seed is used
> specifically for multipath forwarding and not for the other concerns that
> flow_hash_from_keys() is used for, such as queue selection. Expose the kn=
ob
> as sysctl because other such settings, such as headers to hash, are also
> handled that way. Like those, the multipath hash seed is a per-netns
> variable.
>
> Despite being placed in the net.ipv4 namespace, the multipath seed sysctl
> is used for both IPv4 and IPv6, similarly to e.g. a number of TCP
> variables.
>
...

> +       rtnl_lock();
> +       old =3D rcu_replace_pointer_rtnl(net->ipv4.sysctl_fib_multipath_h=
ash_seed,
> +                                      mphs);
> +       rtnl_unlock();
> +

In case you keep RCU for the next version, please do not use rtnl_lock() he=
re.

A simple xchg() will work just fine.

old =3D xchg((__force struct struct sysctl_fib_multipath_hash_seed
**)&net->ipv4.sysctl_fib_multipath_hash_seed,
                 mphs);

