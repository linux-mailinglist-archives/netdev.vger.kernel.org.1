Return-Path: <netdev+bounces-187258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE38AA5FA8
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D92176145
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710D1DEFDD;
	Thu,  1 May 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdfrmvGn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27621DE8A3
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108593; cv=none; b=o4WNLGu8iHpCHZEfcKsGl0GDURPxBZjsk1I19FjRT3ytDs6jRGe45mpVpmw6qLcWyPaxA+oldNdkiKBqgvK0Lu7536hUIN23Pp+Hvy7p8PSr2rUXrThktTbpgYyYy+5/AKzM7ztH/g2cfQ1qD1HbiM3YJ3htBXxIi9F82i4dDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108593; c=relaxed/simple;
	bh=ZgwooxW/BmQqhSDfPs6LmcPj7oDL4mrMlugQS2o7t0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cb5Q9Yky//QNeUOuHKwtiCyHKZNlLKq/IE1iDxhhX4zNKO/sKf6uUTMj2AgHcQyYtT6032j2jl8XnQMj6006lfQ82CRNqbt0hYDVAADellDf/YTutk75A7OdHZihT2kZ/YSTHBY3jubj3IWtKI3NY35CL5lpc/I5pWnw9RU5W8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdfrmvGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203FEC4CEE3;
	Thu,  1 May 2025 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746108593;
	bh=ZgwooxW/BmQqhSDfPs6LmcPj7oDL4mrMlugQS2o7t0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MdfrmvGnXWOFGRFHyKesNyeYdFDQvVVqiNTRmLyAzEDyIZMgEUYCX5VL6W13jbQUR
	 JaSoJ1dXNbNaFZD1lutX3stB7BDcGdFp5jpjx/kvAvPnBVbRU98PLdcGH9yH7O8cnZ
	 qCIVNjWT236kP7iJ5KPED4MIrl2hnb1bd8hARoCTJ95PFE0WG5Y3a2VodMfwfrSoJl
	 NTNf3kdxO4Fml1ufGtBvjvSjC30JRQbxcah9XJlIlC1QOfKo7skaxdX0XJ1vU7hI5x
	 dQEyCKEJFHa0ubrl8W8PkBkFz2iZ2F9hr1Na+Tj3wU3D0Qrmjeyo0o8mQ+0b/FpgO5
	 dLmQWTZme/Fsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D063822D59;
	Thu,  1 May 2025 14:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: fix module unload sequence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174610863199.2990404.17226075375295460943.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 14:10:31 +0000
References: <20250430170343.759126-1-vadfed@meta.com>
In-Reply-To: <20250430170343.759126-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, kuba@kernel.org, richardcochran@gmail.com,
 ap420073@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 10:03:43 -0700 you wrote:
> Recent updates to the PTP part of bnxt changed the way PTP FIFO is
> cleared, skbs waiting for TX timestamps are now cleared during
> ndo_close() call. To do clearing procedure, the ptp structure must
> exist and point to a valid address. Module destroy sequence had ptp
> clear code running before netdev close causing invalid memory access and
> kernel crash. Change the sequence to destroy ptp structure after device
> close.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: fix module unload sequence
    https://git.kernel.org/netdev/net/c/927069d5c40c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



