Return-Path: <netdev+bounces-78579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0A875D0B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443481C20D87
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60C2C6AE;
	Fri,  8 Mar 2024 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi8Q1PwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AB23775;
	Fri,  8 Mar 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871030; cv=none; b=ot94Rl1ebOREeidcNS6YfXItt9Ahm8QMIahrEerCOfHQKdKtmcZpFI+lwdZIbDL3yi1PG9ulZWBWr+pEKah/c2KBBbg97C4jdYhsBCMIXup0wIAir6szKUz47CxtKG/Zy0lXbxUL80kcb8iyzhhvqUivaWSNbAAY6pTCqqiIfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871030; c=relaxed/simple;
	bh=zBKCtVKHUVP0YPHPLhCu2OSFItgCHklS1adP/X+nCyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d0olne1kqnn2nXHXp+2jEtPYymlLaVnFkGDSC+/NGZ9BdWmws3mfXwqp/aSvqymI+rqb4G7JD3AWa8BMRW6QBsHwV5TdxZZJKALyGVJ1ZFAS7htfjPMyMtlu7HUSeOauCTySnTSWwcliNx2NpFcKzlAIgqHL6HO3ubslqugNM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi8Q1PwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8549AC43390;
	Fri,  8 Mar 2024 04:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709871029;
	bh=zBKCtVKHUVP0YPHPLhCu2OSFItgCHklS1adP/X+nCyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mi8Q1PwZh+/ViFjbFDHrjaow7cgbnq1CavDzpSptbnR3uWrPg12ohjmYkjtZ01+YK
	 C/efJboLRjatLHpDbuSmzmSR3iT/PD7K6N+ordBAfQzZCHkIUWnyqmIX17NXQ3ZQ6k
	 pHTsG0aEm0txsvRbkbetVA9qcnFPvrfNerJpblJRcpcXn+tnxO61gdj0jPnRoHWZVs
	 CG7x1Iso5YE1lEHG3OzB2iqERzantKBbtkl9E0fVA/tQLfdkYrr3H3+OmbKfRTSm8c
	 WzJdFEjOM7eji7t/CH2MdzuWU91FDIw2FX+RmzUr8+nL9tTdt9+qo5fmbHNSXty9oH
	 BvWx/b4lOVikw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AB29D84BBC;
	Fri,  8 Mar 2024 04:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] Fix hash bucket overflow checks for 32-bit arches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987102943.21432.2167255417824159739.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 04:10:29 +0000
References: <20240307120340.99577-1-toke@redhat.com>
In-Reply-To: <20240307120340.99577-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, minhquangbui99@gmail.com,
 brouer@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Mar 2024 13:03:34 +0100 you wrote:
> Syzbot managed to trigger a crash by creating a DEVMAP_HASH map with a
> large number of buckets because the overflow check relies on
> well-defined behaviour that is only correct on 64-bit arches.
> 
> Fix the overflow checks to happen before values are rounded up in all
> the affected map types.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
    https://git.kernel.org/bpf/bpf-next/c/281d464a34f5
  - [bpf,v3,2/3] bpf: Fix hashtab overflow check on 32-bit arches
    (no matching commit)
  - [bpf,v3,3/3] bpf: Fix stackmap overflow check on 32-bit arches
    https://git.kernel.org/bpf/bpf-next/c/7a4b21250bf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



