Return-Path: <netdev+bounces-178887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01FA79588
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557123B33DB
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DEB1DDC00;
	Wed,  2 Apr 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTQ6rRu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F518A93F;
	Wed,  2 Apr 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620251; cv=none; b=J9HadfFghFnl+5uN8dFFfAVPxT2TcYrOGpPa0Iq6pFtwYgsfYh4o9/TE3cdX1WIlwXD8B5/D7Nlx3yLOfxZmHFUPWdS1WG/TfKkCt7/PKoiftMmZGB4nsq5qABz5025BUQxYDehfpAyh8JTVaqjQcyVtLWg6YnrzWp3KiEA5Nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620251; c=relaxed/simple;
	bh=QYO5vO48oo4afZX4D+kG5+xVtjjwgmVsgq/UwkHh+Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC6F5FLdRiEw8xyXAl9sXwaFarHzMKe1BLi0ND5gRgsPQbapC34Vf4YMttEZgEBUuxiO0pDcHIuSCo4UxAQIF+URGPvHM1yt64dkCCRnrrj6/NBP/JAyiQ6I7mlXIR5WUFj8TeU2kTMxmZdSlrB1cGAaF86EiORfLeui/qhUKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTQ6rRu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F57C4CEDD;
	Wed,  2 Apr 2025 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743620251;
	bh=QYO5vO48oo4afZX4D+kG5+xVtjjwgmVsgq/UwkHh+Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTQ6rRu1Zl7hFgC/KFYwqPWboUwB83tHgGYLmk3JJor2ThBw3kcHrVYzKZJzDPECJ
	 ilq/cWf1dnKl69Bg25hzTe2/cs9JeBcwgnQ+F6FZ4oth21fwRZwE3i7Fq9aYGQD7lB
	 jlj93AcOMwq4zYjIgtkS+ovBT94b9nAaA0MKu3yZVgZGB9QYXMcUV3WrYG74F48O10
	 uOXW2L1IupIclS6gyUuSnIs//wLbR0+kRXJ+jf8SbRG/Y334U5Z5G7yFV9iJl6w8F4
	 hoXP3WYRbQtVLH71H69A0PClFXScOG9ImITx5N/9Hd72vZC1w+qlyVfHuITiBSwhew
	 nRzGTVboBuoAQ==
Date: Wed, 2 Apr 2025 19:57:26 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/7] net: hibmcge: fix the share of irq statistics
 among different network ports issue
Message-ID: <20250402185726.GW214849@horms.kernel.org>
References: <20250402133905.895421-1-shaojijie@huawei.com>
 <20250402133905.895421-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402133905.895421-4-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 09:39:01PM +0800, Jijie Shao wrote:
> hbg_irqs is a global array which contains irq statistics.
> However, the irq statistics of different network ports
> point to the same global array. As a result, the statistics are incorrect.
> 
> This patch allocates a statistics array for each network port
> to prevent the statistics of different network ports
> from affecting each other.
> 
> irq statistics are removed from hbg_irq_info. Therefore,
> all data in hbg_irq_info remains unchanged. Therefore,
> the input parameter of some functions is changed to const.
> 
> Fixes: 4d089035fa19 ("net: hibmcge: Add interrupt supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


