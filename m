Return-Path: <netdev+bounces-188214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94597AAB8EB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C864E4F69
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CD270ED2;
	Tue,  6 May 2025 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/U7ZYbd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9405287502;
	Tue,  6 May 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746495594; cv=none; b=MfJHMSpKH1UvnVoU/mjXvxto+7WNz4MOTWNNzajJmar61kKY9x0boRPRyjNIYT+cmEoIFyOG00rxMk2wL82ZpWvyxSMwxkX7fuxVE1x4xQ18Zakig8U4AAeMdZWCZ90+gQRJrpPtLxsbSWjY9oqRGCXhNR8aK6FdMD5BHjboPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746495594; c=relaxed/simple;
	bh=c9unjY9lvC/8kPwyEX04TWZ3vKRV4vrlN+1WvwRm4ac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FXuVKuVYaxwX0bUMYUubP7lvvXu2G6C7zVLJJvgHz9kQ913QBAdAE59T500RORUekrhQ33rDJOZHktBFeoQrQsGOqvN+uYG+T4pvIVjyIie8kWxT1C+YQkZ9jmDN+2i7Dwre9BKzOhcIjZIuJfWuBKDR76i1OfUp6UgA5aQIN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/U7ZYbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB20C4CEE4;
	Tue,  6 May 2025 01:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746495594;
	bh=c9unjY9lvC/8kPwyEX04TWZ3vKRV4vrlN+1WvwRm4ac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/U7ZYbdN1BSZfXzVUdfJJZaSwWKp/DX0ESCeyVVFk/+CQ6MuQ3OzZrUNdMNokS0d
	 8P//8feOjDFoc2BJACtCpYtgGw4UVR0OiZfsJHQ6uaa2iOIeuWVi7DCTp/AdTNddKG
	 38YRxKNfxXaDJ+8C2U9SW7Ngh56yH1k/0WjcBYwsIMsTWV44iYL6T8uK5sQGrASb7v
	 BaiY/zBmpXpVEjg4UESkEYRNY1JGjxtmdt2LCr+GPK6Xi3mvYu+7lUKuonYupPN5xg
	 dmihM3pDPXFICNhd+jpdDhvMU0zLgeHlOBlbBOROWb3VY/eDo72OzQ7DWQgroRqktk
	 NFlmuEdr4WKag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4F380664B;
	Tue,  6 May 2025 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv4: ip_tunnel: Replace strcpy use with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174649563350.1007977.12065018765324353318.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 01:40:33 +0000
References: <20250501202935.46318-1-rubenru09@aol.com>
In-Reply-To: <20250501202935.46318-1-rubenru09@aol.com>
To: Ruben Wauters <rubenru09@aol.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 May 2025 21:23:55 +0100 you wrote:
> Use of strcpy is decpreated, replaces the use of strcpy with strscpy as
> recommended.
> 
> strscpy was chosen as it requires a NUL terminated non-padded string,
> which is the case here.
> 
> I am aware there is an explicit bounds check above the second instance,
> however using strscpy protects against buffer overflows in any future
> code, and there is no good reason I can see to not use it.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv4: ip_tunnel: Replace strcpy use with strscpy
    https://git.kernel.org/netdev/net-next/c/c2dbda07662e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



