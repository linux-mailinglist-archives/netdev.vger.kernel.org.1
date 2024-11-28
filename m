Return-Path: <netdev+bounces-147676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596C9DB20D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 05:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2DC1B2187D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 04:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5DA126C02;
	Thu, 28 Nov 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0HvADJk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A691134BD
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767016; cv=none; b=UA7duK+IPxHBDNC2rrgMUsluLFlwGsNXCcrKVdOHmmGVN3j3jsxGwY24EZFUwNJ6NHFnpYBJtEgmEIOljHhqnYTpCfKmivHwOgIfLl/71Tdu3wuwlVJkgIUbyQXDNr9K6RRnKxqd9CN5bWe1hGAJZ5LjOEQLQI+JdmiXHBnXwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767016; c=relaxed/simple;
	bh=a+lYQ4gSWlFLqgUrYyjsm+cKPrhL4j6c4UeQnYdIXik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=azLShSW7D5rM7cG0Uf1APtZWwcAbsKELHZdsbSvipeQYxEd7QGpOreq8HH9w0wXOjfo8oCqi9T6JffXsZrQ8L54IOj0gB/awzZeps9ioVd8CQ+0/IZvNkzhn/2CuIPh2fkVMwYLlJWkEyPLZ9V+L8RaCR5Oh+eniTTo3OtrVXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0HvADJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B942C4CECE;
	Thu, 28 Nov 2024 04:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732767016;
	bh=a+lYQ4gSWlFLqgUrYyjsm+cKPrhL4j6c4UeQnYdIXik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J0HvADJkHZGOHym/E1/EfQOw0LOjXmKMJcdEqVsmfZ2RACqhZoj4HcFtjzJapXub/
	 tv7nURE+Sw6rzj+6L8qu3iTZCIWHmHkaJmVunFEMVM5qCkNxrJm4vnP6RnYXL1XC7V
	 VqMAxnfvGymAcGSokjaqneGK7GrwyGXNjHvqMVs/rlsWsg3Qgkdd1DcetHYhHx85pI
	 uaLfolIgj/KV49WY7sag6H2JueuiDZUQrTJScL5NWnUusjZqnBLG94haY/eqb1iIGT
	 xzk1jHmKtYlxN5a4vLZpbz0rjqQpIb01ASK+Y9EB3rk6zqwqunHOh8Xj8Q5IWU3Vpf
	 0UgTCKeFeFKpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71F1E380A944;
	Thu, 28 Nov 2024 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] devlink: fix memory leak in ifname_map_rtnl_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173276702937.1606457.9820576186870523177.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 04:10:29 +0000
References: <20241125032454.35392-1-heminhong@kylinos.cn>
In-Reply-To: <20241125032454.35392-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 25 Nov 2024 11:24:54 +0800 you wrote:
> When the return value of rtnl_talk() is greater than
> or equal to 0, 'answer' will be allocated.
> The 'answer' should be free after using,
> otherwise it will cause memory leak.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - devlink: fix memory leak in ifname_map_rtnl_init()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=dc283e7b796f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



