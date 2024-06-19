Return-Path: <netdev+bounces-104937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E790F399
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452F11C21250
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B815278D;
	Wed, 19 Jun 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qH/IfHFd"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09315216E
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812796; cv=none; b=VB3F5UkpLhH4UqsPmyX+AqgnaAPnW2cVhcYrwmHLPYfWW7CVLg9AgzpIiJRfQlPx/AYz4IIxJmHPk8S4blvCdKpFCcFdrD4rJ5rwEo4r8xkrDRhuvvxKOufK38Jj7austMQTinyil2fXlQ/Lqrh5jSkjdH0LamzRQlrkUxNv0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812796; c=relaxed/simple;
	bh=ULvnEkKBwCrybQNORJPiinJ0HjslXNnwTFFIRmT8iWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+6nhtJ+SqAeR+mPKTZCRXl+Q32zj/Uc5852xJW+5HIq7PZi9QuOVyqf2rilF0I+xRzYGBjCrx3xMG34CBBZRHZH9GKbnujlicRG3IYrEROn8eqGUkuoao7YGyf7RIM/1GpKo4J9lZaifDW4dEFDNlg9NO6r2tqPIVPsxTu/crA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qH/IfHFd; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718812785; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ULvnEkKBwCrybQNORJPiinJ0HjslXNnwTFFIRmT8iWs=;
	b=qH/IfHFd6jmSoCSblNksTa4kXmpaZ1zrwo0uKKfoc2orwtKR+KRD02+ze/vF1S6TOd2V5K+AaFYkKA+3ypo+LDhKSeHNcg0KEg8i9Ksbixv2VkBur9lslEeN1EO7TrU4WKKEbVBzL0v0Yf/9n5Q4pm/QEeZClX4ti6MM1EKkZLA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8oamoR_1718811851;
Received: from 30.39.254.97(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8oamoR_1718811851)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 23:44:12 +0800
Message-ID: <c4b2d4a9-2fe4-4822-a5ab-57d1bb98f0b8@linux.alibaba.com>
Date: Wed, 19 Jun 2024 23:44:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Thomas Huth <thuth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com>
 <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
 <1718680142.7236671-11-hengqi@linux.alibaba.com>
 <20240618181516.7d22421e@kernel.org>
 <1718762578.3916998-2-hengqi@linux.alibaba.com>
 <20240619080802.07acb5ac@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240619080802.07acb5ac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/6/19 下午11:08, Jakub Kicinski 写道:
> On Wed, 19 Jun 2024 10:02:58 +0800 Heng Qi wrote:
>>>> Currently we do not allow RXCUSM to be disabled.
>>> You don't have to disable checksuming in the device.
>> Yes, it is up to the device itself to decide whether to validate checksum.
>> What I mean is that we don't allow users to disable the driver's
>> NETIF_F_RXCSUM flag.
> I understand. What I'm suggesting is that you send a follow up patch
> that allows it.

OK, will do it.

Thanks.



