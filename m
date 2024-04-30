Return-Path: <netdev+bounces-92321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909F48B6993
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 06:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF3A1C21BB2
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE25D518;
	Tue, 30 Apr 2024 04:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iemwYYUw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D9D531;
	Tue, 30 Apr 2024 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452290; cv=none; b=JTpQfLPYFVFJZKiFQhp486HwvewvIwzubAiPeCO++tI9O9ws8LCG93UoODAGAE+cQN5YinRsf8sCwTIOJ65VPz+hAwUATh1ZU9u8NZ2QDDzrtQtXX3gIhEHwVuNsakvOT8TFVm6x2HJlvPTA9FYv23Pdu9JPO+9tJ3FJ0qRGirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452290; c=relaxed/simple;
	bh=vamxvV7ssmaZu1dRJfLYlSmXr+Xcmz3LVM+j0QFADm0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=rYgGHXcLax2oHrhn76iD94G+xYKcs2Bvfi+t7eKRrwo9D0wBXlgL37KCZBuXHObAsG7zTQMkQvP0QyRIhCpP6MG6eV+f+GT/S1gBUDqMqygUt4zoNXxBHO8d5Z1A6FPsIQQisq+MRB/DM552PfY/d/XLhNsa3h8++jUVd4t49cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iemwYYUw; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714452284; h=Message-ID:Subject:Date:From:To;
	bh=lLWhA6INtv3AySColRQE0PHFqgvrCTu7nUANAMJDBYk=;
	b=iemwYYUwqa1JciEPf2lsLJxSPPTMv0n0saKLqCrLfmdNGNlvQDIvtDcMR8LeyGOATFvzTTSMWIPVN8E0cJ1CD6tcie9Wv86y45nB9bZVoNWj3lemWVz2NuCws+R+muOqYPVrzE8DzwN+/bmFc3mD5HTsmJ3pnhWQMniknDn9Mak=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5b5FBG_1714452281;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5b5FBG_1714452281)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 12:44:42 +0800
Message-ID: <1714452238.254616-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 2/4] ethtool: provide customized dim profile management
Date: Tue, 30 Apr 2024 12:43:58 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S .   Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric   Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S   . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh   Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal   Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul   Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "justinstitt @   google . com" <justinstitt@google.com>
References: <20240425165948.111269-1-hengqi@linux.alibaba.com>
 <20240425165948.111269-3-hengqi@linux.alibaba.com>
 <20240426183333.257ccae5@kernel.org>
 <98ea9d4d-1a90-45b9-a4e0-6941969295be@linux.alibaba.com>
 <20240429104741.3a628fe6@kernel.org>
 <1714442379.4695537-1-hengqi@linux.alibaba.com>
 <20240429201300.0760b6d6@kernel.org>
In-Reply-To: <20240429201300.0760b6d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 29 Apr 2024 20:13:00 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 30 Apr 2024 09:59:39 +0800 Heng Qi wrote:
> > + if (moder[ETHTOOL_A_IRQ_MODERATION_USEC]) {
> > + 	if (irq_moder->coal_flags & DIM_COALESCE_USEC)
> > + 		new_profile[i].usec =
> > + 			nla_get_u32(moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
> > + 	else
> > + 		return -EOPNOTSUPP;
> > + }
> 
> Almost, the extack should still be there on error:
> 
> + if (moder[ETHTOOL_A_IRQ_MODERATION_USEC])
> + 	if (irq_moder->coal_flags & DIM_COALESCE_USEC) {
> + 		new_profile[i].usec =
> + 			nla_get_u32(moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
> + 	} else {
> +		NL_SET_BAD_ATTR(extack, moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
> + 		return -EOPNOTSUPP;
> + 	}
> 

Sure, thanks!

