Return-Path: <netdev+bounces-186770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE868AA1043
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7DB7A37BC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071E21CA1E;
	Tue, 29 Apr 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsORuipn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1801DAC81;
	Tue, 29 Apr 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940027; cv=none; b=qM7TVpTy0UU0FCXik9wvNAwPhVXc/gagw0UJhuUCvdITkkYqzoZuVheSmNGtdAGmYy7ZKecGiKaDC2kM9OeEPH/HrUpc6xgm2+HbMASFsMq/zpq57S5ZcTiChBWkgZMQeqkGGreCaFmjKXvOFRfgtvUiMkBgcAuQ9HQl/TGY8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940027; c=relaxed/simple;
	bh=rxoMXpkpRsXYKrXv1e5QC5IEfYkq+HrBL07RI8vLYXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/cmXPHYCIhIIoLytRyQf5x2KSKJzcVgZ4MIs+wAU4FcU0lMel2oQauzxPbEWjEfI6ylABSo3s6joI09NghTsnbuqYrkcxhYu8RaizzKtPc49iBvUrvsvaw7liT+iYArEcYjp4Nnd2XKVXeGmwO55m2ScAIymyjACmruIyvyQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsORuipn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFC1C4CEE3;
	Tue, 29 Apr 2025 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745940026;
	bh=rxoMXpkpRsXYKrXv1e5QC5IEfYkq+HrBL07RI8vLYXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsORuipn+BexskWvLb3jJGuWS0W5JpuowzIlt3FoR+nvstJhBgHJKNcJyomtzEbTW
	 7kNyFfEr9xWqpQ8cf8/eFG94lyqqtnKlJ64HP9hH3HF4dBrRD+KpFqB/K3y/MXSaO0
	 tf4s611tM+VX4CMePy1Gqr1bI8mN2Xx+lFK9u7YkbFk5ffLjNmWte2BG3zi8hY7pzY
	 ZNWfyhCQCPRsK5jbrm5Jvqvql881wB7NnWvesuhctzUAYaZcTX79HbyDBqE0wxJcpC
	 H+B2lRV+Bj6YsnbTgeco/ptBcYCy6jiIH9Cr+5GLSKwYgebn+HKKcKRE4q0zNTwnom
	 dMNBgQITYL+SA==
Date: Tue, 29 Apr 2025 16:20:21 +0100
From: Simon Horman <horms@kernel.org>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	brian.ruley@gehealthcare.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH] igb: Fix watchdog_task race with shutdown
Message-ID: <20250429152021.GP3339421@horms.kernel.org>
References: <20250428115450.639-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428115450.639-1-ian.ray@gehealthcare.com>

+ Toke

On Mon, Apr 28, 2025 at 02:54:49PM +0300, Ian Ray wrote:
> A rare [1] race condition is observed between the igb_watchdog_task and
> shutdown on a dual-core i.MX6 based system with two I210 controllers.
> 
> Using printk, the igb_watchdog_task is hung in igb_read_phy_reg because
> __igb_shutdown has already called __igb_close.
> 
> Fix this by locking in igb_watchdog_task (in the same way as is done in
> igb_reset_task).
> 
> reboot             kworker
> 
> __igb_shutdown
>   rtnl_lock
>   __igb_close
>   :                igb_watchdog_task
>   :                :
>   :                igb_read_phy_reg (hung)
>   rtnl_unlock
> 
> [1] Note that this is easier to reproduce with 'initcall_debug' logging
> and additional and printk logging in igb_main.
> 
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

Hi Ian,

Thanks for your patch.

While I think that the simplicity of this approach may well be appropriate
as a fix for the problem described I do have a concern.

I am worried that taking RTNL each time the watchdog tasks will create
unnecessary lock contention. That may manifest in weird and wonderful ways
in future.  Maybe this patch doesn't make things materially worse in that
regard.  But it would be nice to have a plan to move away from using RTNL,
as is happening elsewhere.

...


