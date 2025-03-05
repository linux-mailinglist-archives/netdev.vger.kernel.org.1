Return-Path: <netdev+bounces-171904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86DA4F409
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D62C3A960F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A341C85;
	Wed,  5 Mar 2025 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOvnW7HT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AEE3594C;
	Wed,  5 Mar 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139254; cv=none; b=UFCgp59s7MPLLKkEcteKOlymu5nO4dIfXSgJBJldZiuYwDCRz7rMd4tFH2Y1HBYYHlE4gjBvRDxeuRQinL1Cqww/w2/eg1jLfVBQJBDs490RUobj+umwIWnf4J2TkuLUzEOrXEJ4sq9JWPdI8B3XLHGoYlJyoxqEMherFAuvTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139254; c=relaxed/simple;
	bh=3yFoL/csQodidWtcQ5/tM5P80uMXE7Fz4xKze/NWXfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mppo02ORhGgGvOe5lsIK7xjKWD11uLlXEQYcCSb6Czy62Yj3wEI24q2YubTbZu1lVKnXrpC7TwUgBOmbPhQETeuPXC16gcy/3L2mIPRhs2WD0l8cSmHKQRKpgFluEO1rqxxUFqiBbZWeQc4Sw0M8ncCia4OCrwgSX9/o9E2j1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOvnW7HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2114BC4CEE5;
	Wed,  5 Mar 2025 01:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741139253;
	bh=3yFoL/csQodidWtcQ5/tM5P80uMXE7Fz4xKze/NWXfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IOvnW7HTYJfKmE29cF1O4f2QGKUXuktN0S+uq9Mjq88OG2Y74IVrawIBgqNQGLIBt
	 2WUGFWJ30QqD5arGpjiSS2zWAueL2U+afZ/Nftkx0LumwEbt6k7PU+MmIRtOJE7otE
	 qUDQvIiJ16fILmo2ol4MXUlz/Vh7KFjj1LKeYf2ERFnfDqT/9R/icgvWTjxDn1UlQB
	 x0F4Lpmucye3tuRwRM3MlcMpV/riaglWTl6ujmWMY7MSPpv0jnrfv0oyhUu0n4uHdj
	 RJ73Jd8lf9hBQegiGalvgWc3qIg32MlOiWS9e+gxbkQjGP5iWZZ/l4D4rDk0o3T4Kg
	 tyr0BwMbFPkrA==
Date: Tue, 4 Mar 2025 17:47:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Amerigo Wang <amwang@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] netpoll: guard __netpoll_send_skb() with RCU read
 lock
Message-ID: <20250304174732.2a1f2cb5@kernel.org>
In-Reply-To: <20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org>
References: <20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Mar 2025 03:44:12 -0800 Breno Leitao wrote:
> +	guard(rcu)();

Scoped guards if you have to.
Preferably just lock/unlock like a normal person..

