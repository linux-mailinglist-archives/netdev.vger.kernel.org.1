Return-Path: <netdev+bounces-101176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644198FDA2D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29752865A4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E21649D8;
	Wed,  5 Jun 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1HB27Em"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFF160884
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629030; cv=none; b=PBGOAMF8oCydeE7LimgWCrDl33BbV2WcNkwtYAeU/8f4EanoRdjVXB9FsplbfBwRjQz5tCUb3y4ZWkFlTRhatlu8W/QwPYomR8+iKxHpKt/bEk0ai0/gMvK5qbLoRkp6Y3aBORIuj3LOFEM8nFc21kFFn96t7jX+Jkwm9ryNqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629030; c=relaxed/simple;
	bh=mWhc0epeyoc5LMQtY+wA3L56BzVsLvN5v2DSvYz8umw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=umkJV7t2FQXcxbgMEIdP/zJ+9F5pDiq7cs3r9ThDzxQU0+msoRJ6ABBZxl8u2PS1qk7FXPCayoIAE1pzvxBMwh345QnPtelaMxad36hEDxD2wsQb6hCA/OLSRO707aWsTfs9JVi8FiZokLMorMDmkdtsAiHFDFyK+aM9DhfudAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1HB27Em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84AF0C4AF09;
	Wed,  5 Jun 2024 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717629030;
	bh=mWhc0epeyoc5LMQtY+wA3L56BzVsLvN5v2DSvYz8umw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i1HB27EmJc3k1f2PadKjaQFcUYD6eiB/Y3omoep24+mZO82RjeZDyRMTdXFUFmU9n
	 i+OMbg63Sq2PkK+FlpBR/QZ1JS6v/41qiJu8SmcLdZEGTx0sgYHdKnPOJL47HUh9Qt
	 dWPEkWzUVJYc8pLF0oX24p+6pEng7pquKYZvZctVoTveYK/2Ov9ZwgCsbfMvte1NgA
	 OK6rwsZNPWNrbHz07Qk4IcH7NdYKfIrINayON0w//AwrvmMSpdDKsPZBrY3ovDSl+I
	 NWZvWPfBaMi3pCuFpL31CYyv1ScVtqNz0cFpLb18uui1Y+ml96xsI93pNH71ScU+YZ
	 GmgfBm68USmjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7026ED3E997;
	Wed,  5 Jun 2024 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: Fix error message on failed pin verification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171762903045.13835.5481823240293514759.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 23:10:30 +0000
References: <20240604120555.16643-1-karol.kolacinski@intel.com>
In-Reply-To: <20240604120555.16643-1-karol.kolacinski@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Jun 2024 14:05:27 +0200 you wrote:
> On failed verification of PTP clock pin, error message prints channel
> number instead of pin index after "pin", which is incorrect.
> 
> Fix error message by adding channel number to the message and printing
> pin number instead of channel number.
> 
> Fixes: 6092315dfdec ("ptp: introduce programmable pins.")
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] ptp: Fix error message on failed pin verification
    https://git.kernel.org/netdev/net/c/323a359f9b07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



