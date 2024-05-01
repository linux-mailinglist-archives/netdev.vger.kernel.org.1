Return-Path: <netdev+bounces-92798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9C08B8E1B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580A51C20E19
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E43212FF7E;
	Wed,  1 May 2024 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MW0hfKb5"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5553368;
	Wed,  1 May 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580442; cv=none; b=aQvTBDC+TCIpqU94VJFqtagXsIi8DSdzdtU5+ZPE48cCqbPSHSvrp8sFcHERoRFmTuDs/DnsBnp5uau6GQzruJWt1sHpPk6pWLiRcZJOaNncIjvtMO+SNclEQHD7p4Ql6frzYT6seObIzffDXGn18SeRIBbtdr0pFdA2VCM+edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580442; c=relaxed/simple;
	bh=aZNcstz5TBxo+7M7A4J8BxMJ0DLGaT9dj0p3s/4FNPk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=MB7jIWGTdtg6DFdhRQjZSZZwntDPdP8YiVQRsd9VXLyocfsk2uGK1qbJ7o2k74bG7Hgf9LYl//CO2hdDQZOrBLyBBAZr6DfIvPOXoaWqBX4YGtzpWgxHsNYFOkijmdJireWWbZALxsOV7dLyrSn0FvIEhXap/xLa5/hVAASXAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MW0hfKb5; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714580436; h=Message-ID:Subject:Date:From:To;
	bh=LdU5Mtmhz1JVgGDzcEcbbmWJA6Ubb0BUWuMIm7lrfYQ=;
	b=MW0hfKb5XC6vYes7kbtInb4+HXWj3A5BelPVzpL0umwkZAipGmcq96AHpxwVwwaijHJVZLlCyZtZfAVNlAPhiLlITPNGt3Aqo0aNcyjJ6P03c2RUR3Zknzv54fP1uSNogCUo4bP3+HLbs2zjpJey43nO42AXBEIGkJzM5FYKRsA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W5f2lZW_1714580432;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5f2lZW_1714580432)
          by smtp.aliyun-inc.com;
          Thu, 02 May 2024 00:20:33 +0800
Message-ID: <1714580352.6371188-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
Date: Thu, 2 May 2024 00:19:12 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
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
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
 <202405011004.Rkw6IrSl-lkp@intel.com>
 <1714538736.2472136-1-hengqi@linux.alibaba.com>
 <20240501074420.1b5e5e69@kernel.org>
 <1714576307.2126026-2-hengqi@linux.alibaba.com>
 <20240501114754-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240501114754-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 1 May 2024 11:48:23 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, May 01, 2024 at 11:11:47PM +0800, Heng Qi wrote:
> > On Wed, 1 May 2024 07:44:20 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Wed, 1 May 2024 12:45:36 +0800 Heng Qi wrote:
> > > > >    net/ethtool/coalesce.c: At top level:  
> > > >  [...]  
> > > > >      446 | static int ethnl_update_profile(struct net_device *dev,
> > > > >          |            ^~~~~~~~~~~~~~~~~~~~  
> > > >  [...]  
> > > > >      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> > > > >          |            ^~~~~~~~~~~~~~~~~~~~
> > > > >   
> > > > 
> > > > This is a known minor issue, to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
> > > > mentioned in v10. Since the calls of ethnl_update_profile() and
> > > > coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
> > > > true, the robot's warning can be ignored the code is safe.
> > > > 
> > > > All NIPA test cases running on my local pass successfully on V11.
> > > > 
> > > > Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
> > > > up to Kuba (and others). :)
> > > 
> > > You should remove the ifdef around the member in struct net_device.
> > > It's too much code complication to save one pointer in the struct.
> > 
> > Makes sense.
> > 
> > Thanks.
> 
> if you really want to you can add a comment
>  /* only used if IS_ENABLED(CONFIG_DIMLIB) */
> 

Ok, I'll add this.

Thanks.


