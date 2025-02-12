Return-Path: <netdev+bounces-165690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD99A33103
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F377A3ECE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A4D202C58;
	Wed, 12 Feb 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkEMa6eb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4D202C3A
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393274; cv=none; b=lF3kbFjv0entl/a0EsGWOXx+wIm9dohK4RQAoW7RCCPOt7vJtIO+zm0nsijUGtseHdppqzO3TS9KC0IxJxOn/gW6yBhU8OqRNaPVdkDrXNFLGXc4Z1Q5x8y68A63fe6OzEOaEcPyjC/6fw1Ks3GkzKV0zS+b+/ofZ3UE7GVbjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393274; c=relaxed/simple;
	bh=Kyy1coWr+70EtrCSbVd0umvNbA9mrtbdLnba3Kjuqzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa3FSGWu5tPJ3nNr0MDVOrwf/7InoMwKxT8DVqdUjsrqz5jScN1tbWQaPQu0vpkeSCdcjJTFLs7HNQX/mGZBqYmqi1tAYAI6/06biSEXEVidAYzufBPyHjGFQTNVUrsKV4BviOsXjAc1hKDpvKVErpbfQwSrjTwqtk48tBTN/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkEMa6eb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5deb1b8e1bcso189371a12.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 12:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739393270; x=1739998070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+Gm/BoQvFzrn2CqruyOG+znH+4fvq+YXdCl6TiVOhQ=;
        b=FkEMa6ebU+Jiofm42oAH3Rtk2uZfuFff/O+HNpRTfeUpxBAjrPZN5WSebcFXpQ018Q
         H92bHliveFLU/E10HPIfANF1/djLLakowCorTFhAJH31XZE83Rpk2DItxidRRfxjL9GA
         eftKoSo6cndQYVwz7SJUnfl+xBRlFwVFWBom5amk5dN3TBphCK5YzYEyhCOzFOUJi3Ba
         RSkpU+Jv/lyJERCde6KBCFSYJ0yWWu3XFtSmfazVDLRQnrCrF/b4MU9Mk98R8fSAyp4U
         jWVHZ5kJwAtoouuKCisTSRHZ6wxPT7Ovw1GF6QL0v5p63mIMdCx+bW+CPO61GzzcytAN
         AqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393270; x=1739998070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+Gm/BoQvFzrn2CqruyOG+znH+4fvq+YXdCl6TiVOhQ=;
        b=quxDa+ZDaoOq9pzdgIFNPg1+M/5QAsc7AIcSHXzL8WvVHhyuB/QcVu6PnqHrYgUEBI
         q6EzgenxAx+ooigtzcWDMt2YbPBT7w17prhsyTXB1jtXJiPgqIZBYKU7LpRlJeFI/WKR
         bmZqR4B9i0/BKtZ78uCdAriKYlNSMW/+DhjwvJG10qNUhAROvdJPnFcfbzfd/fZqtdxu
         gHsxnAYDz0LBdItjfuR9uNsQP/fchxQmcj6b8DyyOXRLl8Nxdc8+6P9vzLC8FG4RGZwR
         hMn5/m0TPJ1UCnRb2u81yMhWFc27tKYfLrlwcSIY7iq3SL6U+Iuq0U5lR8Z77TYGZTWp
         iHJQ==
X-Gm-Message-State: AOJu0YwEJE355oldTDp4rqH97zxQlBvp9bVP2MAIQy2Bc2YGqQnQ7XcL
	yFXB/tWuduXp8PUGechu+Mhp0UIeEhSi21TV8c0d7xHHOZD+dZ42z0dVoK/QW/boY5FCjKZC9wS
	ax13ICNlYVZ/k6dOkIU71lfD96+740hMS+Xp7
X-Gm-Gg: ASbGncuZryRhNd95WWEMFHk4Uq/M9SvoDOLHyUVVYWkQe3rpwVPrOh9C/fBUOI6C1j8
	OuuDFU4AsgvhGCxiTwuG8MZ+X99mWxPkjl3LAbpW762X2u7NOGmz2E+m3gdcM4hT+giMcxkf6Wg
	==
X-Google-Smtp-Source: AGHT+IHd60kX5SpUlguh8rLse5G3n3WyFn6QvXHHMmhM4bn1HTgpuCCxru3cnYTdr+kUIQWRzEr51AEHX+FhITlT8dM=
X-Received: by 2002:a05:6402:3818:b0:5de:39fd:b2ff with SMTP id
 4fb4d7f45d1cf-5dec9b73e13mr599874a12.0.1739393270409; Wed, 12 Feb 2025
 12:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
In-Reply-To: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 21:47:38 +0100
X-Gm-Features: AWEUYZlnwyi9PbukOdvRqVrLJ9G1Abeg_EXNzu3CcOir8SVg6UtrbbTOJqty3P4
Message-ID: <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 6:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Sabrina reported the following splat:
>
>     WARNING: CPU: 0 PID: 1 at net/core/dev.c:6935 netif_napi_add_weight_l=
ocked+0x8f2/0xba0
>     Modules linked in:
>     CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc1-net-00092=
-g011b03359038 #996
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linu=
x 1.16.3-1-1 04/01/2014
>     RIP: 0010:netif_napi_add_weight_locked+0x8f2/0xba0
>     Code: e8 c3 e6 6a fe 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc =
cc cc cc c7 44 24 10 ff ff ff ff e9 8f fb ff ff e8 9e e6 6a fe <0f> 0b e9 d=
3 fe ff ff e8 92 e6 6a fe 48 8b 04 24 be ff ff ff ff 48
>     RSP: 0000:ffffc9000001fc60 EFLAGS: 00010293
>     RAX: 0000000000000000 RBX: ffff88806ce48128 RCX: 1ffff11001664b9e
>     RDX: ffff888008f00040 RSI: ffffffff8317ca42 RDI: ffff88800b325cb6
>     RBP: ffff88800b325c40 R08: 0000000000000001 R09: ffffed100167502c
>     R10: ffff88800b3a8163 R11: 0000000000000000 R12: ffff88800ac1c168
>     R13: ffff88800ac1c168 R14: ffff88800ac1c168 R15: 0000000000000007
>     FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffff888008201000 CR3: 0000000004c94001 CR4: 0000000000370ef0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>     <TASK>
>     gro_cells_init+0x1ba/0x270
>     xfrm_input_init+0x4b/0x2a0
>     xfrm_init+0x38/0x50
>     ip_rt_init+0x2d7/0x350
>     ip_init+0xf/0x20
>     inet_init+0x406/0x590
>     do_one_initcall+0x9d/0x2e0
>     do_initcalls+0x23b/0x280
>     kernel_init_freeable+0x445/0x490
>     kernel_init+0x20/0x1d0
>     ret_from_fork+0x46/0x80
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
>     irq event stamp: 584330
>     hardirqs last  enabled at (584338): [<ffffffff8168bf87>] __up_console=
_sem+0x77/0xb0
>     hardirqs last disabled at (584345): [<ffffffff8168bf6c>] __up_console=
_sem+0x5c/0xb0
>     softirqs last  enabled at (583242): [<ffffffff833ee96d>] netlink_inse=
rt+0x14d/0x470
>     softirqs last disabled at (583754): [<ffffffff8317c8cd>] netif_napi_a=
dd_weight_locked+0x77d/0xba0
>
> on kernel built with MAX_SKB_FRAGS=3D45.
>
> In such built, SKB_WITH_OVERHEAD(1024) is smaller than GRO_MAX_HEAD, and
> thus after commit 011b03359038 ("Revert "net: skb: introduce and use a
> single page frag cache"") napi_get_frags() ends up using the page frag
> allocator, triggering the splat.
>
> Address the issue updating napi_alloc_skb() and __netdev_alloc_skb() to
> allow kmalloc() usage for GRO_MAX_HEAD allocation, regardless of the
> configured MAX_SKB_FRAGS value.
>
> Note that even before the mentioned revert, __netdev_alloc_skb() was
> not using the small head cache for GRO_MAX_HEAD-size allocation for
> MAX_SKB_FRAGS=3D45 kernel build, which is sort of unexpected.
>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Fixes: 011b03359038 ("Revert "net: skb: introduce and use a single page f=
rag cache"")
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRA=
GS")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/core/skbuff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6a99c453397f..6afd99a2736d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -661,7 +661,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device =
*dev, unsigned int len,
>         /* If requested length is either too small or too big,
>          * we use kmalloc() for skb->head allocation.
>          */
> -       if (len <=3D SKB_WITH_OVERHEAD(1024) ||
> +       if (len <=3D SKB_WITH_OVERHEAD(max(1024, SKB_SMALL_HEAD_CACHE_SIZ=
E)) ||
>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
>                 skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_=
NODE);
> @@ -739,7 +739,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *na=
pi, unsigned int len)
>         /* If requested length is either too small or too big,
>          * we use kmalloc() for skb->head allocation.
>          */
> -       if (len <=3D SKB_WITH_OVERHEAD(1024) ||
> +       if (len <=3D SKB_WITH_OVERHEAD(max(1024, SKB_SMALL_HEAD_CACHE_SIZ=
E)) ||
>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
>                 skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALL=
OC_NAPI,
> --
> 2.48.1
>

This patch still gives a warning if  MAX_TCP_HEADER < GRO_MAX_HEAD +
64 (in my local build)

Why not simply use SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) , and
remove the 1024 value ?

I would  make sure the small cache can be used by both TCP tx packets
and GRO ones.

After the following patch, I no longer have the warning and :

# grep small /proc/slabinfo
skbuff_small_head     98    168   1152   14    4 : tunables    0    0
  0 : slabdata     12     12      0

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688f65daa25ca208e29775326520e1e..a14ab14c14f1bd6275ab2d1d93b=
f230b6be14f49
100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -56,7 +56,11 @@ DECLARE_PER_CPU(u32, tcp_tw_isn);

 void tcp_time_wait(struct sock *sk, int state, int timeo);

-#define MAX_TCP_HEADER L1_CACHE_ALIGN(128 + MAX_HEADER)
+#define MAX_TCP_HEADER L1_CACHE_ALIGN(64 + MAX_HEADER)
+/* This should be increased if a protocol with a bigger head is added. */
+#define GRO_MAX_HEAD (128 + MAX_HEADER)
+#define GRO_MAX_HEAD_PAD (GRO_MAX_HEAD + NET_SKB_PAD + NET_IP_ALIGN)
+
 #define MAX_TCP_OPTION_SPACE 40
 #define TCP_MIN_SND_MSS                48
 #define TCP_MIN_GSO_SIZE       (TCP_MIN_SND_MSS - MAX_TCP_OPTION_SPACE)
diff --git a/net/core/gro.c b/net/core/gro.c
index d1f44084e978fb50b3af9827abd649c7a7176c5e..1dd6f56bef8af793f89720c1dbe=
573e16b60e3da
100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -2,14 +2,12 @@
 #include <net/gro.h>
 #include <net/dst_metadata.h>
 #include <net/busy_poll.h>
+#include <net/tcp.h>
 #include <trace/events/net.h>
 #include <linux/skbuff_ref.h>

 #define MAX_GRO_SKBS 8

-/* This should be increased if a protocol with a bigger head is added. */
-#define GRO_MAX_HEAD (MAX_HEADER + 128)
-
 static DEFINE_SPINLOCK(offload_lock);

 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6a99c453397fcf7a5762cda5200ecee3468fd2e3..5f7fd41d93bbc01e16f6f799431=
7e8c95230c435
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -75,6 +75,7 @@
 #include <net/xfrm.h>
 #include <net/mpls.h>
 #include <net/mptcp.h>
+#include <net/tcp.h>
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
@@ -95,7 +96,8 @@
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #endif

-#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(MAX_TCP_HEADER)
+#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(max(MAX_TCP_HEADER, \
+                                              GRO_MAX_HEAD_PAD))

 /* We want SKB_SMALL_HEAD_CACHE_SIZE to not be a power of two.
  * This should ensure that SKB_SMALL_HEAD_HEADROOM is a unique
@@ -661,7 +663,7 @@ struct sk_buff *__netdev_alloc_skb(struct
net_device *dev, unsigned int len,
        /* If requested length is either too small or too big,
         * we use kmalloc() for skb->head allocation.
         */
-       if (len <=3D SKB_WITH_OVERHEAD(1024) ||
+       if (len <=3D SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
            len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
            (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
                skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NO=
DE);
@@ -739,7 +741,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct
*napi, unsigned int len)
        /* If requested length is either too small or too big,
         * we use kmalloc() for skb->head allocation.
         */
-       if (len <=3D SKB_WITH_OVERHEAD(1024) ||
+       if (len <=3D SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
            len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
            (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
                skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC=
_NAPI,

