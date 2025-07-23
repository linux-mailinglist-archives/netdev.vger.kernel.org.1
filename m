Return-Path: <netdev+bounces-209385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C5B0F6B7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85490176B22
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17102E4257;
	Wed, 23 Jul 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4eN04FJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66527AC30
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283352; cv=none; b=sAlzt2OFa38csd2QIT4vFLMWQB8uEYcDt+O0dL41bUifQMfsSSEwsTjo9t/ZRVwPJz6fcIWf/styFaTdH5B64K2WE7YhFjQK4wMqhBD2k/uWRq4BLk+/0YKDs5yxEiJc3iA2a0J6G54CGsver7qkMm+w1IGK1L074mmWh+etcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283352; c=relaxed/simple;
	bh=S3J/htbtbyUbYL8jZAbnX1q9N03CuQgOMcPhhJmgWik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESp6AURifVcaWovybgTD2kky4VbC9lcMtEei5JDqr/0VQliF3dwcYs6M0DRwrZ5JCRkHOVFcCy+ZjKA9baGsFr9bwqMuIH4QNZGa47ZpaZ/8bdaBIFG4cHRH59a8qVvA/0SOHwTn1X7/GuI7u01r+fxYXw6fu2BcJ7vi0/K2Jkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4eN04FJ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab63f8fb91so187641cf.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753283350; x=1753888150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGuAvS2zzRvy/QUS6Byf3+NsH02qsTfoeHDCyi+OH8s=;
        b=t4eN04FJteugJ1W52hEJOKQOKYgByZLUYp6uH9UBSm2KfVfV60/92ar/WbLnwH1V4v
         7JgGaj8LmYQe1bVICJ1NUE48JHb5bR4FE51//pu8i6gYI3QBaT+Hjnb1PNICtNJkmKQ+
         q1fvn+tqfENVy2f2DhtlZP3yhBIJciRMhDf2S4KU4qYjVm1dIA7z6R2CtinN5TFTEfOz
         C5O0CyFYVLxllktWwawCa7pjlMkIzTqxtaFLf62pbPLTB5gMEg5VlSyHdsWd6Ahs6Fcy
         alVMlxAzNXtZ2eveiAmUTFZ5eechZTBMoyRQJ369pZGM/x6y7U0rHXMkTDZ0kFtkuVB4
         vYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283350; x=1753888150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGuAvS2zzRvy/QUS6Byf3+NsH02qsTfoeHDCyi+OH8s=;
        b=VRWEo7HHgRceQQKnwIShGZA3z2eNAXZbXi1rtYr/ztRWsX09ZlwR+DNcg2e3XOUfg/
         CkdPDqGFWlIcDyNAdgrsQNkAyONfH7el5dXmsJkIqe+3DuV96BawYz8YsGXD75WcYCFY
         q7mkSo+J5pA5Cukoe3clJk3WYnxzMwd2ytDeqsSe4sLuXz+wHG3R9fDkNtv8QGZ/49Ay
         ksTkEn28b7x/IQzZ98hqGBsidNcjiWEK/v9HVCPIwN2sF7hjjoh3AdEgbJQVBBSOwqsN
         sxYlLinjXqlKJ9HVuKJasJKog42PdXqH5Yh4IshQWOjnkDJ23eVHOBnfmQ9Ax7D0JBRF
         wwdg==
X-Forwarded-Encrypted: i=1; AJvYcCUfM9dO8cSq7/vdMLyMPo3eXTTyfcEfrT+dxoxCVxusyUKkOcvRdL+b3t5E7IPL099VYy+oKkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kIJ7uBJI/QEqLMPGhkT+vahmIyvWzOk1lxFBhiTP2boHbDov
	pjj9Ui+tUFwxQA5JnocZMM5r6rVNnAUMxe8u0bphuIt9gYxzy+07+pRaDk3WzciwIMqOP3kvnh+
	iG39nrhPhGHgfeFaaar8YnsxsK3zDEVvLTPjE/A63
X-Gm-Gg: ASbGnctxbdpf3v70zUAqsWMXS5lzbM6k7CbLWXZXkjFjJkbSHlYdEz6paZ9iZIJQpw+
	/ESK4qAGrW0ljbK+et6hAwq/Rhw5Eu7UX1myfoVIBmAiDLbfRpep4+JYkkOnTaySxY8rPynbsra
	YfmGTRYknbSiasCI/LDiwATKSW0PM+CTc4Zdsm0TCFZ9JhIK77vKN8lcvsl/j/fT9bqOIt3tGSg
	wRaVdS0
X-Google-Smtp-Source: AGHT+IGSF5J2ekOo1rRSfsYMDM5Ulvwtfw/mxIaEvldoeeBsyBqdD/dycxbPdVhOW5fDYWzI6vZs+2lcYyEyMEz3tVM=
X-Received: by 2002:a05:622a:1825:b0:4ab:af74:e0be with SMTP id
 d75a77b69052e-4ae6df8b4c6mr47402871cf.43.1753283349495; Wed, 23 Jul 2025
 08:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723082201.GA14090@hu-sharathv-hyd.qualcomm.com>
In-Reply-To: <20250723082201.GA14090@hu-sharathv-hyd.qualcomm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Jul 2025 08:08:58 -0700
X-Gm-Features: Ac12FXyoFQTuYxg1fKYTugW1VABeksBzgTiKlhimlXGxT4kT0IpWz8UpQfMpqrk
Message-ID: <CANn89iLx29ovUNTp9DjzzeeAOZfKvsokztp_rj6qo1+aSjvrgw@mail.gmail.com>
Subject: Re: [PATCH] net: Add locking to protect skb->dev access in ip_output
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, quic_kapandey@quicinc.com, 
	quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:22=E2=80=AFAM Sharath Chandra Vurukala
<quic_sharathv@quicinc.com> wrote:
>
> In ip_output() skb->dev is updated from the skb_dst(skb)->dev
> this can become invalid when the interface is unregistered and freed,
>
> Added rcu locks to ip_output().This will ensure that all the skb's
> associated with the dev being deregistered will be transnmitted
> out first, before freeing the dev.
>
> Multiple panic call stacks were observed when UL traffic was run
> in concurrency with device deregistration from different functions,
> pasting one sample for reference.
>
> [496733.627565][T13385] Call trace:
> [496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0=
x7f0
> [496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
> [496733.627595][T13385] ip_finish_output+0xa4/0xf4
> [496733.627605][T13385] ip_output+0x100/0x1a0
> [496733.627613][T13385] ip_send_skb+0x68/0x100
> [496733.627618][T13385] udp_send_skb+0x1c4/0x384
> [496733.627625][T13385] udp_sendmsg+0x7b0/0x898
> [496733.627631][T13385] inet_sendmsg+0x5c/0x7c
> [496733.627639][T13385] __sys_sendto+0x174/0x1e4
> [496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
> [496733.627653][T13385] invoke_syscall+0x58/0x11c
> [496733.627662][T13385] el0_svc_common+0x88/0xf4
> [496733.627669][T13385] do_el0_svc+0x2c/0xb0
> [496733.627676][T13385] el0_svc+0x2c/0xa4
> [496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
> [496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8
>
> Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
> ---
>  net/ipv4/ip_output.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 10a1d182fd84..95c5e9cfc971 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -425,15 +425,22 @@ int ip_mc_output(struct net *net, struct sock *sk, =
struct sk_buff *skb)
>
>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> -       struct net_device *dev =3D skb_dst_dev(skb), *indev =3D skb->dev;
> +       struct net_device *dev, *indev =3D skb->dev;
>
> +       IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
> +
> +       rcu_read_lock();
> +
> +       dev =3D skb_dst(skb)->dev;

Arg... Please do not remove skb_dst_dev(skb), and instead expand it.

I recently started to work on this class of problems.

commit a74fc62eec155ca5a6da8ff3856f3dc87fe24558
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Jun 30 12:19:31 2025 +0000

    ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]

    Use the new helpers as a first step to deal with
    potential dst->dev races.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
    Link: https://patch.msgid.link/20250630121934.3399505-8-edumazet@google=
.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Adding RCU is not good enough, we still need the READ_ONCE() to
prevent potential load/store tearing.

I was planning to add skb_dst_dev_rcu() helper and start replacing
skb_dst_dev() where needed.

diff --git a/include/net/dst.h b/include/net/dst.h
index 00467c1b509389a8e37d6e3d0912374a0ff12c4a..692ebb1b3f421210dbb58990b77=
a200b9189d0f7
100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -568,11 +568,23 @@ static inline struct net_device *dst_dev(const
struct dst_entry *dst)
        return READ_ONCE(dst->dev);
 }

+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+       /* In the future, use rcu_dereference(dst->dev) */
+       WARN_ON(!rcu_read_lock_held());
+       return READ_ONCE(dst->dev);
+}
+
 static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
 {
        return dst_dev(skb_dst(skb));
 }

+static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb=
)
+{
+       return dst_dev_rcu(skb_dst(skb));
+}
+
 static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 {
        return dev_net(skb_dst_dev(skb));
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 10a1d182fd848f0d2348f65fde269383f9c07baa..37b982dd53f69247634c67c493c=
44fa482100dee
100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -425,15 +425,20 @@ int ip_mc_output(struct net *net, struct sock
*sk, struct sk_buff *skb)

 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-       struct net_device *dev =3D skb_dst_dev(skb), *indev =3D skb->dev;
+       struct net_device *dev, *indev =3D skb->dev;
+       int res;

+       rcu_read_lock();
+       dev =3D skb_dst_dev_rcu(skb);
        skb->dev =3D dev;
        skb->protocol =3D htons(ETH_P_IP);

-       return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+       res =3D NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
                            net, sk, skb, indev, dev,
                            ip_finish_output,
                            !(IPCB(skb)->flags & IPSKB_REROUTED));
+       rcu_read_unlock();
+       return res;
 }
 EXPORT_SYMBOL(ip_output);

