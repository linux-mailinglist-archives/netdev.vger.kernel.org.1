Return-Path: <netdev+bounces-216832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F68B35614
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2930F3A532D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844FD223335;
	Tue, 26 Aug 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxTNvc3M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A03D984
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194598; cv=none; b=ayCP6ZtRifmgMcCHCS3gJq82VXSnJMLavUogTzvogpkqsj8ec9JXlZx8oDKUv0ezY/gCzXJPfDLUMnlC1UnUVL1W/F6N8Q9BL8WylV3kvQp8xZ/so+c4AkXtXB51hH6viaRlB4swY0pLqE0a97Sq7BmA546qC6dTvPgO1qKqU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194598; c=relaxed/simple;
	bh=2e63oCSp9jCyFXDXSIVyTIDFCK5Wk+hRQYyzd57ISuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GU8t1NulKYbzlptW+46hWUoY+js9GHmjos00MUmm8E7Taf1NgGEmjhsAwHYwALrxrcQZx/LWGi3Rhv3Eh/mbZ0F6C1jMXgIPw0saKwItntKNK8/N1eWFPn4VMpiTczZ0D5Q9Utrcs1KJXyWNkhPGpWe15JHEhP7ujJ7rLPlIYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxTNvc3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD05CC4CEF1;
	Tue, 26 Aug 2025 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756194597;
	bh=2e63oCSp9jCyFXDXSIVyTIDFCK5Wk+hRQYyzd57ISuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TxTNvc3MnU7OUnCe02BZWB8mN44ib8Cm7q8Qxedt0MPpN/GhIgzJIT4zwDBbCXbHS
	 MzpYgeqGKBGwXWAFK5TENzS+VWhDq26YQDnOrhX+ixywmIbgrnbDtM6dWLN3sA++Sp
	 2O0rXl4AIRhnVEENVv3nr5BdoPGRFqdIVapcVjdff9vE0I1t+injJrH4motXDKIqoN
	 eX2mnHbkm9PD9lOYx2V31L9SkJ+HvefGMHMf1ITI8mKisCXvH+U6BuRjK3VrV/iWUh
	 KbSE/LiBTK9CGS6ktN0sgqS257nCQZclahRA9jMzkvavj/farDHd6dVovWvUcK7xE7
	 74OZb5ISvsCwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A4383BF70;
	Tue, 26 Aug 2025 07:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND v4] ibmvnic: Increase max subcrq indirect
 entries with fallback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175619460575.3698989.15196706539067195769.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 07:50:05 +0000
References: <20250821130215.97960-1-mmc@linux.ibm.com>
In-Reply-To: <20250821130215.97960-1-mmc@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 Aug 2025 06:02:15 -0700 you wrote:
> POWER8 support a maximum of 16 subcrq indirect descriptor entries per
>  H_SEND_SUB_CRQ_INDIRECT call, while POWER9 and newer hypervisors
>  support up to 128 entries. Increasing the max number of indirect
> descriptor entries improves batching efficiency and reduces
> hcall overhead, which enhances throughput under large workload on POWER9+.
> 
> Currently, ibmvnic driver always uses a fixed number of max indirect
> descriptor entries (16). send_subcrq_indirect() treats all hypervisor
> errors the same:
>  - Cleanup and Drop the entire batch of descriptors.
>  - Return an error to the caller.
>  - Rely on TCP/IP retransmissions to recover.
>  - If the hypervisor returns H_PARAMETER (e.g., because 128
>    entries are not supported on POWER8), the driver will continue
>    to drop batches, resulting in unnecessary packet loss.
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND,v4] ibmvnic: Increase max subcrq indirect entries with fallback
    https://git.kernel.org/netdev/net-next/c/3c14917953a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



