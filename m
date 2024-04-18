Return-Path: <netdev+bounces-89074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33648A961A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA2E1F229D2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02915B99A;
	Thu, 18 Apr 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVhuJf/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671515B570
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432267; cv=none; b=HSR9fSfLR+4ykO77YDKJCSe55rb1hV6Hek6tj8OJMEX+w7D1dtdMU78GxDmVuIqcwmnX+HVTm1JMhos0aymMXFPDQTCwXBp43ircl+YBWx6dlUNax8i1gBe/vYRvanPfFTNbtIxqX61h6utHeTmuNDBFpIp6ZXhYKaQcsCyuNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432267; c=relaxed/simple;
	bh=A9sVgP5Na0ivWKaLqmm+wfRJfl6C+0d8DaZyCaUF3U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWotADgBJsOGDEgSSm+1nzuIflnGOinCROPclROu/2hBw+0vNHrtf5mogzJnm29Ih8OIWPQAgqDyt21DxIVt4OeAV82GWLp1XVqUIF2vGFdGNbs1bUTLey+pWZjmCk810SGWfrlNUCkdXCCvtHLHlyTBRXMpYMccwWorOuLPA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVhuJf/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3049DC3277B;
	Thu, 18 Apr 2024 09:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713432267;
	bh=A9sVgP5Na0ivWKaLqmm+wfRJfl6C+0d8DaZyCaUF3U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVhuJf/6pzeGwnd6k1LT5v7mUdr9s31BfvwMVQwSbx62WgK8wWa1x6ebD1nCfZMeY
	 3vCcHvklp+WX6UpOu/R/tM7vhNg33eoixvFcoE0RDjV8f8zi2f/hmNm4OdtlO5wD7t
	 wumQbdQhrKEUeisMDVR37Z4aRbRX7yOck8RZAGrQ5c1v/Wk8j50eee9goQhNHDJzp4
	 pB1uTHE7f5R5RtBCFUiiNBZbhL9QXvDpTzE8gRBql9fRMVRW0zX7PtiUmX76GoL96u
	 SUHZWjBFuFOmbOwuo2qmxvfw5XQ+Kkkn+8mwihvM1o5boGzqAopiNGShf9IBv8I69n
	 SxY+VigDyYXoQ==
Date: Thu, 18 Apr 2024 10:24:21 +0100
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v10 2/3] xfrm: Add dir validation to "out"
 data path lookup
Message-ID: <20240418092421.GA3974194@kernel.org>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <274c82dfea0d656f59f69ccaab46d4319f0ef54c.1712828282.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274c82dfea0d656f59f69ccaab46d4319f0ef54c.1712828282.git.antony.antony@secunet.com>

On Thu, Apr 11, 2024 at 11:42:13AM +0200, Antony Antony wrote:
> Introduces validation for the x->dir attribute within the XFRM output
> data lookup path. If the configured direction does not match the expected
> direction, out, increment the XfrmOutDirError counter and drop the packet
> to ensure data integrity and correct flow handling.
> 
> grep -vw 0 /proc/net/xfrm_stat
> XfrmOutPolError         	2
> XfrmOutDirError         	2
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

...

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 6affe5cd85d8..7deeb21dae15 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2489,6 +2489,12 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
>  
>  		x = xfrm_state_find(remote, local, fl, tmpl, policy, &error,
>  				    family, policy->if_id);
> +		if (x->dir && x->dir != XFRM_SA_DIR_OUT) {
> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTDIRERROR);
> +			xfrm_state_put(x);
> +			error = -EINVAL;
> +			goto fail;
> +		}

Hi Antony,

the line below assumes that x may be NULL,
but the new code above dereferences x unconditionally.
Is this ok?

Flagged by Smatch.

>  
>  		if (x && x->km.state == XFRM_STATE_VALID) {
>  			xfrm[nx++] = x;

...

