Return-Path: <netdev+bounces-28194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2DC77E9DE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A981F2817E5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15D61775A;
	Wed, 16 Aug 2023 19:45:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DA17738
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 19:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A8C433C8;
	Wed, 16 Aug 2023 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692215117;
	bh=jMLHFGC1zXcDINUDiyKXfSXD+P0geE2aFulULXegssM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmVqtCAnkjvLENgirfohcj8c/+Z9RBH247FogKChlTivHMSJibwWabyP/QBRhxW69
	 nDouXjM/2Sc7P1gtt8oYhA2d4rwjuNA6G+E1m319zEnIk2wioTl60uxzeOGjY8dj61
	 Qr5SaNk0/QZXkuTf5I5mAzX5twSn2Wu1b9dcjx6YdGsdRI0FuM0dTyky81aYdIHbRF
	 uehDAJpNBXAjLQIr83Pjc7XSm5+EmWbG7JyNacFJ2MrlHi4YYPAWGpKCAWmjPpjKiv
	 UUlicXNE6Ohd+eG8OOxHm1X5bXXJvRZ0Gvcgn/p42gayjlPJyUsTT5HvB7kJlpYfiu
	 n7Qo+UkhReRJQ==
Date: Wed, 16 Aug 2023 21:45:06 +0200
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bob Gilligan <gilligan@arista.com>,
	Dan Carpenter <error27@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Donald Cassidy <dcassidy@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	"Gaillardetz, Dominik" <dgaillar@ciena.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ivan Delalande <colona@arista.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	"Nassiri, Mohammad" <mnassiri@ciena.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <simon.horman@corigine.com>,
	"Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v10 net-next 10/23] net/tcp: Wire TCP-AO to request
 sockets
Message-ID: <ZN0nQqIwXp5cQJTR@vergenet.net>
References: <20230815191455.1872316-1-dima@arista.com>
 <20230815191455.1872316-11-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815191455.1872316-11-dima@arista.com>

On Tue, Aug 15, 2023 at 08:14:39PM +0100, Dmitry Safonov wrote:

...

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 8dfa0959e403..7178e8bab922 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c

...

> @@ -1194,9 +1198,51 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
>  static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>  				  struct request_sock *req)
>  {
> +	struct tcp_md5sig_key *md5_key = NULL;
> +	const struct in6_addr *addr;
> +	u8 *traffic_key = NULL;
>  	int l3index;
>  
>  	l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
> +	addr = &ipv6_hdr(skb)->saddr;
> +
> +	if (tcp_rsk_used_ao(req)) {
> +#ifdef CONFIG_TCP_AO
> +		struct tcp_ao_key *ao_key = NULL;
> +		const struct tcp_ao_hdr *aoh;
> +		u8 keyid = 0;

Hi Dmitry,

keyid is declared and initialised here.

> +
> +		/* Invalid TCP option size or twice included auth */
> +		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
> +			return;
> +		if (!aoh)
> +			return;
> +		ao_key = tcp_v6_ao_do_lookup(sk, addr, aoh->rnext_keyid, -1);
> +		if (unlikely(!ao_key)) {
> +			/* Send ACK with any matching MKT for the peer */
> +			ao_key = tcp_v6_ao_do_lookup(sk, addr, -1, -1);
> +			/* Matching key disappeared (user removed the key?)
> +			 * let the handshake timeout.
> +			 */
> +			if (!ao_key) {
> +				net_info_ratelimited("TCP-AO key for (%pI6, %d)->(%pI6, %d) suddenly disappeared, won't ACK new connection\n",
> +						     addr,
> +						     ntohs(tcp_hdr(skb)->source),
> +						     &ipv6_hdr(skb)->daddr,
> +						     ntohs(tcp_hdr(skb)->dest));
> +				return;
> +			}
> +		}
> +		traffic_key = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
> +		if (!traffic_key)
> +			return;
> +
> +		keyid = aoh->keyid;

And reinitialised here.
But is otherwise unused.

Flagged in a W=1 build with both clang-16 and gcc-13.

> +		tcp_v6_ao_calc_key_rsk(ao_key, traffic_key, req);
> +#endif
> +	} else {
> +		md5_key = tcp_v6_md5_do_lookup(sk, addr, l3index);
> +	}
>  
>  	/* sk->sk_state == TCP_LISTEN -> for regular TCP_SYN_RECV
>  	 * sk->sk_state == TCP_SYN_RECV -> for Fast Open.

...

