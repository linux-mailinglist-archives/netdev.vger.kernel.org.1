Return-Path: <netdev+bounces-130543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B618898AC10
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0291F23AAB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E00198E93;
	Mon, 30 Sep 2024 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SU6wPL38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7442B9A5
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720878; cv=none; b=lYEoRxHiKLCB6QlCeINGl1GXlTUq29ad46iwygty5f4BKPlCwR71qfYqw9tlK/Npb0POHg8MuDCU/2TT2VWUyhRYRb7XDp+11Bp6MBYtKhK0srEfxOnl4QZtaXbpqnpdSXTeUYigYQepzvxjBmTV/RnRVISN4p6SXJ+HGD1DeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720878; c=relaxed/simple;
	bh=nvwJJ15JmmkZT83aobCZ7FHy1UzocWPcTJVI45aKs+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9KvF6GsqVadhj441A+KS2VgW7Hf+CbAIw3ynXs/jHNwZDQvcn79Kx62es2/L/xcwVa2LlMdwDv8HFDkVQprL2NSU1jDNpvDUmMFjogap7qIWoLOmC56Y7hqNuVUT17R8UgQzIp0I7ENNKpBevjnsc+ptlwy1yVjzYQUGDqw1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SU6wPL38; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b1335e4e4so42797395ad.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727720876; x=1728325676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ8ek2hT/WFDjyeRsPQC6Ye9s+aSlMGsNX4bBi7RmHM=;
        b=SU6wPL388BuWNeYCPUVMRm3YeOjB7pE7Cn8PMcTj4MLV1y/qxYubgbla2h3CkIPdWE
         sMY4oCsHrpp4mZirvDA82VFnJLdV6elmGtyNiT20LXCi6zIA3ZNdrrcHIHTbe/dJ0TUJ
         riz+kZBFG7GN/Nf6JP/3f1bs3uu5mRAwCCUDJBDyxwmQv+CtLcN5i18wfba27mt5+y6j
         jqX6LptjfLnCyViDwtMKS4BSj1jxl6SodeQXChNvv7ILnwFA/Sfj50J7oWkc84YUDYBt
         TwFew2Ntz9Ot+ifTxH+7bsGPjKfPD88UHH4v8BIN5gOhJPgobmdXLVxaN7cdXDTG8C7F
         V8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720876; x=1728325676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ8ek2hT/WFDjyeRsPQC6Ye9s+aSlMGsNX4bBi7RmHM=;
        b=JQZWoplfB5l13uyRxFYIuziNsagv7aZi/VCVVQaTyjAHyB3T/wUYWQG6D+gSs3OjsE
         ymfOPXnEgXMvxgFE0/nwfn4Jp7R/GS+rIwOQ9O7/ck/F9Cd2oPrO8hTGcUkDIs6Tw3iU
         kMR8M5i8hLuxD+qIkgQrT+v4A+GCGDxXatzbPVMpTj36N25G0K3m7dlBpc6EVsIV8WUm
         ZYwb5OyO3ZR1CKdrP+lbP0fVZC7OUSLc1+tOwN/s+j1L63ouYfv5uo4BWwbEuWORdnVV
         Eke9rjgJp41xgfNBydoLePI6829yzUM8mvGRE3wYpMLjmWNS75WFm2k5ZpH/x8Qov/NC
         NJsw==
X-Forwarded-Encrypted: i=1; AJvYcCU/I5LdhrtF1DufRl9RUIlv0VaCPbf7wzM8z33W17BOnPIj7qNZXm14aWapCaBZO3Cfa9BPKA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvPkUPFfYkJ/hr91uXHjVZ+xS6Ofea4eaHE+uxiuDQp6LogoO
	0xvb5rcjlxf6Pvv6pnJmW6nVg7s+OfnXzJgzo89sFtjVPU1aAtm+4IYNUxcq1P0=
X-Google-Smtp-Source: AGHT+IEPD0M1S4D/tI6Apuz0+SRKRkbBIq0MNt57C/GmcGlxlEEyiQcbKrX6kS3f6EzAtW+NVLq8Kg==
X-Received: by 2002:a17:902:e547:b0:20b:9034:fb44 with SMTP id d9443c01a7336-20b9034fbdbmr48466935ad.16.1727720875944;
        Mon, 30 Sep 2024 11:27:55 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37d67769sm57209885ad.33.2024.09.30.11.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:27:55 -0700 (PDT)
Date: Mon, 30 Sep 2024 11:27:54 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	"Zhong, YuanYuan" <yzhong@purestorage.com>,
	Jeff Garzik <jgarzik@redhat.com>, Ying Hsu <yinghsu@chromium.org>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] igb: Do not bring the device up
 after non-fatal error
Message-ID: <Zvrtqt_0bc9rSBX6@apollo.purestorage.com>
References: <20240924210604.123175-1-mkhalfella@purestorage.com>
 <20240924210604.123175-2-mkhalfella@purestorage.com>
 <CYYPR11MB8429494B65C5E9A025BF8F96BD742@CYYPR11MB8429.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYYPR11MB8429494B65C5E9A025BF8F96BD742@CYYPR11MB8429.namprd11.prod.outlook.com>

On 2024-09-28 14:40:05 +0000, Pucha, HimasekharX Reddy wrote:
> >-----Original Message-----
> >From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Mohamed Khalfella
> > Sent: Wednesday, September 25, 2024 2:36 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Auke Kok <auke-jan.h.kok@intel.com>; Zhong, YuanYuan <yzhong@purestorage.com>; Jeff Garzik <jgarzik@redhat.com>; Mohamed Khalfella <mkhalfella@purestorage.com>; Ying Hsu <yinghsu@chromium.org>; Simon Horman <horms@kernel.org>
> > Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH v2 1/1] igb: Do not bring the device up after non-fatal error
> >
> >Commit 004d25060c78 ("igb: Fix igb_down hung on surprise removal") changed igb_io_error_detected() to ignore non-fatal pcie errors in order to avoid hung task that can happen when igb_down() is called multiple times. This caused an issue when processing transient non-fatal errors.
> > igb_io_resume(), which is called after igb_io_error_detected(), assumes that device is brought down by igb_io_error_detected() if the interface is up. This resulted in panic with stacktrace below.
> >
> > [ T3256] igb 0000:09:00.0 haeth0: igb: haeth0 NIC Link is Down [  T292] pcieport 0000:00:1c.5: AER: Uncorrected (Non-Fatal) error received: 0000:09:00.0 [  T292] igb 0000:09:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [  T292] igb 0000:09:00.0:   device [8086:1537] error status/mask=00004000/00000000
> > [  T292] igb 0000:09:00.0:    [14] CmpltTO [  200.105524,009][  T292] igb 0000:09:00.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
> > [  T292] pcieport 0000:00:1c.5: AER: broadcast error_detected message [  T292] igb 0000:09:00.0: Non-correctable non-fatal error reported.
> > [  T292] pcieport 0000:00:1c.5: AER: broadcast mmio_enabled message [  T292] pcieport 0000:00:1c.5: AER: broadcast resume message [  T292] ------------[ cut here ]------------ [  T292] kernel BUG at net/core/dev.c:6539!
> > [  T292] invalid opcode: 0000 [#1] PREEMPT SMP [  T292] RIP: 0010:napi_enable+0x37/0x40 [  T292] Call Trace:
> > [  T292]  <TASK>
> > [  T292]  ? die+0x33/0x90
> > [  T292]  ? do_trap+0xdc/0x110
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? do_error_trap+0x70/0xb0
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? exc_invalid_op+0x4e/0x70
> > [  T292]  ? napi_enable+0x37/0x40
> > [  T292]  ? asm_exc_invalid_op+0x16/0x20 [  T292]  ? napi_enable+0x37/0x40 [  T292]  igb_up+0x41/0x150 [  T292]  igb_io_resume+0x25/0x70 [  T292]  report_resume+0x54/0x70 [  T292]  ? report_frozen_detected+0x20/0x20 [  T292]  pci_walk_bus+0x6c/0x90 [  T292]  ? aer_print_port_info+0xa0/0xa0 [  T292]  pcie_do_recovery+0x22f/0x380 [  T292]  aer_process_err_devices+0x110/0x160
> > [  T292]  aer_isr+0x1c1/0x1e0
> > [  T292]  ? disable_irq_nosync+0x10/0x10 [  T292]  irq_thread_fn+0x1a/0x60 [  T292]  irq_thread+0xe3/0x1a0 [  T292]  ? irq_set_affinity_notifier+0x120/0x120
> > [  T292]  ? irq_affinity_notify+0x100/0x100 [  T292]  kthread+0xe2/0x110 [  T292]  ? kthread_complete_and_exit+0x20/0x20
> > [  T292]  ret_from_fork+0x2d/0x50
> > [  T292]  ? kthread_complete_and_exit+0x20/0x20
> > [  T292]  ret_from_fork_asm+0x11/0x20
> > [  T292]  </TASK>
> >
> > To fix this issue igb_io_resume() checks if the interface is running and the device is not down this means igb_io_error_detected() did not bring the device down and there is no need to bring it up.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Yuanyuan Zhong<yzhong@purestorage.com>
> > Fixes: 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Any reproductions steps for reproduction of these issue?
> 

I know of two way to reproduce this kernel panic on a kernel that does
not have the patch above.

1- Using aer-inject:

  This works on both physical machine and vm. Here are the steps on a
  virtual machine.

  root@(none):~# lspci -t -v -s 03:00.0
  -[0000:02]---00.0-[03]----00.0  Intel Corporation 82576 Gigabit Network Connection
  root@(none):~# cat > /tmp/uncor << EOF
  > AER
  > UNCOR_STATUS COMP_ABORT
  > HEADER_LOG 0 1 2 3
  > EOF
  root@(none):~# modprobe aer_inject
  root@(none):~# /var/tmp/aer-inject --id=0000:03:00.0 /tmp/uncor

  This is the qemu command used to start the vm. You probably do not
  need all the options related to numa settings and iommu. Only the part
  related to pci setup should be enough.

  /usr/bin/qemu-system-x86_64 \
    -kernel $SRCDIR/arch/x86/boot/bzImage \
    -initrd $INITRAMFSIMG \
    -append "rdinit=/startup.sh console=ttyS0,115200n8" \
    -machine q35,accel=kvm,kernel-irqchip=split \
    -nographic \
    -chardev socket,id=gdb0,host=0.0.0.0,port=22004,telnet=on,server=on,wait=off \
    -gdb chardev:gdb0 \
    $GDB_WAIT \
    -serial telnet:127.0.0.1:22003,server=on,wait=off \
    -device pxb-pcie,id=pcie.1,bus_nr=2,bus=pcie.0 \
    -device ioh3420,id=pcie_port1,bus=pcie.1,chassis=1 \
    -netdev user,id=net0,hostfwd=tcp:127.0.0.1:22002-:22 \
    -device igb,netdev=net0,id=net0,mac=52:54:00:b8:9c:58,bus=pcie_port1 \
    -cpu host \
    -smp 4 \
    -m 8G \
    -object memory-backend-ram,size=7G,id=m0 \
    -object memory-backend-ram,size=1G,id=m1 \
    -numa node,nodeid=0,memdev=m0,cpus=0-1 \
    -numa node,nodeid=1,memdev=m1,cpus=2-3 \
    -chardev socket,id=charmonitor,host=0.0.0.0,port=10001,telnet=on,server=on,wait=off \
    -mon chardev=charmonitor,id=monitor \
    -boot order=c \
    -device intel-iommu,intremap=on


2- Using pcie_aer_inject_error

  Injecting pcie aer error from qemu monitor should be enough to trigger
  the kernel panic. This is using the qemu command above.

  (qemu) pcie_aer_inject_error pcie_port1 0x00004000

