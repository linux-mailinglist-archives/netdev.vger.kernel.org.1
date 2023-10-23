Return-Path: <netdev+bounces-43440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E87D322F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEF81C208FF
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950FC14282;
	Mon, 23 Oct 2023 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8w89mq4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873A14A81
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E98DC433C9;
	Mon, 23 Oct 2023 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698059853;
	bh=3zAwiEexuhFbhJpVqY15Jho2Mmz9AaR+HIcJ8igMtoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8w89mq4wmC3x/KeH3y9Uy6coEjBuvoBB0+8m3HEhN+r6aKHbD1VyZ7iXe0l4KGvT
	 D8EDgUgrGo5ZmaXRYmR8pp3c6LlJPDF+34amu9Hr2ECbYmjYb7VfiDZ3rVibwTuva1
	 GxI0IWyIYxtEgtyCKtwxPqdXuBrl7Sy/WeTUM7U7HqiDBwIHqJES6ZsW72jDGo6Qy1
	 99WgMe7dUStG7PBFyZUZ6+2nCuk/ChXUv1XtRbNYl4n5AK6NIWliaW1NAWcwqpLC5Y
	 Il73Hazs72HGpPMmpNDnF+FceUf0TY7d2Pxazivai7YUdABaYNIHyLPBnT8XUsF/p0
	 wiU0iJl34HrDw==
Date: Mon, 23 Oct 2023 12:16:54 +0100
From: Simon Horman <horms@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net v2] ravb: Fix races between ravb_tx_timeout_work()
 and net related ops
Message-ID: <20231023111654.GW2100445@kernel.org>
References: <20231019113308.1133944-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019113308.1133944-1-yoshihiro.shimoda.uh@renesas.com>

On Thu, Oct 19, 2023 at 08:33:08PM +0900, Yoshihiro Shimoda wrote:
> Fix races between ravb_tx_timeout_work() and functions of net_device_ops
> and ethtool_ops by using rtnl_trylock() and rtnl_unlock(). Note that
> since ravb_close() is under the rtnl lock and calls cancel_work_sync(),
> ravb_tx_timeout_work() should calls rtnl_trylock(). Otherwise, a deadlock
> may happen in ravb_tx_timeout_work() like below:
> 
> CPU0			CPU1
> 			ravb_tx_timeout()
> 			schedule_work()
> ...
> __dev_close_many()
> // Under rtnl lock
> ravb_close()
> cancel_work_sync()
> // Waiting
> 			ravb_tx_timeout_work()
> 			rtnl_lock()
> 			// This is possible to cause a deadlock
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms@kernel.org>


