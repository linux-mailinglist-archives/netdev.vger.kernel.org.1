Return-Path: <netdev+bounces-109245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5B927902
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CBA28F42F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2AB1B010A;
	Thu,  4 Jul 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il9/toL5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D821A070D;
	Thu,  4 Jul 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104029; cv=none; b=EnwP3qZ8woFRBqQvPD1IAaeE77/3kndWSGlH61xGjwJaiRN4ifNHOSdeUPcar7c22Io7m4jP/PZR9nwVNtsAhsmzetE0FwvB6IcGrGN2x9oIcSrD/Xu86zrgbPr7M26DjnOCWz5wS/NQUKlO9S9Jfc47UgE7FrKX3MACt9g/DC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104029; c=relaxed/simple;
	bh=AtRUNVr/TofFL7xGiLJlbcevdK0eBQ/BfqT4mYmpybQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uFFY/1PicW2g1d5jIFY3MtvE+J+fYrd69fZ4gzovSlH6PlDPiiyl5PTKZDYcHTZAKokZPKRd/fQZMxJiTg0E6X8yAtFx7W9omjo0pyGmKAP9J91/TywTvWQsL3M3C71oaFhhS5aweGdnmgF2WimUEhFbrAErVKsbkV7FFLVToJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il9/toL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80236C4AF0C;
	Thu,  4 Jul 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104029;
	bh=AtRUNVr/TofFL7xGiLJlbcevdK0eBQ/BfqT4mYmpybQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Il9/toL5+dKBJwF1+gdGzHaKEcntCACtLzP4tLYl/aEG8kjrE3ZeeY5Cfm6OSb9zq
	 4PfvznLuZBlFirIJ7y/JzfzK/d4HzEseFB9hmt0pZsco7ci0QzsOII6QnDiw/xSvqp
	 ZFFIei49GPHLfbxsV8caV0/o5+Pb15lIqVbSRvmKYVWIsHWqFAYDEjjAPP9eTLq1Dc
	 eX/UsImFrMmS6l2Xxwz/T7REHBwvFJ7FaZiZJJtMC6wSl2cQD+5q3tzRX+5xqjkA7Z
	 3L5iYZ5jql91R9rpu9FamPJeMF+YSu0iqY+/xd2kBJpZvgrQxY3M0IIIrq2QXV7/CV
	 KfVZEnvaUQ7Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CE47C43446;
	Thu,  4 Jul 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mlxsw: core_linecards: Fix double memory deallocation
 in case of invalid INI file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172010402944.7153.11697585580866205532.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 14:40:29 +0000
References: <20240703203251.8871-1-amishin@t-argos.ru>
In-Reply-To: <20240703203251.8871-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: jiri@resnulli.us, idosch@nvidia.com, petrm@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jul 2024 23:32:51 +0300 you wrote:
> In case of invalid INI file mlxsw_linecard_types_init() deallocates memory
> but doesn't reset pointer to NULL and returns 0. In case of any error
> occurred after mlxsw_linecard_types_init() call, mlxsw_linecards_init()
> calls mlxsw_linecard_types_fini() which performs memory deallocation again.
> 
> Add pointer reset to NULL.
> 
> [...]

Here is the summary with links:
  - [net,v2] mlxsw: core_linecards: Fix double memory deallocation in case of invalid INI file
    https://git.kernel.org/netdev/net/c/8ce34dccbe8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



