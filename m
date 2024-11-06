Return-Path: <netdev+bounces-142189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525789BDB72
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071931F23968
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072018E038;
	Wed,  6 Nov 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW5uFtri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530318E020;
	Wed,  6 Nov 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857830; cv=none; b=iS8El22918q2zEJCz07jkmgBNy6BtD04VEr/1NnrU11wOBDDcCF4tZLvVhfnQCJC+laZ7IdSXEDeFGKjvlHFlSj7wqUW+SaoYZCCu9L387nLxPOQDV70M/HMAogvHPhPENTgU6ku4HzU2uMrfR9stBwLfrAjDzamhIb/694VLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857830; c=relaxed/simple;
	bh=UycnUG2vyx2OGbJNhH8/v00Y16FzU8SjpOarn4OXYAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MpDi2zKnhRk2PjpfRpJIg6ZpBwy2y8BKGeM08OwQ0vbyK5chQeigMndOEJgT67/8/+Bc+RJx5evnnnr+XnkwgWIVHEKJBLpwukGNhr3sh80M0pFyjOyiLF9mbqI2IVeK/9hx6xSx9xFTiVTWM3+B6vLqebmxhMXJvYBHfDdinYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW5uFtri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B592C4CECF;
	Wed,  6 Nov 2024 01:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857830;
	bh=UycnUG2vyx2OGbJNhH8/v00Y16FzU8SjpOarn4OXYAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EW5uFtriyhkfGFToWekTZX4I9neZ+py1suYXbj53iYpewPAAglyHyYYtLUnJYSXrE
	 5KFxw5PUGpT/jwiRACRtO02xN8jPdL/NAP5r8jC2d8mqjKVSTXnuF3UqDlrQnU+ZS0
	 IRjjDTN3k66lmowQIf1jmyGs19/dfiKAe7vp14H6Kl37Hp24oYaRaBJ7Gr8ZknZc3g
	 N8PuODPFnM4rBfz0TWBXn5E4FOX5ls57xSQ3k0eLzPAI9VVZjQDuXN1SuVNiIXh9o/
	 rZClyc/D2nBhD640gBI6f9xQ0R6lpbq60LyOcBksprau9aDmqnoPD/61RQ9rt9Edwa
	 q3USPuFHuUfcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D353809A80;
	Wed,  6 Nov 2024 01:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] openvswitch: Pass on secpath details for internal
 port rx.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085783899.762099.17442482800210666704.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:50:38 +0000
References: <20241101204732.183840-1-aconole@redhat.com>
In-Reply-To: <20241101204732.183840-1-aconole@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, pshelar@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Nov 2024 16:47:32 -0400 you wrote:
> Clearing the secpath for internal ports will cause packet drops when
> ipsec offload or early SW ipsec decrypt are used.  Systems that rely
> on these will not be able to actually pass traffic via openvswitch.
> 
> There is still an open issue for a flow miss packet - this is because
> we drop the extensions during upcall and there is no facility to
> restore such data (and it is non-trivial to add such functionality
> to the upcall interface).  That means that when a flow miss occurs,
> there will still be packet drops.  With this patch, when a flow is
> found then traffic which has an associated xfrm extension will
> properly flow.
> 
> [...]

Here is the summary with links:
  - [net-next] openvswitch: Pass on secpath details for internal port rx.
    https://git.kernel.org/netdev/net-next/c/7d1c2d517f50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



