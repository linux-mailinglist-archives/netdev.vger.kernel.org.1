Return-Path: <netdev+bounces-178889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE0A79594
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E903B4582
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498E1A3156;
	Wed,  2 Apr 2025 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO/MaopO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79319258E;
	Wed,  2 Apr 2025 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620698; cv=none; b=kB1XFw7TQOCNUvbSgx11uCfo89iALvOb+6UYKl7L3NWQORnW7+vU/uyeHnpNqPSLjMF0GV5kLEAYJVNPH2GY7HKua3XxXqR3lzA3DecozpVOeH9nJ9gm5M/zv4u9cYp8aNOsW8aTRgC8BiGkDKNQdhvUTwDitFtnNRwPOnn7e/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620698; c=relaxed/simple;
	bh=kjF8ADr7pK1zHSxSI1eFu00gMpqScsM6AeClesUh1Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X336QnR7xY9JO/46c3q/q+hB6fVZcdm4A3vdlCUwon3SZNXhqNH0JYbchf93nE9MTv6T4C4/mZKz4Yn/1S2uQqr1FD/ko+s08EPo8wYtVyYJawgvt8NyvFVi87VyDLXQFnYPBXekgHSLWbJ9Ag9bR21aab2Rwxo9IzLfE6Wta0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO/MaopO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE857C4CEDD;
	Wed,  2 Apr 2025 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743620697;
	bh=kjF8ADr7pK1zHSxSI1eFu00gMpqScsM6AeClesUh1Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qO/MaopOr2XVA5QxHb0TgTkYP9UMmGAyZzviyd8cNr+8Jtlap/2s6rs4CNzNvC+f9
	 X30RLKgI4OAIGcROiXbADnRmvWpVw7yWHZGoAyorKyFKbIZO8oF3P+TWql56AIaFmm
	 G6vpEhqMzWkdbZH3GNgQYtnQ2cfolLNhgRnONuWPADoRnu25tBzOVGC2fbR2aIEMW6
	 NL2jNu6MyS/gz0nIsnNZqzCNEaYcQ5NocIQVpuULjmwwdmrNjb4nwT1Gy6xV/imiix
	 teAEfagVXKFy82wLbu7HfeHZ+bGuUrZYSDyzRGVrDvnUIW+C8u7h2BS/Dh3iUmVK9F
	 KxkrJOXKxacXA==
Date: Wed, 2 Apr 2025 20:04:52 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/7] net: hibmcge: fix the incorrect np_link fail
 state issue.
Message-ID: <20250402190452.GY214849@horms.kernel.org>
References: <20250402133905.895421-1-shaojijie@huawei.com>
 <20250402133905.895421-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402133905.895421-6-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 09:39:03PM +0800, Jijie Shao wrote:
> In the debugfs file, the driver displays the np_link fail state
> based on the HBG_NIC_STATE_NP_LINK_FAIL.
> 
> However, HBG_NIC_STATE_NP_LINK_FAIL is cleared in hbg_service_task()
> So, this value of np_link fail is always false.
> 
> This patch directly reads the related register to display the real state.
> 
> Fixes: e0306637e85d ("net: hibmcge: Add support for mac link exception handling feature")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


