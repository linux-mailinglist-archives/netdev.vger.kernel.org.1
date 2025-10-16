Return-Path: <netdev+bounces-230244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489FBE5B99
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E61640093A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0642E36E1;
	Thu, 16 Oct 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou5GOCLj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D798834;
	Thu, 16 Oct 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655112; cv=none; b=GWFXbX2xGgLbLl1ZvSrygej0fgnLUor9kTxQ5RNsoTbPfMr24tw173b8Kw6GBaknL4DA4FCxvHtQOAz549U5ZVWFQKDyLr/kWAxpilS7D71I2fLGghwlXYQ/1QvMjWiBbTksnQAhK4CF5qVDhV786N4QoN/zusBC7z+/OB3cUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655112; c=relaxed/simple;
	bh=czlyT27p1N4zgXNRMyPM6mkYeIe0/ofkhpebLmY81Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pu+DWWEf6143bi9qSGkn0peo14/l3V/rNy6MS+QYRuizbJ5XDJmM7eB1lzr4kU7V5qHkJ2GJFNVikES4H1zhRlIa88fXcy3qogskXVpPa5VM95hODnZYTjK7ehfTU18gcV+rov9EcTCP8x74Bo6NkwhPOQuj7p/Mx5sQFFHxWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou5GOCLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4564DC4CEF1;
	Thu, 16 Oct 2025 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655111;
	bh=czlyT27p1N4zgXNRMyPM6mkYeIe0/ofkhpebLmY81Yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ou5GOCLjNvny7NfsUYQB98oU/oZoszL9irMyTizhziPIrfgmb4AiA1DNAlS2kTfBl
	 RC8a1yJOM5uG9XtHnOY/Ks5RrkgWT4UvYH6ZnPK3RpJ6nmHLBD9QcdOP82dzXT1MGE
	 lRdswwEFhRc328eVGolbJPHGGZNz3IJXRpgxkRV6QuSeJPOB5YvbIqsrOuvEjsWN/t
	 mQtp+7KNEfNMWAEOz8KAvtaQmXvNY9Q7jiGt50lNdcXhNYalgdvheZruypa1xG1beA
	 cbqrFL57qljspALnjXKVKQD6R8LmppEvQeSMBXTYinWiVGNsOqBhSMAWkbO3UZqzJF
	 3npQTXFQnuqeQ==
Date: Thu, 16 Oct 2025 15:51:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Networking
 <netdev@vger.kernel.org>, Subash Abhinov Kasiviswanathan
 <subash.a.kasiviswanathan@oss.qualcomm.com>, Sean Tranchetti
 <sean.tranchetti@oss.qualcomm.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Subject: Re: [PATCH net] net: rmnet: Fix checksum offload header v5 and
 aggregation packet formatting
Message-ID: <20251016155150.3bc5e351@kernel.org>
In-Reply-To: <20251015092540.32282-2-bagasdotme@gmail.com>
References: <20251015092540.32282-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 16:25:41 +0700 Bagas Sanjaya wrote:
> Fixes: 710b797cf61b ("docs: networking: Add documentation for MAPv5")
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")

Please don't add Fixes tags to markup improvements.
The patch is probably fine for net but there's no need for the extra
tags.

