Return-Path: <netdev+bounces-112187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0893752D
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 10:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA7FB20BAD
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD678291;
	Fri, 19 Jul 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3/LEAmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E76F2F0
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378514; cv=none; b=UfISw2YGzeTeZHz4MQ/pKf6gX3BvQUBtvNcMLzc8KCcijrAlH+bLZd9ciXp5WxRkhNs2eXu1JtI9m7QT/lkUhVQ/gD15xWM4tK8gkklKy/sZfwPZbmdYwvWUvfEc4KAzKYiJebU1Pc/W615ksyXdiHMxO4MLk+1OZxgAtew9LvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378514; c=relaxed/simple;
	bh=N7379S3isTaffnQiWou5XrNoTMiNRY+sLWnV6zk31fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuM+y2jWACMuZOQ+smb4V3ZtrQ2NvpBNyKWv59rUvIm+u8P2t9GxLEdEG6QbBr6S1zlm9MRfFGipcGMVOfMBlt76moBvi0Ue9vbpvITJyycl8yPJrjl4M880tnjSTTiO2xd5hnBQLhEN9PSEjJe38IzXLFxLMKXVdJVk4SK7fbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3/LEAmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A054EC32782;
	Fri, 19 Jul 2024 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378513;
	bh=N7379S3isTaffnQiWou5XrNoTMiNRY+sLWnV6zk31fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3/LEAmZsjHMh4Rxj1Em66Y2PiZUBR3cEUyX9cw940wTASXkln6IqASzviUdErE2i
	 K4GgsQ6uM9St8FOCYw2JrwxujqNhybBpQhtmBBoo+CnpXpZLeMjx6qZRNcauOfLjYZ
	 4P/n8ZEJbQo/6Ej6OJsh+RFO5dnk9yOPOGT9og8S7qf6ZT6B+Isq9jwUQZoWGvba6y
	 dZQEfiJwUi1NegIXq5k+hxVRETZqdwtITlWXb/TBLXWa/XaqK5NNrdO+aqmOionhBT
	 3ecQDe9G/ddnR0WqO4b9x8ZwvltjNG1IKa7HYrBfW125x/AQuzvmplFx4b0PcAEiAb
	 JXIIn/Uj8E4FA==
Date: Fri, 19 Jul 2024 09:41:49 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tparkin@katalix.com,
	samuel.thibault@ens-lyon.org, thorsten.blum@toblux.com
Subject: Re: [PATCH net] l2tp: make session IDR and tunnel session list
 coherent
Message-ID: <20240719084149.GC616453@kernel.org>
References: <20240718134348.289865-1-jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718134348.289865-1-jchapman@katalix.com>

On Thu, Jul 18, 2024 at 02:43:48PM +0100, James Chapman wrote:
> Modify l2tp_session_register and l2tp_session_unhash so that the
> session IDR and tunnel session lists remain coherent. To do so, hold
> the session IDR lock and the tunnel's session list lock when making
> any changes to either list.
> 
> Without this change, a rare race condition could hit the WARN_ON_ONCE
> in l2tp_session_unhash if a thread replaced the IDR entry while
> another thread was registering the same ID.
> 
>  [ 7126.151795][T17511] WARNING: CPU: 3 PID: 17511 at net/l2tp/l2tp_core.c:1282 l2tp_session_delete.part.0+0x87e/0xbc0
>  [ 7126.163754][T17511]  ? show_regs+0x93/0xa0
>  [ 7126.164157][T17511]  ? __warn+0xe5/0x3c0
>  [ 7126.164536][T17511]  ? l2tp_session_delete.part.0+0x87e/0xbc0
>  [ 7126.165070][T17511]  ? report_bug+0x2e1/0x500
>  [ 7126.165486][T17511]  ? l2tp_session_delete.part.0+0x87e/0xbc0
>  [ 7126.166013][T17511]  ? handle_bug+0x99/0x130
>  [ 7126.166428][T17511]  ? exc_invalid_op+0x35/0x80
>  [ 7126.166890][T17511]  ? asm_exc_invalid_op+0x1a/0x20
>  [ 7126.167372][T17511]  ? l2tp_session_delete.part.0+0x87d/0xbc0
>  [ 7126.167900][T17511]  ? l2tp_session_delete.part.0+0x87e/0xbc0
>  [ 7126.168429][T17511]  ? __local_bh_enable_ip+0xa4/0x120
>  [ 7126.168917][T17511]  l2tp_session_delete+0x40/0x50
>  [ 7126.169369][T17511]  pppol2tp_release+0x1a1/0x3f0
>  [ 7126.169817][T17511]  __sock_release+0xb3/0x270
>  [ 7126.170247][T17511]  ? __pfx_sock_close+0x10/0x10
>  [ 7126.170697][T17511]  sock_close+0x1c/0x30
>  [ 7126.171087][T17511]  __fput+0x40b/0xb90
>  [ 7126.171470][T17511]  task_work_run+0x16c/0x260
>  [ 7126.171897][T17511]  ? __pfx_task_work_run+0x10/0x10
>  [ 7126.172362][T17511]  ? srso_alias_return_thunk+0x5/0xfbef5
>  [ 7126.172863][T17511]  ? do_raw_spin_unlock+0x174/0x230
>  [ 7126.173348][T17511]  do_exit+0xaae/0x2b40
>  [ 7126.173730][T17511]  ? srso_alias_return_thunk+0x5/0xfbef5
>  [ 7126.174235][T17511]  ? __pfx_lock_release+0x10/0x10
>  [ 7126.174690][T17511]  ? srso_alias_return_thunk+0x5/0xfbef5
>  [ 7126.175190][T17511]  ? do_raw_spin_lock+0x12c/0x2b0
>  [ 7126.175650][T17511]  ? __pfx_do_exit+0x10/0x10
>  [ 7126.176072][T17511]  ? _raw_spin_unlock_irq+0x23/0x50
>  [ 7126.176543][T17511]  do_group_exit+0xd3/0x2a0
>  [ 7126.176990][T17511]  __x64_sys_exit_group+0x3e/0x50
>  [ 7126.177456][T17511]  x64_sys_call+0x1821/0x1830
>  [ 7126.177895][T17511]  do_syscall_64+0xcb/0x250
>  [ 7126.178317][T17511]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: aa5e17e1f5ec ("l2tp: store l2tpv3 sessions in per-net IDR")
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: Tom Parkin <tparkin@katalix.com>

Thanks James,

I agree that this addresses the issue described.
And, FWIIW, I also checked that the locking order is
consistent with that before this patch as for no reason
in particular I was concerned about deadlocks.

Reviewed-by: Simon Horman <horms@kernel.org>




