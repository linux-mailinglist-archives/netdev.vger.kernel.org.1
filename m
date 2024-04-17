Return-Path: <netdev+bounces-88591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0958A7D02
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351B4282DA5
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F26E613;
	Wed, 17 Apr 2024 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="l3fWh4v5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF76A8A7
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338579; cv=none; b=CLzIr/7B0cBGOGhdFfjJIEK/jrrvImCtPI4ng/YOsvBW/W/VwGkvAmyeLCwb1a3+fVcUCgRClNKy6z0eB2SHpWW1R0A4GRY8eAuqnrP6lH4YGQXw+q6sbZxyFdzQOntVHBQpiw2kE39ni2PnYaKHXm6ttiBM7pesHbOyYi72sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338579; c=relaxed/simple;
	bh=A9w0TNw8xOwwO7aK3Yc6awMgv37h3KiP86rdJZ3sluo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt83ONzpAglhU92CGfeIyh1ISSsbaYF3ypb86WNhpzAz+ZtnnrqO72GwmjNoJo5A1VFurda1YryAK/7lBuHVQ5VegFWKd7MWNdQYK5t97K6d1hFtqvTExbbVa81joNPKrjgK843pWyTfPws4PqSZMLjH+gtAD4PdvAeVBiSm9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=l3fWh4v5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41879819915so17682645e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713338575; x=1713943375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1fZRmtUCzpag8fleysfaO/F+gV8nCRc5HsAwDzsIyo=;
        b=l3fWh4v5wr4HyP5qFZnna7nwKbRKVWQu1qbG0n1LoHROCF9O6kUoldTA3Cq2Mjpas6
         5Fr3amvmSleDDYezmWvojXERDKAUjtbBliXDE6Rn+P6vS7LKYMCJA15ogop2mEN773SV
         vWp//1SZEFiASc89KDMjfshgO0PRvHEZgAH0s0+L121zBdwPY0etGqTYkE+Y3qozQxzV
         o5YO7LfW6G+v2glrEmzgnNaXI4/ODhBd1zBTgYv5t2evSwwHlDOyW2S1YhSWXu4aOxnm
         d40tuKeyUugJSy+tiF1GYuO3WppFT2DVzPBwnCHRzyXfmRitXDeM+t934mBEmeqtaXJZ
         cNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338575; x=1713943375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1fZRmtUCzpag8fleysfaO/F+gV8nCRc5HsAwDzsIyo=;
        b=QW6/TmW8YE4GwlqgrXCPnxR91Q3c1wOEatZeU+hFtmdTRKA23kMhYFnv+4AjApiIA4
         DGRdsFCOJIi42hU6ogaYMkv/N9t27ZjchTCaK9uJE/Ybt8ld19/NMnu830Pq+zQCjRaL
         R55VkWdgY1fNaaPIDZ1GhT8eG8OdiQK9eyi5RovKuG2n1CC6cfbNcgsZ4LIf7cVRD2jI
         16+0GEeA7H8t9tgQYDRE31kf78VZLhnpPUstii7aGIBzbs+aBIx/AR2A2OoKqEb1n3Jk
         oE/kMXZkpK2Uyhg9ERTKt1chmgEx5HLjG6px+5dADoM4cWnJWOoxcSakbgqwesscwEDW
         qycA==
X-Gm-Message-State: AOJu0Yxh7RYtJxCZrmtIwabRbRdBv+s9yjm25blEHi78JE+VXc7KQHrQ
	GQRqKwxwfKHJa1g8snGDDR9tEX2D5O716REFMkPgwg8BNuPM3JQeaaFZ6oRbm24=
X-Google-Smtp-Source: AGHT+IHOMJ6tvg51q7LMCwZaW8Psh5Qlr9UINCBTzEN2w/aV4BJkd1soo+fKHO3Uwy83GP++CdPA3w==
X-Received: by 2002:a05:600c:4f07:b0:414:726:87d9 with SMTP id l7-20020a05600c4f0700b00414072687d9mr13509829wmq.12.1713338575493;
        Wed, 17 Apr 2024 00:22:55 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d5104000000b00346f9071405sm14418312wrt.21.2024.04.17.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:22:55 -0700 (PDT)
Date: Wed, 17 Apr 2024 09:22:53 +0200
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
Message-ID: <Zh94zX-oQs96tuKk@nanopsycho>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
 <Zh5G0sh62hZtOM0J@nanopsycho>
 <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>

Wed, Apr 17, 2024 at 06:37:30AM CEST, jasowang@redhat.com wrote:
>On Tue, Apr 16, 2024 at 5:37 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
>> >On Tue, Apr 16, 2024 at 12:25 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>
>> >> Currently there is no way for user to set what features the driver
>> >> should obey or not, it is hard wired in the code.
>> >>
>> >> In order to be able to debug the device behavior in case some feature is
>> >> disabled, introduce a debugfs infrastructure with couple of files
>> >> allowing user to see what features the device advertises and
>> >> to set filter for features used by driver.
>> >>
>> >> Example:
>> >> $cat /sys/bus/virtio/devices/virtio0/features
>> >> 1110010111111111111101010000110010000000100000000000000000000000
>> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
>> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
>> >> 5
>> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
>> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
>> >> $ cat /sys/bus/virtio/devices/virtio0/features
>> >> 1110000111111111111101010000110010000000100000000000000000000000
>> >>
>> >> Note that sysfs "features" know already exists, this patch does not
>> >> touch it.
>> >>
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >
>> >Note that this can be done already with vp_vdpa feature provisioning:
>> >
>> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
>> >Author: Jason Wang <jasowang@redhat.com>
>> >Date:   Tue Sep 27 15:48:10 2022 +0800
>> >
>> >    vp_vdpa: support feature provisioning
>> >
>> >For example:
>> >
>> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
>>
>> Sure. My intension was to make the testing possible on any virtio
>> device.
>
>It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
>with mediation layer (like feature filtering etc). So it can only run
>on top of standard virtio-pci device.
>
>> Narrowing the testing for vpda would be limitting.
>
>Unless you want to use other transport like virtio-mmio.

Also, the goal is to test virtio_net emulated devices. There are couple
of implementation. Non-vdpa.


>
>Thanks
>
>>
>>
>> >
>> >Thanks
>> >
>>
>

