Return-Path: <netdev+bounces-202822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3CAEF2B3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FB7169676
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B6269CF1;
	Tue,  1 Jul 2025 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWBF/aL9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07F223716;
	Tue,  1 Jul 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360945; cv=none; b=qoVbX9stopa86gEqL+B7USEOskTlByeWs5843buRmni5/L2wGoejBJOG9c4DnK855KK5BY7BOSrjGmyu6T5twfd2ObiWz5+Ihz8vOHLaKcdaBgjVThqQwt+B7KuVGhOcV2CGb2OM2uUBQFowx2Ov5EgYfVCDAtK/6Oz9BgiGBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360945; c=relaxed/simple;
	bh=6UDM5fNF57aJf6DmBghu+lhkpkzxGnJVIa2mlP4nq4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GaVMwEAIALjG+093Dq9M/44D1VAadTq/UmhAWAEUpkcu6iI9Kk4le8BQ8dzXyE6gZ6B/kyG7PtBXDI6e9SwrGNhg5DJhg6HC1lZcAVth1UWmf12PVBdWQeK4ktFomM+eCpUHOlakjf5/xGZOfEARpxup08swpJth035eep5ijUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWBF/aL9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236192f8770so34420895ad.0;
        Tue, 01 Jul 2025 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751360943; x=1751965743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWlbP5Cgher1hLjR8FaEXf/IQPBYBpXZBtIHixSbQv0=;
        b=RWBF/aL9KYhzkwdrl251fDfGgZfE4J30C0eV5nZCVrJbf7SOtWGkLQllKycWr+saWm
         B0m2qEwKrfP+wCjG3zFVAb79GQ4HbPFY/QX2bKc2WdrdzbbDY2TkRZy7714LuZDOPTgn
         4g2Ae8AubkBuumy7OTGnWPsI6MFe+THn9HHoLyXBfPYNMdEfHTk7QjAhPGLzKSDT8MLW
         kB+A8nD6QpnTNDI+X1ALdhYZPY5U/IHZEtBm5UIMSZNiws+38G209fiadkhwhaGnnslo
         d3aE+qQjOV/8vwpb9bpNBMnf8sNifCcG5ViIS8LSLQ6NXLCfleXfzjQgDjwsjxEGcBlk
         gV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360943; x=1751965743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWlbP5Cgher1hLjR8FaEXf/IQPBYBpXZBtIHixSbQv0=;
        b=nc9C5ppkZjG9Y4l3ahY10r/MI9+6OLsRQDReYqdSWY2/XL+iOK0PogMnilKixrmvXu
         3k1Yxv/vqJEvnOfRCeiz5EPRBBZK01MWiPjmwn74FzBDSqQgeame7NOMXzepJvt9Nexl
         BLSzj9160kdyAqBwLpufnGyG4Sm9grsdyFlNOdBHNPH2TsWH8nEld56AYpigVdgaR0h2
         +hOzS7aaLnTJ+TeUaN8g25Mpfy/CBZQ5xPqIiCfVDExXeZPWwVv9HQwt8ZRZsslPrCB6
         le7bkEb1sYfzjHqx4L2znOIJ61sfwYdyvBPhqXLR1mHowPcWx9ALS7plKajGPqTVcmDk
         9+lg==
X-Forwarded-Encrypted: i=1; AJvYcCVOyMHDrcjNnI8J9PixdZVGuUrKQ4djtVbWqmiLg7+AmyYtUvpxCHj3zc2/53DWmJ2bui5GYNwL@vger.kernel.org, AJvYcCWB+gpu/dGRdRu4BEvRnKLRWfuj2A6npSSBRNID2+9QNpHIX1EwpAJLX0EEyD3vNISxeM+cZeXUhJMUvLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN24AkCkcuK04+ALcCCo6OsNlW/kA7YIjInda9rf/QIBvIQdDi
	EAqOgEh/bsRtRGD9UpZLcOjONQPZbbXJneyGHxsAYAR7Ua46OAoibrLq
X-Gm-Gg: ASbGncteChIaifGN9NUvxja5lVN8ga94EypTG/AliqqnOGHebSlqBetxuRRBZJdZqYF
	Iz+GGdASEYuHLjThFKM1/Vu4Dkg88xaaGmiMYOrGCG6cvwLNIloEfbirrOxA+wIP8D11FeeXxvb
	GJc1oXL9mNCR0DedtkkKks69N+jbs2CIB2YfJHFjtB3pDEmAtiyqC8Ol5GptwE2Dz/BQD7r4tUJ
	tYFEJd/wcKrh4wRHxG4LNVVQx3Yez2Ykkvbk3PXlyylvpTSS/O5vof+4rtbqbmXC4h4cp8RVIsD
	SHNc8wVXZoB5azb0J41Gcdz00HOVO+SKSfzTn6H2HvRzf6OMPHbIQDBmJUrRhrLkGMwmcDA12jI
	8XGZ7dZs5nUcyMwfyddZub0cOsu5Gmt0e
X-Google-Smtp-Source: AGHT+IH4br/vkS1TA5kOB0JT6na6FWAWji5Ksq2QJ8zm41vhk8hFAwkD6uASfLWv3LauaAlZIzweIQ==
X-Received: by 2002:a17:902:da48:b0:235:e94b:62dd with SMTP id d9443c01a7336-23b355469f9mr44669715ad.12.1751360943048;
        Tue, 01 Jul 2025 02:09:03 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bcbcsm99758425ad.134.2025.07.01.02.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:09:02 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	florian.fainelli@broadcom.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	opendmb@gmail.com,
	pabeni@redhat.com,
	ryotkkr98@gmail.com,
	zakkemble@gmail.com
Subject: Re: [PATCH] net: bcmgenet: Initialize u64 stats seq counter
Date: Tue,  1 Jul 2025 18:08:58 +0900
Message-Id: <20250701090858.7954-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630162147.GJ41770@horms.kernel.org>
References: <20250630162147.GJ41770@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Horman-san!

On Mon, 30 Jun 2025 17:21:47 +0100, Simon Horman wrote:
>On Sun, Jun 29, 2025 at 11:41:09AM +0000, Ryo Takakura wrote:
>> Initialize u64 stats as it uses seq counter on 32bit machines
>> as suggested by lockdep below.
>> 
>> [    1.830953][    T1] INFO: trying to register non-static key.
>> [    1.830993][    T1] The code is fine but needs lockdep annotation, or maybe
>> [    1.831027][    T1] you didn't initialize this object before use?
>> [    1.831057][    T1] turning off the locking correctness validator.
>> [    1.831090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.16.0-rc2-v7l+ #1 PREEMPT
>> [    1.831097][    T1] Tainted: [W]=WARN
>> [    1.831099][    T1] Hardware name: BCM2711
>> [    1.831101][    T1] Call trace:
>> [    1.831104][    T1]  unwind_backtrace from show_stack+0x18/0x1c
>> [    1.831120][    T1]  show_stack from dump_stack_lvl+0x8c/0xcc
>> [    1.831129][    T1]  dump_stack_lvl from register_lock_class+0x9e8/0x9fc
>> [    1.831141][    T1]  register_lock_class from __lock_acquire+0x420/0x22c0
>> [    1.831154][    T1]  __lock_acquire from lock_acquire+0x130/0x3f8
>> [    1.831166][    T1]  lock_acquire from bcmgenet_get_stats64+0x4a4/0x4c8
>> [    1.831176][    T1]  bcmgenet_get_stats64 from dev_get_stats+0x4c/0x408
>> [    1.831184][    T1]  dev_get_stats from rtnl_fill_stats+0x38/0x120
>> [    1.831193][    T1]  rtnl_fill_stats from rtnl_fill_ifinfo+0x7f8/0x1890
>> [    1.831203][    T1]  rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xd0/0x138
>> [    1.831214][    T1]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x48/0x8c
>> [    1.831225][    T1]  rtmsg_ifinfo from register_netdevice+0x8c0/0x95c
>> [    1.831237][    T1]  register_netdevice from register_netdev+0x28/0x40
>> [    1.831247][    T1]  register_netdev from bcmgenet_probe+0x690/0x6bc
>> [    1.831255][    T1]  bcmgenet_probe from platform_probe+0x64/0xbc
>> [    1.831263][    T1]  platform_probe from really_probe+0xd0/0x2d4
>> [    1.831269][    T1]  really_probe from __driver_probe_device+0x90/0x1a4
>> [    1.831273][    T1]  __driver_probe_device from driver_probe_device+0x38/0x11c
>> [    1.831278][    T1]  driver_probe_device from __driver_attach+0x9c/0x18c
>> [    1.831282][    T1]  __driver_attach from bus_for_each_dev+0x84/0xd4
>> [    1.831291][    T1]  bus_for_each_dev from bus_add_driver+0xd4/0x1f4
>> [    1.831303][    T1]  bus_add_driver from driver_register+0x88/0x120
>> [    1.831312][    T1]  driver_register from do_one_initcall+0x78/0x360
>> [    1.831320][    T1]  do_one_initcall from kernel_init_freeable+0x2bc/0x314
>> [    1.831331][    T1]  kernel_init_freeable from kernel_init+0x1c/0x144
>> [    1.831339][    T1]  kernel_init from ret_from_fork+0x14/0x20
>> [    1.831344][    T1] Exception stack(0xf082dfb0 to 0xf082dff8)
>> [    1.831349][    T1] dfa0:                                     00000000 00000000 00000000 00000000
>> [    1.831353][    T1] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    1.831356][    T1] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> 
>> Fixes: 59aa6e3072aa ("net: bcmgenet: switch to use 64bit statistics")
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>
>Hi Takakura-san,
>
>Thanks for your patch.
>
>Unfortunately it doesn't apply cleanly which is needed by our CI to process
>your patch.
>
>Please:
>
>* Rebase and repost your patch on the net tree
>
>* Target your patch at net (as opposed to net-next) like this
>
>	Subject: [PATCH net v2] ...
>
>* And include Florian's tag in v2
>
>* Post v2 as a new thread
>
>For more information please see
>https://docs.kernel.org/process/maintainer-netdev.html

Thank you for elaborating.
I'll resend v2 accordingly!

Sincerely,
Ryo Takakura

