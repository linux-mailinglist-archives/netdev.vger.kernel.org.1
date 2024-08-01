Return-Path: <netdev+bounces-115053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD07944FC3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA621C23049
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5801B3748;
	Thu,  1 Aug 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8ijgI0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381E1B32A1
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527882; cv=none; b=b01Bb4DiZSLFWlut+INcPh7G2eZK3nh0CpnIDXyH81a8wwAnyOn1niZLyrOruSQDS4294CY/FaSnKSxnRs7rxpqmYUMQmOPpFeXdSyt5H1jlhsQp7bGOORMHOestfwyVPOMa6dbtqqEzMxeFLpjZyCt0hvBIliW1RhzB6UFdB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527882; c=relaxed/simple;
	bh=Cvstk7F2uvlc6hL0SiXZQhxILYKS0JlnWvLz+0p3zVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7laA0zDCT00OZ4t5r10qJb3rn/kdoS2XZfvAyygOpnYFlGfHvvvaf0I6S5+AUJN+lqJeFR91Yw7aOAUgKzUuybCzgpLGYKPIS+9gHBPcQ7BmKDEfC9k/fMvvwbb5Irog1/kHumH7QNReUpj3d+uIvWSWqcBqQB+RSRjnFOgrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8ijgI0p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso36387a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722527879; x=1723132679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHxjN+E4oNxKN907sm5yblx4tgbRX6J8lcP97jp92Xg=;
        b=C8ijgI0pFFSXdKE4yxsutcxeybbbCjCHFCT3tT86J1L3kV0o38sr+Drlxe9APD6RAq
         DVVPPtCoU3dB/cX78MPc8VGBLgbeWaAuIJXq0poI9oMyXzOBt8jesxz618yYnN+9Lh6W
         6O5e87JCdk+Fn7KXjIMPAiSMR29dtvBU06G5GoOJ4ABrf0ua7nAc6n7b9Z9FHmdM3Ej/
         Zk+/4BQgNKEXi6nfanEdgLzHTSEitG99Gnu3q39o6OGD/rbAHwjs/cH23fOIADLVqpbv
         xVpjrgAqYlap9snMqD7xY0F56GMWo1jVYhT7CeMLVPiP0QTXJ5IK69OH8bf+aOwDumk9
         jJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527879; x=1723132679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHxjN+E4oNxKN907sm5yblx4tgbRX6J8lcP97jp92Xg=;
        b=APwfcBWjowkiMk3wOxJUUZgd0fQdxSBBYHRVXKowIE/rzr1VTPxiAaKcxn54qOxnsx
         fWyaaT6VdHXE5/eIIuFFgICHks99TWk9H51eo/7VsDUV/dOIxx5qR+LH5zGKQN8OQuxC
         ahd1KwSfx7D/yrk5+1vbkUerC2YeOuNmgYYqL8UxgNcUO7rjr5yizVR5NTLIXZQL92c0
         CV+O12ctJ3Bi7KHMABTtN1mbL4kcPCKPeOxD6RYsbwJTIXX/sxYIG7L+EHJMcy87vkql
         eNxy6gg8PmbEEWE/PSS3bYF4Q3+gGwLkRf93yQzlzXEJg1Kg168eonTzAumWmNMlbF3Q
         Z3lA==
X-Gm-Message-State: AOJu0YyAZsQECP/Nr+U2YbcYblNpVwxVeZvvtA9KMJ1bKWS+KZoB67s0
	dvbL9Bd2MTdUpgBq1iYHqJE0EIGyxmIDm8Pov8iLDqzkDlRCGilwsCEL/nJ16jXj42k6kY2cLQQ
	ggqc3JXCT0BgAVDyAk0wjyNiaO5KTxQ2rQBtnmRU309ypEITAHjkn
X-Google-Smtp-Source: AGHT+IGb3cEVCCOcwU7t65ZSCzF/6uAuCXwm3gmXrr2qdBigIcSXGh55l4A4a97NjPTnTsXBU26s7wZDsNSsmX1X8k8=
X-Received: by 2002:a05:6402:26d3:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5b719a5e115mr153175a12.2.1722527878368; Thu, 01 Aug 2024
 08:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801152704.24279-1-jchapman@katalix.com>
In-Reply-To: <20240801152704.24279-1-jchapman@katalix.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 17:57:44 +0200
Message-ID: <CANn89iJkFh4JmNO2gM-4c6sbqgdjFzdNZUc-b6jupTMpUaC1mQ@mail.gmail.com>
Subject: Re: RFC: l2tp: how to fix nested socket lockdep splat
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, jakub@cloudflare.com, 
	tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 5:27=E2=80=AFPM James Chapman <jchapman@katalix.com>=
 wrote:
>
> When l2tp tunnels use a socket provided by userspace, we can hit lockdep =
splats like the below when data is transmitted through another (unrelated) =
userspace socket which then gets routed over l2tp.
>
> This issue was previously discussed here: https://lore.kernel.org/netdev/=
87sfialu2n.fsf@cloudflare.com/
>
> Is it reasonable to disable lockdep tracking of l2tp userspace tunnel soc=
kets? Is there a better solution?
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index e22e2a45c925..ab7be05da7d4 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1736,6 +1736,16 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunne=
l, struct net *net,
>         }
>
>         sk->sk_allocation =3D GFP_ATOMIC;
> +
> +       /* If the tunnel socket is a userspace socket, disable lockdep
> +        * validation on the tunnel socket to avoid lockdep splats caused=
 by
> +        * nested socket calls on the same lockdep socket class. This can
> +        * happen when data from a user socket is routed over l2tp, which=
 uses
> +        * another userspace socket.
> +        */
> +       if (tunnel->fd >=3D 0)
> +               lockdep_set_novalidate_class(&sk->sk_lock.slock);
> +


I would rather use

// Must be different than SINGLE_DEPTH_NESTING
#define L2TP_DEPTH_NESTED 2

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 5d2068b6c77859c0e2e3166afd8e2e1e32512445..4d747a0cf30c645e51c27e531d2=
3db682259155f
100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1171,7 +1171,7 @@ static int l2tp_xmit_core(struct l2tp_session
*session, struct sk_buff *skb, uns
        IPCB(skb)->flags &=3D ~(IPSKB_XFRM_TUNNEL_SIZE |
IPSKB_XFRM_TRANSFORMED | IPSKB_REROUTED);
        nf_reset_ct(skb);

-       bh_lock_sock_nested(sk);
+       spin_lock_nested(&sk->sk_lock.slock, L2TP_DEPTH_NESTING);
        if (sock_owned_by_user(sk)) {
                kfree_skb(skb);
                ret =3D NET_XMIT_DROP;

