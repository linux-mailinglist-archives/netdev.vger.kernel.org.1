Return-Path: <netdev+bounces-171610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7EA4DCDD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A67A7A5D05
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1C1FBC9B;
	Tue,  4 Mar 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j415LynE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7C1F193D;
	Tue,  4 Mar 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088772; cv=none; b=gqlofmdoPYxDS6lBbXXIww6EPBqP4cxReNOrvciqL2OTvPb04bs7UDHj+jSIJ2nv4MzIEXxVJ/DnV+bD3L5Kh96Sv5euwQ1H1lbauLWKgHo9bcXNd3yqE0XWgT30YNLDuBRFYU2aH6BK5a9RaBr/Xbq81xZlEybrW++6OlAFdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088772; c=relaxed/simple;
	bh=5y3AT23ebdCmJk0btj891bMWItHXaFcvxFbbOso/Wek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d18hHEKqhmZ6Gytos+euzwPovev7bVumvmAMLde4liy+QXfcBvn+n60yfyC97uArlu1sZqkp4kJW6An4CwkglBJpX+Q42si5A86ZqxQI8jhfPgioKfzlavSYYdON9HS1MoB0MdzNTQ1TYsUUw2fEZitq4AdJ0n9zskkAORB8pLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j415LynE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD207C4CEE5;
	Tue,  4 Mar 2025 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088771;
	bh=5y3AT23ebdCmJk0btj891bMWItHXaFcvxFbbOso/Wek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j415LynE3XvROLsaZHycED6qlb6CjtjfZbQWx4BtYMVBJ0oVwD3EsSzIxTPN6Ei/9
	 yux6g7RAqXrY4NL0hMC+BqxQpFGvqGrWh6P9qa+bJTsl/3kHkWQ9q5+n/Ec82VLe3t
	 1F9hS4L0pHgFu6g6nxtZRN3+bKAfqM5xCffSAXDSOypLMagG0aQu4E0qSEQS7Pbc9t
	 Vqkhv0cyQUqcBXTChTopwP4J++mb+MOdvkuyhplOHlp7lKWLNF7RgMl72EvoSgNVNv
	 vcVYUzmiCGPlbKa70NIqKxvdxUloQ4PEwgufvZsklGzwMl6a1JwXMOPhufi08vSM5m
	 M1UBJardsUmkA==
Date: Tue, 4 Mar 2025 11:46:06 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: make sure ptp clock is unregister and
 freed if hclge_ptp_get_cycle returns an error
Message-ID: <20250304114606.GA3666230@kernel.org>
References: <20250228105258.1243461-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228105258.1243461-1-shaojijie@huawei.com>

On Fri, Feb 28, 2025 at 06:52:58PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> During the initialization of ptp, hclge_ptp_get_cycle might return an error
> and returned directly without unregister clock and free it. To avoid that,
> call hclge_ptp_destroy_clock to unregist and free clock if
> hclge_ptp_get_cycle failed.
> 
> Fixes: 8373cd38a888 ("net: hns3: change the method of obtaining default ptp cycle")
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


