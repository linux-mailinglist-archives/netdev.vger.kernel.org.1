Return-Path: <netdev+bounces-64368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F03832B44
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 15:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD1C1C21421
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C14524B8;
	Fri, 19 Jan 2024 14:20:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFD4EB30
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674039; cv=none; b=ccYIrM39d8eQPDCSLysiPVtUFJTsm3v+3uOM7xsOJfUquoEOc9+Hq+8RAwyGhGmUBzxddCItT5J6TKpm9SrlzPEECtLfMU6QNKLOxFYQchFWPk9Gqb6vrfZ+F+6CYm16cn6VlmLZGxlkQMjUsOobcq/LA8EQkOsgMZjBC3vhbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674039; c=relaxed/simple;
	bh=FGwojiboHadsnYPaKwypjdnTtk0s5JjsWXbb+JDY4So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhUYO5+fgLr8saJNiXx6k9YIxPopLj+Lc+mpY38R/4f5KuNMdvXSQj6ZUfVQUcEP13eU0Nvujvoe1DvsAZProoSn2mgHwGFCKza9zG9UdP3rq/phtaWdOT8JiAub0PWiPhYIra4y+VOCi/5HqGEglWHdxs/QXpVDmsfTnVTJMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-wDAK9_1705674028;
Received: from 172.20.10.2(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-wDAK9_1705674028)
          by smtp.aliyun-inc.com;
          Fri, 19 Jan 2024 22:20:30 +0800
Message-ID: <02c20702-0f35-4a6c-ae7a-da5163378019@linux.alibaba.com>
Date: Fri, 19 Jan 2024 22:20:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] virtio-net: a fix and some updates for
 virtio dim
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <20240119072743-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240119072743-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/19 下午8:28, Michael S. Tsirkin 写道:
> On Tue, Jan 16, 2024 at 09:11:30PM +0800, Heng Qi wrote:
>> Patch 1 fixes an existing bug. Belongs to the net branch.
>> Patch 2 requires updating the virtio spec.
>> Patch 3 only attempts to modify the sending of dim cmd to an asynchronous way,
>> and does not affect the synchronization way of ethtool cmd.
>
> Given this doesn't build, please document how was each patch tested.
> Thanks!

There are some other local modifications. When using 'git add -ip' to 
temporarily store the patch content,
content that does not belong to this patch (struct virtnet_coal_entry) 
was mistakenly added to the patch [3/3],
and it was compiled and passed locally. Sorry for this, I will 
re-release it in the next version.

Thanks,
Heng

>> Heng Qi (3):
>>    virtio-net: fix possible dim status unrecoverable
>>    virtio-net: batch dim request
>>    virtio-net: reduce the CPU consumption of dim worker
>>
>>   drivers/net/virtio_net.c        | 197 ++++++++++++++++++++++++++++++++++++----
>>   include/uapi/linux/virtio_net.h |   1 +
>>   2 files changed, 182 insertions(+), 16 deletions(-)
>>
>> -- 
>> 1.8.3.1


