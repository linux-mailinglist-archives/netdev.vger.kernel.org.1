Return-Path: <netdev+bounces-205742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CFFAFFF0D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6DC3A77CE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C427242902;
	Thu, 10 Jul 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4o+WNhj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47887215F4B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142602; cv=none; b=EJ48SS8wFG4OzxLRl2tuPwwsM0D/KoSyW7b8znb9UMS9ZEtJWmGfvX/BnnWkckp5g1OJWQoGK4gb/GmfPfeze3vt8KFw/p4dlz3s6a/SOH0okzP5YlymhdrIVonYCWFS/hA8SA6D2NkeqZaAaq7+RETPI/U/TcTA+g8zDyfeqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142602; c=relaxed/simple;
	bh=L8lkzM2t1OZG1VsTPWmuFHlM8M7SwQHok62S3yIxEFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7ViyOPwXbYJsHmJiaRKpMFrNTBgzVZylNzuMJt1ZClbQw3xmtO/lJ5JGCz5ygss7GolRwJ0SB1hXwz9tr4DpSkNwNZTHOn52EXs2RiNnJdS0R+T4JCP99w6OYB/T1OTJjIu7LoSnJ0phyKkTBTPUO13OMlN8KoX/vd/qapB8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4o+WNhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519D9C4CEE3;
	Thu, 10 Jul 2025 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752142601;
	bh=L8lkzM2t1OZG1VsTPWmuFHlM8M7SwQHok62S3yIxEFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4o+WNhjPVKjrJvgLVcIOzdEOkyPfoPzuYNvMf4/cvhOIvPv1cPFQ7YnaKQETQBfu
	 709w/evFwP9U/dZJteJam6uVOukHEyTudpmAKEPvd/NyVu3P5RuGz7HqtYzMesxzMe
	 ygFLx0BtC6OWFxRJe4ObOYCjguRRLDbhXQbIFzsN/n1aQWXvtP8yrEr/q7J40xyykH
	 vy4GqHM3GWD0R1Fv4oWp0T2RV/zVvcoyjrJdRGGkBU/NBY5Fp/0ZfOkv3/Qe7nfSoZ
	 G63dajJ+wzL8f4KBweiEJyOVI10bjTGZ6249BakPNSCWy6aoC3eF7uKIiKe0mieM9r
	 KRPfehqxbde9A==
Date: Thu, 10 Jul 2025 11:16:38 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, bjking1@linux.ibm.com,
	haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com
Subject: Re: [PATCH v3 net-next 0/2] ibmvnic: Fix/Improve queue stats
Message-ID: <20250710101638.GO721198@horms.kernel.org>
References: <20250709184008.8473-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709184008.8473-1-mmc@linux.ibm.com>

On Wed, Jul 09, 2025 at 11:40:06AM -0700, Mingming Cao wrote:
> This patch series introduces two updates to the ibmvnic driver, 
> focusing on improving the accuracy and safety of queue-level statistics.
> 
> Patch 1: Convert per-queue RX/TX stats to atomic64_t to ensure thread-safe 
> updates in concurrent environments. This establishes a safe and consistent 
> foundation for subsequent statistics-related fixes. 
> 
> Patch 2: Fix inaccurate sar statistics by implementing ndo_get_stats64() and 
> removing the outdated manual updates to netdev->stats.
> 
> This series is intended for `net-next` and assumes the bug fix for hardcoded 
> `NUM_RX_STATS` and `NUM_TX_STATS` has already been included in the `net` tree.
> 
> --------------------------------------
> 
> Changes since v2:
> link to v2: https://www.spinics.net/lists/netdev/msg1104665.html
> 
> - Dropped Patch 2 from v2, which fixed the hardcoded `NUM_RX_STATS` and `NUM_TX_STATS`,
>  as suggested by Simon. https://www.spinics.net/lists/netdev/msg1106669.html
> - Updated Patch 1 in v2 to rebase on top of the above fix in `net`.
> – Patch 3 in v2 (now patch 2) unchanged.
> - Dropped Patch 4 from v2, which raised the default number of indirect sub-CRQ entries 
> and introduced a module parameter for backward compatibility. Based on review feedback, 
> plan to explore alternative ways to handle older systems without adding a module parameter.
> 

Thanks, overall this looks good to me.

I think you need to repost this patchset once [1] is present in net-next.

[1] [PATCH net] ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof
    https://lore.kernel.org/all/20250709153332.73892-1-mmc@linux.ibm.com/

-- 
pw-bot: deferred

