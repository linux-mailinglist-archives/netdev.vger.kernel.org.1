Return-Path: <netdev+bounces-148686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259E9E2D97
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276352824B1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDA205AB3;
	Tue,  3 Dec 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZeGT8IMt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC81D79A0;
	Tue,  3 Dec 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259169; cv=none; b=MpnSJXNSsvmYYwYdSmI9ZiZTWSMPjLD1pSxO8i6TvugE1+tqi2eZVNN3CQkCCNXFyX/broJVG0H4c1biNmeN8bchmAzhgCcrkZBJAAWRWA17VFy7xUt/KcGIxnVj9XSMlouyvwQWWwI+Uxle6NZVv6jjnPIcZHBlfT7UaQdyRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259169; c=relaxed/simple;
	bh=ED0+PSaCuSXyiar/EpUFwUujyMhuxfCj0XACF8H7dpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG5zN1pbApQEgQG9aeB1aw8DLxltUYnXL/pjyCWQCDO7C7Krq9yyLfTbY0QVYS5QuEBKebw7hTrSOr0KH94GTaSv3MhTM0azfPx/3suZigD1khFG8U9lexiHK6mkdzPOIF5xeDQIL3uQoaJ8yEGihfOnlRYqT5BNUfbgJkPaw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZeGT8IMt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UgFLcq8fF6gfgG8K7ATQxmd3PJFQdx5aoMrRZH/iNfE=; b=ZeGT8IMtbWcGE6BnHlC/y0vgoi
	W2fyQNgRV2gp5GYOAPTzMRgoYpC6+h/ZbNdh3MxKokTkOvOq0zbLYAKG1o4fbgzPaNUFz4bpZUebt
	TlqUObNjF+bAddGVF6K+uf9mqQM3b+wB3S5a+EctkIcFHlNIQQbOWyrZ310H6NOdkGyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZsu-00F8MR-8L; Tue, 03 Dec 2024 21:52:40 +0100
Date: Tue, 3 Dec 2024 21:52:40 +0100
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
Subject: Re: [PATCH V4 RESEND net-next 7/7] net: hibmcge: Add nway_reset
 supported in this module
Message-ID: <34df770b-279e-4ade-ac0c-80b8901f57ee@lunn.ch>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203150131.3139399-8-shaojijie@huawei.com>

On Tue, Dec 03, 2024 at 11:01:31PM +0800, Jijie Shao wrote:
> Add nway_reset supported in this module
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

