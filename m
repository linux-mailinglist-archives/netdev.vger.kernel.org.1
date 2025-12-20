Return-Path: <netdev+bounces-245599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3122CD34AF
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 207AD3007E62
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D5307AC6;
	Sat, 20 Dec 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YztI3DKE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124E22154B
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766253268; cv=none; b=tgJgFppZtvMqggf0z5wK1jmegwmYHN5wk84oPd1xlaCFYrEf4o7qUlshZIC6GjAIVS82K8Fy4anDjG7VDdPcPm0Eq8qfdxQhzismg4zLzGC9+YUHyYnWhk/5Q5uXUh+K3WkNyWasdmGe60ZCHsp1g9u/I8GtDrliX81F8z0Jd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766253268; c=relaxed/simple;
	bh=mX/T2ssXsYa7jTnKl7494pWo46vNjnXdFpJhy+34ZGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pkAoRwiq62XoJHk/L5wB6xWK/pk3b6AeAL9DegVRPIcm5hSzMD6fr/Ws73j23qaofg7hNhDmqvSqzcLTIy4marbvktcU81D5ZKI/gwkkvcpyPom7Qapr24D2qT8FtYQf9kb2svwwx5GlmVFiouFhPJVVw31AiTt187+bejThxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YztI3DKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A4AC4CEF5;
	Sat, 20 Dec 2025 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766253268;
	bh=mX/T2ssXsYa7jTnKl7494pWo46vNjnXdFpJhy+34ZGo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YztI3DKEqw9A+YQ6kI4aa7zTVRAf0Id4icHaKg4YcxA/RTIfi6+8hYeSqmRx4lnpu
	 38niAXGM0gqcpxBbZdta7ufHjjp669aMN62KGvTOeV0AtDXR8srZPLHBYowjfXy7js
	 1Y7YGczqmM8iLvoL8okb20RTDSVu8HYLZyvCDgINYlYPMUNh2li+15h6Vu256nDSKU
	 OhSOaewogQTTwO2ByqTAaRYElG94c9gUtzCQdfJ33d15zpbJX5PQUffw01sNxdNWJL
	 hv9UCJk0WZZWTmirnLRnG2ubT8YDhD2vUYPn+3JTfJ7cDgtMOoR7XYHPfMZ2Ya9NnD
	 973fKUxifP2xg==
Message-ID: <4a682f36-44a0-42c9-a82a-25fed5024cb2@kernel.org>
Date: Sat, 20 Dec 2025 10:54:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG nexthop] refcount leak in "struct nexthop" handling
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 "David S. Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Ido Schimmel <idosch@idosch.org>
References: <d943f806-4da6-4970-ac28-b9373b0e63ac@I-love.SAKURA.ne.jp>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <d943f806-4da6-4970-ac28-b9373b0e63ac@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/25 7:57 AM, Tetsuo Handa wrote:
> syzbot is reporting refcount leak in "struct nexthop" handling
> which manifests as a hung up with below message.
> 

...

> 
> Commit ab84be7e54fc ("net: Initial nexthop code") says
> 
>   Nexthop notifications are sent when a nexthop is added or deleted,
>   but NOT if the delete is due to a device event or network namespace
>   teardown (which also involves device events).
> 
> which I guess that it is an intended behavior that
> nexthop_notify(RTM_DELNEXTHOP) is not called from remove_nexthop() from
> flush_all_nexthops() from nexthop_net_exit_rtnl() from ops_undo_list()
>  from cleanup_net() because remove_nexthop() passes nlinfo == NULL.
> 
> However, like the attached reproducer demonstrates, it is inevitable that
> a userspace process terminates and network namespace teardown automatically
> happens without explicitly invoking RTM_DELNEXTHOP request. The kernel is
> not currently prepared for such scenario. How to fix this problem?
> 
> Link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84

thanks for the report and a reproducer. I am about to go offline for a
week, so I will not have time to take a look until the last few days of
December. Adding Ido in case he has time between now and then.

