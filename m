Return-Path: <netdev+bounces-125309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67596CB8E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED7B282583
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AF184;
	Thu,  5 Sep 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y14g1ag7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62A1C27
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495033; cv=none; b=mXf6pQLZj0QhL0CeY30BV6eFGPfWiQTy6qywVq2UTMVL28onT3DA9x3/PZbTKEFBRPeBl9g/tUsxiB2IRA3Sp3R1asglX3MLILl1TAu8H6wYOZTon/BqtgJm//m3q4lN3VVdz0gJyEaGhq2u+ZrLxbl0d1vT2d6gFKpWpB7W7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495033; c=relaxed/simple;
	bh=7DlZNYgf1uUyC8mAcNoQCpLZJrDDjukFyaJEv91AlkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFVW0oI4PHOAa4ibaE79R1LPTL91lfPl0X+5hApHoSjSRtdC9OHPRSaPchat+L8dAjJ66os42ta0tOdGJGxOmrlBkRx5i9rttEG/K22U3a2dgUqY8yWxJrnScqKEIPdJkqbefRBsBySzvF7NksrwChC/NKJ7rsIfDqdlVtxVNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y14g1ag7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323EDC4CEC2;
	Thu,  5 Sep 2024 00:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725495033;
	bh=7DlZNYgf1uUyC8mAcNoQCpLZJrDDjukFyaJEv91AlkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y14g1ag7v/OtoC+F0sz451qE+mjQvLfrdNfzxXztRao8KWFRE2sQPh69Iy3fHw7wD
	 Xj6yeSkhCtg11jrlhhssCXwLTZUAbxLd/cIw1UfQ80KXwz5IsYCNxWwRDZf8AogcFv
	 mT1pLiFOSHXQVjJWm3fbSVKcpr2QBusme8olOGkOmeGMzKG2wsxo1xcjlesEYL5tgM
	 l/oaUJtkzkMR6xnysjL22QpHT5q3Mx4IsXS+o1/owRLqn2PPCO17XohpPNiBWhBfj7
	 uZzaRJgENlt98jXvFUSAx3WOgbSacI7hN+9fyH95HZH3xuPjvFnSw+mhizydK5PGYX
	 twnUXD6I2o7Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9F3822D30;
	Thu,  5 Sep 2024 00:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] ionic: Remove redundant null pointer checks in
 ionic_debugfs_add_qcq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549503406.1206552.10228773047758360950.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:10:34 +0000
References: <20240903143149.2004530-1-lizetao1@huawei.com>
In-Reply-To: <20240903143149.2004530-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Sep 2024 22:31:49 +0800 you wrote:
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant, and using IS_ERR is
> safe enough.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [-next] ionic: Remove redundant null pointer checks in ionic_debugfs_add_qcq()
    https://git.kernel.org/netdev/net-next/c/4614ac219e3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



