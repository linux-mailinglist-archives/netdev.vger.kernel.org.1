Return-Path: <netdev+bounces-218878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7DDB3EF14
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0ED1893B41
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4B4502A;
	Mon,  1 Sep 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsL9c8W8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E544409
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756830; cv=none; b=Tm39FjbXdOm3ryslbDtgReEHJxZtrex6daETz/316z1he2SzytsLZMHbukKDATtnDulLoW6Jkvpja1lbNhm8tnuKPNMDm38QIc+AVtDjllpeBlxdfHbJwV8Ed0ety+r1D+S9gOZG4YHpfLQcxB9ZGSaxKZEoa5nSi1EtqbpLanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756830; c=relaxed/simple;
	bh=4vgJKGazyObdpN96dix55Rod45t1RmQxoC9jRWl5Mc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p7i+PlVFW0fJG+uWZZ+tG0QfzhsMieSBv/QJW10fYaEIjvMa6PyioFvfTHIar6Rxg7DZr4H+dP+n4LapCSsuhgC2GnFPjn+KbaPbVQI45bqvUho5muPKkYbbsVuGObboa1cVvKW9P11JT1QSzpfNLetbyuKVUJAX9sWPETidoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsL9c8W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF64C4CEF0;
	Mon,  1 Sep 2025 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756828;
	bh=4vgJKGazyObdpN96dix55Rod45t1RmQxoC9jRWl5Mc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UsL9c8W8da2lhQ89QYIlaNBgI7KJWUE7ePaKFp8Ziem+saXrOgRMSJS7vZ+GK7YK2
	 qHU5O5LI6ZTDmvIAIINfNMEYhPQogS/39EiUJ+iYl/hzvw8bI0TcgUu/NZHa0gTywA
	 15P50qwxEbO2uIq/wo14xbHB4Z+RCAQroPPWo6CC9SpkX5TdIt9WRR5olw3WXMhP7h
	 V5hZkPQ4zBAu3dqpb+NSU6rk891dagIgakqGh3TPTMcDcl33ihbiQu4VMeKLMiOISC
	 mflUYD3eY88suUIrZk9uj+t9tnHU67Lg8xr1OWG6gYHsmXxrrHO8XQ5GTWAv2eAr6N
	 +P/T4TJq9FPpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03C383BF4E;
	Mon,  1 Sep 2025 20:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] bnxt_en: fix incorrect page count in RX aggr ring
 log
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675683450.3868594.10783390976721710804.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:00:34 +0000
References: <20250830062331.783783-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250830062331.783783-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: michael.chan@broadcom.com, jacob.e.keller@intel.com,
 somnath.kotur@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 23:23:27 -0700 you wrote:
> The warning in bnxt_alloc_one_rx_ring_netmem() reports the number
> of pages allocated for the RX aggregation ring. However, it
> mistakenly used bp->rx_ring_size instead of bp->rx_agg_ring_size,
> leading to confusing or misleading log output.
> 
> Use the correct bp->rx_agg_ring_size value to fix this.
> 
> [...]

Here is the summary with links:
  - [v2,net] bnxt_en: fix incorrect page count in RX aggr ring log
    https://git.kernel.org/netdev/net/c/7000f4fa9b24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



