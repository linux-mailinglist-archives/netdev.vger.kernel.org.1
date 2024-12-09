Return-Path: <netdev+bounces-150404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887DD9EA220
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DD1284A30
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F00119DF44;
	Mon,  9 Dec 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsuTetW/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E02C9A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784616; cv=none; b=s4maY1HLtEh6LLklf0bJ5Pd8lF6YeCNNuON9Ueqka5Erw6ixSUO4yB1ehwo9IqHqEi0jr0GgDmZQOCbz3LhfjCPVdgLzdAd5HIq6qnO1tufgnMpFGE9oK+SAJMhQ+PgD/CjfPGeKJRG4cr2R1utj318kKgHxaUo2OJwT1qUgOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784616; c=relaxed/simple;
	bh=jJYTRLqVs0lcM4WoMt0lImXxnkAvO4Mn1iX2RpM8Wbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pa6dw+9R7CdYdWV2doogaDWWbyOPOpi3Dm4jfq7ilcH2ISU4EQlU92+YGZyYpD9EkqIdpSauYRzPZ9UTKEnRNqSiTMVgEwtgf3i7E50RefCHHib7jksoPoGyckPEvAizeAhj1m4hssD2vWhbLGwd4mlFmcgoQ9XawNVg2bXnDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsuTetW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65365C4CED1;
	Mon,  9 Dec 2024 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733784615;
	bh=jJYTRLqVs0lcM4WoMt0lImXxnkAvO4Mn1iX2RpM8Wbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UsuTetW/8L4kOwtemoju0+Enh2yJ+QKaMAysi6+cavw+QCNrrJKK2nglarS5/X/r5
	 jQYYS7TYmpiQELaO90Cs2mucAxAGpHkrQKyiPigCqY3cD14fJs6BWgKZt6khOQvVGF
	 zz0HCqXqemiMotMbUwAMhsS0i2VqL19qqbDkfWrGJD51ObNc3++ZttXp2NJDgnMiB+
	 xcZ91O2L/ZEatCyIVX6T+AMiF4z+0D8w/Drv2ZXvxk7+o5XXfe0GHQ+p0IQc2aXwVE
	 MeVgp5B6K4dgyK80Tm5b0Gy4h0cQLSjvE6phmER8mIgLjtEitUQMkA8TmNK2ug4SyD
	 8B4zcBP7P4MWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A70380A95E;
	Mon,  9 Dec 2024 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mctp: no longer rely on net->dev_index_head[]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173378463075.265624.6135159899694072322.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 22:50:30 +0000
References: <20241206223811.1343076-1-edumazet@google.com>
In-Reply-To: <20241206223811.1343076-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 jk@codeconstruct.com.au, matt@codeconstruct.com.au, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Dec 2024 22:38:11 +0000 you wrote:
> mctp_dump_addrinfo() is one of the last users of
> net->dev_index_head[] in the control path.
> 
> Switch to for_each_netdev_dump() for better scalability.
> 
> Use C99 for mctp_device_rtnl_msg_handlers[] to prepare
> future RTNL removal from mctp_dump_addrinfo()
> 
> [...]

Here is the summary with links:
  - [net-next] mctp: no longer rely on net->dev_index_head[]
    https://git.kernel.org/netdev/net-next/c/2d20773aec14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



