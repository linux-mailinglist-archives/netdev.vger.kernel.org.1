Return-Path: <netdev+bounces-173948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4281A5C794
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080523B2F59
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5E25DB0A;
	Tue, 11 Mar 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhsSbMWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5625E807
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707056; cv=none; b=NP5/UyG/ipwtUl/9cg16+pMLnD3aSl+Mpc/hn6nXG+7+bYQiiJ1mRSFoEuAVZM9jiMMdXfUkSTl7iuXVONK2181EYtnUSlP7EuejcEqJjdp7ZI0Z/0ZDfIBpbd0jdsHaSmwhQG28gwkcSZR+hathTDkADUK1lni+wUgLtlPskMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707056; c=relaxed/simple;
	bh=jLpO0aClIlGsNxrUNyVQiaXn8vjjrMvUwz4FprQTRoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM0LnHV7bB8ZG7XPQuZaf42zaLL9oUeZi65cxJ0JoUVmDKVKrcUtEgZ0t6MNsFT+NDcplkiRFfruwFVOjYS30BgoRN/HHjY/znFuyjyyvtrOv2CRjMwC7zXD/dsYwkt5y7Px68Jlp3NuTsbjk3vheTdSzFqTnPm0uHZeWGr+mbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhsSbMWT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225489a0ae6so155075ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741707054; x=1742311854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVGJAzXPVHMjqIFrjU+0+4wH31oMqsdQyLQzVc+pkY0=;
        b=FhsSbMWTjmF83KcDjUo2txL3WXmnBHlHWnUNNK+Vd36x5+QvdeNe6JUVzixtsjc27k
         g2VAOwxRtKQxImBCjGdDrDoC4HulyYD839Vh8nPy7yLXUgYXf3IovmDeZXh0Kj1/su6c
         nUD49p6lMAu0+4tWSyrzHKD/9H8GQn2Uo8xnYO7sp//CZlZiiInKLR04yFybV78SbjJJ
         01nCNl7u3HvQOaO5Qj6/wvvUQ4p+erg+CxziXUOr6OyYM8eGOKX2NRBeZ/goiP1nepSR
         sp2xNE6Dms7fucwiTDPR72BmBzhJQ2879rO+UpYCE5AJPVWBw+BmZnlkh1N9QyMdf7Xp
         qXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707054; x=1742311854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVGJAzXPVHMjqIFrjU+0+4wH31oMqsdQyLQzVc+pkY0=;
        b=td/4bqdlKX3FEI2XdQEzBOh00Hpts+gm7yyb9oIV2UBgoN6kp2glQ335FqMYoeYBDv
         GRpMshqgapbRD58RrCmahgtDyxQ1kxmDohL/dwZPA0ewAMQHsYlhxWsfuCS+oUorPIQh
         zTkaeBc1Hjacac3lFit4CWjzVMn1wepehnsFf3yf2DAFnwOsq6kxdqKppIqTbMTsL1A5
         dDj2aMZK8CR6Kp7mnjXHX7Eqpq5l5gQTEgUHvAD+VoHE0K0Xts9DnyY8BkZ/8M1Ibavu
         w4rcbIkkOv1bbDabFzE7DOGBj5NThHQIDLUyX11wjWYh0HWSVlEwvKP1Sb7S1sRwju/U
         FX1A==
X-Gm-Message-State: AOJu0YysG/yybY3KGb+oeg4EIxLhkPa8qWrnV6qy38wIufi9LT5MVEt8
	C70vMHd86coBg4xPEydTsd3XgkIBSNmAXqMEu3VJOh95vvlRh/d6HwQEMbaIYszhMKLOuoCqTTr
	Fx/5BkzdliX+TrLTLApPra0Wd8tobzr2M6Dx1
X-Gm-Gg: ASbGncskA8Kp2LcIcWWdB7YLRV83Jr3r0pMJvgjK4qvplRnRimVB0RKQTntHFyxebiI
	Etom2K5ZqnQIwZwRqtw6j2qNveC1ibCuTgokzo6gZU8vFB7i0RkZku9t32CBJEidCJt0CwGm7sa
	hUaA7mQBO/KFH6Ba+bpGWimRVjF+oGBZXT91sqi3KI8yn+hdjXULoaWJAW
X-Google-Smtp-Source: AGHT+IGYHJc/dR1cL3X3QNS0Lcow2KWr3zVva+Z830WG9yASnDR3fJuYHKDNLSUxaqcOEPiRmBNOmQ0iC1ARn/BdUfo=
X-Received: by 2002:a17:902:e801:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-225416231b2mr8512655ad.14.1741707054179; Tue, 11 Mar 2025
 08:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-3-sdf@fomichev.me>
In-Reply-To: <20250311144026.4154277-3-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 08:30:41 -0700
X-Gm-Features: AQ5f1JqD407vBMjqQOmrKFXb7bJs2U7gZbWGDMPZYCzlPxwlBJDa2J8QTmskVJQ
Message-ID: <CAHS8izNVZ0RqccDKGiL2h+MesCrvza_kwck0RmsrTNAcTkcmjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: add granular lock for the netdev
 netlink socket
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	donald.hunter@gmail.com, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com, 
	xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> As we move away from rtnl_lock for queue ops, introduce
> per-netdev_nl_sock lock.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  include/net/netdev_netlink.h | 1 +
>  net/core/netdev-genl.c       | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.h
> index 1599573d35c9..075962dbe743 100644
> --- a/include/net/netdev_netlink.h
> +++ b/include/net/netdev_netlink.h
> @@ -5,6 +5,7 @@
>  #include <linux/list.h>
>
>  struct netdev_nl_sock {
> +       struct mutex lock;
>         struct list_head bindings;
>  };
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a219be90c739..63e10717efc5 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>                 goto err_genlmsg_free;
>         }
>
> +       mutex_lock(&priv->lock);

You do not need to acquire this lock so early, no? AFAICT you only
need to lock around:

list_add(&binding->list, sock_binding_list);

Or is this to establish a locking order (sock_binding_list lock before
the netdev lock)?

--=20
Thanks,
Mina

