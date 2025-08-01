Return-Path: <netdev+bounces-211324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D95B17FFD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00A01C221DE
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089A233155;
	Fri,  1 Aug 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHqz6Ciw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23220E030;
	Fri,  1 Aug 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043119; cv=none; b=EV/Tb4IJEGcsaVBLMq0QMor3CH898RZHzAtAPdT6TK2Q0HGyIYZ6TmkU+2fzTD9jmFq52xyLw0TG5A1/U6aXR0eNmJZ/XnMbPkKuE0U9HIJWXCAPubTTi4UCl46tjtvn/2aCH2JskWQPU2+nI1X8NfEUiirx4Y/xFbAonXUXHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043119; c=relaxed/simple;
	bh=0VBYeZ2CAzWVabsnByrpxPKftpmxnAoWSIEm7FC9Wvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyKWnK05nzIl7DyLTVcaEM6u3E0Ke1L4TLmsUqFRk2oVNZDrCkSlTFBKw67Fl1fNnSu2GSsPAhQ8LACW6sBYg44jPbUNuaBn6d279RhOwsIEVFX0kNhrPRwnRhENMMwEtT77jJ9aSiGXVsmGPWe8JK3/4jCIAxFDx40tnXN1wzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHqz6Ciw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBE8C4CEE7;
	Fri,  1 Aug 2025 10:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754043119;
	bh=0VBYeZ2CAzWVabsnByrpxPKftpmxnAoWSIEm7FC9Wvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHqz6CiwGShQR37Lq7SGYpJ8i0X4DO7JTJF1nbiMYkq7zF8Ro4fnxARrjxu+5TU6E
	 Ob46yyxYA/nEAUR+uR918PqvC+sux2+YFvii+M2DxkqPu0RktBSNA1iRzyTO2v4bdE
	 +aNAKF+LtgNHbpdRMQKqq8SwR1G4EPYbegkA5QQ93r235iIrzlL5fMaj6V43P1uCHR
	 Fsc6yVf0RqXAYQWw8v5zKmNsUlSGuptnVQ9Lqg8xzdrGTGp6T6COy2yRzU6DIogZDw
	 XIGv4hqPg2JB7FapRrzqDCLO7HcLCWaOSPV3aEuY0XR4uoSXBG22PPrsyRfGuTIQu6
	 qR5IyAw966W6Q==
Date: Fri, 1 Aug 2025 11:11:54 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: hibmcge: fix the division by zero issue
Message-ID: <20250801101154.GK8494@horms.kernel.org>
References: <20250731134749.4090041-1-shaojijie@huawei.com>
 <20250731134749.4090041-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731134749.4090041-3-shaojijie@huawei.com>

On Thu, Jul 31, 2025 at 09:47:48PM +0800, Jijie Shao wrote:
> When the network port is down, the queue is released, and ring->len is 0.
> In debugfs, hbg_get_queue_used_num() will be called,
> which may lead to a division by zero issue.
> 
> This patch adds a check, if ring->len is 0,
> hbg_get_queue_used_num() directly returns 0.
> 
> Fixes: 40735e7543f9 ("net: hibmcge: Implement .ndo_start_xmit function")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Thanks,

Thinking aloud:

I see that hbg_get_queue_used_num() can be called for both RX and TX
rings via the debugfs code hbg_dbg_ring(). And that hbg_net_stop()
clears the RX and TX ring configuration using hbg_txrx_uninit().

So I agree that when the port is down ring-len will be 0.

Reviewed-by: Simon Horman <horms@kernel.org>

