Return-Path: <netdev+bounces-137764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06609A9AF7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52478B24494
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562C15250F;
	Tue, 22 Oct 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rW5Jha/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642E1494BF
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581987; cv=none; b=Nuov1K325FpM/uTD1kdo5QhpHi0SlG//WTBsvndNoYk8ua3Li9a2I/2DUnvNnAJOIc8Ymzd2ovMoOU4JbjA4V4tbtwrhv0l42lE8y2rIpQByyfgLU68lUKXEY1QhM4egZAsnHKaKr98IoduREZz5sqMFlhUhreEstfswq7fynus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581987; c=relaxed/simple;
	bh=QXftKrPb3VEFG7E4D13QJJzYRnaqeJinmUo5nLfm0nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKxtZt8/pxo9yTeTFyWnDK5HUdUV5u7bN5HwDVtnozuBkAJ3ynDRhn+tnH1+9EeMEfaHui/XGvgLgyfgROFK5LKy+6s/tEEJifq8woJiPX4hps2RGr4pKxdGNHXVLlwv5n5jr0PLQANqwAGhN/mWp3rOs1SwFMV5/Wy/0pTMZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rW5Jha/0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso1649664a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729581984; x=1730186784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXO/MgMISfZY587Sbu/ZaG0vtXKQF5OZjUxTzgJg378=;
        b=rW5Jha/0yvZiYRnmltP30zFmrVKKxFhpNvQrbckZ+FBKWWFYO9xu6cJMN/cwsjQPF5
         Gj5g8x537LAnUfwKRJ7ny/xqM6nXnnda9vZOAML+b6hB7hzSszeZiydbHsI5Fs4GPPcR
         WiBRi7j7Dpygbrv+B9tLMc/yPeCV0qwHPaTcASCJErFHd7+z4QaSTu6PkvMX1ehic7jd
         KwMGRNZNZyan+MCyCOxdgmwrF3xAu/ALr5EKnF/8FZCLOJ5Cke0SaKVnvFpCLZQl14xY
         uP9fhPz73KG2+6qcujFK0rULXVdHVp7j6lQuPJm8QMz53Z9WRZhX1VTLUJ8Xfgu4kdQ2
         IejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729581984; x=1730186784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXO/MgMISfZY587Sbu/ZaG0vtXKQF5OZjUxTzgJg378=;
        b=bXLFr9zEeUo503XkFu1UlGMHcY1ZX5oeFagBGis7hoVAB0durJvPJ2gQvIzksmzVk+
         H1/MBUpDULvcpf9oujrwZmH9FE49tUOAE35Vf07Crx8235grnrVyMPcpt9uvnj2sn3X6
         Gj2CyrM3bJXrDgcLMqteJlSRGO2bFTQqYKwh5+Y6kt1Z8JO41/DSLOX6oajzXJ7f2oDa
         ZOhCJ7nX1qFcQKd9jXO1XzNRrGVzu/hcpBHF9Rlp4PeBrCX3SMC2SS/2nfupK+lb0B86
         tvaLzoB+GgGESqE3glZJEQNKy5ggTminNS2I71in99Xs5ukjUv5sJ8K8pExtZWIPaX6g
         pL6g==
X-Gm-Message-State: AOJu0Yw5ChbSeko7XatWXT+XGz0CsooAyLPrn+cCad522Lp2uXULYzgj
	HDfEEmXJVtzEy8wRye83sPLBnBnzKa3s+PpTndUv4ubJH5GiggQhRy0STfuENdpkAUWtxWsANhL
	WXI2h8uU4Xmh9rJeSVTrMNwt6IkggyZlLsMxF
X-Google-Smtp-Source: AGHT+IGvIFh3aWOCyffW3tOLWj8o8Nt4Oixx2u7dI6KxZ+6OvwMBz0qnU6pi3n3wcPOKWJ4HeBky9A0NRbL5VogVr90=
X-Received: by 2002:a05:6402:2548:b0:5c7:202f:ec9b with SMTP id
 4fb4d7f45d1cf-5ca0ac61ec7mr14570189a12.16.1729581983971; Tue, 22 Oct 2024
 00:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022070921.468895-1-idosch@nvidia.com>
In-Reply-To: <20241022070921.468895-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 09:26:11 +0200
Message-ID: <CANn89iLHV5NqHPjRp6W77c1DFtOBDmBs1sWR5+W_405NvOBs7g@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, pshelar@nicira.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:10=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> The per-netns IP tunnel hash table is protected by the RTNL mutex and
> ip_tunnel_find() is only called from the control path where the mutex is
> taken.
>
> Convert hlist_for_each_entry_rcu() in ip_tunnel_find() to
> hlist_for_each_entry() to avoid the suspicious RCU usage warning [1] and
> add an assertion to make sure the RTNL mutex is held when the function
> is called.
>
> [1]
> WARNING: suspicious RCU usage
> 6.12.0-rc3-custom-gd95d9a31aceb #139 Not tainted
> -----------------------------
> net/ipv4/ip_tunnel.c:221 RCU-list traversed in non-reader section!!
>
> other info that might help us debug this:
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> 1 lock held by ip/362:
>  #0: ffffffff86fc7cb0 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3=
77/0xf60
>
> stack backtrace:
> CPU: 12 UID: 0 PID: 362 Comm: ip Not tainted 6.12.0-rc3-custom-gd95d9a31a=
ceb #139
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xba/0x110
>  lockdep_rcu_suspicious.cold+0x4f/0xd6
>  ip_tunnel_find+0x435/0x4d0
>  ip_tunnel_newlink+0x517/0x7a0
>  ipgre_newlink+0x14c/0x170
>  __rtnl_newlink+0x1173/0x19c0
>  rtnl_newlink+0x6c/0xa0
>  rtnetlink_rcv_msg+0x3cc/0xf60
>  netlink_rcv_skb+0x171/0x450
>  netlink_unicast+0x539/0x7f0
>  netlink_sendmsg+0x8c1/0xd80
>  ____sys_sendmsg+0x8f9/0xc20
>  ___sys_sendmsg+0x197/0x1e0
>  __sys_sendmsg+0x122/0x1f0
>  do_syscall_64+0xbb/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ip_tunnel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index d591c73e2c0e..a93c402f573e 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -218,7 +218,9 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tun=
nel_net *itn,
>
>         ip_tunnel_flags_copy(flags, parms->i_flags);
>
> -       hlist_for_each_entry_rcu(t, head, hash_node) {
> +       ASSERT_RTNL();
> +
> +       hlist_for_each_entry(t, head, hash_node) {
>                 if (local =3D=3D t->parms.iph.saddr &&
>                     remote =3D=3D t->parms.iph.daddr &&
>                     link =3D=3D READ_ONCE(t->parms.link) &&
> --
> 2.47.0
>

I was looking at this recently, and my thinking is the following :

1) ASSERT_RTNL() is adding code even on non debug kernels.

2) It does not check if the current thread is owning the RTNL mutex,
only that _some_ thread is owning it.

I would think that using lockdep_rtnl_is_held() would be better ?

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d591c73e2c0e53efefb8fb9262610cbbd1dd71ea..25505f9b724c33d2c3ec2fca535=
5d7fdd4e01c14
100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -218,7 +218,7 @@ static struct ip_tunnel *ip_tunnel_find(struct
ip_tunnel_net *itn,

        ip_tunnel_flags_copy(flags, parms->i_flags);

-       hlist_for_each_entry_rcu(t, head, hash_node) {
+       hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()=
) {
                if (local =3D=3D t->parms.iph.saddr &&
                    remote =3D=3D t->parms.iph.daddr &&
                    link =3D=3D READ_ONCE(t->parms.link) &&

