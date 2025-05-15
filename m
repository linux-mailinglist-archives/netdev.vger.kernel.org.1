Return-Path: <netdev+bounces-190752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FE6AB89D7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B09E1BC4572
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F51F3FEB;
	Thu, 15 May 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/8ea/RN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87521DED69;
	Thu, 15 May 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320599; cv=none; b=FCKhBnHeUnu7iz+tkGKy2tGyTEOyqLFGotfryS3LfYu0uZIF6q4f/ciXYfDS6CfRhQezVLI2OcuyhnTC3IMgfn9wVu7Be/E7NsUK4TJkj/Rq3nqI1mR9bDOb1lf+VkJ6azvII03EhbnKYIlsWvktoNzTVtb8j/PClL1o3ME0vJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320599; c=relaxed/simple;
	bh=kkn17Jt03MhKy4AFP/8fqOQ2y54FZN+sG/ga/lrHMG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EkgEHUGmRxNwQPK+8Er7yGSlX+wsjff03995ZtA6kzxUZCarfE8bwu1Ejfyf/HdNyV4XAsnQwQnGHEkRkKfVbeMYPWl1msrmjU/wrr6IwfURU5aQyrGqASD43PqXuVA0XqPQUDQiMlULk1nannuFxnqqHSR5YnW8qYKu3ymGOEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/8ea/RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9BFC4CEEB;
	Thu, 15 May 2025 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747320599;
	bh=kkn17Jt03MhKy4AFP/8fqOQ2y54FZN+sG/ga/lrHMG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y/8ea/RNV5A0sJvRQOzGLXg67jSW6soPYZRZ/unpHrXLt6plOnlpVR7Z4cq33rSBk
	 sTlFUir2I1m92qmubCxja7SHsg/eFyeM4wDv0qWiVRUw6NM+rRr1tWFGQuxcs6vb9s
	 SUSMvodASBXHR8YBELHOCVv1u9jL5A8aRYVTGOPQPHODl6pxzNMShlYTK0U8vegBOd
	 3F7Ld8x87H+kaBoKISSQ/pWY85W/b1RgWmpdHeM/pHPaQcCNuAUpz66ZRyTXXro92I
	 zvoK/RHqeveZ5jaQrlqFrYmT8w/3N8+tPyLFnkLjNQrSccpzDXa2bGEfp92Lw6kVr5
	 MslHM9bRUznSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EDC3806659;
	Thu, 15 May 2025 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tls: fix kernel panic when alloc_page failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174732063626.3135544.6593619015947519690.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 14:50:36 +0000
References: <20250514132013.17274-1-hept.hept.hept@gmail.com>
In-Reply-To: <20250514132013.17274-1-hept.hept.hept@gmail.com>
To: Pengtao He <hept.hept.hept@gmail.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 21:20:13 +0800 you wrote:
> We cannot set frag_list to NULL pointer when alloc_page failed.
> It will be used in tls_strp_check_queue_ok when the next time
> tls_strp_read_sock is called.
> 
> Unable to handle kernel NULL pointer dereference
> at virtual address 0000000000000028
>  Call trace:
>  tls_strp_check_rcv+0x128/0x27c
>  tls_strp_data_ready+0x34/0x44
>  tls_data_ready+0x3c/0x1f0
>  tcp_data_ready+0x9c/0xe4
>  tcp_data_queue+0xf6c/0x12d0
>  tcp_rcv_established+0x52c/0x798
> 
> [...]

Here is the summary with links:
  - net/tls: fix kernel panic when alloc_page failed
    https://git.kernel.org/netdev/net/c/491deb9b8c4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



