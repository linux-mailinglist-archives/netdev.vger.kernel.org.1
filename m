Return-Path: <netdev+bounces-75171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B84C868724
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 03:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3C41C24DD8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C62915C8;
	Tue, 27 Feb 2024 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aS2hgcIv"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12536C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001108; cv=none; b=XmmOu2aIvhSsLVoX2tBlN/W7HzCWCWNnh5N6mWBDaazo4ptSN7BlUq/oXBHe6PhdWkAWpHKwPTwz4arfDCgWw2cPSTXI43L45R6BsCE0DAd7ZWi8nVRevIfEGAEH6PzCkZXQgCkg6QYeNgnXg/JosNF3JOGzi+R+hAcVH281clM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001108; c=relaxed/simple;
	bh=bX7eoxFABSjg59jrBLkh63A7ptVgISi6Vc9LJkFqyBU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=n9JyOZFyoTF6r0acG5N5q+vrarpAAvh/OhCQ+Uj1alj1yrVP2N4YlzG/M9gTju7iIjbNR2tkpiXm77B5LyNCvAJuQKH3vvtfl7h22gecXp6mH/3rfkVbUBrdfvZhOXO7+PrbZTxsLqrS6/hLdW+l3fVk9PUwugaeXDLWLCL0lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aS2hgcIv; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709001097; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=/NwCFmkAyrx6sMHjK0w6e6VKX1vnLoBn6CwBjGClUXw=;
	b=aS2hgcIvdX2oJJ8MaWxYL2eaAemYznZcLmsrBnZLIOUQ6eNpCvZtSiAh4u6RrGSV2xGSLc5fxkXyTk5RRGaPXKxB8unEsA6qjHh+PMmpBLF1Y0OFt0V4e6OdPWp8bliYQuQu/YbIe5JL3ZppqSxvFDQ1eG5PImisKZ58fRLw04I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1L5L3Q_1709001096;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1L5L3Q_1709001096)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 10:31:36 +0800
Message-ID: <1709000456.2609937-2-xuanzhuo@linux.alibaba.com>
Subject: Re: virtio-net + BQL
Date: Tue, 27 Feb 2024 10:20:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Dave Taht <dave.taht@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 hengqi@linux.alibaba.com,
 netdev@vger.kernel.org
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
 <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
In-Reply-To: <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 23 Feb 2024 07:58:34 -0500, Dave Taht <dave.taht@gmail.com> wrote:
> On Fri, Feb 23, 2024 at 3:59=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Hi Dave,
> >
> > We study the BQL recently.
> >
> > For virtio-net, the skb orphan mode is the problem for the BQL. But now=
, we have
> > netdim, maybe it is time for a change. @Heng is working for the netdim.
> >
> > But the performance number from https://lwn.net/Articles/469652/ has no=
t appeal
> > to me.
> >
> > The below number is good, but that just work when the nic is busy.
> >
> >         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
> >         BQL, tso on: 156-194K bytes in queue, 535 tps
>
> That is data from 2011 against a gbit interface. Each of those BQL
> queues is additive.
>
> > Or I miss something.
>
> What I see nowadays is 16+Mbytes vanishing into ring buffers and
> affecting packet pacing, and fair queue and QoS behaviors. Certainly
> my own efforts with eBPF and LibreQos are helping observability here,
> but it seems to me that the virtualized stack is not getting enough
> pushback from the underlying cloudy driver - be it this one, or nitro.
> Most of the time the packet shaping seems to take place in the cloud
> network or driver on a per-vm basis.

So for the virtualized stack, do you mean the virtio-net + tap(host).
But now, on the cloud the virtio-net devices are DPUs in most cases.
The DPU is passthrought to the vm. So the virtio-net devices work
more like the hw devices.

On this case, I can do some benchmarks, but I want to do the test
when the nic is not full to simulate the normal user cases.

Can the BQL help to reduce the latency or increase throughput?
Or other benefit.

Thanks.

>
> I know that adding BQL to virtio has been tried before, and I keep
> hoping it gets tried again,
> measuring latency under load.
>
> BQL has sprouted some new latency issues since 2011 given the enormous
> number of hardware queues exposed which I talked about a bit in my
> netdevconf talk here:
>
> https://www.youtube.com/watch?v=3DrWnb543Sdk8&t=3D2603s
>
> I am also interested in how similar AI workloads are to the infamous
> rrul test in a virtualized environment also.
>
> There is also AFAP thinking mis-understood-  with a really
> mind-bogglingly-wrong application of it documented over here, where
> 15ms of delay in the stack is considered good.
>
> https://github.com/cilium/cilium/issues/29083#issuecomment-1824756141
>
> So my overall concern is a bit broader than "just add bql", but in
> other drivers, it was only 6 lines of code....
>
> > Thanks.
> >
>
>
> --
> https://blog.cerowrt.org/post/2024_predictions/
> Dave T=C3=A4ht CSO, LibreQos

