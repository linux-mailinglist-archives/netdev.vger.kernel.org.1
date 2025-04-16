Return-Path: <netdev+bounces-183350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E6CA9079E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FD25A0CA0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A89D20CCF4;
	Wed, 16 Apr 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRPBMaxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291D18C32C;
	Wed, 16 Apr 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817042; cv=none; b=Qxee+9URZQxrNjyvd/0WgpPEKPx9MsqKcs4iXHqRU2IgwTncIuzHL6RKOOJXap8GoP/AncCHJZ9SER/b74r2xi6ohf4tWVzJwKDo1bIRXZHxdEgDicucVkStx4j0JBUU+VoqosfPR0arUoI0T2i6BeFlZ2gqWp1obukPitpG0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817042; c=relaxed/simple;
	bh=pGN2FXf/xEtwV//iodDxkLZW7OxIkiZj+THM/M1JVek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMa4jaE0TTOmxbAHya94pHm+vfXvxCW46ZHmkz0sezdGq3VPqqXG6p/MwGaEuUwTZnPkF4NV7A+/PwRfO/5tgpn3p0b+LTHIilwOuIvIPZu3IC52HON9E3YLMw/yrL00RY/xQZfzUApnaKATgY2dv975H3ulpBww0/C89hyKec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRPBMaxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46AFC4CEE2;
	Wed, 16 Apr 2025 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744817042;
	bh=pGN2FXf/xEtwV//iodDxkLZW7OxIkiZj+THM/M1JVek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRPBMaxZC9H7f4o35IrstTtLsqBUWW3k/4Mrmjl3qoXyvWKjO5oalml9EdnxkxAvW
	 /XNT1GZ5t40KQ6qTl9J/zTiAgSdg0brYz/whhj7z8CtLo3jpPAJYu0v9s4P1mJq9EO
	 aEk7QOW7PYd29Bdxk7kF0Q7f6Ni1YuExs21svDjQHNePcqnXwy3fSsE6LNHKOPVdhz
	 U6tn8hw5V+1GV1i5qlxwgs5Z9cnZKXQMBZpdIV/Z1Mcuv943LXYwBois7+KYL5xfzE
	 iwMiCiOou9jXYAWbfZWVOv/pnTStmQm8UvBb9v4q/6uAu+AsG1V3GgfHk5CnahVFal
	 7eAmm/VbGzT9w==
Date: Wed, 16 Apr 2025 16:23:57 +0100
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: txgbe: fix memory leak in txgbe_probe() error
 path
Message-ID: <20250416152357.GS395307@horms.kernel.org>
References: <20250415032910.13139-1-abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415032910.13139-1-abdun.nihaal@gmail.com>

On Tue, Apr 15, 2025 at 08:59:09AM +0530, Abdun Nihaal wrote:
> When txgbe_sw_init() is called, memory is allocated for wx->rss_key
> in wx_init_rss_key(). However, in txgbe_probe() function, the subsequent
> error paths after txgbe_sw_init() don't free the rss_key. Fix that by
> freeing it in error path along with wx->mac_table.
> 
> Also change the label to which execution jumps when txgbe_sw_init()
> fails, because otherwise, it could lead to a double free for rss_key,
> when the mac_table allocation fails in wx_sw_init().
> 
> Fixes: 937d46ecc5f9 ("net: wangxun: add ethtool_ops for channel number")
> Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

