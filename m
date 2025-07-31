Return-Path: <netdev+bounces-211106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64CDB169C9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 02:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5DA160984
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 00:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D018641;
	Thu, 31 Jul 2025 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6Vrn+mO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB492A55
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753923342; cv=none; b=qtYZ/3a156dJuUbBytZam8kcEGoUvLwAED6XyNFLfXTgNTZHSNzAMo1lGp3E5HRJOPnR0ej9LuY6fADEtzed9FsSZF6Qr7PBwNgbj6f6kbS7vaAecQWaxJOx+9TqqpvUY4YuyiXjbNQ72dxjXApBFoEgIamqTDqtmjWoLdGEktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753923342; c=relaxed/simple;
	bh=/d26Utr9tU3OGWfr/+/s1y5yEz/2Vz/AioCg7Iyne5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQzvQ2jcLXIiw3tdPCQC76QnHHuq0yR85oDE4nAOztme8rcnSC3YJbc4AkOEcrLAQn+5E+6maDPQfiHe+JYf2dA5UHySfBZWZoOlkqnhVwQeA1vJCjgACbA7qKV3MaRzT7lFcyeGD9xi/izL5eXPtP9NwlzEEDxUI4zxfNpej8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6Vrn+mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13537C4CEEB;
	Thu, 31 Jul 2025 00:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753923342;
	bh=/d26Utr9tU3OGWfr/+/s1y5yEz/2Vz/AioCg7Iyne5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D6Vrn+mO6i5mR/er7TnprDB3/EBfoRWPAwXNJvwVpJ78wdW3oL/6xVuHGlo6hO518
	 dXy1pMm4sd7tMdGW+BsrzxQJy8wi8GXvEAQwEu8Wg7GSzMiwWVr6J35kiVtkR2sk1U
	 2RQXDzCs9Wwpast+rCLUTxcH/JOZ4q4zDBjgIF2BOLVtbvBDNtmUBivgmUG22/22Ji
	 fsKqblYePsrUln7iad/uUQbAUIbfAe23njSZsvucpPs5V/UZ6oIu5wkaVleo+kFD7r
	 gZ1z4pF++LhKm08jmTyBmYK1YK3T+rCcBw8ME1e+eyYlygrOAPIC+JjjcionSD0olC
	 cwelX1WUxVDLw==
Date: Wed, 30 Jul 2025 17:55:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, willemb@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v2] net: Update threaded state in napi config
 in netif_set_threaded
Message-ID: <20250730175541.37cfac15@kernel.org>
In-Reply-To: <20250730182511.4059693-1-skhawaja@google.com>
References: <20250730182511.4059693-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 18:25:11 +0000 Samiullah Khawaja wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1c6e755841ce..1abba4fc1eec 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -7023,6 +7023,9 @@ int netif_set_threaded(struct net_device *dev,
>  	 * This should not cause hiccups/stalls to the live traffic.
>  	 */
>  	list_for_each_entry(napi, &dev->napi_list, dev_list) {
> +		if (napi->config)
> +			napi->config->threaded = threaded;
> +
>  		if (!threaded && napi->thread)
>  			napi_stop_kthread(napi);
>  		else

Could we possibly just call napi_set_threaded() instead of having the
body of this loop? The first "if (threaded)" in napi_set_threaded()
should do nothing.. and the rest is pretty much copy & paste.
The barrier is not a concern, it's a control path. WDYT?

The test needs to be added to a Makefile, a few more comments on the
contents..

> +def enable_dev_threaded_disable_napi_threaded(cfg, nl) -> None:
> +    """
> +    Test that when napi threaded is enabled at device level and
> +    then disabled at napi level for one napi, the threaded state
> +    of all napis is preserved after a change in number of queues.
> +    """
> +
> +    ip(f"link set dev {cfg.ifname} up")

Why the up? Env should ifup the netdevsim for you..

> +    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
> +    ksft_eq(len(napis), 2)

So.. the tests under drivers/net are supposed to be run on HW devices
and netdevsim (both must work). Not sure if running this on real HW
adds much value TBH, up to you if you care about that.

If you don't move the test to net/, and use NetdevSimDev() directly.

If you do let's allow any number of queues >= 2, so ksft_ge() here.
Real drivers are unlikely to have exactly 2 queues.

> +    napi0_id = napis[0]['id']
> +    napi1_id = napis[1]['id']
> +
> +    threaded = cmd(f"cat /sys/class/net/{cfg.ifname}/threaded").stdout
> +    defer(_set_threaded_state, cfg, threaded)
> +
> +    # set threaded
> +    _set_threaded_state(cfg, 1)
> +
> +    # check napi threaded is set for both napis
> +    _assert_napi_threaded_enabled(nl, napi0_id)
> +    _assert_napi_threaded_enabled(nl, napi1_id)
> +
> +    # disable threaded for napi1
> +    nl.napi_set({'id': napi1_id, 'threaded': 'disabled'})
> +
> +    cmd(f"ethtool -L {cfg.ifname} combined 1")
> +    cmd(f"ethtool -L {cfg.ifname} combined 2")

And if you decide to keep this in drivers/net it would be good to defer
resetting the queue count to original value too. You can do (untested):

	cur = ethtool(f"-l {cfg.ifname}", json=True).get("combined")

or simply assume there is as many queues as there was napis earlier.

And then a defer(ethtool..

> +    _assert_napi_threaded_enabled(nl, napi0_id)
> +    _assert_napi_threaded_disabled(nl, napi1_id)
-- 
pw-bot: cr

