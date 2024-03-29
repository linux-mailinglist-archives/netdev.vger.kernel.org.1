Return-Path: <netdev+bounces-83444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A49A892462
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D31C2131C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACB5131E59;
	Fri, 29 Mar 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE1W9062"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B43B78E
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741230; cv=none; b=u9Ux9qrGE0p59TWiaP+3zoj8nuLSGKckJ5fuLBn82tiJumNsEAxL1maTs2E+CrXg8lcdmg9xawfYzLgAvIQ0s/sKTroESVDK65qk2BLdeEvjxZg69+jVQBYCsb0xK8G3HgDEXyYnnSXg4aX6s33gExoM6gBDQEEsLYLlP8k/Eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741230; c=relaxed/simple;
	bh=KtwH4JU6R07qC9iKh828leWD3mREIZdmqlOr7LfdHFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eW5ZAwB0VThkDQRTT3FDDDM9N3GZ9MwrIeLYFny8429kCYDgbNqe7yopeEFDL58Av+kGtYn5H78cCshCJiaLH6SciwnH345OhvMgQPJsl1//NXQCOKTp0vtQVyqvUSgsYWHJwcS/ID2ORT0RaWMfF8uycCG6akgxlKxle4flkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE1W9062; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7314C43394;
	Fri, 29 Mar 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741230;
	bh=KtwH4JU6R07qC9iKh828leWD3mREIZdmqlOr7LfdHFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XE1W90622iwU9OccbirQ2gTaaaJWLSLP9mb3yJfYM9CWggetPfBJ+GANrRYz18Zli
	 iW+SBdnLa355E1id99U0ysx7Dn7ohSHdjL+IfGaAkP7cCdw8CbFGWeul/oBs9pkTzk
	 pycGYlrfNUFL4vJeAJn0ZnxdhNejd1JaLTAphrC1G9hQ32Uj/bp6HBJE0AL2iM6ND0
	 hSbyKy5/PlPtZnNA27yUNqdg9G9hHFRDCOiQdhQtEeNyzzS9iERh99DLF+g7toXVlC
	 IH43XfdzxuYvc997F5Hw5MBwTIkTbpABzRF/Ls7TKiWl5iVLWcDgtwwDqe/VE0bSFv
	 lhuMz51VgD/JQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4B9ED2D0EB;
	Fri, 29 Mar 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not consume a cacheline for system_page_pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174122986.26003.4948949718309362435.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:40:29 +0000
References: <20240328173448.2262593-1-edumazet@google.com>
In-Reply-To: <20240328173448.2262593-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, lorenzo@kernel.org,
 hawk@kernel.org, toke@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 17:34:48 +0000 you wrote:
> There is no reason to consume a full cacheline to store system_page_pool.
> 
> We can eventually move it to softnet_data later for full locality control.
> 
> Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] net: do not consume a cacheline for system_page_pool
    https://git.kernel.org/netdev/net/c/5086f0fe46dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



