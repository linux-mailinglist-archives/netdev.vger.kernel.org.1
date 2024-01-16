Return-Path: <netdev+bounces-63694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7837A82EEA6
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 13:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B1AB22D63
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2D01B95A;
	Tue, 16 Jan 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwvZ54Ud"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF11B955
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705406694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B8ajVQymZm3XFA/oKBTg5clv0Gz5FCP74257oiUbfmI=;
	b=CwvZ54Ud329Bl2j/n4X/btn8w2WO7/1LY+GHUiyRuOLOsMfETSbQ9vyFXO0UWT5CT31bHB
	dIUV4gNTEXLZ8K0FABQ36zpQqsV0aJE2QpsEZZTYdIa+cw3CyRWvLdJX6qHCDKcF8O54BB
	7nSQvang6vdAUlFHP/qetfqgcysR38Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-zcOv36PgM3-XqU_7kN39Dg-1; Tue, 16 Jan 2024 07:04:52 -0500
X-MC-Unique: zcOv36PgM3-XqU_7kN39Dg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3378f48dbbfso657211f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 04:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705406692; x=1706011492;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8ajVQymZm3XFA/oKBTg5clv0Gz5FCP74257oiUbfmI=;
        b=X1EwxsJ1pA9biLFQKH2MN4jvxglKa+CgvwVvvxIpkc/J3+SYYebSbDYKZ5L5nb5EL7
         aXqCShiOOSHZ14HB9GTZdaWpm/ZwpGlyUpRibuVOm9y8DWb6nArK/rm6XMftbQUKPFGE
         cLIs3/qnDfDwP87A/HQBvhXVlnOr8G4SWV74ipFSEMotcIt9xNZflGfVpIjP2ijEhO6o
         183jD5NvBCsmjdtN0IbiJQqOxo3sjmZC3g3IM1oohkYpUhMSzzz8/AFP3soryRu7eXPi
         SVPj8K/3lfF180Wv7CLRFkBDbDD88n9MwV67EgvmpM3ujkfGA4QXdc8HxITxwVgm5aAY
         bm9Q==
X-Gm-Message-State: AOJu0YwLtTha+4fXmFLonN7GDEV8D7inONLQA0nsV9wrrxTrRzKSV131
	WaoYSCr9P0UZfB+xyYwM18jgmz7Dn682OtXoI20lsPPPc+XNTdIBP4tNlcpJitr3y+dNSs8WZLu
	ocN2gwWVc07GxdwddtYcZVpyN
X-Received: by 2002:a5d:6411:0:b0:336:7290:3cb6 with SMTP id z17-20020a5d6411000000b0033672903cb6mr7782744wru.6.1705406691769;
        Tue, 16 Jan 2024 04:04:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+3Bavcxll5cZESoPFN2DmSSjwKbMYZiCXVLkwH70hOkown2eY1eJbbdiYonAARK+aZPw1VQ==
X-Received: by 2002:a5d:6411:0:b0:336:7290:3cb6 with SMTP id z17-20020a5d6411000000b0033672903cb6mr7782728wru.6.1705406691394;
        Tue, 16 Jan 2024 04:04:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-126.dyn.eolo.it. [146.241.241.126])
        by smtp.gmail.com with ESMTPSA id d13-20020a056000114d00b003379d5d2f1csm9199874wrx.28.2024.01.16.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 04:04:50 -0800 (PST)
Message-ID: <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
From: Paolo Abeni <pabeni@redhat.com>
To: Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Date: Tue, 16 Jan 2024 13:04:49 +0100
In-Reply-To: <20240115012918.3081203-1-yanjun.zhu@intel.com>
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-15 at 09:29 +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Some devices emulate the virtio_net hardwares. When virtio_net
> driver sends commands to the emulated hardware, normally the
> hardware needs time to response. Sometimes the time is very
> long. Thus, the following will appear. Then the whole system
> will hang.
> The similar problems also occur in Intel NICs and Mellanox NICs.
> As such, the similar solution is borrowed from them. A timeout
> value is added and the timeout value as large as possible is set
> to ensure that the driver gets the maximum possible response from
> the hardware.
>=20
> "
> [  213.795860] watchdog: BUG: soft lockup - CPU#108 stuck for 26s! [(udev=
-worker):3157]
> [  213.796114] Modules linked in: virtio_net(+) net_failover failover qrt=
r rfkill sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency int=
el_uncore_frequency_common intel_ifs i10nm_edac nfit libnvdimm x86_pkg_temp=
_thermal intel_powerclamp coretemp iTCO_wdt rapl intel_pmc_bxt dax_hmem iTC=
O_vendor_support vfat cxl_acpi intel_cstate pmt_telemetry pmt_class intel_s=
dsi joydev intel_uncore cxl_core fat pcspkr mei_me isst_if_mbox_pci isst_if=
_mmio idxd i2c_i801 isst_if_common mei intel_vsec idxd_bus i2c_smbus i2c_is=
mt ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_p=
ower_meter pfr_telemetry pfr_update fuse loop zram xfs crct10dif_pclmul crc=
32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel =
sha512_ssse3 bnxt_en sha256_ssse3 sha1_ssse3 nvme ast nvme_core i2c_algo_bi=
t wmi pinctrl_emmitsburg scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
> [  213.796194] irq event stamp: 67740
> [  213.796195] hardirqs last  enabled at (67739): [<ffffffff8c2015ca>] as=
m_sysvec_apic_timer_interrupt+0x1a/0x20
> [  213.796203] hardirqs last disabled at (67740): [<ffffffff8c14108e>] sy=
svec_apic_timer_interrupt+0xe/0x90
> [  213.796208] softirqs last  enabled at (67686): [<ffffffff8b12115e>] __=
irq_exit_rcu+0xbe/0xe0
> [  213.796214] softirqs last disabled at (67681): [<ffffffff8b12115e>] __=
irq_exit_rcu+0xbe/0xe0
> [  213.796217] CPU: 108 PID: 3157 Comm: (udev-worker) Kdump: loaded Not t=
ainted 6.7.0+ #9
> [  213.796220] Hardware name: Intel Corporation M50FCP2SBSTD/M50FCP2SBSTD=
, BIOS SE5C741.86B.01.01.0001.2211140926 11/14/2022
> [  213.796221] RIP: 0010:virtqueue_get_buf_ctx_split+0x8d/0x110
> [  213.796228] Code: 89 df e8 26 fe ff ff 0f b7 43 50 83 c0 01 66 89 43 5=
0 f6 43 78 01 75 12 80 7b 42 00 48 8b 4b 68 8b 53 58 74 0f 66 87 44 51 04 <=
48> 89 e8 5b 5d c3 cc cc cc cc 66 89 44 51 04 0f ae f0 48 89 e8 5b
> [  213.796230] RSP: 0018:ff4bbb362306f9b0 EFLAGS: 00000246
> [  213.796233] RAX: 0000000000000000 RBX: ff2f15095896f000 RCX: 000000000=
0000001
> [  213.796235] RDX: 0000000000000000 RSI: ff4bbb362306f9cc RDI: ff2f15095=
896f000
> [  213.796236] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
> [  213.796237] R10: 0000000000000003 R11: ff2f15095893cc40 R12: 000000000=
0000002
> [  213.796239] R13: 0000000000000004 R14: 0000000000000000 R15: ff2f15095=
34f3000
> [  213.796240] FS:  00007f775847d0c0(0000) GS:ff2f1528bac00000(0000) knlG=
S:0000000000000000
> [  213.796242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  213.796243] CR2: 0000557f987b6e70 CR3: 0000002098602006 CR4: 000000000=
0f71ef0
> [  213.796245] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  213.796246] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 000000000=
0000400
> [  213.796247] PKRU: 55555554
> [  213.796249] Call Trace:
> [  213.796250]  <IRQ>
> [  213.796252]  ? watchdog_timer_fn+0x1c0/0x220
> [  213.796258]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  213.796261]  ? __hrtimer_run_queues+0x1af/0x380
> [  213.796269]  ? hrtimer_interrupt+0xf8/0x230
> [  213.796274]  ? __sysvec_apic_timer_interrupt+0x64/0x1a0
> [  213.796279]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [  213.796282]  </IRQ>
> [  213.796284]  <TASK>
> [  213.796285]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  213.796293]  ? virtqueue_get_buf_ctx_split+0x8d/0x110
> [  213.796297]  virtnet_send_command+0x18a/0x1f0 [virtio_net]
> [  213.796310]  _virtnet_set_queues+0xc6/0x120 [virtio_net]
> [  213.796319]  virtnet_probe+0xa06/0xd50 [virtio_net]
> [  213.796328]  virtio_dev_probe+0x195/0x230
> [  213.796333]  really_probe+0x19f/0x400
> [  213.796338]  ? __pfx___driver_attach+0x10/0x10
> [  213.796340]  __driver_probe_device+0x78/0x160
> [  213.796343]  driver_probe_device+0x1f/0x90
> [  213.796346]  __driver_attach+0xd6/0x1d0
> [  213.796349]  bus_for_each_dev+0x8c/0xe0
> [  213.796355]  bus_add_driver+0x119/0x220
> [  213.796359]  driver_register+0x59/0x100
> [  213.796362]  ? __pfx_virtio_net_driver_init+0x10/0x10 [virtio_net]
> [  213.796369]  virtio_net_driver_init+0x8e/0xff0 [virtio_net]
> [  213.796375]  do_one_initcall+0x6f/0x380
> [  213.796384]  do_init_module+0x60/0x240
> [  213.796388]  init_module_from_file+0x86/0xc0
> [  213.796396]  idempotent_init_module+0x129/0x2c0
> [  213.796406]  __x64_sys_finit_module+0x5e/0xb0
> [  213.796409]  do_syscall_64+0x60/0xe0
> [  213.796415]  ? do_syscall_64+0x6f/0xe0
> [  213.796418]  ? lockdep_hardirqs_on_prepare+0xe4/0x1a0
> [  213.796424]  ? do_syscall_64+0x6f/0xe0
> [  213.796427]  ? do_syscall_64+0x6f/0xe0
> [  213.796431]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [  213.796435] RIP: 0033:0x7f7758f279cd
> [  213.796465] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 33 e4 0c 00 f7 d8 64 89 01 48
> [  213.796467] RSP: 002b:00007ffe2cad8738 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [  213.796469] RAX: ffffffffffffffda RBX: 0000557f987a8180 RCX: 00007f775=
8f279cd
> [  213.796471] RDX: 0000000000000000 RSI: 00007f77593e5453 RDI: 000000000=
000000f
> [  213.796472] RBP: 00007f77593e5453 R08: 0000000000000000 R09: 00007ffe2=
cad8860
> [  213.796473] R10: 000000000000000f R11: 0000000000000246 R12: 000000000=
0020000
> [  213.796475] R13: 0000557f9879f8e0 R14: 0000000000000000 R15: 0000557f9=
8783aa0
> [  213.796482]  </TASK>
> "
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/net/virtio_net.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 51b1868d2f22..28b7dd917a43 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2468,7 +2468,7 @@ static bool virtnet_send_command(struct virtnet_inf=
o *vi, u8 class, u8 cmd,
>  {
>  	struct scatterlist *sgs[4], hdr, stat;
>  	unsigned out_num =3D 0, tmp;
> -	int ret;
> +	int ret, timeout =3D 200;
> =20
>  	/* Caller should know better */
>  	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> @@ -2502,8 +2502,14 @@ static bool virtnet_send_command(struct virtnet_in=
fo *vi, u8 class, u8 cmd,
>  	 * into the hypervisor, so the request should be handled immediately.
>  	 */
>  	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> +	       !virtqueue_is_broken(vi->cvq)) {
> +		if (timeout)
> +			timeout--;

This is not really a timeout, just a loop counter. 200 iterations could
be a very short time on reasonable H/W. I guess this avoid the soft
lockup, but possibly (likely?) breaks the functionality when we need to
loop for some non negligible time.

I fear we need a more complex solution, as mentioned by Micheal in the
thread you quoted.

Cheers,

Paolo


