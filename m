Return-Path: <netdev+bounces-152822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729739F5D99
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62F8169323
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B812CD8B;
	Wed, 18 Dec 2024 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AErLo+lP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6727487A5
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493814; cv=none; b=fS7XLCmN4tSD+IGn1WjGRI4nuLdeb66FbuV9+mV9SX5E8dlErRMe+75C6nvC/2OHyzSIG4FamLgXk9l3LtRxBBwiItJ2HDrsIyCmT+QsJ4XsM2kIR+CKeF6O3we7hzpas3bMgedj71P6T1EHUCmQcSaSLQf8mv5/ZdFUCqYpFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493814; c=relaxed/simple;
	bh=xL2hT0K6Th+dAIzOVPJNeO4sJuGV6eMVmoxwHBWlPqo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnNtUoh5XzopsWIGXgWKxFkAem96n3lmcDPw9kfNF8tXrzzv1NEoOasqqmFH/RgT898H30xiEWJv1pb/QxoegMszgz0g3K3/55ANAkh6C3ljU2zZAb61wRMpFe9U4i3N+qjaqmr1AgmrBY3I4NVTmH1P8yfWQHXsfa9jiu24veE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AErLo+lP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2E5C4CECE;
	Wed, 18 Dec 2024 03:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734493814;
	bh=xL2hT0K6Th+dAIzOVPJNeO4sJuGV6eMVmoxwHBWlPqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AErLo+lPVCY2UyXQfeDqyxUtW+rem45bFhFWQHy/FU1DZnLiQr/bUBKxvl/sfpqQe
	 urwUrUiimQLKIVKQylbizyzrja8Ns/K02QypTW0kH34q2ZRclGc+AdJieddJR5XGdy
	 3BxVureH+cPZQ7S3YtJcNX3Cm6Ym83gM9VMIy4odMHc0CBB9lTztnYsvXGDH52HKyU
	 jwkWtPJ1x0QlLYFfRTA8jKUJ7wwDnXoWmP/VKDc5nDHa6qvDC3srEzLi42Mv7vclA0
	 6alQfHIErkT14RhrnNH7ePDzk0U6eIYnHr2l6H3FAZqIAkVOHvGnaL7jyjXNpjSJ9S
	 KV4FVl2Yv8vRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB253806657;
	Wed, 18 Dec 2024 03:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] inetpeer: reduce false sharing and atomic
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173449383151.1170405.15965464430728519978.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 03:50:31 +0000
References: <20241215175629.1248773-1-edumazet@google.com>
In-Reply-To: <20241215175629.1248773-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, idosch@nvidia.com,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Dec 2024 17:56:25 +0000 you wrote:
> After commit 8c2bd38b95f7 ("icmp: change the order of rate limits"),
> there is a risk that a host receiving packets from an unique
> source targeting closed ports is using a common inet_peer structure
> from many cpus.
> 
> All these cpus have to acquire/release a refcount and update
> the inet_peer timestamp (p->dtime)
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] inetpeer: remove create argument of inet_getpeer_v[46]()
    https://git.kernel.org/netdev/net-next/c/661cd8fc8e90
  - [v2,net-next,2/4] inetpeer: remove create argument of inet_getpeer()
    https://git.kernel.org/netdev/net-next/c/7a596a50c4a4
  - [v2,net-next,3/4] inetpeer: update inetpeer timestamp in inet_getpeer()
    https://git.kernel.org/netdev/net-next/c/50b362f21d6c
  - [v2,net-next,4/4] inetpeer: do not get a refcount in inet_getpeer()
    https://git.kernel.org/netdev/net-next/c/a853c609504e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



