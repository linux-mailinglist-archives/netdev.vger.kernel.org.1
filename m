Return-Path: <netdev+bounces-103118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC49065AA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E41C22E61
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3D13C9D2;
	Thu, 13 Jun 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IWUbiyLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EBF13CA87
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265069; cv=none; b=MgkPl24AxKete5wNv+KNs2/bhslR/jfGWmJgZnW5SoJFD6JQEEodb4xVzS/NqbuYfQjWnjWGlYARagR2KiXSn36xx/49KQa7vu71P3kWL3oIVP3IDRp4IrQf/4YYgbQE4v/HaKpyce8V2hmF1BA6pSkKog+8erDUkrNgeE6J0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265069; c=relaxed/simple;
	bh=QlZvMsihDKgOGZ0YcdXI9OPSFSORcRYfFTl6DwBWbP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p45PLA1S+F84i+eTC5iWexoRAfPKZVP0Sn/cOXiKxdXgDr43TcYuz6ImWFiU0LszOetxNCWAQXMwEoASEw/hhcU2ijTRXxBVcLtY/LU4upRAlrD7gt1hGPFVGghyVg+1nP+LCc7kuRTV2EBNVFXF/0ksYsR2+sFHnGgwtbgxTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IWUbiyLt; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-42121d27861so6909615e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718265065; x=1718869865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlZvMsihDKgOGZ0YcdXI9OPSFSORcRYfFTl6DwBWbP8=;
        b=IWUbiyLt78cLOjeA0cT0jpa0XchQUWYTrT0+mChIH+HWhoU2xQp6mJHYPjAtu0uMjZ
         VlNdUYYPtAJso76cGSJojP0dbQDZ1Ggg1xV9rrvP4hV0oyItDq7yeWXtC69TOyK/5m6n
         BKJJnj6XHzYSS7aI9vVuriNAnkhy3vA7A4XW4T1Pe+bMexWCRYkzatvOFubOnSPax1b2
         8pu2jZGxNYUPFTmsf+YLHGVzbG0uDI0xdLBVAyo6BcT+uwFO2pc6IqNBclVEoOYL86si
         +a7PqCnxu39Eh3R4y5cYFPHl1wYepv8SUrPRB+TZwT8qM0+3aE7BaAVJI7rq2CF783GI
         HMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265065; x=1718869865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlZvMsihDKgOGZ0YcdXI9OPSFSORcRYfFTl6DwBWbP8=;
        b=mCfsKd0QxMlpIIJO5WBMfOjmxa9LGaQ86Fq9OQFGoFnKThoAIkfufPbs0LHb1kzvYv
         AcJYXXFLN9uWu7RnW2lZgLUTPiuEOKmPS1xoOulBoRT3gUQf99+K7cTll8PWJNLfLVDY
         8H8LlZ7PxGLBCFyZeTi8IlN9AxpGwsQtkf+oZrqcv5nzB5cbmOmdzGkCrEPKPlzq8i4P
         Gx9HJzElrC5aukyYOAUrVuqKEzHPelDq2DUd4O4flfXW16fd3JAGWtodhwTASvIzntbc
         SUQftMD89mHgDFhBFLKaVbKRBQM2h+22UO9qQpv2//pLtLXhJhnm29HAgOhQRkMQANkS
         yMHw==
X-Forwarded-Encrypted: i=1; AJvYcCWDdkLFSmYfTawRhhUR79i5lWetslXsgabA4H0jHatbXxWjbnTDjJKaJjIw35pEgA30ebOE2pUMUGUjHAnIUZk0B4HD8es+
X-Gm-Message-State: AOJu0YyGy73Tw18Zk/X6Rdt7WAKBa60bZ8qfQRN70YSqNOTRV2WEeYLm
	r7EJfFh7D3H0MWflgkMttavqC2ZHSEM8nZFW4DBsAadTjRW5LMP4+bDlX6av8eA=
X-Google-Smtp-Source: AGHT+IHkyXFn+cWYwH11H8DBLIVmSEjAZ8VktwxPbq6Vemp3YIIKGB1RUzklxVHGkTs6kCa6FvXKjA==
X-Received: by 2002:a05:600c:4ecf:b0:421:7aad:370a with SMTP id 5b1f17b1804b1-422863adb55mr32013835e9.9.1718265064871;
        Thu, 13 Jun 2024 00:51:04 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602efc4sm13581765e9.15.2024.06.13.00.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:51:04 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:51:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <Zmqk5ODEKYcQerWS@nanopsycho.orion>
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
 <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion>
 <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>

Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrote:
>On Thu, Jun 13, 2024 at 3:19 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
>> >On Thu, Jun 13, 2024 at 1:38 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
>> >> >From: Jason Xing <kernelxing@tencent.com>
>> >> >
>> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
>> >> >BQL device") limits the non-BQL driver not creating byte_queue_limits
>> >> >directory, I found there is one exception, namely, virtio-net driver,
>> >> >which should also be limited in netdev_uses_bql(). Let me give it a
>> >> >try first.
>> >> >
>> >> >I decided to introduce a NO_BQL bit because:
>> >> >1) it can help us limit virtio-net driver for now.
>> >> >2) if we found another non-BQL driver, we can take it into account.
>> >> >3) we can replace all the driver meeting those two statements in
>> >> >netdev_uses_bql() in future.
>> >> >
>> >> >For now, I would like to make the first step to use this new bit for dqs
>> >> >use instead of replacing/applying all the non-BQL drivers in one go.
>> >> >
>> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
>> >> >new non-BQL drivers as soon as we find one.
>> >> >
>> >> >After this patch, there is no byte_queue_limits directory in virtio-net
>> >> >driver.
>> >>
>> >> Please note following patch is currently trying to push bql support for
>> >> virtio_net:
>> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.us/
>> >
>> >I saw this one this morning and I'm reviewing/testing it.
>> >
>> >>
>> >> When that is merged, this patch is not needed. Could we wait?
>> >
>> >Please note this patch is not only written for virtio_net driver.
>> >Virtio_net driver is one of possible cases.
>>
>> Yeah, but without virtio_net, there will be no users. What's the point
>> of having that in code? I mean, in general, no-user kernel code gets
>> removed.
>
>Are you sure netdev_uses_bql() can limit all the non-bql drivers with
>those two checks? I haven't investigated this part.

Nope. What I say is, if there are other users, let's find them and let
them use what you are introducing here. Otherwise don't add unused code.

>
>>
>>
>> >
>> >After your patch gets merged (I think it will take some time), you
>> >could simply remove that one line in virtio_net.c.
>> >
>> >Thanks.

