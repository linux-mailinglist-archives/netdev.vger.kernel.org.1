Return-Path: <netdev+bounces-94336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D78BF35A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E198928BB32
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F9376;
	Wed,  8 May 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3d5G79O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01F364
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127060; cv=none; b=ETt0TTvIwbxHTucsiRoh4GOHaxpstC//1vm9iaEojbZc79WdTeGJwwivxYo51Ze/Nnro1bQbkU0Nd8FESAKpeS+9+5l0PH6W3lW+tsit5MAwLlgHeg8tb7+b0QaWQPFEoRIDienfKVWUkajDZ0FASX4gA3hOpxrEXIzsLiVsmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127060; c=relaxed/simple;
	bh=bduKDGL0PA459pS/wg1ricN9VVYQwJCrp+xkt9RlatA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYM4umC3hxxEo0GPFAAW4gPUxXRX4qgg9gs5kZoWuGC6AjcnKW2jJuI+KT5V6GVu2WfV0I0DryAtsbZlnJ2DiLc75tNNJacM5A87w0F7+ftG49jjcj9MrVs/PIvxjAkJa7XXVd0D+Q6aK0YjV8qCNzrD+QrUbK0t5o+MEU7HPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3d5G79O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC150C2BBFC;
	Wed,  8 May 2024 00:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715127060;
	bh=bduKDGL0PA459pS/wg1ricN9VVYQwJCrp+xkt9RlatA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I3d5G79OVJFQKQFpRpfLJsGPUgNzhbAgo2tlcmRjZ3cU/TrVVaJKWpsHcwVQl4t9X
	 1gVxEpX9D6EXr+/9zMUc2+QyrTtZc57e8r9Quq5qAwbm91D2+7MjEWKMGu7VdR+KX5
	 E8IkjysShoxDadqk3WYj5Ov0E7cMgucyyx24Awz9j1Ht3XjD3bpoGncDfTszvkSXTu
	 hxNlhaN4oYBIp+o4kIlvkO1qiP7SQV5jLnqm58hgK3xigzFwK57zodYc5hPcCIHFjm
	 AWoiBJG2j+5TahUrXBK6p1cqRIIC3ClzacIjYXmmqth1ksnIxpStO8kc9QecUS7xN0
	 ZCqUoNiAsiyIA==
Date: Tue, 7 May 2024 17:10:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 03/24] ovpn: add basic netlink support
Message-ID: <20240507171058.6ec1308b@kernel.org>
In-Reply-To: <20240506011637.27272-4-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 03:16:16 +0200 Antonio Quartulli wrote:
> +    name: nonce_tail_size

nit: typically we hyphenate the names in YAML and C codegen replaces
the hyphens with underscores (and converts to uppercase)

> +         exact-len: OVPN_NONCE_TAIL_SIZE

speaking of which - is the codegen buggy or this can be nonce_tail_size?
(or rather nonce-tail-size)

> +      -
> +        name: pad
> +        type: pad

You shouldn't need this, now that we have uint.
replace nla_put_u64_64bit() with nla_put_uint().
Unfortunately libnl hasn't caught up so you may need to open code 
the getter a little in user space CLI.

BTW I'd also bump the packet counters to uint.
Doesn't cost much if they don't grow > 32b and you never know..

> +        request:
> +          attributes:
> +            - ifname
> +            - mode
> +        reply:
> +          attributes:
> +            - ifname

The attribute lists 

> +	struct net_device *dev;
> +	int ifindex;
> +
> +	if (!attrs[OVPN_A_IFINDEX])

GENL_REQ_ATTR_CHECK()

> +		return ERR_PTR(-EINVAL);
> +
> +	ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
> +
> +	dev = dev_get_by_index(net, ifindex);
> +	if (!dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!ovpn_dev_is_valid(dev))
> +		goto err_put_dev;
> +
> +	return dev;
> +
> +err_put_dev:
> +	dev_put(dev);

NL_SET_BAD_ATTR(info->extack, ...[OVPN_A_IFINDEX])

> +	return ERR_PTR(-EINVAL);

