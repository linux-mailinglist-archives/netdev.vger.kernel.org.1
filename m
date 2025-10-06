Return-Path: <netdev+bounces-228031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198ABBF342
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 22:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750A53C0A32
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B52DEA89;
	Mon,  6 Oct 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="graBK8TN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3272DEA6E
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782883; cv=none; b=EwvFI92lOsMa3FnX20X1q5nN60fDLgLCi37ALKzCNgGip6bHV6Yb8NllOsbl3Z3iblL9how6S9+eCWtaK3tG/ugYe0QJwnJ+YrI5fcMlC1YSERQVI3miDijGEUaMFE+ipHQ48/bCTKAvmXcdslr02H3pFFKQ02lHDdX9OSFIYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782883; c=relaxed/simple;
	bh=EStykIO0RnsOoqJCqqXdOHSyfx5KfVQYep5tsfOo2J4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DNylOTmPLCiChCqiAEVZGo/hBGXowvmannn67TYEuRNmguoyOrjWWDIiuVeEIq79QzpQ5ZVt7l5fSOYZLcoaYXXyh6waJcyHzY924IP9wECzmZef9kSDmf5Z9mkD8VkzeEznOsLYrGPDrlpfYXdqN5IuBtEVXrhsou69YinQ+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=graBK8TN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0879C4CEF7;
	Mon,  6 Oct 2025 20:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759782882;
	bh=EStykIO0RnsOoqJCqqXdOHSyfx5KfVQYep5tsfOo2J4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=graBK8TNAyL9dLL7TiInYBSINs+F4xLaM2CZIE1Y5I0WUOIbr+P2MsbUKdED1m4mG
	 /eHDqRgWLnInGvuqTw21FhQyL0FNk2F60PbAqFagNT+l2lCNlu/is2O1N39ZbsJqfy
	 Z3We+cI2ZpQDozLYYddfYMmcj6vtNjAH4XzqA5AiDDTyvSx9b7TIeVZhKQyaIVDclf
	 qyE2mQ0OmhHfBXKum48Wc0AoNjVBscfwXqTEZLEt753J4ob2UdzzDyTIBMZhfpxk4r
	 QUQ2DrmWtQt2Onv0lQO/3XoTF3yn9No3b8rwelyNeqTFfh9YAKQsBpAwtEBdSSgUY8
	 ZD0ZW+sacZuTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4239D0C1A;
	Mon,  6 Oct 2025 20:34:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: take care of zero tp->window_clamp in
 tcp_set_rcvlowat()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175978287249.1522677.593941136577699237.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 20:34:32 +0000
References: <20251003184119.2526655-1-edumazet@google.com>
In-Reply-To: <20251003184119.2526655-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Oct 2025 18:41:19 +0000 you wrote:
> Some applications (like selftests/net/tcp_mmap.c) call SO_RCVLOWAT
> on their listener, before accept().
> 
> This has an unfortunate effect on wscale selection in
> tcp_select_initial_window() during 3WHS.
> 
> For instance, tcp_mmap was negotiating wscale 4, regardless
> of tcp_rmem[2] and sysctl_rmem_max.
> 
> [...]

Here is the summary with links:
  - [net] tcp: take care of zero tp->window_clamp in tcp_set_rcvlowat()
    https://git.kernel.org/netdev/net/c/21b29e74ffe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



