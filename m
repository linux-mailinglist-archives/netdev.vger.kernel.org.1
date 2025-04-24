Return-Path: <netdev+bounces-185355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F2A99E68
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B335462BEE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421351C863D;
	Thu, 24 Apr 2025 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In6JOv4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD02701C3;
	Thu, 24 Apr 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458957; cv=none; b=eUMf7qHwTyrlM7Ckbx2POfZWG9ua0i66N4sZZMZ+ImQAHRDStW/EJlZPSr29RlzFNml+QQRX4zmfdxIVMFeSFbG3M7xjlrhZJkI7v2UVKPtfeO8NV9WcAhQUJsi2WtQrCAGuLubRtFT4oEKKbxR4nG6B+O3X3D5i6QYcRXV4ZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458957; c=relaxed/simple;
	bh=0LzpYyQ58dMxDi/yJxj6/tta1TEp+k7e6IxpWE06PFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMAvp+fOoplSudZMhAqYANeaFq9DxcqObqgYhD1+AFes7l9CPyPGjkRmskmPMAfCSS7Gsj6rvC9umFHtee32fef6y26gxWg0PzB9csTb3W0uY4r0YdWUjildzkCLw4DAAIn6an3+5FVfW34jjeWhFOhKIoQ0m//ztdm3RYaIWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In6JOv4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459F5C4CEE2;
	Thu, 24 Apr 2025 01:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745458956;
	bh=0LzpYyQ58dMxDi/yJxj6/tta1TEp+k7e6IxpWE06PFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=In6JOv4zruOG7B/CI2fFbqeq/VPb72PUYKRkd+QMIaHJK8yk8ni/ZKIDfjyFMlGeA
	 xEVU2uiqG59uGADij04uWEc+0FrQ4IALcN8j0WPUeldH+tOEf9X3q6OwMZvxp3F5v4
	 yPXwPR7jYPYnnhb1w/++QU2I+ZXkfxC6EG0xS2jUKJ8aogMk4Pf2GE/cYfQdPXSzTp
	 j9t2HinSF52+aEkLKZedXmKJTJE3Ihm0ed1MI+ZBfr8JeHcCvdnuFHz3BcMdeE4Jv/
	 p51jYYOm/nSwANnsTYsnxlGZ5IMYiJivEP+f255egrHMe8OY7FnQ0+LN+5ZXCzOvFI
	 xro+dmtF0ljhg==
Date: Wed, 23 Apr 2025 18:42:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: add synchronization for stats
 update
Message-ID: <20250423184235.0242ae79@kernel.org>
In-Reply-To: <20250421191645.43526-2-yyyynoom@gmail.com>
References: <20250421191645.43526-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 04:16:44 +0900 Moon Yeounsu wrote:
> -	dev->stats.tx_errors++;
> +	np->tx_errors++;
>  	/* Ttransmit Underrun */
>  	if (tx_status & 0x10) {
>  		dev->stats.tx_fifo_errors++;
> @@ -904,7 +904,7 @@ tx_error (struct net_device *dev, int tx_status)
>  	}
>  	/* Maximum Collisions */
>  	if (tx_status & 0x08)
> -		dev->stats.collisions++;
> +		np->collisions++;

These can be updated concurrently with the reading.
Since they are 64b on 32b machines the update may not be atomic.
So to be safe please take the spin lock around the increments,
or you could convert them to a atomic_t, or you can make them 32 bits
and update them with WRITE_ONCE() read with READ_ONCE()..
-- 
pw-bot: cr

