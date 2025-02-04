Return-Path: <netdev+bounces-162384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD9A26B77
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBF5167491
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 05:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13D1F8918;
	Tue,  4 Feb 2025 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y2kOr/ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655B1E7C3A
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647709; cv=none; b=GEYU2DUL3JP5gIu8uN5LKeBHbyLjBFS1+evs383R8yDu3o5f8pGga8qPaGpKHituYQOk2s23YFD3GlGdM6XrMQJjmJ9ABQ7G+r+gG1RJjbEPb44tGmsTP/rGWVPFPKVnctkUfQ8THJqtFCh9Z/rmCa2kZ9smbBF6yJyuHAEEGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647709; c=relaxed/simple;
	bh=nYAF5s+uKZtSXnsmpv+zAw8Qoaed8S94csftcjLRjSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4/wVd/nzCfoUAzckvjwQ3CAob2yOtKgeuQ+Rn13rGbpSAE78pYaUELjwld77Xi3oU3fSZ7W4hRHRvrypJK82khtxkoL+qFXHdKPgEuSEwyXL/yxwglUd1UrBwZcPlneeKf2tdVGVQyo0rO4QstUQ9jpHVZJ5B5a4OzX8udXYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y2kOr/ng; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso11578181a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738647706; x=1739252506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5ROGBW5YIKKrxe7d9gIpTjtYz2shKgG19iXvjXoYo4=;
        b=y2kOr/nggZKVrqWUt3i2eH01AC//L8Mgr5HgIgrc6GnJQWwLs+cwjH8wma3V/5bUWb
         dKx9aojEtlfzNx5u/BK08okgvGNcoDE8wv8boZDQhSqQpBlzdCSHL8gFf02fV0un2b6t
         q292HfAr9s7F5ub8sFFxJcVoV3WNc2aomoIlvVWE1Th6mnpnl5BPRDzA/9PO35kt1Qy/
         jyrcj6pUiofnvSCvQg/3nX4NeFnpftlari4gacgL+pZmNWPhJgcd3py7f4NJNjt9YcsO
         uQE8fx8rdBxtdnQAHmR/6QDbqQZkfvQ9kffLlJJndL5DXFgbIB9ESfnnE8vz0xHc7YDR
         0jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738647706; x=1739252506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5ROGBW5YIKKrxe7d9gIpTjtYz2shKgG19iXvjXoYo4=;
        b=XOZustw8FS0tdNu9VF4Gm5sj5sUvu9ZgYfZpHY3xgCR7EAhSwSeA4qghFz95af+U0H
         i5hWTV+4WqIUwNcAJLTzjN0idKI7Mzk3U84FUFjwysaQys1XRClakNaIcqBaJsO0xBOa
         1sDPtGlv9jsmRnn2pCDHNx26RMyORW8hrPCEYf9IkftSCZEVM4sw37bWXbYvwVnDoE14
         bcTCZEdB+EQgRvOTfRA8W92cXOq6uwCSaOtzX9DO1wnZyo9OQ1IjUTkUoqCQRa3v6TyR
         ExjAVJX5YE205AYBkBfqOPlrHbtJa5lV0gXEU9kldyzE9cLo3x2S9bLzWEye5P2vZSPE
         AaPg==
X-Gm-Message-State: AOJu0YxCRZdzSZJT9FEPmqr0YBCL0hQDLK0mjgezgKH6FAQN6LdUY0bt
	Lm2VMnTo6z9gF580RnAnNCURahMnGS0jIfvt3kN0MTyyi40zWIADCgW5+lnqONqM7/VBiCGXMdr
	HlMaePEYzIL29/Pvw293NNk/SF1QvrpQJ5Mn6
X-Gm-Gg: ASbGncvlaGm6tzrhQEKiVSzICJqU8PKMJ3RIx3smXvL8PZMfbAEnZaQM5trGVB1Qn2W
	ZLv9HaK3Xk/wiPqxCD7H6ghetMTIdvGuQRhLabmnz3DRpPtRxp0ELVXJCMiEg6285QsuM2g==
X-Google-Smtp-Source: AGHT+IEMB0Hh889ibaUBX8XyMjpH1b7qQ7nyK1EmLnf3HffI4U1UKf9iAEcXVLy7W3BoIRyGUzpG0knK3TOoZKxbsG8=
X-Received: by 2002:a05:6402:4024:b0:5dc:8fc1:b3b5 with SMTP id
 4fb4d7f45d1cf-5dcc1592f25mr1943568a12.15.1738647705554; Mon, 03 Feb 2025
 21:41:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203191714.155526-1-jdamato@fastly.com>
In-Reply-To: <20250203191714.155526-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 06:41:34 +0100
X-Gm-Features: AWEUYZnzdMxgHmohNWyQW-UZKVVFL3VTRcdtUoDk1P89l4Uz7MXAldoeIms1bDY
Message-ID: <CANn89i+vf5=6f8kuZKCmP66P1LWGmAj06i+NhgqpFLVR8K5bEA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdev-genl: Elide napi_id when not present
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, Mina Almasry <almasrymina@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 8:17=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> There are at least two cases where napi_id may not present and the
> napi_id should be elided:
>
> 1. Queues could be created, but napi_enable may not have been called
>    yet. In this case, there may be a NAPI but it may not have an ID and
>    output of a napi_id should be elided.
>
> 2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
>    to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
>    output as a NAPI ID of 0 is not useful for users.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Updated to elide NAPI IDs for RX queues which may have not called
>      napi_enable yet.
>
>  rfc: https://lore.kernel.org/lkml/20250128163038.429864-1-jdamato@fastly=
.com/
>  net/core/netdev-genl.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 715f85c6b62e..a97d3b99f6cd 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -385,9 +385,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct=
 net_device *netdev,
>         switch (q_type) {
>         case NETDEV_QUEUE_TYPE_RX:
>                 rxq =3D __netif_get_rx_queue(netdev, q_idx);
> -               if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -                                            rxq->napi->napi_id))
> -                       goto nla_put_failure;
> +               if (rxq->napi && rxq->napi->napi_id >=3D MIN_NAPI_ID)
> +                       if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> +                                       rxq->napi->napi_id))
> +                               goto nla_put_failure;
>
>                 binding =3D rxq->mp_params.mp_priv;
>                 if (binding &&
> @@ -397,9 +398,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct=
 net_device *netdev,
>                 break;
>         case NETDEV_QUEUE_TYPE_TX:
>                 txq =3D netdev_get_tx_queue(netdev, q_idx);
> -               if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -                                            txq->napi->napi_id))
> -                       goto nla_put_failure;
> +               if (txq->napi && txq->napi->napi_id >=3D MIN_NAPI_ID)
> +                       if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> +                                       txq->napi->napi_id))
> +                               goto nla_put_failure;
>         }

Hi Joe

This might be time to add helpers, we now have these checks about
MIN_NAPI_ID all around the places.

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index c39a426ebf52038b493b145e65e2d3d7f0c74e4c..741fa77547001aa5d966763c815=
40ee9210c949e
100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -24,6 +24,11 @@
  */
 #define MIN_NAPI_ID ((unsigned int)(NR_CPUS + 1))

+static inline bool napi_id_valid(unsigned int napi_id)
+{
+       return napi_id >=3D MIN_NAPI_ID;
+}
+
 #define BUSY_POLL_BUDGET 8

 #ifdef CONFIG_NET_RX_BUSY_POLL
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62eabcc61a10065f98cc914f5f0d975..b5c4e42351e67d73c0aa879156e=
ea431d4baf7aa
100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -364,6 +364,13 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb,
struct genl_info *info)
        return err;
 }

+static int nla_put_napi_id(struct sk_buff *skb, const struct napi_struct *=
napi)
+{
+       if (napi && napi_id_valid(napi->napi_id))
+               return nla_put_u32(skb, NETDEV_A_QUEUE_NAPI_ID, napi->napi_=
id);
+       return 0;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
                         u32 q_idx, u32 q_type, const struct genl_info *inf=
o)
@@ -385,8 +392,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp,
struct net_device *netdev,
        switch (q_type) {
        case NETDEV_QUEUE_TYPE_RX:
                rxq =3D __netif_get_rx_queue(netdev, q_idx);
-               if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-                                            rxq->napi->napi_id))
+               if (nla_put_napi_id(rsp, rxq->napi))
                        goto nla_put_failure;

                binding =3D rxq->mp_params.mp_priv;
@@ -397,8 +403,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp,
struct net_device *netdev,
                break;
        case NETDEV_QUEUE_TYPE_TX:
                txq =3D netdev_get_tx_queue(netdev, q_idx);
-               if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-                                            txq->napi->napi_id))
+               if (nla_put_napi_id(rsp, txq->napi))
                        goto nla_put_failure;
        }

