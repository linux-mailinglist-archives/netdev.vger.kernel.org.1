Return-Path: <netdev+bounces-113330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8193DD0F
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 04:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B22B22BBF
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A42A186A;
	Sat, 27 Jul 2024 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdtcpQCW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02517E9;
	Sat, 27 Jul 2024 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722047885; cv=none; b=MwWs+Xyi5X7L3DuEdakpsppBHo9Br29BcvDZNV97xXxVIed4a72f3wmJgQpvdcOMNfx+baUYMO+JVQu23VxOPo2fzal7qK9aH7Ni8ouYXqfKylVpaWZeFxrxrwKs9/r87kB2QCIIVHsZFXigVGSZJE9oo0/jV5rGscAXTJglHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722047885; c=relaxed/simple;
	bh=eovpOsg4Kr/mIT7zpUFC8+Q4yEFsMXjxDoGqBIQ1fps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kawl1jRz5rWp4aAz7aA0BglXU+IuODgUpb481fqLMXj4wP0Hjbfv2MVErb42vxytzgImP+WLc+p1+S3vOJhSIHJyQ9x5AtQZYfcIN7PAjN9pYQ6lw+CY54XZvLFg0U9WjjObabJgjec9CPyZPskUr2CtSbTJ0py1JHT8L/j9HTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdtcpQCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F807C32782;
	Sat, 27 Jul 2024 02:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722047884;
	bh=eovpOsg4Kr/mIT7zpUFC8+Q4yEFsMXjxDoGqBIQ1fps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gdtcpQCWTkifX0Jp9dxA3GQfTXU/LvC4V/rCtRZdKIEHEuTY9EbHvBrzZDHzKrUoB
	 68BnafkMYeTKDpH+pcA22WRfbMsLbXgu12TYQw383gk2J08q4uiRRoaWtYYu8xcayY
	 i1H3MZtX20gADdPI3dgeGaw4zB1Bob/GA98Trb+ziUXQCLWswwlPakZzK7hn4Qt0LQ
	 zcKPSgjUTD4qenjI63vZL2Ow0ARUPX3IAclGOZ4EP8uzUHifO7t6BLp5EIjZ5KzT5u
	 KI6WkBAZ1xEhunT8A1BCKBtIi+cRoYMglGY67cjlre30Y/jzGSk/ADk2Zxpg8yHbgv
	 uHOlswA5A0Y9w==
Date: Fri, 26 Jul 2024 19:38:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Clark
 Wang <xiaoning.wang@nxp.com>, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-imx@nxp.com
Subject: Re: [PATCH v2 net-next] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
Message-ID: <20240726193803.20c36d7c@kernel.org>
In-Reply-To: <20240726145312.297194-1-shenwei.wang@nxp.com>
References: <20240726145312.297194-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 09:53:12 -0500 Shenwei Wang wrote:
> The current FEC driver uses a single default rx-usecs coalescence setting
> across all SoCs. This approach leads to suboptimal latency on newer, high
> performance SoCs such as i.MX8QM and i.MX8M.
> 
> For example, the following are the ping result on a i.MX8QXP board:
> 
> $ ping 192.168.0.195
> PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
> 64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=1.32 ms
> 64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=1.31 ms
> 64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=1.33 ms
> 64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=1.33 ms
> 
> The current default rx-usecs value of 1000us was originally optimized for
> CPU-bound systems like i.MX2x and i.MX6x. However, for i.MX8 and later
> generations, CPU performance is no longer a limiting factor. Consequently,
> the rx-usecs value should be reduced to enhance receive latency.
> 
> The following are the ping result with the 100us setting:
> 
> $ ping 192.168.0.195
> PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
> 64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=0.554 ms
> 64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=0.499 ms
> 64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=0.502 ms
> 64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=0.486 ms
> 
> Performance testing using iperf revealed no noticeable impact on
> network throughput or CPU utilization.

Sounds like an optimization, net-next is still closed:
https://netdev.bots.linux.dev/net-next.html
Please repost after Monday.
-- 
pw-bot: defer

