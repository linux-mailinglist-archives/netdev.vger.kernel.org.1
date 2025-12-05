Return-Path: <netdev+bounces-243841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74917CA870C
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30B40300FA27
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB532A3F1;
	Fri,  5 Dec 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY3rwwSs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251C222566;
	Fri,  5 Dec 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953737; cv=none; b=TvAO34pWlNR4zewsGryU1SqQF+wOj4iDUWKUlCvGx9+dPygykt8Jrfg/0TRAxqKGMicw8TXLMp5CYi99o+MWGI3b6GSqQw+MKnWBD7PLvn8PAVtEOtI+LuNDX1ni7TVbay5AWmD/q3Uh4fJj2AatTcjKX5fvV2zXsdPUIcffJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953737; c=relaxed/simple;
	bh=gBQgFks+WFKPF4MU12XBeVJDGl24bVrbY0BaE5fudJE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uezJOTKDvqyOuIFkIxSfDzJgz1ciJMjkRtV+Kc8JiyJhod3+GnvxKPTfy4uRnlAreqRG7gAbUmwll+LSVcZB+42ZicK6MKok1+ZLf81qkcFZM0vInhkhnYiZzApsqOzwWlZ0K6/STQJ+8RZ/3DmNTJHnWmg81wvTawuhflDQyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY3rwwSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8B5C4CEF1;
	Fri,  5 Dec 2025 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764953735;
	bh=gBQgFks+WFKPF4MU12XBeVJDGl24bVrbY0BaE5fudJE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pY3rwwSsfN5OSRYvzs/GBxtD4i/3awVyWbOwaFRXkujCBHOD3aiX20SAnTJOCT5AP
	 m2cM87EM+CeLosKyaEikxWiET0+LAu7b5IJ3DxjaPKQq7/jg46afLAjFlUuIpIsLcC
	 l25hREPEJJm886F+Na0UjI7+54aq3s7l3TX9oM21MtXne9Xn5nw+TxAOCzyCUwiWak
	 z7CpMT0/cCz0ubGIzEFGj8Y0NLeCya8mpk84BSg+Mncq781uFxQskyF3+peeBuoLcL
	 vgOA6XlZQEF/Bkch9Gd4UvMKq1odDS2rkWPhnnrNcZnvXknflXR4MZkG282sNcEY2c
	 mBzMhmkqL4WQw==
Date: Fri, 5 Dec 2025 08:55:35 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org, 
    mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net] mptcp: select CRYPTO_LIB_UTILS instead of CRYPTO
In-Reply-To: <20251204054417.491439-1-ebiggers@kernel.org>
Message-ID: <4eaa66fd-cd4e-a5af-1d6b-6d8a95150d3f@kernel.org>
References: <20251204054417.491439-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 3 Dec 2025, Eric Biggers wrote:

> Since the only crypto functions used by the mptcp code are the SHA-256
> library functions and crypto_memneq(), select only the options needed
> for those: CRYPTO_LIB_SHA256 and CRYPTO_LIB_UTILS.
>
> Previously, CRYPTO was selected instead of CRYPTO_LIB_UTILS.  That does
> pull in CRYPTO_LIB_UTILS as well, but it's unnecessarily broad.
>
> Years ago, the CRYPTO_LIB_* options were visible only when CRYPTO.  That
> may be another reason why CRYPTO is selected here.  However, that was
> fixed years ago, and the libraries can now be selected directly.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> net/mptcp/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Eric!

Yes, this is a case of our Kconfig predating CRYPTO_LIB_UTILS. Appreciate 
the fix.

Netdev maintainers, it's fine to apply this directly to the -net tree.

Reviewed-by: Mat Martineau <martineau@kernel.org>


>
> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index 20328920f6ed..be71fc9b4638 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -2,11 +2,11 @@
> config MPTCP
> 	bool "MPTCP: Multipath TCP"
> 	depends on INET
> 	select SKB_EXTENSIONS
> 	select CRYPTO_LIB_SHA256
> -	select CRYPTO
> +	select CRYPTO_LIB_UTILS
> 	help
> 	  Multipath TCP (MPTCP) connections send and receive data over multiple
> 	  subflows in order to utilize multiple network paths. Each subflow
> 	  uses the TCP protocol, and TCP options carry header information for
> 	  MPTCP.
>
> base-commit: b2c27842ba853508b0da00187a7508eb3a96c8f7
> -- 
> 2.52.0
>
>

