Return-Path: <netdev+bounces-203382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D65AF5B39
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272741C26F6F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C073093A4;
	Wed,  2 Jul 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r78VRl5I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A03307ADF;
	Wed,  2 Jul 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466900; cv=none; b=hkl+07I9F+1q80ywazNzQhW7YBB25TtNyaCs6nwcla5ny/bmw7AddoSRxKkzbyDEOi8xJTIkcn+w/v5jia2uQwFWswQGcdcXPhOp7lq1bdmlvtmOHw96wqnhRigi2KDUdpqvhVbpTWc7kGnK2VzWalbs+cOByyvZMNFu8BV6zoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466900; c=relaxed/simple;
	bh=kYG7Gws/V5xCeQe918f67t+EtnM9+dC9skPifSL5mEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYxU/wTj0CgK/I2yyNGNwhqDOOwShhQMSshzlDo3La9UXQOPIWy9VQOZ6zgdn2WCQJHtzmsAWfQHoRtjZMZJ5NbcF3aIG7oh4HU+PAD15Kkd4/5Szqib5NY7N4nFNJs45MIOkYO5xgCMhUAS6W2wA00EQoOGHVaoeByndEnlwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r78VRl5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947FAC4CEE7;
	Wed,  2 Jul 2025 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751466900;
	bh=kYG7Gws/V5xCeQe918f67t+EtnM9+dC9skPifSL5mEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r78VRl5I/3sZGIc4Z4XSnZZ9nI0/VFYS5QZJPImjo4moC0CXyco4x9TCM5999WMS2
	 SXYSBaO+sxAgcRH7yNHZ1W+WGH0XxKL+auKJmN7/6ONgyozd3akL+V8Qb2xc+d24xJ
	 4f8Rfu6RxsjjtycjFVE+VYPFrhlHzwmetUUzIZ8jrBQ/pmxs+mIv8yZf6WBEVatlul
	 AFXB5yYWH5TPn/HMk+Z6zOIa2JInaLCwFRxez9k7elGf6GUy0Je9Prsbrav7oMd4Xr
	 cy8FN4m3gSh9J4UBfIVSQ6Me5ZTe61QRI4OkqrOiY+pY4POSYPnJgQy/fUCnQkacq2
	 dWoFesrrt+42Q==
Date: Wed, 2 Jul 2025 07:34:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
Message-ID: <20250702073458.3294b431@kernel.org>
In-Reply-To: <20250702074619.139031-1-g.goller@proxmox.com>
References: <20250702074619.139031-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 09:46:18 +0200 Gabriel Goller wrote:
> It is currently impossible to enable ipv6 forwarding on a per-interface
> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
> enable it on all interfaces and disable it on the other interfaces using
> a netfilter rule. This is especially cumbersome if you have lots of
> interface and only want to enable forwarding on a few. According to the
> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
> for all interfaces, while the interface-specific
> `net.ipv6.conf.<interface>.forwarding` configures the interface
> Host/Router configuration.
> 
> Introduce a new sysctl flag `force_forwarding`, which can be set on every
> interface. The ip6_forwarding function will then check if the global
> forwarding flag OR the force_forwarding flag is active and forward the
> packet.

Should we invert the polarity? It appears that the condition below only
let's this setting _disable_ forwarding. IMO calling it "force" suggests
to the user that it will force it to be enabled.

Nicolas, how do you feel about asking for a selftest here? 
The functionality is fairly trivial from datapath PoV, but feels odd 
to merge uAPI these days without a selftest..

