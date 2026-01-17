Return-Path: <netdev+bounces-250719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D638D38FFB
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4EB630031BF
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766A27700D;
	Sat, 17 Jan 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrX72Duu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824C25A62E
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669812; cv=none; b=pIUJKz8Czmqh8jAxFOR1m4iLRGtAoENY+ZL/DojeO8u8q7ny2lPb7FR5CGIW9g/ZYvclD9tNrLLKZW6ou46glSLd5fgqAa7RYp8KYNALfeUOQENxKUH7covJCuMJ/1pLnFgee4Yt5rqX5UcDQQASotKWAJBQ3keV1Zli/6rgC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669812; c=relaxed/simple;
	bh=TIbHV2TgW/OfrR6BMsysytWiYEp1aQCuA3ag7HA19sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAioabpgz0Qn1CgsJyY8Xsq3YdaotmP4VqgGe2lFDLlznn2SM0q57igH5rDwcftkhaWvxRUmHknXeU+1zcF6CjEkEupktCCCIXrQ4O+Hi/KdHbhexQx1EDkQyt76l+7rJCyq/R23aZSu3sHeSh2ikkbwPxebLQb16A3n1jae75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrX72Duu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED76C4CEF7;
	Sat, 17 Jan 2026 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768669811;
	bh=TIbHV2TgW/OfrR6BMsysytWiYEp1aQCuA3ag7HA19sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KrX72DuuAQAJMXUeWAtFpIIdy65kIDKYS4sGWFK593aWs4LUixDtFr97EI2hnxo2F
	 ffIwrk3C3PnDj8OxLjHE7IeQogMJleGIOvxVXFpoqogdH5QQTXe1UbwYT310BI3Aa2
	 Wnc42hdKy/XhkDAqj0e7FHSilDqO2RjyE/IdUAMcfzUF5byTuV6Q6RIxxNyPBws3Z5
	 jggIa28iEWtar+ZRJckq49AsYw1dD27gOzHF0ExTGc/UisEJ79xzBQTKsSzW6NmijE
	 1rhNaZnsJgb/cY4/DbVvkfX6JCg9nNK3x58vWtE3e3lUZpnCtIrPtJruDJwPYIR7iM
	 L4lCcZb/drXTg==
Date: Sat, 17 Jan 2026 09:10:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260117091010.3133de3b@kernel.org>
In-Reply-To: <20260117164255.785751-1-kuba@kernel.org>
References: <20260117164255.785751-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 08:42:55 -0800 Jakub Kicinski wrote:
> Running a memcache-like workload under production(ish) load
> on a 300 thread AMD machine we see ~3% of CPU time spent
> in kmem_cache_free() via tcp_ack(), freeing skbs from rtx queue.
> This workloads pins workers away from softirq CPU so
> the Tx skbs are pretty much always allocated on a different
> CPU than where the ACKs arrive. Try to use the defer skb free
> queue to return the skbs back to where they came from.
> This results in a ~4% performance improvement for the workload.

In the interest of full transparency the performance testing was
done on a 6.13-ish kernel. But I don't see anything that'd make
the situation better upstream..

