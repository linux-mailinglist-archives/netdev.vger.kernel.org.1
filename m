Return-Path: <netdev+bounces-101753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E078FFF5E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429E12889AB
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB67815B986;
	Fri,  7 Jun 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UygIkChc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDE15B552
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752323; cv=none; b=PtnzraA/DKJp7G07qQTNSxj3BFBebm4uzkhjqIzLlKORj0ipp8QxjTwnMj0CzA+H3XS9zOxfDsJt7uME+75Up8eNBkSdnkXOYgowG7otvvCkXnV7u9ghFuafnE4KuVFbH4YIFGjHNVQlLLL0YweLsggl9TeuPKRGd8jAhuFcqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752323; c=relaxed/simple;
	bh=ztnzsXMOnQoBzvV4D7EflV3YRxDgpe1NeDBVLAoLFso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPM4yTtuC257N0NtBkMNu37a9fsHawKhFhM7FN6BYse0pGGPIqeRqosdfW9LqFr7gV8Vcqto2ZNEJEZD+6iw6I0jtABOF1gyJK7pvYuB3q4Ey/QRHkJmNlbO5SAaLlsQ67z3sCL0fVz6KMPCqGF/MdOiW/6bmaCAqOW9J72AR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UygIkChc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so6131a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717752320; x=1718357120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyjd+vh3aiiXZ15aghWc+zKeIWazhMBZHSZywZPOjeI=;
        b=UygIkChcqh1iUlgfA889ZxlRS6f0tVB/e2rbyVaP199rxoNyzEw4lET8AOjskbd1mF
         bkxevdVbss3M/K6EcwtS9wOLY0Z+nSP5BqC+cbyCQHS0Jd14JjWJSEkoLE21txAjPBEo
         aGuaN4ER4rQnXPxrqYVKqJ2/vxR+VxBmj4Q/Ez/PHQALmeZZ3KgnpoZH9qJvRwh/nCGH
         y7ONeDfJfW3qf89T3gjqJ5mJjtd0iC4UzdrqMcbRFkdYqyEdVlITJ951oP8WyRKgtcpb
         CVbeS5NF2nEXb/Lw/8+zLiywRQoA6K5/RWQMLF8FNc1yW1VVMhemUzXHVoJ7Usw5FqPz
         7ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752320; x=1718357120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyjd+vh3aiiXZ15aghWc+zKeIWazhMBZHSZywZPOjeI=;
        b=g4eo4V4BEpBOc2Oh9vdlMQIRElS85ySEh7SX36t1NrcadGhfQW9CFQ6517xNEqUCkb
         W6jqDs4nDdGjBgUfDlPv84IhTudDC1vUzq1e5Gp5569PWsGoK18yw1E66Cvfpq4toHXm
         TuKcr+8qqRyRTgPHn4oSg0UIVGNxZ5oNPMRUqlp/JCE7A8/UEZ9gfKzKsoEjLplzEmGg
         /DWlZdPCAzW8+K0+eQeLdABnAZxy/xXbtjE1krGARRCDdrNxMtNRXiFElMjfhYDa9z+S
         azkT8dd7cZJCSzrvWr6GpXX4o7x3UhimVu3oj66lVAKFIYqmEvztnfscTmbO4dMJtIQS
         4x5Q==
X-Gm-Message-State: AOJu0YwWxjfsRTuoEG9yQSW9T6L9SeRWtyJ1i1h6BzWgCUH2SY0ASK/U
	mDhSLEv4hndOvYv6A9wzR85sMfM8Nz2ADgKBDjRsNOa70PllAC+c+LtzskNTAtwsXVi4f6OUQfX
	KWgeVfTRhMrXu/FtKN2+evq44qPWgz9Abb0W1
X-Google-Smtp-Source: AGHT+IFY+e05JglJssHOD0lwpr4BcdSqLx9yyuaiJwTq82TryzLJboei//mGj8DWkhTvn06RcdAPeFzYBkThn6e4LHc=
X-Received: by 2002:a05:6402:5d94:b0:57a:1937:e2a4 with SMTP id
 4fb4d7f45d1cf-57aacb86e0amr416565a12.3.1717752318649; Fri, 07 Jun 2024
 02:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607083205.3000-1-fw@strlen.de> <20240607083205.3000-2-fw@strlen.de>
In-Reply-To: <20240607083205.3000-2-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 11:25:07 +0200
Message-ID: <CANn89i+50SE0Lnbpj1b1u62CyOfVxH25bneXnc3e=RJB0+jJ9g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: add and use skb_get_hash_net
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org, 
	pablo@netfilter.org, willemb@google.com, Christoph Paasch <cpaasch@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:36=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Years ago flow dissector gained ability to delegate flow dissection
> to a bpf program, scoped per netns.
>
> Unfortunately, skb_get_hash() only gets an sk_buff argument instead
> of both net+skb.  This means the flow dissector needs to obtain the
> netns pointer from somewhere else.
>
> The netns is derived from skb->dev, and if that is not available, from
> skb->sk.  If neither is set, we hit a (benign) WARN_ON_ONCE().
>
> Trying both dev and sk covers most cases, but not all, as recently
> reported by Christoph Paasch.
>
> In case of nf-generated tcp reset, both sk and dev are NULL:
>
> WARNING: .. net/core/flow_dissector.c:1104
>  skb_flow_dissect_flow_keys include/linux/skbuff.h:1536 [inline]
>  skb_get_hash include/linux/skbuff.h:1578 [inline]
>  nft_trace_init+0x7d/0x120 net/netfilter/nf_tables_trace.c:320
>  nft_do_chain+0xb26/0xb90 net/netfilter/nf_tables_core.c:268
>  nft_do_chain_ipv4+0x7a/0xa0 net/netfilter/nft_chain_filter.c:23
>  nf_hook_slow+0x57/0x160 net/netfilter/core.c:626
>  __ip_local_out+0x21d/0x260 net/ipv4/ip_output.c:118
>  ip_local_out+0x26/0x1e0 net/ipv4/ip_output.c:127
>  nf_send_reset+0x58c/0x700 net/ipv4/netfilter/nf_reject_ipv4.c:308
>  nft_reject_ipv4_eval+0x53/0x90 net/ipv4/netfilter/nft_reject_ipv4.c:30
>  [..]
>
> syzkaller did something like this:
> table inet filter {
>   chain input {
>     type filter hook input priority filter; policy accept;
>     meta nftrace set 1                  # calls skb_get_hash
>     tcp dport 42 reject with tcp reset  # emits skb with NULL skb dev/sk
>    }
>    chain output {
>     type filter hook output priority filter; policy accept;
>     # empty chain is enough
>    }
> }
>
> ... then sends a tcp packet to port 42.
>
> Initial attempt to simply set skb->dev from nf_reject_ipv4 doesn't cover
> all cases: skbs generated via ipv4 igmp_send_report trigger similar splat=
.
>
> Moreover, Pablo Neira found that nft_hash.c uses __skb_get_hash_symmetric=
()
> which would trigger same warn splat for such skbs.
>
> Lets allow callers to pass the current netns explicitly.
> The nf_trace infrastructure is adjusted to use the new helper.
>
> __skb_get_hash_symmetric is handled in the next patch.
>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/494
> Signed-off-by: Florian Westphal <fw@strlen.de>

Nice, I had an internal syzbot report about the same issue.

Reviewed-by: Eric Dumazet <edumazet@google.com>

