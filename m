Return-Path: <netdev+bounces-206002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ED5B010AF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666D53B48DD
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FED2A1C9;
	Fri, 11 Jul 2025 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItWC3J5g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C1A55
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196789; cv=none; b=TQVTdmNdmESc/CAZIdEUbJcskc+gJjD8XXInWCGZWiIGPgSDU5l5uYIn/JNcRYLUvJPf+F9aBNlRIZLuDP8YNvkOXnRX30VaAOLGorxysmVIesT/8QcH+xtl+eEoW+9Hp363rYS4nR86nHkuNkjqvyE7DHC3gfb5EIVK3uFjJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196789; c=relaxed/simple;
	bh=F1l+R8vdiQ4akv0gdcMKMIvOZvPyKk2aemc4C/pgsjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6zjN3V5tq4B6A6wcBLnVL43VxXscsg1kaQtWYmfFwfEscWZcV14E8OuNmyhq5sD1NxOL7SiTfbYK6mxxkUftPQdRIqcZDk7iKH8pQJg5X7YJdVwrng3/FgeWNgeOxg8zeAgn33QvbtwjPADFyqyP3Zva/5JUUO1AjzuIpjeT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItWC3J5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D0EC4CEF4;
	Fri, 11 Jul 2025 01:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196789;
	bh=F1l+R8vdiQ4akv0gdcMKMIvOZvPyKk2aemc4C/pgsjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ItWC3J5gjyqDt8e4Xb1dvXJihENPQWjRxx258FYvhR6+//FpWnQZa7eBWYXASsYIy
	 U1f9zNb+efoNycv/YpI8PKQAmq3tS+l7ltBatMEKfQZRSGOwdsPbLIT+EK7EQWxE2o
	 pwVQF7FTpKUjSwtL40UgcerVEDDDOGqNLEPft+/X4cF+TM9JCFr63s8qtwIInu5u4/
	 pWgkZF0NlVQau66H5lZAsDN/hTwhw9w2uRpssZoe+WH1OE2XdgO9C1jkDSzHMYnsGS
	 HDpRtcr52Fc+Zm5WvqZlK0DzI8L2YyF09nkkC+QmGNsGNIIJ7MPqsK2HF048aVz2+6
	 H1JjzjjlcBiQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE123383B266;
	Fri, 11 Jul 2025 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with
 dynamic sizeof
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219681151.1724831.1331022153897221685.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:20:11 +0000
References: <20250709153332.73892-1-mmc@linux.ibm.com>
In-Reply-To: <20250709153332.73892-1-mmc@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, nnac123@linux.ibm.com,
 horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 08:33:32 -0700 you wrote:
> The previous hardcoded definitions of NUM_RX_STATS and
> NUM_TX_STATS were not updated when new fields were added
> to the ibmvnic_{rx,tx}_queue_stats structures. Specifically,
> commit 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx
> batched") added a fourth TX stat, but NUM_TX_STATS remained 3,
> leading to a mismatch.
> 
> [...]

Here is the summary with links:
  - [net] ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof
    https://git.kernel.org/netdev/net/c/01b8114b432d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



