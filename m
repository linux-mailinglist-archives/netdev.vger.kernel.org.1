Return-Path: <netdev+bounces-227182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4EBA9974
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A2C3A972D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ECC2FBDE7;
	Mon, 29 Sep 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2MgX+tN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229283054D6
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156342; cv=none; b=EodhBF6qEhsnTOzH6uRJKL2YXVKFMLbJJhr8iNhEeVG6y0OuDhTXYaqVGaVnXESHTeiGe0bzunuVqcKU+ej6xZZTvixdWa1mZQ3zFSldOdqE7NiGmXQbkrCDMvDEIU9WKUi3AOdWWG9+Uxpi22hUg/6nK8vGX4hEfIlCjZl3/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156342; c=relaxed/simple;
	bh=gfGffWboEZhuzcqBWe5ObMHfPdoPukvyrQN35ZuZEBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2QIYx3/qqncXTgy8l5ZIX7+e7BRWXlyDZ/VLjWSucxL6bijiy8QKEeSArS6iKqjS3eUTB00JBsjTQ6TmU7iyDw2JwGKSn0ACPjDf0+v+ihkZqLkh/9mj8Jbmeu7ue1UXxEoZA87+oS/IYLxtRNOOtPVlzKKzvxr84DjUbA64cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2MgX+tN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4da37f6e64cso40235121cf.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759156339; x=1759761139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5/27Ug010rXHK5Myi5mlYNuf30pTVfukgvY3Ag/aqQ=;
        b=d2MgX+tNetH/YDOGzKobPH5P+ac/NQ/r7FRSp16BVnp377+VnKiqI29fbDuwe/TljF
         /wbc0DjQjsgkvK2NEryzwzSiXQyzRgMKYwLO5Uj3JPJ3pbVyRl7mAKFqisNYuGN+kwCE
         TUel8p9ssfdN3mJ2zeFpyJ2Te1J7AxYJymsqhtZsfcfAVK5Jj/8gJ6Gm1/gAARWoCkIw
         fS7s+pwkmmVLP8jl4LljPDRAhPNSPIggiaaQh6JN4jdx00Npxp3J3cb4lmWZ2ZF2Yv+R
         R4jtZsBqyXbZkA8PPcGEBI0hIfmt3qBO8bPsZ1k7Kl8Q1k93aY1M0AQs5fDjfe3PkwNG
         drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759156339; x=1759761139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5/27Ug010rXHK5Myi5mlYNuf30pTVfukgvY3Ag/aqQ=;
        b=eD2Ke/oNqXbYyiVID9iwr5PlmZ4HnZVfbPGj0lxAzX88fS0mjLkb4+lellGWQ6JIwt
         Wv6k5U8hj8vwJ60OSIDaikAejZ+RAe5YUBpYHT9wwV6w+sQ7VQ/eqPUoXd25boOEIjUC
         XydxWmNsNf40Qf2X5/2PHSybPBwvVbYM8WG4s22yK26FHmBt9acMRWfoD650gzsdKxoS
         QH+EzqJL1eYndAwUdL9LY05NBDHm0gExFTWOvHLabksQVjAjwnmSZ7qu1Dcrf3/mSR6N
         92HZ1Sx26+QIT4FCuCiajXcqbCvkX24E4/OCyb72CXEOTNfvZ26cyVS5qwf02siSp+iS
         myGA==
X-Forwarded-Encrypted: i=1; AJvYcCVBABOIls+4F00WrH91yn3F5Q5HOx3YExjqQPK6bn5AbR9jMQe4UazLJ2VAw3OHeVt88RkYGNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpekuE67VQS1D4NbxFc27midUvcYtwa0dghj1T3Mtll9OzKje
	trSzfzwn1CfTRFyxuW4N2hUiQcYaI1OuwfZgJ1rcsgur2cp7y3eTM7SPZGmwqkh6JGTD2J3RLKc
	jdOcDo5/ep4EUFjMxOjpVP/J08DH3D1kX2MU+NvAl
X-Gm-Gg: ASbGncvo8YNIoWZqbJop4DkZrZ4A8htTbKIdLlUXh21AKx/Kw99WPxye6oHrZTz31df
	jl1L6t7VFvZ9j4e7AQ/E7homtxGkWnGIxeDTWwn25B4Bzmez3l/bKs5kVGK31uLeWOsjHzc2+rx
	Ukr64Q/gb4gVds6OwytZJBOvBawCKw0HYGDm0d5C9+z+1QyCpvQT1uj2uxOHv/HPMSQ7kg2JbgJ
	BAPV3DPPffwOfYSB0UMY6HX
X-Google-Smtp-Source: AGHT+IHjRgl4bZ6aU9dLDIycnuSdKC7t/XPPqg7lvhB2P2ClA4ugOGjDah0tDXCD9TNQUtTIheJs3NP9CHcoD7kkQRM=
X-Received: by 2002:a05:622a:8c03:b0:4df:1196:f56f with SMTP id
 d75a77b69052e-4df1196f9c2mr88938811cf.83.1759156338280; Mon, 29 Sep 2025
 07:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929140839.79427-1-edumazet@google.com> <aNqXETgt9pHIsnvx@horms.kernel.org>
In-Reply-To: <aNqXETgt9pHIsnvx@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Sep 2025 07:32:06 -0700
X-Gm-Features: AS18NWCKMmDkX42Nmjr7lMgGRAabr_LZLhO0bOvaG2tUY9zA3taZmcQrqTOWICI
Message-ID: <CANn89i+iwkUXQcpw+Uq3PLrz19r8QdO1Mf-9BKE=S3++MqV6Xg@mail.gmail.com>
Subject: Re: [PATCH net-next] Revert "net: group sk_backlog and sk_receive_queue"
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	kernel test robot <oliver.sang@intel.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 7:26=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Sep 29, 2025 at 02:08:39PM +0000, Eric Dumazet wrote:
> > This reverts commit 4effb335b5dab08cb6e2c38d038910f8b527cfc9.
> >
> > This was a benefit for UDP flood case, which was later greatly improved
> > with commits 6471658dc66c ("udp: use skb_attempt_defer_free()")
> > and b650bf0977d3 ("udp: remove busylock and add per NUMA queues").
> >
> > Apparently blamed commit added a regression for RAW sockets, possibly
> > because they do not use the dual RX queue strategy that UDP has.
> >
> > sock_queue_rcv_skb_reason() and RAW recvmsg() compete for sk_receive_bu=
f
> > and sk_rmem_alloc changes, and them being in the same
> > cache line reduce performance.
> >
> > Fixes: 4effb335b5da ("net: group sk_backlog and sk_receive_queue")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202509281326.f605b4eb-lkp@intel.=
com
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/sock.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Sorry Eric, but it looks like you forgot your SoB.

Right, somehow I always get "git revert" wrong :)

