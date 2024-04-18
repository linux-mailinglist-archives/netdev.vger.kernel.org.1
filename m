Return-Path: <netdev+bounces-89055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84358A94F6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344121F21A65
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D83F12FB18;
	Thu, 18 Apr 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lFpyifOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9A1E497
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428927; cv=none; b=efLpB80VA2ri+jSY1FZ0QrYlZDo2CPAozXOgG6w6AiHmPhwF0xi++vEOKb+6DMzqU058WVzrT8Y7HqvtMj17QlUxTLmd4r+DsMR7SkhbtOzF3n1+fikwE/2d41mreDlxaZYdl8gtYQ3tNQGxUUhO5jYuZUlq/WxolT+CPxzkXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428927; c=relaxed/simple;
	bh=ZQlNvuxU1Ruuhia4AiY+CRXdS6bFMo/TL73YQJTuopc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3uogvSXtvVTU3XBvVuqGzMr9HN4rCXTST/tGdQX0+rJ0A7QKOz7+AzQxo2h656EncZu0gK1ZqHZN0PDfw3rHI6adCb0mmvmr2sxspieGY192vTpeP6pkAO/6QEhxjWaprLd7TOdpKdGx5EnJGyPWarCmRlKKcqzYlWn2SZDkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lFpyifOm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571bddd74c1so280829a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713428923; x=1714033723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00EHNLIhtTOTMUZiuikNl15VWRGSekrYgAUwPrFoFtQ=;
        b=lFpyifOmzmlAk3j5DWeX4O1xZzNFVIdRgCPNN3RXJypjjS0IJ+bX1T4YSc5M5drH9d
         qYFbl4iu7w1VO5lV8h7nNyH7fVCZpd77JxvCwE4RK0y0cIfmq51YDavHikPtnyMVJsQZ
         SJMZemY4VcK4yVXa0aBIRe0IaPeHZJ09uWeY8mHgyxJquP4p442lKRx3dwfw7OLK/093
         wAB4thrfJW7uLMNR5DT43t2Yr2ImCzgBjSHivxDpUoE4Zvms9e5Vm+0HJTjVadfW4bO9
         EDT1wgNdYJ04A0aRpZIGp5pbXooCMGtKE0so/fCXjPTMpoay+p4KzcXFAX2U1YbMwr0B
         ngAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713428923; x=1714033723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00EHNLIhtTOTMUZiuikNl15VWRGSekrYgAUwPrFoFtQ=;
        b=Ghj3E2kiQw4sSAcVxqfH2y/mBQFZaN08UzNrwRdiJ6X0mvj7oH8t/eHTdKtpgVm3XY
         6kcaBuwKqdYGKDYzlALctIWxJq2rgmDDgehGXG36dbT1kszJJ8WSrwuAKtUggSpbvCpu
         XLo47E//twkTTzdui/xn7SOmeuQhvcGf8+F2T+mK9j5c0PSPMxoXSKKfYzp45Kx5FGKi
         Vs+s5bgl/SXDUCz417Gr9HiIeoYKFQ50kW+1V0IK5+KZP1uNU38KojyvrE5N4oxa0tE/
         jZTVWvjZaqpP5kgT0VeGDBESarteqkP0P9dZRub8VuvrcwsCj+42Lr8eie1GaoQQVL2F
         FPNg==
X-Gm-Message-State: AOJu0YxTp1rb4S5okTJrTfuNQJtnkdtSRKOTRxjjPcclK+Eiyel7XCFj
	ta4/AiaLuOqHG84dCGRmMIjggj5JVwx65tPu3oSoQlzHCg3Wo5uqFl3wS67OIBM=
X-Google-Smtp-Source: AGHT+IELCQfsKbAJfRd6jWQR9/DGdQt4Kz33gV1dBsN0EjytMayF4FnnyYOWYDum+jCtoh41R8zKHg==
X-Received: by 2002:a17:906:cb95:b0:a52:3ff0:4a12 with SMTP id mf21-20020a170906cb9500b00a523ff04a12mr1295937ejb.18.1713428923382;
        Thu, 18 Apr 2024 01:28:43 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id k14-20020a17090627ce00b00a525669000csm576040ejc.154.2024.04.18.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:28:42 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:28:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
Message-ID: <ZiDZudK3PuSF_3sZ@nanopsycho>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
 <Zh5G0sh62hZtOM0J@nanopsycho>
 <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
 <Zh94zX-oQs96tuKk@nanopsycho>
 <CACGkMEtqJL1+D9byRLSFdFmo0aqoWAeHqmqyq+KEzoC8xhnEFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtqJL1+D9byRLSFdFmo0aqoWAeHqmqyq+KEzoC8xhnEFA@mail.gmail.com>

Thu, Apr 18, 2024 at 02:59:41AM CEST, jasowang@redhat.com wrote:
>On Wed, Apr 17, 2024 at 3:23 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Apr 17, 2024 at 06:37:30AM CEST, jasowang@redhat.com wrote:
>> >On Tue, Apr 16, 2024 at 5:37 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
>> >> >On Tue, Apr 16, 2024 at 12:25 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >>
>> >> >> Currently there is no way for user to set what features the driver
>> >> >> should obey or not, it is hard wired in the code.
>> >> >>
>> >> >> In order to be able to debug the device behavior in case some feature is
>> >> >> disabled, introduce a debugfs infrastructure with couple of files
>> >> >> allowing user to see what features the device advertises and
>> >> >> to set filter for features used by driver.
>> >> >>
>> >> >> Example:
>> >> >> $cat /sys/bus/virtio/devices/virtio0/features
>> >> >> 1110010111111111111101010000110010000000100000000000000000000000
>> >> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
>> >> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
>> >> >> 5
>> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
>> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
>> >> >> $ cat /sys/bus/virtio/devices/virtio0/features
>> >> >> 1110000111111111111101010000110010000000100000000000000000000000
>> >> >>
>> >> >> Note that sysfs "features" know already exists, this patch does not
>> >> >> touch it.
>> >> >>
>> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> ---
>> >> >
>> >> >Note that this can be done already with vp_vdpa feature provisioning:
>> >> >
>> >> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
>> >> >Author: Jason Wang <jasowang@redhat.com>
>> >> >Date:   Tue Sep 27 15:48:10 2022 +0800
>> >> >
>> >> >    vp_vdpa: support feature provisioning
>> >> >
>> >> >For example:
>> >> >
>> >> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
>> >>
>> >> Sure. My intension was to make the testing possible on any virtio
>> >> device.
>> >
>> >It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
>> >with mediation layer (like feature filtering etc). So it can only run
>> >on top of standard virtio-pci device.
>> >
>> >> Narrowing the testing for vpda would be limitting.
>> >
>> >Unless you want to use other transport like virtio-mmio.
>>
>> Also, the goal is to test virtio_net emulated devices.
>> There are couple
>> of implementation. Non-vdpa.
>
>So what I want to say is, vp_vdpa works for all types of virtio-pci
>devices no matter if it is emulated or hardware.

Sure, but I wanted to have a simple generic way, working on all virtio
devices, even the ones backed by a different transport, and without need
of extra vdpa layer.


>
>Thanks
>
>>
>>
>> >
>> >Thanks
>> >
>> >>
>> >>
>> >> >
>> >> >Thanks
>> >> >
>> >>
>> >
>>
>

