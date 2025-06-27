Return-Path: <netdev+bounces-202017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBEAEBF6C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7273ABF24
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914801F4C99;
	Fri, 27 Jun 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoNInXet"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE461F473C;
	Fri, 27 Jun 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051270; cv=none; b=SNRCj+cSsyLiRtbclorRz8CarAssVSFHQw56hdHZqkjgJ0yJja9HYBQvxDQDhlMlzyQkGP6jVkXgp/F92wkg+BJTTG14By5IfifsgktUaSkuxXp5vYSHEBLU6PoKZUfznGpHf+FnhpRjUHQP6fmVfBDyCwom/DmJnkrq4WxumhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051270; c=relaxed/simple;
	bh=HIhKSfWvwkdsX1z7HRNgiPtJGkgBB0cwT3oK/I1EHSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL4k4WRPwgnXzA44DlYkyw4mWlLJzPIj5BOqOyfTJ3H3noXcfGiXq1xqhkA8X6cAmdiCl204F4obej+wDoNM2YtYHMcsw0FxY+9ynO5DJSKZ0qg+O2wuBFDPrPgyDPF85XdX4skWqg2cGp0ugaV3kN9rFeC0Y9uJ3Tl67OegqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoNInXet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34731C4CEE3;
	Fri, 27 Jun 2025 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751051270;
	bh=HIhKSfWvwkdsX1z7HRNgiPtJGkgBB0cwT3oK/I1EHSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoNInXet/SF/XDDWcDAzOipleBp0RN+4LCu1mdZxWZm/j7yp3U6PFv0hUxTuwFiJF
	 URMUAt05RbHzhZSGjlFnOIxzIPJYXuG+xqaZu2ml1SryXrC2qynxiNHXo3lpLrhXqL
	 K1eEisRKtjhKQJ+BdYTZi7n7Vpnz5fgBbzZ+mZECZ6sHm00ZzoYvARQ3sWrQKubnZs
	 ZN3YWoKe3jiWuhjMXkxUr2QdNGQkTGPxMPfvOrKfufS7OaB0GktLdqkvhe259a/N3G
	 aRnwN/Ndl1aNAv6uyp2o0YPCZvcNJXGb93+4v3SQFJXTmEkSl227g6T1aO6GT/e2Tu
	 9Xwr42m7pUjVg==
Date: Fri, 27 Jun 2025 20:07:45 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: libwx: fix the incorrect display of the queue number
Message-ID: <20250627190745.GC1776@horms.kernel.org>
References: <7F26D304FEA08514+20250627080938.84883-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F26D304FEA08514+20250627080938.84883-1-jiawenwu@trustnetic.com>

On Fri, Jun 27, 2025 at 04:09:38PM +0800, Jiawen Wu wrote:
> When setting "ethtool -L eth0 combined 1", the number of RX/TX queue is
> changed to be 1. RSS is disabled at this moment, and the indices of FDIR
> have not be changed in wx_set_rss_queues(). So the combined count still
> shows the previous value. This issue was introduced when supporting
> FDIR. Fix it for those devices that support FDIR.
> 
> Fixes: 34744a7749b3 ("net: txgbe: add FDIR info to ethtool ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

I am assuming that this is for net.

Reviewed-by: Simon Horman <horms@kernel.org>

...

