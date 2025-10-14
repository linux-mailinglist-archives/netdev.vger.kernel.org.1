Return-Path: <netdev+bounces-229247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE520BD9C77
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBE3BB533
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25330E85D;
	Tue, 14 Oct 2025 13:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0742F5327
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449224; cv=none; b=qNoxgnCpFc1whHeHwmp3kxQwgiK6Q6K8UcSpPL2vgNuZnkdJk57bo5+oCWKYBSl2NwIagm+KnNRhQa88zVPIkWm2qXsYqeEKaoDwWH6Z4KDS4xOPY9obhdsNMdOL3+bW8qUDqGgT9ScrFlsFAbBX6qAfNEbmNeOmH71ONoq8B/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449224; c=relaxed/simple;
	bh=QWZJ4slRIq+R7lMIy2b4esTwgpk/O7LKiER1jDZdsYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5wpiir8I1xA3O9UrqjOUxjx3t0PeyOH6xVS+WVK0iN5Vu6UoQsbk4CBJ4ElC290wmSOfdHhto4tVuOwprTyP27gwt6eMmC6kRsw/77e1ukiGwJe90gMzYzePSpL7/l/k/KIndfA0U1ygktZsha9KTF4eq+PnajKam8k7BS4SNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B4F7D60321; Tue, 14 Oct 2025 15:40:20 +0200 (CEST)
Date: Tue, 14 Oct 2025 15:40:15 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
Message-ID: <aO5Sv9GEEPl6zAE5@strlen.de>
References: <20251014060454.1841122-1-edumazet@google.com>
 <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
 <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
 <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
 <tdxplao4k3tru2ydqrjg5wzt4mmllblmilys456y7latayvdex@3l7xabhdjf2d>
 <CANn89iKQYN1qTZoSW4+1v6scDgH53zi9pP_O_mEbTdYQYie1uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKQYN1qTZoSW4+1v6scDgH53zi9pP_O_mEbTdYQYie1uQ@mail.gmail.com>

Eric Dumazet <edumazet@google.com> wrote:
> Thanks for testing. I will follow Sabrina suggestion and send :
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..d66f273f9070 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>                 sk_peek_offset_bwd(sk, len);
> 
>         if (!skb_shared(skb)) {
> -               if (unlikely(udp_skb_has_head_state(skb)))
> -                       skb_release_head_state(skb);
> +               /* Make sure that this skb has no dst, destructor
> +                * or conntracking parts, because it might stay
> +                * in a remote cpu list for a very long time.
> +                */
> +               DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> +               DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> +               DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
>                 skb_attempt_defer_free(skb);

Are there cases where we expect to pass skb which violate this to
skb_attempt_defer_free()?

If no, then maybe move existing checks in skb_attempt_defer_free() up and
apped the skb_nfct check there so syzbot can blame other offenders too.

