Return-Path: <netdev+bounces-179317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF17A7BFA7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CE2176064
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E41F3FE3;
	Fri,  4 Apr 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiiCKR2A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77041F30DD
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777598; cv=none; b=jYL/BBlwokPkxZ+vojqrtCym/geTCG2nGir2M33Wa+x1i49CkLwn9yC8gf20Q2SGfqHRQkLoqSsgOnfPL9VQ+FMZAtDYXfx73ji22wuqBSGO8EjFfUpKRTmrGqYb0MrbYNbeT6n0gjzcBsHrLHUxj3V6g5wELtsE2eBLtEGrM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777598; c=relaxed/simple;
	bh=UTmg5mV7vCXLiT3zkNeLxITmublMJSUfJwa8s/v4TQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i4GPMqGYtna8k8v/w6MJywBoZ+qVJWy4piwITwcPlmi4Qy06mNVa3aWx+TtyLiRVZjek5AtKVdSnA1CWzvrNQXK/5uYOD3DhlMYwZWquv3pRI3Yi/OGKYyyKtJOnFvWlvx0J7KTtwU3iQGbk17KobSmaeLok42BRl3juCvwv4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiiCKR2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E645C4CEE8;
	Fri,  4 Apr 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743777597;
	bh=UTmg5mV7vCXLiT3zkNeLxITmublMJSUfJwa8s/v4TQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iiiCKR2ASSO3sjosXlaD7+xVw+ItYEc1EoeIZFhVD6qbbeETYMqzFTBvPzdzOmPvy
	 tdigIN4IFRGtBWu5HWAlY+TxLFUWhPqniMWj0dpajywUyZ3NOYBIJ4f0GWpW9mB95f
	 DMqrLBmBmOZP+6uOZZSeGiZRBZ9IT+nr9H/jO5dGLDzHRtbJLQ15ZSgvDk8TZh2SLJ
	 N0J2jjjjbO7ZoBi5k6GJr2HXoD4FA6Fw6fyhL9EOa6U40dWApa/extBSG2CeiyFFZH
	 xDLxL3/B81lFYDhF8TB0iw4culcUSLprkkk/ACAh26/fNfRoLQKYR2aoz0cd0fPl0i
	 VP0p5OeLJLIyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7A73822D28;
	Fri,  4 Apr 2025 14:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ibmveth: make veth_pool_store stop hanging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377763424.3283451.909184370963487754.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 14:40:34 +0000
References: <20250402154403.386744-1-davemarq@linux.ibm.com>
In-Reply-To: <20250402154403.386744-1-davemarq@linux.ibm.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nnac123@linux.ibm.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 10:44:03 -0500 you wrote:
> v2:
> - Created a single error handling unlock and exit in veth_pool_store
> - Greatly expanded commit message with previous explanatory-only text
> 
> Summary: Use rtnl_mutex to synchronize veth_pool_store with itself,
> ibmveth_close and ibmveth_open, preventing multiple calls in a row to
> napi_disable.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ibmveth: make veth_pool_store stop hanging
    https://git.kernel.org/netdev/net/c/053f3ff67d7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



