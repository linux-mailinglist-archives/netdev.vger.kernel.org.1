Return-Path: <netdev+bounces-81858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E888B5AA
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 00:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058591F63F4A
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F384D28;
	Mon, 25 Mar 2024 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEcZ/1ve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C984D1D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410995; cv=none; b=Ft8uJS9WHgdQxai1GTWzEnnjP744s9fkXYm/zznuZ2ct2+FdXZLXSdPYWAL1JGN5/lDd2zyQIdrxRmNn34F1GmdG5kltnVifnJCtNUj/ZaJr+9mf4LNqwypjuYCB4bFqsZ1M7/5nOZK4Br2aBF9MNMr3ffC+K7t8gmnV5nB0OCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410995; c=relaxed/simple;
	bh=Z174WjDHU7fBvv/+yk52dexUaT14pPScWLIS5mXN5EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXhDw7uLYPRIbNLpQglX11PkbyalqAPwUODH6sbuZWP3fZUX0FrBd93umkTOQ9/r8LqNcQJrtcBD4yMJF4Skbg5EpVAXSAmv9AW3yaPbnrljNognwdr/A70n4DwEIzLmGoKm9rwXWkVGdBx4zSeURSmtneJDOI8x40Xjv4DxjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEcZ/1ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E24C433F1;
	Mon, 25 Mar 2024 23:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711410994;
	bh=Z174WjDHU7fBvv/+yk52dexUaT14pPScWLIS5mXN5EQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lEcZ/1ve1X4Ajpm7aRkixcSF7J6ylhy5oZjJyBKoAkM1fZ9M+9AzUex4rp1nBoZdL
	 lgyyjHfMW/oNQGujnQooyLZrQM6VtGrk6Vb1Pz0iSKBvJALuoIrTt0cLUpkUpQKEZ0
	 N4I4Bp7Pg0iZMV6S5IcL+PN+x1iEJ39u08AkovWGJptlERYHDd8V5hPseuxRVkbNtA
	 kMjpVU4AQxdWqbiO9+T3H8WDlhaPab+VbR6eIwgQJAv6oizEGD7wQ2xQfYdYSYkD/Y
	 Vv19bOPbFNkiVldPKX2WgRkxVxQXgImwRsiBgFjcm82XMIKgkskZN8am1jL1SPq1rs
	 GcbsPt31sDkCw==
Date: Mon, 25 Mar 2024 16:56:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu
 <wujianguo106@163.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net 1/8] tcp: Fix bind() regression for v6-only
 wildcard and v4-mapped-v6 non-wildcard addresses.
Message-ID: <20240325165633.0664c3f8@kernel.org>
In-Reply-To: <20240325181923.48769-2-kuniyu@amazon.com>
References: <20240325181923.48769-1-kuniyu@amazon.com>
	<20240325181923.48769-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 11:19:16 -0700 Kuniyuki Iwashima wrote:
> -	if (sk->sk_family == AF_INET && ipv6_only_sock(sk2))
> +	if (ipv6_only_sock(sk2) &&
> +	    (sk->sk_family == AF_INET || ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)))

breaks build for IPV6=n (i.e. TDC):

https://github.com/p4tc-dev/tc-executor/commit/ac16181d7589bdf29c7c3907243e829f6b954570#diff-0042f6af11ac801c4370fb95b8e4f0de734b793c9e23bff936a1bb03c63eb6f0R228
-- 
pw-bot: cr

