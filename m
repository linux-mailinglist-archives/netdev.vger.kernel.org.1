Return-Path: <netdev+bounces-81345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AF8874E9
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34F01F2400F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766E81750;
	Fri, 22 Mar 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2brwd7U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837226AD4
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147626; cv=none; b=EVtl1qlh9Z3YUIX7nUY8wP0FmkIml4b6HnPryVAQo0FMUVElm5nzwt3P/bhr4R9w7t/Ux+fAwhCAp7IIenB7mrtAvBabBAcgFHImonLX/mMCSRVj/nv/cnpcyu9VV7yMWMsrg5kLI5bLG35R9McwY1CpIaTBjKWOFFWDvsJyY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147626; c=relaxed/simple;
	bh=SupyVteZIW2XkRPxZ1srwhsGPIY/5D/mJC0Ki4YGOC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beYp+zTM2jM7osb2znMpax21XqFUJegSnj9YV4dqGKPN9P2+AFVuO8CaXC1hMlny6QrAALDep0fex+nMOyHiwWSrdEi69u7IeD2vK3Ez1QoUVaaEmQ6dPIRTgZzPP88rjl1JIKHv+6eFm+++oytGBWyfhSkGMZ5comPOshfSd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2brwd7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A84C433F1;
	Fri, 22 Mar 2024 22:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711147625;
	bh=SupyVteZIW2XkRPxZ1srwhsGPIY/5D/mJC0Ki4YGOC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2brwd7UzvIuvC7hVD6lwvAhocOXRZmgUzNkmxL4rrWb2D6zl1sM6+U6blvYwKR4C
	 bAGyAVp83LYqUYVWPJP8gMNEDXBSgRHDNTUD+R/Mbq30ooYXQPfJUz5vVV1esZTKTY
	 wKzl18ePC8kdAEKoyAgPuTcyWvde+34EE66yyANMmmogBnYIY1Ppc24lEx5+8doh+9
	 N5m0rKf8Lzosd6JH2uITDq2DHoVO8fXoIkaDOgLDH3aQKj8ydYXfWYaApeMjG8CkB5
	 zTLhsgwv9UBvAG6D3o5o0aRO+bcSBCiHNGXLrRhMNBwFDkBdzJ+GqmqzVtZQ2oHSH0
	 C4jUWiH+phTYw==
Date: Fri, 22 Mar 2024 15:47:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Josef
 Bacik <josef@toxicpanda.com>, Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH net] tcp: properly terminate timers for kernel sockets
Message-ID: <20240322154704.7ed4d55f@kernel.org>
In-Reply-To: <20240322135732.1535772-1-edumazet@google.com>
References: <20240322135732.1535772-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 13:57:32 +0000 Eric Dumazet wrote:
> +	if (!sk->sk_net_refcnt)
> +		inet_csk_clear_xmit_timers_sync(sk);

The thought that we should clear or poison sk_net at this point
(whether sk->sk_net_refcnt or not) keeps coming back to me.
If we don't guarantee the pointer is valid - to make it easier
for syzbot to catch invalid accesses?

