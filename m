Return-Path: <netdev+bounces-75172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61A1868744
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 03:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC20B25630
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447BC11CAF;
	Tue, 27 Feb 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p0kycPuM"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E390FBEA
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001365; cv=none; b=t9Ty4MYV2fz6kG4czsKgcycPiwhF1iyM2ezs5S3SHXm9dHOQWx4BVQrxuo1g7Jnp2timvcbqtRP9QyCWpL6hQ5WBkjio15RHuWgatSOcDH9cF6bA06MfP8JnXI78LabPx9JF+CkwSsQQc8B5scmg5tJ1f2kKvKoe/8t5rayx3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001365; c=relaxed/simple;
	bh=lmBcnIiA4LO9rmjfJP3g1M7w8Yixw6eQ1jOVt3kOq00=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=JeX50gLVB7rbj/0aFwZ1cKpCgTSe+AufDlyRfCacz/SHd5KXiXNbnJZUkJDuglycmLE17um15swCy5F1u4/OztORYC5JazXGSd7LnO5cjK1f55Xtmv2TVtHznx312+vkvYiChp2Yu1p8vJ8+xsw2BveoJ4F+zeqhcRYK7+6Bbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p0kycPuM; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709001360; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=tzKOQJQwqcCHx0AWBIdGqgDNcJ7PI0iy6fzAWvQQ47E=;
	b=p0kycPuMii8OTyjxpgkM2RRkwwARtbS7J9gAXAMbU6NS+pUUu4FDloISBdHvfrHlugfcrT0zgBgIXcyUviqGCClr3BSfGdeuiZRsEY2qqjjVEL9J3wlHFb6bhXAAvOArBYBkaNmoYAGDIUSsLgC0re+xPvTxVJDj3R0b/nnh4Fw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1LB.cE_1709001359;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1LB.cE_1709001359)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 10:35:59 +0800
Message-ID: <1709001133.4560003-3-xuanzhuo@linux.alibaba.com>
Subject: Re: virtio-net + BQL
Date: Tue, 27 Feb 2024 10:32:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Dave Taht <dave.taht@gmail.com>,
 hengqi@linux.alibaba.com,
 netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
 <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com>
 <20240225133416-mutt-send-email-mst@kernel.org>
 <CAA93jw4DMnDMzzggDzBczvppgWWwu5tzcA=hOKOobVxJ7Se5xw@mail.gmail.com>
 <20240225145946-mutt-send-email-mst@kernel.org>
 <CACGkMEuFRQW6TFkF8KSHd7kGQH991pj_fCAT8BkMt8T51mEbWg@mail.gmail.com>
In-Reply-To: <CACGkMEuFRQW6TFkF8KSHd7kGQH991pj_fCAT8BkMt8T51mEbWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 26 Feb 2024 13:03:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Feb 26, 2024 at 4:26=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Sun, Feb 25, 2024 at 01:58:53PM -0500, Dave Taht wrote:
> > > On Sun, Feb 25, 2024 at 1:36=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Fri, Feb 23, 2024 at 07:58:34AM -0500, Dave Taht wrote:
> > > > > On Fri, Feb 23, 2024 at 3:59=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > Hi Dave,
> > > > > >
> > > > > > We study the BQL recently.
> > > > > >
> > > > > > For virtio-net, the skb orphan mode is the problem for the BQL.=
 But now, we have
> > > > > > netdim, maybe it is time for a change. @Heng is working for the=
 netdim.
> > > > > >
> > > > > > But the performance number from https://lwn.net/Articles/469652=
/ has not appeal
> > > > > > to me.
> > > > > >
> > > > > > The below number is good, but that just work when the nic is bu=
sy.
> > > > > >
> > > > > >         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
> > > > > >         BQL, tso on: 156-194K bytes in queue, 535 tps
> > > > >
> > > > > That is data from 2011 against a gbit interface. Each of those BQL
> > > > > queues is additive.
> > > > >
> > > > > > Or I miss something.
> > > > >
> > > > > What I see nowadays is 16+Mbytes vanishing into ring buffers and
> > > > > affecting packet pacing, and fair queue and QoS behaviors. Certai=
nly
> > > > > my own efforts with eBPF and LibreQos are helping observability h=
ere,
> > > > > but it seems to me that the virtualized stack is not getting enou=
gh
> > > > > pushback from the underlying cloudy driver - be it this one, or n=
itro.
> > > > > Most of the time the packet shaping seems to take place in the cl=
oud
> > > > > network or driver on a per-vm basis.
> > > > >
> > > > > I know that adding BQL to virtio has been tried before, and I keep
> > > > > hoping it gets tried again,
> > > > > measuring latency under load.
> > > > >
> > > > > BQL has sprouted some new latency issues since 2011 given the eno=
rmous
> > > > > number of hardware queues exposed which I talked about a bit in my
> > > > > netdevconf talk here:
> > > > >
> > > > > https://www.youtube.com/watch?v=3DrWnb543Sdk8&t=3D2603s
> > > > >
> > > > > I am also interested in how similar AI workloads are to the infam=
ous
> > > > > rrul test in a virtualized environment also.
> > > > >
> > > > > There is also AFAP thinking mis-understood-  with a really
> > > > > mind-bogglingly-wrong application of it documented over here, whe=
re
> > > > > 15ms of delay in the stack is considered good.
> > > > >
> > > > > https://github.com/cilium/cilium/issues/29083#issuecomment-182475=
6141
> > > > >
> > > > > So my overall concern is a bit broader than "just add bql", but in
> > > > > other drivers, it was only 6 lines of code....
> > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > >
> > > >
> > > > It is less BQL it is more TCP small queues which do not
> > > > seem to work well when your kernel isn't running part of the
> > > > time because hypervisor scheduled it out. wireless has some
> > > > of the same problem with huge variance in latency unrelated
> > > > to load and IIRC worked around that by
> > > > tuning socket queue size slightly differently.
> > >
> > > Add that to the problems-with-virtualization list, then. :/
> >
> > yep
> >
> > for example, attempts to drop packets to fight bufferbloat do
> > not work well because as you start dropping packets you have less
> > work to do on host and so VM starts going even faster
> > flooding you with even more packets.
> >
> > virtualization has to be treated more like userspace than like
> > a physical machine.
>
> Probaby, but I think we need a new rfc with a benchmark for more
> information (there's no need to bother with the mode switching so it
> should be a tiny patch).

YES.

We need to know the cases that BQL can improve. Then I can do some
benchmarks on it.

I don't think the orphan mode is a problem. We can clarify that
the no-orphan mode is the future, so we can skip the orphan mode.

Thanks.


>
> One interesting thing is that gve implements bql.
>
> Thanks
>
> >
> >
> > > I was
> > > aghast at a fix jakub put in to kick things at 7ms that went by
> > > recently.
> >
> > which one is it?
> >
> > > Wireless is kind of an overly broad topic. I was (6 years ago) pretty
> > > happy with all the fixes we put in there for WiFi softmac devices, the
> > > mt76 and the new mt79 seem to be performing rather well. Ath9k is
> > > still good, ath10k not horrible, I have no data about ath11k, and
> > > let's not talk about the Broadcom nightmare.
> > >
> > > This was still a pretty good day, in my memory:
> > > https://forum.openwrt.org/t/aql-and-the-ath10k-is-lovely/59002
> > >
> > > Is something else in wif igoing to hell? There are still, oh, 200
> > > drivers left to fix. ENOFUNDING.
> > >
> > > And so far as I know the 3GPP (5g) work is entirely out of tree and
> > > almost entirely dpdk or ebpf?
> > >
> > > >
> > > >
> > > > --
> > > > MST
> > > >
> > >
> > >
> > > --
> > > https://blog.cerowrt.org/post/2024_predictions/
> > > Dave T=C3=A4ht CSO, LibreQos
> >
>

