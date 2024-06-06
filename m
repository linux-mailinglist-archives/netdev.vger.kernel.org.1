Return-Path: <netdev+bounces-101432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572FD8FE81E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE851C25FBE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95061195998;
	Thu,  6 Jun 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E9DSAM1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD9195988
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681513; cv=none; b=kcx/+rkMUEJVY3V5s+7K4MW5CsuVFc+7t4E4pH7A/6vTm7DXM+CIv+g6pOHwugZrbWLHjoAVlJbSQMybeZB6WUhq2H2Zhp6vMHMLqHEcP5keGViSUp9NLbHniRFImBJfDDXK+9nEfG1Hi4AXpL8M/D3UHyMDhlF2XFeTIFi+SzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681513; c=relaxed/simple;
	bh=ETbwxjKeQNyzp3aJQuy3uxvhni5xHQLfJAuwpU+mDHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKqNJBkCzQM42VnVpVdJ9gVJD6XWhkeipqMi8M2bJ0aP/tIAmDDXXIH5ukIkoWiKDjOAIZcfYN5qvQkNfZ0wla6W7uNlM6fj9i4NTLLWi8OUu0JW3ILQ4DQlIp99vwfg8yMi4kY/3FP6rY/rvGYrSPCzHmY7PpNoTdJdqA5kuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E9DSAM1l; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42136faf3aeso6413925e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717681509; x=1718286309; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/kEq/cSXLDF9g1VB9kvBV2CHVx+ge4bVlvK/b/5dgDA=;
        b=E9DSAM1lByRdhbm20FUAOB8Uq1DRg0hsLf32BjtuulbRKfau/VZPLZZ313kYnIRPYK
         8CaKZxkWIVPqSyW+QVFXHYDwyjjHS86oRkl4rOff4HVjkJIE8+s7x3aP6Meyftu/TNHU
         iUieekcvhgaZW3x71Avo7D890Mfh4tgE8X8dECX/3DoNbu9/WcHK0cyBjR9jJYoVKoOb
         BuTwUZB94MMmVXdLl8mMJXo8FPKcj/YdJuNnPZPNvR1gcmgnHsajVnJdBG+omM0BZo5/
         2aXsUROZ8rUjMg/5ZHmY0AIea4M9b9vIzG4jura+s7VZUhCht5yKXEMv2ioc8aJT8emV
         JoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681509; x=1718286309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kEq/cSXLDF9g1VB9kvBV2CHVx+ge4bVlvK/b/5dgDA=;
        b=fLfWiCfmjXQEF6ljtt6MtAFQmmbx6zoU4M+Ju6nXAyibgrjXRMI9x791FHtqFSnnzw
         gSg0TrqYfcTFeY16RQKtns53rKnlK0N/WIDbmHCajRZu+Uvs9sGOrum3iBTb1EplQtvm
         up17PyJGfuxn2UC1CeiBX6YjgFR282zNUV4T44KT1PABc4/cLTwDg+QnAH2WEwOvfSAB
         qh7l/M3zSv/gu4zvUJMnvhEsau5Ghrnaxdr1fHaymmaebXYfFpYusaK+OZ+X/+uhEubQ
         D9ETRuISZ2LzmNxH1odZejS79Km/K4uSjqx/HvdIWbfCD4uMq0GpRk0gT85Uc2mpzOxw
         0Bsg==
X-Forwarded-Encrypted: i=1; AJvYcCVbDZ2YJo1pc02V6JPntJheaYbhsYXeeEmY6b/x4sW67TV6v7sDQYYdAlKbza/EIBp+b8uMjjbGcqzTzaX1A8X43TpU3Eli
X-Gm-Message-State: AOJu0YxFjAkFwJidec+399Y63QN8uPKl16jcaXCf+BPVvd32NuT1v70P
	mV5V1N0cjlnNWXDRPBU93MF4QRf5OtVmWq/rf2eLMXbz2T76jmq6oGTb6Pa2vtY=
X-Google-Smtp-Source: AGHT+IGO4QJRyNU1dKUWadFZnIp3cwBRcYvJu0m0pBiLJcJ89bYxEqcWmfR91HnKvgLL+cxSDb/nYA==
X-Received: by 2002:a05:600c:19d2:b0:41a:8b39:8040 with SMTP id 5b1f17b1804b1-421562e751dmr41781605e9.20.1717681508824;
        Thu, 06 Jun 2024 06:45:08 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42160a19ae5sm9751525e9.18.2024.06.06.06.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:45:08 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:45:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>

Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
>> > > If the codes of orphan mode don't have an impact when you enable
>> > > napi_tx mode, please keep it if you can.
>> >
>> > For example, it complicates BQL implementation.
>> >
>> > Thanks
>>
>> I very much doubt sending interrupts to a VM can
>> *on all benchmarks* compete with not sending interrupts.
>
>It should not differ too much from the physical NIC. We can have one
>more round of benchmarks to see the difference.
>
>But if NAPI mode needs to win all of the benchmarks in order to get
>rid of orphan, that would be very difficult. Considering various bugs
>will be fixed by dropping skb_orphan(), it would be sufficient if most
>of the benchmark doesn't show obvious differences.
>
>Looking at git history, there're commits that removes skb_orphan(), for example:
>
>commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
>Author: Eric Dumazet <edumazet@google.com>
>Date:   Fri Sep 28 07:53:26 2012 +0000
>
>    mlx4: dont orphan skbs in mlx4_en_xmit()
>
>    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
>    completions) we no longer need to orphan skbs in mlx4_en_xmit()
>    since skb wont stay a long time in TX ring before their release.
>
>    Orphaning skbs in ndo_start_xmit() should be avoided as much as
>    possible, since it breaks TCP Small Queue or other flow control
>    mechanisms (per socket limits)
>
>    Signed-off-by: Eric Dumazet <edumazet@google.com>
>    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
>    Cc: Or Gerlitz <ogerlitz@mellanox.com>
>    Signed-off-by: David S. Miller <davem@davemloft.net>
>
>>
>> So yea, it's great if napi and hardware are advanced enough
>> that the default can be changed, since this way virtio
>> is closer to a regular nic and more or standard
>> infrastructure can be used.
>>
>> But dropping it will go against *no breaking userspace* rule.
>> Complicated? Tough.
>
>I don't know what kind of userspace is broken by this. Or why it is
>not broken since the day we enable NAPI mode by default.

There is a module option that explicitly allows user to set
napi_tx=false
or
napi_weight=0

So if you remove this option or ignore it, both breaks the user
expectation. I personally would vote for this breakage. To carry ancient
things like this one forever does not make sense to me. While at it,
let's remove all virtio net module params. Thoughts?



>
>Thanks
>
>>
>> --
>> MST
>>
>

