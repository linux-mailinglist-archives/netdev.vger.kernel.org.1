Return-Path: <netdev+bounces-124886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B196B453
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40FC1C25EA8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F317BEC7;
	Wed,  4 Sep 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nd4iNw+M"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5E183CB7
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437693; cv=none; b=Kv92p+iqG5bZuEi3+KvnYx/gCLiMKcqpZ2+uwlQ+D9BsqR2AY9CH+xGA1CtaKB8mID9IcjKah+ORuKG8dH/rpOXAH5XARdvTBI2xEqQjasmbFnCtjvNOFOv8hF4g0bAxwHN9uelcGqBJkRVphOQrB+Xx1KcABurjcIvRQL+fycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437693; c=relaxed/simple;
	bh=uVsyEwe2BdaHXxSJNDFbbZlWT3GMOmjKl/Yqc5RpyBg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EQY9yJdm4wcbyxTLl0eeqd/rT8/D/PXImHjXw/7jenv2vbm5ofLwV2l0fCW3q1TAhE2Pn2MANBvabNeiuLsGNB/WYu/3ueE6jxnAMV9klHtoVB3lp7r8qJAZpusGyZiMmAqZpU7EiM1g4GPi6CS2E4ccwKiknLkBjwXzhPBKxSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nd4iNw+M; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725437682; h=Message-ID:Subject:Date:From:To;
	bh=uVsyEwe2BdaHXxSJNDFbbZlWT3GMOmjKl/Yqc5RpyBg=;
	b=Nd4iNw+MCBz+ByRI90ZhSHwNetCm76C0I7YE+ErjsHy55gUbHxvljY9C/lBKAat7cFroZgoyGBxpN8F8xtMVahGhYU+RLDVAnAjUwVTK+XwjlC5gNfdaHq+Z4bXhn1buAh98bMllyHPpFqTVupxPv8ifAEPgHqqyhyeVBmaxgw0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEGqm2o_1725437680)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 16:14:41 +0800
Message-ID: <1725437142.8429277-2-xuanzhuo@linux.alibaba.com>
Subject: Re: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting support
Date: Wed, 4 Sep 2024 16:05:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>,
 "Machulsky,  Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>,
 "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>,
 "Bshara, Nafea" <nafea@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>,
 "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik,  Ofir" <ofirt@amazon.com>,
 "Beider, Ron" <rbeider@amazon.com>,
 "Chauskin,  Igor" <igorch@amazon.com>,
 "Bernstein, Amit" <amitbern@amazon.com>,
 Cornelia  Huck <cohuck@redhat.com>,
 Parav Pandit <parav@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
 <20240811100711.12921-3-darinzon@amazon.com>
 <20240812185852.46940666@kernel.org>
 <9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
 <20240813081010.02742f87@kernel.org>
 <8aea0fda1e48485291312a4451aa5d7c@amazon.com>
 <20240814121145.37202722@kernel.org>
 <IA0PR12MB87130D5D31AEFDBEDBF690ADDC952@IA0PR12MB8713.namprd12.prod.outlook.com>
 <686a380af2774aa9ade5a9baa1f9e49a@amazon.com>
In-Reply-To: <686a380af2774aa9ade5a9baa1f9e49a@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 3 Sep 2024 04:29:18 +0000, "Arinzon, David" <darinzon@amazon.com> wrote:
> > > > I've looked into the definition of the metrics under question
> > > >
> > > > Based on AWS documentation
> > > > (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-
> > > networ
> > > > k-performance-ena.html)
> > > >
> > > > bw_in_allowance_exceeded: The number of packets queued or dropped
> > > because the inbound aggregate bandwidth exceeded the maximum for the
> > > instance.
> > > > bw_out_allowance_exceeded: The number of packets queued or
> > dropped
> > > because the outbound aggregate bandwidth exceeded the maximum for
> > the
> > > instance.
> > > >
> > > > Based on the netlink spec
> > > > (https://docs.kernel.org/next/networking/netlink_spec/netdev.html)
> > > >
> > > > rx-hw-drop-ratelimits (uint)
> > > > doc: Number of the packets dropped by the device due to the received
> > > packets bitrate exceeding the device rate limit.
> > > > tx-hw-drop-ratelimits (uint)
> > > > doc: Number of the packets dropped by the device due to the transmit
> > > packets bitrate exceeding the device rate limit.
> > > >
> > > > The AWS metrics are counting for packets dropped or queued (delayed,
> > > > but
> > > are sent/received with a delay), a change in these metrics is an
> > > indication to customers to check their applications and workloads due
> > > to risk of exceeding limits.
> > > > There's no distinction between dropped and queued in these metrics,
> > > therefore, they do not match the ratelimits in the netlink spec.
> > > > In case there will be a separation of these metrics in the future to
> > > > dropped
> > > and queued, we'll be able to add the support for hw-drop-ratelimits.
> > >
> > > Xuan, Michael, the virtio spec calls out drops due to b/w limit being
> > > exceeded, but AWS people say their NICs also count packets buffered
> > > but not dropped towards a similar metric.
> > >
> > > I presume the virtio spec is supposed to cover the same use cases.
> > On tx side, number of packets may not be queued, but may not be even
> > DMAed if the rate has exceeded.
> > This is hw nic implementation detail and a choice with trade-offs.
> >
> > Similarly on rx, one may implement drop or queue or both (queue upto some
> > limit, and drop beyond it).
> >
> > > Have the stats been approved?
> > Yes. it is approved last year; I have also reviewed it; It is part of the spec
> > nearly 10 months ago at [1].
> > GH PR is merged but GH is not updated yet.
> >
> > [1] https://github.com/oasis-tcs/virtio-
> > spec/commit/42f389989823039724f95bbbd243291ab0064f82
> >
> > > Is it reasonable to extend the definition of the "exceeded" stats in
> > > the virtio spec to cover what AWS specifies?
> > Virtio may add new stats for exceeded stats in future.
> > But I do not understand how AWS ENA nic is related to virtio PCI HW nic.
> >
> > Should virtio implement it? may be yes. Looks useful to me.
> > Should it be now in virtio spec, not sure, this depends on virtio community
> > and actual hw/sw supporting it.
> >
> > > Looks like PR is still open:
> > > https://github.com/oasis-tcs/virtio-spec/issues/180
> > Spec already has it at [1] for drops. GH PR is not upto date.
>
> Thank you for the reply, Parav.
> I've raised the query and the summary of this discussion in the above mentioned github ticket.
>

I saw your reply on github.

So what is the question?

Now the stats are rx/tx_hw_drop_ratelimits, so I think these stats should only
count the number of dropped packets.

Yes, I also think the stats of queue packets are good. But that may be
new stats in the next version of the virtio spec or with new virtio feature.

But for the user, I thinks these are important. For me, I think nic
should provide all these stats.

Thanks.


