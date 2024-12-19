Return-Path: <netdev+bounces-153509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988F9F85BB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DB5167818
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA761BEF78;
	Thu, 19 Dec 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkmtfY4C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890AF1BD9CB;
	Thu, 19 Dec 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639523; cv=none; b=WDLYpEg41Hh+Aonx1Ai/B3ox6gmLbThssMV29zPkoBZHe61Jgqx9FER1ng7xtT/J5XW5gq6csqgH6jJJqvSKuYawe5Tc6mutuBt6K8m2t4WK2h46z8s2r74lQpTtrZQyN7C8uXvhwORHcKaHJVoBn7DFCWRmyRZWL+6lNh8TloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639523; c=relaxed/simple;
	bh=KoFj7ZTbF8oplY3j57+uvv4cZtVSD6uQ2VvgawtQeZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiGSjEr9GJmGl4w7402h14tybk11SyoNzh6r5Q0e4Q8ZMcw10hD84CGogUhO2BmjYrwSC5sER53aoDhMFIyA1BXPrS4IWVsKfYfIJYeCwXO/iHTM+l/WxrX91LUI5QEzMutJZJOZsUB/TEml0qUAbdzWDBgHvuMhh5vI+v1Gboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkmtfY4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA2BC4AF0E;
	Thu, 19 Dec 2024 20:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639523;
	bh=KoFj7ZTbF8oplY3j57+uvv4cZtVSD6uQ2VvgawtQeZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZkmtfY4CfyLT3DhJsGJl9L7zxd6scUYBDFYB0zl5EXzmSd3aschRzzGmJDedlpygQ
	 H9iufJau2UUI+xMD8bzc/Xa6t1mg3sRo9PMKwLESHx8bFaIFjIWch1qpzz3yNOTfNH
	 Awp6p2+gVQ9/yyZd0vlcJTgLj22YrUm9whgm1BdQWen2UYV+EM1owwnIP7b4JjGvYY
	 ECTLGuU9Y2EoTDRNqL/UbytzSye3S3oqzYAGdd4+mDsBoV9JMXhjqgmj2JLU9SvBWg
	 brw+AZjM3dkdBN9W9CjnMi8i+qvzcDgvd+Ov/ZQFs2OZuyrU19HEK2PnpGmK7yOSo9
	 MobkbzpOP6I/A==
Date: Thu, 19 Dec 2024 12:18:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch,
 hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk,
 sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241219121841.3ed4de71@kernel.org>
In-Reply-To: <Z2R1GFOg1hapdfl-@JRM7P7Q02P.dhcp.broadcom.net>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-4-ap420073@gmail.com>
	<20241218182547.177d83f8@kernel.org>
	<CAMArcTXAm9_zMN0g_2pECbz3855xN48wvkwrO0gnPovy92nt8g@mail.gmail.com>
	<20241219062942.0d84d992@kernel.org>
	<CAMArcTUToUPUceEFd0Xh_JL8kVZOX=rTarpy1iOAD5KvRWP5Fg@mail.gmail.com>
	<20241219072519.4f35de6e@kernel.org>
	<Z2R1GFOg1hapdfl-@JRM7P7Q02P.dhcp.broadcom.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 14:33:44 -0500 Andy Gospodarek wrote:
> > I see it now in bnxt_set_rx_skb_mode. I guess with high MTU
> > the device splits in some "dumb" way, at a fixed offset..
> > You're right, we have to keep the check in the driver, 
> > at least for now.  
> 
> The mutlti-buffer implementation followed what was done at the time in
> other drivers.  Is the 'dumb way' you mention this check?
> 
>  4717                 if (dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
>  4718                         bp->flags |= BNXT_FLAG_JUMBO;
>  4719                         bp->rx_skb_func = bnxt_rx_multi_page_skb;
>  4720                 } else {
>  4721                         bp->flags |= BNXT_FLAG_NO_AGG_RINGS;
>  4722                         bp->rx_skb_func = bnxt_rx_page_skb;
>  4723                 }

Yes, that and my interpretation of the previous discussion let me to
believe that the BNXT_FLAG_JUMBO does not enable header-data split.
And speculating further I thought that perhaps the buffer split with
jumbo > 4k is to fill first buffer completely, header+however much
data fits.

I could have misread the previous conversation (perhaps Michael meant
XDP SB / PAGE_MODE when he was referring to XDP limitations?)

Or maybe the HDS does happen with XDP MB but there is another
limitation in the code?

I'm not sure. At this stage we just need to know if the check in the
driver is really needed or XDP MB + HDS are fine, and we can remove
the driver check, as core already prevents XDP SB + HDS. Could you
clarify?

