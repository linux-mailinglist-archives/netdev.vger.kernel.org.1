Return-Path: <netdev+bounces-231927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1FFBFEBD9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 02:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0646D4E262A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93A19258E;
	Thu, 23 Oct 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpsaGEj6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7A1547E7;
	Thu, 23 Oct 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179211; cv=none; b=MEClgSzJ5XaCfqD/gzFteEeJMIYyfUMXXNMXS4xRbpFkOLEMWpM1nYwKx5JZyx506mmaf6+3Za9RX15pjAljup5AykFwmEDxhof7le8nOMDOghkh9IM/TRDSbFlGHuUP9kplpBd0B6cwjkT6zjm73yGf2O3Wp7QEtNKpjXf8wZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179211; c=relaxed/simple;
	bh=tVvYZsxkCrxwXNpjOJQVKaTFbg1BT7j7hRKyeC8BWm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcIBUoTGX8Dw0wBGuHdncH0RIWxGA/SsdvEgg2Jtm/tU4g4wZiWNRZ+MJxRQiNXwVkTJUI0jv+bKT71xfO8Z23PHkbHmzp4pnj45RO6uFHomovDqdgULkUfYCyYS37LyFd09VFuhmaKvdfW4L19j6S6qgp1V/2LnTvkiSpkjU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpsaGEj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDCEC4CEE7;
	Thu, 23 Oct 2025 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761179211;
	bh=tVvYZsxkCrxwXNpjOJQVKaTFbg1BT7j7hRKyeC8BWm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UpsaGEj6bYZcuHN1P5Q+DT0iYce5v/Jbt3KroSe4b5KzlH+j2yGVq7joczftxIDtw
	 N/ASxnfQD+UiilPFo9q9QuK3P/cuFw987ZeMOvzanYK7870BhETUpGF1kGqyFoVREO
	 +IXV2/OCGyw1OH0fpSBzO2Yxjj5s+Q7gRoMkNCk6ZJjDvElWssND0qe1mf4ILSPOu4
	 tU6weKjaiMeKzOYE4eJ+4ZKUyuA7ipZuQMIlt/sNGR6/9Pc7eoqLkOPoIqvzCsLjFL
	 ybSbg9xqzYTZ9i0sdWZdjI/HlnT0qLzUixZeUXvhz3/w7EUJKXb1cT6+GSIsNlgPa3
	 aDj7efZQeBS8w==
Date: Wed, 22 Oct 2025 17:26:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: <aleksander.lobakin@intel.com>, <andrew+netdev@lunn.ch>,
 <anthony.l.nguyen@intel.com>, <corbet@lwn.net>, <davem@davemloft.net>,
 <edumazet@google.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
 <jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next v2 13/14] ixgbe: preserve RSS indirection table
 across admin down/up
Message-ID: <20251022172649.0faa0548@kernel.org>
In-Reply-To: <20251022034051.28052-2-enjuk@amazon.com>
References: <20251021161006.47e42133@kernel.org>
	<20251022034051.28052-2-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:40:45 +0900 Kohei Enju wrote:
> On Tue, 21 Oct 2025 16:10:06 -0700, Jakub Kicinski wrote:
> >On Tue, 21 Oct 2025 12:59:34 +0900 Kohei Enju wrote:  
> >> For example, consider a scenario where the queue count is 8 with user
> >> configuration containing values from 0 to 7. When queue count changes
> >> from 8 to 4 and we skip the reinitialization in this scenario, entries
> >> pointing to queues 4-7 become invalid. The same issue applies when the
> >> RETA table size changes.  
> >
> >Core should reject this. See ethtool_check_max_channel()  
> 
> Indeed, you're right that the situation above will be rejected. I missed
> it.
> 
> BTW, I think reinitializing the RETA table when queue count changes or
> RETA table size changes is reasonable for predictability and safety.
> Does this approach make sense to you?

Yes, if !netif_is_rxfh_configured() re-initializing is expected.

> >> Furthermore, IIUC, adding netif_is_rxfh_configured() to the current
> >> condition wouldn't provide additional benefit. When parameters remain
> >> unchanged, regardless of netif_is_rxfh_configured(), we already preserve
> >> the RETA entries which might be user-configured or default values,   
> >
> >User may decide to "isolate" (take out of RSS) a lower queue,
> >to configure it for AF_XDP or other form of zero-copy. Install
> >explicit rules to direct traffic to that queue. If you reset
> >the RSS table random traffic will get stranded in the ZC queue
> >(== dropped).
> 
> You're correct about the ZC queue scenario. The original implementation
> (before this patch) would indeed cause this problem by unconditionally
> reinitializing.
> 
> I believe this patch addresses that issue - it preserves the user
> configuration since neither queue count nor RETA table size changes in
> that case. If I'm misunderstanding your scenario, please let me know.
> 
> I could update the logic to explicitly check netif_is_rxfh_configured()
> as in [1], though the actual behavior would be the same as [2] since
> the default RETA table is a deterministic function of (rss_indices,
> reta_entries):
> 
> [1] Check user configuration explicitly:
>     if (!netif_is_rxfh_configured(adapter->netdev) ||
>         adapter->last_rss_indices != rss_i ||
>         adapter->last_reta_entries != reta_entries) {
>         // reinitialize
>     }
> 
> [2] Current patch:
>     if (adapter->last_rss_indices != rss_i ||
>         adapter->last_reta_entries != reta_entries) {
>         // reinitialize
>     }
> 
> Do you have any preference between these approaches, or would you
> recommend a different solution?

I was expecting something like:

if (netif_is_rxfh_configured(adapter->netdev)) {
	if (!check_that_rss_is_okay()) {
		/* This should never happen, barring FW errors etc */
		warn("user configuration lost due to XYZ");
		reinit();
	}
} else if (...rss_ind != rss_id ||
           ...reta_entries != reta_entries) {
	reinit();
}

