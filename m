Return-Path: <netdev+bounces-97146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C70E8C961C
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 21:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BA728115E
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A013ADA;
	Sun, 19 May 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwDrwz6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29291094E
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147982; cv=none; b=FVYTagU6lZrvedqMfNEFvsaffy76YLTWVS7u9FVigFbqKHO3m68orFYS+MRWKXfmmbvlNegqjgyb1wspkyJKVJP2rD2f/F8NJChO86jLoqIkH9NwiVMtJS9nYvJOLBZ45M3ZY9e6GrT8DLOOLncEF/DcefFVeNLw3jQdkVUvE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147982; c=relaxed/simple;
	bh=mnrstNLOmNMDfH/FwiDlr1DWaxctx5Rdurc8++M/bnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2abhBi4HBKcoVwSh4jKIXrboe99wGLikLMtALCANZ+icJZmabDBooZf8/SVpzlnQYrj+s0lR4iEG9sT8AbBgFaM9GaryKN7KER+XQzbu1CVMz56Fxybhs58KKhnEPiseb9zqRTP5qoh2vb3Fjm5vVvbGaE91Nyy7AOxz4JMIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwDrwz6Z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a609dd3fso861541066b.0
        for <netdev@vger.kernel.org>; Sun, 19 May 2024 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716147978; x=1716752778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Spr00F9Df8AOIsgKyo3d8VLWMMA9Va59fG4IPPZj99s=;
        b=bwDrwz6Zjr34n8LOP+1MwyJ8ir03GQLJTf2XJr698blQ8JmwQ3ocfE9jjy/JPZhHyz
         oLkWxS0kQJ9dwo5MYGBvwiQAUpIN4/U3feQCQMNbFtqgd2Ijoet2R4EOO6QxV8Yo/LuP
         LK6QJDWc26jjk1IwuZc+NUxtBb86Xy1pcy1NOuHb8ZrtLn3GKb1MaKUKdjW8NNI0gP0+
         U6IufCxnBlqtcUrTKVq+xaEFmaPVhUZcJGsq5HbFgHTa9lfCiSJEsLZoYKqFikQP+xYU
         ZXxd9BgrMgO/uryMz2c6syxfij799yHJeQn5GCclpqOm/nI8cxDw//e4odka5t9DvMu3
         Zm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716147978; x=1716752778;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spr00F9Df8AOIsgKyo3d8VLWMMA9Va59fG4IPPZj99s=;
        b=fAl8Fs9ePMsQzESGBMw2Rmte1c9+JpdPqzIk/VrZ73grNBnHi8zYipuIPybXflJbPv
         +y2iw8HROIxDGTJO1cxY6AOwG/dz1gf5kM4gusQkVt9VWjx7AVqaRuLFyJ0geKHm77qN
         RRc312M2H00/JAneTGHdp2VuSJh4p3JkpEGdSdr+g7wK9OvAyp4qSy7wesb9ncIMG6Qu
         ngY6hzEf9pqgWKIMFrjK+a6QKSQ+nKfvvlMub24zknvRBBul7ezIaGk/t7l8WuX1tH2U
         DAJIuP19ABwdkOoIhU9prG3O8N6op+9ghW5kORWAgVEo19+tkWzn9+mFYGeMkcr4E4Ap
         PqIA==
X-Forwarded-Encrypted: i=1; AJvYcCXRr2lWRH6ChvOJzOkKM4yZB/8NzPwNALSHbsob3PVH8Bl+L6E60P7guZqH4bu2m/A5macVznYy/1ebTA/9z8P9rKiULcBq
X-Gm-Message-State: AOJu0YzWlp5a9mSmkQ9rxhkEcITnlmVgVu5FHmG9Eak/s1BEHVyH7f82
	aM5acYjY+c/vcKJgDy5M8hBydnSnvxXcHOfhy96dcvkVxk8Nytvy
X-Google-Smtp-Source: AGHT+IFcZHzxlvuHGXZrs8852z+XpeBdFf4ghUBX8d0J4aOyLFjspS/n7V51hyp+c3DUo0mddT1wSw==
X-Received: by 2002:a17:906:480d:b0:a5c:dad0:c464 with SMTP id a640c23a62f3a-a5d58d52f7cmr397636166b.6.1716147977454;
        Sun, 19 May 2024 12:46:17 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9044:8700:f4f7:85c6:b597:4436? (dynamic-2a02-3100-9044-8700-f4f7-85c6-b597-4436.310.pool.telefonica.de. [2a02:3100:9044:8700:f4f7:85c6:b597:4436])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a17b0125bsm1395949166b.143.2024.05.19.12.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 12:46:16 -0700 (PDT)
Message-ID: <47ec1f1f-1258-4553-85f7-e9d2fd1d18ac@gmail.com>
Date: Sun, 19 May 2024 21:46:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: Crash with TX segmentation offload on RTL8125
To: Ken Milmore <ken.milmore@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>
References: <b18ea747-252a-44ad-b746-033be1784114@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b18ea747-252a-44ad-b746-033be1784114@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 17.05.2024 22:51, Ken Milmore wrote:
> I have found an obscure but serious bug involving fragmented TX skbuffs=
 on the RTL8125.
> The fix is trivial and is given at the end of this post.
>=20
>=20
> For some months I have been running an RTL8125B with TX segmentation of=
fload enabled, as follows:
>=20
> # ethtool -K eth0 tx-scatter-gather on tx-tcp-segmentation on tx-tcp6-s=
egmentation on
>=20
> This considerably reduces the soft IRQ CPU usage of the driver under he=
avy load.
> I found it to be stable under prolonged use, until I encountered a prob=
lem connecting to a Windows machine using xfreerdp.
>=20
> After a few minutes of usage with xfreerdp, the network connection fail=
s, often also locking up the machine completely.
> The following warning is seen:
>=20
>=20
> [  188.932673] ------------[ cut here ]------------
> [  188.932690] WARNING: CPU: 15 PID: 0 at drivers/iommu/dma-iommu.c:104=
1 iommu_dma_unmap_page+0x79/0x90
> [  188.932708] Modules linked in: nft_chain_nat nf_nat bridge stp llc j=
oydev hid_generic ip6t_REJECT nf_reject_ipv6 qrtr ipt_REJECT nf_reject_ip=
v4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sunr=
pc nft_compat nf_tables libcrc32c binfmt_misc nfnetlink nls_ascii nls_cp4=
37 vfat fat intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_p=
owerclamp coretemp amdgpu kvm_intel kvm snd_sof_pci_intel_tgl snd_sof_int=
el_hda_common irqbypass soundwire_intel soundwire_generic_allocation soun=
dwire_cadence iwlmvm snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp gha=
sh_clmulni_intel snd_sof sha512_ssse3 snd_hda_codec_realtek snd_sof_utils=
 sha512_generic mac80211 snd_soc_hdac_hda snd_hda_ext_core sha256_ssse3 s=
nd_soc_acpi_intel_match snd_hda_codec_generic sha1_ssse3 snd_soc_acpi led=
trig_audio snd_soc_core snd_compress gpu_sched snd_hda_codec_hdmi soundwi=
re_bus drm_buddy libarc4 drm_display_helper snd_hda_intel snd_intel_dspcf=
g snd_intel_sdw_acpi aesni_intel cec iwlwifi
> [  188.933060]  snd_hda_codec rc_core drm_ttm_helper crypto_simd ttm cr=
yptd snd_hda_core rapl snd_hwdep drm_kms_helper iTCO_wdt intel_cstate pmt=
_telemetry mei_hdcp intel_pmc_bxt pmt_class evdev snd_pcm i2c_algo_bit mx=
m_wmi cfg80211 intel_uncore wmi_bmof pcspkr snd_timer ee1004 iTCO_vendor_=
support mei_me snd watchdog mei soundcore intel_vsec rfkill serial_multi_=
instantiate intel_pmc_core acpi_tad acpi_pad usbhid button hid nct6683 pa=
rport_pc ppdev drm lp parport fuse loop efi_pstore configfs efivarfs ip_t=
ables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic dm_mod ahci=
 nvme libahci xhci_pci nvme_core libata xhci_hcd t10_pi r8169 realtek crc=
64_rocksoft crc64 crc_t10dif mdio_devres usbcore scsi_mod libphy crc32_pc=
lmul crc32c_intel i2c_i801 crct10dif_generic crct10dif_pclmul scsi_common=
 i2c_smbus usb_common crct10dif_common fan video wmi pinctrl_alderlake
> [  188.933435] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 6.1.0-21-amd=
64 #1  Debian 6.1.90-1
> [  188.933446] Hardware name: Micro-Star International Co., Ltd. MS-7D4=
3/PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
> [  188.933451] RIP: 0010:iommu_dma_unmap_page+0x79/0x90
> [  188.933461] Code: 2b 48 3b 28 72 26 48 3b 68 08 73 20 4d 89 f8 44 89=
 f1 4c 89 ea 48 89 ee 48 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 17 a5 a6 =
ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 66 0f 1f 44 00
> [  188.933467] RSP: 0000:ffffa579c04c0e30 EFLAGS: 00010246
> [  188.933476] RAX: 0000000000000000 RBX: ffff946ac1e580d0 RCX: 0000000=
000000012
> [  188.933482] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000003
> [  188.933489] RBP: ffff946ae189d9d8 R08: 0000000000000002 R09: fffffff=
ffff80000
> [  188.933495] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000000
> [  188.933501] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000=
000000000
> [  188.933507] FS:  0000000000000000(0000) GS:ffff94721f5c0000(0000) kn=
lGS:0000000000000000
> [  188.933515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  188.933522] CR2: 00007ff061775000 CR3: 0000000772010000 CR4: 0000000=
000750ee0
> [  188.933529] PKRU: 55555554
> [  188.933535] Call Trace:
> [  188.933543]  <IRQ>
> [  188.933552]  ? __warn+0x7d/0xc0
> [  188.933564]  ? iommu_dma_unmap_page+0x79/0x90
> [  188.933574]  ? report_bug+0xe2/0x150
> [  188.933589]  ? handle_bug+0x41/0x70
> [  188.933598]  ? exc_invalid_op+0x13/0x60
> [  188.933606]  ? asm_exc_invalid_op+0x16/0x20
> [  188.933617]  ? iommu_dma_unmap_page+0x79/0x90
> [  188.933625]  rtl8169_unmap_tx_skb+0x3b/0x70 [r8169]
> [  188.933647]  rtl8169_poll+0x63/0x4e0 [r8169]
> [  188.933667]  __napi_poll+0x28/0x160
> [  188.933678]  net_rx_action+0x29e/0x350
> [  188.933688]  __do_softirq+0xc3/0x2ab
> [  188.933697]  ? handle_edge_irq+0x87/0x220
> [  188.933708]  __irq_exit_rcu+0xaa/0xe0
> [  188.933719]  common_interrupt+0x82/0xa0
> [  188.933728]  </IRQ>
> [  188.933731]  <TASK>
> [  188.933734]  asm_common_interrupt+0x22/0x40
> [  188.933742] RIP: 0010:cpuidle_enter_state+0xde/0x420
> [  188.933751] Code: 00 00 31 ff e8 b3 24 97 ff 45 84 ff 74 16 9c 58 0f=
 1f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 88 cf 9d ff fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [  188.933756] RSP: 0000:ffffa579c0203e90 EFLAGS: 00000246
> [  188.933764] RAX: ffff94721f5f1a40 RBX: ffffc579bfbf2f00 RCX: 0000000=
000000000
> [  188.933769] RDX: 000000000000000f RSI: fffffffdb2461367 RDI: 0000000=
000000000
> [  188.933773] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000=
03c9b26c9
> [  188.933777] R10: 0000000000000018 R11: 000000000000084b R12: fffffff=
fa3f9ef20
> [  188.933781] R13: 0000002bfd4336f6 R14: 0000000000000004 R15: 0000000=
000000000
> [  188.933791]  cpuidle_enter+0x29/0x40
> [  188.933797]  do_idle+0x202/0x2a0
> [  188.933808]  cpu_startup_entry+0x26/0x30
> [  188.933817]  start_secondary+0x12a/0x150
> [  188.933828]  secondary_startup_64_no_verify+0xe5/0xeb
> [  188.933843]  </TASK>
> [  188.933848] ---[ end trace 0000000000000000 ]---
>=20
>=20
> After some experimentation, I found the cause:=20
>=20
> - rtl8169_start_xmit() gets the number of fragments in the skb (nr_frag=
s), then calls rtl8169_tso_csum_v2().
>=20
> - For some devices, rtl8169_tso_csum_v2() calls __skb_put_padto() to pa=
d the buffer up to a minimum of 60 bytes to work around hardware bugs.
>=20
> - If the skb is fragmented, it seems that __skb_put_padto() may coalesc=
e it so that nr_frags is reduced.
>=20
> - rtl8169_start_xmit() still has the old value of nr_frags, which may c=
ause some TX ring buffer entries to be improperly set up.
>=20
> It seems that xfreerdp generates lots of small packet fragments (~46 by=
tes) so it is a good candidate for triggering this bug.
>=20
> To verify this, I tried the following code which produced the dmesg out=
put below:
>=20
>=20
> diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c =
linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> index 2ce4bff..d663b2a 100644
> --- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
> +++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4284,6 +4284,9 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_b=
uff *skb,
>  	else if (!rtl8169_tso_csum_v2(tp, skb, opts))
>  		goto err_dma_0;
> =20
> +	WARN(frags !=3D skb_shinfo(skb)->nr_frags,
> +		"rtl8169_start_xmit: frags changed: %u -> %u",
> +		frags, skb_shinfo(skb)->nr_frags);
>  	if (unlikely(rtl8169_tx_map(tp, opts, skb_headlen(skb), skb->data,
>  				    entry, false)))
>  		goto err_dma_0;
>=20
> [14182.036226] ------------[ cut here ]------------
> [14182.036245] rtl8169_start_xmit: frags changed: 1 -> 0
> [14182.036278] WARNING: CPU: 15 PID: 0 at /home/ken/work/r8169/linux-so=
urce-6.1/drivers/net/ethernet/realtek/r8169_main.c:4287 rtl8169_start_xmi=
t+0x54d/0x7e0 [r8169]
> [14182.036313] Modules linked in: r8169(OE) realtek mdio_devres libphy =
nft_chain_nat nf_nat bridge stp llc qrtr ip6t_REJECT nf_reject_ipv6 ipt_R=
EJECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 sunrpc nft_compat nf_tables libcrc32c binfmt_misc nfnetlink=
 joydev hid_generic nls_ascii nls_cp437 vfat fat intel_rapl_msr intel_rap=
l_common x86_pkg_temp_thermal intel_powerclamp coretemp amdgpu kvm_intel =
kvm snd_sof_pci_intel_tgl irqbypass snd_sof_intel_hda_common snd_hda_code=
c_realtek soundwire_intel snd_hda_codec_generic soundwire_generic_allocat=
ion ghash_clmulni_intel ledtrig_audio soundwire_cadence iwlmvm snd_sof_in=
tel_hda sha512_ssse3 snd_sof_pci sha512_generic snd_sof_xtensa_dsp sha256=
_ssse3 snd_sof sha1_ssse3 snd_sof_utils snd_soc_hdac_hda mac80211 snd_hda=
_ext_core snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_compress=
 snd_hda_codec_hdmi soundwire_bus aesni_intel libarc4 gpu_sched snd_hda_i=
ntel drm_buddy snd_intel_dspcfg crypto_simd
> [14182.036723]  snd_intel_sdw_acpi drm_display_helper cryptd iwlwifi sn=
d_hda_codec cec rapl rc_core drm_ttm_helper snd_hda_core mei_hdcp iTCO_wd=
t ttm pmt_telemetry snd_hwdep intel_cstate intel_pmc_bxt pmt_class evdev =
cfg80211 intel_uncore snd_pcm drm_kms_helper wmi_bmof pcspkr mxm_wmi ee10=
04 snd_timer iTCO_vendor_support mei_me watchdog i2c_algo_bit snd mei sou=
ndcore rfkill intel_vsec serial_multi_instantiate intel_pmc_core acpi_tad=
 acpi_pad button usbhid hid nct6683 parport_pc ppdev drm lp parport fuse =
loop efi_pstore configfs efivarfs ip_tables x_tables autofs4 ext4 crc16 m=
bcache jbd2 crc32c_generic dm_mod ahci xhci_pci nvme libahci xhci_hcd nvm=
e_core libata t10_pi usbcore scsi_mod crc32_pclmul crc64_rocksoft crc32c_=
intel crc64 i2c_i801 crc_t10dif crct10dif_generic i2c_smbus crct10dif_pcl=
mul usb_common scsi_common crct10dif_common fan video wmi pinctrl_alderla=
ke [last unloaded: r8169(OE)]
> [14182.037307] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W  OE =
     6.1.0-21-amd64 #1  Debian 6.1.90-1
> [14182.037318] Hardware name: Micro-Star International Co., Ltd. MS-7D4=
3/PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
> [14182.037323] RIP: 0010:rtl8169_start_xmit+0x54d/0x7e0 [r8169]
> [14182.037347] Code: 48 05 90 00 00 00 f0 80 08 01 b8 10 00 00 00 48 83=
 85 68 01 00 00 01 e9 0a fd ff ff 89 fe 48 c7 c7 e0 67 32 c0 e8 53 56 d8 =
c5 <0f> 0b e9 85 fb ff ff 4c 8b bb c8 00 00 00 8b 83 c0 00 00 00 8b 54
> [14182.037354] RSP: 0018:ffffa68fc04c0b90 EFLAGS: 00010286
> [14182.037364] RAX: 0000000000000000 RBX: ffff91b0272a82e8 RCX: 0000000=
00000083f
> [14182.037370] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 0000000=
00000083f
> [14182.037376] RBP: ffff91aec4368000 R08: 0000000000000000 R09: ffffa68=
fc04c0a08
> [14182.037381] R10: 0000000000000003 R11: ffff91b63f77dc40 R12: 0000000=
000000001
> [14182.037385] R13: ffff91aec4368980 R14: 00000000000014a5 R15: 0000000=
000000004
> [14182.037390] FS:  0000000000000000(0000) GS:ffff91b61f5c0000(0000) kn=
lGS:0000000000000000
> [14182.037398] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14182.037404] CR2: 00007ff280669820 CR3: 000000048b410000 CR4: 0000000=
000750ee0
> [14182.037411] PKRU: 55555554
> [14182.037415] Call Trace:
> [14182.037424]  <IRQ>
> [14182.037430]  ? __warn+0x7d/0xc0
> [14182.037443]  ? rtl8169_start_xmit+0x54d/0x7e0 [r8169]
> [14182.037466]  ? report_bug+0xe2/0x150
> [14182.037480]  ? handle_bug+0x41/0x70
> [14182.037490]  ? exc_invalid_op+0x13/0x60
> [14182.037498]  ? asm_exc_invalid_op+0x16/0x20
> [14182.037508]  ? rtl8169_start_xmit+0x54d/0x7e0 [r8169]
> [14182.037527]  ? csum_block_add_ext+0x20/0x20
> [14182.037537]  ? reqsk_fastopen_remove+0x190/0x190
> [14182.037546]  ? skb_checksum_help+0xac/0x1d0
> [14182.037556]  dev_hard_start_xmit+0x60/0x1d0
> [14182.037568]  sch_direct_xmit+0xa0/0x370
> [14182.037582]  __dev_queue_xmit+0x94f/0xd70
> [14182.037592]  ? nf_hook_slow+0x3e/0xc0
> [14182.037602]  ip_finish_output2+0x297/0x560
> [14182.037616]  __ip_queue_xmit+0x171/0x460
> [14182.037624]  __tcp_transmit_skb+0xaa4/0xc00
> [14182.037636]  tcp_write_xmit+0x528/0x1390
> [14182.037646]  tcp_tsq_handler+0x7a/0x90
> [14182.037655]  tcp_tasklet_func+0xdd/0x120
> [14182.037665]  tasklet_action_common.constprop.0+0xb8/0x140
> [14182.037679]  __do_softirq+0xc3/0x2ab
> [14182.037689]  __irq_exit_rcu+0xaa/0xe0
> [14182.037702]  common_interrupt+0x82/0xa0
> [14182.037712]  </IRQ>
> [14182.037715]  <TASK>
> [14182.037719]  asm_common_interrupt+0x22/0x40
> [14182.037727] RIP: 0010:cpuidle_enter_state+0xde/0x420
> [14182.037737] Code: 00 00 31 ff e8 b3 24 97 ff 45 84 ff 74 16 9c 58 0f=
 1f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 88 cf 9d ff fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [14182.037744] RSP: 0018:ffffa68fc0203e90 EFLAGS: 00000246
> [14182.037752] RAX: ffff91b61f5f1a40 RBX: ffffc68fbfbf2f00 RCX: 0000000=
000000000
> [14182.037757] RDX: 000000000000000f RSI: fffffffdb973bbb2 RDI: 0000000=
000000000
> [14182.037761] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000=
03c9b26c9
> [14182.037766] R10: 0000000000000018 R11: 00000000000005ce R12: fffffff=
f87b9ef20
> [14182.037772] R13: 00000ce6033a7166 R14: 0000000000000004 R15: 0000000=
000000000
> [14182.037782]  cpuidle_enter+0x29/0x40
> [14182.037789]  do_idle+0x202/0x2a0
> [14182.037801]  cpu_startup_entry+0x26/0x30
> [14182.037813]  start_secondary+0x12a/0x150
> [14182.037825]  secondary_startup_64_no_verify+0xe5/0xeb
> [14182.037838]  </TASK>
> [14182.037842] ---[ end trace 0000000000000000 ]---
> [14182.064321] ------------[ cut here ]------------
> [14182.064336] WARNING: CPU: 15 PID: 0 at drivers/iommu/dma-iommu.c:104=
1 iommu_dma_unmap_page+0x79/0x90
> [14182.064353] Modules linked in: r8169(OE) realtek mdio_devres libphy =
nft_chain_nat nf_nat bridge stp llc qrtr ip6t_REJECT nf_reject_ipv6 ipt_R=
EJECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 sunrpc nft_compat nf_tables libcrc32c binfmt_misc nfnetlink=
 joydev hid_generic nls_ascii nls_cp437 vfat fat intel_rapl_msr intel_rap=
l_common x86_pkg_temp_thermal intel_powerclamp coretemp amdgpu kvm_intel =
kvm snd_sof_pci_intel_tgl irqbypass snd_sof_intel_hda_common snd_hda_code=
c_realtek soundwire_intel snd_hda_codec_generic soundwire_generic_allocat=
ion ghash_clmulni_intel ledtrig_audio soundwire_cadence iwlmvm snd_sof_in=
tel_hda sha512_ssse3 snd_sof_pci sha512_generic snd_sof_xtensa_dsp sha256=
_ssse3 snd_sof sha1_ssse3 snd_sof_utils snd_soc_hdac_hda mac80211 snd_hda=
_ext_core snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_compress=
 snd_hda_codec_hdmi soundwire_bus aesni_intel libarc4 gpu_sched snd_hda_i=
ntel drm_buddy snd_intel_dspcfg crypto_simd
> [14182.064746]  snd_intel_sdw_acpi drm_display_helper cryptd iwlwifi sn=
d_hda_codec cec rapl rc_core drm_ttm_helper snd_hda_core mei_hdcp iTCO_wd=
t ttm pmt_telemetry snd_hwdep intel_cstate intel_pmc_bxt pmt_class evdev =
cfg80211 intel_uncore snd_pcm drm_kms_helper wmi_bmof pcspkr mxm_wmi ee10=
04 snd_timer iTCO_vendor_support mei_me watchdog i2c_algo_bit snd mei sou=
ndcore rfkill intel_vsec serial_multi_instantiate intel_pmc_core acpi_tad=
 acpi_pad button usbhid hid nct6683 parport_pc ppdev drm lp parport fuse =
loop efi_pstore configfs efivarfs ip_tables x_tables autofs4 ext4 crc16 m=
bcache jbd2 crc32c_generic dm_mod ahci xhci_pci nvme libahci xhci_hcd nvm=
e_core libata t10_pi usbcore scsi_mod crc32_pclmul crc64_rocksoft crc32c_=
intel crc64 i2c_i801 crc_t10dif crct10dif_generic i2c_smbus crct10dif_pcl=
mul usb_common scsi_common crct10dif_common fan video wmi pinctrl_alderla=
ke [last unloaded: r8169(OE)]
> [14182.065329] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W  OE =
     6.1.0-21-amd64 #1  Debian 6.1.90-1
> [14182.065339] Hardware name: Micro-Star International Co., Ltd. MS-7D4=
3/PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
> [14182.065343] RIP: 0010:iommu_dma_unmap_page+0x79/0x90
> [14182.065354] Code: 2b 48 3b 28 72 26 48 3b 68 08 73 20 4d 89 f8 44 89=
 f1 4c 89 ea 48 89 ee 48 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 17 a5 a6 =
ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 66 0f 1f 44 00
> [14182.065361] RSP: 0018:ffffa68fc04c0e30 EFLAGS: 00010246
> [14182.065370] RAX: 0000000000000000 RBX: ffff91aec1efc0d0 RCX: 0000000=
000000012
> [14182.065377] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000003
> [14182.065382] RBP: ffff91aec4369dc8 R08: 0000000000000002 R09: fffffff=
ffff80000
> [14182.065387] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000000
> [14182.065393] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000=
000000000
> [14182.065397] FS:  0000000000000000(0000) GS:ffff91b61f5c0000(0000) kn=
lGS:0000000000000000
> [14182.065404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14182.065410] CR2: 00007ff280669820 CR3: 000000048b410000 CR4: 0000000=
000750ee0
> [14182.065416] PKRU: 55555554
> [14182.065421] Call Trace:
> [14182.065427]  <IRQ>
> [14182.065434]  ? __warn+0x7d/0xc0
> [14182.065446]  ? iommu_dma_unmap_page+0x79/0x90
> [14182.065454]  ? report_bug+0xe2/0x150
> [14182.065469]  ? handle_bug+0x41/0x70
> [14182.065478]  ? exc_invalid_op+0x13/0x60
> [14182.065488]  ? asm_exc_invalid_op+0x16/0x20
> [14182.065499]  ? iommu_dma_unmap_page+0x79/0x90
> [14182.065510]  rtl8169_unmap_tx_skb+0x3b/0x70 [r8169]
> [14182.065533]  rtl8169_poll+0x63/0x4e0 [r8169]
> [14182.065553]  __napi_poll+0x28/0x160
> [14182.065564]  net_rx_action+0x29e/0x350
> [14182.065574]  ? note_gp_changes+0x50/0x80
> [14182.065586]  __do_softirq+0xc3/0x2ab
> [14182.065595]  ? handle_edge_irq+0x87/0x220
> [14182.065609]  __irq_exit_rcu+0xaa/0xe0
> [14182.065619]  common_interrupt+0x82/0xa0
> [14182.065628]  </IRQ>
> [14182.065632]  <TASK>
> [14182.065636]  asm_common_interrupt+0x22/0x40
> [14182.065644] RIP: 0010:cpuidle_enter_state+0xde/0x420
> [14182.065652] Code: 00 00 31 ff e8 b3 24 97 ff 45 84 ff 74 16 9c 58 0f=
 1f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 88 cf 9d ff fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [14182.065659] RSP: 0018:ffffa68fc0203e90 EFLAGS: 00000246
> [14182.065666] RAX: ffff91b61f5f1a40 RBX: ffffc68fbfbf2f00 RCX: 0000000=
000000000
> [14182.065673] RDX: 000000000000000f RSI: fffffffdb973bbb2 RDI: 0000000=
000000000
> [14182.065677] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000=
03c9b26c9
> [14182.065681] R10: 0000000000000018 R11: 000000000000077d R12: fffffff=
f87b9ef20
> [14182.065687] R13: 00000ce604e764b0 R14: 0000000000000004 R15: 0000000=
000000000
> [14182.065698]  cpuidle_enter+0x29/0x40
> [14182.065707]  do_idle+0x202/0x2a0
> [14182.065718]  cpu_startup_entry+0x26/0x30
> [14182.065728]  start_secondary+0x12a/0x150
> [14182.065738]  secondary_startup_64_no_verify+0xe5/0xeb
> [14182.065751]  </TASK>
> [14182.065755] ---[ end trace 0000000000000000 ]---
>=20
>=20
> The patch below fixes the problem, by simply reading nr_frags a bit lat=
er, after the checksum stage.
>=20
>=20
> diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c =
linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> index 2ce4bff..ee1beda 100644
> --- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
> +++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4263,7 +4263,7 @@ static void rtl8169_doorbell(struct rtl8169_priva=
te *tp)
>  static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>  				      struct net_device *dev)
>  {
> -	unsigned int frags =3D skb_shinfo(skb)->nr_frags;
> +	unsigned int frags;
>  	struct rtl8169_private *tp =3D netdev_priv(dev);
>  	unsigned int entry =3D tp->cur_tx % NUM_TX_DESC;
>  	struct TxDesc *txd_first, *txd_last;
> @@ -4290,6 +4290,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_b=
uff *skb,
> =20
>  	txd_first =3D tp->TxDescArray + entry;
> =20
> +	frags =3D skb_shinfo(skb)->nr_frags;
>  	if (frags) {
>  		if (rtl8169_xmit_frags(tp, skb, opts, entry))
>  			goto err_dma_1;
>=20

Nice. Are you going to submit this as proper fix?
Supposedly it should fix the following:
9020845fb5d6 ("r8169: improve rtl8169_start_xmit")


