Return-Path: <netdev+bounces-207340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3529B06B12
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3187AEC32
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650720C00C;
	Wed, 16 Jul 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr0ViDCB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E462E3700
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628958; cv=none; b=ekmXMvRKoMQL+UWJs6HkTcDLgCLlAlESWtKiuBbDVKJ0M7hBFVeicbi+F51ZWsOQLkJ4rOAB/muwGX45zN/javhm4w3MvWksY3KpGz28uGdtDVMLXBeVk8eHE1mmYfaDez4kPhw882zGLtiL7Q5DoAiJeUXvpR5OFq7Zfe1ecGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628958; c=relaxed/simple;
	bh=vXfDI19rd6mivpXz0O0GR91PA3Hm3B9v3j1jum1UY2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAIVVsCMZXlIoR5o9KGql3FFsGGKTklAdBHL+V9TsiRF2TA3ZqpoISSG31zcksrfePqx4NKY7j+eeY0SDWsyGbPHWv0PS9L6eh24IK5hh9hIyUedZp/IIXt+kHOq8izSSWNW1Sbf9u/z8MY7jtY3ktiNc/sZgDWyLtrn+0Mlx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr0ViDCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8CDC4CEE3;
	Wed, 16 Jul 2025 01:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752628958;
	bh=vXfDI19rd6mivpXz0O0GR91PA3Hm3B9v3j1jum1UY2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gr0ViDCBIWstDyhZi/3o4Y23RFFSSbHPp7dNBPOlM5sWLrYOx6VDERx+xQE/EqrYi
	 GTFx5jDaTgvb55Ot0jbOjwbdEDI+z9wDC8qqMUwDd3lrk+ff2XdcccX3PfnVOO8pD6
	 RoxkfxhZqnAm2XNlckbO1k3F6UGh6hrIZSABhe4xGAwLrOKuoe88Jg1JqCbVkJAtFN
	 PoXsmXi5ekji8Zf5oM9HuNB0YeKhZpfGWlrY8DevJYjPkLDc6SyMUATuFU987Q44Eh
	 rT/z6+hCY91V+nObPXUNbr6ivzhzSA/pilIdCqxL4kPdILS657IaObehm623GZHhup
	 Ip8z0qSheu/bw==
Date: Tue, 15 Jul 2025 18:22:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 02/15] neighbour: Move two validations from
 neigh_get() to neigh_valid_get_req().
Message-ID: <20250715182236.317f232d@kernel.org>
In-Reply-To: <20250712203515.4099110-3-kuniyu@google.com>
References: <20250712203515.4099110-1-kuniyu@google.com>
	<20250712203515.4099110-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 20:34:11 +0000 Kuniyuki Iwashima wrote:
>  	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
>  					    NDA_MAX, nda_policy, extack);
>  	if (err < 0)
> @@ -2951,11 +2957,14 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
>  	}
>  
>  	for (i = 0; i <= NDA_MAX; ++i) {
> -		if (!tb[i])
> -			continue;
> -
>  		switch (i) {
>  		case NDA_DST:
> +			if (!tb[i]) {
> +				NL_SET_ERR_MSG(extack, "Network address not specified");
> +				err = -EINVAL;
> +				goto err;
> +			}

Any idea why this attr validation is coded up so weirdly?

NDA_DST is 1, so we could make this whole thing:

const struct nla_policy nda_get_policy[] = {
	[NDA_DST]		= { .type = NLA_BINARY, .len = MAX_ADDR_LEN },
};

	err = nlmsg_parse(nlh, sizeof(struct ndmsg), tb,
			  ARRAY_SIZE(nda_get_policy) - 1,
		  	  nda_get_policy, extack);

and then no looping over the attributes would be necessary.

I'd also be tempted to replace the extack string with
	NL_SET_ERR_ATTR_MISS(extack, NULL, NDA_DST);
but I'm biased towards YNL :)

