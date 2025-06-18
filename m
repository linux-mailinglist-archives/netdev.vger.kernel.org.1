Return-Path: <netdev+bounces-199150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61834ADF2CE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC4E1899487
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9B2EAB84;
	Wed, 18 Jun 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MClqgHyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECF1D63D8
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264982; cv=none; b=aT/e4yisZHOQlI0g0QvXG3/VwIml5TdGtBcwfroFs7/PScARYNzc79Lgw6BMActAHjCyF2F0RBCsiRlqGgEpq4+03x7SyGBozzvfP2S1l04dHCEwxB9oXW8++W8PESt5c1cVrIlZMO4w7ZpbrxhWjmzCvH0SGC5qaYSeJ/hB7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264982; c=relaxed/simple;
	bh=UVKVWKchrBRDAB38nMKVoj3WGiynP2zWKodTvIeoy1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax9RfVKWE8CO9UjbVxNWqlx2tw1lxROg0QPVQOHO49cJQ8plVCl77DB/ri9GhpCVEV+LzxLmCKlwuEwHn5Pz576d73J7bZIyfH+66d/nUdRMTQVDXE0E6Ph9lb9f8pCt+DevAEnbMwQ6346mpUg6pxZAC1XCYkJLyiQh2gTlnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MClqgHyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE351C4CEE7;
	Wed, 18 Jun 2025 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750264981;
	bh=UVKVWKchrBRDAB38nMKVoj3WGiynP2zWKodTvIeoy1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MClqgHybeOslBL/Zmmj0fE/gTnbu+OrSh/Jp3Fe/MXqrZat5G7Rk0v3stm+NNma39
	 UMntKgMBgaG1v0t6VOtY2Z67L56CjJPrs8bQJZmDk/VrnaAb9D8fKlEUEt3qutlT/o
	 tabGXytiCT0gKZHs9Os2z9MaSLllZelVNZSTG81C8iLkSCQI4olwp1UPrLgbTZ9tLb
	 WjipfdOO0MP9q7XhkmuNbaFw+1ta42TOkBwEjq/fJtLala6rFNks5gTDbJbBlL4ebJ
	 Z5yarGpJrVT02l18CpVK5VTeY9uRg6MbNWq7dAZq8WcB5tvHANVajtO98KovTqNxRm
	 Owygq8sl8yRuQ==
Date: Wed, 18 Jun 2025 17:42:58 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: tcp_time_to_recover() cleanup
Message-ID: <20250618164258.GT1699@horms.kernel.org>
References: <20250618091246.1260322-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618091246.1260322-1-edumazet@google.com>

On Wed, Jun 18, 2025 at 09:12:46AM +0000, Eric Dumazet wrote:
> tcp_time_to_recover() does not need the @flag argument.
> 
> Its first parameter can be marked const, and of tcp_sock type.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


