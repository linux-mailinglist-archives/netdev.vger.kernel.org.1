Return-Path: <netdev+bounces-103263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7210D90753D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A5AB230AD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207114265A;
	Thu, 13 Jun 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bJdOM3pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BB146004
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289285; cv=none; b=ett4S081ah27iqsFH+LrD7mNsGj1LELuaiXGKeTETDSI9LMPmW0evmE/n7/Ot6N0rgcbblfFHxurjlfNKQ1KiyzgGC52h7hLv3tQqbtWDVxeFptVw6NME/hMzjw3r1XZS4PvZ0RDWWs7eaYdjOaBwvUp0tOqJq9FSWfuW+qocKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289285; c=relaxed/simple;
	bh=E+PbljG/AHjK8JT/n3LEefgI2iQ66K3U3UvR8MXoSSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzOYD/fRjIMGTD9fdE8Osil7+F0r3HQTTDU5DBtATfzgaGm/2IEDLTWK3LFkpYsP3e/AmGn5Zqcvprc70emQvTkGndTcOsQ+qd/+PEm3DfyIAgey/LxlDy8o4GFlnZnZ26jdQy4WmAx9hMrHrb1WA3fOn1wpWkNg+hAgS1ISOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bJdOM3pf; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso1103112e87.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718289281; x=1718894081; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+PbljG/AHjK8JT/n3LEefgI2iQ66K3U3UvR8MXoSSE=;
        b=bJdOM3pfZSqiD8dvPenXGImVMWE9zPyi5hBTOQcKP9W5NQxwneVT4zAEzsMVliKW+W
         MAsJSSploWMRxm5NTAMLlsN5qSHZt/eNN2uxpbi04fV1i50kW/elzk4uAt/1srodiouB
         J+pMdQ1lK93RpJI6e1bxqqCRbw3zvvcj9YJfmq4OmmTN/wXB+8AR3E7tx3pMlD59fPhW
         Kq/hvGff0oKX7K4zrCDmTYE17SmjCcpB75jHtJhgjzyJhRV/sDycB59cWCormsSJI+HM
         Gdu1JY043PkdAYF8PST8SiWSvMc99HMR0rISQeVkTQhTv1plaavr5iGRrOZDSmRR84Oo
         Fj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718289281; x=1718894081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+PbljG/AHjK8JT/n3LEefgI2iQ66K3U3UvR8MXoSSE=;
        b=cZPqQ+5wzUMPvf4NQzME1J/Mn4JFfBXH1gaHTvQqKwHp0q6uRU3e010VGR2GI6zpvs
         aTF2ux907QFGxnPEUZsKL6HF/4cla5K58rn+tDIA7W0LW6QH7DSAQygae5Xykf3m+08t
         uKNvjWH5y63SplPnXzcK9ACA+0vuBKPCTyA+/1GC5AWlu7NPNUAOKWCYTkAsP3X2RzCg
         wOKCCNfDZssAcLvV9b+mBASQRx1PkB3maWQMN+Y30xafoA3VA7G18BnYHP/9/2kldJQL
         hhYDoUSe1dEv2C31OJi3vKB2KdwWbaFGDw29SMLHO8+b8DqRoxL//Hqk+v9lYOIXUFVz
         SACQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlQnFpGy85xxrWolgOXCTk8qm9Zmnij2jCPXPOdVOw+hfr/9VxoRS9YmPxMGTl7HkwnjNAHGr1kT18ZFo8MMXPXP9gc3oW
X-Gm-Message-State: AOJu0YxjWbshd61oDt5Rcudk93RW0ekeTcSlQx1UrLXxuzA3X21XhT/z
	wHgZ/yfM32DTLKrG/Ux20qyIFS7F5ubp3rovetibp/VMkBscjOvjYU5fblcYdc4=
X-Google-Smtp-Source: AGHT+IEqGjKaB+LBBnRLz1rtZoEXnb6lYVgiiDwgVQjlDaHyxmX0GRvfRRrhFJNx5CeMuibc2u5vhQ==
X-Received: by 2002:a19:c514:0:b0:52b:beea:ee45 with SMTP id 2adb3069b0e04-52c9a400d4bmr2631534e87.53.1718289281235;
        Thu, 13 Jun 2024 07:34:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9193sm64295285e9.21.2024.06.13.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:34:40 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:34:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	dsahern@kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <ZmsDfS24IJAWAmvK@nanopsycho.orion>
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
 <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion>
 <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
 <Zmqk5ODEKYcQerWS@nanopsycho.orion>
 <20240613035148-mutt-send-email-mst@kernel.org>
 <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com>
 <ZmrxdwR2srw11Blo@nanopsycho.orion>
 <CAL+tcoBu0mCDeDTdEYZ5ccboYOuFeBfbNYvefo2dOWgoxAPg+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBu0mCDeDTdEYZ5ccboYOuFeBfbNYvefo2dOWgoxAPg+Q@mail.gmail.com>

Thu, Jun 13, 2024 at 04:11:12PM CEST, kerneljasonxing@gmail.com wrote:
>On Thu, Jun 13, 2024 at 9:17 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 13, 2024 at 11:26:05AM CEST, kerneljasonxing@gmail.com wrote:
>> >On Thu, Jun 13, 2024 at 3:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>
>> >> On Thu, Jun 13, 2024 at 09:51:00AM +0200, Jiri Pirko wrote:
>> >> > Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrote:
>> >> > >On Thu, Jun 13, 2024 at 3:19 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > >>
>> >> > >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
>> >> > >> >On Thu, Jun 13, 2024 at 1:38 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > >> >>
>> >> > >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
>> >> > >> >> >From: Jason Xing <kernelxing@tencent.com>
>> >> > >> >> >
>> >> > >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
>> >> > >> >> >BQL device") limits the non-BQL driver not creating byte_queue_limits
>> >> > >> >> >directory, I found there is one exception, namely, virtio-net driver,
>> >> > >> >> >which should also be limited in netdev_uses_bql(). Let me give it a
>> >> > >> >> >try first.
>> >> > >> >> >
>> >> > >> >> >I decided to introduce a NO_BQL bit because:
>> >> > >> >> >1) it can help us limit virtio-net driver for now.
>> >> > >> >> >2) if we found another non-BQL driver, we can take it into account.
>> >> > >> >> >3) we can replace all the driver meeting those two statements in
>> >> > >> >> >netdev_uses_bql() in future.
>> >> > >> >> >
>> >> > >> >> >For now, I would like to make the first step to use this new bit for dqs
>> >> > >> >> >use instead of replacing/applying all the non-BQL drivers in one go.
>> >> > >> >> >
>> >> > >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
>> >> > >> >> >new non-BQL drivers as soon as we find one.
>> >> > >> >> >
>> >> > >> >> >After this patch, there is no byte_queue_limits directory in virtio-net
>> >> > >> >> >driver.
>> >> > >> >>
>> >> > >> >> Please note following patch is currently trying to push bql support for
>> >> > >> >> virtio_net:
>> >> > >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.us/
>> >> > >> >
>> >> > >> >I saw this one this morning and I'm reviewing/testing it.
>> >> > >> >
>> >> > >> >>
>> >> > >> >> When that is merged, this patch is not needed. Could we wait?
>> >> > >> >
>> >> > >> >Please note this patch is not only written for virtio_net driver.
>> >> > >> >Virtio_net driver is one of possible cases.
>> >> > >>
>> >> > >> Yeah, but without virtio_net, there will be no users. What's the point
>> >> > >> of having that in code? I mean, in general, no-user kernel code gets
>> >> > >> removed.
>> >> > >
>> >> > >Are you sure netdev_uses_bql() can limit all the non-bql drivers with
>> >> > >those two checks? I haven't investigated this part.
>> >> >
>> >> > Nope. What I say is, if there are other users, let's find them and let
>> >> > them use what you are introducing here. Otherwise don't add unused code.
>> >>
>> >>
>> >> Additionally, it looks like virtio is going to become a
>> >> "sometimes BQL sometimes no-BQL" driver, so what's the plan -
>> >> to set/clear the flag accordingly then? What kind of locking
>> >> will be needed?
>> >
>> >Could we consider the default mode is BQL, so we can remove that new
>> >IFF_NO_BQL flag? If it's hard to take care of these two situations, I
>> >think we could follow this suggestion from Jakub: "netdev_uses_bql()
>> >is best effort". What do you think?
>>
>> Make sense.
>>
>> Also, note that virtio_net bql utilization is going to be not only
>> dynamically configured, but also per-queue. It would be hard to expose
>> that over one device flag :)
>
>At that time, I would let virtio_net driver go, that is to say, I
>wouldn't take it into consideration in netdev_uses_bql() since it's
>too complicated.
>
>BTW, hope to see your per-queue configured feature patchset soon :)

It's done already. See virtnet_set_per_queue_coalesce()
if ec->tx_max_coalesced_frames is 0, napi_weight is set to 0 and napi
orphan mode is used.


>
>>
>>
>> >
>> >>
>> >> > >
>> >> > >>
>> >> > >>
>> >> > >> >
>> >> > >> >After your patch gets merged (I think it will take some time), you
>> >> > >> >could simply remove that one line in virtio_net.c.
>> >> > >> >
>> >> > >> >Thanks.
>> >>

