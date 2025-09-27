Return-Path: <netdev+bounces-226925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150EBA6336
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0531898C48
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35A1D86DC;
	Sat, 27 Sep 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFIbcytP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA64316E
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759004914; cv=none; b=aM6jOX3mQb1OR/iysTIRUxDtABTsuxfwd+zfAeg3zx1LoYzsuvce8vSp2jrDXeGOwjYmCogOF+Rl8UC3HP4AHq31cHdIIIlqIR7tQ8WjSUd66fNnHS+/m+07OWeOqYf5rLhzRqPj6JEQQRcx9vjbaECLaDP0NsEFA4HTqpc1/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759004914; c=relaxed/simple;
	bh=kSMKv25t30jWBSdd3kxSwhTDhs6NJhXHxR7L3F+pnOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5euCopHcdAkNRy3fRH6tLQEU8SGk9WGTpTS9DiX5BIXFWy4UWrZSaaxTz1c7qfFr/OM2lViW2MWD/AyB1kmfUve79VkKFafDSDAId0r+4BaQNDo7jo0lRyIJo0yaleK82VYD72fys9yu1LcvbQoWZ6/dk5xUDpG7TOs3TSNbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFIbcytP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f605f22easo2953420b3a.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759004912; x=1759609712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAlYIEg+NQPSeaTKhdVQ+2d4wGSgMJU5cEeb+LM+DRE=;
        b=FFIbcytPvbFxFDV2hm3RHMPGqFKahR6gS2P6Dwzna/hD4e9o8hFdr2MA47biezudPr
         vETeN0qb1BmeJAFuasbHudwbRpLiyElfZtV2bSzzba1XT1jucPo0BLQeLYiBqsBvM+y+
         nZbWm2cw0OOQHDrsSALKBS6zJhMe1jG44YKO0jWdCWW7PAIyIM1Io0Gv1ja91rAKdECm
         7Oy9jXE/U84PPWy8H8husvjLt4uamhbewN+4aGflPG41rjYVEbZkAMXuVX6msOR7L+J/
         cSHekNiPbp0b94f5m/s/wkrwdBvTIFbqVsBzTetivSnrU+XSISCf1Libgv1YBikjPw7V
         WO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759004912; x=1759609712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAlYIEg+NQPSeaTKhdVQ+2d4wGSgMJU5cEeb+LM+DRE=;
        b=OB53q/z//f+RFZGB0Ap2Xl4eNOhs1AGr8xCI/SNKdawdah3dh0FoMelKk1rKOlJmrg
         ItAJ6/zzkUoNjbHtNZRp68an2k1IE2cxTZsM2BLYWtSwraO12bggp+cxKBhFuz7VYPrW
         TjoWrQFsqU5zE19ZET2ojhSHlze1PSt4SLT9W2A3C/jTjhHtKGdhMUuiPRrECK0vKpAV
         2Apww2TqkczMdzOyLVbypz8uHkFcfVbXwzQt2z927URwVAHCnamCGNbZB6QQaf2FKRSd
         9o2K3nqbJI2H6fjDOh7Xrwkv3OvhvlSzl5luu4AjNsAltljNr7xaMHgkTnOtFgKrAHup
         JZxA==
X-Forwarded-Encrypted: i=1; AJvYcCU3/+qz5TKSQ4T1bk3pZzE2Zf3UIt1r8bWBIrWX7A9hIh7JZy0dad56g+ETLfOu1P1IoDzQlIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzds1wszkYCNdt5ttF615aPyPV3BgvUYtzqxSsULGIkfmnsQSTy
	GuXq+y8E+Ep3bcy0rWv6OGVjZggcWdz2yljxO0Wke0OiMKtX8+nydb+9lVZDRl2ZO8RGLWUgV+t
	M6HKULBUu9knxWpkQcmdbBGLWEOPFn/bosBT9oK59
X-Gm-Gg: ASbGncvnB0+5akLG/Cu4gOmwQHXHitnF8oCFp303iqPCIevZfsmduGkS9pbpnBdmY9R
	DHpbEQLSRMKuEJmj98Ezp9oahN78echHBfdgypqTEB3KeEovZBUqebGVBRKGEhDXGGyTA6jNlEU
	vxqyGkbvdHymczspxk3ZYRLJ9iwfkSl/ycwThGk9lyIFpX1CKk6oZM0KNpCGMfXXr5b+H2LN8O3
	6t5wtX7uhNhoDYDZ2nnPFy9ulUBN0hZGalu5rT3JIAVAZCDLf3DoVK7olMGLQ==
X-Google-Smtp-Source: AGHT+IEA504ORmY1X/5dAyq6qpkDI05+8fBrfr52ykglJmR7C4bmpXlVBp5xXeaTh0Jv/rsQ+NS6izANoMBzBcOSNQI=
X-Received: by 2002:a17:90b:350c:b0:330:6c04:a72b with SMTP id
 98e67ed59e1d1-3342a2498f2mr12670438a91.3.1759004911873; Sat, 27 Sep 2025
 13:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com> <20250926151304.1897276-4-edumazet@google.com>
In-Reply-To: <20250926151304.1897276-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 27 Sep 2025 13:28:20 -0700
X-Gm-Features: AS18NWCF0K1OHThNh5S_VnFhxBV1P-AV2bKP_Lz5GyRQGnCjiX2gG4XJgED358c
Message-ID: <CAAVpQUDiGuCtUzXeJw0004VxDHFketF7J+Xu6tqEod_o=3r7Kg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add NUMA awareness to skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Instead of sharing sd->defer_list & sd->defer_count with
> many cpus, add one pair for each NUMA node.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/netdevice.h |  4 ----
>  include/net/hotdata.h     |  7 +++++++
>  net/core/dev.c            | 37 +++++++++++++++++++++++++------------
>  net/core/dev.h            |  2 +-
>  net/core/skbuff.c         | 11 ++++++-----
>  5 files changed, 39 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5c9aa16933d197f70746d64e5f44cae052d9971c..d1a687444b275d45d105e336d=
2ede264fd310f1b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3536,10 +3536,6 @@ struct softnet_data {
>
>         struct numa_drop_counters drop_counters;
>
> -       /* Another possibly contended cache line */
> -       struct llist_head       defer_list ____cacheline_aligned_in_smp;
> -       atomic_long_t           defer_count;
> -
>         int                     defer_ipi_scheduled ____cacheline_aligned=
_in_smp;
>         call_single_data_t      defer_csd;
>  };
> diff --git a/include/net/hotdata.h b/include/net/hotdata.h
> index fda94b2647ffa242c256c95ae929d9ef25e54f96..4acec191c54ab367ca12fff59=
0d1f8c8aad64651 100644
> --- a/include/net/hotdata.h
> +++ b/include/net/hotdata.h
> @@ -2,10 +2,16 @@
>  #ifndef _NET_HOTDATA_H
>  #define _NET_HOTDATA_H
>
> +#include <linux/llist.h>
>  #include <linux/types.h>
>  #include <linux/netdevice.h>
>  #include <net/protocol.h>
>
> +struct skb_defer_node {
> +       struct llist_head       defer_list;
> +       atomic_long_t           defer_count;
> +} ____cacheline_aligned_in_smp;
> +
>  /* Read mostly data used in network fast paths. */
>  struct net_hotdata {
>  #if IS_ENABLED(CONFIG_INET)
> @@ -30,6 +36,7 @@ struct net_hotdata {
>         struct rps_sock_flow_table __rcu *rps_sock_flow_table;
>         u32                     rps_cpu_mask;
>  #endif
> +       struct skb_defer_node __percpu *skb_defer_nodes;
>         int                     gro_normal_batch;
>         int                     netdev_budget;
>         int                     netdev_budget_usecs;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fb67372774de10b0b112ca71c7c7a13819c2325b..afcf07352eaa3b9a563173106=
c84167ebe1ab387 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5180,8 +5180,9 @@ static void napi_schedule_rps(struct softnet_data *=
sd)
>         __napi_schedule_irqoff(&mysd->backlog);
>  }
>
> -void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu)
> +void kick_defer_list_purge(unsigned int cpu)
>  {
> +       struct softnet_data *sd =3D &per_cpu(softnet_data, cpu);
>         unsigned long flags;
>
>         if (use_backlog_threads()) {
> @@ -6715,18 +6716,26 @@ bool napi_complete_done(struct napi_struct *n, in=
t work_done)
>  }
>  EXPORT_SYMBOL(napi_complete_done);
>
> -static void skb_defer_free_flush(struct softnet_data *sd)
> +struct skb_defer_node __percpu *skb_defer_nodes;

seems this is unused, given it's close to the end of cycle
maybe this can be fixed up while applying ? :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

