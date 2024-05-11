Return-Path: <netdev+bounces-95731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7498C32F3
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C647E282265
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0841BDCF;
	Sat, 11 May 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEGU9xUq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090E17588;
	Sat, 11 May 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715449075; cv=none; b=PwucxD/sUgZTiHBqKl/n5s+L7oWnD0nLEJR12uuADfDO8T5080mLEDoWE31DoDA4ZsIReBcjkA56FFzZYPnCAUJWxxalj/IICAA5xaQE8EnXtJtpkPD87VeuqWbR9TxPplQw/eUO1B6trQw2SEZi1jde1UO13GF9APnUetF67LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715449075; c=relaxed/simple;
	bh=BGoqZZQFriY3a7wWUduAqOnPoWp4JxonZw5g6JsApNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahTqzOj264x/2HRwGc3Siblm7GZSHXeVbI8CPybv2pAV9kFJWHesqhcdQk4vQbWwGXDWXJT5mPgdJTvi3qG4O9gTNFJePi29tKMMrWkZvhkLtCQLRQNDD41vrICRw12j2W0hcea9TFdC8sZSBDyvjijNoSwqUKbNlX95KT0EMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEGU9xUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDF7C2BBFC;
	Sat, 11 May 2024 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715449075;
	bh=BGoqZZQFriY3a7wWUduAqOnPoWp4JxonZw5g6JsApNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEGU9xUq+FIoL3XpwI99cZHx559LFo8SePVjnznht6sr4Nhm7f1dKJV33onL2RrnO
	 kYedeEbz7WP6YorCYObPvbr5IKEHUnbLWbiWI1WkaAkG897nDxqRw/0up3NmzAbtiK
	 AzN0aD/IS0Yf5xC78fOfLcU2jYxoZ4CwU6yDkfbR38uhrdDFV7vPKJT0UUyc2e/5LS
	 iXfsetsvv7LlHHmCtSx+j3WqBxQhGs+Qnqnk4MlZRmHY0C+M5bx2XV3YphH7GRD597
	 dWZjdY+S3W4SlMk4wyW1tyDxAUTq5m/JgdlDXRtf6UuYALveuw073xVcBB5Uw0tG1Q
	 qpCynCAdPxi3w==
Date: Sat, 11 May 2024 18:37:48 +0100
From: Simon Horman <horms@kernel.org>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
	bartosz.golaszewski@linaro.org, rohan.g.thomas@intel.com,
	rmk+kernel@armlinux.org.uk, fancer.lancer@gmail.com,
	ahalaney@redhat.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v5 1/2] net: stmmac: move the EST lock to struct
 stmmac_priv
Message-ID: <20240511173748.GR2347895@kernel.org>
References: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
 <20240510122155.3394723-2-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510122155.3394723-2-xiaolei.wang@windriver.com>

On Fri, May 10, 2024 at 08:21:54PM +0800, Xiaolei Wang wrote:
> Reinitialize the whole EST structure would also reset the mutex
> lock which is embedded in the EST structure, and then trigger
> the following warning. To address this, move the lock to struct
> stmmac_priv. We also need to reacquire the mutex lock when doing
> this initialization.
> 
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
>  Modules linked in:
>  CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
>  Hardware name: NXP i.MX8MPlus EVK board (DT)
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __mutex_lock+0xd84/0x1068
>  lr : __mutex_lock+0xd84/0x1068
>  sp : ffffffc0864e3570
>  x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
>  x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
>  x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
>  x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
>  x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
>  x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
>  x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
>  x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
>  x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
>  x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
>  Call trace:
>   __mutex_lock+0xd84/0x1068
>   mutex_lock_nested+0x28/0x34
>   tc_setup_taprio+0x118/0x68c
>   stmmac_setup_tc+0x50/0xf0
>   taprio_change+0x868/0xc9c
> 
> Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Reviewed-by: Simon Horman <horms@kernel.org>


