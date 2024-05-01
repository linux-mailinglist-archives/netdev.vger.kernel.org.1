Return-Path: <netdev+bounces-92774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820958B8C85
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26951C21890
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCDB130A61;
	Wed,  1 May 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dMWtETRe"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD68130493;
	Wed,  1 May 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576412; cv=none; b=Xw9CJdepPrRbbwAbwmtrRVv/UthwgfQUL5x9bxosHZGwVGlXlXGtp2eBFvkAgxzfba8iW07L3MuO7FX2e1ylNfi/igTjo12R1AvqnB7oEKW7bjDpQW7LP7GL0IHfQ6halpWUwbPJbc9eHWXo9NxgtPm78J+JFItpGF0anJuzgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576412; c=relaxed/simple;
	bh=IhW6CILoVD5OQfZzI5w7otUMItBVOSdHMl/84FmuSy4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ouGrETYRKF2MSD+JpGJQiDe2XFzdipCvMUpycBRv2rIDzi2Km+ndsiNsAu3AMOTxc7eBbgaksPTS1Wo+wwhXmI/dUPswA4tEviq+ZXy9bm2Pk0WGNql4sQlttwZrIufBSRxSXCbmrRRcbbQcoqOjNMCriJ1gaKItA6Jqlq38Vbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dMWtETRe; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714576407; h=Message-ID:Subject:Date:From:To;
	bh=lBclA3zJaNSyXNr4Q/nKzIomxbyIyt9xMFyfv7GftGc=;
	b=dMWtETRenAsPF0EH7k0wbP6ylsyf1jzyBZFmSrXuZJ9ueiNWUwSCv3fvYIVGTFwb7MjD2JJnqVlKWog9pFoTdkN7VdgBjwvfrYkXIdq245LBltsCnWrLGwW11hL+GZeZ6R5QlxOsza1I3kiVM2xa/aebjkpzRV9p4AOGdODmWMs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W5f1kY1_1714576404;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5f1kY1_1714576404)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 23:13:25 +0800
Message-ID: <1714576307.2126026-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
Date: Wed, 1 May 2024 23:11:47 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev,
 "David  S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric  Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S  . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh  Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal  Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul  Greenwalt <paul.greenwalt@intel.com>,
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
In-Reply-To: <20240501074420.1b5e5e69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 1 May 2024 07:44:20 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 1 May 2024 12:45:36 +0800 Heng Qi wrote:
> > >    net/ethtool/coalesce.c: At top level:  
> >  [...]  
> > >      446 | static int ethnl_update_profile(struct net_device *dev,
> > >          |            ^~~~~~~~~~~~~~~~~~~~  
> >  [...]  
> > >      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> > >          |            ^~~~~~~~~~~~~~~~~~~~
> > >   
> > 
> > This is a known minor issue, to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
> > mentioned in v10. Since the calls of ethnl_update_profile() and
> > coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
> > true, the robot's warning can be ignored the code is safe.
> > 
> > All NIPA test cases running on my local pass successfully on V11.
> > 
> > Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
> > up to Kuba (and others). :)
> 
> You should remove the ifdef around the member in struct net_device.
> It's too much code complication to save one pointer in the struct.

Makes sense.

Thanks.

