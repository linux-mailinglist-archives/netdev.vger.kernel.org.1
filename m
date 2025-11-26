Return-Path: <netdev+bounces-241921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA5C8A800
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D18B4359570
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF3306D54;
	Wed, 26 Nov 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiFrgxmG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F95306D23
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168957; cv=none; b=hxqWz0DmSjwj1hUDnTaRwljettuWbM+3b5vmZPP8lfEw6NzQUb0BeYOxJa7HNRmQpIPMtE7CnM9Rv4g0C79UL7kdysn/XEwUma7LkDeyS8ii2+y4YDlAtrP0Gvcv6hWm7LHq3nFCMCQt8J6CwODSM9npXR3GJbvQsIOQBsidIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168957; c=relaxed/simple;
	bh=+ZKIgLiCk4Chr6Z6KMSrs9G7Z6s0UV9nfNo+tWI7ea8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLHP+lKTI1nC3IJiOJvpm5ztHD3MbrYwYms6O7twoFGfoRx5PQFhBJ5swC39ErxfhZJEsaN21aSznFB7KpduPdBvargNuE+UKh0O2t3t3r4SJ7hw6E1OrGzUB3StiOXdjp5ac8DqMAMOPMPgtQ/cmHdHjEqr26XFapGsLk47ipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiFrgxmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6313C4CEF7;
	Wed, 26 Nov 2025 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764168957;
	bh=+ZKIgLiCk4Chr6Z6KMSrs9G7Z6s0UV9nfNo+tWI7ea8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiFrgxmG5SwAphQ84AomozazFRU3cqbuqlfONGYvez+hrQgtkyJRS8b+eeKg7xyM9
	 CzaABj1IK0Ko5Dbi52d97EjM6lJvA4b6MOcqx3PiN2PWu+LFpLhpfJUGlELOrcP1vR
	 bKn8qRji+Gf8g5eGnh0BrFgKG05ZUWyFclhpf9Qi6/WnJI7bo6ExDRHDeBb8g6Ax2z
	 nxq5U+ccWlynv3LzRT/pcjiIAkP7DYHNBeY4bWXDUK0Ny1XMJOS1uo3K3IJTXrbuGf
	 drFIMimmWS6Wh4xur+W4wavpVzEN3Qa7axzHPKZIUb7o28YH7Ke8RgFE88SmtaCfMn
	 akJ/v8wYdLOkA==
Date: Wed, 26 Nov 2025 06:55:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
 <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, Jason Xing
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 0/5] A series of minor optimizations of the
 bonding module
Message-ID: <20251126065550.3d40f620@kernel.org>
In-Reply-To: <20251126023829.44946-1-tonghao@bamaicloud.com>
References: <20251126023829.44946-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 10:38:24 +0800 Tonghao Zhang wrote:
> These patches mainly target the peer notify mechanism of the bonding module.
> Including updates of peer notify, lock races, etc. For more information, please
> refer to the patch.

This breaks the bonding_options tests:

https://netdev-3.bots.linux.dev/vmksft-bonding/results/402281/1-bond-options-sh/stdout
https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding/results/402282/1-bond-options-sh/stdout
https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding/results/402461/1-bond-options-sh/stdout
-- 
pw-bot: cr

