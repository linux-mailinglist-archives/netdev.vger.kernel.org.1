Return-Path: <netdev+bounces-210808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB6B14E83
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A3E545F2C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337DA1C2335;
	Tue, 29 Jul 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryPotRjI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4A1B87C9;
	Tue, 29 Jul 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796313; cv=none; b=orx5M+y240fC/bPQY5u1xmHYPOhouNqXfQO1fuHVANGO3rnWiJ7v9AV1VeycipR6AMyzzly3gMRXxry44YKipje9u5Zxh7jXQjsGkzsrmjVHRetRfil/QBQelUVnTb2UJGj1cHeiLEXsI5HJUrbt3kmnzKwoYzZmpragj/m2KRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796313; c=relaxed/simple;
	bh=p+5XkRXQLP3a3M5GCf3pNfYknzNMOKmgGFmi5Hf9phc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNS/TSFARr+5ceaiq7/Jdv7DC9z6X4rjDAGpAAblXDKQ+TJKCIw1p5euZA1AAXYKHXO3rf5dBJSICQQf6HCJkOS+7TE4Wy8ylZK0avaVT+hzVsw6PdAVsZO8OOfP4ARnnEmVjPGJwecx0D9xRaFIIk62WAY9NTdUqYTK/n12d9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryPotRjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D6AC4CEF5;
	Tue, 29 Jul 2025 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753796312;
	bh=p+5XkRXQLP3a3M5GCf3pNfYknzNMOKmgGFmi5Hf9phc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryPotRjI0W/Y0emcM1tilBwyIBs0yucxS6Ez3aR/r7VDKYiuurSLkIlHxz/7/eCSA
	 HNV6sg6r7I0XHbQZjaezXk9hG9GtDUQIkdAyOc4Hn/vQEdRT426YND12RVAtFsTSJB
	 qUa91LrY0Uu2CPtF4eF3ou7hhkN9GvfMkfmhyUfMQHCP0uXiG8lwS/cx/lGLz+OD0Z
	 Lf2YxgIOuaFfqhxT3sypYAVkqe1iMxwN6w82PAVUcA848QDYrHPfaDUd1zAwi4leVV
	 d7ApHvxshIt5J13jf6PKFbOiu60JBH2QFkNJtv8dL/YTP3qQ7NyD2+6t+a492HyzF4
	 7bs5eQx7nQK4w==
Date: Tue, 29 Jul 2025 14:38:28 +0100
From: Simon Horman <horms@kernel.org>
To: Tian <27392025k@gmail.com>
Cc: irusskikh@marvell.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: atlantic: fix overwritten return value in
 Aquantia driver
Message-ID: <20250729133828.GE1877762@horms.kernel.org>
References: <20250729005853.33130-1-27392025k@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729005853.33130-1-27392025k@gmail.com>

On Mon, Jul 28, 2025 at 05:58:52PM -0700, Tian wrote:
> From: Tian Liu <27392025k@gmail.com>
> 
> In hw_atl_utils.c and hw_atl_utils_fw2x.c, a return value is first assigned
> to `err`, but then later calls overwrite it unconditionally. As a result,
> any earlier failure is lost if the later call succeeds. This may cause the
> driver to proceed when it should have stopped.
> 
> This patch uses `err |=` instead of assignment, so that any earlier error
> is preserved even if later calls succeed. This is safe because all involved
> functions return standard negative error codes (e.g. -EIO, -ETIMEDOUT, etc).
> OR-ing such values does not convert them into success, and preserves the
> indication that an error occurred.
> 
> Fixes: 6a7f2277313b4 ("net: aquantia: replace AQ_HW_WAIT_FOR with readx_poll_timeout_atomic")

nit: No blank line here

I do agree that the Fixes tag is correct in the case of hw_atl_utils_fw2x.c

But, in the case of hw_atl_utils.c, it seems to me that the correct Fixes
tag would be as follows, because prior to this commit the value of err was
not overwritten:

Fixes: e7b5f97e6574 ("net: atlantic: check rpc result and wait for rpc address")

Given the different commits that are being fixed I would suggest splitting
the patch into two, one per file that is being updated.

> 
> Signed-off-by: Tian Liu <27392025k@gmail.com>

...

-- 
pw-bot: changes-requested

