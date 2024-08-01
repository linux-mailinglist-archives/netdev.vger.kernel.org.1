Return-Path: <netdev+bounces-114929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B400944B40
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DDF28522E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06F1A01B9;
	Thu,  1 Aug 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mi560tEj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3F18950D;
	Thu,  1 Aug 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515226; cv=none; b=NR/xlcZNrS1UR80k8GF2uG7gfTvzrNOIbRW9pB8ne82B8vTIuLczplpfhCpr+M0YozlYxP1YccnUC8ycAulZS8E+fqXus6vhj/LtVZblC4qk+NgrgegrDee/BGMWqNP8PaSn0rYVndMb0nQW3AY+yhqpI0Cqnd9JY8LPTGtfg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515226; c=relaxed/simple;
	bh=mhZTIzPPGSVg8xR2fPDWbNDYLA1pKJOKdUzhAdIMMPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GESh7V+rVQ0Zc8YqznmNDtrOImGm+qIZuw+qU0CjkLaWGppP2pA+FDEnAI7DBaMQJd7NUU2e0HH3c8M2raYRSLRBlWa8Vh0UkVXYa9LrXnDpuTKWYQw5r9TghddhQypwt0Pv+25809yTDiuQ76PY1wmQR0+Jv1rnXQbf7ZiykAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mi560tEj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uFT718APO6F3v1BZlCEjnLz6LfcNBZUUyqBQTFVpYHk=; b=Mi560tEjjru7xoD/nC9LGpedyX
	5MF3iZBHnhlbJbzmApDDbkdO1hW0upqNBC+Lv2F/X8eJr5aZbD8H5mRzcJzce+XuB5SqwQozkvBmw
	iJaPW/8B2T636CakzykvlA4bEcltKH4yAng2ltaeWgJVSZ4aBGbLYbUcAV3OYhrE0vg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZUtT-003ly3-Gm; Thu, 01 Aug 2024 14:26:55 +0200
Date: Thu, 1 Aug 2024 14:26:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 08/10] net: hibmcge: Implement workqueue and
 some ethtool_ops functions
Message-ID: <f54fcc51-3a38-49b6-be14-24a7cdcfdada@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-9-shaojijie@huawei.com>
 <b20b5d68-2dab-403c-b37b-084218e001bc@lunn.ch>
 <c44a5759-855a-4a8c-a4d3-d37e16fdebdc@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44a5759-855a-4a8c-a4d3-d37e16fdebdc@huawei.com>

> > Why do you need this? phylib will poll the PHY once per second and
> > call the adjust_link callback whenever the link changes state.
> 
> However, we hope that the network port can be linked only when
> the PHY and MAC are linked.
> The adjust_link callback can ensure that the PHY status is normal,
> but cannot ensure that the MAC address is linked.

So why would the SGMII link be down? My experience with SGMII is that
the link comes up as soon as both ends have power. You are also not
using in-band signalling, you configure the MAC based on the
adjust_link callback.

Basically, whenever you do something which no other driver does, you
need to explain why. Do you see any other MAC driver using SGMII doing
this?

	Andrew

