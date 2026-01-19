Return-Path: <netdev+bounces-251054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A88D3A70C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0265302BBBE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8C28D8D1;
	Mon, 19 Jan 2026 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HywpMgEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69380846F
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822713; cv=none; b=MgM7gKREsx4napeIZlB6dOfDUVyDJ2jjA5k93eWP85Kl7FBid/uLnknGEm2BfK1WqijV4k7xq7X8a2Z2FFfyViRuFYLd7lscEZXLZrzsuBr4qBGlqycRIOlB4lTNAUbTzjzC05u20QKEFyOeVZfaGsRmmPLoy/QkB1W7BPV/Noc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822713; c=relaxed/simple;
	bh=cntmWMzUKE5gwf3tkVHGDNT7Q0ZbaacON2u3VmU+rrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO/E5pGwlRZD1CCaJn4EbbMreMxwnXzM40n40/zkrxEl9BjhHWcywNtcQThV2suwyjrMYBeY4p4dY9a9osSX0U6dGsAWRoSpag7BeHl102WfmPYrXELkTAodp2lcpbEBr6BwDY06EEURKxiC93BDIwJsqwLS9EL0js+NWDY5gDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HywpMgEw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50146fcf927so44947371cf.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768822711; x=1769427511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k3Awf9rgyQjObvkpmEnEoMiyeZVjM1YlDDV6KpWYk4=;
        b=HywpMgEwkGM7uzpxdGqI+bMUxAVhF1vEIw4ZhvKRiJcTj+gznvzQ5dBNVL2JIZFbyR
         eVdAqcOh8aLqfkkSpVb0xVlRXYCyPaBg2NHqt/mUJmwUU6P1mNNlEJDvk4bfEg9EsXr9
         Qic2dNjE36FwBFT8vvLdveJcoq4ZLtApbUb+Du7L4IDbVjcaLCJQ6UcYRRkMBnBic2oO
         nY3whZaYk9RrW4RZc7syQIyqpxQBicNU+/HR4k88kx4DWp9+53IGKLGnnYMiiheXtZUt
         91dfeGRJLD08s753fjVnM4cBFj53I/WrKeVhbxVIqKEkNcyNrS5k3BnNaJT5c4fALBFn
         vHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768822711; x=1769427511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0k3Awf9rgyQjObvkpmEnEoMiyeZVjM1YlDDV6KpWYk4=;
        b=S3NaMXaZf1oVkozT+Nbf9lBGFTDKACt/6snFCVCj8hn2+33nNVgG7REUDMHqm/RYz3
         uC77eFt+bisYNd9zdf0gKhllMpUdoQXnJjcjdFS5K5r0QZy3DuJrxKYdUEpE5IWad63/
         MEOQ9+3fxOPVNEdBaMgKf63edu1jIvqJAKInUlXuPemv60Bf5IXGJApmo0zXIV04TSjJ
         7r0G/TVmPv0q+8bLWy6Rdt+y/4E0T5wdiFSS9AtK2R8k3Y77uhtBFhpXtyWiMvgf8EZa
         Mu2UVytG7Wu42u9kaQ4f1zKTpstHPPzDYZtrs8yHGhDiZE9zSkBpFGICqsYoP5KW1YcH
         51BQ==
X-Gm-Message-State: AOJu0YwyK2nGasjvfFOmnKvFEGOATR9F+uBIyAzughaJx1vxRX6KCzHh
	IbKE8lZNw1pjWaeQYdEERn37acBTy2o7wDXTZJR4PEXTVRQBnYTlm6z6hJ2qyN2N8j+K7nZgf39
	aEDMKMq/WXZY8aZC577LaUbc25KrSmcIJ5QwFXiOA
X-Gm-Gg: AY/fxX47EtLpUW5Z0cEK9uddajEjZzB4Vj+8XBUHCe70V/GJny4+2g3NGa/0hx2aei6
	0ygGqe0xcmvV6lKyWIvPhU7EUT+GUvceAk4ytEGFE4IttIBWrxlPtq+PFv899A7VFatNRoLh9wN
	BgAEZZ/6dV6gn8GqlteGdomYb5GNDqvSNG6xLWq57FqPBXdNKggGwxVtRz9gA58cCIConhUMRtQ
	/5nWr/9qCacp28274SBlF+LsCKhZ7thDK0Tm7tK9Z14SRSsHIfShssQysP0OdlrOE8K9Es=
X-Received: by 2002:ac8:7d16:0:b0:4ff:7eaf:6fa1 with SMTP id
 d75a77b69052e-502a156ae5dmr153563511cf.11.1768822710799; Mon, 19 Jan 2026
 03:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119112512.28196-1-fw@strlen.de>
In-Reply-To: <20260119112512.28196-1-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Jan 2026 12:38:19 +0100
X-Gm-Features: AZwV_Qgjrjj4cIBMKe0pYQTORTTXcQrzW9omFStAvrR7aUKFDIeHL8wuv5qqINE
Message-ID: <CANn89i+Akf5vcL2zzgWrfs7D=h2pov5DmKKckw+3XK9Sjav=yw@mail.gmail.com>
Subject: Re: [PATCH net v3] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, kuba@kernel.org, 
	davem@davemloft.net, Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 12:25=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> I added skb_vlan_inet_prepare() helper in the cited commit, hinting
> that we would need to use it more broadly.
>
> syzbot confirmed this was the case in ip6_gre.
>
> uninit-value in ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6ta=
ble_mangle.c:72
>  ip6t_mangle_out net/ipv6/netfilter/ip6table_mangle.c:56 [inline]
>  ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6table_mangle.c:72
>  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
>  nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
>  nf_hook include/linux/netfilter.h:269 [inline]
>  __ip6_local_out+0x5ac/0x640 net/ipv6/output_core.c:143
>  ip6_local_out+0x4c/0x210 net/ipv6/output_core.c:153
>  ip6tunnel_xmit+0x129/0x460 include/net/ip6_tunnel.h:161
>  ip6_tnl_xmit+0x341a/0x3860 net/ipv6/ip6_tunnel.c:1281
>
> Uninit was stored to memory at:
>  ip6_tnl_xmit+0x34f7/0x3860 net/ipv6/ip6_tunnel.c:1277
>  __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
>  ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
>  ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4091 [inline]
>  slab_alloc_node mm/slub.c:4134 [inline]
>  __do_kmalloc_node mm/slub.c:4263 [inline]
>  __kmalloc_node_track_caller_noprof+0x6c7/0xf90 mm/slub.c:4283
>  kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
>  pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
>  skb_realloc_headroom+0x140/0x2b0 net/core/skbuff.c:2355
>  ip6_tnl_xmit+0x2106/0x3860 net/ipv6/ip6_tunnel.c:1227
>  __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
>  ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
>  ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922
>
> Fixes: d8a6213d70ac ("geneve: fix header validation in geneve[6]_xmit_skb=
")
> Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6023ea32e206eef7920a
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mazin Al Haddad <mazin@getstate.dev>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  v3: pass 'true' argument to skb_vlan_inet_prepare to not change network
>  header offset.

Ah right, this escaped my radar, thanks Florian !

