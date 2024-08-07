Return-Path: <netdev+bounces-116453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE694A723
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2705A28225A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0C1DF68A;
	Wed,  7 Aug 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KYThlzXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09EA1E2880
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031006; cv=none; b=QGgALhsgutFJcXR/Sx9ehYZTJIDgsZIWqYLs1Jjjc1wWTK4IVx4QFTlhFvrbYwOWmMBz+tvum+CB46YHlhRzoSZY2lnkSpa5h19fdpU6IHBwlRwJA707U+p7w447u6C1igF8rtJjo4fApxnBGWSIDOOg6j3YYbSdSibrfUElIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031006; c=relaxed/simple;
	bh=BiLTYjEEWbcsArt9gXF+patN1xl98emwcAg1k9odJHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIxCqFKoveUkR8oQrbjAN5/VyHZ3rYJRmXwgGwdTA2pTDPrNE7rsHjzaJtkGZ98NE9BMvLPCLqPHkcZFqe1EHByLuKbgX+HO9ve6wj9rh23BM0nyq2Wl03FwZLgdEazbPVZ+umIcBI4/32rqdN892b7nNAeZWIx4lZ+PbdkC/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KYThlzXj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367963ea053so1128628f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723031002; x=1723635802; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WPiTjPl0io56uoZTpMUq0Vu6LhIedWzhFK+Y40jYdDE=;
        b=KYThlzXjVUq/rVKsg7HDm7boxdHIDPNTeU4hd1qQltl6YGCChyl7UWKLmIHDytS1F+
         U2DmUo8cNXZRsXJ73Q/PnyIz11yKIzCkoKd06oZSWQulY1YWS5xwPjC6qkF+9h/0yu1d
         jhbQMqCta4/DRK6vxbjgaP6xegBSlHzHCoyUS5udBTP/9q/2XOXCdh3z9xC8xJ0Lg+Zo
         vznwj3SOIt4reWYaaKr59g0y5gJ7UfUi8VF6z/DBT06EnG2inYSjMaB/Y56Un9ikQV+9
         MiS7JSoImZUqfA+SKJPaDK+7Y4Y5o93KhYhQLybGUKjsbSsCRPzINjbDFQ6Dt8YRVmwp
         wTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031002; x=1723635802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPiTjPl0io56uoZTpMUq0Vu6LhIedWzhFK+Y40jYdDE=;
        b=h1nI8yAmlHSVBpC17c287NJDFXnqorp5iKLB99wUAB62e5IygVzFTEA/t0bltc0IFE
         kCUvoxpm+gzyp7OQL16GfuNbrtArMogVom7Cki48tAcZo921nFZu3g3lmvUbfFsm9lWI
         vFczkzRMAcr2qdWV7iI9pRcFGrlHuqurt97qDvo0IiwrHzdkqG2S52waAfB80qnbvcw6
         7KbMl9TFBeSpwBvgSanFM0YCqrIwmdp2bcoXBI8YAmwtGKjfVctx/tN5ofETCzCeLLsB
         iSstnR7oLX7OLVzThxJsfCeFOtpmP/MAlQHNXSa8IMocH6hV3N3nYLjVQS0lxBhNyrCd
         fLyg==
X-Forwarded-Encrypted: i=1; AJvYcCUR4UnkbPW9lo+ZcEM9dvyGaXsJ81qWfK7rHeOEp5BgXL7VlFr49VZLuseuqyTaPBPQgKJ2VGwViRc6ozhkCzeIn1fluvQZ
X-Gm-Message-State: AOJu0Yz8gZu4ZOdg4zmpIVeBdNvHBvey8QiTPQfRBC7T7i1mMplo5oa3
	zPQHfRsThlXj9+X6rzERtgMVkFe6UTxW/+5RhKvpUNf2lg4r9+wIHpOYS9J5CvihMXCtp8gfT9h
	O
X-Google-Smtp-Source: AGHT+IF8NV6Hxx2VUu4xf85hCiX85AbfOke1O4Oh0RIr3AWUZDWwDHmXoEHgRj1o33PeI4I9LqdGPg==
X-Received: by 2002:a05:6000:1789:b0:368:6337:4221 with SMTP id ffacd0b85a97d-36bbc1c7934mr18420085f8f.54.1723031001510;
        Wed, 07 Aug 2024 04:43:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059885sm15835898f8f.84.2024.08.07.04.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:43:20 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:43:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/10] net: libwx: add eswitch switch api for
 devlink ops
Message-ID: <ZrNd1_m3UduA9mT0@nanopsycho.orion>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>
 <20240805164350.GK2636630@kernel.org>
 <ZrIMLEqxn6UxQ7B1@nanopsycho.orion>
 <721C2E58-6348-4645-A932-0FF6499147B1@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <721C2E58-6348-4645-A932-0FF6499147B1@net-swift.com>

Wed, Aug 07, 2024 at 09:41:53AM CEST, mengyuanlou@net-swift.com wrote:
>
>
>> 2024年8月6日 19:42，Jiri Pirko <jiri@resnulli.us> 写道：
>> 
>> Mon, Aug 05, 2024 at 06:43:50PM CEST, horms@kernel.org wrote:
>>> On Sun, Aug 04, 2024 at 08:48:39PM +0800, Mengyuan Lou wrote:
>>> 
>>> Each patch needs a patch description describing not just what is done
>>> but why.
>>> 
>>> Also, please seed the CC list for patch submissions
>>> using get_maintainer this.patch. I believe that b4
>>> will do that for you.
>>> 
>>>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>>> 
>>> ...
>>> 
>>>> static void wx_devlink_free(void *devlink_ptr)
>>>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
>>>> new file mode 100644
>>>> index 000000000000..a426a352bf96
>>>> --- /dev/null
>>>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
>>>> @@ -0,0 +1,53 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Copyright (C) 2019-2021, Intel Corporation. */
>>> 
>>> Are you sure Intel holds the copyright on this code?
>>> 
>>>> +
>>>> +#include <linux/pci.h>
>>>> +
>>>> +#include "wx_type.h"
>>>> +#include "wx_eswitch.h"
>>>> +#include "wx_devlink.h"
>>>> +
>>>> +int wx_eswitch_mode_set(struct devlink *devlink, u16 mode,
>>>> + struct netlink_ext_ack *extack)
>>>> +{
>>>> + struct wx_dl_priv *dl_priv = devlink_priv(devlink);
>>>> + struct wx *wx = dl_priv->priv_wx;
>>>> +
>>>> + if (wx->eswitch_mode == mode)
>>>> + return 0;
>>>> +
>>>> + if (wx->num_vfs) {
>>>> + dev_info(&(wx)->pdev->dev,
>>>> + "Change eswitch mode is allowed if there is no VFs.");
>>> 
>>> maybe: Changing eswitch mode is only allowed if there are no VFs.
>>> 
>>>> + return -EOPNOTSUPP;
>>>> + }
>>>> +
>>>> + switch (mode) {
>>>> + case DEVLINK_ESWITCH_MODE_LEGACY:
>>>> + dev_info(&(wx)->pdev->dev,
>>>> + "PF%d changed eswitch mode to legacy",
>>>> + wx->bus.func);
>>>> + NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
>>>> + break;
>>>> + case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>>>> + dev_info(&(wx)->pdev->dev,
>>>> + "Do not support switchdev in eswitch mode.");
>>>> + NL_SET_ERR_MSG_MOD(extack, "Do not support switchdev mode.");
>>> 
>>> maybe: eswitch mode switchdev is not supported
>>> 
>>> I am curious to know if you are planning to implement eswitch mode in the
>>> near future.  If not, is wx_eswitch_mode_set() needed: it seems unused in
>>> this patchset: it should probably be added in a patchset that uses it.
>> 
>> This is wrong.
>> 
>> switchdev mode should be supported from the beginning. There is some odd
>> hybrid mode supported, VF gets devlink port created for representors,
>> yet no netdev. I'm very sure this triggers:
>> 
>> static void devlink_port_type_warn(struct work_struct *work)
>> {
>>        struct devlink_port *port = container_of(to_delayed_work(work),
>>                                                 struct devlink_port,
>>                                                 type_warn_dw);
>>        dev_warn(port->devlink->dev, "Type was not set for devlink port.");
>> }
>> 
>> So, if you don't see this message, leads to my assuptions this patchset
>> was not tested. Certainly odd.
>> 
>
>I have seen this warnning info.

Yet you ignore it. Awesome.


>What I want is that the devlink port Uapi to vfs, but I think the product will
>not to support switchdev mode and the representors representors will not be used.

Implement proper netdevs for VF representors in switchdev mode please.
Legacy mode should not create devlink ports.

>
>Be like:
>https://lore.kernel.org/netdev/20240620002741.1029936-1-kuba@kernel.org/
>
>> 
>>> 
>>>> + return -EINVAL;
>>>> + default:
>>>> + NL_SET_ERR_MSG_MOD(extack, "Unknown eswitch mode");
>>>> + return -EINVAL;
>>>> + }
>>>> +
>>>> + wx->eswitch_mode = mode;
>>>> + return 0;
>>>> +}
>>>> +
>>>> +int wx_eswitch_mode_get(struct devlink *devlink, u16 *mode)
>>>> +{
>>>> + struct wx_dl_priv *dl_priv = devlink_priv(devlink);
>>>> + struct wx *wx = dl_priv->priv_wx;
>>>> +
>>>> + *mode = wx->eswitch_mode;
>>>> + return 0;
>>>> +}
>>> 
>>> ...
>>> 
>> 
>

