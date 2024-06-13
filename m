Return-Path: <netdev+bounces-103098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396689064C8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D353B1F2279B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A25A7A0;
	Thu, 13 Jun 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X+WWumih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6A5F876
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263159; cv=none; b=EnUaEP7sf04cipHwtu7XmdoHMaoRHGWXhoOwQCi1llZuKskTfQcnqEX3hKu+TOrTGMnl2hh5+MU/G+zViDthPVQGFGDJXxgB0vLAPEqwMtvKe2QBTcvdcFD7qOAlEGpNE0zSokuSgumPF/vZMMGE0+jQJesnAZObVV+BvgDi3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263159; c=relaxed/simple;
	bh=TzeJop5nKLNTds80+WUlKBHV3oFUZ/+WHxCILNbZbsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOzCJqJ4nT4TXG2uG1rt+kEQCxzRKr9mwQ4J0an/KpGZxomAUvP70DddgMwHUqG8PFx+Y8YkDvmM1VE6QuFiziDk+Lvt9Ac14hjcWntRM/yVKNdyZrMqLmaO5uPCrKACu4tzL48S+hneTdnZf4OLuAVavegTK86rrbw14hO72Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X+WWumih; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-421820fc26dso6502625e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718263156; x=1718867956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TzeJop5nKLNTds80+WUlKBHV3oFUZ/+WHxCILNbZbsA=;
        b=X+WWumihnXZlo0a6ENGjTplBYJ1oTMvYIa6n6obD0Q+VEZTF/kemD+Wjri3EzqU2GO
         zz+5pU5nlW6x01Hc28PNzsd0/gXS2EzomXg9xU3hSm90vXNW+MUhEO/oCfw6LcVRoLiR
         ktvIo8CvU1Uk1a+3z8g5Vrjc/XF2e0R5b1DUGuTIxPhnBqS7nGK23V0cEAdS0jBpD9bj
         TgCQraUeUvU+bFKdlbrqe46Ennnfby0FqPF4qZ2fu9BhVQri+UiM22g/R1vT4Od3TrJJ
         Jel0JM8aXYrYWOV82MdNt3RP2968wPq0+m3bPzlb7H648iIhOWQHL+3OVo1flKO1+cWY
         wS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263156; x=1718867956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzeJop5nKLNTds80+WUlKBHV3oFUZ/+WHxCILNbZbsA=;
        b=Tq9XiD08oQVazytf/hZmDdsdURwb/2Z4vEXMJXHSRaoCDroafohV+xfJt99wdzS2NT
         VHNRwt89D1u5P2s8HuTyXG2K8aFDutPg/+1zOvx4XEXvpqGSuaS0RIGgL/ECkahuYp2h
         iqyJXuUBvVegJAf1q9NGsrIc9nuZb5JeS12x66daa49mhhKuEH0nZwuRe6sa/b/cfdip
         PNATkY8wbC4Ykc6XdgkAhQxLZhopSTnSwmR0staDFTOu4GZB7zA9bEOI71fF+uVJ3X+b
         PzjjvouTlcMC008qChwUBiLOVPcIWbv3hBEg9DLy3zlAOKUnont3FQUVGB5wmVlFhE0N
         zCNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/GoRxsRhbP8maq0ci6IorvH4DCJKiSfuVQsTgFnazMmA/yFImbOqKcQS5nEFt4lWG6Eq+jNT0FMxUw5Q+J2c3jNXTF7bp
X-Gm-Message-State: AOJu0Yz35VUV5D3VUGjtoKyE0+Uy4kz3aGSIJE/OHzn5lA1v3g4MSSoV
	NDdnoZv592EBHpL1dIChp1EU+2ap9nc5FdbFoZcXa/pphpsK3TUnDgQwYsCrRhQ=
X-Google-Smtp-Source: AGHT+IGl0YvYwK8MoDJscuypQJ17jwFmwcn09ZKxZqvyzK8MNJmQlR+uPmmOX7iTOIKwEW9afSZARA==
X-Received: by 2002:a05:600c:1f15:b0:421:f0e2:300b with SMTP id 5b1f17b1804b1-422863b86e6mr38195605e9.17.1718263155474;
        Thu, 13 Jun 2024 00:19:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22f4sm825165f8f.78.2024.06.13.00.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:19:14 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:19:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <Zmqdb-sBBitXIrFo@nanopsycho.orion>
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
 <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>

Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
>On Thu, Jun 13, 2024 at 1:38 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
>> >From: Jason Xing <kernelxing@tencent.com>
>> >
>> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
>> >BQL device") limits the non-BQL driver not creating byte_queue_limits
>> >directory, I found there is one exception, namely, virtio-net driver,
>> >which should also be limited in netdev_uses_bql(). Let me give it a
>> >try first.
>> >
>> >I decided to introduce a NO_BQL bit because:
>> >1) it can help us limit virtio-net driver for now.
>> >2) if we found another non-BQL driver, we can take it into account.
>> >3) we can replace all the driver meeting those two statements in
>> >netdev_uses_bql() in future.
>> >
>> >For now, I would like to make the first step to use this new bit for dqs
>> >use instead of replacing/applying all the non-BQL drivers in one go.
>> >
>> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
>> >new non-BQL drivers as soon as we find one.
>> >
>> >After this patch, there is no byte_queue_limits directory in virtio-net
>> >driver.
>>
>> Please note following patch is currently trying to push bql support for
>> virtio_net:
>> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.us/
>
>I saw this one this morning and I'm reviewing/testing it.
>
>>
>> When that is merged, this patch is not needed. Could we wait?
>
>Please note this patch is not only written for virtio_net driver.
>Virtio_net driver is one of possible cases.

Yeah, but without virtio_net, there will be no users. What's the point
of having that in code? I mean, in general, no-user kernel code gets
removed.


>
>After your patch gets merged (I think it will take some time), you
>could simply remove that one line in virtio_net.c.
>
>Thanks.

