Return-Path: <netdev+bounces-92709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FD8B858A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA39B282E53
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290E4CB2B;
	Wed,  1 May 2024 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLEnVrO5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC64C62A
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714544578; cv=none; b=mSoa6yRt2o/N9XE1NRniEaXE20fItFE2VWnzd0we0OrkQEwxwgFHFKgGT4EyuFP7RACOrLRaKzrmu9VYsEBbNfH808miACc/81kiJJfP4FohsnsThjyNz0A8GlwxmWMAixxwg7fmGUut7Fidqo1+qze557w86fouKmTfTttvDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714544578; c=relaxed/simple;
	bh=upq73+EhxBOo0PVL/mv6ZHgGqLvRsO4ZGE/0KRXpo5k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RtY5krEaMPZFg0ODV2ri9rOj0fBNFwOKezy6LfRSgT+nFIP/01QZJJsUnqn1YqG6TkLkIRzMKU//cGTHE7YrBsGi9ay0XL0omHN2RYKzv/x/l3EfrdFK7wKi5BtYmdc5geXGRRRTju1L4fn+AOsuXWzhKfjqdv6ugU2lZLMsSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLEnVrO5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ab48c1c007so1673342a91.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714544576; x=1715149376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feNhaIGXYhfEj5WxJT19Aa4Z7ws65mTA3AGt1rarXio=;
        b=DLEnVrO5uIf/SyCSI2lGAryDZtaK8yXWdosX8IXIpIEonGChXBpm4QH7B+raAdzTcx
         iJJuksux9VZG6kwwgWmZ5hLfEjw0hD9ToH/GZ36YIV04HxEVM+PP2tFKGq2YnAxZIUal
         LI+dlXZ1emgIkQbpNjKGZ4KVhjuc9ld/OCXeKqpZnigbysWo6aTRLOI8IynpYcGElppT
         ityzh3Jzb0HUnzd4dfE6IHNDWLSLRRCyVl2lZ4A+uWSSvnXO06hCS8onBJlgxUcNJDYU
         4cQTL578QWgU9lgU7RHYAPhLugSQcD+yJfhh537mmQmUkUIT/Dtz9r/YVuSfBVeC6JRe
         uucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714544576; x=1715149376;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=feNhaIGXYhfEj5WxJT19Aa4Z7ws65mTA3AGt1rarXio=;
        b=R650dj52uEC8KMOUiRKw94EHOQW9NrGEeGDes5F/GS9U5VJUJ1XdjE/7jnVl2k76yl
         kjaZEB2H/R8T8YWItR5BH7gkvxjZnC25MwdYcsRDhOO9aGCTR184hBf3ydqPBwknMDTi
         ZcOJ9tw56tUXIM361zOSna6B9GI0MXeqOYl6XBkaH+Tts9p+cddPqqkAw7YjT9fkZIuY
         H/aDlaD6XHF8HrT4K/SJ26c1yGJu7SWCnUYqLyklPhk5aAMd1isWaOcpt3SOT+oPAndh
         Wq1zm7TfYBNK5J4kHAJYbNiwVXHiJdLZL+9fCrmHu9FzVd66MzRuKN60RneZuTgTqGy/
         HUhg==
X-Forwarded-Encrypted: i=1; AJvYcCVT8WVFW1GZXq8HfpmMZuwmC7YZYo9vABZUnj4F4ANytIHoV2Gd0g2DVHGfU+DA/IwZm9wAo7+r2rEU4tzx0q4SxPmhTFYo
X-Gm-Message-State: AOJu0YzN1p724zVJY/HgS1sY1efr6Gj72UbxElE102fvvtoXu5uGILgn
	J7Sb87cB+6PuLEnWLix3/ukyPGy4x0ox0K9NdQyyd9g3tuV1OQLY210UeZDC
X-Google-Smtp-Source: AGHT+IE9zG8YxMM3rT73c/8cAKEx3ZUWev7cTBgX+xv7J6hp20JlvhbEm4Zw4Ff+u0a5kQ1kT+aBFw==
X-Received: by 2002:a17:902:ec89:b0:1e2:b3d:8c67 with SMTP id x9-20020a170902ec8900b001e20b3d8c67mr1536286plg.6.1714544575769;
        Tue, 30 Apr 2024 23:22:55 -0700 (PDT)
Received: from localhost (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090341cd00b001eb492fdf93sm7766245ple.146.2024.04.30.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:22:55 -0700 (PDT)
Date: Wed, 01 May 2024 15:22:52 +0900 (JST)
Message-Id: <20240501.152252.1283306844636725107.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v3 5/6] net: tn40xx: add mdio bus support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <1dc56a84-771a-478c-b302-769186d6497e@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
	<20240429043827.44407-6-fujita.tomonori@gmail.com>
	<1dc56a84-771a-478c-b302-769186d6497e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 30 Apr 2024 22:51:52 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
>> index a93b83e343d3..2719a31fe86c 100644
>> --- a/drivers/net/ethernet/tehuti/tn40.h
>> +++ b/drivers/net/ethernet/tehuti/tn40.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/if_vlan.h>
>>  #include <linux/in.h>
>>  #include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/ip.h>
>>  #include <linux/module.h>
>>  #include <linux/netdevice.h>
> 
>> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
>> @@ -0,0 +1,132 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (c) Tehuti Networks Ltd. */
>> +
>> +#include "tn40.h"
>> +
> 
> Part of the reason we want to see includes here, and not in a .h file
> is that you are including lots of things which an MDIO driver does not
> need. That slows down the build.

Understood, fixed.

>> +static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
>> +{
>> +	void __iomem *regs = priv->regs;
>> +	int mdio_cfg;
>> +
>> +	mdio_cfg = readl(regs + TN40_REG_MDIO_CMD_STAT);
>> +	if (speed == 1)
>> +		mdio_cfg = (0x7d << 7) | 0x08;	/* 1MHz */
>> +	else
>> +		mdio_cfg = 0xA08;	/* 6MHz */
>> +	mdio_cfg |= (1 << 6);
> 
> Is there any documentation about these bits? 

No information in the original code.

>> +static int tn40_mdio_get(struct tn40_priv *priv, u32 *val)
>> +{
>> +	u32 stat;
>> +	int ret;
>> +
>> +	ret = readx_poll_timeout_atomic(tn40_mdio_stat, priv, stat,
>> +					TN40_GET_MDIO_BUSY(stat) == 0, 10,
>> +					10000);
>> +	return ret;
> 
> You don't need the ret variable. Just:
> 
> 	return readx_poll_timeout_atomic(...);

Oops, fixed.

