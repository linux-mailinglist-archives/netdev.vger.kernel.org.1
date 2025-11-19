Return-Path: <netdev+bounces-239762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 136B2C6C3BB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 630CC4E3C63
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D6222562;
	Wed, 19 Nov 2025 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odHeBkPq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034F1AC44D;
	Wed, 19 Nov 2025 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515388; cv=none; b=eOB0X+n9/uyaHR9kQ4Ccp2OwRE6xz2A4cdVBfQzHwlemY9SsRVbY7ndXW12kVv2OeUlmmtP4sKcOEZfkdG+HtAeCNxmALcUZx9xMlZZz8et3i9tMog9pgiJdVMSnDXCPNwe3GMxg2vLJQNXuERnAnXx4xGrNYIoMp69Mhifk59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515388; c=relaxed/simple;
	bh=glUiSqAGv7rEytGwfKD+3aTp+TzV47q5iucblojgwXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSlLNoclvkxHuyBE+b7m9IjUAYmowDMCDVJjRC0/01C7v0QbxtHARHLEu4xWfDBxA6De5+j4GRDdQlqFTNgMtH0UwwkMIlTkgs5ZxfF64yDfAHmXEqBonIE1TOTEDUAmh8dEuImRfm6hij3fReaMo1sshSYLHE+xL41lxh36kDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odHeBkPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305B7C2BCB7;
	Wed, 19 Nov 2025 01:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763515387;
	bh=glUiSqAGv7rEytGwfKD+3aTp+TzV47q5iucblojgwXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odHeBkPq/DC+/K0H5khu3Jhnntbu4OVaZ7wU5jRyXtorX9MdN0GZDplATU/HnQip2
	 4Y37S1p/BE7rKsQ11Y5aQnmbKlsdCf4zeknEpGxTOXFH2NURaO4zDLTvY6/RIO5qik
	 B4able9Hbc0Lk/Fz5TxyKPT17AYDmyiOKSoWuyGJNSzOEk5AMeFsyGjf/p0LgR5vjd
	 lhKE9wO7ODgKSYU8snjKA9296lEvQnq9uX4JV0oLox+aJFs2WTxK3leMt1o2V+CBeM
	 w1B+/502MMFeUdr+v9zfJUHpnOeM94t4PCVhfh+HMubR7g0ZzUs9Q/uml8dYJWspZ8
	 cYoAA2v1EC85A==
Date: Tue, 18 Nov 2025 17:23:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 04/13] ipvlan: Support IPv6 in macnat mode.
Message-ID: <20251118172304.0cf92242@kernel.org>
In-Reply-To: <20251118100046.2944392-5-skorodumov.dmitry@huawei.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
	<20251118100046.2944392-5-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 13:00:36 +0300 Dmitry Skorodumov wrote:
> To make IPv6 work with macnat mode, need to
> process the TX-path:
> * Replace Source-ll-addr in Solicitation ndisc,
> * Replace Target-ll-addr in Advertisement ndisc
> 
> No need to do anything in RX-path

drivers/net/ipvlan/ipvlan_core.c:343:18: warning: variable 'orig_skb' set but not used [-Wunused-but-set-variable]
  343 |         struct sk_buff *orig_skb = skb;
      |                         ^

