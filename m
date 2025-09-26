Return-Path: <netdev+bounces-226819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4334ABA560F
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E866C743DC5
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2E29BDA4;
	Fri, 26 Sep 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRj5GLY5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7701388;
	Fri, 26 Sep 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758928967; cv=none; b=a1Ihjf7AXaRGJ79UVwDMNsQHcq7eQZqO7NibzIm00pCfKmCX/XQFVr2ylCV2ZnvDrF/7goCmdxIqfU1MNtmSM3nnbIVWS9hFWZJYLE6Xgh9057PuMe0nGrcBQCLjyXvd8dPwYdV/wcIu6aZHYE7AEaDMZpog6ffdKYm/pUlKd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758928967; c=relaxed/simple;
	bh=oUgsZRPbtscNRoSHTfS39WafgqSCWlckUAttN5x6CIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7fqxECgiRQY7eqA+ggF+5l7r57dsLLSNjawSreS55l5VjwI0S5K8nAxN+o7WbGbdrDiSiQz5MWAEOwB2SDCF+7WwTlARpU9hSN6wb20ml9Xg2cXAZo/QD8qjnb5Trbxm6xLq5D+u5kNDzJZn/Gq3j8kqyJiToucW5rCipS3xIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRj5GLY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BA5C4CEF4;
	Fri, 26 Sep 2025 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758928966;
	bh=oUgsZRPbtscNRoSHTfS39WafgqSCWlckUAttN5x6CIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TRj5GLY542Wn5H88+Yt9Ixx8IcUdj4E6c9OxwWB8kmY0jJxnL/zEyNfS9ijUN40iS
	 1t1eoQ6G01NHmVxD3saAraefRMe1ftC2fqXvJKssI6kkKaNO2iGIUal1Wq+aNLcFs+
	 xUlno5CTyTu4ecQrj4NFNkD8g0uX/VvYFc2TUwXYcZavLI8J1Tky2RXM+larU9+kw8
	 bd7g+EWhoGXxztfvxeUfw+BAxAsz+snQErGKjAQS6twznPuXi3W44GE44L9sO2P3It
	 iJ55/igosQBBtqCjnsahMU8sFeC8NZh0mAffkSziRXaENwKVBQtNB9EwIPlqTE9Ctl
	 gVBkTPqgGu/4g==
Date: Fri, 26 Sep 2025 16:22:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry
 <almasrymina@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 2/2] net: devmem: use niov array for token
 management
Message-ID: <20250926162245.5bc89cfa@kernel.org>
In-Reply-To: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea@meta.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
	<20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 09:31:34 -0700 Bobby Eshleman wrote:
> @@ -2530,8 +2466,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
>  		 */
>  		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
>  			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> +			struct net_devmem_dmabuf_binding *binding;
>  			struct net_iov *niov;
>  			u64 frag_offset;
> +			size_t size;
> +			size_t len;

unused variables here

> +			u32 token;
>  			int end;
-- 
pw-bot: cr

