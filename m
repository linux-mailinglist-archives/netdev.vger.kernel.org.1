Return-Path: <netdev+bounces-104401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354A490C680
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA101C21C70
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE5718E761;
	Tue, 18 Jun 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hLXdUplR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B213DBBB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697168; cv=none; b=i7dqJfFqTMxFm8qVXcg4uXz0EeFmC98tf5w3g9wBkXqNxkXFR7ziKbJLb35OS3idnNSMW6l5C4G3tP+xW/BNHnyRQHkgHCHpG2g7o1VTaZVUffBePHBB6CT6l1LH8V20VoLcbujXfud3nOmRf2UpQ+pvojeMywxmQWVJ+leBx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697168; c=relaxed/simple;
	bh=VNEo19Tc5MJTiO5fT03+bouUbfa/076D4b1voV/qyao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY63FUoVWy4qSBs0/4ioAtklsvjdFVyr3EyZ6UZWAcCfPGwkvAcdFpkK+Pkvidap/KwhLkXrQKw1vULZapFNFLnScJ8+3LH6fIdyC2l7RlJrRyD8xTqyTDk9LqIeVbQPZDMbz4yvHwQ1ApRzZQQCbImrlhJhED3yxQ+w+kqOEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hLXdUplR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-356c4e926a3so4872701f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718697164; x=1719301964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/XI6WSwtia3EjF/qcHL88JwGq0UZpvShFE/yvYgKu4g=;
        b=hLXdUplRKG6hQ98EXHm9puczUNI3uIU7emtA69ic+tItH+e4WEUALP/7QmyAf13+yh
         cTOEEb6yjX7LOvKP5EiM7z/iTtgSyrRCTDeR65Wgo0awkEr88SmjHejoIUbMvG/AEXVI
         /DJL9ZQCmJ6+9anrvfuot9jg30ndhTT3RnJQIU5nmT7NgQr19zT7W7lUiSasdSEisJ6i
         M0f86bB/qNKJJf8F1T+K13AwdS9Qf0wml7eg3c92YAXN+qyEfYs39dsOXx2DVK3a/Gtp
         xJ0mM6D2dp7IGOjhGOG9tQSrPYY62WfnBTPvayWt+xRaXmqGGHqyZXkAy3kj6/HEbIVe
         WdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697164; x=1719301964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XI6WSwtia3EjF/qcHL88JwGq0UZpvShFE/yvYgKu4g=;
        b=EH7rtMF0JYAsH+gaTCSuiUvy4obS99M7746ougkX5oq3A5qpfPL4vKxYvBc+NZEW9D
         AtypujpQi6GNn08/YrYFNNY/YeEt+hz4feBTIyX8DoTkUExLhV4NtIiwQSy0f5VUsZPF
         hoUI+0yqhg+kpALkTPz9QsZjPLTH0cM68RUpOsU9Nkgdq7B5dSVekF3yam6JxNqWEYBC
         Z9qdIaTduM87sn+OvgE4WOXKsY8RcY7eTXNnZvpyUdn7VqkRwlpEzAA8Wa9chOrZ5DBT
         qCEZ3gqcJtdH0mPNALve0OJ3s20og75rXhpXuxv8OXowy5j2VWPrKrAmZQ2lR7FeIDQU
         vMgg==
X-Gm-Message-State: AOJu0YxxoFoZKXJrEabEVzEy1GiXxTJCZHCa5eny1h3TS/e7LjmOXmMB
	SwA59tyfMT2UWzQ41j0A5ietJLWtxbco2LkjrPLoUvDI6cV8Cn9jKTbsU89sREY=
X-Google-Smtp-Source: AGHT+IF1XsFupWj3HhfJxQ7LjsEbbKSBNrBVVdNZN9TU3kkhg3a/RnyXA8WufdFDaI/EexvRvBDwRw==
X-Received: by 2002:a5d:6903:0:b0:35f:209b:c10f with SMTP id ffacd0b85a97d-3607a782476mr8245733f8f.68.1718697164430;
        Tue, 18 Jun 2024 00:52:44 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2263sm13700598f8f.83.2024.06.18.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:52:43 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:52:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnE8yKDl5O-UkBS_@nanopsycho.orion>
References: <20240612170851.1004604-1-jiri@resnulli.us>
 <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>
 <Zm__WzuGEV8OdEKR@nanopsycho.orion>
 <CACGkMEt9Vokeh6n8DKdBcqLRKVEXvNzM+-Zwad5eeMHvOdxXPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt9Vokeh6n8DKdBcqLRKVEXvNzM+-Zwad5eeMHvOdxXPw@mail.gmail.com>

Tue, Jun 18, 2024 at 02:53:42AM CEST, jasowang@redhat.com wrote:
>On Mon, Jun 17, 2024 at 5:18 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Jun 17, 2024 at 04:34:26AM CEST, jasowang@redhat.com wrote:
>> >On Thu, Jun 13, 2024 at 1:09 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>
>> >> Add support for Byte Queue Limits (BQL).
>> >>
>> >> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>> >> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>> >> running in background. Netperf TCP_RR results:
>> >>
>> >> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>> >> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>> >> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>> >> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>> >> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>> >> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>> >>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>> >>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>> >>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>> >>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>> >>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>> >>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>> >>
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >> v1->v2:
>> >> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>> >>   propagate use_napi flag to __free_old_xmit() and only call
>> >>   netdev_tx_completed_queue() in case it is true
>> >> - added forgotten call to netdev_tx_reset_queue()
>> >> - fixed stats for xdp packets
>> >> - fixed bql accounting when __free_old_xmit() is called from xdp path
>> >> - handle the !use_napi case in start_xmit() kick section
>> >> ---
>> >>  drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++---------------
>> >>  1 file changed, 32 insertions(+), 18 deletions(-)
>> >>
>> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> >> index 61a57d134544..5863c663ccab 100644
>> >> --- a/drivers/net/virtio_net.c
>> >> +++ b/drivers/net/virtio_net.c
>> >> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>> >>
>> >>  struct virtnet_sq_free_stats {
>> >>         u64 packets;
>> >> +       u64 xdp_packets;
>> >>         u64 bytes;
>> >> +       u64 xdp_bytes;
>> >>  };
>> >>
>> >>  struct virtnet_sq_stats {
>> >> @@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>> >>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>> >>  }
>> >>
>> >> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> >> +                           bool in_napi, bool use_napi,
>> >>                             struct virtnet_sq_free_stats *stats)
>> >>  {
>> >>         unsigned int len;
>> >>         void *ptr;
>> >>
>> >>         while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> >> -               ++stats->packets;
>> >> -
>> >>                 if (!is_xdp_frame(ptr)) {
>> >>                         struct sk_buff *skb = ptr;
>> >>
>> >>                         pr_debug("Sent skb %p\n", skb);
>> >>
>> >> +                       stats->packets++;
>> >>                         stats->bytes += skb->len;
>> >>                         napi_consume_skb(skb, in_napi);
>> >>                 } else {
>> >>                         struct xdp_frame *frame = ptr_to_xdp(ptr);
>> >>
>> >> -                       stats->bytes += xdp_get_frame_len(frame);
>> >> +                       stats->xdp_packets++;
>> >> +                       stats->xdp_bytes += xdp_get_frame_len(frame);
>> >>                         xdp_return_frame(frame);
>> >>                 }
>> >>         }
>> >> +       if (use_napi)
>> >> +               netdev_tx_completed_queue(txq, stats->packets, stats->bytes);
>> >> +
>> >>  }
>> >
>> >I wonder if this works correctly, for example NAPI could be enabled
>> >after queued but before sent. So __netdev_tx_sent_queue() is not
>> >called before.
>>
>> How is that possible? Napi weight can't change when link is up. Or am I
>> missing something?
>
>Something like this:
>
>1) packet were queued
>2) if down
>3) enable NAPI
>4) if up
>5) packet were sent

Gotcha, will try to fix. Thanks!


>
>?
>
>Thanks
>
>>
>> >
>> >Thanks
>> >
>>
>

