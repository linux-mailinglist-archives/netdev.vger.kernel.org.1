Return-Path: <netdev+bounces-81458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A4889670
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 09:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ED01C25A14
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191314B080;
	Mon, 25 Mar 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q/5ep+EB"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83B155750
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333294; cv=none; b=O8+f6TzNUUCeJDaQzDTZFM4hKGZhdjgFEQBTdluWJugJoOhgQLSSASqnYokqmfjAA5+dZhBQpUzGfGU3lM+sy+a8TS3B4q/pFd/N1ZVsww2baT8bGDBin5eB3PrNn5FUbN8thjdnF4/RUSWalbZkQUA7eya7/6T6fuCH6HA5uZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333294; c=relaxed/simple;
	bh=O55hfeRrM8Nyva7hubsFry8A4/QGu0XdVfEA6z4VZmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE2aKnbzeekdoBJvQtHLw/kcyEm6YA5YfAOrTAUWXenlFbbjQ1L+fWBw40BGgC1kBEELCJ7J/i4k7xY5X+nvi2hIuSEn2QJ9tzcugs+hcKKRu8+kaNnYCuqYZAiP/9QUHxdUnXpCVLtUrn5s3zy1MiSVHuMxdD1hLc5N1Qf+k3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q/5ep+EB; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711333289; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P3YrW/OUqxaVBghKQR22O4dIfIzNVTvbEPAdpxgPbw4=;
	b=Q/5ep+EBy//ewWVtJQpw6o9hs/x5yD31aZGUAsp4sCoSGhzGOuthIm24Ummm8/jiAUWO/mHcyOiX3Ej/GgWjSEN7PlK31Zqh50AiNcDWjbKcUinm5SK2FlCl2xRa3uQaE/Alk6LBu3MD2/wcnzPLmXNF8kgjrs2pmykqVXybgLc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W38IF0._1711333286;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W38IF0._1711333286)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 10:21:29 +0800
Message-ID: <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
Date: Mon, 25 Mar 2024 10:21:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/22 下午1:19, Jason Wang 写道:
> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> Currently, ctrlq processes commands in a synchronous manner,
>> which increases the delay of dim commands when configuring
>> multi-queue VMs, which in turn causes the CPU utilization to
>> increase and interferes with the performance of dim.
>>
>> Therefore we asynchronously process ctlq's dim commands.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> I may miss some previous discussions.
>
> But at least the changelog needs to explain why you don't use interrupt.

Will add, but reply here first.

When upgrading the driver's ctrlq to use interrupt, problems may occur 
with some existing devices.
For example, when existing devices are replaced with new drivers, they 
may not work.
Or, if the guest OS supported by the new device is replaced by an old 
downstream OS product, it will not be usable.

Although, ctrlq has the same capabilities as IOq in the virtio spec, 
this does have historical baggage.

Thanks,
Heng

>
> Thanks


