Return-Path: <netdev+bounces-166698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD21FA36FC8
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C26C3AFE0C
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8CD1EA7C3;
	Sat, 15 Feb 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+nZ3Gvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39117B50B
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640600; cv=none; b=f5NqFv8B+mCD9X87a+el2X+LYMbVrPa9lUgCB3uPqASvM957FrUj7r7M+MPHyeL59J16QZg2IOxxYnTobUc9GAMVgJV04vf2RBE4wB55dnbZEfuQh6yYDGarjmQGuquSwiLfwEvEiyy/eFCOYQ/wEaTGAi+uBP4wceLh5c+FmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640600; c=relaxed/simple;
	bh=tKOBzBxlRpCPco1eskLBhqzcqZL/mxMqxCxcklwD8VM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfee5heEFS4V6vcdYr19rZLFanvIvV5hMwXP2JDN3wSgb3QMmH+W2JaZ7qQhcUvdOv/izRSUttPLbLGyXdJMlAOErmmL7bN+/2SDehWDmolRFc+e9ZtJAYMmCQ4gm1rp6cSRGd1teGp4IKlGkpYWtZe5Bfe0tjgGh19ZpSlKzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+nZ3Gvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BE3C4CEDF;
	Sat, 15 Feb 2025 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739640599;
	bh=tKOBzBxlRpCPco1eskLBhqzcqZL/mxMqxCxcklwD8VM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+nZ3GvbxnJCPCe8Va+3CUk4dU+Ol9ng7k1gM4DbCtVcFRpU3s6i1EuC6JD7Ythnb
	 sgK+C8FTMnT+JeeutRbm07qzoeHTsl717wxhTigIjM6I7rwRYiP2FEhqgL5oKagbze
	 113oQKWeT1G3WIW2qgmLHH+7yhaWNNRVQ+2fsRyGnMBeL+jwPQeCL0lvOtocKzVA9Y
	 ItZtdehhVJrQTU8X5B17yb0vT2+dS8Wa48/PIzzMMfOOY2Uj8AMMhFHs1bpQ43jPsb
	 rk00E2l3AvS8jiJskH9f3QJZhIuX3EToz9R/8dml/8ab/TxaKssRIvXRXgp4yh1Hv+
	 wysYiUm0/tn4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7419E380AA7E;
	Sat, 15 Feb 2025 17:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_api: fix error handling causing NULL
 dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173964062887.2306719.12280700542530896756.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 17:30:28 +0000
References: <20250213223610.320278-1-pierre@stackhpc.com>
In-Reply-To: <20250213223610.320278-1-pierre@stackhpc.com>
To: Pierre Riteau <pierre@stackhpc.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 23:36:10 +0100 you wrote:
> tcf_exts_miss_cookie_base_alloc() calls xa_alloc_cyclic() which can
> return 1 if the allocation succeeded after wrapping. This was treated as
> an error, with value 1 returned to caller tcf_exts_init_ex() which sets
> exts->actions to NULL and returns 1 to caller fl_change().
> 
> fl_change() treats err == 1 as success, calling tcf_exts_validate_ex()
> which calls tcf_action_init() with exts->actions as argument, where it
> is dereferenced.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_api: fix error handling causing NULL dereference
    https://git.kernel.org/netdev/net/c/071ed42cff4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



