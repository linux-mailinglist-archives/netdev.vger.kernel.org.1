Return-Path: <netdev+bounces-190496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C893AB70C6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAB81666B1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130651DF75D;
	Wed, 14 May 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnMcVn45"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B918787A;
	Wed, 14 May 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238891; cv=none; b=Lj3ZYClq+BFrfdVW/pot1OxhBa63sJLnzw6NLNtrUngcS/PITk19IGI4Y3iyQI3Bb2x2B4uV9gqRe7S89QryZmHu9L9qQH+NrbE3M9NBElnePaAzt9n9UoXH2rFc1+rDpYqHxJEAcQ60Z+T7g67cNfnAjre2dAYud8AIiRskfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238891; c=relaxed/simple;
	bh=bFpwNz08zrSCvP6Znm9FT0VWYBH5RsAskPNCp1Ece1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3ru26y3luiNids29pWcnzmQ36Mn/Fg0aAeAfy/GobgGTrQK63+Z3HU7TWizyQ+/R549fQRh5Nfji8Z8WfE4RBpQGKNmwE38hkD7R3BHjkgTBC3lZ01CcVLZkXTodIZZ62UNVKCeCPcoh+7o1CQR8whtIaZ4S3kGJEfk4GYNQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnMcVn45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF96EC4CEE3;
	Wed, 14 May 2025 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747238889;
	bh=bFpwNz08zrSCvP6Znm9FT0VWYBH5RsAskPNCp1Ece1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OnMcVn45/YQTMIQkGZtwuJuiEwJWKEacaq6GeYjLQnCndzGAqgOagk6/qTzPlfuY+
	 zUwJBDdV7sLPhCZNScCUM1T0jMvjdaVwfyKHLc+ejCmZPKLaCHlA/jVFPb9TYPgsrI
	 1V6bl/jh7ZNvIG4zwiRlhyKAr16MUeqcMcWiHJUhl2LizjNw7D/73bZix5QYLPZxky
	 3vXDqoG0ygV+jsYzjL5X9jKkhRDeSqxCh2X8XoTy7WHUgNLX59nwhm3qnkCSm2dA+u
	 tpyLRAxP8en5uVuJC6PouadUeOhoIadEWPHYuVVqLSxSM0di6aJeDm6P/LyR0rDPG3
	 4RD36ULntTS3w==
Date: Wed, 14 May 2025 09:08:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hibmcge: fix wrong ndo.open() after reset
 fail issue.
Message-ID: <20250514090808.2ae43183@kernel.org>
In-Reply-To: <743a78cc-10d4-45f0-9c46-f021258b577d@huawei.com>
References: <20250430093127.2400813-1-shaojijie@huawei.com>
	<20250430093127.2400813-3-shaojijie@huawei.com>
	<20250501072329.39c6304a@kernel.org>
	<743a78cc-10d4-45f0-9c46-f021258b577d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 10:40:26 +0800 Jijie Shao wrote:
> on 2025/5/1 22:23, Jakub Kicinski wrote:
> > On Wed, 30 Apr 2025 17:31:27 +0800 Jijie Shao wrote:  
> >> If the driver reset fails, it may not work properly.
> >> Therefore, the ndo.open() operation should be rejected.  
> > Why not call netif_device_detach() if the reset failed and let the core
> > code handle blocking the callbacks?  
> 
> If driver call netif_device_detach() after reset failed,
> The network port cannot be operated. and I can't re-do the reset.
> So how does the core code handle blocking callbacks?
> Is there a good time to call netif_device_attach()?
> 
> Or I need to implement pci_error_handlers.resume()?
> 
> 
> [root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
> ETHTOOL_RESET 0xffff
> Cannot issue ETHTOOL_RESET: Device or resource busy
> [root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
> ETHTOOL_RESET 0xffff
> Cannot issue ETHTOOL_RESET: No such device
> [root@localhost sjj]# ifconfig enp132s0f1 up
> SIOCSIFFLAGS: No such device

netdev APIs may not be the right path to recover the device after reset
failure. Can you use a PCI reset (via sysfs) or devlink ?

