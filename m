Return-Path: <netdev+bounces-64526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ADE835998
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A561F21536
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F81370;
	Mon, 22 Jan 2024 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxIWkRIy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D268136A
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892781; cv=none; b=FzAnVrrn8izdMXfO2Y1YdyrVLSrjhCPXgQIBUKoQKSo3RKPHAT+xxI2Hy0X87Hc75pfE/mV1vxRUiHkKScTRdEgsB/jVBW8H7XNOnuniL/gS/itBsZ7LiIfnwrDvBOQ+PDmPsgM7jNf8L1BewVWIBRLN+7tvXVlPQpLAUsCelwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892781; c=relaxed/simple;
	bh=wHlFdiBWdakIE4lXUZbrOEZCpuiQdgpFkz7vU4v35PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbYhxaKubVWpJhmd4Pnse1FlVGjups5OFbqnSekODt5gTMWjTPDn74oHQK+dsksWyPlakxGAivHezrNDXtsptpGy7mgp5YzDxh42QuDSyC/ogmGWCKyXKgwCkqTuz67AnRT/YYZ4X/3isNxeTSh89GWfSeSeBzlhxD6z7ITNrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxIWkRIy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705892779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wxP3c1bpliL/kY+OLuDtLpxpmcZRFPAWsM57nyqz+0=;
	b=hxIWkRIyIMImEupU4el04tp2tUXlRfbmFBN9mngYn6SZgQeBSqJvqm/1KeKhuvtMTvzvSU
	T1xwqUNiM1w8agz7tJYy1Onp9FSicxvphReDMAEW0vvJ9NCoUFD0hn3N//zKlJ25WDkP3c
	Lu4RfXHg2cwhUxg/aU+EsI6o+PUFWPI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-EwoLF9qzNB2xmFBhidlGoQ-1; Sun, 21 Jan 2024 22:06:17 -0500
X-MC-Unique: EwoLF9qzNB2xmFBhidlGoQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-598e30e7e8cso2623913eaf.3
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 19:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705892777; x=1706497577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wxP3c1bpliL/kY+OLuDtLpxpmcZRFPAWsM57nyqz+0=;
        b=NXu0uNIQontZphDrmzQUz0wgImuVJ17faTn8DbqvyMWwxBibgANNNpQCukuLBT1V2F
         ht7y57yMeTGXvL4AYP/UVIT/ToWb8GhbD+UZmk6hvVlgHtZrI1t7PVB+0EwORjbYP6mJ
         IWtfl/SS64sxlive0+m9j6sEG0UXSaUwr3i4TtEqmhIxK4vZ1L3Ce9IgPHah5HqijuAb
         WNALrO5ps8g0gL4pX06uKMLJkxQz7Rf71OEAxHfzHlCZkWqJ4+pwnkzk4aABDivLiurk
         D4Wv9TD2UyXclBcmvSxCk5juQHbTh3Od6mSv18oWVB2DkEGIaiMWcM1DqLhFxAG8fOID
         xm0Q==
X-Gm-Message-State: AOJu0YxMIwbC2EIzKHDkgcGOehJZ4AIAVIH9T7aIohJzJ644IhZR2sO3
	KcyfKaHOjLhpKQTrApJNLRVbKvhBlyvp/a+cyd3+B0hF5puip8h9rmRvqHw+QCBIkoDZ/AeOzoI
	Fv2yJc65tkPY5AyVSFXYAZocBJIi4pHcvS3mAGtLMDqewAK/7JeR+vUfTamGAaBJIhiE6M8Zx1l
	m4OFk4RFPQeSES/BXZuZZZCGNlaybw
X-Received: by 2002:a05:6358:3a1c:b0:175:c7bb:5bbb with SMTP id g28-20020a0563583a1c00b00175c7bb5bbbmr983219rwe.42.1705892776650;
        Sun, 21 Jan 2024 19:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB6Wc4CkNgE9EWHnnFCZkNePtnUoFM/x56G6dp9bHIY1V1FT7JTlgwgNNu3osGi7akvTAxu6KZ4nL4XlnAJFU=
X-Received: by 2002:a05:6358:3a1c:b0:175:c7bb:5bbb with SMTP id
 g28-20020a0563583a1c00b00175c7bb5bbbmr983205rwe.42.1705892776276; Sun, 21 Jan
 2024 19:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <CACGkMEtVQEZUR2iD_Xs2zhPMspqJvYbMTfrD=gQv660_DVRJsg@mail.gmail.com> <6cf2699a-483d-4124-9782-b6a771a41e70@linux.dev>
In-Reply-To: <6cf2699a-483d-4124-9782-b6a771a41e70@linux.dev>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 11:06:04 +0800
Message-ID: <CACGkMEs49oOz1+GuFvZuu7vi8fnda4zujWjvU6nXQ58-ut=mgw@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:22=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2024/1/15 10:20, Jason Wang =E5=86=99=E9=81=93:
>
> On Mon, Jan 15, 2024 at 9:35=E2=80=AFAM Zhu Yanjun <yanjun.zhu@intel.com>=
 wrote:
>
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
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
>
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
>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/net/virtio_net.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 51b1868d2f22..28b7dd917a43 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2468,7 +2468,7 @@ static bool virtnet_send_command(struct virtnet_inf=
o *vi, u8 class, u8 cmd,
>  {
>         struct scatterlist *sgs[4], hdr, stat;
>         unsigned out_num =3D 0, tmp;
> -       int ret;
> +       int ret, timeout =3D 200;
>
> Any reason we choose this value or how can we know it works for all
> types of devices?
>
> As I mentioned in the commit log, the similar problem also occurs in Inte=
l NIC driver and Mellanox NIC driver.
>
> This commit is borrowed from the solution of Intel NIC driver. So the val=
ue is also from Intel NIC driver solution.

Right, so basically I meant we need a solution that works for all vendors.

>
> A more easy way is to use cond_resched() but it may have side effects
> as well[1]. But it seems less intrusive anyhow than the proposal here?
>
> Thanks a lot for your suggestions. I have made tests with the commits in =
the link https://www.mail-archive.com/virtualization@lists.linux-foundation=
.org/msg60297.html.
>
> Because virtio_net driver spins waiting for the response of hardware, vir=
tio_net driver can not be unloaded and kernel hang still occurs when runnin=
g "ip link" or unloading virtio_net module.

Well, yes. It aims to solve the lockups as described in this commit
log. It doesn't solve the issue of infinite waiting etc.

Thanks

>
> Zhu Yanjun
>
> Thanks
>
> [1] https://www.mail-archive.com/virtualization@lists.linux-foundation.or=
g/msg60297.html
>
>         /* Caller should know better */
>         BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> @@ -2502,8 +2502,14 @@ static bool virtnet_send_command(struct virtnet_in=
fo *vi, u8 class, u8 cmd,
>          * into the hypervisor, so the request should be handled immediat=
ely.
>          */
>         while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -              !virtqueue_is_broken(vi->cvq))
> +              !virtqueue_is_broken(vi->cvq)) {
> +               if (timeout)
> +                       timeout--;
> +               else
> +                       return false; /* long time no response */
> +
>                 cpu_relax();
> +       }
>
>         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>  }
> --
> 2.42.0
>


