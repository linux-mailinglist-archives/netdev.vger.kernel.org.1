Return-Path: <netdev+bounces-192052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56687ABE620
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DF27A31C8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440C25DAE7;
	Tue, 20 May 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnqmBqIH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507B242D89;
	Tue, 20 May 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776730; cv=none; b=a47pP4CApzk6OAmsPnbWExm2t4Lk/wWeYL9R2ozxi0ysBf3kbgX8V1hmXi1CQ7fml+kN9+wk0oY+cIbGHDsDej318QH6an1qCoLe0tTWDVZw/onKTK818bU+UxI1DdQjYH2R7nAUtvVPUF8OY9alhfsOY1+xl6eFeMrsbFkVkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776730; c=relaxed/simple;
	bh=7kNmNOGw8jU7/boFkoQt9CBk7iN0XYkjtvAos28E6Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3l7QeXzD/ty790eP+f6gPuQnmbUNWY18RzdAoBVGB1UTuU9OTFyvbWE82Ut0lzbfQoGrp3vYdXh9iGauw9x4ziJD7oqsRYxFcf3/fBOpdPK/kcFWXuyejyG8uqej3hX6DYZLUe2cvAXvFkX532c7DnzCkBj9YKI6bEk/ri0Djk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnqmBqIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B5EC4CEE9;
	Tue, 20 May 2025 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747776730;
	bh=7kNmNOGw8jU7/boFkoQt9CBk7iN0XYkjtvAos28E6Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnqmBqIH5RzGeViPD6asdxFNbGUfas0+YNLygqIm2uXcBCs4WM0XuSzgGUB8ows0m
	 276o7fq3BjSNWv5gzE1yIweeUhT3KUIW17eLASaFrtHYaFupjVUm+Kg5bXsGcStmYU
	 6430aBfAQ7cntBGfdeMd7WxWJ3RBUtlGEI3GtqlhKIIue+NX+VUQMrEzSBOB0UEM+u
	 qYLJh7GMN/jtJx8PkXHRbdrL2IkwPYxDd9mKdM7/9naTP++MqnihxMRYuheHCOsS53
	 J6HlFKN8IXZTZvivdUB1neEEqXlmFz7jjDclV/WA+oEzoQ/Rs8Gn+9XqVubM+V6PNq
	 CKu5NLAh1rN4A==
Date: Tue, 20 May 2025 14:32:06 -0700
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2] rtnetlink: do_setlink: Use struct
 sockaddr_storage
Message-ID: <202505201431.B2E1B4F8EC@keescook>
References: <20250520212147.it.062-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520212147.it.062-kees@kernel.org>

On Tue, May 20, 2025 at 02:21:51PM -0700, Kees Cook wrote:
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 6b7731739bbf..4953e202d0c0 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> [...]
> @@ -3098,10 +3088,9 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>  		down_write(&dev_addr_sem);
>  		netdev_lock_ops(dev);
>  
> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> -		       dev->addr_len);
> -		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
> -		kfree(sa);
> +		ss->sa_family = dev->type;
> +		memcpy(ss->__data, nla_data(tb[IFLA_ADDRESS]), dev->addr_len);
> +		err = netif_set_mac_address(dev, &ss, extack);
>  		if (err) {
>  			up_write(&dev_addr_sem);
>  			goto errout;

Ugh, sorry, this has a dependency on a separate patch. Please ignore
this; I will send them as a set.

-- 
Kees Cook

