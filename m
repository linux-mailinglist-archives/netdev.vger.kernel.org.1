Return-Path: <netdev+bounces-96242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387D8C4B20
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DC0B2210B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3312749C;
	Tue, 14 May 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G2IxTJcY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9C6FB9;
	Tue, 14 May 2024 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652930; cv=none; b=WTbpVsu0qos/I3K4IEPNC1NOoGtVOek+A+TqZNZ9KT6R69obW6vkaBMFitAfs26TUsUmdJKRRsEBYpr9PnDs8OIiOaIm215c8vbePuqDhY3WQils5VMSkKKJa90lqdcJPwxKtl9f5lwFrvfqAEyhlxkTegm1SgNUcJ2BbY16NiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652930; c=relaxed/simple;
	bh=z6Lm5ompKBHeHZuRba98YUM44pCmPMVjPqmvhRHI+r8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mKFKJ6Ajnvp5GI8EFEUYSLJUFTz3M0xeVOQyLfBvO64TvhsjftfyhBQPlc07EiWh0x0o77/8DQDZumxZtbOLwXtyD+ToAHXxTIRUSTIXwRDEqjulHoAHv72V7Aj0Zc4Zyk8frxQNMNNRXlfzE/IKGzneLgyxhfqPCKF8S+UFuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G2IxTJcY; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715652921; h=Message-ID:Subject:Date:From:To;
	bh=iPnEEWKQuTa1Y1rNnIiTQTNWYIOeu95k7A0SXh7Y2lk=;
	b=G2IxTJcYjZYBofcRQ6AANchYZ12tHWb21D9aX3eLHfVI3/7GsaiwdPGDh/R6/YTZWgctl6NfjINiKtaBsGMmnMOhY4tkyjlaNOH6mabLjFexMRv187IF7xn8ZTi8C91Hk9ziFX4jMepIMhuGwyNPnHvqjA5fNEX+rjpwtxtRwJc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0W6TQv3T_1715652917;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6TQv3T_1715652917)
          by smtp.aliyun-inc.com;
          Tue, 14 May 2024 10:15:18 +0800
Message-ID: <1715652495.6335685-4-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim profile management
Date: Tue, 14 May 2024 10:08:15 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason    Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett    Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan    Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul    Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 donald.hunter@gmail.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240509044747.101237-1-hengqi@linux.alibaba.com>
 <20240509044747.101237-3-hengqi@linux.alibaba.com>
 <202405100654.5PbLQXnL-lkp@intel.com>
 <1715531818.6973832-3-hengqi@linux.alibaba.com>
 <20240513072249.7b0513b0@kernel.org>
 <1715611933.2264705-1-hengqi@linux.alibaba.com>
 <20240513082412.2a27f965@kernel.org>
 <1715614744.0497134-3-hengqi@linux.alibaba.com>
 <20240513114233.6eb8799e@kernel.org>
In-Reply-To: <20240513114233.6eb8799e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 13 May 2024 11:42:33 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 13 May 2024 23:39:04 +0800 Heng Qi wrote:
> >  config PROVE_LOCKING
> >         bool "Lock debugging: prove locking correctness"
> > -       depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
> > +       depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && NET
> 
> We can't make lockdep dependent on NET.
> People working on other subsystems should be able to use LOCKDEP 
> with minimal builds.


Got it. Then I declare "DIMLIB depends on NET" and clean up other places.

One more friendly request, I see net-next is closed today, but our downstream
kernel release deadline is 5.20, so I want to test and release the new v14 today,
is it ok?

Thanks!

