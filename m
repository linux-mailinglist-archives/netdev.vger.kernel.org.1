Return-Path: <netdev+bounces-198751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 144EEADDA63
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E0B1941F9A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA12FA647;
	Tue, 17 Jun 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDrYi5/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454B2FA62D
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179843; cv=none; b=BYt7dhVhHFEV8hWC+vIfP/yZ+vICSnk80XDczL0a2bmBruB1Zm6kBspkXCRWRjTfzI1PmIYFm/+H92Rqo2HQAPv8/KUL/27Hex4WJDizf6W+YZ9tNzpfiiAbwgb7adANmb8A9DgFprcjILOsfK0UWa9o/jXdD7aqlqsJcaRN46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179843; c=relaxed/simple;
	bh=58sQOwOY7z4b/c5mmqmjDSprgSvMILiemuSdP7HVIdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTaTyHNExoRd7ZPaTD8n4NQpwlpAtAsTm0tIhZI4hQ8kDb+p8VQRgwv45Z0T9QF8n0mF/ipJehrYzWrprHC5BBXd8ua8WNIX17Hx9mTSmtAlGTDG1wsL/0tWRd0eL9mV+XOCLWZ2xrqDRqiA9iVuVmzw2Au8BD4K+hYRtbAZoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDrYi5/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44880C4CEE3;
	Tue, 17 Jun 2025 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750179843;
	bh=58sQOwOY7z4b/c5mmqmjDSprgSvMILiemuSdP7HVIdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDrYi5/KgZl0bpZKpOXPKaCTNTEI0uQHBKIL/hRysNsCDZxcDT7hRChJ6yN8sDwTC
	 1a+sygLfaiiVfNqm6RoaIy6Qm4L1xkwlZ2MV0eDbymhGNmlNI69KcJ5ZOsdzPnsOfu
	 2Ywzh1+4ZgAPm6gFCGMzJzRKQJmtbWV9uMFL9Mff5lJbeybzLgtZXDFMI1HjZzpLmA
	 8THFqcXNqfIVUpAhlmGgHSQFjWmr5isSO86/K1WB6IFU8xoLqG1UdnmXBE2XByQYLY
	 Qkw2fs/Avak14Na8u5R7t/anjvgu1002WwlAAlQhBckvUx+WNTjRFt9F0dWNa+LGXO
	 7xLntmnM+Oh6A==
Date: Tue, 17 Jun 2025 18:03:59 +0100
From: Simon Horman <horms@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH v3] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <20250617170359.GA2545@horms.kernel.org>
References: <aEzIYYxt0is9upYG@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEzIYYxt0is9upYG@v4bel-B760M-AORUS-ELITE-AX>

On Fri, Jun 13, 2025 at 08:54:57PM -0400, Hyunwoo Kim wrote:
> Since taprio’s taprio_dev_notifier() isn’t protected by an
> RCU read-side critical section, a race with advance_sched()
> can lead to a use-after-free.
> 
> Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
> 
> Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMaxSDU based on TC gate durations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v3:
> - Change so that taprio_set_picos_per_byte() is not included in the lock.
> - v2: https://lore.kernel.org/all/aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX/
> 
> Changes in v2:
> - Add the appropriate tags.
> - v1: https://lore.kernel.org/all/aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX/

Thanks for the update.

I agree that this is consistent with the review by Vladimir of v2.

Reviewed-by: Simon Horman <horms@kernel.org>

...

