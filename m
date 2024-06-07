Return-Path: <netdev+bounces-101664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F088FFC58
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2D91F2837E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE83153508;
	Fri,  7 Jun 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lXy1XKcS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D2152530
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742423; cv=none; b=ddktz6UAR/jneb/WIJApHLkZK+cXZ58IXK6wngzvKz4ZR+RFpQHftmMQPpznQ1Mm3DAorNopkWnykednR5ShlkJ+VZkoDWHZ/zbNCE0sZd++aqpmAxwNUZAaEy8O1lLZbZmWKcqZr7imDDtUGc8gVZ1bZua8wfWpjRCwtjuuJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742423; c=relaxed/simple;
	bh=/d3qW4gpJGu9Os/l+hCKKxUgircnCfPEEFpLhTQLvH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjMlyVOBJQC3Zm/mVViJfSCFtOdEs9qkHRYT7O86rKdrAbD/svMwvcZ8RFrTAmHuOPi8wC2FBgkRCV+a0TFLghvG1DgS/e1e88HzkclJIMioDurGEk26rs5KDR0cRHtZQshKCqW6xBhXHg3VUmoMbM06ru9lgTatRQFWNMX+ldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lXy1XKcS; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-35dc7d0387cso2107131f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717742420; x=1718347220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6XEI8dLMpJdDM7JTfp7N8sVgu1+rTv4sqoDOCzXLd0w=;
        b=lXy1XKcSqwGu3wvxI7vsTz3TqpgARitRV12FEHFQS7dBF57GvAB5cQkM15tWFvYPVW
         4eDfr2Mka/WniHKEtuMQKmeDgqg/n3YvrvRz4MPOpWjW/0oHFNB9yWWCwekFcJaljDQr
         VHHsLFlch1Qbb70U2oIhLr7GhKRXicSrWiQpE66uvwZX7GGKZDxp2k2Xry3vlmwsQLQJ
         ondKLTHJhVo+bE+j/4VfSWNCebc9f5keQd+SM7EgPuSxnN/y45UpHwjleUDkQVbL3szh
         QJ1gmotRYuIX8SkH0YcQxojdBjIQ6/+kvJzJfbhmnzycrY67B6WJ+/qbxpgvz7XflZqz
         CDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742420; x=1718347220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XEI8dLMpJdDM7JTfp7N8sVgu1+rTv4sqoDOCzXLd0w=;
        b=QkoC1Uvs4Ut2r1Tj0xAfBfIScWU9MbS+9GKyU+t481JjCHwEezPEJTTQNyiTlSRQ8g
         UysdY8LbwwtY8glgreQDPHJloLx+zNOEevBFQNxv8hdcHPRAFQlKD8yU6qbjurEKg5JZ
         MxMjreumQYlWqZzaA200o6Qr/Cqz+LjdULzKuursDjUosVmVC1VluHdEqVkChP5y5rm4
         qjCpeHQpmKOJXWA85s0p0Jw36lqpF6P4GiPAvw2N+nUUjUMsR9iCaaOI7DCPrAAv1jED
         N3NMdQHIYjOwQake4mxcT9oLvFzDReT3qfLcnizURhS3iPywa7+E4ydGPR/S09TsUYA2
         QFLw==
X-Forwarded-Encrypted: i=1; AJvYcCWoIeYkLINm79Fs+Ht9z84C29Z45Ry77qFbvQc14CZRw5iRrg3KACm15am17CLHB5oVICodXLRYZ8b5JM8zuYVEINkhE82S
X-Gm-Message-State: AOJu0Yxv7R47tf1nAzgr4TuennSbu4ZR8dvp7I14g/eaggOV20Jq37iO
	DExnC8lFR/PegrTP+uf9RhJJ/KbPjgfUZubZw2bQHMBiT5SoL/3a6dYN9byBYnw=
X-Google-Smtp-Source: AGHT+IHUavIyWqadcBvafENMlXxkybMFx2G2vYtGOo2aeuGi1pPkT7U0AF/nyo5SZVx6FfgEmzaUQg==
X-Received: by 2002:a5d:6b82:0:b0:35e:f2f7:8a44 with SMTP id ffacd0b85a97d-35efedd7c32mr1284241f8f.47.1717742420175;
        Thu, 06 Jun 2024 23:40:20 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0b876d80sm163622f8f.109.2024.06.06.23.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:40:19 -0700 (PDT)
Date: Fri, 7 Jun 2024 08:40:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mst@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmKrUJ23zBD7HZkF@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
 <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>

Fri, Jun 07, 2024 at 08:22:31AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 6, 2024 at 9:41 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 06, 2024 at 06:25:15AM CEST, jasowang@redhat.com wrote:
>> >On Thu, Jun 6, 2024 at 10:59 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>> >>
>> >> Hello Jason,
>> >>
>> >> On Thu, Jun 6, 2024 at 8:21 AM Jason Wang <jasowang@redhat.com> wrote:
>> >> >
>> >> > On Wed, Jun 5, 2024 at 7:51 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> >> > >
>> >> > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
>> >> > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
>> >> > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > > > >>> From: Jiri Pirko <jiri@nvidia.com>
>> >> > > > >>>
>> >> > > > >>> Add support for Byte Queue Limits (BQL).
>> >> > > > >>
>> >> > > > >>Historically both Jason and Michael have attempted to support BQL
>> >> > > > >>for virtio-net, for example:
>> >> > > > >>
>> >> > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >> > > > >>
>> >> > > > >>These discussions focus primarily on:
>> >> > > > >>
>> >> > > > >>1. BQL is based on napi tx. Therefore, the transfer of statistical information
>> >> > > > >>needs to rely on the judgment of use_napi. When the napi mode is switched to
>> >> > > > >>orphan, some statistical information will be lost, resulting in temporary
>> >> > > > >>inaccuracy in BQL.
>> >> > > > >>
>> >> > > > >>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
>> >> > > > >>reasonable. This provides good support for BQL.
>> >> > > > >
>> >> > > > >But when the device does not support dim, the orphan mode is still
>> >> > > > >needed, isn't it?
>> >> > > >
>> >> > > > Heng, is my assuption correct here? Thanks!
>> >> > > >
>> >> > >
>> >> > > Maybe, according to our cloud data, napi_tx=on works better than orphan mode in
>> >> > > most scenarios. Although orphan mode performs better in specific benckmark,
>> >> >
>> >> > For example pktgen (I meant even if the orphan mode can break pktgen,
>> >> > it can finish when there's a new packet that needs to be sent after
>> >> > pktgen is completed).
>> >> >
>> >> > > perf of napi_tx can be enhanced through tx dim. Then, there is no reason not to
>> >> > > support dim for devices that want the best performance.
>> >> >
>> >> > Ideally, if we can drop orphan mode, everything would be simplified.
>> >>
>> >> Please please don't do this. Orphan mode still has its merits. In some
>> >> cases which can hardly be reproduced in production, we still choose to
>> >> turn off the napi_tx mode because the delay of freeing a skb could
>> >> cause lower performance in the tx path,
>> >
>> >Well, it's probably just a side effect and it depends on how to define
>> >performance here.
>> >
>> >> which is, I know, surely
>> >> designed on purpose.
>> >
>> >I don't think so and no modern NIC uses that. It breaks a lot of things.
>> >
>> >>
>> >> If the codes of orphan mode don't have an impact when you enable
>> >> napi_tx mode, please keep it if you can.
>> >
>> >For example, it complicates BQL implementation.
>>
>> Well, bql could be disabled when napi is not used. It is just a matter
>> of one "if" in the xmit path.
>
>Maybe, care to post a patch?
>
>The trick part is, a skb is queued when BQL is enabled but sent when
>BQL is disabled as discussed here:
>
>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>
>Thanks

Will try to go in orphan removal direction first.

>
>>
>>
>> >
>> >Thanks
>> >
>> >>
>> >> Thank you.
>> >>
>> >
>>
>

