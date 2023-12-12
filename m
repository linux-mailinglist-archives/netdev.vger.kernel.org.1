Return-Path: <netdev+bounces-56568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C780F681
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD5428147C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C181E3B;
	Tue, 12 Dec 2023 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEQHZ1B5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7D81E36
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 19:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E8C433C9;
	Tue, 12 Dec 2023 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408907;
	bh=mj3SAwKcmqSqhMBqORrj4sHEFg6g5cS+PgxB5jSbueY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KEQHZ1B5w9+KQEUURp8DI6uCXRF4SjDEK2K0PH8YTdG4Q7EUrSRK+V6rfabwGbsQV
	 UFPCt5lBYyOGcrgt/KV18WrYpGDH39q6CTQmi2Fg1MJ5mYXJBSjWfsegyeIPjQrjBb
	 lUzWYVkaqwQe2KFCL32uqg1nrUVFn16KSIxhXk3+T5Ive6WDYeS2KkznrBGz/XpFnO
	 N/ekEg3TGKl5HjMu37kyXAaILa7GZyZGBkp3RToBqCq2K61E7CKMSW4sIGUDXcT7Wc
	 5kJpD5I+OCycKUCY6IrSsCzwoOGMLFNxVqQeiobdYQOqq8dbhbPEYiFaJP9qyi3QCx
	 8ETOjngt76Vdg==
Date: Tue, 12 Dec 2023 11:21:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 10/13] rtase: Implement ethtool function
Message-ID: <20231212112145.25953351@kernel.org>
In-Reply-To: <20231208094733.1671296-11-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-11-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 17:47:30 +0800 Justin Lai wrote:
> +static const char rtase_gstrings[][ETH_GSTRING_LEN] = {
> +	"tx_packets",
> +	"rx_packets",
> +	"tx_errors",
> +	"rx_errors",
> +	"rx_missed",
> +	"align_errors",
> +	"tx_single_collisions",
> +	"tx_multi_collisions",
> +	"unicast",
> +	"broadcast",
> +	"multicast",
> +	"tx_aborted",
> +	"tx_underrun",

Please take a look at struct rtnl_link_stats, anything that's already
present there should be reported via ndo_get_stats64, not ethtool

