Return-Path: <netdev+bounces-140191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635D9B5809
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887A41C22A92
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7456920F5B1;
	Tue, 29 Oct 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DruI43d1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11820C48F;
	Tue, 29 Oct 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245823; cv=none; b=r8yvggDDAQc0xyjqm/DbegqM32H8r3sKWyJWs92H+sXhCahajp29yjHcE8vFloXT8AHz0d281otn13477FgUlhrjh5twx3HjJm4X/gqXdDQS9dMFGFMFUmZ3cjpyi2IDtDWHOAPdIcS8Pm5oskpMi1naI/d1P3m5rmJ61icbqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245823; c=relaxed/simple;
	bh=PywelGb5nKYcEkX4Oxcod0UeSEo5aFC1T6+IF4fr1qI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DbaeodNpE6l6PjfgFVajHnYpkrgkzmna1eJ2yirpXh6lxJwMJnUsML7quCm/3FeOY/x0ISzx6LU1CRjZnux3lG8LtxEp5qYeDX5781KyWGOGCJn2DF8Z3JOwVyklPqmJ1v5HpOc5ZCq7iwO7RChhtvbaSyTeDdeHDQBzN54pcXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DruI43d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA67C4CEE3;
	Tue, 29 Oct 2024 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245822;
	bh=PywelGb5nKYcEkX4Oxcod0UeSEo5aFC1T6+IF4fr1qI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DruI43d1h1WaLJpRy//D5LfuLKpb7EymWpqMfuYLQ79EvZjxYCancXPOUuJCarj/E
	 awBesJdUFJL+FI+Tah34Gm+CRHHnCJUWYdg0vyfFKB/FQH+fwYr3dTKKr+BzJc4rWn
	 qfIkWQDZz1nXsm/RdlZUfJPFAD9tntS1EEl2JCSx2bWSat3A+WI3mgC/nIWUh1SMBA
	 YFznFQhEQ6TEuBJdJl1T4o0NCT4PKoZ4VwnvtXF/hm0uiSBjzbCP3r+cEKPVQ+GkuT
	 CDKAc5CI/IvgQwhwlBRgDWd1PSy2yY4W5McuPYOl+NAV00lGg0h4Fsq+SHZFxxAWPc
	 TusLuueIGxi+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE18380AC00;
	Tue, 29 Oct 2024 23:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: fix crash when config small
 gso_max_size/gso_ipv4_max_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024583053.858719.7672255955334382371.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:50:30 +0000
References: <20241023035213.517386-1-wangliang74@huawei.com>
In-Reply-To: <20241023035213.517386-1-wangliang74@huawei.com>
To: wangliang (CI) <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, kuniyu@amazon.com,
 stephen@networkplumber.org, dsahern@kernel.org, lucien.xin@gmail.com,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 11:52:13 +0800 you wrote:
> Config a small gso_max_size/gso_ipv4_max_size will lead to an underflow
> in sk_dst_gso_max_size(), which may trigger a BUG_ON crash,
> because sk->sk_gso_max_size would be much bigger than device limits.
> Call Trace:
> tcp_write_xmit
>     tso_segs = tcp_init_tso_segs(skb, mss_now);
>         tcp_set_skb_tso_segs
>             tcp_skb_pcount_set
>                 // skb->len = 524288, mss_now = 8
>                 // u16 tso_segs = 524288/8 = 65535 -> 0
>                 tso_segs = DIV_ROUND_UP(skb->len, mss_now)
>     BUG_ON(!tso_segs)
> Add check for the minimum value of gso_max_size and gso_ipv4_max_size.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: fix crash when config small gso_max_size/gso_ipv4_max_size
    https://git.kernel.org/netdev/net/c/9ab5cf19fb0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



