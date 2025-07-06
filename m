Return-Path: <netdev+bounces-204434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A1AFA693
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65A71896A77
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA21C84B8;
	Sun,  6 Jul 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNGGEJ7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9CB7260B
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751820440; cv=none; b=oLsZcrplQZ5HqLuG4WNpi6BSmS4zuzZQ8gsh0sT/L07/y//DHtVPQd2GtsiZqvOLV45qwx280RvoMVwNJSgUGQOkZsRqtXpeP+DydquMQ2Pep0Y3PpbO5HzvOHSvnLumhk/kpmYQBasiRRc2ck+RaSUNq5/7/TZTyM0DV7Q2hbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751820440; c=relaxed/simple;
	bh=5njAMe+NS91TkHoum0wGrl1vesY4AsrNMcpCgk3t3Og=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=f6zFqvCptNLKRxferfKkv64HwYjzsBHstfv59eGf9EAmGRvkdmCxyPcp7XRqXXAfm8Gb57nsAueiWDp+gw/Fq3h9teUjnGZZhX24dPRFqRU6lkTwn2AG9/4UG/99JX5A00qXtcwLlvCgW0jgbbMIJKFnbz89graWPfxWb4t+iW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNGGEJ7F; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8600c87293so1785649276.1
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751820438; x=1752425238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqQiff3z6W8uWgoi2kCzhatbYnhl0exd2u+8JPUslE8=;
        b=jNGGEJ7FpKDErfMU562XluJRS/RD/Zt/TjSC9EFZMBu8/8K825Y2XuBrsOprzB21LY
         HkKuiD3QorcCf2O1QpVuXNePtCcNakun1BoUuqm/cieigyjHZlVpphPi8li+izkTyc7H
         1ubMiALKHzYrAwFVcw4Bhtzm0C3A0THd/NEhgqX7YnU5EEYZzq31quBJN0dXwZNWSnar
         X1ak+YOXa2jmIhf2gjtXKS+9f+jUitn7Hw4iTUpOsDZroLUOHm6S6lV4o0bDfrznIdr0
         PmaQ9IHsIAX7FklieOZuczuCbvmUnTX3Rm4gXyayVN8Zkt3nsksc35YflsqYSxnFWCiU
         1ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751820438; x=1752425238;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EqQiff3z6W8uWgoi2kCzhatbYnhl0exd2u+8JPUslE8=;
        b=KOggcnc2WN/1nwnoMCqurz0hpxaJRhFIdJ7kl4Am7aK49wMVJrBivRH9HoZUdXRMHr
         BCKLHLfHrslZRftExelAnEW+jtroN5cjXnvMaQMOki0X2cVaMZ4bTAIer0YHZZ0JIhSv
         dPWEDFvAlcyPeZU6uo3u0/X0IqwLbJovoXPRcnz44q0qky3P+TKlSnKz/qjpgslSU4Ll
         vg8bG8xFc+XXHVQZHqX8LmvDOiV4tATgRdxGcuL4Dq0R15ijrXESv0ppmLJxRsNZ3/rJ
         W1zjhUSrOPNFkypMEo05qIupNOAiOyORe6fFdYgqLWRRxiCSxyX3Tli0Co2ivzjfc/DX
         HAhA==
X-Forwarded-Encrypted: i=1; AJvYcCWWNoeI0fhQfuKuUy9g8Q8wCzPA865o2I8xsw9EEL1J2A0bKc8Ef5FThVIwAuviFOTcCnKhDKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtl6hjxT0/qApWu47hRk+Z5AbAoHDRnu1VAQllsZrE8PLrg9+B
	iNtZNlFlohqaI3/6rD9Gc/+wgB054RTFQYp9ni2y9JhgK0l1a/ATBPnz
X-Gm-Gg: ASbGncu3zeEDa4XKPMtp7N/Jx/js5dlqVxv2FTJMc5URZNS73toL3y/XSVQdlmKqr2P
	joJmrFlugwCT3C5iNseRMxnQvlIk8wxvfjxd32Qc8VZoor/5n5ubMuhEN0qy6okvs1enxgSnVPk
	tAvS6967IqoNZ6gGpQchPeSqpoxS55PGuducV4yn0OKcKMlH1meym7+G74Ig8A9MUENwUvHuZGP
	3I5+McjDruhK2aDuE0+D7TKmzy/5BXVfbAdecT/cK+39vG4MgPmQ2ZS+a/BYvEfeWgCOA1wownl
	nyTFk5/EQ68ti7Mo6YigzFQRFmuhQlvOmBhZaRLSMUC901pLA/3blMgEhDnRBC+JoepmV05dzn2
	ATyFfniQOM4+kNh2nVxbnyGvJON5EAPAglzrmuB4=
X-Google-Smtp-Source: AGHT+IGToLTpbp9WA/jQJLymdCCMM3zjnAtvItQUoWreae+DDQVGmvqVQ3ls5uViIFTloa+AZWIYxA==
X-Received: by 2002:a05:690c:610d:b0:712:e22d:a235 with SMTP id 00721157ae682-7176ccaaa35mr76704867b3.17.1751820437920;
        Sun, 06 Jul 2025 09:47:17 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c44093dsm2064666276.27.2025.07.06.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:47:17 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:47:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aa894a8b6e_3ad0f32946d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-9-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-9-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 08/19] net: psp: add socket security association code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add the ability to install PSP Rx and Tx crypto keys on TCP
> connections. Netlink ops are provided for both operations.
> Rx side combines allocating a new Rx key and installing it
> on the socket. Theoretically these are separate actions,
> but in practice they will always be used one after the
> other. We can add distinct "alloc" and "install" ops later.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> 
> Notes:
>     v3:
>     - lift pse/pas comparison code into new function:
>       psp_pse_matches_pas().
>     - explicitly mark rcu critical section psp_reply_set_decrypted()
>     - use rcu_dereference_proteced() instead of rcu_read_lock() in
>       psp_sk_assoc_free() and psp_twsk_assoc_free()
>     - rename psp_is_nondata() to psp_is_allowed_nondata()
>     - check for sk_is_inet() before casting to inet_twsk()
>     - psp_reply_set_decrypted() should not call psp_sk_assoc()
>     - lift common code into psp_sk_get_assoc_rcu()
>     - Fix exports with EXPORT_IPV6_MOD_GPL()
>     
>     v2:
>     - add pas->dev_id == pse->dev_id to policy checks
>     - __psp_sk_rx_policy_check() now allows pure ACKs, FINs, and RSTs to
>       be non-psp authenticated before "PSP Full" state.
>     - assign tw_validate_skb funtion during psp_twsk_init()
>     - psp_skb_get_rcu() also checks if sk is a tcp timewait sock when
>       looking for psp assocs.
>     - scan ofo queue non-psp data during psp_sock_recv_queue_check()
>     - add tcp_write_collapse_fence() to psp_sock_assoc_set_tx()
>     v1:
>     - https://lore.kernel.org/netdev/20240510030435.120935-7-kuba@kernel.org/
> 
>  Documentation/netlink/specs/psp.yaml |  71 +++++++
>  include/net/psp/functions.h          | 113 +++++++++--
>  include/net/psp/types.h              |  58 ++++++
>  include/uapi/linux/psp.h             |  21 ++
>  net/psp/Kconfig                      |   1 +
>  net/psp/Makefile                     |   2 +-
>  net/psp/psp-nl-gen.c                 |  39 ++++
>  net/psp/psp-nl-gen.h                 |   7 +
>  net/psp/psp.h                        |  22 +++
>  net/psp/psp_main.c                   |  11 +-
>  net/psp/psp_nl.c                     | 244 +++++++++++++++++++++++
>  net/psp/psp_sock.c                   | 276 +++++++++++++++++++++++++++
>  12 files changed, 852 insertions(+), 13 deletions(-)
>  create mode 100644 net/psp/psp_sock.c
> 
> diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
> index 054cc02b65ad..57b24cd6f3f1 100644
> --- a/Documentation/netlink/specs/psp.yaml
> +++ b/Documentation/netlink/specs/psp.yaml
> @@ -38,6 +38,44 @@ attribute-sets:
>          type: u32
>          enum: version
>          enum-as-flags: true
> +  -
> +    name: assoc
> +    attributes:
> +      -
> +        name: dev-id
> +        doc: PSP device ID.
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: version
> +        doc: |
> +          PSP versions (AEAD and protocol version) used by this association,
> +          dictates the size of the key.
> +        type: u32
> +        enum: version
> +      -
> +        name: rx-key
> +        type: nest
> +        nested-attributes: keys
> +      -
> +        name: tx-key
> +        type: nest
> +        nested-attributes: keys
> +      -
> +        name: sock-fd
> +        doc: Sockets which should be bound to the association immediately.
> +        type: u32
> +  -
> +    name: keys
> +    attributes:
> +      -
> +        name: key
> +        type: binary
> +      -
> +        name: spi
> +        doc: Security Parameters Index (SPI) of the association.
> +        type: u32
>  
>  operations:
>    list:
> @@ -107,6 +145,39 @@ operations:
>        notify: key-rotate
>        mcgrp: use
>  
> +    -
> +      name: rx-assoc
> +      doc: Allocate a new Rx key + SPI pair, associate it with a socket.
> +      attribute-set: assoc
> +      do:
> +        request:
> +          attributes:
> +            - dev-id
> +            - version
> +            - sock-fd
> +        reply:
> +          attributes:
> +            - dev-id
> +            - version

Why return the same values as passed in the request?

> +            - rx-key
> +        pre: psp-assoc-device-get-locked
> +        post: psp-device-unlock
> +    -
> +      name: tx-assoc
> +      doc: Add a PSP Tx association.
> +      attribute-set: assoc
> +      do:
> +        request:
> +          attributes:
> +            - dev-id
> +            - version

Version must be the same for rx and tx alloc. It is already set for
rx, so no need to pass explicitly. Just adds the need to for a sanity
check in the handler.

> +            - tx-key
> +            - sock-fd
> +        reply:
> +          attributes: []
> +        pre: psp-assoc-device-get-locked
> +        post: psp-device-unlock
> +
>  mcast-groups:
>    list:
>      -

> +static inline bool
> +psp_pse_matches_pas(struct psp_skb_ext *pse, struct psp_assoc *pas)
> +{
> +	return pse && pas->rx.spi == pse->spi &&
> +	       pas->generation == pse->generation &&
> +	       pas->version == pse->version &&
> +	       pas->dev_id == pse->dev_id;

Since struct psp_skb_ext is 64 bits, could almost implement this as
a single 64-bit match. The only outlier is spi, which is rx.spi.

Which also indicates that this is psp_pse_matches_pas_rx.

Still, the other three fields could be a single 32b comparison.
Not sure if worth the effort (using a union or cast, say).

> +struct psp_assoc {
> +	struct psp_dev *psd;
> +
> +	u16 dev_id;
> +	u8 generation;
> +	u8 version;
> +	u8 key_sz;

implied by version?

> +	u8 peer_tx;
> +
> +	u32 upgrade_seq;
> +
> +	struct psp_key_parsed tx;
> +	struct psp_key_parsed rx;
> +
> +	refcount_t refcnt;
> +	struct rcu_head rcu;
> +	struct work_struct work;
> +	struct list_head assocs_list;
> +
> +	u8 drv_data[] __aligned(8);
> +};
> +

> +int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
> +				struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct socket *socket;
> +	struct psp_dev *psd;
> +	struct nlattr *id;
> +	struct sock *sk;
> +	int fd, err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_SOCK_FD))
> +		return -EINVAL;
> +
> +	fd = nla_get_u32(info->attrs[PSP_A_ASSOC_SOCK_FD]);
> +	socket = sockfd_lookup(fd, &err);
> +	if (!socket)
> +		return err;
> +
> +	sk = socket->sk;
> +	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6) {
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    info->attrs[PSP_A_ASSOC_SOCK_FD],
> +				    "Unsupported socket family");

Should this also check sk_type?

> +
> +struct psp_dev *psd_get_for_sock(struct sock *sk)

Same as other support functions, consider spelling it out fully as
psp_dev_get_for_sock.

> +{
> +	struct dst_entry *dst;
> +	struct psp_dev *psd;
> +
> +	dst = sk_dst_get(sk);
> +	if (!dst)
> +		return NULL;
> +
> +	rcu_read_lock();
> +	psd = rcu_dereference(dst->dev->psp_dev);
> +	if (psd && !psp_dev_tryget(psd))
> +		psd = NULL;
> +	rcu_read_unlock();
> +
> +	dst_release(dst);
> +
> +	return psd;
> +}

> +void psp_reply_set_decrypted(struct sk_buff *skb)
> +{
> +	struct psp_assoc *pas;
> +
> +	rcu_read_lock();
> +	pas = psp_sk_get_assoc_rcu(skb->sk);
> +	if (pas && pas->tx.spi)
> +		skb->decrypted = 1;
> +	rcu_read_unlock();
> +}
> +EXPORT_IPV6_MOD_GPL(psp_reply_set_decrypted)

semicolon

> -- 
> 2.47.1
> 



