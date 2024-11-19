Return-Path: <netdev+bounces-146088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471549D1EB3
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3F51F223B6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7990142624;
	Tue, 19 Nov 2024 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPOX5MWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08013AA35;
	Tue, 19 Nov 2024 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985873; cv=none; b=jT1jxpn62EowRrCRPy/W5jO6abUm8CIHMJ0yFFdxfHV7PohXxSM9wlxFYO0NAS0JjpQd3Hqu6R6MuskwCOZS/BiHcAB3sCcsYpKFoZo0zGbmv2VTdc5ALusAzmq2MWJ4SWS/r+wRF9EyZJQoLgl32L2+RKMg0TzmYDEQIzA+N2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985873; c=relaxed/simple;
	bh=7jDb8H+Flc+eOAqehImd4mkdDmhj3tUyn3G6YFZI5ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZa1iJVEwtpQbzl2PHRSsMB4v/32VL3aNA4LMrZqwOA9WafcKRRCC3gVv2J5JldoIK0/kxNZCL0mok14Mua3IQf/VwPqS3d2eNN9MxqRw8RFpm9jAmtiPEvjTi/kiCij5Sv33Y1wv0oA7rx5QmNNFvfqWjqtlY5VyupvQsdAUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPOX5MWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C567CC4CECF;
	Tue, 19 Nov 2024 03:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985873;
	bh=7jDb8H+Flc+eOAqehImd4mkdDmhj3tUyn3G6YFZI5ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nPOX5MWyOL7zeYG3r5t3jPztJyfdKYFFbuzrATqkvX5TamfRaBRdIQJAwhFuYkDDE
	 bFENqvzoG/8rdtVnNscgbEmULrKhsxVoLJNWLsIK5F7WV9EdSS0KUMXUJXjPygEpzQ
	 DSjlfgdO6MBrMeSMrBz/x2dP66iTCsidwaYzSP0FipgB9EqJp9DFbQTtbnpOhL5oAP
	 q5InglinySmjqhYrLspn/CAvSzZAGy8Y1ZV1D7+RHAwrPOECfKkbrwteYZaeS8Ckhv
	 G1UhnM+yOOK3qOFiN5qe3xGpehhWFFBD63TiTnrkbonAjXhajecHy/qts7KBrEgxoR
	 2pBmgnKybeYUg==
Date: Mon, 18 Nov 2024 19:11:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: Qingtao Cao <qingtao.cao@digi.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: mv643xx_eth: disable IP tx
 checksum with jumbo frames for Armada 310
Message-ID: <20241118191111.7286dc2c@kernel.org>
In-Reply-To: <20241118004509.200828-1-qingtao.cao@digi.com>
References: <20241118004509.200828-1-qingtao.cao@digi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 10:45:09 +1000 Qingtao Cao wrote:
> The Ethernet controller found in Armada 310 doesn't support TCP/IP checksum
> with frame sizes larger than its TX checksum offload limit
> 
> When the path MTU is larger than this limit, the skb_warn_bad_offload will
> throw out a warning oops
> 
> Disable the TX checksum offload (NETIF_F_IP_CSUM) when the MTU is set to a
> value larger than this limit, the NETIF_F_TSO will automatically be disabled
> as a result and the IP stack will calculate jumbo frames' checksum instead.

I thought I suggested ndo_features_check, why are you using
fix_features?
-- 
pw-bot: cr

