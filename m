Return-Path: <netdev+bounces-52757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE78000F0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 02:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0051D1C20E96
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9CF17E1;
	Fri,  1 Dec 2023 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXgn6AmB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627117D9;
	Fri,  1 Dec 2023 01:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C4FC433C8;
	Fri,  1 Dec 2023 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701393922;
	bh=pA9obsUKkI3gLtmE5e/MIgsUKhFNUSwkoGABXxOXVu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qXgn6AmBfQ/Zd6RVRJTPsZAbwENL/P5ChNB5zVXW0us7mhGHTnTM9sNNTsCC9XQxN
	 L1uGh4x2n2RNCNp1RMfq9bjsLjHILqLsFEDBfDoRuu5RbUweF3Qn4DCOZPuUtfOC/W
	 cgLl/hy6IQQTBfTywH4xH6a7Ijlk+gb4RALHriraRg/4+zauwSA3WB9jIBHc6UvEMK
	 pve1ll983tzlpGE+05zeqz0RtkS54rsaP4JSXJoyKf4BX+eaGsmizKzq1dj0/9ks0B
	 AJIe6Qexsgf9KACjBa6OjE70PNGpb1hiWU6Y0mWHs9fPVNfTs8PGu3yaeu8pMQBDFs
	 wTU9Lq7vBbWSw==
Date: Thu, 30 Nov 2023 17:25:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, Jeff
 Johnson <quic_jjohnson@quicinc.com>, Michael Walle <mwalle@kernel.org>, Max
 Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <20231130172520.5a56ae50@kernel.org>
In-Reply-To: <20231130200058.work.520-kees@kernel.org>
References: <20231130200058.work.520-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 12:01:01 -0800 Kees Cook wrote:
> This has the additional benefit of being defensive in the face of nlattr
> corruption or logic errors (i.e. nla_len being set smaller than
> NLA_HDRLEN).

As Johannes predicted I'd rather not :(

The callers should put the nlattr thru nla_ok() during validation
(nla_validate()), or walking (nla_for_each_* call nla_ok()).

> -static inline int nla_len(const struct nlattr *nla)
> +static inline u16 nla_len(const struct nlattr *nla)
>  {
> -	return nla->nla_len - NLA_HDRLEN;
> +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
>  }

Note the the NLA_HDRLEN is the length of struct nlattr.
I mean of the @nla object that gets passed in as argument here.
So accepting that nla->nla_len may be < NLA_HDRLEN means
that we are okay with dereferencing a truncated object...

We can consider making the return unsinged without the condition maybe?
-- 
pw-bot: cr

