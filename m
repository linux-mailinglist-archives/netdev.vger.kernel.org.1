Return-Path: <netdev+bounces-80033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF787C9B7
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 09:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375AC2839E8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4EA168DE;
	Fri, 15 Mar 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="haheg2Ec"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9D14AB7;
	Fri, 15 Mar 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490270; cv=none; b=sxz0Nq3zEFUXA0SiUjGdQfRglICJcb/KvnrUdEpT8YqI4TFRvDridodFgjmiJiEf+ColXonnZQnRsdl8kTKsEAKLGmXcGEAa2aC8CbeiAoNC3bXTH35CWoGjADePUbN6aKpcWWB2IXOdXjaz4Cbxb3LF8KP2Mc0kUevs2KvbikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490270; c=relaxed/simple;
	bh=DRkkmD/QbTHhutIxMrgokTp3CCqI7QaR/h8T7hy55is=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=WxhR1H/fqZM4j2GK47q8VkNexW0ZLJD1Cq5ngxvIIkxR5otKZRTIUzyJcUDI0gdyWzjCQOFupIX5z6ZiI/2qo+Glj13pQElOi9YwvmykLhDLn0T0F9YwtEVDQRLyzN+kkopuRKSJ2wZqIxVjgmB5KF1/pdWlI6sjKvosj96wYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=haheg2Ec; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710490266; h=Message-ID:Subject:Date:From:To;
	bh=YPsibT017DvxyxoNSxNBbO0nrsAsyY5mHP0Y0p2jK9w=;
	b=haheg2Ec7oNb1oepTKjT3oUC+HkAWUl7G76h+oTbKVkk/MCbdh9SE1j9ldSsCCUOLYb857zw1xKmQ+m/0prCQ1MQQR02fLr0uqHs1qLWVxe30oQI5ryDd0uSvfnDU/4KCQysG3rcI9Tvgo0ELbauxEYpQCD2xqxQ1qF831y3gPg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2Vb0V3_1710490264;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2Vb0V3_1710490264)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:11:05 +0800
Message-ID: <1710490258.2804203-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 8/8] virtio-net: support queue stat
Date: Fri, 15 Mar 2024 16:10:58 +0800
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
 <20240314085459.115933-9-xuanzhuo@linux.alibaba.com>
 <20240314155616.107de7c3@kernel.org>
In-Reply-To: <20240314155616.107de7c3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 14 Mar 2024 15:56:16 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 14 Mar 2024 16:54:59 +0800 Xuan Zhuo wrote:
> > +static void virtnet_get_base_stats(struct net_device *dev,
> > +				   struct netdev_queue_stats_rx *rx,
> > +				   struct netdev_queue_stats_tx *tx)
> > +{
> > +	/* The queue stats of the virtio-net will not be reset. So here we
> > +	 * return 0.
> > +	 */
> > +	memset(rx, 0, sizeof(*rx));
> > +	memset(tx, 0, sizeof(*tx));
> > +}
>
> /**
>  * struct netdev_stat_ops - netdev ops for fine grained stats
>  * @get_queue_stats_rx:	get stats for a given Rx queue
>  * @get_queue_stats_tx:	get stats for a given Tx queue
>  * @get_base_stats:	get base stats (not belonging to any live instance)
>  *
>  * Query stats for a given object. The values of the statistics are undefined
>  * on entry (specifically they are *not* zero-initialized). Drivers should
>  * assign values only to the statistics they collect. Statistics which are not
>  * collected must be left undefined.                  ^^^^^^^^^^^^^^^^^^^^^^^^
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I see.

Thanks.

