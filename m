Return-Path: <netdev+bounces-159255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C329DA14F05
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BE71634AC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E51FF1A7;
	Fri, 17 Jan 2025 12:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CF1FF1A5
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115741; cv=none; b=sAZ5ILecgBtyhpzaH5HOork1+pUfXdkcYt6WIloutdJtM08Vu2Y4zAl5FVxV4o/nSgJee+kyAHDix5fxbG4ZAkJB+s096YWvxjgOM481vu2NRfExyFHLvE7pZvNyUzWQJ9+995RgGlMdW+ZUBCLBV7N1+6KVu9ducrM1oP28Cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115741; c=relaxed/simple;
	bh=+JSV2vEaoseoQmVoRVqiOcsXx0VhfuCeiHpZA6zXjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gByNlvRJx+WCzgSkpPUOD7IviNfRqMzqxKreXyl3vee2J4Xu/kMfLxtgTWrCQpJDwgPO2QFshP7slR1SAUu4x/LVRZ15xE1vwAfpQ/xrQLbVVw6p45LLUNiBqGbvvT+hUPyBCEbrzFi8YKuZdnbqCE/n7fJeqVuVHqAiLwF4KiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso415012666b.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737115738; x=1737720538;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/LpZ50lT8IWGeVUEXUfFyEZLepS06VAzbU4nDDG0n0=;
        b=Xf0voN/fD2XmHDHSex5mE88k8dot42iSUwTioFaU8mrBAGEs3gVrQSJD9pSBLD82TR
         R6LULmKvJU1EXDXAf85p/jq9xntqiYNhc7+QJLebfFIJNDP2relN2glAszvTv9R9BjMI
         U7R8AaKF5UwucFA+pagooKk1H/dW/htTEnyjKh4Ow+JOFo0hDOowk2TYdqkpxFrfOJTh
         0Obels5q9M5YUu59bWXhpR5CLgWqNJgCHjsDO6UKHonRxz+12XjGAodvXcUQzRa0NtNM
         hZ1iZnmwnXhG0I6pp001dqPtz5LZODVGb8mHiJEi28FCkT6pg4BHINMgzd20aG/rCZL8
         V+Dg==
X-Gm-Message-State: AOJu0YxFy4NqV2qx4uAN6p8dbmhLShUa+wHTTA3c1BqdmEHOK6dsY7kM
	jykaFp+xfMvbcDJi+8/k4pHLQTkx2051QjuLOnc31YeixKoPW6Nn
X-Gm-Gg: ASbGnctXqBF39YeF6b13kwdvVqCYz+wUOzCDqqEIq6nuqZFf0IqwrPf8PQogGhu7sj3
	Gbp9QpZUUY2OwZL+x5MuocznmUzskZ3o9TucaHmSdWC1hKzH1fmQj87NcqUTk93U7drfoTI7qk3
	eXZqwlUM4Hhsa/S1Cq0yxm5d8G/e/p5wouYo2K1r6JZRT/VyXNGmE6itLrkl7Pb0DBEbgqbhQnG
	XJzUrfUhdQZi6wAiPZHRPpluioEnoUEYlTjVx11IZcdZTw=
X-Google-Smtp-Source: AGHT+IFLQQuq2M5rzOOBSHnyMRK8NLJy+kIrqF3iFidqm7uyi/11JTOvHCWmIr6GspB7ENKbm8ixlQ==
X-Received: by 2002:a17:907:7287:b0:aa6:2c18:aaa2 with SMTP id a640c23a62f3a-ab38b30fe7fmr289034566b.27.1737115737553;
        Fri, 17 Jan 2025 04:08:57 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670dcesm1433933a12.20.2025.01.17.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:08:56 -0800 (PST)
Date: Fri, 17 Jan 2025 04:08:53 -0800
From: Breno Leitao <leitao@debian.org>
To: michael.chan@broadcom.com, pavan.chebbi@broadcom.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com
Subject: bnxt_en: NETDEV WATCHDOG in 6.13-rc7
Message-ID: <20250117-frisky-macho-bustard-e92632@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am deploying 6.13-rc7 at commit 619f0b6fad52 ("Merge tag 'seccomp-v6.13-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux") 
in a machine with Broadcom BCM57452 NetXtreme-E 10Gb/25Gb/40Gb/50Gb and
the machine's network is down, with some error messages and NETDEV
WATCHDOG kicking in.

Are you guys familiar with something similar ?

Here are some of the messages. Examples:

	 bnxt_en 0000:04:00.0 eth0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 5123 ms
	 bnxt_en 0000:04:00.0 eth0: TX timeout detected, starting reset task!
	 bnxt_en 0000:04:00.0 eth0: [0.0]: tx{fw_ring: 0 prod: a cons: 8}
	 bnxt_en 0000:04:00.0 eth0: [0]: rx{fw_ring: 0 prod: 1ff} rx_agg{fw_ring: 9 agg_prod: 7fc sw_agg_prod: 7fc}


Later I am getting this hung task report:

	       Tainted: G                 N 6.13.0-rc7-kbuilder-00043-g619f0b6fad52 #3
	 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	 task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
	 Call Trace:
	  <TASK>
	  __schedule+0xb72/0x3690
	  ? __pfx___schedule+0x10/0x10
	  ? __pfx_lock_release+0x10/0x10
	  schedule+0xea/0x3c0
	  async_synchronize_cookie_domain+0x1b8/0x210
	  ? __pfx_async_synchronize_cookie_domain+0x10/0x10
	  ? __pfx_autoremove_wake_function+0x10/0x10
	  ? kernel_init_freeable+0x500/0x6d0
	  ? __pfx_kernel_init+0x10/0x10
	  kernel_init+0x24/0x1e0
	  ? _raw_spin_unlock_irq+0x33/0x50
	  ret_from_fork+0x31/0x70
	  ? __pfx_kernel_init+0x10/0x10
	  ret_from_fork_asm+0x1a/0x30
	  </TASK>

	 Showing all locks held in the system:
	 3 locks held by kworker/u144:0/11:
	  #0: ffff88810a1b5948 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x1090/0x1950
	  #1: ffffc9000013fda0 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x1950
	  #2: ffff8881128081b0 (&dev->mutex){....}-{4:4}, at: __driver_attach_async_helper+0xa4/0x260
	 1 lock held by khungtaskd/203:
	  #0: ffffffff8669a1e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x75/0x330
	 7 locks held by kworker/u144:3/208:
	 4 locks held by kworker/u144:4/290:
	  #0: ffff88811db39948 ((wq_completion)bnxt_pf_wq){+.+.}-{0:0}, at: process_one_work+0x1090/0x1950
	  #1: ffffc9000303fda0 ((work_completion)(&bp->sp_task)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x1950
	  #2: ffffffff86f71208 (rtnl_mutex){+.+.}-{4:4}, at: bnxt_reset+0x30/0xa0
	  #3: ffff88811e41d160 (&bp->hwrm_cmd_lock){+.+.}-{4:4}, at: __hwrm_send+0x2f6/0x28d0
	 3 locks held by kworker/u144:6/322:
	  #0: ffff88810812a948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1090/0x1950
	  #1: ffffc90003a4fda0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x1950
	  #2: ffffffff86f71208 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60
	 =============================================


Full log at https://pastebin.com/4pWmaayt

Thanks
--breno

