Return-Path: <netdev+bounces-55393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C180AB7B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5A2281782
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C541C78;
	Fri,  8 Dec 2023 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhGcvQHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0D3A262
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 17:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DA6C433C7;
	Fri,  8 Dec 2023 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702058298;
	bh=i3zR86utGEYA7Xdspgg2zVvcSEmN9mJK9Dt3h3KxjQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WhGcvQHVQpfZnblx7HqMrQCJPPSpXYvD/lPgP+Gt4JaJU8Ey5wMPmyNfk1xZDb5zq
	 QkgJOMze1diVpRwsGVfPj9XbAQmbpzMq5dHnOypcNviprGtjQsqS4yKDHMY7tZuYNO
	 Oo4Mq70JW0KJa73PvpZbd2+YxKDhwUa1bb273H0HHQw8pijc6FIj/9OtiFpdd8Y5sM
	 llnrvN5oEont1jdLWA5yBNvkRt5MndFfvLZ9YWXOL+QAB6crbAajht8Z2orBti6d1J
	 UBBKsabERUpCHHz/XPxd9Ts0SGYzou7gIGgEApRJbov6zdH+YF9/6e7iDUDc525x97
	 52PQInXrVtk8g==
Date: Fri, 8 Dec 2023 09:58:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] netdevsim: allow two netdevsim ports to be
Message-ID: <20231208095817.5aa69755@kernel.org>
In-Reply-To: <20231207172117.3671183-2-dw@davidwei.uk>
References: <20231207172117.3671183-1-dw@davidwei.uk>
	<20231207172117.3671183-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 09:21:15 -0800 David Wei wrote:
> +	ret = copy_from_user(buf, data, count);
> +	if (ret)
> +		return -EFAULT;
> +	buf[count] = '\0';
> +
> +	cur = buf;
> +	token = strsep(&cur, " ");
> +	if (!token)
> +		return -EINVAL;
> +	ret = kstrtouint(token, 10, &id);
> +	if (ret)
> +		return ret;
> +
> +	token = strsep(&cur, " ");
> +	if (!token)
> +		return -EINVAL;
> +	ret = kstrtouint(token, 10, &port);
> +	if (ret)
> +		return ret;
> +
> +	/* too many args */
> +	if (strsep(&cur, " "))
> +		return -E2BIG;

What's wrong with scanf?

