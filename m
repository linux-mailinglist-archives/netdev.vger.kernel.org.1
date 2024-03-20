Return-Path: <netdev+bounces-80718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FD880A0F
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FDFB21EAA
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780B10A26;
	Wed, 20 Mar 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx6TpfvY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB0101F7
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904229; cv=none; b=kaUy/wBhaxJFHQeRHvH+MlIhbhnxgScFF/HmYOe/qfNcdSdDY3/SoGRysMaBhORGs/PVnk/xJnRGQazyHj+f1spLdmSi1zffQDC2jo+JhcsAcP5RkNDWQzs03lsY0cQ7Oeqiezcc570/MY9Fo4kHAhT2zPGrDOgEdRlHXHXbERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904229; c=relaxed/simple;
	bh=nRG9EnCr3NHs98lt2zge0Os7lGUe8oGAjSO9qvmedZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BGyL/DktBEYsmKtkO6bCsS98bG+Mw7pc8DRXyHlbIZzP/koXBHeCbSWeaSwO/de6GhTRQ7dV2pp41e2u03rtR798IHPgu5wIBsQKgid8XrneCLfiB7XT7DpNb8r4WCMi0HnF7D6v1KnT2isXpXnu8WBjXnxbUCgLkZ0IJ7BvYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx6TpfvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B271CC433F1;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710904228;
	bh=nRG9EnCr3NHs98lt2zge0Os7lGUe8oGAjSO9qvmedZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qx6TpfvY9omgnlNykQj/XzCwv3NJfLUJ75DGyCQgqRljBd0W7aGzIr9uBby8E918s
	 2V8Eo9CfL7Ls5b/skc2WAkKZumlRv2wSuoJHvUMcA7ogDhyDPREC6u4grtLeykkK9c
	 hNiZozqsrb1M95ALIeGa0jioe41nn77jnXL6+7kwEJUEs6YSlzrT/K0PNov3q1vOWT
	 V0iuGGvuUaOAWm/kzwOOUpysOoHhS7hyxikKsHmU2SsM1hkcJMnAFhxD+WQleJwaiR
	 NOH1rtwpYAw/KT1Acf9wiP4tYHsgtXA+dfvDOXjyKyAWHuVT48uFfF2V5WXGAPNfJu
	 VXEBn4DQY9C8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4DA6D982E3;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net: esp: fix bad handling of pages from page_pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171090422867.19504.7943706734766336293.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 03:10:28 +0000
References: <20240319110151.409825-2-steffen.klassert@secunet.com>
In-Reply-To: <20240319110151.409825-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 19 Mar 2024 12:01:50 +0100 you wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> When the skb is reorganized during esp_output (!esp->inline), the pages
> coming from the original skb fragments are supposed to be released back
> to the system through put_page. But if the skb fragment pages are
> originating from a page_pool, calling put_page on them will trigger a
> page_pool leak which will eventually result in a crash.
> 
> [...]

Here is the summary with links:
  - [1/2] net: esp: fix bad handling of pages from page_pool
    https://git.kernel.org/netdev/net/c/c3198822c6cb
  - [2/2] xfrm: Allow UDP encapsulation only in offload modes
    https://git.kernel.org/netdev/net/c/773bb766ca4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



