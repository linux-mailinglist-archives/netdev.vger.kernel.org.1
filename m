Return-Path: <netdev+bounces-104140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24AD90B4CC
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6021F281CFB
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE4A140E37;
	Mon, 17 Jun 2024 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arEIzA6y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B61E87C;
	Mon, 17 Jun 2024 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637010; cv=none; b=t3ey2JvZSRGCZex/34kdUEHcYy+cIbIy2SOeQ69mf+1N0QB/KS40Af0WmfeF8gdf7N0KXTqlpmCAWGE9HUsfVfb8sioJr4matHwPx8NtdQMF5lSSgcNTbUwbBq9ejhR73ETHH8PE2dlzXa+WPNs7pdq5AMEObVxfTSXJlEGX1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637010; c=relaxed/simple;
	bh=lVHJEHPDA3M8jPm23I5g+gFB7Ixe/wDt7ACpF/CV9F0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyOPiUaK97+LqLeaOKoH0kA/yHU/PEqHGCJxuTqvnEl/TywgdjLpiMVlrcRY1DVkE2PTpQ1sByoXXeXnDzUKrCj2VY+QtZY6PpTzb6ugxIwnc1UdDqeTQVGq5WNCjJqGYqABMUPTTRVgvhXDczRptHd3co3HSyPoFeyBwJ9vmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arEIzA6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6942CC2BD10;
	Mon, 17 Jun 2024 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718637010;
	bh=lVHJEHPDA3M8jPm23I5g+gFB7Ixe/wDt7ACpF/CV9F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=arEIzA6yKkCRLb0knK7BIboY4/ee2yeJJ39Uy9qFHSJi8N9Wz5hYeumf53Vubnqq4
	 5012VjXZZP0G/VU5CXVeeBPEvPPfVEpfstAoJFDO/j41B60hYoFaXjhPYF9oQpaPF8
	 44GBF25ijho04JZi0URWLZ3InsRxGH9SF0r4YdQS61V2DI6zzXO+sq1UJzE+B28qlp
	 kcjr5VMrhrIWzHOupNHrSUCEw95PyWFExvQ0t9YNWFGxlghvXzIJ0O64kLnTtg2l5g
	 V2cWp0osb9flM92UjXNLYH17+vK+a6qqpDu4JSCH7zZN7sKEIYnY6Bnf82rC5sMiNb
	 CDsbwVpk78DIA==
Date: Mon, 17 Jun 2024 08:10:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "rkannoth@marvell.com" <rkannoth@marvell.com>, "Ping-Ke
 Shih" <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Message-ID: <20240617081008.1ccb0888@kernel.org>
In-Reply-To: <82ea81963af9482aa45d0463a21956b5@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-11-justinlai0215@realtek.com>
	<20240612173505.095c4117@kernel.org>
	<82ea81963af9482aa45d0463a21956b5@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 06:54:59 +0000 Justin Lai wrote:
> > Are you sure this is the correct statistic to report as?
> > What's the definition of rx_missed in the datasheet?  
> 
> What we refer to as rx miss is the packets that can't be received because
> the fifo in the MAC is full. We consider this a type of MAC error, identical
> to the definition of FramesLostDueToIntMACRcvError.

Is this a FIFO which silicon designers say can't overflow?
Or it will overflow if the host is busy and doesn't pick up packets?
If it's the latter I recommend using stats64::rx_missed_errors.
That's the start we try to steer all NIC drivers towards for "host 
is too slow".

> > Also is 16 bits enough for a packet counter at 5Gbps?
> > Don't you have to periodically accumulate this counter so that it doesn't wrap
> > around?  
> 
> Indeed, this counter may wrap, but we don't need to accumulate it, because
> an increase in the number of rx_miss largely indicates that the system
> processing speed is not fast enough. Therefore, the size of this counter
> doesn't need to be too large.

Are you basically saying that since its an error it only matters if 
its zero or not? It's not going to be a great experience for anyone
trying to use this driver. You can read this counter periodically from
a timer and accumulate a fuller value in the driver. There's even
struct ethtool_coalesce::stats_block_coalesce_usecs if you want to let
user configure the period.

