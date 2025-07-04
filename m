Return-Path: <netdev+bounces-204197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1EAF9763
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566BE5A4C7B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA4C3074BD;
	Fri,  4 Jul 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9yZRXm0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456F7E0E8;
	Fri,  4 Jul 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644546; cv=none; b=nZ+Ax+O8IxnZZ0g/6OtgioiZTzZjwyWjXRNVXk1LqTzODtva1LRV+HRuiY9BTCxoaYc+dGdVY1wSrkRNJPnyIFM0eDCcPtz5//czXpREyW08FwNkBusAbVbgw2Mc64Uf683za8KUaR/Ra2b6ySje54DjQHPp8l3HxVIagattNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644546; c=relaxed/simple;
	bh=kB7YCMAGOnOlfWkjkQ75i28xx1JJ+6zUBbOj2bze9lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqIRrC1xIAsx5SCWPMmH9YSrTGISOPpMTqBah/Os5DJ/ZJlns8RnZuYB6HYaoHVuycALxf2Rsptp2bBlcdJIIaHwYY+3xWkQyYpqkkS7bvRCURI2AvNcvNIDTcPV2iC5N5toHkqYlJxAoeps5ZTOXmDTWtaMk/8w/5n7NdWvYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9yZRXm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5E6C4CEE3;
	Fri,  4 Jul 2025 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751644545;
	bh=kB7YCMAGOnOlfWkjkQ75i28xx1JJ+6zUBbOj2bze9lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9yZRXm0qnN7DyPM4VGwDp0LNtwV1GXbJIDJD4Uoeda9noMzb/NFJ+oRyamRcI6Oy
	 Zk57z0rhfg/Cfr13pEl6jTs8+eL49df0lI5rIotXjLQ3/CJZZKFl2gC/WwFW5miRUh
	 SsMSmil0mPDrCwDPPDmvLrknIp08ujR5rH1IJYaRNJbuUABNygT1tozP3sQSvYvh/Z
	 hV45LTTLIIefdHEOSzWehLB3JH+FKeGPdA9jAkOh1G68pl+u6La3cgCOOS/7c+F/vz
	 vzhW/MoD6yEvhAAhxgwq5HzTyE89hXzdHi7GZ2JZ65DXTzK2PgkoRXpfLr/56XQGZz
	 V2qRrG7Py2SPg==
Date: Fri, 4 Jul 2025 16:55:39 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/4] net: hns3: disable interrupt when ptp init failed
Message-ID: <20250704155539.GG41770@horms.kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702130901.2879031-3-shaojijie@huawei.com>

On Wed, Jul 02, 2025 at 09:08:59PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> When ptp init failed, we'd better disable the interrupt and clear the
> flag, to avoid early report interrupt at next probe.
> 
> Fixes: 0bf5eb788512 ("net: hns3: add support for PTP")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


