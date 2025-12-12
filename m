Return-Path: <netdev+bounces-244527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5986BCB9646
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 18:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EDA13008310
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC9221F0A;
	Fri, 12 Dec 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5o7ZFXR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF87EEAB
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558326; cv=none; b=VAAkIiVIUwD0oRJN8QwQ7t0cwpMy3R1Fc7IsjmyQIc135DrjmJhl4qt/0O3ph7MkOO54jVMLhEqzSiMdUtZtpt19+MOCdoijrW89ZNzAqUSTdwsurXtK0dg21n1juoQXjtiVEi5lCRtJaQFabA5+9eIoI/qCeS6vH16G8C5NuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558326; c=relaxed/simple;
	bh=WzhcILF8dekewWPm8rvJhuRgx6DUqtD4FLDGO5T/Nck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tap6XlAKp2HCJGCTklbanWf7JjP/ddOlFo3Id9flDlykrNAV7gqRxeuEtE/AlyWpopcuto+sigY6UKWqTtX9ZEgaCBqruh3cP6sNVRuH6IaMhgqKSygVmNF7mcF5pAgJg0iMW6IeuHp6uMu3ji+NtAN64WGGwTxjxCsLk4BtWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5o7ZFXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B728CC4CEF1;
	Fri, 12 Dec 2025 16:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765558326;
	bh=WzhcILF8dekewWPm8rvJhuRgx6DUqtD4FLDGO5T/Nck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5o7ZFXRchuCGAw/v/bfkqG2793AXAWJN/o7u5A5JpvaFC/XruRFZGX07fZYTXRQ7
	 2/pyTt86NAaHHEfKsJYIVqPjCF3CfBQZvRNTgs0f0HqkScaLaC+gCfue4GlNrGl/ra
	 Ck0j1NfoIPdYXl+JeY34mOSnao1Ljzix3pbk8vK0ASWXaWTrq1QGJC/mmbKaE3mDKf
	 wz3GPgtZCgG2SeLPjwXQaJUyl0l6VQaLEYIxzfOgehksQ62R/hJB6y6hJXePliqUXg
	 plym1Au2J/XaBSNvqvEY+JPN7zQEXYlU1AcqRyRmr7Q7fjL17Ko5KwMibfwVK4Jc+c
	 2PFb2YxxNMjJw==
Date: Fri, 12 Dec 2025 16:52:02 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	dharanitharan725@gmail.com
Subject: Re: [PATCH net] team: fix check for port enabled in
 team_queue_override_port_prio_changed()
Message-ID: <aTxIMtJqE1SKhn9-@horms.kernel.org>
References: <20251212102953.167287-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212102953.167287-1-jiri@resnulli.us>

On Fri, Dec 12, 2025 at 11:29:53AM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> There has been a syzkaller bug reported recently with the following
> trace:
> 
> list_del corruption, ffff888058bea080->prev is LIST_POISON2 (dead000000000122)

...

> Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
> Fixes: 6c31ff366c11 ("team: remove synchronize_rcu() called during queue override change")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


