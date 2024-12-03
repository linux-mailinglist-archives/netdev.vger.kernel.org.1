Return-Path: <netdev+bounces-148678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332499E2D8C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE09165D53
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86C207A0A;
	Tue,  3 Dec 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cOT0v3jQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5B2500D3;
	Tue,  3 Dec 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259019; cv=none; b=XJLap6wLviL6KyrJL+BMU8WKQPt8tBF20mmlrYUxOec01lU59Pm1H7xb2d8yzLHYSQQlQr/81RJGwy9w3mjwktDLoajfngXMKq2qKB8aCJ8t23mRX3qlQPHTffPD2DJTssy6eieGl1p1NIJI5WSqZT0e6VGEJnchuGdpEaw2QTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259019; c=relaxed/simple;
	bh=7+j9DnxUn70DjqRYTpQY7FOv8r8Y8PsV/D9Pa6QJk64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyCtvhNG4C9anyna7qDAjOfDxncg6TMuym+OyoHKFF+ARJF8unarJLYooW1FTD3jBh+uQ9Nhu8E22GA/3pOl9FIvpRaQRUYrQN9CsM8igBKRYITeC/wkz8KjKRlcZ0pHVDeOwbz6+6jkq5BakhSrnaRGQZtcE+d0HoOfh9aPHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cOT0v3jQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8CtVo84DNVMA9mDCGRA2D9tpJTeTMoet2o2LaezMPZw=; b=cOT0v3jQ2qHR0hdaQjzATRtOwa
	3koVRXGHJ78hiE9Ehp4CKi4rF8afZrR9HqkTtXrUL70OnF9MHO8hNYPkvHzl+70lNcWQjboCVrM4N
	RtR4FzPtrLfW1e1ORWEsIvhafwWl40rOIxFSQaS1wqgre1dKLqOh5fvcX4qWyRjCtnik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZqT-00F8JK-Tz; Tue, 03 Dec 2024 21:50:09 +0100
Date: Tue, 3 Dec 2024 21:50:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hkelam@marvell.com
Subject: Re: [PATCH V4 RESEND net-next 5/7] net: hibmcge: Add pauseparam
 supported in this module
Message-ID: <ec478652-0400-403c-bac5-308809f840fa@lunn.ch>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203150131.3139399-6-shaojijie@huawei.com>

On Tue, Dec 03, 2024 at 11:01:29PM +0800, Jijie Shao wrote:
> The MAC can automatically send or respond to pause frames.
> This patch supports the function of enabling pause frames
> by using ethtool.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

