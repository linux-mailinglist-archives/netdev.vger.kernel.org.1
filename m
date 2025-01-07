Return-Path: <netdev+bounces-155644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E62A03416
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53A53A15D6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09937286A8;
	Tue,  7 Jan 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZrGP7LM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE1282F1
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210185; cv=none; b=dWhtKxzIp0j1uIRYtNSRLjCDmy2p6G+Hg87nXnDQsbF0tVXxZBqcJLSK9nbAJJvJNKTmg9KWnJPzflBNxLnGwmj1jnJkeBxtjzjy8V4p0droY+klv0J1zO5P0dU4ZjGTgFeVdUh8wtouteBm0XPk9XvjkbARzmeAuOwjXOqhCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210185; c=relaxed/simple;
	bh=8cROc4wIHeCQjQkqJrKe5M3jD/E3TRmAGQjGeUeJwYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8F2RdFyJZMjLcIS1T4bGzT4I3LsAPQZajRQmFjs/nQefYpIwsalVo/K0u/RTaSD+8wcbBIXK2fV/HzevI8W8izhNsQi7j4GsdACcL58lrxGe/SUxNecAU4J9rxkKyQh8KlXhtlrPQ5EVb63VbfDkh+U0OBWZk3ZwG0GKQKV3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZrGP7LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8ABC4CED2;
	Tue,  7 Jan 2025 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736210185;
	bh=8cROc4wIHeCQjQkqJrKe5M3jD/E3TRmAGQjGeUeJwYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RZrGP7LMXVf69a/rNZa6ZoAGRKeW9sdzHA8zCeQxWJ5BCRqlmhNDs2lGUYH8y79NZ
	 k1uz1ugVwkc5nypgeNgr5kQ7R7jSJY0VTZJ/9AiaVaj/evxM3aEUcZA1Ral+DM3aB2
	 +qwZmdbHvjD3fvBDSWEBDZi6BTbV0NAupqJdaHVD5cuuzURs+LrwcXkvkb4BHokl+i
	 epii2BjDY7Y0PgzyZgga9lFcO0ZMjwmkvn30R56TXKEUrII/rW6ubfe8fs9dqPgZGR
	 0lTVSjohYhVioXnimceI/im/Wo7ktoyTQjCIfa7t0noeBb2xZbT6sIgDOYUs0DI40e
	 swy/T8xqSaEHQ==
Date: Mon, 6 Jan 2025 16:36:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru
 <vdogaru@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>
Subject: Re: [PATCH net-next 03/15] net/mlx5: HWS, denote how refcounts are
 protected
Message-ID: <20250106163624.7cebcbeb@kernel.org>
In-Reply-To: <20250102181415.1477316-4-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
	<20250102181415.1477316-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 20:14:02 +0200 Tariq Toukan wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Some HWS structs have refcounts that are just u32.
> Comment how they are protected and add '__must_hold()'
> annotation where applicable.

Out of curiosity -- do you have tooling which uses those annotations?
Can smatch use it? IIUC the sparse matching on the lock state is pretty
much disabled these days.

