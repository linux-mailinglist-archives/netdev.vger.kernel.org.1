Return-Path: <netdev+bounces-247191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FBCCF58C6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B3C43015160
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495B02FBDF5;
	Mon,  5 Jan 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi9ip0Nr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366B2DCF7B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645608; cv=none; b=a3AVvX8+XFXj4IrnVVxOJNmswQAxYtGpRXOS81fIoFBKPm953IghoK+wVu8mMxKhAoHoTKGBoIySVxeCrK/Fi5AE0blEqe3jnfXrBrFa+hqeiic7Ya5gO+eDUkWWVcWVvmN789oxWU/yBX3N/Wvl0c8fGqHC+yzrdFMdONqHrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645608; c=relaxed/simple;
	bh=jYKhqqIcSLa2nBBd+NM3vcSqKPLM5AUFEib8Zhc0pWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbvfM/nxOmO8+k/O+bknWzHk2XBAa5NmvGQu2cSyT2p9+5B3YrhUJ4j0Q4Xa/U/2zXJSGlbCDy9BlgNXVzV+PQ9Kl9QsASURBYgtLntVSsTaOdqdy4yrl8YY1ifH+2DiHzkSITggnQmdyHdXaWIJDQcpWGwur52jKXR9/Do6nkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi9ip0Nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8FFC19425;
	Mon,  5 Jan 2026 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767645608;
	bh=jYKhqqIcSLa2nBBd+NM3vcSqKPLM5AUFEib8Zhc0pWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xi9ip0NrA3QHrf5KZbnq/EaOLB8dg9N9gfu1VsQquj+kYHWAI+acsxgVrova0Y01L
	 TlHF5ULfuxK5KhizV1R5RyT1DAZDOvUa8l2TUb/v+Uv/u4lPXxVJzecMKBYhQj1Ih4
	 86ho7al82NXD5YO+5LBxKuVN1u4NylslWkDuqwTrube0G0gaoKkmpP+eaKOkaoFQLT
	 5h13cmHAgW/gPJwj9HBUXDV7eG0ZavbJFyZbkgOrWUNv4o+Y8XUnUnnmZGJHPgEVsX
	 8Oz4hLX4jCxEyLQMxmI+cnHEiajya5o8SkSURuD5s0jH7WKxTJQiLjIfZ/arrFqxNx
	 sxeYJk+SDi+bA==
Date: Mon, 5 Jan 2026 12:40:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, Mazin Al Haddad
 <mazin@getstate.dev>
Subject: Re: [PATCH net] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <20260105124006.299e6b86@kernel.org>
In-Reply-To: <20260105100330.2258612-1-edumazet@google.com>
References: <20260105100330.2258612-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 10:03:30 +0000 Eric Dumazet wrote:
> I added skb_vlan_inet_prepare() helper in the cited commit, hinting
> that we would need to use it more broadly.

This appears to break all GRE tests, unfortunately.
Conditions need to be inverted?
-- 
pw-bot: cr

