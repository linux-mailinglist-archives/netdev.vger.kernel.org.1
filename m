Return-Path: <netdev+bounces-103962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AD90A969
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CAE28BBC0
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E7194122;
	Mon, 17 Jun 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Bd/PhWej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5961922F0
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615908; cv=none; b=A3MhBYFMckun2lxsnm9s9UAukv9uppgHSv6Ncrivg8yAgjNVEEL002o0kJKdWgGLr51mrvlLU4A3v4m7Q+Qv/ExtxNgS8QAMs2S27cGDvQ0KOCKXRuG1NE3NUx0C7ggfxfGTz7vNW0A+1JrhCAzlAL2FSDeCb5veCi2OiuhR768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615908; c=relaxed/simple;
	bh=60p88lXRnFxWwD0DE/HWIs9gL3qFPJpsKvKfDLWGtnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYmeLX8Gf7iPmjd/IvUNX4lWJ5/0m85oALca1jC9ryxAL2PIQU8oHVyv3UtEAgVgK0ZtFBpScE3IK+kXoEbEwCZKtvGxQfL3uEJlNyfjolBFja68DVwassNGiv5Y5WmwVrKD1W5F22M+fDYGpx8I+oIUY660WVsShMB/VWUdw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Bd/PhWej; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3609565a1bdso606489f8f.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718615903; x=1719220703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POfDX3xWgrJgT8Fq+G401F4a/WRA9742U2LN9jolq6Q=;
        b=Bd/PhWejI+Yi3d95jXGRFl602/Cim92wMKUS0x0DKXhOknV04YIS00ytDQHvjM6ned
         1vEpAHhRosju96OnrD4ddb/j0kyAsG4nKNLtGag/jyW49SR1RK7ifD4MWPl4X7clxt9T
         +Ita4AeVHYXMjTNVnx2Q4m72J2v0957eNCt1xqsO4vH87w5yrgpKerKPjCED0UN0r6+f
         oq0v7cni9kNhkxflBYB87yXbBMxPLuZxGN9GGizI64qVUk8RRkI2VIJKx3Z8qMzd4Hww
         U6zob52xh+F7ZFWUo7x5hgtmsEY6dnU9zUKk6UYhptPeeHa1sJcQPDe9ws4S1PRXDoJ+
         wqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615903; x=1719220703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POfDX3xWgrJgT8Fq+G401F4a/WRA9742U2LN9jolq6Q=;
        b=EY7kSTxGSQRdCTr9oebBThyOe+294ntbX+If0rOQ3L1ynmWnd4y9wpT171bQzfAB6A
         Jl2QogsDuI5dqvun7xjuOJLeoDMSMnUP3aaEfr/UgYeap510p0TCSOlqYwau1tQdhmqK
         R1i77/hnbN7cvZRxdX5r6toMMGZCh5BuMAWOVfTS4PILDWo11MuIyBLBpBsYhI3fUzOT
         sz+7Ae+AMnNeoJE5t9mTab+eSE7JvtqwRm6brNlrZjHUJtCq9XHb8SXqJWt96GdlKDOQ
         j0CDisV80S7D+YTOcm/0wEp6boX5sN7bPZv0F9MVcqFK3Z7azk0//ZAFK70N+1juokeA
         QdPA==
X-Gm-Message-State: AOJu0Yz8WFLuCF81vwW4ZXKB3sjRRwl9z19905szUjjuEwKKiYDN9jSg
	/KhzFnevHNHhUv7w9pMoRUFgpdy2hF64U2IU9ziuGI3O/GNzfY80hIKOJWuaHEw=
X-Google-Smtp-Source: AGHT+IFc3xNDHvg8DJDW+rOLA6i/+nFtomWf+/l7TwKCWXAEUYTKks7voFma+B6f2Aaqai0xRQn9jA==
X-Received: by 2002:adf:e9c9:0:b0:35f:3068:56a1 with SMTP id ffacd0b85a97d-3607a781a27mr6160588f8f.54.1718615903203;
        Mon, 17 Jun 2024 02:18:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2407sm11567394f8f.72.2024.06.17.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:18:22 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:18:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
Message-ID: <Zm__WzuGEV8OdEKR@nanopsycho.orion>
References: <20240612170851.1004604-1-jiri@resnulli.us>
 <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>

Mon, Jun 17, 2024 at 04:34:26AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 13, 2024 at 1:09 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Add support for Byte Queue Limits (BQL).
>>
>> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>> running in background. Netperf TCP_RR results:
>>
>> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>>   propagate use_napi flag to __free_old_xmit() and only call
>>   netdev_tx_completed_queue() in case it is true
>> - added forgotten call to netdev_tx_reset_queue()
>> - fixed stats for xdp packets
>> - fixed bql accounting when __free_old_xmit() is called from xdp path
>> - handle the !use_napi case in start_xmit() kick section
>> ---
>>  drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++---------------
>>  1 file changed, 32 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 61a57d134544..5863c663ccab 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>>
>>  struct virtnet_sq_free_stats {
>>         u64 packets;
>> +       u64 xdp_packets;
>>         u64 bytes;
>> +       u64 xdp_bytes;
>>  };
>>
>>  struct virtnet_sq_stats {
>> @@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>>  }
>>
>> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> +                           bool in_napi, bool use_napi,
>>                             struct virtnet_sq_free_stats *stats)
>>  {
>>         unsigned int len;
>>         void *ptr;
>>
>>         while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> -               ++stats->packets;
>> -
>>                 if (!is_xdp_frame(ptr)) {
>>                         struct sk_buff *skb = ptr;
>>
>>                         pr_debug("Sent skb %p\n", skb);
>>
>> +                       stats->packets++;
>>                         stats->bytes += skb->len;
>>                         napi_consume_skb(skb, in_napi);
>>                 } else {
>>                         struct xdp_frame *frame = ptr_to_xdp(ptr);
>>
>> -                       stats->bytes += xdp_get_frame_len(frame);
>> +                       stats->xdp_packets++;
>> +                       stats->xdp_bytes += xdp_get_frame_len(frame);
>>                         xdp_return_frame(frame);
>>                 }
>>         }
>> +       if (use_napi)
>> +               netdev_tx_completed_queue(txq, stats->packets, stats->bytes);
>> +
>>  }
>
>I wonder if this works correctly, for example NAPI could be enabled
>after queued but before sent. So __netdev_tx_sent_queue() is not
>called before.

How is that possible? Napi weight can't change when link is up. Or am I
missing something?

>
>Thanks
>

