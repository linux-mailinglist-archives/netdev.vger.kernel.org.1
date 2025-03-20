Return-Path: <netdev+bounces-176497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7032CA6A8E8
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A74216FD76
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BD1DE4C5;
	Thu, 20 Mar 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cK0M5big"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EE1DE8B4
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481845; cv=none; b=rzCtnfR0mSB2VNlYRtS2XSwAJ241YhfEEbDgwEi6kXfw2EsZlGW1aFggqiRzWCmd8xM7uwI6m17DHL97hkP4O4/5wJrWSjhovJzbwkGc88O5yKvZmV6B8/8EdIznRGuctc6V2yztRFHCztUFF4dl3pTlnthDTIhAN/L/okEDw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481845; c=relaxed/simple;
	bh=JHzUZoR8lq5MFSvoKkJNi3J/mT9YLstA4OxDQT4tD40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yvd5/Fd+BFh8PbJL2xN9YH7oof2HJM1rfgj4Etb4zNKNMnW0F6AoNaJSyP18F2o5tjY6Lr+3O52UNLWL6qgkuv5Wm20CGY8UtvN4ik1DwTxEDaXhpkxAOf6BtjhzLtRQNw8bH2f76NpEmKhTDXcA/dQ8gZRopLIzm9XJfxA4sQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cK0M5big; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47666573242so462091cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742481843; x=1743086643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9ZTqmYe/Y7irwKFbdto8vqvrOFTVnp0VvvLxz2X3Aw=;
        b=cK0M5bigQcmD9ie/nsWoj/J90Q0bUH2YkQPUTzGbtMLdHnmC62WSbFJDXzdN+Fknx4
         m/U7otAPb0BnftYF6ATrd2C1sNw+kEQemqwkK3c9OCGIcFQLAhtPIY5TN7Wnc3aUvBdt
         iTzwc1HVdco9uEDfW4SAc/+r6C/2Q5cvO5jEoj+ON0Sax/dnx06HvU5Cznuw4QBzWZdB
         flIHgFTHYJbPJiCWuaSRhZ5Mmo5zB9rCrzGwULm1km7GBFjglK22HLAYppLyqBxF3cK6
         OS/JDyEMA9zpFguK1vMXRjmMNXiikUaHbt33xDCru2Bzvq3Qt6Oe8AsdsH7IVQQqi0Fu
         ICZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481843; x=1743086643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ZTqmYe/Y7irwKFbdto8vqvrOFTVnp0VvvLxz2X3Aw=;
        b=XjF/ErdeOjadvWzLPMbuevYZ25j10A8+x1WMFAywQ3GVFjpjoUFNGv1IVWPW94llLO
         Av1OJ4Y4Oh7WINYNJuTXdslqpa8agqGMi35TATJ/yX1vHqKWIUpXayNeU1QeN5Ek1wZW
         uLknLM40Z2V4I7pbESR8NXU4H8VHm180WEwA3lp437EvCOyzdyF1RpCOssrP+/q0Qb6S
         xMakXQhb8OvzmmMjXIvOAupkr0u8cFZcjjsSVcHDx/MgHNMKKj+H8c0cbUqxxYIKZgFE
         G9RQt0ejsTqptpvdMo4EwfPRo7mg6jGABtq2D9zHnGJrE+2+XW+GTJb0cHCWNyAoA3dj
         SxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeWNX9P2DCDXl5Rvw4/Ic8fw7VCNLGYvlpkMupbTkukLkwQk2AoJg+IKOK3maNU3UqCHVR2YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7wfso5EcYiw6N7ZZFCJ60iZWAld/BVatyIlPXdUWwTmGu2/J
	OR+mIzwc2krZlCCRBhoNs2rJkx+2aCviYplH1Gi6x5DJP3zfS/nhghcrCVn29rIsoiOUzMbu1Z4
	MRAXL8T0hx+2NZDczxiyVl6vuQ3IpL/rs6Xr5A1nLK2DbiWfQszxAD6g=
X-Gm-Gg: ASbGncust9mpwOfdzvYgkZc+Z3CdPUAAMkLC9O1S8pLTQdrjW0XxpF5IAHlZYZWIJhi
	+7N/EiHyB9gBNl4T2E2kCSkdonrQG8ZeEQReGdnQpy5uv0BHfpOVe6T8/g7w+/DzK2uQ6gb7hVk
	s1q+e/NSGDD8j3NibY2T2eJHbiOaoZ2JQjTUpIDYQ4GzeX1GQi/BIBGYhg3cE=
X-Google-Smtp-Source: AGHT+IEjL/Nj9shSfsPtRGjxxQtsoecGvydKBFwrnQD20drHw527kXYtD+oUIxpBw+bu1SgmPT5+B2GB85HeCppN5kY=
X-Received: by 2002:a05:622a:1149:b0:472:538:b795 with SMTP id
 d75a77b69052e-4771162b279mr3888411cf.22.1742481842707; Thu, 20 Mar 2025
 07:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320121604.3342831-1-edumazet@google.com>
In-Reply-To: <20250320121604.3342831-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 20 Mar 2025 10:43:46 -0400
X-Gm-Features: AQ5f1Jpa66LWn7DMpn05zoGgHtOGYBB81EiVgQ4DVJwC5ysn9OenzEB7XaRBmus
Message-ID: <CADVnQykt=1rFCBJgSu1b2sm4VQ3t=gdwZ=7cPXMFJ245dhAm4A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid atomic operations on sk->sk_rmem_alloc
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 8:16=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> TCP uses generic skb_set_owner_r() and sock_rfree()
> for received packets, with socket lock being owned.
>
> Switch to private versions, avoiding two atomic operations
> per packet.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tcp.h       | 15 +++++++++++++++
>  net/ipv4/tcp.c          | 18 ++++++++++++++++--
>  net/ipv4/tcp_fastopen.c |  2 +-
>  net/ipv4/tcp_input.c    |  6 +++---
>  4 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d08fbf90495de69b157d3c87c50e82d781a365df..dd6d63a6f42b99774e9461b69=
d3e7932cf629082 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h

Very nice. Thanks!

Reviewed-by: Neal Cardwell <ncardwell@google.com>

A couple quick thoughts:

> @@ -779,6 +779,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_so=
ck *tp, int pktsize)
>
>  /* tcp.c */
>  void tcp_get_info(struct sock *, struct tcp_info *);
> +void tcp_sock_rfree(struct sk_buff *skb);
>
>  /* Read 'sendfile()'-style from a TCP socket */
>  int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> @@ -2898,4 +2899,18 @@ enum skb_drop_reason tcp_inbound_hash(struct sock =
*sk,
>                 const void *saddr, const void *daddr,
>                 int family, int dif, int sdif);
>
> +/* version of skb_set_owner_r() avoiding one atomic_add() */
> +static inline void tcp_skb_set_owner_r(struct sk_buff *skb, struct sock =
*sk)
> +{
> +       skb_orphan(skb);
> +       skb->sk =3D sk;
> +       skb->destructor =3D tcp_sock_rfree;
> +
> +       sock_owned_by_me(sk);
> +       atomic_set(&sk->sk_rmem_alloc,
> +                  atomic_read(&sk->sk_rmem_alloc) + skb->truesize);
> +
> +       sk_forward_alloc_add(sk, -skb->truesize);
> +}
> +
>  #endif /* _TCP_H */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 989c3c3d8e757361a0ac4a9f039a3cfca10d9612..b1306038b8e6e8c55fd1b4803=
c5d8ca626491aae 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1525,11 +1525,25 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied=
)
>         __tcp_cleanup_rbuf(sk, copied);
>  }
>
> +/* private version of sock_rfree() avoiding one atomic_sub() */
> +void tcp_sock_rfree(struct sk_buff *skb)
> +{
> +       struct sock *sk =3D skb->sk;
> +       unsigned int len =3D skb->truesize;
> +
> +       sock_owned_by_me(sk);
> +       atomic_set(&sk->sk_rmem_alloc,
> +                  atomic_read(&sk->sk_rmem_alloc) - len);
> +
> +       sk_forward_alloc_add(sk, len);
> +       sk_mem_reclaim(sk);

One thought on readability: it might be nice to make these functions
both use skb->truesize rather than having one use skb->truesize and
one use len (particularly since "len" in the skb context often refers
to the payload length). I realize the "len" helper variable was
inherited from sock_rfree() but it might be nice to make the TCP
versions easier to read and audit?

Also, it might be nice to have the comments above
tcp_skb_set_owner_r() and tcp_sock_rfree() reference the other
function, so maintainers can be reminded of the fact that the
arithmetic in the two functions needs to be kept exactly in sync?
Perhaps something like:

/* A version of skb_set_owner_r() avoiding one atomic_add().
 * These adjustments are later inverted by tcp_sock_rfree().
 */
static inline void tcp_skb_set_owner_r(struct sk_buff *skb, struct sock *sk=
)
...

/* A private version of sock_rfree() avoiding one atomic_sub().
 * Inverts the earlier adjustments made by tcp_skb_set_owner_r().
 */
void tcp_sock_rfree(struct sk_buff *skb)

Anyway, the patches LGTM. Those were just some thoughts. :-)

Thanks!

neal

