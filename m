Return-Path: <netdev+bounces-80742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F6880CCB
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51A2B21908
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F252C85A;
	Wed, 20 Mar 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xMent+6C"
X-Original-To: netdev@vger.kernel.org
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8033381AA;
	Wed, 20 Mar 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922351; cv=none; b=UxYGRFthWnlEK1BfDPjM4HHl/lo7YtbmXsRhTknEPTmC4Rbr1xn3aotXggUwUDg5FWuMyJB9sNqiYKPsYxZwUKDjp4rGaH0cwiVPdzVZf840RM66OQvbGG9BexEX/gzDkuoRMN9AT02dhkm8tyac2rm6ZDU0Ty6SKl1ml7QLFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922351; c=relaxed/simple;
	bh=2Oq8Uun0tT2JiU0cIwoDYug7ugm+rPl/BjiEmuLGDr0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=JIx8mDh+tkRNnCA/7OQqtLjoVvyb71rQMsHHRFbkyGFvmrkLwJfYuJUr6HSaQpwU/sOsCuDGT8+2BQRQBXeWFukqalmFmuQq7aLE5jwibpHE6XHqIG6fqGmXaIdTxOhtz+1KqB9RXQtWkWrtoeKZUlPHvyiv6B/uxvICHEyF9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xMent+6C; arc=none smtp.client-ip=47.90.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710922330; h=Message-ID:Subject:Date:From:To;
	bh=2Oq8Uun0tT2JiU0cIwoDYug7ugm+rPl/BjiEmuLGDr0=;
	b=xMent+6Cd0amDN0wtKwklPgyJhlNIoFx6MSRQON91LDq2g5OKr6deJxXA3vidOjc633ypmu/UbSwIZ4RfKOPROmhzvCf6fyePC5hxGvKlK8GN0RRFhb/AUVvSUpDYouo1EE+vzwo75XY9m69LQNr58caAIV4QFOT7Oh4bXl4rVo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2wfq-K_1710922327;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2wfq-K_1710922327)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 16:12:08 +0800
Message-ID: <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Wed, 20 Mar 2024 16:04:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Michael  S. Tsirkin" <mst@redhat.com>,
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
 bpf@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
 <ZfgxSug4sekWGyNd@nanopsycho>
 <316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
In-Reply-To: <316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 19 Mar 2024 11:12:23 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On Mon, 2024-03-18 at 13:19 +0100, Jiri Pirko wrote:
> > Mon, Mar 18, 2024 at 12:53:38PM CET, xuanzhuo@linux.alibaba.com wrote:
> > > On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
> > > > Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
> > > > > As the spec:
> > > > >
> > > > > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> > > > >
> > > > > The virtio net supports to get device stats.
> > > > >
> > > > > Please review.
> > > >
> > > > net-next is closed. Please resubmit next week.
> > >
> > >
> > > For review.
> >
> > RFC, or wait.
>
> @Xuan, please note that you received exactly the same feedback on your
> previous submission, a few days ago. While I do understand the legit
> interest in reviews, ignoring explicit feedback tend to bring no
> feedback at all.

Sorry.

I have a question regarding the workflow for feature discussions. If we
consistently engage in discussions about a particular feature, this may result
in the submission of multiple patch sets. In light of this, should we modify the
usage of "PATCH" or "RFC" in our submissions depending on whether the merge
window is open or closed? This causes the title of our patch sets to keep
changing.

Or I miss something.


Thanks.


>
> Paolo
>

