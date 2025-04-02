Return-Path: <netdev+bounces-178854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851FFA7937A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F16165B83
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6015A86B;
	Wed,  2 Apr 2025 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/nnXIPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22926AFB
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612719; cv=none; b=etb101WuIyvhzBR9grDmqcwgT6txTz7l3Q/7B/OdCl9lWrYwh4JzT0OaiZ55BL1AFK1JlTNhVEIfvWUZJNTLGSkVbdGRd5u8oSXiBBbrpmaGETwx7nou3y1l7laTHeSL6wvO4KqCivvivM5+3BvjdL2ayj33asAhBUIqqadQjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612719; c=relaxed/simple;
	bh=LJo7WwFyzDLvp0Kn687ErqQCSKtPyCI0rckGbbD8zyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ig9tLcR2rsparZ6YF5F8SEvnLepFrI04VmGHlKiLUkcFBQevLQjJLLkR97HdpKb1oWMiQHko4C6WmdIA9x9Fm0MtdiuBFJ+rQBSMWi9oMxg09pCMtlgdzJmJVP+MeCAwtV+qEOFfIOI1V3jSLTgckpgAh6aZ+gT5NvK+2aDMUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/nnXIPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250F9C4CEDD;
	Wed,  2 Apr 2025 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743612718;
	bh=LJo7WwFyzDLvp0Kn687ErqQCSKtPyCI0rckGbbD8zyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/nnXIPXOjmry5SX1HAFpqCgwK8fUCGi5nSqzH5nK9RraRKmRkA5IjsFggYrfWDxg
	 yBovlGGD1y3oqxV22Ah/ukBWMBk/fCBvcFj+zqWhf7DGZOHb8A4k9rNAyqNTAF5LML
	 zGQ7cdzUi+TiKDg6onk3Fwaqrva77McTbBDlZ0xxMX0G3ITCtpoywsUZxAQuGVeZEQ
	 dXxglrhC/sVIYEwBZ1tWOaTYMtKaljnghz4PZDBYR3xUxljBWF7mW8j376TipsZqFr
	 Q7FbycL39Pd9mfJ0oKxTK6GysISFJnofJQPLqHKHY+a7QGIbU+ZeeCm0ESITgyvdQf
	 g6kSRPJ9oNs/Q==
Date: Wed, 2 Apr 2025 09:51:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, netdev@vger.kernel.org, romieu@fr.zoreil.com,
 kuniyu@amazon.com
Subject: Re: [PATCH net] eth: bnxt: fix deadlock in the mgmt_ops
Message-ID: <20250402095157.4d7c53ee@kernel.org>
In-Reply-To: <20250402133123.840173-1-ap420073@gmail.com>
References: <20250402133123.840173-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Apr 2025 13:31:23 +0000 Taehee Yoo wrote:
> When queue is being reset, callbacks of mgmt_ops are called by
> netdev_nl_bind_rx_doit().
> The netdev_nl_bind_rx_doit() first acquires netdev_lock() and then calls
> callbacks.
> So, mgmt_ops callbacks should not acquire netdev_lock() internaly.
> 
> The bnxt_queue_{start | stop}() calls napi_{enable | disable}() but they
> internally acquire netdev_lock().
> So, deadlock occurs.
> 
> To avoid deadlock, napi_{enable | disable}_locked() should be used
> instead.
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")

Too far back, v6.14 doesn't need this fix. I think the Fixes tags
should be:

Fixes: cae03e5bdd9e ("net: hold netdev instance lock during queue operations")

No need to repost, I'll change when applying. Unless I'm wrong.

