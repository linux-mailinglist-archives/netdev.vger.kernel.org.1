Return-Path: <netdev+bounces-209649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2DB1022C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E59D189C215
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51269266EE7;
	Thu, 24 Jul 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmC1X7OV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBD1FDE09
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343286; cv=none; b=Ya/7c4f+tmtgNxRrW0/bFS/fCgug4GWfPCcJ5sPVWFbFkURl9axNMcbV4z+18o9aXcOZBQwyFpGV1R8H1bmhXKox4RyCbHZEcVupLm0xqC0TttplEnNQDeVFN/1U5TUCvNqUs5k+OKrOcpg3FBJhwlIV4fqSQfA6fMfu3v7Rv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343286; c=relaxed/simple;
	bh=4KNiWzFV2bNN8cOxxtE1m+R1Lm2UXbqQYZ2qmeab3BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3KJKeEdPaGJFKMOmIYDaN/U5hvPoDsLBeQ5wEulu3dEURKigZSZcYhbJV3eoYUz9Zi0jNtXb6jW3JheuEG0m+m9XAP6C1oxUcyGulFFZmWhGwZznYUkQbzkepiVQj64QtTcumL/Of2Tz/Avf5lqbJ5p8tl/dIN/KqWhC4cZJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmC1X7OV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753343283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/POiMtYV9nanueUjphvuy30vmh+pvymQRZNCoduHXo=;
	b=QmC1X7OVHDS2PvX9vBVL9xejioAlgUzVN+j+KTOlIbvn2BadRyP/sA6JaHq98pT8qV79Rn
	dXnrvqZyT3H5NMUqYQiSyfE/IrGTE24m8TnfgEevjUPqoQ2HQ2RpUq/SmP0pXJPKD3ofkI
	5HJWqR73VQn1mdcN6K8W4m9CO67MNtA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-fm-kydTqPNimxmPOfa2fWw-1; Thu, 24 Jul 2025 03:48:00 -0400
X-MC-Unique: fm-kydTqPNimxmPOfa2fWw-1
X-Mimecast-MFC-AGG-ID: fm-kydTqPNimxmPOfa2fWw_1753343280
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so405434f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 00:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343279; x=1753948079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/POiMtYV9nanueUjphvuy30vmh+pvymQRZNCoduHXo=;
        b=FKyvxCQVBCfHOJb/SBgARpF4eyK0Hbbct50uF907fCvBzU6lMgsMdezpW5HR57J8ul
         sq7zhq7ndHyI7rwmoPgJjYnk9dq9WuoIs1DFQLU3OCldsEEzm8GTHbO/PKBRTAofXNhJ
         /p2hmtjECyz1/7/2wJfYWndJUM6xrEdrBWkshwEU7HLIX0cj2UPEOgp1q/IDnoA96jit
         aUyGpg1La2iezn71LLLtS+BPzdOAFUl7vdyWwNgRc9P8qizcvR+HOb617dzgASP117IJ
         G+Mdu2Rqm3NT4fe7snsfT5gTXfgQdrbCkWpREsg/nBjYvGlM4Lqaa0Hj17bpuIVcX5Nd
         Jf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0/Dm8uuWf0+EqrT9m8bnM8S8vc7Vwi+cYjKPdI9HwLwfPOCuysMjqPdvVBhxWh55rucGeTu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xj6NfUgKgT3Ta3X+IGeTK2URiHhLf7zHfXJZRHTC18wRI530
	gZj9qVyWn8b5soWZCok2sbs36GoiP3Jl/ydQUYD8ZQEfjaVXLtUpBKfpRbdn2O5wFVclbOlOrMo
	/pDVOxCJWTnLMgBOA6hNufyLtJd6TAS0UaGzjyYQkA6LVgiCT6WDuKEhk3g==
X-Gm-Gg: ASbGncsEmMFK4Ociw4WA3xZgKRA/O8PQKaWZQj02oD3bjHhxp6ove2ShXVDiLVhmVFB
	qqayM1Xqla6RN0iTFTE8jeq+tFsj8FmcuccbyihVpdkQ/m8WoHpLd7ryilOcrNRHmdTxui4Dx9a
	HAIJZuCFW/z1OpF0y0HPqEZBqFvuOBna2EfuxQeWVsS5zQ/uKJHD0cGtDa801cmlxR7Y3PWyeMQ
	bDzv+elvL4BFh9JJhHp3fh+87ITU5vp1W39LxF7kHVDRoB35PuwAhE5FkrWT14KblvammQGnBxr
	eWkPDZ4ZanJAzTp39bLrdZOaJy1NboFGsFg=
X-Received: by 2002:a05:6000:2282:b0:3aa:caea:aa7f with SMTP id ffacd0b85a97d-3b768f2fb02mr4659131f8f.56.1753343279546;
        Thu, 24 Jul 2025 00:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOTPsIwokUe1RrqwNEvvDU/YeV+sC8OwKuHXpbMrKFltW01eLRSdc64q4eeersKEit6tiUtg==
X-Received: by 2002:a05:6000:2282:b0:3aa:caea:aa7f with SMTP id ffacd0b85a97d-3b768f2fb02mr4659111f8f.56.1753343279021;
        Thu, 24 Jul 2025 00:47:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc71437sm1296280f8f.29.2025.07.24.00.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:47:58 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:47:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: jasowang@redhat.com, eperezma@redhat.com,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Subject: Re: vhost: linux-next: crash at vhost_dev_cleanup()
Message-ID: <20250724034659-mutt-send-email-mst@kernel.org>
References: <vosten2rykookljp6u6qc4hqhsqb6uhdy2iuhpl54plbq2tkr4@kphfpgst3e7c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vosten2rykookljp6u6qc4hqhsqb6uhdy2iuhpl54plbq2tkr4@kphfpgst3e7c>

On Wed, Jul 23, 2025 at 08:04:42AM -0700, Breno Leitao wrote:
> Hello,
> 
> I've seen a crash in linux-next for a while on my arm64 server, and
> I decided to report.
> 
> While running stress-ng on linux-next, I see the crash below.
> 
> This is happening in a kernel configure with some debug options (KASAN,
> LOCKDEP and KMEMLEAK).
> 
> Basically running stress-ng in a loop would crash the host in 15-20
> minutes:
> 	# while (true); do stress-ng -r 10 -t 10; done
> 	
> >From the early warning "virt_to_phys used for non-linear address",
> I suppose corrupted data is at vq->nheads.
> 
> Here is the decoded stack against 9798752 ("Add linux-next specific
> files for 20250721")
> 
> 
> 	[  620.685144] [ T250731] VFIO - User Level meta-driver version: 0.3
> 	[  622.394448] [ T250254] ------------[ cut here ]------------
> 	[  622.413492] [ T250254] virt_to_phys used for non-linear address: 000000006e69fe64 (0xcfcecdcccbcac9c8)
> 	[  622.447771] [     T250254] WARNING: arch/arm64/mm/physaddr.c:15 at __virt_to_phys+0x64/0x90, CPU#57: stress-ng-dev/250254 
> 	[  622.487227] [ T250254] Modules linked in: vhost_vsock(E) vfio_iommu_type1(E) vfio(E) unix_diag(E) sch_fq(E) ghes_edac(E) tls(E) tcp_diag(E) inet_diag(E) act_gact(E) cls_bpf(E) nvidia_cspmu(E) ipmi_ssif(E) coresight_trbe(E) arm_cspmu_module(E) arm_smmuv3_pmu(E) ipmi_devintf(E) coresight_stm(E) coresight_funnel(E) coresight_etm4x(E) coresight_tmc(E) stm_core(E) ipmi_msghandler(E) coresight(E) cppc_cpufreq(E) sch_fq_codel(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) sm3_ce(E) sha3_ce(E) spi_tegra210_quad(E) vhost_net(E) tap(E) tun(E) vhost(E) vhost_iotlb(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) acpi_power_meter(E) loop(E) efivarfs(E) autofs4(E) [last unloaded: test_bpf(E)]
> 	[  622.734524] [ T250254] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
> 	[  622.734525] [ T250254] Hardware name: ...
> 	[  622.734526] [ T250254] pstate: 63401009 (nZCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
> 	[  622.734529] [     T250254] pc : __virt_to_phys (/home/user/Devel/linux-next/arch/arm64/mm/physaddr.c:?) 
> 	[  622.734531] [     T250254] lr : __virt_to_phys (/home/user/Devel/linux-next/arch/arm64/mm/physaddr.c:?) 
> 	[  622.734533] [ T250254] sp : ffff800158e8fc60
> 	[  622.734534] [ T250254] x29: ffff800158e8fc60 x28: ffff0034a7cc7900 x27: 0000000000000000
> 	[  622.734537] [ T250254] x26: 0000000000000000 x25: ffff0034a7cc7900 x24: 00000000040e001f
> 	[  622.734539] [ T250254] x23: ffff0010858afb00 x22: cfcecdcccbcac9c8 x21: ffff0033526a01e0
> 	[  622.734541] [ T250254] x20: 0000000000008000 x19: ffcecdcccbcac9c8 x18: ffff80008149c8e4
> 	[  622.734543] [ T250254] x17: 0000000000000001 x16: 0000000000000000 x15: 0000000000000003
> 	[  622.734545] [ T250254] x14: ffff800082962e78 x13: 0000000000000003 x12: ffff003bc6231630
> 	[  622.734546] [ T250254] x11: 0000000000000000 x10: 0000000000000000 x9 : ed44a220ae716b00
> 	[  622.734548] [ T250254] x8 : 0001000000000000 x7 : 0720072007200720 x6 : ffff80008018710c
> 	[  622.734550] [ T250254] x5 : 0000000000000001 x4 : 00000090ecc72ac0 x3 : 0000000000000000
> 	[  622.734552] [ T250254] x2 : 0000000000000000 x1 : ffff800081a72bc6 x0 : 000000000000004f
> 	[  622.734554] [ T250254] Call trace:
> 	[  622.734555] [     T250254] __virt_to_phys (/home/user/Devel/linux-next/arch/arm64/mm/physaddr.c:?) (P)
> 	[  622.734557] [     T250254] kfree (/home/user/Devel/linux-next/./include/linux/mm.h:1180 /home/user/Devel/linux-next/mm/slub.c:4871) 
> 	[  622.734562] [     T250254] vhost_dev_cleanup (/home/user/Devel/linux-next/drivers/vhost/vhost.c:506 /home/user/Devel/linux-next/drivers/vhost/vhost.c:542 /home/user/Devel/linux-next/drivers/vhost/vhost.c:1214) vhost 
> 	[  622.734571] [     T250254] vhost_vsock_dev_release (/home/user/Devel/linux-next/drivers/vhost/vsock.c:756) vhost_vsock 


Cc more vsock maintainers.




> 	[  622.734575] [     T250254] __fput (/home/user/Devel/linux-next/fs/file_table.c:469) 
> 	[  622.734578] [     T250254] fput_close_sync (/home/user/Devel/linux-next/fs/file_table.c:?) 
> 	[  622.734579] [     T250254] __arm64_sys_close (/home/user/Devel/linux-next/fs/open.c:1589 /home/user/Devel/linux-next/fs/open.c:1572 /home/user/Devel/linux-next/fs/open.c:1572) 
> 	[  622.734584] [     T250254] invoke_syscall (/home/user/Devel/linux-next/arch/arm64/kernel/syscall.c:50) 
> 	[  622.734589] [     T250254] el0_svc_common (/home/user/Devel/linux-next/./include/linux/thread_info.h:135 /home/user/Devel/linux-next/arch/arm64/kernel/syscall.c:140) 
> 	[  622.734591] [     T250254] do_el0_svc (/home/user/Devel/linux-next/arch/arm64/kernel/syscall.c:152) 
> 	[  622.734594] [     T250254] el0_svc (/home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:169 /home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:182 /home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:880) 
> 	[  622.734600] [     T250254] el0t_64_sync_handler (/home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:958) 
> 	[  622.734603] [     T250254] el0t_64_sync (/home/user/Devel/linux-next/arch/arm64/kernel/entry.S:596) 
> 	[  622.734605] [ T250254] irq event stamp: 0
> 	[  622.734606] [     T250254] hardirqs last enabled at (0): 0x0 
> 	[  622.734610] [     T250254] hardirqs last disabled at (0): copy_process (/home/user/Devel/linux-next/kernel/fork.c:?) 
> 	[  622.734614] [     T250254] softirqs last enabled at (0): copy_process (/home/user/Devel/linux-next/kernel/fork.c:?) 
> 	[  622.734616] [     T250254] softirqs last disabled at (0): 0x0 
> 	[  622.734618] [ T250254] ---[ end trace 0000000000000000 ]---
> 	[  622.734697] [ T250254] Unable to handle kernel paging request at virtual address 003ff3b33312f288
> 	[  622.734700] [ T250254] Mem abort info:
> 	[  622.734701] [ T250254]   ESR = 0x0000000096000004
> 	[  622.734702] [ T250254]   EC = 0x25: DABT (current EL), IL = 32 bits
> 	[  622.734704] [ T250254]   SET = 0, FnV = 0
> 	[  622.734705] [ T250254]   EA = 0, S1PTW = 0
> 	[  622.734706] [ T250254]   FSC = 0x04: level 0 translation fault
> 	[  622.734708] [ T250254] Data abort info:
> 	[  622.734709] [ T250254]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> 	[  622.734711] [ T250254]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> 	[  622.734712] [ T250254]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> 	[  622.734713] [ T250254] [003ff3b33312f288] address between user and kernel address ranges
> 	[  622.734715] [ T250254] Internal error: Oops: 0000000096000004 [#1]  SMP
> 	[  622.734718] [ T250254] Modules linked in: vhost_vsock(E) vfio_iommu_type1(E) vfio(E) unix_diag(E) sch_fq(E) ghes_edac(E) tls(E) tcp_diag(E) inet_diag(E) act_gact(E) cls_bpf(E) nvidia_cspmu(E) ipmi_ssif(E) coresight_trbe(E) arm_cspmu_module(E) arm_smmuv3_pmu(E) ipmi_devintf(E) coresight_stm(E) coresight_funnel(E) coresight_etm4x(E) coresight_tmc(E) stm_core(E) ipmi_msghandler(E) coresight(E) cppc_cpufreq(E) sch_fq_codel(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) sm3_ce(E) sha3_ce(E) spi_tegra210_quad(E) vhost_net(E) tap(E) tun(E) vhost(E) vhost_iotlb(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) acpi_power_meter(E) loop(E) efivarfs(E) autofs4(E) [last unloaded: test_bpf(E)]
> 	[  622.734740] [ T250254] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
> 	[  622.734740] [ T250254] Hardware name: ...
> 	[  622.734741] [ T250254] pstate: 63401009 (nZCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
> 	[  622.734742] [     T250254] pc : kfree (/home/user/Devel/linux-next/./include/linux/page-flags.h:284 /home/user/Devel/linux-next/./include/linux/mm.h:1182 /home/user/Devel/linux-next/mm/slub.c:4871) 
> 	[  622.734745] [     T250254] lr : kfree (/home/user/Devel/linux-next/./include/linux/mm.h:1180 /home/user/Devel/linux-next/mm/slub.c:4871) 
> 	[  622.734747] [ T250254] sp : ffff800158e8fc80
> 	[  622.734748] [ T250254] x29: ffff800158e8fc90 x28: ffff0034a7cc7900 x27: 0000000000000000
> 	[  622.734749] [ T250254] x26: 0000000000000000 x25: ffff0034a7cc7900 x24: 00000000040e001f
> 	[  622.734751] [ T250254] x23: ffff0010858afb00 x22: cfcecdcccbcac9c8 x21: ffff0033526a01e0
> 	[  622.734752] [ T250254] x20: 003ff3b33312f280 x19: ffff80000acd1a20 x18: ffff80008149c8e4
> 	[  622.734754] [ T250254] x17: 0000000000000001 x16: 0000000000000000 x15: 0000000000000003
> 	[  622.734755] [ T250254] x14: ffff800082962e78 x13: 0000000000000003 x12: ffff003bc6231630
> 	[  622.734757] [ T250254] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffffdfc0000000
> 	[  622.734758] [ T250254] x8 : 003ff3d37312f280 x7 : 0720072007200720 x6 : ffff80008018710c
> 	[  622.734760] [ T250254] x5 : 0000000000000001 x4 : 00000090ecc72ac0 x3 : 0000000000000000
> 	[  622.734761] [ T250254] x2 : 0000000000000000 x1 : ffff800081a72bc6 x0 : ffcf4dcccbcac9c8
> 	[  622.734763] [ T250254] Call trace:
> 	[  622.734763] [     T250254] kfree (/home/user/Devel/linux-next/./include/linux/page-flags.h:284 /home/user/Devel/linux-next/./include/linux/mm.h:1182 /home/user/Devel/linux-next/mm/slub.c:4871) (P)
> 	[  622.734766] [     T250254] vhost_dev_cleanup (/home/user/Devel/linux-next/drivers/vhost/vhost.c:506 /home/user/Devel/linux-next/drivers/vhost/vhost.c:542 /home/user/Devel/linux-next/drivers/vhost/vhost.c:1214) vhost 
> 	[  622.734769] [     T250254] vhost_vsock_dev_release (/home/user/Devel/linux-next/drivers/vhost/vsock.c:756) vhost_vsock 
> 	[  622.734771] [     T250254] __fput (/home/user/Devel/linux-next/fs/file_table.c:469) 
> 	[  622.734772] [     T250254] fput_close_sync (/home/user/Devel/linux-next/fs/file_table.c:?) 
> 	[  622.734773] [     T250254] __arm64_sys_close (/home/user/Devel/linux-next/fs/open.c:1589 /home/user/Devel/linux-next/fs/open.c:1572 /home/user/Devel/linux-next/fs/open.c:1572) 
> 	[  622.734776] [     T250254] invoke_syscall (/home/user/Devel/linux-next/arch/arm64/kernel/syscall.c:50) 
> 	[  622.734778] [     T250254] el0_svc_common (/home/user/Devel/linux-next/./include/linux/thread_info.h:135 /home/user/Devel/linux-next/arch/arm64/kernel/syscall.c:140) 
> 	[  622.734781] [     T250254] do_el0_svc (/home/user/Devel/linux-next/arch/arm64/kernel/syscall.c:152) 
> 	[  622.734783] [     T250254] el0_svc (/home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:169 /home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:182 /home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:880) 
> 	[  622.734787] [     T250254] el0t_64_sync_handler (/home/user/Devel/linux-next/arch/arm64/kernel/entry-common.c:958) 
> 	[  622.734790] [     T250254] el0t_64_sync (/home/user/Devel/linux-next/arch/arm64/kernel/entry.S:596) 
> 	[ 622.734792] [ T250254] Code: f2dffbe9 927abd08 cb141908 8b090114 (f9400688)
> 	All code
> 	========
> 	0:*	e9 fb df f2 08       	jmp    0x8f2e000		<-- trapping instruction
> 	5:	bd 7a 92 08 19       	mov    $0x1908927a,%ebp
> 	a:	14 cb                	adc    $0xcb,%al
> 	c:	14 01                	adc    $0x1,%al
> 	e:	09 8b 88 06 40 f9    	or     %ecx,-0x6bff978(%rbx)
> 
> 	Code starting with the faulting instruction
> 	===========================================
> 	0:	88 06                	mov    %al,(%rsi)
> 	2:	40 f9                	rex stc 
> 	[  622.734795] [ T250254] SMP: stopping secondary CPUs
> 	[  622.735089] [ T250254] Starting crashdump kernel...
> 	[  622.735091] [ T250254] Bye!


