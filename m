Return-Path: <netdev+bounces-105557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50685911BD0
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CF1C22D67
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45DF1422D6;
	Fri, 21 Jun 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HDw5sRv7"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78E39FD0;
	Fri, 21 Jun 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951591; cv=none; b=VVWQACB2nscMIXZicjZu4X/CnlNnX37x+lgErZ4zM3uBrysDTswSFh2edfObEI+u8I+XN4SUEkU/PVNyDSk3yMesFEDbNa2BJYxy6Y+ht6sO0AKUSAyvKBqYFHPD0U6aJchbAedSRvKY1mp7CmN7wqKRngDlZ70LF9eGKXwJoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951591; c=relaxed/simple;
	bh=4pzyRHT73Q7GiPsI890QMwhId8ur1gzjRUjj9cW5f74=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=n+3BrZEQA0M6IHwa9VFvDmERKDh1Ibd7d6R5ck7XV5c+l4LzyQ7mqeJ9GViBRZ6EmliRg/RbCRWFA4A8zMWwnlFN+cksv0OYK0y4Q5TaA8XLqJFlgBR7pm1fLsxrh78gzOrsw7Aq5TFg8wLjO3TQT67C7oZY0huJdC/1SooaR4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HDw5sRv7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718951584; h=Message-ID:Subject:Date:From:To;
	bh=HQzBAHQmzzdOD9opnF/vKbMd3fqbLQ9N71S3Ajm7tHA=;
	b=HDw5sRv7nKaqBL0XKUDQRVH2cs4RuPAz30yxX1GNqLZOvV1wImY+16e7EFCcwBpUbdVyuU/AgW1Cc1GGUCeQhT+aGhn/alsxvvK4eRHyYHH1w0IMOVCC4DD9qXny5nkBkCW6uCSSgbUoJ2+Gk8u+g5YoExz545uOKMHoJDWA5kw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W8vIaOZ_1718951582;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8vIaOZ_1718951582)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 14:33:02 +0800
Message-ID: <1718951303.3419425-15-hengqi@linux.alibaba.com>
Subject: Re: [PATCH RESEND net-next v14 3/5] ethtool: provide customized dim profile management
Date: Fri, 21 Jun 2024 14:28:23 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 donald.hunter@gmail.com,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 awel Dembicki <paweldembicki@gmail.com>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240618025644.25754-4-hengqi@linux.alibaba.com>
 <20240620203918.407185c9@kernel.org>
In-Reply-To: <20240620203918.407185c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 20:39:18 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 18 Jun 2024 10:56:42 +0800 Heng Qi wrote:
> > +	if (dev->irq_moder && dev->irq_moder->profile_flags & DIM_PROFILE_RX) {
> > +		ret = ethnl_update_profile(dev, &dev->irq_moder->rx_profile,
> > +					   tb[ETHTOOL_A_COALESCE_RX_PROFILE],
> > +					   info->extack);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	if (dev->irq_moder && dev->irq_moder->profile_flags & DIM_PROFILE_TX) {
> > +		ret = ethnl_update_profile(dev, &dev->irq_moder->tx_profile,
> > +					   tb[ETHTOOL_A_COALESCE_TX_PROFILE],
> > +					   info->extack);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> 
> One last thing - you're missing updating the &mod bit.
> When any of the settings were change mod should be set
> to true so that we send a notification to user space,
> that the settings have been modified.

Oh, I didn't modify the mod bit in the past because the profile list
modification does not require the dual_change behavior, ignoring the
passing of ret = 0/1. Will modify.

Thanks.


