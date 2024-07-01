Return-Path: <netdev+bounces-107975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8CD91D592
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 02:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052A3B20B8A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 00:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6A610F9;
	Mon,  1 Jul 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po8DTCLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBD23A0
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719795469; cv=none; b=TqlcNf4NmXKohsqjn0kVOr+745tsdiJvmBJJPMGKpGncN5DBFR+VT6mRt6dT+dI7j9ojikpyKmQ1NkJY1i8hv5kLdyhgRzYv8gQL9M37c39gfTnSMoS0UxuJccaV0djPw58K5DhZQmgAdg+dsh3OHqPGGUsjNzcbMuVyskGebKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719795469; c=relaxed/simple;
	bh=vP3G/C28XA0czFiqkZw5y0loGlqNAvJp9QcKVriTdyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQuDJPeKtoQIuB2OmkSBOhmzp6bl+t0whKe4FZL2l1CVf/bSFulhNHG3vlcga12I2OUJLOoUMA5xoUqiECvEv9XqCqm0XijU1NbddCstVJkJLAIMEnSN+GjsdPhdMwlIvXD0OiIZs6HgrD9nuC6TEllJ5lBXUDZ05+8PJk+EtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po8DTCLh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-72ed1fbc5d9so1596858a12.0
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719795468; x=1720400268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXpmSHPgWE/PV8wliw5E/E+TJWhw+ZKzdn0PRKCoh+0=;
        b=Po8DTCLhpxkBN0fWkNvqZvGVuCt2gYZt1Wdhq77mRmzgRzfSJCUXIdZM4Vixenn5IY
         efBj0oTsRTFWwv4zl49G0tuAFOAVipL3gDktQlkwh935IHhBeaL63RgBZjncmDbe5KIw
         gbXa8QbPATiSPQm1VcobcZuMsrRGsOby15EzbzQOicmSmxxJvpyG0nITgcw6IveWcNjn
         dgAW8W0XGBZ8p3QAf1xOHesxFeEai2XyKG/wgCi1omMihL7OskuBiYkOpvFH7H3idLlo
         poplHos15MXwFKrburGk4Lecy8QMRjQAuI0nNKS5/F3P5lzztioSdS8BgdyPVSbJzhi6
         kD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719795468; x=1720400268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXpmSHPgWE/PV8wliw5E/E+TJWhw+ZKzdn0PRKCoh+0=;
        b=P3spow/gu8BjOtH1SiAubQtKttUkzWwhTR+sRYvUfOXskk6ny+y4k7E6Hx4x23zIWd
         Pm6+SbnrF4akCxKuSxvr0u26iMYzGgKQa10KuHsfLtFklDncI5gQInIcsxDH1DWa9Ryf
         H+iqVCUOSdHgLFDaLUJTXOm+ebEtSlHWyTxBVuN4uehMlsfuwB/VBjzUx5CqVeAPPJ/z
         ix4giskqxHKXc11y7nlfBzam+2RwVgonqh5zXIhm47hMvthEIBwLFMMj5r5WDLrTInW0
         IR2I4BE3s0iXHJpJEWD47Xj2HmDxmsOXspiQ6zK68MsYqKjg/jcOLk9qZFBIfXN6bVj8
         ZqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW8gWr43Ck2LkEjpByvv0FrHGqfoTQIi25Ai2wme86LbVA61H5N6OsAZUe2jyNfhxco79hGrU+f/qX0Q9kMSwudACjZT4B
X-Gm-Message-State: AOJu0YyCFjIWhgrHVIdVwAtVTjZl8QL0i2zpE/yKvK/FUshM8CumGLQ6
	coPMdqRV/fjH5YaVgV5LUYjhMMVOis7SpawKgHVEJawYXdHoaed3
X-Google-Smtp-Source: AGHT+IENP2Tugyu67ZTerq9hYY5R9kCUDtRPj/vLF2JFbHi6OlR/BUOIMJUFFoFVTqeJPP/54Q1WDA==
X-Received: by 2002:a05:6a20:29a7:b0:1be:e265:81ff with SMTP id adf61e73a8af0-1bef624192amr5205542637.56.1719795467691;
        Sun, 30 Jun 2024 17:57:47 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bf20dsm5409675a91.39.2024.06.30.17.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 17:57:47 -0700 (PDT)
Date: Mon, 1 Jul 2024 08:57:38 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: 'Simon Horman' <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <ZoH_Aqg8CgD7ZqT3@Laptop-X1>
References: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>

On Sun, Jun 30, 2024 at 02:20:55PM +0100, 'Simon Horman' wrote:
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

