Return-Path: <netdev+bounces-179168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58440A7B02F
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327F9188AA88
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184A33997;
	Thu,  3 Apr 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX67A27P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B11C84A4;
	Thu,  3 Apr 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711597; cv=none; b=E/g3N8mTU4oov5RjViTxC65wRBzlVKQnAMAiZ8a437LG8+86DETjbVdZHSdKPrgf4cvmDPZeJTA+lqLyQuR1gDGh1XWJfXjhCAzYejT35AOzmgh+rqCs8Dm227vX//einJ8zSBVYkAw1BbbXuXP/ffv9RFmOqK9OQuK/7FElg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711597; c=relaxed/simple;
	bh=n+xsBSSSDBvOWYIKnxdxot3uNBzuLOElrpN4A/mo16M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qDyN23akk/d9aiGrMsLn5vLJlUgp7S5EWrMHlh9gGQQKikOAuRJBVCfS8KkyD0AJy34Acebhv+ddRRiblVD4JgKBF01POIy0Y6ah5YJ68Ut5AqrjDaASd035Ibsn3ldDS5f3PxEL9wOxCRJgsB3YoHaK+H3+SNi5TbqyNKml6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX67A27P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46303C4AF09;
	Thu,  3 Apr 2025 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743711597;
	bh=n+xsBSSSDBvOWYIKnxdxot3uNBzuLOElrpN4A/mo16M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iX67A27PeVh70gNmLtfNLcJqmgfQfyyy/NAheS6PRrVa1Thb0nNN9mXGg4AFJD/xO
	 9X9jPP+AeZsmEvSm3yABINm/fgDHDmePhuDI24X/3cXqw3Cbw6DH6srTwHettb3OxV
	 aF/JOHQ91htUZQXnE6fEq8GrpHg6HJFbnPFFgvpL4hfCEea8IVY+FYejSjN0vXjNN2
	 exAhOXD15/0fRh19BJM3TyeoJ2zmju2WfCtUttEV1hIdfqXQEtMF3LZytzZWzLkJ8+
	 IlEEy+ai6FPVfG5jAuOLJQ/UbPL8YYDmvD8rbrbwj0PtjY1R5ccRnu+6qMfol5WyzG
	 pVgCFSDwTKRpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710C4380664C;
	Thu,  3 Apr 2025 20:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: increment TX timestamping tskey always for stream
 sockets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174371163427.2672071.7073463393326839454.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 20:20:34 +0000
References: <cf8e3a5bd2f4dbdba54d785d744e2b1970b28301.1743699406.git.pav@iki.fi>
In-Reply-To: <cf8e3a5bd2f4dbdba54d785d744e2b1970b28301.1743699406.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, kerneljasonxing@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Apr 2025 19:57:59 +0300 you wrote:
> Documentation/networking/timestamping.rst implies TX timestamping OPT_ID
> tskey increments for each sendmsg.  In practice: TCP socket increments
> it for all sendmsg, timestamping on or off, but UDP only when
> timestamping is on. The user-visible counter resets when OPT_ID is
> turned on, so difference can be seen only if timestamping is enabled for
> some packets only (eg. via SO_TIMESTAMPING CMSG).
> 
> [...]

Here is the summary with links:
  - Bluetooth: increment TX timestamping tskey always for stream sockets
    https://git.kernel.org/bluetooth/bluetooth-next/c/2c1cf148c1fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



