Return-Path: <netdev+bounces-116060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE5948E06
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617F8287A33
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A61C3F1F;
	Tue,  6 Aug 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dOrJ8Jem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4A1C3F18
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944563; cv=none; b=Kq08/xGawFU3ZY/5OFflNervb059fl4YMHPuIcgDgU0kaQQQAiL9wx/+m8l4c9c6dDeHIlN9bncdjfJx+bgZmlqFdaAVck3wFxydZOqpQgZJ2rpdcaQNogLqxHA5o50DGOZvEZpLuBGcRLFMI1ORB+5o40hbfMXyILy2IBr+y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944563; c=relaxed/simple;
	bh=tvfKFP2sNk6Z+iZXM+Ef4Cu7GiyrgQAQsuK8Uxsj1KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKDf3Kp4or7bNozVy0NUIHpZ/sLOQXZSviw51LS/Mh1R8RaHz9dEo5oD1gCMusdw9uyWqmfxVuzRYRu0Og6fw5znF40s7BvX5lRnfA8MWby2EPrBSn3JAmtxDKQHz+973gk6jrpybB4r6zQKx3HQvC5f4mqwDkYfa62M12AmWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dOrJ8Jem; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f136e23229so5131051fa.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722944558; x=1723549358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHJ/GcmyXBDRLhEJUDCUTIJ7olXqKiArFs07ifWfRhQ=;
        b=dOrJ8JemqjLshnHy5umowHVy4Oj7zTKrLw0c0cQOfpT3WxSwrf00SPklQgNrClGLad
         iU8Cd2Yan5b1kkDeiPpJ3AjnEWZaYe0JpbGHNuhz43goYBY1QD93VSTRoAiy9/97OZwC
         1wckDuF6KrD6VFINGgC5h0p3Cs16vumL7f1w+ya4TJV9K3Dm3JJ98zkt5Qz+isfT890w
         YS1RwX3LeQb7WSPnPh0ZFbFRrxcftAZHQEVZuiM3K/ILiCySpckPFFX8wapn17r6DPjV
         Wem4tE23StntJyQWsEFzuj7zbKBWN7M7vEd+l3Tsc/BPghISSqJI7bdYYh32fP+SFvKJ
         toTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944558; x=1723549358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHJ/GcmyXBDRLhEJUDCUTIJ7olXqKiArFs07ifWfRhQ=;
        b=ndTrgfmPqznd8cMbS+uwxEaUG/FkEt+5P71OOoq9+hmpi1cjxn/Esx8/tz6IHqznGR
         1KIaxpuKE/ejNDrEmMRc98Q5ImOMYmXEE3dUsUpaI1ePCQUTVXnJTlCBY5+yM6TW0pGL
         YMnXiUORWAKBRlrykJBfepoWT+PCmSqdU5p4yHaDY+0ed/LLEfGBnQPnMPjkKjbqNHZs
         z2fUe4cO4nmrrSezu2yGb2ePE1n7xUWVrginqGWPFD8mItNpS7Cq+jpF45+pvKhG0+WX
         mRbdUHa46nJOCsvxhzy7NK9pvbbeTiUNclouQsLKmTVNkG4WN+AK8bhqEcQjzy4Xdl1e
         AyhA==
X-Forwarded-Encrypted: i=1; AJvYcCW4PuXGTk/7+42jGHT8rCRbbj/WmcILpUJDz7Q2b6rnvW42cOId+F0hIYiCGG/morWV8dU0JV2wbO4mpyj/s4vY+1cbZlJ5
X-Gm-Message-State: AOJu0YyyhI64C+HWsldRlY7+y8JbTsprWyo/6UbIuPF0+1pndBQciw8H
	heoTopG/vD459G5fI63nYs3uqRPhqePWl/g7CiaASGhMvVp7bUlmlnLhq96obgI=
X-Google-Smtp-Source: AGHT+IHJ/3RpqIpck9bxccLZqpNXB07ZbOxRN0xMXrnl7I08MyGxVrzUv2sl569AMcQ/nhl45ITuyw==
X-Received: by 2002:a05:6512:a93:b0:52e:9cb1:d254 with SMTP id 2adb3069b0e04-530bb39dc80mr9689762e87.46.1722944558164;
        Tue, 06 Aug 2024 04:42:38 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3c4fsm543161066b.33.2024.08.06.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:42:37 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:42:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/10] net: libwx: add eswitch switch api for
 devlink ops
Message-ID: <ZrIMLEqxn6UxQ7B1@nanopsycho.orion>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>
 <20240805164350.GK2636630@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805164350.GK2636630@kernel.org>

Mon, Aug 05, 2024 at 06:43:50PM CEST, horms@kernel.org wrote:
>On Sun, Aug 04, 2024 at 08:48:39PM +0800, Mengyuan Lou wrote:
>
>Each patch needs a patch description describing not just what is done
>but why.
>
>Also, please seed the CC list for patch submissions
>using get_maintainer this.patch. I believe that b4
>will do that for you.
>
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>
>...
>
>>  static void wx_devlink_free(void *devlink_ptr)
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
>> new file mode 100644
>> index 000000000000..a426a352bf96
>> --- /dev/null
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2019-2021, Intel Corporation. */
>
>Are you sure Intel holds the copyright on this code?
>
>> +
>> +#include <linux/pci.h>
>> +
>> +#include "wx_type.h"
>> +#include "wx_eswitch.h"
>> +#include "wx_devlink.h"
>> +
>> +int wx_eswitch_mode_set(struct devlink *devlink, u16 mode,
>> +			struct netlink_ext_ack *extack)
>> +{
>> +	struct wx_dl_priv *dl_priv = devlink_priv(devlink);
>> +	struct wx *wx = dl_priv->priv_wx;
>> +
>> +	if (wx->eswitch_mode == mode)
>> +		return 0;
>> +
>> +	if (wx->num_vfs) {
>> +		dev_info(&(wx)->pdev->dev,
>> +			 "Change eswitch mode is allowed if there is no VFs.");
>
>maybe: Changing eswitch mode is only allowed if there are no VFs.
>
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	switch (mode) {
>> +	case DEVLINK_ESWITCH_MODE_LEGACY:
>> +		dev_info(&(wx)->pdev->dev,
>> +			 "PF%d changed eswitch mode to legacy",
>> +			 wx->bus.func);
>> +		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
>> +		break;
>> +	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>> +		dev_info(&(wx)->pdev->dev,
>> +			 "Do not support switchdev in eswitch mode.");
>> +		NL_SET_ERR_MSG_MOD(extack, "Do not support switchdev mode.");
>
>maybe: eswitch mode switchdev is not supported
>
>I am curious to know if you are planning to implement eswitch mode in the
>near future.  If not, is wx_eswitch_mode_set() needed: it seems unused in
>this patchset: it should probably be added in a patchset that uses it.

This is wrong.

switchdev mode should be supported from the beginning. There is some odd
hybrid mode supported, VF gets devlink port created for representors,
yet no netdev. I'm very sure this triggers:

static void devlink_port_type_warn(struct work_struct *work)
{
        struct devlink_port *port = container_of(to_delayed_work(work),
                                                 struct devlink_port,
                                                 type_warn_dw);
        dev_warn(port->devlink->dev, "Type was not set for devlink port.");
}

So, if you don't see this message, leads to my assuptions this patchset
was not tested. Certainly odd.



>
>> +		return -EINVAL;
>> +	default:
>> +		NL_SET_ERR_MSG_MOD(extack, "Unknown eswitch mode");
>> +		return -EINVAL;
>> +	}
>> +
>> +	wx->eswitch_mode = mode;
>> +	return 0;
>> +}
>> +
>> +int wx_eswitch_mode_get(struct devlink *devlink, u16 *mode)
>> +{
>> +	struct wx_dl_priv *dl_priv = devlink_priv(devlink);
>> +	struct wx *wx = dl_priv->priv_wx;
>> +
>> +	*mode = wx->eswitch_mode;
>> +	return 0;
>> +}
>
>...
>

