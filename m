Return-Path: <netdev+bounces-101430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7948FE810
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8072285EE5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC95719642D;
	Thu,  6 Jun 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yaCBJ3lW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6D195FF6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681280; cv=none; b=lXke+lCQb377/jSG19QCOzXe26CzTe3kEs0oB/M5xNsx7p+GEVqnmSP9XyVCJjMjS70X3zaM77LQU0dN7Ff8g+2m3qxFh8piBOO2m0NLFwn2+WiEvLZcVrL+Y6bhXbB09hcvojzs2vAlxsL+74oaeoDXYSSUpUC3PeBpWwcPiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681280; c=relaxed/simple;
	bh=MepWOeCaXlT4cft2/xb3k6MmO1MBFt/mXAckD02oOGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOrqQOd7lJacGyN8wTGrsyRI26Uvdf5DCjJzkGNDhaR8agwDyNbIlqjfRUiFR5keR/8bE4SwOPdQrO3wObRVvRtY24ZkykWHZFEIBXmh85ZpbKUImmKRI+9AecFA6GtdWUA3mfSQbl0zyXJmC0Z9cbKZgOUO96M+fNchpHFhIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yaCBJ3lW; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-42159283989so12750835e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717681277; x=1718286077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EHt1vwruUZwoLHmiyjsAgdJDvWiCcabCfNGofejWbyA=;
        b=yaCBJ3lW5T3kb9zIaqeXMoA6lYgN4ZN/WkW7MhJCrLk26JuhS+AVWDZoGM1y6vfL0k
         76vM4Ktr+ySNkyceeYE4c8zMj1YopCJfLEq/mmY8u5DpPhQvopCrxRF58bR66cychTqs
         NrCYxyLKgyfbVAiSy5P8Zhl98LZ431NtnHfEygAB7DBbCnFqtsSWn88VgWUxJZs2tsuk
         IbclgEkvIvCiowLQYh19QjAgSehhIf8B5SxQ466qyApCWukK9FNhnBTGsZvsjo955ZAW
         p8c+NBWnaHZoCfsTPM6Z9NA9SIDyiBht7OoyM+W2fZh21c8qdSmVJrfjZ5zb3sIA6UD9
         oZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681277; x=1718286077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHt1vwruUZwoLHmiyjsAgdJDvWiCcabCfNGofejWbyA=;
        b=DInM0ChQFgtAoZe8c+TCwYDnqo0/GQUonpwAt4jXYKHBYmd2qdzMe7jYwdwixV/rQQ
         YDVZ+oOkUDTbP1uGetfxMxhNEcRPMO7RALlXdDDiZCGPCHHXjEprg3rhss5/y2pGRTO8
         bL2/33cRtEiDLHFpGDdJ/qV32EvrccJGbKnD5KF1SUunnSiG8BHqL/AYJtInjFWECcFw
         Mq+JUwHV9OR7YdpypfeRsmWRSriipukTykUYt5ERSvcuXER7EOL+tLSZLOkGumNO7m7E
         g30kf4/eSKPXt/uWFKM6K3s+YvE+i7kOgTYMfTin2Imei/rPa0Ebi91HA46eot0tD0nv
         HKYg==
X-Forwarded-Encrypted: i=1; AJvYcCXBR6CO3d/tB50BwIyKNqLPmxYXmQi+utTX4h4ThmEwVPfe71drR8exyNjAgKwMXBEz7nmvxJO7zkPRFH7KbLqcfnvcJOV9
X-Gm-Message-State: AOJu0Yzh9Z8TuW5BznDBNNoCwDVNjTlgE/PbbEhUcPNRHQWRt5hkccM3
	DYkhLfGCGuauoAdOgEq5gEs3I1lLlleqXMYE2H3N9wuRb5LpxyVlhPvS1pU60jY=
X-Google-Smtp-Source: AGHT+IHbNLQBJFkwT1Js3XASWm4yJsmYHWqXgvOybdju1UZ3MSs0vkF2JmLbiS2QqtNaFA37HdUcqg==
X-Received: by 2002:a05:600c:4f49:b0:421:36da:9438 with SMTP id 5b1f17b1804b1-4215633a175mr62261305e9.28.1717681276442;
        Thu, 06 Jun 2024 06:41:16 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811e008sm55048115e9.28.2024.06.06.06.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:41:15 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:41:12 +0200
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
Message-ID: <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>

Thu, Jun 06, 2024 at 06:25:15AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 6, 2024 at 10:59 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>
>> Hello Jason,
>>
>> On Thu, Jun 6, 2024 at 8:21 AM Jason Wang <jasowang@redhat.com> wrote:
>> >
>> > On Wed, Jun 5, 2024 at 7:51 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> > >
>> > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
>> > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
>> > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > >>> From: Jiri Pirko <jiri@nvidia.com>
>> > > > >>>
>> > > > >>> Add support for Byte Queue Limits (BQL).
>> > > > >>
>> > > > >>Historically both Jason and Michael have attempted to support BQL
>> > > > >>for virtio-net, for example:
>> > > > >>
>> > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> > > > >>
>> > > > >>These discussions focus primarily on:
>> > > > >>
>> > > > >>1. BQL is based on napi tx. Therefore, the transfer of statistical information
>> > > > >>needs to rely on the judgment of use_napi. When the napi mode is switched to
>> > > > >>orphan, some statistical information will be lost, resulting in temporary
>> > > > >>inaccuracy in BQL.
>> > > > >>
>> > > > >>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
>> > > > >>reasonable. This provides good support for BQL.
>> > > > >
>> > > > >But when the device does not support dim, the orphan mode is still
>> > > > >needed, isn't it?
>> > > >
>> > > > Heng, is my assuption correct here? Thanks!
>> > > >
>> > >
>> > > Maybe, according to our cloud data, napi_tx=on works better than orphan mode in
>> > > most scenarios. Although orphan mode performs better in specific benckmark,
>> >
>> > For example pktgen (I meant even if the orphan mode can break pktgen,
>> > it can finish when there's a new packet that needs to be sent after
>> > pktgen is completed).
>> >
>> > > perf of napi_tx can be enhanced through tx dim. Then, there is no reason not to
>> > > support dim for devices that want the best performance.
>> >
>> > Ideally, if we can drop orphan mode, everything would be simplified.
>>
>> Please please don't do this. Orphan mode still has its merits. In some
>> cases which can hardly be reproduced in production, we still choose to
>> turn off the napi_tx mode because the delay of freeing a skb could
>> cause lower performance in the tx path,
>
>Well, it's probably just a side effect and it depends on how to define
>performance here.
>
>> which is, I know, surely
>> designed on purpose.
>
>I don't think so and no modern NIC uses that. It breaks a lot of things.
>
>>
>> If the codes of orphan mode don't have an impact when you enable
>> napi_tx mode, please keep it if you can.
>
>For example, it complicates BQL implementation.

Well, bql could be disabled when napi is not used. It is just a matter
of one "if" in the xmit path.


>
>Thanks
>
>>
>> Thank you.
>>
>

