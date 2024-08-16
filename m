Return-Path: <netdev+bounces-119313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C99955230
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A331F22542
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D31386C6;
	Fri, 16 Aug 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FhUrnLZL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B482488;
	Fri, 16 Aug 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842294; cv=none; b=H8wAlZ3BhF7vc6rTNo+C4TKKUiAlu8I7ELHlLtalfTmTKQaHjzKA4lJzUozvdGupksr9WAyYiVsf59RxLGBcsBjQFJihhhRhxLAqYVCss7NEPGh94M+fqW0eQRCNkeIpngdyqCHBcqhW52MsEHOG8YQYVNpfjBXwNRpNtV1npyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842294; c=relaxed/simple;
	bh=lIPl6mg4iSxAeM9Cffphu+kosAR6pV+zKre+ORdcLOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz7iODRS5oaNHiLQ4jZGeDBSbjAwrZ3qyANJmkQfaP9FcXPNign7JWAjoY3AW9QsRsiyNlKAnG8owSsrA2ezWpuqO13B5SeXD6LhtUGTxmPjRw3k1l0lBNQPAFUPml2NiLHuBMve4D6yg1diIywPe0WuhRGeX/e+NLPJQaYs/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FhUrnLZL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gH/TATT1pUnq9TeLpMZd1I83/KKpMcKp23KQ5KwZ9l4=; b=FhUrnLZLEN22xNPr2B5D4QhaL+
	orMMoaIMyPcZWyVgwA9I6II6sOh//L7mPjw6dwOxXTFhHSfH1RWtmvJCtnecaSiEKjhnLzHchFQeT
	ETNbUwg3vQ38UbqmeRBnmVxkMl5qEWOv7Bd27tkMpyp1fNNLB6rqA3/TLiiaxMJ7K/hM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf47l-004xqk-MH; Fri, 16 Aug 2024 23:04:41 +0200
Date: Fri, 16 Aug 2024 23:04:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, jdamato@fastly.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 net-next 03/11] net: hibmcge: Add mdio and
 hardware configuration supported in this module
Message-ID: <7bab865c-b5f6-4319-ba0f-1d0ddc09f9cd@lunn.ch>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
 <20240813135640.1694993-4-shaojijie@huawei.com>
 <79122634-093b-44a3-bbcd-479d6692affc@lunn.ch>
 <1ff7ba7c-3a25-46b5-a9de-a49d96926e64@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff7ba7c-3a25-46b5-a9de-a49d96926e64@huawei.com>

On Fri, Aug 16, 2024 at 02:10:36PM +0800, Jijie Shao wrote:
> 
> on 2024/8/16 10:25, Andrew Lunn wrote:
> > > +struct hbg_mdio_command {
> > > +	union {
> > > +		struct {
> > > +			u32 mdio_devad : 5;
> > > +			u32 mdio_prtad :5;
> > > +			u32 mdio_op : 2;
> > > +			u32 mdio_st : 2;
> > > +			u32 mdio_start : 1;
> > > +			u32 mdio_clk_sel : 1;
> > > +			u32 mdio_auto_scan : 1;
> > > +			u32 mdio_clk_sel_exp : 1;
> > > +			u32 rev : 14;
> > > +		};
> > > +		u32 bits;
> > > +	};
> > > +};
> > This is generally not the way to do this. Please look at the macros in
> > include/linux/bitfield.h. FIELD_PREP, GENMASK, BIT, FIELD_GET
> > etc. These are guaranteed to work for both big and little endian, and
> > you avoid issues where the compiler decides to add padding in your
> > bitfields.
> > 
> > 	Andrew
> 
> Thanks, I already know about macros like FIELD_PREP or FIELD_GET.
> and these macros are already used in parts of this patch set.
> 
> But I think this writing style in here very convenient.
> Although padding needs to be added during definition,
> but you can use command.mdio_start or command->mdio_start
> to access specific bitfields.
> 
> Although FIELD_PREP/FIELD_GET is convenient,
> But it also needs to define the mask using BIT or GENMASK,
> and the mask can only be a static constant,
> which makes it difficult to use sometimes.

Have a look around. How many drivers use this sort of union? How many
use bitfield.h. There is a reason the union is not used. I suspect
there is nothing in the C standard which guarantees it works.

      Andrew

