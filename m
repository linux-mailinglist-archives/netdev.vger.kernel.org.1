Return-Path: <netdev+bounces-244141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6BCB0642
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 888C63019678
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6ED2FE053;
	Tue,  9 Dec 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq659yd9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2C2D1F61
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293819; cv=none; b=IRQggNFKM54ZLyl/1j1MdY+Tn1GhpDhg7yNJ8GEGEqm2bSphfBGgrPIv8FwJSb+ZtnT60q/PC054gnS7GyfN5J6XR5W8VVCJiQOeKPPL8AluhdofssAYgFMTXiuJPMXWydlGFD0otlOcWRWmedzTlfMUoNQ9rbnJ5ZDkAvw+x78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293819; c=relaxed/simple;
	bh=JD5hyBpJAaNJ7sYgl/UrQWHJjtabTdl0L4UaYY83N+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+I9nxuU8ebC/Epk6mh92XvBJJAIiOIsVIhSKDWSAnDwlOCnclkO/rk44Nf1+rbTLE57HhyG9z6uOfu7pNIWgcd+gT8HEYJIjiaoHrb0mcS+QbSAtoasxQ2WWmleOVLlkAsFZ319l3CaHSTCoDTbF93RGkn4igGSzlTK8T9m5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq659yd9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aad4823079so5238738b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765293817; x=1765898617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7DbZ+8N23FwouofrnDLigkDHoe3CUpkkU2pOJ+ToVI=;
        b=dq659yd9spEH0AGlJjSXLFg6yLammOn6b7Fash88SM1EoPff0OUXVC+Ah/d/EPfwqm
         YE8eERQNhpwarsHnbSftuNxhg54x80TAfSHqYgMqe/pGXRHo/XmVDBto3IaQdG0XROzn
         vKIr8nyQbVjI3fxamkeWdzYSi7qzNWRd2/u48xE8O18sY2T88KQBMJjwXOP1x4hcm/le
         Wrttm7XMiFG7E6THyTguFmi3pSdYEZSOfyo/++qQD4c7QIhaTGHRH1kOMN9w6AQk3EzV
         Uljw8GebCdczwbGV2kp0WQW3xe2T8DF4JN2wa3Ohfmb1PbWK61JiNvrr3vqXlGRYsJ6k
         BpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765293817; x=1765898617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7DbZ+8N23FwouofrnDLigkDHoe3CUpkkU2pOJ+ToVI=;
        b=ASV8Sx7myd3wHwtfzfUgCkvnrF6YP0v4RNlLhKmr30iR2T5Hb4nwxpLPo3/MLGKlMy
         nf2PXGN51/rPuxNl8gkDIWBK6mK/SOevSgbjIw/u8pq2z4jnagGz3XHqzunpXmssj8al
         fwHFW0Ac03Y7GQK17XMr01404koQRk1dKQo35d2Bs1rdz+kExbbMR2v9Usm+kEIBg75M
         U7H/vXCN/9HZMtw/0ORBisc+E94hniG72pLKtsYtnKwlRtX4wUv6/HT0QcjFMs3hLfU7
         K7weKAHA/ITWZyVllHFCsilRfpOSq61VniwPfWtAxVZJcwSXmhDBSjDvmKe/55OmiAt/
         c0/Q==
X-Gm-Message-State: AOJu0YywgCiB+dvnHqfhtrwznGd5P79qFKdcGgLZp0UMW/7Uoo/g4mzE
	uzFgdBTzw7c5Ew+WOGsWvaUWAUDkzpm634e6h0IREortSYGJQW1B12hM
X-Gm-Gg: ASbGncsRXKRsfHO9pojyAs07KDDsBInhD9FwY/2bjspdB7amPbEFZljhG7FSPb9iSqR
	ucF0+b3jfQZb3QfqqjXfjqs+yZsjT64jXkIREYxSfrARNbnHGkhSCLz2+Y7FW/8FfsV3oQYZSlE
	5Fd8Xc90q/rkyYecTVofVaocS3TCUNXhB1DNm4SP//GUvCbJQYR/Oz0uKEcbOM4yQkFIH+1LzE/
	T/ntVLeArFzvdJBiJQrXQyIl0PdU7f2CMBNQn/9oPfSnH3PMUq2iam+u55Ipmd0wUsSjJRiPPbM
	5xB0u57YSqw7ZFUY5q7Spfqbi6kUdUkueIzJxXXci5JEK03lzr6CWnfn8eRpYGor8p6LNjVoSQ1
	FSMQCCpbRicbKnXRmUgGlOjBiV/SqLx8lipwqmvE9s28mmdnJHKKSBVhgheumfgQfREEw8Se76k
	1PPRcovr3kZN+Vgt6mYh3mjEagmSyL3V21ANjygxcUsoQB0UQyKO8piV2Whj0K
X-Google-Smtp-Source: AGHT+IFN5sdylXJLxCHNNsv6xbK8xt8uPVU4i306NX8HPuK5V8M26O/oWPXK67LxkxgltqZUNhCZqw==
X-Received: by 2002:a05:6a00:1703:b0:7e8:4471:8d1 with SMTP id d2e1a72fcca58-7e8c786662bmr9491026b3a.50.1765293817283;
        Tue, 09 Dec 2025 07:23:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:e7d6:7fa4:50a3:fa14? ([2001:ee0:4f4c:210:e7d6:7fa4:50a3:fa14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ed2cd65ad1sm6229403b3a.56.2025.12.09.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 07:23:36 -0800 (PST)
Message-ID: <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
Date: Tue, 9 Dec 2025 22:23:30 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/25 11:30, Jason Wang wrote:
> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Calling napi_disable() on an already disabled napi can cause the
>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>> work too early before enabling all the receive queue napis.
>>
>> The deadlock can be reproduced by running
>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>> device and inserting a cond_resched() inside the for loop in
>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>> processing the delayed refilled work runs on the same CPU as
>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>> In real scenario, the contention on netdev_lock can cause the
>> reschedule.
>>
>> This fixes the deadlock by ensuring all receive queue's napis are
>> enabled before we enable the delayed refill work in
>> virtnet_rx_resume_all() and virtnet_open().
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>   1 file changed, 28 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 8e04adb57f52..f2b1ea65767d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>          return err != -ENOMEM;
>>   }
>>
>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>> +{
>> +       bool schedule_refill = false;
>> +       int i;
>> +
>> +       enable_delayed_refill(vi);
> This seems to be still racy?
>
> For example, in virtnet_open() we had:
>
> static int virtnet_open(struct net_device *dev)
> {
>          struct virtnet_info *vi = netdev_priv(dev);
>          int i, err;
>
>          for (i = 0; i < vi->max_queue_pairs; i++) {
>                  err = virtnet_enable_queue_pair(vi, i);
>                  if (err < 0)
>                          goto err_enable_qp;
>          }
>
>          virtnet_rx_refill_all(vi);
>
> So NAPI and refill work is enabled in this case, so the refill work
> could be scheduled and run at the same time?

Yes, that's what we expect. We must ensure that refill work is scheduled 
only when all NAPIs are enabled. The deadlock happens when refill work 
is scheduled but there are still disabled RX NAPIs.

Thanks,
Quang Minh.


