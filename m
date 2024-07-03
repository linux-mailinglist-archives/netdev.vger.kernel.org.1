Return-Path: <netdev+bounces-108644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E18924CC1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE73C1C22094
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FD623;
	Wed,  3 Jul 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS6guZQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997A391
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719966625; cv=none; b=pbhXWlb+CIwgvXDq9sz9gUm4UcyU/J7FfD/x7MqOHktetIBWW3m/nNW6Kz63ru8ujJZSC0FBn0iYdXX8cLd7td0QM2aoQLELOF5sUhAGM1pq6lBZyCQjwnw5SDQkxmshBPUEfIw7gn1DTcGAuOnRJopjLHu31l2hKtNIoOqcnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719966625; c=relaxed/simple;
	bh=8e79/fLj3JfMOkhBbOz/L6hoDK/GEIHor8k+KYPAJ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2DtkGd1EouhVO6iJoJxvTeTXAXlDIeMaFbupFAVML/HsfZohvCyPVxRMaftMv9yaxsFp6F2C+PNoZuaW/pJgMNbMiPF/Hrs0BMVVy3FiJwB0EvIpQrhMrmNlW23HepWfnFY5b15iAVT82+NFt+1PQs/291GWtzJedHfKfKYsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS6guZQi; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7226821ad86so3059057a12.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719966623; x=1720571423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYQtXFmBGu3MLcTd5T6+LlU+aNFFc/l1vdC2SyQcYFQ=;
        b=nS6guZQiu7mFaO2VRTooPYvwideKp1+bcOiHu3CFs+qLZ1pyQb9lOLM8+cO1Hgn9dF
         lXcqGF6E+xBT3xgsGPHTWSx33HcXkiqFEhIGLjcKy+O9lpWffaZCpFp2pFe36TjBuC99
         2lDDb5zEL9Sa2zJz04Ry1MKyatAyXLbR5ijuBE8Xlj+Tbvch9l6VQ20Yc6XG9SNecJZD
         2d9njviUOyRd8+ojmAim3kuq7qEfrF97KQAPcZxvgCwWe3z1yDs9nLToZl3MfMnQjo+h
         zI6LSub+Nko2RJ8yAhhbot+8Y5x2sG3TClbkC2kEkZx5s1DLTueHmwz9RGBhnH8lL4Lt
         d9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719966623; x=1720571423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYQtXFmBGu3MLcTd5T6+LlU+aNFFc/l1vdC2SyQcYFQ=;
        b=krLPjbilh+OzLQJv6F3ILj/GcH6C1KfibR1sxebBJdIODfsAP8l8DsHWsMOstj0Az6
         P3QIt5nQfsFbDSHjizmtJPRCwZIi7qkxVEtlprf0vaMcUyb6HMYoVyNm749zjbUosvAe
         28QmIfm2GhSTIcCRlDAlC6Ws5JD1Uu2X7b5dPuCdHtmpPoDSrfjIe2WpYL/EkE+252um
         I79+UfvoC3UPJCump22+UWCwGDlJ3/gaIGgLdjkq65CdL1IqiFF2Z2b43m+oTlScRAD8
         gn5GzlE5cMDOkp7cZBZUlJGesHDLeZB7c2fu3e2cIA9fGITugKkMNVOb1v0kjMvHAWZv
         5NMA==
X-Forwarded-Encrypted: i=1; AJvYcCXWT5LXItTfn8HFa8+opZWgCkw7wf1BbiCa7/Ein5d+1K1JwrT214zS7WRCd0RXy1GdLRi3Qvgh87cD/aAIrbJyQkgXK9Mq
X-Gm-Message-State: AOJu0YzNzWy9OCxd3Fe8HtoQ02RlCDsHEbPrnmCo4gbE+0f89MaatP6T
	smIoJFqfSA1ivf2Ft1kL45HHH2E/I+jxmfWlpB96XI34j1efxNZE
X-Google-Smtp-Source: AGHT+IEIkKnSL7OhzGceo5wdcjhqTiqCw6W86HQG2pVC4+NO0b3xhZhHz4vhKlzILQpS3UzQaSUCUA==
X-Received: by 2002:a05:6a20:3d83:b0:1be:cc01:6a6b with SMTP id adf61e73a8af0-1bef611dd8fmr10553577637.1.1719966622791;
        Tue, 02 Jul 2024 17:30:22 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:62b0:7aad:184a:7969:1422])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1a075616sm567865ad.15.2024.07.02.17.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 17:30:22 -0700 (PDT)
Date: Wed, 3 Jul 2024 08:30:17 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: 'Simon Horman' <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v6] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <ZoSbmdPWWFauvY2Q@Laptop-X1>
References: <20240702-bond-oob-v6-1-2dfdba195c19@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-bond-oob-v6-1-2dfdba195c19@kernel.org>

On Tue, Jul 02, 2024 at 02:55:55PM +0100, 'Simon Horman' wrote:
> From: Sam Sun <samsun1006219@gmail.com>
> 
> In function bond_option_arp_ip_targets_set(), if newval->string is an
> empty string, newval->string+1 will point to the byte after the
> string, causing an out-of-bound read.
> 
> BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>  strlen+0x7d/0xa0 lib/string.c:418
>  __fortify_strlen include/linux/fortify-string.h:210 [inline]
>  in4_pton+0xa3/0x3f0 net/core/utils.c:130
>  bond_option_arp_ip_targets_set+0xc2/0x910
> drivers/net/bonding/bond_options.c:1201
>  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
>  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
>  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
>  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> ---[ end trace ]---
> 
> Fix it by adding a check of string length before using it.
> 
> Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
> Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

