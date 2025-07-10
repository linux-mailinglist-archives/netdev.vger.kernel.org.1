Return-Path: <netdev+bounces-205725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA07CAFFDE8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F351C86B87
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE328E5E6;
	Thu, 10 Jul 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwdNo92q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6028B7FC
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139184; cv=none; b=hLhNDxSolfvWkU/BsOfyfs5T1vqgfk0syRj9quEkjJlNLXYrsYMz7uZUVwRGgTpz/TPDW8K5qhcBvczyvNGPh7fAqVxmSPzjY6BmvGrLmNc36sYMvRIo7Te2rNZe5Zi4py3WJkw4qNH01BjlFt8G7MO70z2g7Qjol6pmHCDkPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139184; c=relaxed/simple;
	bh=B4ZW8363ul5k4E59oX+h/MKXMeFPzqNRqmtbmF5IPMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QmACaAL32CeztuRgiEzdZy37IZlAAwo0xAnqX2jE1GAHgz5zDougm01xtuvg8WSzTsc1wfZ9mI61DjzK33TdocsxBDzHFoRFSj8K/HEWqG/i1cR5O3XQyRPBLuMAtTxrOFk3srumdvPK0AAtpoY05lFfu2bM2QuuBqJ5z46XfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwdNo92q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348A1C4CEF7;
	Thu, 10 Jul 2025 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752139184;
	bh=B4ZW8363ul5k4E59oX+h/MKXMeFPzqNRqmtbmF5IPMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MwdNo92qID98UwKBcHX7nxMPfEIMXikTVRFiwS1KTD4mKtKJwrHCkGMMQs8qxyJBm
	 MHPrfIDI7jku3+nt5PySzbJ83oPaHZismxtReb1O57EMQSGjt2YxzcweCavDlemD0Q
	 y0NGYGHOnmKu2cC12YQjktTKZ85l196ItENdxRO9+Fh43YBimg7bqsL2VaF9W/sr6p
	 V5S/WXF6e+42FPD8bwBI8ksWrfbD+y5D8Xio/KphYk6PlPCNQMyP6KqwZRC7+RegDP
	 lE4mpIaUb255Y1+ibVRdSTVBgCc3ckGFFs8inXDFrJHo/dIbWrqdMm1Zm8b2p9ggI+
	 p/B9/ievogGUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04B383B262;
	Thu, 10 Jul 2025 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix null-deref in agg_dequeue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175213920654.1416702.17199527229879667524.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 09:20:06 +0000
References: <20250705212143.3982664-1-xmei5@asu.edu>
In-Reply-To: <20250705212143.3982664-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  5 Jul 2025 14:21:43 -0700 you wrote:
> To prevent a potential crash in agg_dequeue (net/sched/sch_qfq.c)
> when cl->qdisc->ops->peek(cl->qdisc) returns NULL, we check the return
> value before using it, similar to the existing approach in sch_hfsc.c.
> 
> To avoid code duplication, the following changes are made:
> 
> 1. Changed qdisc_warn_nonwc(include/net/pkt_sched.h) into a static
> inline function.
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: sch_qfq: Fix null-deref in agg_dequeue
    https://git.kernel.org/netdev/net/c/dd831ac8221e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



