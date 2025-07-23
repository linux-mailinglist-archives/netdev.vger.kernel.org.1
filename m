Return-Path: <netdev+bounces-209167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF87B0E831
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E9C3ABB63
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC016D9BF;
	Wed, 23 Jul 2025 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YraaC8Jo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F813A41F
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234609; cv=none; b=MzSh5ecDXPWBRvrurhUs7jfwTC8he8wPe8XZh1b2lkHL0IOc2uHNdOHw/prR9HSZ3dFL0mkJdnzmBS2FBBCI0iV4tBPjrXD6ygXo24F7pz/CY0hbXFc62nmj0TM0MP2vn/BG4Q/eWq57k3OkCAWJV9M1vvLTf3G39iXBMp3U+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234609; c=relaxed/simple;
	bh=FxqKfuN0GN6MNf20guvIzG1LJRYpjlIPFTWfQI02NCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOXMWz7WsH6BIqLAzcAwrC6SyBdCj6snyhHHI0RGYIikmrHO/Ejp+/jtd/X1duvBPYpbLWjR1GqGF5NGN/apPcLVo/lY7YoghdLWmLH2j06BSvRgw0Dp+I/Lw9GHAuXE/LhBSEyF9sK9RbQE77KEei8U5x1W3A0hH5z5/Cdq0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YraaC8Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7DCC4CEF6;
	Wed, 23 Jul 2025 01:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234608;
	bh=FxqKfuN0GN6MNf20guvIzG1LJRYpjlIPFTWfQI02NCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YraaC8JotkqIaY8pHUPm8j9PCv27QeBasCD174j54IpbJF14tV4mOtTofEVRIOWIZ
	 Hoa/G+MFAR1hyD9X8bNl3NG2GFbzHA5Kr7M/GMhNCIcBzCII0s8o98GoZhKbN8Gqnw
	 EaCFXEfuyHZH5JJSSmdDoz9QBBJmF80l/XyeAUaL+41/kdx9CWAPunGp5UDr6/cmL0
	 8pNCqGxHnjuMSAWVbuR984Jo7X0vVoMJCWlh18OKRgQUW+Pbq5GbmPkeOecKfWQ36U
	 wuxfdz2NCdBWBCIVGU5U2M9NgM0SNjul1WM0WD4KEpTovVBcaMUv2ELUf9snvc+qOt
	 2YeqsyU1WJzAA==
Date: Tue, 22 Jul 2025 18:36:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: Restore napi threaded state only when it
 is enabled
Message-ID: <20250722183647.1fd15767@kernel.org>
In-Reply-To: <20250721233608.111860-1-skhawaja@google.com>
References: <20250721233608.111860-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 23:36:08 +0000 Samiullah Khawaja wrote:
> Commit 2677010e7793 ("Add support to set NAPI threaded for individual
> NAPI") added support to enable/disable threaded napi using netlink. This
> also extended the napi config save/restore functionality to set the napi
> threaded state. This breaks the netdev reset when threaded napi is

"This breaks the netdev reset" is very vague.

> enabled at device level as the napi_restore_config tries to stop the
> kthreads as napi->config->thread is false when threaded is enabled at
> device level.

My reading of the commit message is that the WARN triggers, but
looking at the code I think you mean that we fail to update the
config when we set at the device level?

> The napi_restore_config should only restore the napi threaded state when
> threaded is enabled at NAPI level.
> 
> The issue can be reproduced on virtio-net device using qemu. To
> reproduce the issue run following,
> 
>   echo 1 > /sys/class/net/threaded
>   ethtool -L eth0 combined 1

Maybe we should add that as a test under tools/testing/drivers/net -
it will run against netdevsim but also all drivers we test which
currently means virtio and fbnic, but hopefully soon more. Up to you.

I'm not sure I agree with the semantics, tho. IIUC you're basically
making the code prefer threaded option. If user enables threading
for the device, then disables it for a NAPI - reconfiguration will
lose the fact that specific NAPI instance was supposed to have threading
disabled. Why not update napi->config in netif_set_threaded() instead?
-- 
pw-bot: cr

