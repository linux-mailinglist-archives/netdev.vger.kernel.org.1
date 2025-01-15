Return-Path: <netdev+bounces-158647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78835A12D9C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1CD1887893
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1A1D9A42;
	Wed, 15 Jan 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoNlwnOi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB74D599;
	Wed, 15 Jan 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976104; cv=none; b=ap7x4u6IC/hlXm72HlVytQ4pC2UslWpoqY2d84UZYJRIMhox7mBNCaaYDC4Yk/VokPRlUCiWqEdThBSqr2M/jPDX6wS4mXxK0gWCwqWi84Ith/P8KPkiIjmqv1tZFEcz110xnoh7iFja9Zk3BNMwdPMXgfsCgDb8LFbE3Swtbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976104; c=relaxed/simple;
	bh=9TWMahBJxv0Fx7tGkIPVI77bNHYo41nONeIt3qjqxbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QK2mqfeVgQp8sYbnLvKZitZh7n8uWhsijc+kUvSwuWZSi3FDa0HK0aEQ8CUtA9fTKFETBfjnV8JKhMy5y8xhwV32H97Fof3NWzMm0Oq9uN4rmy8RdqOLUBZ5nxTIyF+TwmRPqv1cK4aR1Vjw97jaGkGBhJJd/HEyoNEqP7qvu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoNlwnOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7CEC4CED1;
	Wed, 15 Jan 2025 21:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976104;
	bh=9TWMahBJxv0Fx7tGkIPVI77bNHYo41nONeIt3qjqxbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QoNlwnOiPqfSlE8B3jdrtQ6z0dNj+TBZVwaz1RQzJB22Hx5VMKwrarrpfefcpGAT2
	 IypN47XCBrXLOYKSNXUsymQwkTyqMKq2e+aLAeST389haEhwlvoKnZqf3mBYOP0Qh6
	 M7v4mw2ImDAkx0UiZlmCgOkLikiSl9xlqUdXcztzWZpSDkIUS/5DjNpe3o5R4eOMka
	 0Zpb2GUKJRsyLB1acfubOobtyJ8v7tXFPFFRbog0+yQa5DKpa2ZAnbogBLkjKm7K6l
	 PFUecXPgOZfPLeCVZVViOnGlYc7J5L5eo52lFqUrMXTXqb7/lAmef2EMKyEcIPJkuB
	 U6G86UhClS4Uw==
Date: Wed, 15 Jan 2025 13:21:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mptcp: fix for setting remote ipv4mapped
 address
Message-ID: <20250115132142.53db10b2@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-fix-remote-addr-v1-1-debcd84ea86f@kernel.org>
References: <20250114-net-next-mptcp-fix-remote-addr-v1-1-debcd84ea86f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 19:06:22 +0100 Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Commit 1c670b39cec7 ("mptcp: change local addr type of subflow_destroy")
> introduced a bug in mptcp_pm_nl_subflow_destroy_doit().
> 
> ipv6_addr_set_v4mapped() should be called to set the remote ipv4 address
> 'addr_r.addr.s_addr' to the remote ipv6 address 'addr_r.addr6', not
> 'addr_l.addr.addr6', which is the local ipv6 address.

Wasn't there a syzbot report for this? Just curious.

