Return-Path: <netdev+bounces-178751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E7A78B28
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70A03B0C98
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7DC233D92;
	Wed,  2 Apr 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpLZVzwj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1A16BE17;
	Wed,  2 Apr 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743586574; cv=none; b=C+tAmSSxRwvQoM0F06M1au6td3C47peBW2NO2peAFrC9eqo+lHtwvXoQyDm4YAcRpATYFyaaR0aPyM1czfknPjeO2FRM8w0h/a70DUiBbHwfWmJdndSsP27Zx2FttYV//OJQg4YSGQVJh8JdnwqVCE8lZ1gJM7QblEbRdlmRsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743586574; c=relaxed/simple;
	bh=G1RWy73ojl3qG3hlsUMk08tmX8YtZkW4GbYJeVymtog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5kylx/67BtspqYV0I8Yoj3/z7/mhdUnw0rz91z1mskHwNQdIS7nGwmvtCVVGSTpSkIlSZ14Fr1v+P/UoOrt32mAm3ucOy6ilVeZGN89Sep7vIKJfKXU3LjR+NVzRVMO/E9oFXDw20pXhL3+qhq98RJ66tMLiNvgU+N7PhV1HYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpLZVzwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB0DC4CEDD;
	Wed,  2 Apr 2025 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743586573;
	bh=G1RWy73ojl3qG3hlsUMk08tmX8YtZkW4GbYJeVymtog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpLZVzwjgIHIzfOAbLFxcZRqMm90MrAweJjoIwUOf3gaFJBeIhHzb7mVWej2Lz9ow
	 vjOte9ntM+nGfIdS89C04B6MJSaivBkmmGHgYSN9SeFVhf0ReADjFWveiuSvJjD77G
	 oQH4ObwFl/ql/lOnsVsXelG9YzSZygO66mbu+5qCFr6348ci3tBwOhtN4b+xlJMnlP
	 /x37CRslYuwVTCwxO9p0HmUf21GSTeaVc9LLMRf4/Wk2MbB44O9rEAi3YAHPspQ+Jd
	 ZpIQcdGeTVtuvbW4bHhO4vPFAh5DtDK9rudgLoAe5LKhgLDGGCl2/ZkVnFtyUTJUPh
	 MCQAClHgULaWA==
Date: Wed, 2 Apr 2025 10:36:09 +0100
From: Simon Horman <horms@kernel.org>
To: Debin Zhu <mowenroot@163.com>
Cc: pabeni@redhat.com, 1985755126@qq.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	paul@paul-moore.com
Subject: Re: [PATCH v3] netlabel: Fix NULL pointer exception caused by
 CALIPSO on IPv4 sockets
Message-ID: <20250402093609.GK214849@horms.kernel.org>
References: <2a4f2c24-62a8-4627-88c0-776c0e005163@redhat.com>
 <20250401124018.4763-1-mowenroot@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401124018.4763-1-mowenroot@163.com>

On Tue, Apr 01, 2025 at 08:40:18PM +0800, Debin Zhu wrote:
> When calling netlbl_conn_setattr(), addr->sa_family is used
> to determine the function behavior. If sk is an IPv4 socket,
> but the connect function is called with an IPv6 address,
> the function calipso_sock_setattr() is triggered.
> Inside this function, the following code is executed:
> 
> sk_fullsock(__sk) ? inet_sk(__sk)->pinet6 : NULL;
> 
> Since sk is an IPv4 socket, pinet6 is NULL, leading to a
> null pointer dereference.
> 
> This patch fixes the issue by checking if inet6_sk(sk)
> returns a NULL pointer before accessing pinet6.
> 
> Fixes: ceba1832b1b2("calipso: Set the calipso socket label to match the secattr.")

There is probably no need to repost for this, but
there is a missing space in the Fixes tag. It should be like this:

Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")

> Signed-off-by: Debin Zhu <mowenroot@163.com>
> Signed-off-by: Bitao Ouyang <1985755126@qq.com>
> Acked-by: Paul Moore <paul@paul-moore.com>

...

