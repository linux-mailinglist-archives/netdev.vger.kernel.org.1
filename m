Return-Path: <netdev+bounces-121111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD52095BB89
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B81B2BCFA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484C1CDA08;
	Thu, 22 Aug 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zouydmzX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB61CB300;
	Thu, 22 Aug 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343275; cv=none; b=MGBxlt4Qth3nbGFRONz0PjbcOJkqw/X0wJJIUSWIbbdlnQO2sckBGGzKk3JxuPhOtnjNTJqEGbouyFLHu5mvlpXqJVUzdNguV2qfT2Tun7kjNuvfUAwH5ZdXeKtuFfM3xQBDWiLFYFOxegZsr0RvCuxje7rdavSF/VbG3es7um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343275; c=relaxed/simple;
	bh=9kkHtI0PCQ2/rdPadgf2UepaKphOiHBsQNreBiz6NXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJZzRUkCec5NzQ+QW0NoyXW7/SF1Df8AX6BH75tLrcNYLC9lStpsrBPU2N6DGEHyk040WcxZQqy3FSOAtqk24qezZIvOJWRgg6KWoXwYvUwXC5rWvhs/aGAp9D+p4OvIz7YPgmUafflOL8Hxj58k9nAif519JdszrErscm4djqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zouydmzX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6hQT/A4EBbq/UzrZsywuDtivOUsNCTks8Oh43tzbCME=; b=zouydmzXOvtLUU5l8awBwarBy+
	LFmZ7hlUZo6C9P/XIFb5bszyZc7n9iS/thtMRY9w0m0WF3yCJe0mu2cdBe/z7i8rYfzLgCLC2+pgA
	zMW+tlgmaKNq+4wWWWZdYAI+rSrQCooit/MXCbUoRNMh+NiNdE4Y4QzXKPfHx4/seLDg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shAS8-005RyP-Mf; Thu, 22 Aug 2024 18:14:24 +0200
Date: Thu, 22 Aug 2024 18:14:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 11/11] net: add ndo_validate_addr check in
 dev_set_mac_address
Message-ID: <4cc7e36f-64ff-44d8-9412-73e4704b766d@lunn.ch>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
 <20240822093334.1687011-12-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822093334.1687011-12-shaojijie@huawei.com>

On Thu, Aug 22, 2024 at 05:33:34PM +0800, Jijie Shao wrote:
> If driver implements ndo_validate_addr,
> core should check the mac address before ndo_set_mac_address.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

