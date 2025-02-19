Return-Path: <netdev+bounces-167577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3704A3AF59
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C6C189834C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF51A239F;
	Wed, 19 Feb 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1I5lkrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D851A08A8;
	Wed, 19 Feb 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931014; cv=none; b=Rs1l7WLR85w9ZWjGR7eaVEWBVL7ESVvpaoaBtFIYkvFALVBky/LvMgsXdhlnLkFUOG3V0EExihMrqAs7JxBp2f0gqDcn0Akr/CEWDBHYN/svHTNDIICh7dAFmocZNMG9+vrNGVMfuNzbWd8kT2cPFqcK/x7OecZRZ0yUrr1vN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931014; c=relaxed/simple;
	bh=QX0uKsFHqK5EZhY4YLrtYsUZm+NyM8VMY2lVCsFaDLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJTr2XruquNWOY0LfMVS5apprflbgYak1USD+Zxje4ra54pwmWORgY8itstNJMLXcjfzSNTNCcjfux87XkRHLR10a7ox6u1kJUegew6FEasb4YY7xG5Mo2lQ6Doy9S6+yWZYPwwFIpoQ3Pkmzh0aK5n5EFpO/1ia3yA4M7F+jjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1I5lkrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52494C4CEE6;
	Wed, 19 Feb 2025 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931014;
	bh=QX0uKsFHqK5EZhY4YLrtYsUZm+NyM8VMY2lVCsFaDLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i1I5lkrQ8y+D9hv7GA4L/cItNFU0tzVoKDHvKK7JP3n2LRaVC5kkkcUTf36qRmddB
	 haev0lrKKdHFClJ24RFcdXjvwWSwjPv4aX4mPpWz1/sOx0JBqXW7AAE5SIYaEnXW9q
	 wN5UFYYxl2j5+49JM8sbL8/NVZDc83IRI1WCydQtcNSOEx64E5zFOFmDukof4jQ0w/
	 mKJLPwjmwQDYPFAow9l8fB04RDXbeCBnONcS19W9knGeJCzVxqFEg4BNGK8aJpuJEs
	 CihsqbRBiOUpX6R6OUXfzUrFrKv/i4uM9g3d9G7yOkNT+QJzNSeAEi/Mn5fO2X7skf
	 JGfKJkVkbqVPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF9380AAE9;
	Wed, 19 Feb 2025 02:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlink: Unset cb_running when terminating dump on release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993104449.103969.1148424479511504135.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:10:44 +0000
References: <aff028e3eb2b768b9895fa6349fa1981ae22f098.camel@oracle.com>
In-Reply-To: <aff028e3eb2b768b9895fa6349fa1981ae22f098.camel@oracle.com>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Feb 2025 09:40:51 +0000 you wrote:
> When we terminated the dump, the callback isn't running, so cb_running
> should be set to false to be logically consistent.
> 
> cb_running signifies whether a dump is ongoing. It is set to true in
> cb->start(), and is checked in netlink_dump() to be true initially.
> After the dump, it is set to false in the same function.
> 
> [...]

Here is the summary with links:
  - netlink: Unset cb_running when terminating dump on release
    https://git.kernel.org/netdev/net-next/c/438989137acd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



