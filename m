Return-Path: <netdev+bounces-80032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279B87C9B3
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 09:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC5E28305F
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3391214F65;
	Fri, 15 Mar 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fYXNmJWp"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0A14AB0;
	Fri, 15 Mar 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490261; cv=none; b=qunWe0S0Zg/4EP//ZnB5vOGVYgbdPJbEPExFNTrtZlL9HcP6K8qkqMRt2tSMEzgCFVV4/sNqfYVQZwUHuj9iSmVQq+wB8guVgRlZL2N7ShrkHxU3yzSpLCWYsO6vVobxCBHtjFIYVvZxW0zwEj5w3HAhDA5w4R5YZvybI2TSdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490261; c=relaxed/simple;
	bh=hf/7tzQiNSvYmFuA/yKuj1fm3A4gA/3hedPkcZLXEe8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=s1rHiBAE+85F5eToewKL2888iklYXW8jvYRSARhFeDIfFmU24wGMyL0P5neKNSumv0+InVwNIkq9nMTBW98yn0yuWqlCLi778N2d8yaZI2K17OAOBWqOMFGDG5U/IO9tCCfrkW19pzbkWCD8ZOh9PwoCDFzIJruw6syehdi2tv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fYXNmJWp; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710490251; h=Message-ID:Subject:Date:From:To;
	bh=hf/7tzQiNSvYmFuA/yKuj1fm3A4gA/3hedPkcZLXEe8=;
	b=fYXNmJWplcKF5W2UnPUwG8wBfUOtbby51EA29jlCTX4AUdPfQvQZX+jYjlycW3ntVgfyX7P4eHccM7eVAkx4Wa+5sooe1KEWSKdOPOmP9Eitntb/MkNR8QfV7i0JMB/WeaUp5KhIA5YSHPaj6SWGXjEXNRINsieTWZhNxICvtKo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2ViqTo_1710490249;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2ViqTo_1710490249)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:10:50 +0800
Message-ID: <1710489940.1772969-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 3/8] virtio_net: support device stats
Date: Fri, 15 Mar 2024 16:05:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha  Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
 <20240314085459.115933-4-xuanzhuo@linux.alibaba.com>
 <20240314155425.74b8c601@kernel.org>
In-Reply-To: <20240314155425.74b8c601@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 14 Mar 2024 15:54:25 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 14 Mar 2024 16:54:54 +0800 Xuan Zhuo wrote:
> > make virtio-net support getting the stats from the device by ethtool -S
> > <eth0>.
> >
> > Due to the numerous descriptors stats, an organization method is
> > required. For this purpose, I have introduced the "virtnet_stats_map".
> > Utilizing this array simplifies coding tasks such as generating field
> > names, calculating buffer sizes for requests and responses, and parsing
> > replies from the device. By iterating over the "virtnet_stats_map,"
> > these operations become more streamlined and efficient.
>
> Don't duplicate the stats which get reported via the netlink API in
> ethtool. Similar story to the rtnl stats:
>
> https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors

Sorry, this patch set did not follow this.

I will fix in next version.

But I plan that will be done in the commit "virtio-net: support queue stat".
This commit in next version will report all stat by ethtool -S.
The commit "virtio-net: support queue stat" in next version
will not report the duplicate the stats that reported via the netlink API.

Do you think ok?

Thanks.








