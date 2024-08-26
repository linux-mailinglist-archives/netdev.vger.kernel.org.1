Return-Path: <netdev+bounces-122072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF6095FCCD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA546284FC6
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD38519B5B2;
	Mon, 26 Aug 2024 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru2Abz+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A54199392;
	Mon, 26 Aug 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711432; cv=none; b=NHwTxwzAqsymR7zPBj2oQApsaBX+OhJItJ4bTsBw70CvNaE02JxqLgc3YEwdcJdS+jUnBEmgauHNSk8EIs6Qz5PH54LegOg17b7NBHwFlv0hn2lqmZLxEdOiF62CBcI9CfYKxXT9Di7JR39L5Z/et2x/Uv/NbXlna6hT+sQOKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711432; c=relaxed/simple;
	bh=NZgPOFhIqIPViQpP6aVKnm/5N/U8SdouetIW0dTDBNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K7W1IdV0Z/o7yAk1ycnhy3RBlJS8pqcQ/HprznMJ5tXVeAruCXK/nsFAu5OPFKRyM7QjoqfTuLQxdmRmwDKIQPjQXtgdX6UjzDKiiLLjn1eNjuQQ9IupZBpYj4h+UwyZtUvL3XhLnTavkiI2BQC5vX9Kd2LWjFlsr2if4iVQYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru2Abz+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34308C8B7D5;
	Mon, 26 Aug 2024 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711431;
	bh=NZgPOFhIqIPViQpP6aVKnm/5N/U8SdouetIW0dTDBNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ru2Abz+0EEDVJvo/hY9TyYhN93UHtaC2wByWn+LQHc4loqjyhUuGI8zFarzUwD+26
	 LrD73bdJ55TL7v4xswQWZnHXuVwGt0kE8KPVQ8WtQ21t96uLRnn4R8TN5+Q5vB6RL/
	 oof/j/JEmwJd6VyzcueojCxX2eidzF/E6wcAiWWbhTfSUJrOn7etIJBzlAP+mr/vCg
	 iFGkrjxLzTjWsGZ/b9BJGYAA626BMtFCh8smafGEqy38rX9alQ3A2mIszspYDN84+T
	 gKbrCYsk+AxtzVw2MsdUYNekvhFkOWmzhhi4OUZtSe8PpSJOfWRf4YVbnBO4U9Xru5
	 YRFJTE2rBXtCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EBF3806651;
	Mon, 26 Aug 2024 22:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] net: dpaa:reduce number of synchronize_net() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172471143099.144512.14979007419630166439.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 22:30:30 +0000
References: <20240822072042.42750-1-xuiagnh@gmail.com>
In-Reply-To: <20240822072042.42750-1-xuiagnh@gmail.com>
To: XI HUANG <xuiagnh@gmail.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 15:20:42 +0800 you wrote:
> In the function dpaa_napi_del(), we execute the netif_napi_del()
> for each cpu, which is actually a high overhead operation
> because each call to netif_napi_del() contains a synchronize_net(),
> i.e. an RCU operation. In fact, it is only necessary to call
>  __netif_napi_del and use synchronize_net() once outside of the loop.
> This change is similar to commit 2543a6000e593a ("gro_cells: reduce
> number of synchronize_net() calls") and commit 5198d545dba8ad (" net:
> remove napi_hash_del() from driver-facing API") 5198d545db.
> 
> [...]

Here is the summary with links:
  - [PATCHv2] net: dpaa:reduce number of synchronize_net() calls
    https://git.kernel.org/netdev/net-next/c/2c163922de69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



