Return-Path: <netdev+bounces-79271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769AF878901
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399F828153C
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77AF55E75;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGXBh34U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A255C08
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185962; cv=none; b=NTJdt1TDs7s+VUPnzxIn1TGePozMR2I1M722YNfP9KM+2iQbivMzDAma9g2+yhTUBn+WQ+2A9uJ+LVJ1YXkNO9JX+cBrdSGe1wX32x5Jc6SqL8mNgGxb9+fs42UFuWr+9epEJdc6pjudCY3vj0A4lWG2CT265AAga7bjZkN2SOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185962; c=relaxed/simple;
	bh=IA3c9Nq4eM38hX1/CgLS0hVNmFDX36Mi+LYS4d8e2Z4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZBcagTy1S3jWSo8K8A8Jj4Ii22tpPDY3vKUqTS7+hdEd5q/z2gDGOuYolEqeQPkdBDyDMS4Ejc8vXIp9yq+1UW/fGqSVcpmuvK0AgoxDhY6fwFkWwJ0JskGYUzuZV08gRH4yCY5PR5iJ9KxBqj5HhKHbDeXkTZ9JgiveZnvVI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGXBh34U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D764C433A6;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185962;
	bh=IA3c9Nq4eM38hX1/CgLS0hVNmFDX36Mi+LYS4d8e2Z4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tGXBh34UQRdFdR8mYIWTLUEHEoAyLmYG4duEfFl6MqN8bWZ9pH8NWIphrc6LweoTt
	 SMznnDnKEsqf2ITbDF5GtMdxhYi/5D30a4kg5Jh+i5QOsjoNmLVmBS2zbX4mbrB+rO
	 QTX1I9YBRdYTWiiLn8id0WPLabDQshtq5ulcdN18ZUPj9N5LNL6qexKdZBx99HJOrV
	 tcM8KyOTvc72t+UMZjKx1ZJk0+WtHzp39BuSudonTkOiBhXw7KU1zxUyN5Kh8KMATX
	 jEs77cbWb3H4qQhgn3VgaQuo8zGaj7o23yimSQ345lm1DRFVfPiNMtM15F61g6V19b
	 lipzUagyPXy1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1A1BC39563;
	Mon, 11 Mar 2024 19:39:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ynl: samples: fix recycling rate calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018596198.1144.18106942127909565260.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:21 +0000
References: <20240307221122.2094511-1-kuba@kernel.org>
In-Reply-To: <20240307221122.2094511-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Mar 2024 14:11:22 -0800 you wrote:
> Running the page-pool sample on production machines under moderate
> networking load shows recycling rate higher than 100%:
> 
> $ page-pool
>     eth0[2]	page pools: 14 (zombies: 0)
> 		refs: 89088 bytes: 364904448 (refs: 0 bytes: 0)
> 		recycling: 100.3% (alloc: 1392:2290247724 recycle: 469289484:1828235386)
> 
> [...]

Here is the summary with links:
  - [net-next] ynl: samples: fix recycling rate calculation
    https://git.kernel.org/netdev/net-next/c/900b2801bf25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



