Return-Path: <netdev+bounces-196768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11540AD64C7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D2B188445F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346FF72637;
	Thu, 12 Jun 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt7Bjd45"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6C72616;
	Thu, 12 Jun 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689408; cv=none; b=JJ5KoAQPnxOIp5weJU0tHRDunfgB0r0+cAhN/LJmA8ACakSm3RaWyAAHsrK+G+YojEL2cl4qGq+RK6zx7Y5cruOCmf+49Ioj2qjU/jKbrX+I+ycPiYRN7hnvzqU52M4Sj/egVwTq5DD093ckB+Pp0pqzG6hTUre50rGuELH4o48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689408; c=relaxed/simple;
	bh=LhIRh8KdmKAkbr3/t5AAbCmWmT+ExP2OEERaew9pFEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QHwzwszz5aK0q1uwANMhfSTzysf2tItFcRoPhRRUTm8L1FYwmD/vsjQF/pUtjJfGivrqsKlGVNw9FejwO6cspKlaJEklNrmIYkGI7dBdkDtXUJaHFop3QntcvfL91m6fS/e0CM5VvKWw7GpJdpaVwPXFW4l29gs20YUOB4R27lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt7Bjd45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE32C4CEF2;
	Thu, 12 Jun 2025 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749689407;
	bh=LhIRh8KdmKAkbr3/t5AAbCmWmT+ExP2OEERaew9pFEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dt7Bjd455bJztzFHzt+igJQ9iYn274xKgPd0VMqsy/0KMdf/9QCj51OcyzMLMgsN1
	 R3GCQnMryjAOQW4VNglYf8iJBR8nFv4gWeGNf1cnHusyZKbuO0Nh3pP0GA6JQh9U11
	 4E/jUSdD0Cec/zZGsR+Vw/slAaiILPAbAcPIn3p6VxFBMvyTNMXb9+5Bg0X5G2deCP
	 fKHL8gsfv2hikrKH45NyTmlGV0wDbh6kWoUgC+L3MsfTu/QIZMfI3bmIjE5CgYRItB
	 YRdy1RWpPMNQgI1OlAXv5STRsXFDJWDUztvHSjzba3ZAfAIjdZ/Q2sgjRL7c+ixF5O
	 TahPxpirBQsFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1B3822D1A;
	Thu, 12 Jun 2025 00:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: macb: Add shutdown operation support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968943799.3552664.1746704463270362055.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 00:50:37 +0000
References: <20250610114111.1708614-1-abin.joseph@amd.com>
In-Reply-To: <20250610114111.1708614-1-abin.joseph@amd.com>
To: Abin Joseph <abin.joseph@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 17:11:11 +0530 you wrote:
> Implement the shutdown hook to ensure clean and complete deactivation of
> MACB controller. The shutdown sequence is protected with 'rtnl_lock()'
> to serialize access and prevent race conditions while detaching and
> closing the network device. This ensure a safe transition when the Kexec
> utility calls the shutdown hook, facilitating seamless loading and
> booting of a new kernel from the currently running one.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: macb: Add shutdown operation support
    https://git.kernel.org/netdev/net-next/c/5e84d5b36b5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



