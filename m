Return-Path: <netdev+bounces-236519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ECBC3D8D4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17BD188B429
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73A30B505;
	Thu,  6 Nov 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo2meooQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D927F4E7;
	Thu,  6 Nov 2025 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467182; cv=none; b=H3Azys/zk5HSSzMQ43Bz5uFIu0UbEq6Ere7tB0NlVNfvSTC/aKN2Mv98mt1Yp1vpb21AV8D+Fft1Vk20qS6BPbIHfJUNlNRqqXYgQ9VqvD9V1pvRt2jB62GxTGt0FkVgbw4uN9VbKhfQ6vvrqTsH8i/wH9xhsYJ49HX7ugWDNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467182; c=relaxed/simple;
	bh=NeL+xYZHOYWXuLDLXVvZlwC64XSLn6KftmV4pqYADUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rC43jyaAgdHXWPrVXWqgfbR+LHtNb8o4Osvl6Wq4SknJHRqxoJFvo86CCxdEuPdiepxO/12x1Lbd9NDcMPK7ec7nQmXD8cl/1YbLVgkpHXSkjcOuRev7akcXCkWV09Kd4PwIlKuvnRvqOJzkjmklSBr+M3df0uXpeWBthx04kqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo2meooQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA3AC4CEFB;
	Thu,  6 Nov 2025 22:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762467181;
	bh=NeL+xYZHOYWXuLDLXVvZlwC64XSLn6KftmV4pqYADUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jo2meooQuqdXmsWyZVGGaNVGhbtcfxponiIoHz93yOP7bUQY6lEW3BZFevPO/QIsB
	 R8zcAG3m6jeEaIq357tLKwF6iR05JRADanMUzYIgMcH+CdCcs5dki1CBqLYn+cYQtH
	 DuSnCmFYaa5vR69kPYpdBRpdVhPflkjIR0K1f14vrE2/EzkOH9iUL1ehDNro8eUObP
	 hhmJ2auhqavPjII7UzR192K0faeZ2mZLWd1EyhRLNAsU4fZUOVQCG81S9mLmSagpo8
	 qFwB9ajtRM2gqGEkqqlBB1pxR6u+P6TGDg8NFAVpiTxiel7qWnWmsIeyIztJL3qnA9
	 q0OxJnr61p7ZQ==
Date: Thu, 6 Nov 2025 14:12:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config
 and helper structs and functions:
Message-ID: <20251106141259.60e48f1e@kernel.org>
In-Reply-To: <CAPrAcgMXw5e6mi1tU=c7UaQdcKZhhC8j-y9woQk0bk8SeV4+8A@mail.gmail.com>
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
	<20251028174222.1739954-2-viswanathiyyappan@gmail.com>
	<20251030192018.28dcd830@kernel.org>
	<CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com>
	<20251104164625.5a18db43@kernel.org>
	<CAPrAcgMXw5e6mi1tU=c7UaQdcKZhhC8j-y9woQk0bk8SeV4+8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 21:38:59 +0530 I Viswanath wrote:
> On Wed, 5 Nov 2025 at 06:16, Jakub Kicinski <kuba@kernel.org> wrote:
> > I wouldn't use atomic flags. IIRC ndo_set_rx_mode is called under
> > netif_addr_lock_bh(), so we can reuse that lock, have update_config()
> > assume ownership of the pending config and update it directly.
> > And read_config() (which IIUC runs from a wq) can take that lock
> > briefly, and swap which config is pending.  
> 
> How does this look?
> 
> It's possible for the actual work of set_rx_mode to be in a work item
> so we need to validate that dev->addr_list_lock is held in update_config()
> 
> // These variables will be part of dev->netif_rx_config_ctx in the final code
> bool pending_cfg_ready = false;
> struct netif_rx_config *ready, *pending;
> 
> void update_config()
> {
>     WARN_ONCE(!spin_is_locked(&dev->addr_list_lock),
>     "netif_update_rx_config() called without netif_addr_lock_bh()\n");
> 
>     int rc = netif_prepare_rx_config(&pending);
>     if (rc)
>         return;
> 
>     pending_cfg_ready = true;
> }
> 
> void read_config()
> {
>     // We could introduce a new lock for this but
>     // reusing the addr lock works well enough
>     netif_addr_lock_bh();
> 
>     // There's no point continuing if the pending config
>     // is not ready
>     if(!pending_cfg_ready) {
>        netif_addr_unlock_bh();
>        return;
>     }
> 
>     swap(ready, pending);
>     pending_cfg_ready = false;
> 
>     netif_addr_unlock_bh();
> 
>     do_io(ready);
> }

Yes, I think this flow looks good.

> On the topic of virtio_net:
> 
> set_rx_mode in virtio_net schedules and does the actual work in a work
> item, so would
> the correct justification here be moving I/O out of the rtnl lock?

Avoiding rtnl_lock is not a goal right now. We should still take
rtnl_lock around read_config() in case the driver assumes rtnl_lock
is held around all its config paths.

The objective is just to simplify the driver. Avoid the state
management and work scheduling in every driver that needs to the config
async. IOW we just want to give drivers an ndo_set_rx_mode that can
sleep.

