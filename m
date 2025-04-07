Return-Path: <netdev+bounces-179579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC40DA7DB64
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49309169DA2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2BF2356CD;
	Mon,  7 Apr 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAp2RN5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD522DF90
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744022634; cv=none; b=jeT1HNrSUfr8kQIBP10yNjuWjC00SJkB/QNPvkk3yvpafMk0SW/xAw+R9+M9/jbk27m2OVgVsTg6N2RHonw7qUH02nIUVz7iUgPVfqAMnFLuKNnHwrvlAGKgMEfzlFHN+vK0xSA0Jpigo5emShqSQP12zMdjNc8DopvK22OyU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744022634; c=relaxed/simple;
	bh=4x4zQCYCpZqtqGM5wUFA0JzjY0ON3VVjUMPDjFFK3xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQG8ym0eUtR1cUWzYfSawJd1i4ntmHUGqTcE0G/+z9k4vDur0CqEDaCOgmSID0bZF7ENj6kPnh7FONYVSCi3tbDed9Gh1+sv4uTuTgA5vr/qTxcXx8ERO5KlmInnHDE1sVeKVq6G/UneIc5If1WUvlTjWexEWCAuJNjkdxq3yH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAp2RN5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1109C4CEE7;
	Mon,  7 Apr 2025 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744022633;
	bh=4x4zQCYCpZqtqGM5wUFA0JzjY0ON3VVjUMPDjFFK3xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAp2RN5LxCk229NUfGCTDbsIprhfErxieIb563jMUXhVDkCpJb7qwHQWwyIyoPrhH
	 9HDpjlFyxRyTIRwMezGyTUKJTgiTOEJsAsHH60dsCzMlP7hmDdJv6mAgoSOBj4I5Bu
	 m+EgAoerG8/qR+PrPyrc4Q7DHfA7KmtLpaku+fai601c7ccTpNWjMb3swvxOYvnOt5
	 ytZuiTMsrSJN2Fd4WPSs5WcVPuHSoHEHxd05if85+WiLJUaPdAU/EwrQJLYBB2wLqD
	 V4fLMcW70OuM2TzeH7XNAQH8yCQhoxvWt/LptLhTjq0rhF1SFDZa0PWfJyT2h4cmc4
	 viQePP9bewgSw==
Date: Mon, 7 Apr 2025 11:43:50 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] idpf: fix potential memory leak on kcalloc()
 failure
Message-ID: <20250407104350.GA395307@horms.kernel.org>
References: <20250404105421.1257835-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404105421.1257835-1-michal.swiatkowski@linux.intel.com>

On Fri, Apr 04, 2025 at 12:54:21PM +0200, Michal Swiatkowski wrote:
> In case of failing on rss_data->rss_key allocation the function is
> freeing vport without freeing earlier allocated q_vector_idxs. Fix it.
> 
> Move from freeing in error branch to goto scheme.
> 
> Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")

Hi Michal,

WRT leaking q_vector_indxs, that allocation is not present at
the commit cited above, so I think the correct Fixes tag for
that problem is the following, where that allocation was added:

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")

I do note that adapter->vport_config[idx] may be allocated but
not freed on error in idpf_vport_alloc(). But I assume that this
is not a leak as it will eventually be cleaned up by idpf_remove().

So the Fixes tag not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Suggested-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

...

