Return-Path: <netdev+bounces-127512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA59759CD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D4BB23E19
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC51B78FF;
	Wed, 11 Sep 2024 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6jBLLi1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64B1B78F3
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077150; cv=none; b=SWJTjGB8y7zLfdxHv8jE/k1uxkgQY2YwMlIFZ0QbLeym++J6/DGJEJ9NPkqgQIWHsCXCSBPqfA4M3iUkHEUi+BLnQVB5ePmifX0xvbCVnN0fXcX/8/j4P1x98wXX0yj7t6Fmpz/1F6VioncAVjMMOpXeRgeBhNq1/wieuoTa+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077150; c=relaxed/simple;
	bh=MP1y3l6FkfJxUen/GD99U9NGAPRSaB9hl/d0N8whiMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLYtpxIW1rWNRUjF/MQ8Urlh//g61Bmhm+3MAqeZOezNfNGK6MxC/zog6QfDKBcgQwGBKqwPZt90xxOwA/I/Ijwg2h1vMe1HAFvh2GGAWw/XhL2iKD83Pu5TlQ7hJoud0MytKv997V0vdF4bcwc9eeZSS8gA7OV3pU8VjM9+aWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6jBLLi1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726077145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USRMv9RzUopMWvtodUYYp9EwsgYfe6uI7ezp0e+xAS0=;
	b=J6jBLLi1oAB64xDep20oECvWq/hflVGRf+Kak3UpgaKsni5QUnSjV2TAU8j7SOxdTYrJSt
	A+2SAOfcxeR+o8RiXxlpyY99kkxueuHZqV0E3IRK+UCGwmH6Akk3ZpzyYcApxyENVJ0deC
	pfZ5aW8K8zW0txAQJXxKtNHpGHIqIz8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-MFqH6vh8PuCKA3PGBs475g-1; Wed, 11 Sep 2024 13:52:24 -0400
X-MC-Unique: MFqH6vh8PuCKA3PGBs475g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a9bffc241eso22861785a.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 10:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726077143; x=1726681943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USRMv9RzUopMWvtodUYYp9EwsgYfe6uI7ezp0e+xAS0=;
        b=kK2ry3qwDucl1G54i8xqc+jVHbrfhQ7SIf03V5W6WTCaG3/PhxBl1l7DqIX0hOTxtY
         dsdDePJT2Egk3aaM7KVKxnlYT5nLYhLOsbgG5hJbzvoO0V9zWyy5pOoFntsz8wJsTL6L
         O7MWRJWwSbNhwAuzgXSoDPpVzvD/ImqCYdNypvOyXWPZUWCriBXonvddZaBk22mWvaPy
         PsHlZGMXvgnXQ0djR/P0SE6S9WSlmSj64/YQ1D8ZOOjgHrLIbqjLT9KISmfRtOFgUlbY
         XxaxzrQdjOo7kv/c9rDt/a3eiVPVpvBJLcMb9JRwE/+Q3Q+PhX3o8V+FE43ID7fGC8y0
         56JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrjk1rq+iraPiINz20G8gdaURZcmwB7c7XV1QgCdVpzNh6S63x2TKnQ5MF9j4dcPcmPs3c/cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/9zkSy7YBFGmx2rU6GL70KspLy4QqMolbldXyogQi85hH4dN
	fkkKMAEjG+TIw+Gk7M8v37x/UOcbaxw7+oYbnVDmxB2mQOFrtPWvTP2bDGX/PIzCTBIt33aFV5U
	7gh/mctuSTdYyUgY+b1YtkFsA0Tl2SWqW26pEtKpzAAZijx6TCCrlnQ==
X-Received: by 2002:a05:620a:28c7:b0:7a9:a744:f989 with SMTP id af79cd13be357-7a9e5f8fbc7mr21770185a.46.1726077143605;
        Wed, 11 Sep 2024 10:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaIBbrZV7quifxciyS6qJ4NtWPS4KWQAt/MZjRMAcRq6+Ll3a9JPMjdHfJgRHoxzT0Fv45mA==
X-Received: by 2002:a05:620a:28c7:b0:7a9:a744:f989 with SMTP id af79cd13be357-7a9e5f8fbc7mr21765685a.46.1726077142987;
        Wed, 11 Sep 2024 10:52:22 -0700 (PDT)
Received: from fedora-x1 (bras-base-london1622w-grc-35-184-146-85-211.dsl.bell.ca. [184.146.85.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1e3a8sm446257985a.117.2024.09.11.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:52:22 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:52:20 -0400
From: Kamal Heib <kheib@redhat.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: YangHang Liu <yanghliu@redhat.com>, Chao Yang <chayang@redhat.com>,
	ivecera <ivecera@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix trying to free
 already-freed IRQ
Message-ID: <ZuHY1DHpeg3K868D@fedora-x1>
References: <20240903182555.1253466-1-kheib@redhat.com>
 <CAGYh1E_tbTY5U1Uwpszw7KeUTaKXV0+Lw4AUgBFdsTbx=Gb73A@mail.gmail.com>
 <SJ0PR11MB586692C95212C29D929C0DA5E59C2@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <Ztjz4ZZIP8v6iKF1@fedora-x1>
 <SJ0PR11MB5866A1A4AF2FC7216B372E14E59D2@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <ZuD9MRVoiN2pmmpf@fedora-x1>
 <SJ0PR11MB586618D8EE350346110C02A6E59B2@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <SJ0PR11MB58669EBD94CD541831F3120DE59B2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB58669EBD94CD541831F3120DE59B2@SJ0PR11MB5866.namprd11.prod.outlook.com>

On Wed, Sep 11, 2024 at 08:50:39AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Loktionov, Aleksandr
> > Sent: Wednesday, September 11, 2024 10:35 AM
> > To: Kamal Heib <kheib@redhat.com>
> > Cc: YangHang Liu <yanghliu@redhat.com>; Chao Yang
> > <chayang@redhat.com>; ivecera <ivecera@redhat.com>;
> > netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; Nguyen,
> > Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; intel-wired-lan@lists.osuosl.org;
> > Paolo Abeni <pabeni@redhat.com>; David S . Miller
> > <davem@davemloft.net>
> > Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix trying to
> > free already-freed IRQ
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Kamal Heib <kheib@redhat.com>
> > > Sent: Wednesday, September 11, 2024 4:15 AM
> > > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > > Cc: YangHang Liu <yanghliu@redhat.com>; Chao Yang
> > > <chayang@redhat.com>; ivecera <ivecera@redhat.com>;
> > > netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; Nguyen,
> > > Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > > <przemyslaw.kitszel@intel.com>; intel-wired-lan@lists.osuosl.org;
> > > Paolo Abeni <pabeni@redhat.com>; David S . Miller
> > > <davem@davemloft.net>
> > > Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix trying to
> > > free already-freed IRQ
> > >
> > > On Thu, Sep 05, 2024 at 07:51:15AM +0000, Loktionov, Aleksandr
> > wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Kamal Heib <kheib@redhat.com>
> > > > > Sent: Thursday, September 5, 2024 1:57 AM
> > > > > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > > > > Cc: YangHang Liu <yanghliu@redhat.com>; Chao Yang
> > > > > <chayang@redhat.com>; ivecera <ivecera@redhat.com>;
> > > > > netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>;
> > Nguyen,
> > > > > Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > > > > <przemyslaw.kitszel@intel.com>; intel-wired-
> > lan@lists.osuosl.org;
> > > > > Paolo Abeni <pabeni@redhat.com>; David S . Miller
> > > > > <davem@davemloft.net>
> > > > > Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix trying
> > to
> > > > > free already-freed IRQ
> > > > >
> > > > > On Wed, Sep 04, 2024 at 09:00:32PM +0000, Loktionov, Aleksandr
> > > wrote:
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org>
> > On
> > > > > Behalf
> > > > > > > Of YangHang Liu
> > > > > > > Sent: Wednesday, September 4, 2024 4:37 AM
> > > > > > > To: Kamal Heib <kheib@redhat.com>; Chao Yang
> > > > > > > <chayang@redhat.com>
> > > > > > > Cc: ivecera <ivecera@redhat.com>; netdev@vger.kernel.org;
> > > Jakub
> > > > > > > Kicinski <kuba@kernel.org>; Nguyen, Anthony L
> > > > > > > <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > > > > > > <przemyslaw.kitszel@intel.com>;
> > > > > > > intel-wired-lan@lists.osuosl.org; Paolo Abeni
> > > > > > > <pabeni@redhat.com>; David S . Miller <davem@davemloft.net>
> > > > > > > Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix
> > > trying
> > > > > > > to free already-freed IRQ
> > > > > > >
> > > > > > > This issue can be reproduced by hot-unplugging the INTx i40e
> > > PF.
> > > > > > >
> > > > > > > The Call Trace will disappear after using Kamal's fix.
> > > > > > >
> > > > > > > Tested-by: Yanghang Liu<yanghliu@redhat.com>
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On Wed, Sep 4, 2024 at 2:26 AM Kamal Heib <kheib@redhat.com>
> > > wrote:
> > > > > > > >
> > > > > > > > Avoid the following warning when trying to free an already
> > > > > > > > freed
> > > > > > > IRQ,
> > > > > > > > The issue happens when trying to call i40e_remove() twice
> > > from
> > > > > two
> > > > > > > > different contexts which will lead to calling
> > > > > i40e_vsi_free_irq()
> > > > > > > > twice, Fix the issue by using a flag to mark that the IRQ
> > > has
> > > > > > > already been freed.
> > > > > > > >
> > > > > > > > i40e 0000:07:00.0: i40e_ptp_stop: removed PHC on enp7s0
> > > > > > > > ------------
> > > > > > > [
> > > > > > > > cut here ]------------ Trying to free already-free IRQ 0
> > > > > > > > WARNING: CPU: 2 PID: 12 at kernel/irq/manage.c:1868
> > > > > > > > __free_irq+0x1e3/0x350 Modules linked in: nft_fib_inet
> > > > > > > > nft_fib_ipv4
> > > > > > > > nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> > > > > nf_reject_ipv6
> > > > > > > > nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> > > > > nf_defrag_ipv6
> > > > > > > > nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink vfat fat
> > > > > > > > intel_rapl_msr intel_rapl_common kvm_amd ccp iTCO_wdt
> > > > > > > > iTCO_vendor_support kvm i2c_i801 pcspkr i40e lpc_ich
> > > > > > > > virtio_gpu i2c_smbus virtio_dma_buf drm_shmem_helper
> > > > > > > > drm_kms_helper virtio_balloon joydev drm fuse xfs
> > libcrc32c
> > > > > > > > ahci
> > > > > crct10dif_pclmul
> > > > > > > > libahci crc32_pclmul crc32c_intel virtio_net libata
> > > virtio_blk
> > > > > > > > ghash_clmulni_intel net_failover virtio_console failover
> > > > > serio_raw
> > > > > > > > dm_mirror dm_region_hash dm_log dm_mod
> > > > > > > > CPU: 2 PID: 12 Comm: kworker/u16:1 Kdump: loaded Not
> > tainted
> > > > > > > > 5.14.0-478.el9.x86_64 #1 Hardware name: Red Hat KVM/RHEL,
> > > BIOS
> > > > > > > > edk2-20240524-1.el9 05/24/2024
> > > > > > > > Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> > > > > > > > RIP: 0010:__free_irq+0x1e3/0x350
> > > > > > > > Code: 00 00 48 8b bb a8 01 00 00 e8 09 74 02 00 49 8b 7c
> > 24
> > > 30
> > > > > e8
> > > > > > > > 8f 7c 1d 00 eb 35 8b 74 24 04 48 c7 c7 50 a3 61 92 e8 cd
> > 99
> > > f6
> > > > > ff
> > > > > > > > <0f>
> > > > > > > 0b
> > > > > > > > 4c 89 fe 48 89 ef e8 30 aa b3 00 48 8b 43 40 48 8b 40 78
> > 48
> > > > > > > > RSP: 0018:ffffb971c0077ac8 EFLAGS: 00010086
> > > > > > > > RAX: 0000000000000000 RBX: ffff8b594193ee00 RCX:
> > > > > 0000000000000027
> > > > > > > > RDX: 0000000000000027 RSI: 00000000ffff7fff RDI:
> > > > > ffff8b59bcf208c8
> > > > > > > > RBP: ffff8b594193eec4 R08: 0000000000000000 R09:
> > > > > ffffb971c0077970
> > > > > > > > R10: ffffb971c0077968 R11: ffffffff931e7c28 R12:
> > > > > ffff8b5944946000
> > > > > > > > R13: ffff8b594193ef80 R14: ffff8b5944946000 R15:
> > > > > 0000000000000246
> > > > > > > > FS:  0000000000000000(0000) GS:ffff8b59bcf00000(0000)
> > > > > > > > knlGS:0000000000000000
> > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > CR2: 00007f11eb064000 CR3: 000000000ad40004 CR4:
> > > > > 0000000000770ef0
> > > > > > > > PKRU: 55555554
> > > > > > > > Call Trace:
> > > > > > > >  <TASK>
> > > > > > > >  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > > > > >  ? show_trace_log_lvl+0x26e/0x2df  ?
> > > > > > > > show_trace_log_lvl+0x26e/0x2df  ? free_irq+0x33/0x70  ?
> > > > > > > > __free_irq+0x1e3/0x350  ? __warn+0x7e/0xd0  ?
> > > > > > > > __free_irq+0x1e3/0x350  ? report_bug+0x100/0x140  ?
> > > > > > > > srso_alias_return_thunk+0x5/0xfbef5
> > > > > > > >  ? handle_bug+0x3c/0x70
> > > > > > > >  ? exc_invalid_op+0x14/0x70
> > > > > > > >  ? asm_exc_invalid_op+0x16/0x20  ? __free_irq+0x1e3/0x350
> > ?
> > > > > > > > __free_irq+0x1e3/0x350
> > > > > > > >  free_irq+0x33/0x70
> > > > > > > >  i40e_vsi_free_irq+0x19e/0x220 [i40e]
> > > > > > > >  i40e_vsi_close+0x2b/0xc0 [i40e]
> > > > > > > >  i40e_close+0x11/0x20 [i40e]
> > > > > > > >  __dev_close_many+0x9e/0x110
> > > > > > > >  dev_close_many+0x8b/0x140
> > > > > > > >  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > > > > >  ? free_pcppages_bulk+0xee/0x290
> > > > > > > >  unregister_netdevice_many_notify+0x162/0x690
> > > > > > > >  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > > > > >  ? free_unref_page_commit+0x19a/0x310
> > > > > > > >  unregister_netdevice_queue+0xd3/0x110
> > > > > > > >  unregister_netdev+0x18/0x20
> > > > > > > >  i40e_vsi_release+0x84/0x2e0 [i40e]  ?
> > > > > > > > srso_alias_return_thunk+0x5/0xfbef5
> > > > > > > >  i40e_remove+0x15c/0x430 [i40e]
> > > > > > > >  pci_device_remove+0x3e/0xb0
> > > > > > > >  device_release_driver_internal+0x193/0x200
> > > > > > > >  pci_stop_bus_device+0x6c/0x90
> > > > > > > >  pci_stop_and_remove_bus_device+0xe/0x20
> > > > > > > >  disable_slot+0x49/0x90
> > > > > > > >  acpiphp_disable_and_eject_slot+0x15/0x90
> > > > > > > >  hotplug_event+0xea/0x210
> > > > > > > >  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
> > > > > > > >  acpiphp_hotplug_notify+0x22/0x80  ?
> > > > > > > > __pfx_acpiphp_hotplug_notify+0x10/0x10
> > > > > > > >  acpi_device_hotplug+0xb8/0x210
> > > > > > > >  acpi_hotplug_work_fn+0x1a/0x30
> > > > > > > >  process_one_work+0x197/0x380
> > > > > > > >  worker_thread+0x2fe/0x410
> > > > > > > >  ? __pfx_worker_thread+0x10/0x10
> > > > > > > >  kthread+0xe0/0x100
> > > > > > > >  ? __pfx_kthread+0x10/0x10
> > > > > > > >  ret_from_fork+0x2c/0x50
> > > > > > > >  </TASK>
> > > > > > > > ---[ end trace 0000000000000000 ]---
> > > > > > > >
> > > > > > > > Fixes: 41c445ff0f48 ("i40e: main driver core")
> > > > > > > > Tested-by: YangHang Liu <yanghliu@redhat.com>
> > > > > > > > Signed-off-by: Kamal Heib <kheib@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
> > > > > > > >  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
> > > > > > > >  2 files changed, 9 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> > > > > > > > b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > > > > > index d546567e0286..910415116995 100644
> > > > > > > > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > > > > > > > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > > > > > @@ -865,6 +865,7 @@ struct i40e_vsi {
> > > > > > > >         int num_q_vectors;
> > > > > > > >         int base_vector;
> > > > > > > >         bool irqs_ready;
> > > > > > > > +       bool legacy_msi_irq_ready;
> > > > > > I'm against adding additional boolian var which can cause race
> > > > > conditions.
> > > > > > Use I40E_FLAG_MSIX_ENA or at least add additional bit and use
> > > > > interlock test_and_clean/test_and_set bit functions instead.
> > > > > >
> > > > >
> > > > > Hi Aleksandr,
> > > > >
> > > > > Thanks for your review!
> > > > >
> > > > > This patch was inspired by the use of "irqs_ready" boolian flag
> > in
> > > > > the case that I40E_FLAG_MSIX_ENA is set, Please take a look at
> > the
> > > > > following change from 2014 for more info:
> > > > >
> > > > > 6374184672c8 ("i40e: remove irqs only when they are set up")
> > > > >
> > > > > I'll change the patch to use your suggstion, but probably the
> > use
> > > of
> > > > > "irqs_ready" needs to be changed too.
> > > > >
> > > > > Thanks,
> > > > > Kamal
> > > >
> > > > Thank you for pointing me to similar fix, now I see my mistake -
> > > I40E_FLAG_MSIX_ENA is pf level flag.
> > > > Now we have a race in i40e_vsi_release() v i40e_close() and
> > probably
> > > a better solution to use interlocked bits in i40e_vsi struct.
> > > >
> > > > But for me it looks like a race on higher level -  vsi states.
> > > > If i40e_remove() already called i40e_vsi_close() then when
> > > i40e_close() calls i40e_vsi_close() second time i40e_vsi_close()
> > must
> > > just bail out with nothing to do.
> > > > Do you see my point, it's not just interrupt freeing race, it's
> > vsi
> > > state race. We need to make i40e_vsi_close() and i40e_vsi_release()
> > > idempotent.
> > > >
> > > > Proper fix should be something like:
> > > >   Add vsi_state interlocked bit-set into vsi struct.
> > > >
> > > >   Replace everywhere in i40e code sequence of two calls:
> > > > 	i40e_vsi_close(pf->vsi[i]);
> > > > 	i40e_vsi_release(pf->vsi[i]);
> > > >   With single one:
> > > > 	i40e_vsi_release(pf->vsi[i]);
> > > >
> > > > i40e_vsi_release() must interlock vsi state to prevent re-entrance
> > > and double calls.
> > > > 			must first call i40e_vsi_close()
> > > >
> > > > i40e_vsi_close() must interlock vsi state to prevent re-entrance
> > and
> > > double calls.
> > > >
> > > > From my point of view this is much closer to the proper fix.
> > > > Introducing simple race-prone bool variable is just adding one
> > more
> > > timebomb.
> > > >
> > > > With the best regards
> > > > Alex
> > >
> > > Hi Alex,
> > >
> > > Thanks for your review and feedback!
> > >
> > > I've prepared the following change based on the above suggestion,
> > > Could you please take a look and give your feedback:
> > Waw, it looks almost perfect for me.
> > Just wonder why we didn't came to such solution before.
> > 
> But just one more thing!
> i40e_vsi_close() and i40e_vsi_release() need to be not only idempotent, but synchronous too! To preserve driver logic working and be safe.
> I.e. the function needs to return only when other thread returned from the same function.
>

Unless I'm missing something, seems like i40e_vsi_release() is already
calling i40e_vsi_close() or i40e_close() (which calles i40e_vsi_close()),
please take a look at the following code from i40e_vsi_release()

if (vsi->type != I40E_VSI_SRIOV) {
        if (vsi->netdev_registered) {
                vsi->netdev_registered = false;
                if (vsi->netdev) {
                        /* results in a call to i40e_close() */
                        unregister_netdev(vsi->netdev);
                }
        } else {
                i40e_vsi_close(vsi);
        }
        i40e_vsi_disable_irq(vsi);
}

Thanks,
Kamal
 
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> > > b/drivers/net/ethernet/intel/i40e/i40e.h
> > > index d546567e0286..2ed0a027ce69 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > > @@ -135,6 +135,7 @@ enum i40e_vsi_state {
> > >         __I40E_VSI_REINIT_REQUESTED,
> > >         __I40E_VSI_DOWN_REQUESTED,
> > >         __I40E_VSI_RELEASING,
> > > +       __I40E_VSI_CLOSING,
> > >         /* This must be last as it determines the size of the BITMAP
> > > */
> > >         __I40E_VSI_STATE_SIZE__,
> > >  };
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > index cbcfada7b357..b883e187fc9b 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > @@ -5233,6 +5233,10 @@ static void i40e_napi_disable_all(struct
> > > i40e_vsi *vsi)  static void i40e_vsi_close(struct i40e_vsi *vsi)  {
> > >         struct i40e_pf *pf = vsi->back;
> > > +
> > > +       if (test_and_set_bit(__I40E_VSI_CLOSING, vsi->state))
> > > +               return;
> I think just returning is not enough, to preserve driver logic, here we need to wait until another thread will close and return only then.
> 
> > > +
> > >         if (!test_and_set_bit(__I40E_VSI_DOWN, vsi->state))
> > >                 i40e_down(vsi);
> > >         i40e_vsi_free_irq(vsi);
> > > @@ -7422,6 +7426,7 @@ static int i40e_up_complete(struct i40e_vsi
> > > *vsi)
> > >                 return err;
> > >
> > >         clear_bit(__I40E_VSI_DOWN, vsi->state);
> > > +       clear_bit(__I40E_VSI_CLOSING, vsi->state);
> > >         i40e_napi_enable_all(vsi);
> > >         i40e_vsi_enable_irq(vsi);
> > >
> > > @@ -14162,7 +14167,10 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
> > >                 dev_info(&pf->pdev->dev, "Can't remove PF VSI\n");
> > >                 return -ENODEV;
> > >         }
> > Please don't forget to call void i40e_vsi_close() in this function
> > then!
> > From the first glance the i40e_vsi_close() call should go here.
> > 
> > > -       set_bit(__I40E_VSI_RELEASING, vsi->state);
> > > +
> > > +       if (test_and_set_bit(__I40E_VSI_RELEASING, vsi->state))
> > > +               return -ENODEV;
> > > +
> > But the i40e_vsi_close() call could be here, can you double check?
> > Thank you
> > 
> > 
> > >         uplink_seid = vsi->uplink_seid;
> > >
> > >         if (vsi->type != I40E_VSI_SRIOV) { @@ -16270,7 +16278,6 @@
> > > static void i40e_remove(struct pci_dev *pdev)
> > >          * adminq and hmc.
> > >          */
> > >         i40e_pf_for_each_vsi(pf, i, vsi) {
> > > -               i40e_vsi_close(vsi);
> > >                 i40e_vsi_release(vsi);
> > >                 pf->vsi[i] = NULL;
> > >         }
> > >
> > >
> > > Thanks,
> > > Kamal
> > >
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > >         u16 seid;               /* HW index of this VSI
> > > > > (absolute
> > > > > > > index) */
> > > > > > > >         u16 id;                 /* VSI number */
> > > > > > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > > > > > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > > > > > index cbcfada7b357..b39004a42df2 100644
> > > > > > > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > > > > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > > > > > @@ -4630,6 +4630,9 @@ static int
> > i40e_vsi_request_irq(struct
> > > > > > > i40e_vsi *vsi, char *basename)
> > > > > > > >         if (err)
> > > > > > > >                 dev_info(&pf->pdev->dev, "request_irq
> > > failed,
> > > > > > > > Error %d\n", err);
> > > > > > > >
> > > > > > > > +       if (!test_bit(I40E_FLAG_MSIX_ENA, pf->flags) &&
> > > !err)
> > > > > > > > +               vsi->legacy_msi_irq_ready = true;
> > > > > > > > +
> > > > > > > >         return err;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > @@ -5061,6 +5064,10 @@ static void
> > i40e_vsi_free_irq(struct
> > > > > > > > i40e_vsi
> > > > > > > *vsi)
> > > > > > > >                         }
> > > > > > > >                 }
> > > > > > > >         } else {
> > > > > > > > +               if (!vsi->legacy_msi_irq_ready)
> > > > > > > > +                       return;
> > > > > > > > +
> > > > > > > > +               vsi->legacy_msi_irq_ready = false;
> > > > > > > >                 free_irq(pf->pdev->irq, pf);
> > > > > > > >
> > > > > > > >                 val = rd32(hw, I40E_PFINT_LNKLST0); @@
> > > > > > > > -11519,6
> > > > > > > > +11526,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf
> > > *pf,
> > > > > enum
> > > > > > > i40e_vsi_type type)
> > > > > > > >         vsi->work_limit = I40E_DEFAULT_IRQ_WORK;
> > > > > > > >         hash_init(vsi->mac_filter_hash);
> > > > > > > >         vsi->irqs_ready = false;
> > > > > > > > +       vsi->legacy_msi_irq_ready = false;
> > > > > > > >
> > > > > > > >         if (type == I40E_VSI_MAIN) {
> > > > > > > >                 vsi->af_xdp_zc_qps =
> > > > > > > > bitmap_zalloc(pf->num_lan_qps, GFP_KERNEL);
> > > > > > > > --
> > > > > > > > 2.46.0
> > > > > > > >
> > > > > >
> > > >
> 


