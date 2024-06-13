Return-Path: <netdev+bounces-103230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84965907369
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13F22862D0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C722092;
	Thu, 13 Jun 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w5S9Hbl0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605715CB
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284671; cv=none; b=IowTe9wDB2UevYcCd3DoW55rMD8TCm7hcXI2o7fcvbK4f4UyqvWeK7FWMit5zGbZZEqs3jXfxJJlkAzj0GANGqABXIQOks6mqHhRFFUBW/0fGhyVXORegmL7dTA9Un5zLAKSgPmtVSSR3qLCShtGpc8oqVqoeL60iiymP5Rdmo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284671; c=relaxed/simple;
	bh=HKmj2hi3H3aEFKJxh/Fd9rAiipQgbrbA2aBMsyBUmRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG60pQP3comttp7WCezOTDl5P05o86xpb8R/FEyulWuL2j8SVwKzENDDM9R5os7ASyxzAXu/ILfkyT+kZPMoBQVB9h01eyaH6BeWZoKqAwkz3oWkpzKoHFoyIrjfed/9i6Fwrwdp0UvRpFs23JzopU83LDCXfDtNcLjaq0K952c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w5S9Hbl0; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-52ca342d6f3so540967e87.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718284667; x=1718889467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HKmj2hi3H3aEFKJxh/Fd9rAiipQgbrbA2aBMsyBUmRA=;
        b=w5S9Hbl0s1FuIBkkqOXdHDZgF6OJbPFPp8xd0KR+KC4H5GXnHpJieptcta1ony3Egt
         8h4Q/sInQ4q882WvS4TaH2XjfqHDb7w2b66pnN/Ywa1zSpl9Zkd93nxs5wS5VRvbdT5w
         4g3rBvkaEHZT4TaALcdE0OPi0SluQ7PBb1qJMG5HKv5Pk+7805gVmYGKQ/G1JwqQUjA0
         luA74n6u2kBKoF/opV0VoAQPTUa/EUQHEhjvuGvgI1ZcFsjSkJKwhvF7mLWwKBB2d4DN
         EPVd/o4bQ5UUd+dOiWd7WMyYFP5MPKTmny8P53J/aIAqB9lHiqXKp2Av4ktSN85XvrZM
         Dnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284667; x=1718889467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKmj2hi3H3aEFKJxh/Fd9rAiipQgbrbA2aBMsyBUmRA=;
        b=WTWZCthl7rmw2XAVqi13idDpUvi/rPhQFAAQ05jwomBpzA/4+fRc87VqRbiZhZd6nG
         Coo1Lkazdb1fELQnYY562dpCYPay/GtoSOd2qjr4Lj05qAyXohUGApZqP57wW04+g9eL
         8c/zw+xfKskz4AbN93aPZdejJ/HPBwfCOhY302bTIu5xEkrtto1banWTpnjgBFdI1Bg0
         inYFaUs8Fybew5SQW6dht3JypIe/ojUwMTeJMn1SDEiS9l/fHcObQ+6TLdi+0fWznJ/V
         19TkFwv98KrNqYI3qQWAeJ8KhroxMcNxD3PNiDBVctiqreHK/EbODF0cBiKBhD51pHta
         daLw==
X-Forwarded-Encrypted: i=1; AJvYcCXR49X2G4Xb12LAVLhnWhB6Dxo7/r8q8NQOwNLUAojgYGxCo++O3piRZICKu9nvnPbR3jgqeIk0eKU/LWNrTCkB21nbKJ1B
X-Gm-Message-State: AOJu0YyEWGfwCl91g3ArOjkS3/nkQ939Wn94kOvbGyQ/LAiBMm88mdt7
	SSUGCsBKKoRuh2+66h0IQ/4J1sLQBKeflK/4ifV6I6FZUsYIjBEx20/YDl4kCg4=
X-Google-Smtp-Source: AGHT+IHy16bKPmKCb8TaTkyU4cg4pD1eK5WyvDwsk0dnGSLwgK4Yh6jSvCUoZFUYFFe9Sgy+RG8RRA==
X-Received: by 2002:a05:6512:3f0e:b0:51b:214c:5239 with SMTP id 2adb3069b0e04-52c9a406a2fmr3994035e87.62.1718284667195;
        Thu, 13 Jun 2024 06:17:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de63asm62992705e9.30.2024.06.13.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:17:46 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:17:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	dsahern@kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <ZmrxdwR2srw11Blo@nanopsycho.orion>
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
 <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion>
 <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
 <Zmqk5ODEKYcQerWS@nanopsycho.orion>
 <20240613035148-mutt-send-email-mst@kernel.org>
 <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com>

Thu, Jun 13, 2024 at 11:26:05AM CEST, kerneljasonxing@gmail.com wrote:
>On Thu, Jun 13, 2024 at 3:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Jun 13, 2024 at 09:51:00AM +0200, Jiri Pirko wrote:
>> > Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrote:
>> > >On Thu, Jun 13, 2024 at 3:19 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> > >>
>> > >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
>> > >> >On Thu, Jun 13, 2024 at 1:38 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> > >> >>
>> > >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
>> > >> >> >From: Jason Xing <kernelxing@tencent.com>
>> > >> >> >
>> > >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
>> > >> >> >BQL device") limits the non-BQL driver not creating byte_queue_limits
>> > >> >> >directory, I found there is one exception, namely, virtio-net driver,
>> > >> >> >which should also be limited in netdev_uses_bql(). Let me give it a
>> > >> >> >try first.
>> > >> >> >
>> > >> >> >I decided to introduce a NO_BQL bit because:
>> > >> >> >1) it can help us limit virtio-net driver for now.
>> > >> >> >2) if we found another non-BQL driver, we can take it into account.
>> > >> >> >3) we can replace all the driver meeting those two statements in
>> > >> >> >netdev_uses_bql() in future.
>> > >> >> >
>> > >> >> >For now, I would like to make the first step to use this new bit for dqs
>> > >> >> >use instead of replacing/applying all the non-BQL drivers in one go.
>> > >> >> >
>> > >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
>> > >> >> >new non-BQL drivers as soon as we find one.
>> > >> >> >
>> > >> >> >After this patch, there is no byte_queue_limits directory in virtio-net
>> > >> >> >driver.
>> > >> >>
>> > >> >> Please note following patch is currently trying to push bql support for
>> > >> >> virtio_net:
>> > >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.us/
>> > >> >
>> > >> >I saw this one this morning and I'm reviewing/testing it.
>> > >> >
>> > >> >>
>> > >> >> When that is merged, this patch is not needed. Could we wait?
>> > >> >
>> > >> >Please note this patch is not only written for virtio_net driver.
>> > >> >Virtio_net driver is one of possible cases.
>> > >>
>> > >> Yeah, but without virtio_net, there will be no users. What's the point
>> > >> of having that in code? I mean, in general, no-user kernel code gets
>> > >> removed.
>> > >
>> > >Are you sure netdev_uses_bql() can limit all the non-bql drivers with
>> > >those two checks? I haven't investigated this part.
>> >
>> > Nope. What I say is, if there are other users, let's find them and let
>> > them use what you are introducing here. Otherwise don't add unused code.
>>
>>
>> Additionally, it looks like virtio is going to become a
>> "sometimes BQL sometimes no-BQL" driver, so what's the plan -
>> to set/clear the flag accordingly then? What kind of locking
>> will be needed?
>
>Could we consider the default mode is BQL, so we can remove that new
>IFF_NO_BQL flag? If it's hard to take care of these two situations, I
>think we could follow this suggestion from Jakub: "netdev_uses_bql()
>is best effort". What do you think?

Make sense.

Also, note that virtio_net bql utilization is going to be not only
dynamically configured, but also per-queue. It would be hard to expose
that over one device flag :)


>
>>
>> > >
>> > >>
>> > >>
>> > >> >
>> > >> >After your patch gets merged (I think it will take some time), you
>> > >> >could simply remove that one line in virtio_net.c.
>> > >> >
>> > >> >Thanks.
>>

