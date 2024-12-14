Return-Path: <netdev+bounces-151937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CFA9F1BE4
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 02:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2976F16A060
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4746D531;
	Sat, 14 Dec 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWaCSeYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37DDF49
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734139991; cv=none; b=phlYQBrFJI1752g6xRARskng63Dh+9khm5UdgXpbCt3v+ZYqDUQU7Uc/1bnGHD2z2B3NZx0/Fm9PeT6Oy2b+OBx9KksvWan/fHc/yo0FRsENiH79dmUUHhXvE/EQ6TwwsjNqjg62I3wxBS8Q6Qz2c1Vv4lHtg8Jlb9g0tfm47Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734139991; c=relaxed/simple;
	bh=3g66Gw+f9bOVke53JVJcb0ug56WRUbsk/YpEFjRLK+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFaPWQJrImkjRTu4wP1e/RDToslB8AciTX3bw3+RWZpuCNn4bVDyrrfGDICl/zG2lssAbvMJE5/j8KULdYAYbK2XBXx8o3MfWVKP2QZCutLY8QmPRKOud6AUI9s31jkNQ4OviEB42cNXtdWwp5VH09sU+7aWCxX/1cyOiGaZ0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWaCSeYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9665C4CED0;
	Sat, 14 Dec 2024 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734139991;
	bh=3g66Gw+f9bOVke53JVJcb0ug56WRUbsk/YpEFjRLK+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iWaCSeYpaokU1tRuYQfarOK+Cd5IxbqiJys15VCVA3lOwRQyDjzfXxM55jxysbM34
	 ritZUoYQqkGOwnH9N0cU82ZbylrO2RlO8Uxl6RyeJ4STm8yaaxaTUoYwWwVX9+p3Ka
	 lY5tEWrh6k5TznYsJsYh9dUpkbyaXasFngsDD47YlahDBK5elOat+x/iKUgSBkd2lL
	 1Hr6zh27mqpKkA8cFGuASarTtciiw+LTIQjU0SGta67U6bGMgssV8u9Ukd7M0kcFM5
	 EsM6ei2HAbN0qMeRTKyj9ml0PwFFFgfIPQXBaCJXtG+yRrnGYmEEQ+oLOpttXCsH9Y
	 557xNOSHc4G5Q==
Date: Fri, 13 Dec 2024 17:33:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Xiaoliang Yang
 <xiaoliang.yang_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 0/4] ethtool get_ts_stats() for DSA and ocelot
 driver
Message-ID: <20241213173309.5c7eb234@kernel.org>
In-Reply-To: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
References: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 16:08:48 +0200 Vladimir Oltean wrote:
> After a recent patch set with fixes and general restructuring, Jakub asked for
> the Felix DSA driver to start reporting standardized statistics for hardware
> timestamping:
> https://lore.kernel.org/netdev/20241207180640.12da60ed@kernel.org/

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thank you!

