Return-Path: <netdev+bounces-97031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3478C8D50
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE91C22341
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED2C1DFF2;
	Fri, 17 May 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSMSWEvN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD41DFE4
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978310; cv=none; b=ePv8wuZ5F+r+nAUutQVQ5bbu1leNt+6B+08HvU6htpBaj2PK4Vxf2SysEtVA1xylZ9f0UVEnOU+tyjgHM+F+fymuoY66aS5DOQIjXz5yx1mEa6AVxZ94lihc+v0P9z8wbX3JTFPGOgxqWwSbno+ofZG/Fp42SEerdFeV5sBzYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978310; c=relaxed/simple;
	bh=QLMynQHY9rMT+v7e6QNMRck3cvDpr3kGp4oIKCQpzPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LMAXxcUoIqRMUgJuQKc9jkrSLu0s91JRWfWR+kv4cBujRG+X6IZSONr+zSJC3yEoJ65U2Ldm/JTqxCAFyMoo2Eo8TkFWLdi1z80uChzJ72tO2PrRgc2J/zWMiqcfwWYb+AdictuMQzNlL3bbyiyluR5KMAjbYIFxLYvNMc/gAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSMSWEvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB223C4AF08;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715978309;
	bh=QLMynQHY9rMT+v7e6QNMRck3cvDpr3kGp4oIKCQpzPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kSMSWEvNuFjdX3soQzyl9wpsjxf4jhp1OAJypGxkbvMLvQAt0xHPKLKnmO256B6VP
	 7A1yQwOd1sjTcYqAPzRPExfSOVJlb9eQe+Zo60Uom+NNJS4DRE8Ki7zVX4tlDD1Hn8
	 SeY5ya5nLmPA+itTW9ZMMTp5XSM5I7aBocLb3dILTpum4la3iobCtMo1jN74oO/6Od
	 pgtgZN7tra/l0LG+FfrkPVQgNwNVnHfvzS8b7nowfBZ9XrtJrE5BVxXlWqPna08GCJ
	 +3PqaEy9Bkrv7M8TP0mAfi9Ji7n7i9PTWqMHqiw7bbJG+xec7N2tVNW8Y3HAMvKOoo
	 Yz0AqBTfkppUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFCBDC1614E;
	Fri, 17 May 2024 20:38:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: fix ICMP error handling for UDP-encap sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171597830971.5541.6670033109325689905.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 20:38:29 +0000
References: <20240513172248.623261-1-tparkin@katalix.com>
In-Reply-To: <20240513172248.623261-1-tparkin@katalix.com>
To: Tom Parkin <tparkin@katalix.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 18:22:47 +0100 you wrote:
> Since commit a36e185e8c85
> ("udp: Handle ICMP errors for tunnels with same destination port on both endpoints")
> UDP's handling of ICMP errors has allowed for UDP-encap tunnels to
> determine socket associations in scenarios where the UDP hash lookup
> could not.
> 
> Subsequently, commit d26796ae58940
> ("udp: check udp sock encap_type in __udp_lib_err")
> subtly tweaked the approach such that UDP ICMP error handling would be
> skipped for any UDP socket which has encapsulation enabled.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: fix ICMP error handling for UDP-encap sockets
    https://git.kernel.org/netdev/net/c/6e828dc60e50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



