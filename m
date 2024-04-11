Return-Path: <netdev+bounces-87160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10048A1F47
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8530DB27E32
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AFF205E06;
	Thu, 11 Apr 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDxPxtzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41E205E27
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860982; cv=none; b=Tet96JmDy6mJdII48SyTpDwxBEXDHqk63/XAQ0iTEfV4tudm4/7XD+Y7+f9yzTeEjfTNpu4bCPRZse96nMbDatC8tynrkx0cjT85yLz/kcgSAyuelXH/IbCs5S2l7psxS8i/Wjp5zuWr/9Z9K91tlAkclnM8ghBzrDSP6471lw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860982; c=relaxed/simple;
	bh=ArIABd9BX+7PFdbepq2utekmsL42kvVLqFs2aNsK2pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1vJS0UetOy/0BibXp8oiT8KRIknsz437IAuDm5Ivg2SBlat0KFtk7e8G6WwmNTgKv2UtjqhnVSXYp6lsQ4oTl5s60CR1LBJ+YPamjWflpgbFxxot0N28WvJwmMGnDixCKC7I98khJ+RltABHjykqeEqNJ2oDU5qiUv3ypQaQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDxPxtzO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so2510a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712860979; x=1713465779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT0vQu6xinY4dZbH6WLGjdM2WJ42dXv/5AMUZHNaulo=;
        b=IDxPxtzOpJBzjes4f7ZBhd0Fl+zH0EweC+IXd+Tq//KCj188DiVB6D0POBpm8frG/W
         8Z0X673ZDZ017essnF6Ovupj2gw3gk2+1Mh9YpiKVp7J/8utfsfxk9aOT6pUt33Sxj6E
         Hv64vOUcR391t6l0pglqfwQA299M+PHYk4/kwmrHYZAzepJHV+xdk9DXzIHNtW0CuVHn
         NZuo3Nfk3GDybrNlkb93ehnzRIVZ2EeL51NTuzrhMUPsZXzaQm/L6uvDew0NVDRg5Rll
         LBMufo6v63mNRFGf/KxUkNtH3jj+DgIvuVrGfSVPcc7xKoSPBt/6S4DxBDNcPtwbB6Ao
         +oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712860979; x=1713465779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT0vQu6xinY4dZbH6WLGjdM2WJ42dXv/5AMUZHNaulo=;
        b=KSKHuE1FmND1QNgJnL0KBsrDqgqbEYoTvmLedgdPQEtD6BHw9oL1UgMVUt1cdCcOkD
         3wSwI2qTrmJWRRLdYNjgUSZbhvtGD8jsAvgCWehxthUVNea2Iob7GNVw7+L+iobXeVeT
         0mbx/QlIsVIovFcM9KgSH+pM2UMeb9bG+kiBGbgk6/PQjAZEL6EANeVfBApHXOrtiU/9
         HZhyYwJjiYBfl7xMVI5kKmEQrEEXDyfX7ALIesN8we5u4fbveB6mhuqvoZa+rAusWS9F
         rt04uL8AS6yOG7Zwvktt0Cc+uLwb4/fdM/4jtYkh8LbkadoUZanpkLciULuHi5LfqdbO
         eUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8LJmF30Lah2LRq1Jk0ZXBzDKwGlzGSncWIYJWnFcBrHqWkoe8ePY7Y8bI3YzEap8DOOzb4q3RSrC9PF/jPWGymdn3Qztr
X-Gm-Message-State: AOJu0YzU/UtjDA0xFuhGFsOePxr/pWoG8A+4NV8Vxz9vyVVnZaXC14ps
	7DNXmBvNKFhpC/rYe62q3HJtqpITCo9JrXimfwgzQAc+QP+WdReRqDKWWthLT2aEK4x+mWTmmTy
	znl9xQt2tc8J/tyWjojGHRrliFjbbQWCtnt27
X-Google-Smtp-Source: AGHT+IF917+dN9zBiuOeEVDpEMfZIeL7JyE7V4ZwpA1Kg1dEGPkwIPmUhqii6NAO2kSAnpslKsTWdD118gXratRPVYo=
X-Received: by 2002:aa7:d889:0:b0:56e:5681:ff3e with SMTP id
 u9-20020aa7d889000000b0056e5681ff3emr17234edq.2.1712860978879; Thu, 11 Apr
 2024 11:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411180202.399246-1-kuba@kernel.org>
In-Reply-To: <20240411180202.399246-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Apr 2024 20:42:45 +0200
Message-ID: <CANn89iJne2+k+MJQzu1U7vO6eEbTLjD7QQxSG6hPgZ1i7+AutA@mail.gmail.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	Stefano Brivio <sbrivio@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, dsahern@kernel.org, 
	donald.hunter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Commit under Fixes optimized the number of recv() calls
> needed during RTM_GETROUTE dumps, but we got multiple
> reports of applications hanging on recv() calls.
> Applications expect that a route dump will be terminated
> with a recv() reading an individual NLM_DONE message.
>
> Coalescing NLM_DONE is perfectly legal in netlink,
> but even tho reporters fixed the code in respective
> projects, chances are it will take time for those
> applications to get updated. So revert to old behavior
> (for now)?
>
> Old kernel (5.19):
>

> Reported-by: Stefano Brivio <sbrivio@redhat.com>
> Link: https://lore.kernel.org/all/20240315124808.033ff58d@elisabeth
> Reported-by: Ilya Maximets <i.maximets@ovn.org>
> Link: https://lore.kernel.org/all/02b50aae-f0e9-47a4-8365-a977a85975d3@ov=
n.org
> Fixes: 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU protection")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> CC: donald.hunter@gmail.com
> ---
>  net/ipv4/fib_frontend.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index 48741352a88a..c484b1c0fc00 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1050,6 +1050,11 @@ static int inet_dump_fib(struct sk_buff *skb, stru=
ct netlink_callback *cb)
>                         e++;
>                 }
>         }
> +
> +       /* Don't let NLM_DONE coalesce into a message, even if it could.
> +        * Some user space expects NLM_DONE in a separate recv().
> +        */
> +       err =3D skb->len;

My plan was to perform this generically from netlink_dump_done().

This would still avoid calling a RTNL-enabled-dump() again if EOF has
been met already.

A sysctl could opt-in for the coalescing, if there is interest.

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index dc8c3c01d51b709c132ff63a0c534c1cc286589a..cad1124393ac74f3d5bfa86556e=
d9028f5ec8f65
100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2282,7 +2282,12 @@ static int netlink_dump(struct sock *sk, bool lock_t=
aken)
                cb->extack =3D NULL;
        }

+       /* Don't let NLM_DONE coalesce into a message, even if it could.
+        * Some user space expects NLM_DONE in a separate recv().
+        * Maybe opt-in this coalescing with a sysctl or socket option ?
+        */
        if (nlk->dump_done_errno > 0 ||
+           skb->len ||
            skb_tailroom(skb) <
nlmsg_total_size(sizeof(nlk->dump_done_errno))) {
                mutex_unlock(&nlk->nl_cb_mutex);

