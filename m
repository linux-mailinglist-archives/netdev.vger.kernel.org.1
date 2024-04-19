Return-Path: <netdev+bounces-89624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F938AAEDC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA3D283AF2
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6D8565D;
	Fri, 19 Apr 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4KDXKFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34E80022
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531268; cv=none; b=krFgu87pbXWH3+cBCaJsPxdOF+A3g+Ld1Mhv3AhTSGspOK3F/A+NuTKn6Plb8VQywLy8wIhtHJYoTO45TCpYl/UNQ8No0rykW6T+BO9Q0mFFbyycumJRXQ0zS1tRgQE2x4FN8SAtT0Ejq9lN76xGCI3yS87vGYzGjp6VN8Oo/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531268; c=relaxed/simple;
	bh=Vi8RVGKvtTRJKhQGrAK+KGxIMFOR7j+BkbFN8Y8KUWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6TrIWwKM70wuKGRfCu74TFP1B8u2O/QaMCO2pht6n488C/CdsCyTNPo7Ei0DLDRVKupm3a1j5kbHKhtpBMZoEKc/1xlXmLLC2VPPZCJe3L2EYKK9mvX74fHhQseel+tIB1UeMnALXO+ebvUPJm1u7R/oyudixVvgFphdSTTVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4KDXKFw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0bec01232so16651815ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713531267; x=1714136067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1ptde74k3WYzhPH0umlAbgdQd31wn7b98/aCs2C+LU=;
        b=Y4KDXKFwHrEVd9yj1tQoGmTn/xL8irD6aN3+RFkKRfGABURnctDEwFOdKWoqJs/dBj
         w+Vwappzx8xNWAXJixEbGbd4SBrzj5gOyuc5AXhF0TjIdOcoho5xgKZHAe4d6NR7xyC8
         azg1evN0E9mARilYDxnJIVG1WYwXmNSK9UucaWghwAtxbDztX99ls8nv0yox/Qk6wwW+
         NLPJkrSe1S/EvEayU7NenZEmAj7nE1I+Dbeyqun8yg/Q+i5uDIz8yE/dXqNhjhmF1EGu
         Q8ac/x+kUKf+T2I1RXd5U+h6V6VLU1X2704emNycHhar9qtJGiUTXCoRVVVHNMTaWyN8
         56rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713531267; x=1714136067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1ptde74k3WYzhPH0umlAbgdQd31wn7b98/aCs2C+LU=;
        b=bfHGRFaQ/ElMqR5RJQJU3gw81rFHiz4w8RUQxcgkm1R8OakE75K/jwiw4ZBioDT8Lo
         F32F9zP/Bo5oyrQBGJH5yrsR0U+PE54VMy2xh4g0VlxK6Tr2UVPe6Pglp/3AVAyEyS3b
         IXyZ6R6awKIyaAhUUmKF+mNtFYctg8kJGQ88nXV7FqTQp9ahCV6WMPWMZC0gvzaLSbYq
         p0cFq4xFBCQtCdpuAT9mez2zI/LiOxB0PFaaW2GgBBCnTLpQ9etfs8FuI8OxaSq6vJEy
         z0cVcL6thkjrhwsQX0ieNFcBOMliXs4qam1itCR7rVarrJ2040leaeMSWkcM4BGchyId
         wnvw==
X-Forwarded-Encrypted: i=1; AJvYcCW4jUTjhW345zkcQ6wBtqmGj03tTh7/DppvWETWKLrqeVRZaIPOhuYWdJCKVeLprF4LZoDtd/zsKSQgrA/odK41JyIpQDrZ
X-Gm-Message-State: AOJu0Yx8js6Xle3f5QH/jBbnTR4tb9xw06AStZPwUw755un0fQDy2CUB
	BWlgHdXOfHe3fz9o5xhR8rnEOukwRY/9DuRtSpTeew5mJHom7k7V
X-Google-Smtp-Source: AGHT+IHNgHHMxBHnlW+7hCO4BbgNwagABXy6hCXLU1OETb01yjoHQluESdOgU4/yP2uu2aJF8h3lLg==
X-Received: by 2002:a17:902:db02:b0:1e0:a4c9:84cd with SMTP id m2-20020a170902db0200b001e0a4c984cdmr2470549plx.60.1713531266584;
        Fri, 19 Apr 2024 05:54:26 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf5-20020a170902b90500b001e7b82f33eesm3268554plb.291.2024.04.19.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:54:26 -0700 (PDT)
Date: Fri, 19 Apr 2024 20:54:21 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: 'Simon Horman' <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v4] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <ZiJpfZQb_yA936Wh@Laptop-X1>
References: <20240419-bond-oob-v4-1-69dd1a66db20@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-bond-oob-v4-1-69dd1a66db20@kernel.org>

On Fri, Apr 19, 2024 at 12:08:25PM +0100, 'Simon Horman' wrote:
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
> ---
> Changes in v4 (Simon):
> - Correct  whitespace mangled patch; posting as requested by Sam Sun
> - Link to v3: https://lore.kernel.org/r/CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com
> 
> Changes in v3 (Sam Sun):
> - According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
>   ("bonding: convert arp_ip_target to use the new option API") to
>   f9de11a16594 ("bonding: add ip checks when store ip target").
> - Link to v2: https://lore.kernel.org/r/CAEkJfYMdDQKY1C-wBZLiaJ=dCqfM9r=rykwwf+J-XHsFp7D9Ag@mail.gmail.com/
> 
> Changes in v2 (Sam Sun):
> - According to Jay and Hangbin's opinion, remove target address in
>   netdev_err message since target is not initialized in error path and
>   will not provide useful information.
> - Link to v1: https://lore.kernel.org/r/CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com/
> ---
>  drivers/net/bonding/bond_options.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 0cacd7027e35..64a06e3399ee 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
>  	__be32 target;
>  
>  	if (newval->string) {
> -		if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
> -			netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
> -				   &target);
> +		if (!(strlen(newval->string)) ||
> +		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
> +			netdev_err(bond->dev, "invalid ARP target I4 specified\n");

Hi Simon, the error message should be "invalid ARP target specified\n"

Thanks
Hangbin

