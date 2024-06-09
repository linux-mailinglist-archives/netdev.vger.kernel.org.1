Return-Path: <netdev+bounces-102086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 879F4901607
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367371F213AC
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5F24B5B;
	Sun,  9 Jun 2024 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSgCBlJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A520B33
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717934055; cv=none; b=oWTKldz6qKsa/NI8CvSxxKTOAgOtTFnMGdZPUhP7D090IQU2Z5v+XoK0RWuPebYDl8xhZvHRylSuaFAoy+t4eUBlk/gtB7Ef4HQBPH+Y2/2vgsTsU1meVLiobBPri4eXn5Va0MC2xp2GA62P79G8ISdYJLlf54yGgPFMTVnAJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717934055; c=relaxed/simple;
	bh=U8nub1PQ401/rllW1fTbwvlY7Chd20gj3o+9pi6S3Xo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BB0I6HI08CU3nh+ccmCaaMMrBcn/AmI9bYvaO1yt6DKbDQvf6XnTPH24PFaoQxkikwEq3YilKMTyHRQy2NB4WTscWLTqZYw6jyC1WB9tP8J/S31L28l+Va8sCMlzBhLv7L7brM+jy0yKiT9M5+PTPAhVrnU+duPeO62sDUGfK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSgCBlJ0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f60a17e3e7so4060265ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717934053; x=1718538853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFKprugPlHLSx3yHmNg5VyI9ekssfoPm+mrgBG/Csdg=;
        b=nSgCBlJ0x7uXhmZt+r14T0mRRReLOZixA1wMhkN/Onkrvjl+FceaxwEGXxotv92RZw
         aYrO/TNeozf3qWYdfkAnusngdLDwOpPznu45LsWNWNhTn7mB30FYyzNNc+5LhgN3WUxc
         ogwREvXfZpQOOO6uVis2GnuzK/ijbjVN+wc9e8iU3Y0IpKPzPVUAQme5EIfLwqM7YJRo
         TmB6RIZhd9CGjqzoeSu+4xjJDLjS7s7rCf+OSGyctr1Cgnx9ZFcVjvXSZXwjrOyTx0FS
         6NCbLQGy562Np5pEgYsC0/57vsU764Bz3Aqvi4DJlwpFnCBHxLASfY1Pis7azlBb0l3a
         hKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717934053; x=1718538853;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TFKprugPlHLSx3yHmNg5VyI9ekssfoPm+mrgBG/Csdg=;
        b=CHHlrVOnrhalhyfMorstpB9KriMggLOGBDWga1ZAC7YGMnJYknxlG1hAor7ShR8BtI
         kRvvRWJJArTb89iW0HlJAzJnreDRr6REkJsxSxcON/DEhvzjR9eMwwRzlsBqCldJikYf
         M+3XOEmrC27yi+fuS2TjvYsoyGv2p4Ie5g5doFLD2t3CfoCuv3K/2cOQohQLNydNPZ0H
         IZpRnZ7K/CF7/GlTV2tnIyn93DQC/Nxhei+CswkOUO1YVKl1wFDmzKNxEmpE/7UKr3fx
         UyLoZiMJ9kC86YJ7k+GGV16qY+qlYTNFoJuxSmBJnAvSTUx0JFB4gnOGE0Hfo7eUTUU0
         05RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvgQZs5WQ2QIEBEeQwhYpODA3kHa8kXxorqBs6pKVkrYt0Pxjn/puBUfsID3k6zCXkGpddPkXeLVPTxNDKYBUixUAgEfvL
X-Gm-Message-State: AOJu0YxW+4jQatDYoBP+n0tRcU00mPSeYay8ijnnxROS3U9IABZYldeP
	H76pyTZw4v11iU7ww+EMZ4nepQuxGrc4TRH6Aoka0xGhvewZAAGU
X-Google-Smtp-Source: AGHT+IEoKBvWcZW5SR8A2gpq+HLtu3R8geCophZfLZq2tXISiRPLRHIyEG7WrKD87UsFqcw1ZsulSg==
X-Received: by 2002:a17:903:2349:b0:1f7:12c9:9426 with SMTP id d9443c01a7336-1f712c9974fmr3758975ad.3.1717934053295;
        Sun, 09 Jun 2024 04:54:13 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f4bda999sm23550695ad.244.2024.06.09.04.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 04:54:12 -0700 (PDT)
Date: Sun, 09 Jun 2024 20:53:58 +0900 (JST)
Message-Id: <20240609.205358.1673083013074950109.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Sun, 9 Jun 2024 11:10:54 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

>> FUJITA Tomonori (6):
>>    net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
>>    net: tn40xx: add register defines
>>    net: tn40xx: add basic Tx handling
>>    net: tn40xx: add basic Rx handling
>>    net: tn40xx: add mdio bus support
>>    net: tn40xx: add phylink support
>>
>>   MAINTAINERS                             |    8 +-
>>   drivers/net/ethernet/tehuti/Kconfig     |   15 +
>>   drivers/net/ethernet/tehuti/Makefile    |    3 +
>>   drivers/net/ethernet/tehuti/tn40.c      | 1771 +++++++++++++++++++++++
>>   drivers/net/ethernet/tehuti/tn40.h      |  233 +++
>>   drivers/net/ethernet/tehuti/tn40_mdio.c |  143 ++
>>   drivers/net/ethernet/tehuti/tn40_phy.c  |   76 +
>>   drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
>>   8 files changed, 2493 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40.c
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40.h
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
>>   create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h
>>
>>
>> base-commit: c790275b5edf5d8280ae520bda7c1f37da460c00
> 
> Hi Tomonori,
> 
> feel free to add my
> 
> Reviewed-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Thanks a lot!

> to your patch series.
> I have also tested your driver, however since I have 10GBASE-T cards
> with x3310 and aqr105 phys I had to add a few lines (very few!) to
> make
> them work. Therefore, formally I cannot claim to have tested exactly
> your patches.

With few changes, the driver works in-tree Aquantia PHYs driver
(drivers/net/phy/aquantia)?


> Once your driver is out, I will post patches for supporting the other
> phys.
> Thanks for taking the effort of mainlining this driver!

Great!

