Return-Path: <netdev+bounces-80371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4C287E8AA
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313E128285B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3F364A5;
	Mon, 18 Mar 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iZ7lTwAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BED2EB05
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761501; cv=none; b=Bg2I80lA4YxWNGv0107rFpdUHO1VkUYTWO2f2tqPRagG4NF1C1rMDlXa8PTUcGosAzGLHTpEFxgrUdwyI/Qbx2lbYv9CLaHvS+NNY7gP1slciOwKKIdxHae+2Np/bYWLdL223jowlWkvPR7BKPbNx6zbG8uzbnmVxKaOX24n6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761501; c=relaxed/simple;
	bh=BUfYzfB4nIa8ngImK6uuUD/gCNyrGYcjGhb6MYofvoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVmyFZwoN0Z9PExIk6GuERhkQInxwZNUnxtUKaFOSeQFpcTX7nX8rrRKuu6foTiKyrpBox7wtOqQNfmRqFnNhVy1jgXLfiXtbthue1MpkyZcdMPXUe0TK4JgoP84IID5LnE8FBD28+dqiqB7pNelMj3ebFFr226SjTwupQ2ZwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iZ7lTwAo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41410a86d5cso5480095e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710761496; x=1711366296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msDk9uend+vPej2m56zNtdW90aju9Z/kKIHZGCbaQbw=;
        b=iZ7lTwAonDzDUOaSWZqQxjGcTwmnHWjv4sDqfX5wWJAj4cNTI3WTbR09rDQRSJyWU2
         QKHakE2ztbQYuzBp01HBGEzpks+1xWGyZuex6w5R3xg8KYp+Nws1wmCfeCkijnmjL5aU
         96IfFTPeWLWR8eeyRRfZScbhs/CBpiqe0jds5gceD2tgphyqreN0ucNDgDaqAb4BxumQ
         95cIH+rg/j57xCpSRXuRuQ7YbzjYtUWCM34LXiMcnHDEDVyjmX5uRnyHXY41YuK9a3po
         nT23tp/Vkb0VWlNymbvi7MDN3jriwKXEe57wcOUYlDuXETOEcB/OP//DiXZELP9S9Y4f
         u5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710761496; x=1711366296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msDk9uend+vPej2m56zNtdW90aju9Z/kKIHZGCbaQbw=;
        b=oRIU1skFP+7AAFlKie191o8zoxaQDzim0To+bOyEKTTZGPqGfg3RFDJPLfRzSs+nut
         60IeJVFTouxZ7rBurM/bdzeF6km9Aoe8mVDqjvoa/a7l1Y2zlvq4eCcjCE1LzlafInWH
         kmnVoHrO5aBOjqUcaqEY2KXika0nlD//MFuK/BZpZSvgze7Bors+QP871WfCU/BIUPGB
         kt2J3Q1Uzpbpre3puAX0t3IO86DJ1AqWBvahjv1tEeRuFlIzFu+2FkHW8ZHx65pxAMJ6
         neP1iiheM7NiOQLaHd7zrlNVPm4Bgl+yk9CzyhH7mFhs7E9vs68dKw9APz3BOTYc3LpH
         TS1Q==
X-Gm-Message-State: AOJu0YxeIdeFw0ERW6qwD5ynd+DPD03tSHJtdjYs88mhiHu1j/fBXVxY
	kCGtXxZcxKCCmx8IJf8Rqmf0mgnyRjmN1U4D03WMli6AAqL2eUA9gBtDc224KEw=
X-Google-Smtp-Source: AGHT+IG2bl04Bf5qDRWox1Wz13Ixq9lN3LYhswVn2zPLAJhdBWiydlddGM/eFcI7FtlSaVFGtM7Mww==
X-Received: by 2002:a05:600c:45d0:b0:414:3d4d:56e3 with SMTP id s16-20020a05600c45d000b004143d4d56e3mr573729wmo.18.1710761496169;
        Mon, 18 Mar 2024 04:31:36 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm17888266wmb.42.2024.03.18.04.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:31:35 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:31:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Subject: Re: [PATCH net 0/6] wireguard fixes for 6.9-rc1
Message-ID: <ZfgmE5cIh-hrjJCX@nanopsycho>
References: <20240314224911.6653-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314224911.6653-1-Jason@zx2c4.com>

Thu, Mar 14, 2024 at 11:49:05PM CET, Jason@zx2c4.com wrote:
>Hey netdev,
>
>This series has four WireGuard fixes:
>
>1) Annotate a data race that KCSAN found by using READ_ONCE/WRITE_ONCE,
>   which has been causing syzkaller noise.
>
>2) Use the generic netdev tstats allocation and stats getters instead of
>   doing this within the driver.
>
>3) Explicitly check a flag variable instead of an empty list in the
>   netlink code, to prevent a UaF situation when paging through GET
>   results during a remove-all SET operation.
>
>4) Set a flag in the RISC-V CI config so the selftests continue to boot.
>
>Please apply these!
>
>Thanks,
>Jason
>
>
>Breno Leitao (2):
>  wireguard: device: leverage core stats allocator
>  wireguard: device: remove generic .ndo_get_stats64
>
>Jason A. Donenfeld (3):
>  wireguard: netlink: check for dangling peer via is_dead instead of
>    empty list
>  wireguard: netlink: access device through ctx instead of peer
>  wireguard: selftests: set RISCV_ISA_FALLBACK on riscv{32,64}
>
>Nikita Zhandarovich (1):
>  wireguard: receive: annotate data-race around
>    receiving_counter.counter

Looks fine to me.

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>



>
> drivers/net/wireguard/device.c                        | 11 ++---------
> drivers/net/wireguard/netlink.c                       | 10 +++++-----
> drivers/net/wireguard/receive.c                       |  6 +++---
> .../selftests/wireguard/qemu/arch/riscv32.config      |  1 +
> .../selftests/wireguard/qemu/arch/riscv64.config      |  1 +
> 5 files changed, 12 insertions(+), 17 deletions(-)
>
>-- 
>2.44.0
>
>

