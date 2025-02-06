Return-Path: <netdev+bounces-163623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75853A2AF9B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6915188D9E9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F2194A67;
	Thu,  6 Feb 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2oWWalo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8A42AB4
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864762; cv=none; b=aioDO+BH01qAzMyw81/Ou0RPy8OYWzYcf+hdziw8dZW0EeeUuwK6Pp39jR14XaJmmPJuvvaQT520LnMithOE0HW6GBicQT6Gygf9dXh2x+mvokjvIlzV7oCtY2S7wOHvD3XSD5eyMm4qtKEaKv6shEHhB35qmGUywydTwLChCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864762; c=relaxed/simple;
	bh=8wC6QuGnHrWMPaX5jjgKy6WUFIho5IHGnatvkclhNbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi4opW2HVWI8UpCovvIBVh0TziCyomDZdKC08jcnoKHxdF9gmcstCOYUxMokCuGdFkGEa9CWEREsWf+9a+quZ8OxJDFsZD8ljkzeKb7s1TjZgJZF347Sh828u7D6BZSKCoib0cptBhgFbsZlZ2J8KCQhovJQyEvaHcaZbZw1s/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2oWWalo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70273C4CEDD;
	Thu,  6 Feb 2025 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738864762;
	bh=8wC6QuGnHrWMPaX5jjgKy6WUFIho5IHGnatvkclhNbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2oWWaloDOHUkVOqOXPWTbOUj5w4BvCSb2UsW2QdppVX8SKL3mlkDodTfSV689KWR
	 jGH+HOzg+xF3iEs0j/vkhKwvsgc149h1qEUjAweXEnjSsqViVh7PaySFdtrRJ7esIp
	 17v53ddpXU2l2q+PgJaIs0srTLPo1nT3eqsV9mXfGK45BM86JYODipZxRuavzkUhES
	 9w14oItFKj5qLvyShvQBGMP0klXaGUxWnuCtJp2j6p3xlL6sJlH4t/6Ki3SyrnsEZ6
	 7N2ExsdI1+07dhZpTdnr9vl7hYRZzkuL4zDl9sUb0mNgVDNdNS4/9WHQXt72SRDjUo
	 pDdAWjL+P/AQw==
Date: Thu, 6 Feb 2025 17:59:18 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: do not export tcp_parse_mss_option() and
 tcp_mtup_init()
Message-ID: <20250206175918.GA554665@kernel.org>
References: <20250206093436.2609008-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206093436.2609008-1-edumazet@google.com>

On Thu, Feb 06, 2025 at 09:34:36AM +0000, Eric Dumazet wrote:
> These two functions are not called from modules.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

