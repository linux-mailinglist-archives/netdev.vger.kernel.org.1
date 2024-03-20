Return-Path: <netdev+bounces-80724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB0880A5C
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 05:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31306B21A19
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B458460;
	Wed, 20 Mar 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmbszD0x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3026184F
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909029; cv=none; b=TuxvXTJchmAVyuTs4NJFYel23b3IsqSqWVqjAlaip+pPTUOB+Y6GFvUheWd9siWApegUrjFREHcsK0FOwuvHwPViWDEyYGmIsGIiV0lQA7G4Br2aUJwkl3Q1dypQTLWkCmRWzzV81Cg9ZfDFWb8IW8ZtNvFJJ196J449h/o1j2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909029; c=relaxed/simple;
	bh=GK9YWsI/z7UyRmkmrsNlL42xv15+lOlYUbqbXTyWVxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uIh6FSZ2BMO6UaUsyiPRH6KspzPV+87HfQ60+aJJ8zirJE2g4XE6F5Ie8rukTsvzN1+4SRX3OCF3JkACcrzFOtBXo3cdXNl0ARkjy1x9/GJdz0AiAhrtL0EqPjKIFCk2f1y4K5kDjKvitzGZPJuR14xy88pIyFecOEy1zHrqmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmbszD0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56B06C43390;
	Wed, 20 Mar 2024 04:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710909029;
	bh=GK9YWsI/z7UyRmkmrsNlL42xv15+lOlYUbqbXTyWVxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DmbszD0xAR3NeC5fL3Ga1kVPSh+0B0K0LQWUvgagqGkR6LfLuW3oL6T7YbbYcqkV4
	 wFfiixOUK7yJ3x04L1vBi2QOm9LFuQHkXrKEcmEq29dXzUCWE5skpjPzJ9fXW3Lgjf
	 GgEkr/mSrWpzVR1FErALDaXt4ni57HmW//vON6RVb+wi3fpde/qABcokmxTbGgmOEF
	 y1T9GDknvEDhkqNddEpI5CtvK+wsFp5yr8pzXzTUocdnx03GAKV50IlMc1A0wGRNIq
	 W4mt3QEzFS4vcg2a37juha6z6R7HHuioF76FtLHNf1TGQCIzIiQf4WMjABrtIp+5aH
	 Ok7SIqa0MG7zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 438C4D982E4;
	Wed, 20 Mar 2024 04:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ifstat: don't set errno if strdup fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171090902927.27266.18265340517235211753.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 04:30:29 +0000
References: <20240318091640.2672-1-dkirjanov@suse.de>
In-Reply-To: <20240318091640.2672-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 dkirjanov@suse.de

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 18 Mar 2024 05:16:40 -0400 you wrote:
> the strdup man page states that the errno value
> set by the function so there is not need to set it.
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  misc/ifstat.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [iproute2] ifstat: don't set errno if strdup fails
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=4da7bfbf917b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



