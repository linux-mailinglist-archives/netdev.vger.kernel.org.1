Return-Path: <netdev+bounces-97037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF68C8D76
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 22:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAD628625C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0403C489;
	Fri, 17 May 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9UGiUGn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB314F61
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715979088; cv=none; b=PbKcXY9Swlt4BHWnYDVb6R6XrxFpmF2SWxMC6hnlMIuPC8JyQh0FXNXDQgwbovnL+Wfb4GjmFDrg4JMHgKBSBEMwfOBmBAHqUivn1Vu4xHLUTGKDn1GZjK3A7LYX5aynn4fVgCrE83Is7ItGmdQbBkca5j7q7jt+HEmIFeU944U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715979088; c=relaxed/simple;
	bh=svEIBFyIcg0xBHUJy9BIF5nssM2UzUXFkb1nXLEqm8c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=WZSwj+ExjMNM0oKWh5ysyssFURgmbeAy6tuQn9n1Oh/0+GkeGPP4Iw02a+O5MAyFys73LhCQqsYH1jE+D5JuqMay02COxDg/jzC9iBLQlsVszRYxeu6Fh6RcPuW+LAcV81ws2Kzi6I+egeOllwmR3z+oSxBQSKIMVShJJcC7ErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9UGiUGn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420180b5922so7001015e9.2
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715979085; x=1716583885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XGWNaRy3bFdFStXz+dQONXn7+J1jJGysSZ52VoLNew=;
        b=Y9UGiUGnU1D71Z+Tarf6XNnla1NgUrwh4RU+kNv1tQqtHIq7Qj/SZLKOchPZd1ez/M
         f6NxM78LEYDHpHnXp1+v3qhv2mjrrV8Xd/IC6/uKgb/xBos2RnrZvGAcv0QZINbf++JN
         5k6jxuygOYroEelsbGBM3jga3SD6bHkps650lPkUofY/2wrGnjzgrZey3XGCfmaszsGr
         Wr+txvP1JjfasNGe/5ib8KktpzX+qLmHe6lfoFn+C+0lQVZ4+x+afuvMqj1rkhoIxxzH
         wgl2B3F4A23UW2P739xj8ADZs+Kzusdkvtdg4UE/Ci/ZDcy0baHiPz+dPCuwURrTKZPu
         i8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715979085; x=1716583885;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0XGWNaRy3bFdFStXz+dQONXn7+J1jJGysSZ52VoLNew=;
        b=SsVYfGnKG7iFP6u0BhkKFH4q/ah4B7R+Dg5fyiCFMk4XDcrMCNUTw6IGW2t/Fgj38d
         VoIEFBmeO0HQOg4niiMMhaI5Jf/6+qAc/uXZzY4HK5JhRvtleq5USmk8QnTIzRIJX8fA
         Vqw05gS4QiDH0/2z9GZkQwaPvI3dzfpfAC1iGX8yJNaQORlO5SB4vZTXdoG6jDPcFsgD
         tbE2AN3J6uRxYpdUssnsMNTL5d3l5E9rdqKw/2rD8Et1mHP8NKfrO7Uh1Ngx89DtpCuN
         JlA0BFgihduSuHDb0G+LwJ8+r00DNgbcVqX1A/4YUsOjHhXVLIiVvneVgEjgrUYJWEG4
         dd5w==
X-Gm-Message-State: AOJu0YxJ5b6SJJnukso3nz521429MXCSCai0D5unH1JighkGsg5+0yC1
	Xf+9Vx5LGZxpe5TVO9/eY/BJS6cG0YbKxj1t4wTonKavw4MbjcddKtCfYbWl
X-Google-Smtp-Source: AGHT+IE8HNlxk3gn7BIGIj/7h03BuHm9712pP0DGfz8pPPgBFUlHK7RZaNuOYQcuRRrHePNKZU4euA==
X-Received: by 2002:a05:600c:3114:b0:418:a706:3209 with SMTP id 5b1f17b1804b1-41feac55e6emr254056825e9.31.1715979084097;
        Fri, 17 May 2024 13:51:24 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42016a511a7sm190891855e9.0.2024.05.17.13.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 13:51:23 -0700 (PDT)
Message-ID: <b18ea747-252a-44ad-b746-033be1784114@gmail.com>
Date: Fri, 17 May 2024 21:51:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ken Milmore <ken.milmore@gmail.com>
Subject: r8169: Crash with TX segmentation offload on RTL8125
Content-Language: en-GB
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have found an obscure but serious bug involving fragmented TX skbuffs o=
n the RTL8125.
The fix is trivial and is given at the end of this post.


For some months I have been running an RTL8125B with TX segmentation offl=
oad enabled, as follows:

# ethtool -K eth0 tx-scatter-gather on tx-tcp-segmentation on tx-tcp6-seg=
mentation on

This considerably reduces the soft IRQ CPU usage of the driver under heav=
y load.
I found it to be stable under prolonged use, until I encountered a proble=
m connecting to a Windows machine using xfreerdp.

After a few minutes of usage with xfreerdp, the network connection fails,=
 often also locking up the machine completely.
The following warning is seen:


[  188.932673] ------------[ cut here ]------------
[  188.932690] WARNING: CPU: 15 PID: 0 at drivers/iommu/dma-iommu.c:1041 =
iommu_dma_unmap_page+0x79/0x90
[  188.932708] Modules linked in: nft_chain_nat nf_nat bridge stp llc joy=
dev hid_generic ip6t_REJECT nf_reject_ipv6 qrtr ipt_REJECT nf_reject_ipv4=
 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sunrpc=
 nft_compat nf_tables libcrc32c binfmt_misc nfnetlink nls_ascii nls_cp437=
 vfat fat intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_pow=
erclamp coretemp amdgpu kvm_intel kvm snd_sof_pci_intel_tgl snd_sof_intel=
_hda_common irqbypass soundwire_intel soundwire_generic_allocation soundw=
ire_cadence iwlmvm snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp ghash=
_clmulni_intel snd_sof sha512_ssse3 snd_hda_codec_realtek snd_sof_utils s=
ha512_generic mac80211 snd_soc_hdac_hda snd_hda_ext_core sha256_ssse3 snd=
_soc_acpi_intel_match snd_hda_codec_generic sha1_ssse3 snd_soc_acpi ledtr=
ig_audio snd_soc_core snd_compress gpu_sched snd_hda_codec_hdmi soundwire=
_bus drm_buddy libarc4 drm_display_helper snd_hda_intel snd_intel_dspcfg =
snd_intel_sdw_acpi aesni_intel cec iwlwifi
[  188.933060]  snd_hda_codec rc_core drm_ttm_helper crypto_simd ttm cryp=
td snd_hda_core rapl snd_hwdep drm_kms_helper iTCO_wdt intel_cstate pmt_t=
elemetry mei_hdcp intel_pmc_bxt pmt_class evdev snd_pcm i2c_algo_bit mxm_=
wmi cfg80211 intel_uncore wmi_bmof pcspkr snd_timer ee1004 iTCO_vendor_su=
pport mei_me snd watchdog mei soundcore intel_vsec rfkill serial_multi_in=
stantiate intel_pmc_core acpi_tad acpi_pad usbhid button hid nct6683 parp=
ort_pc ppdev drm lp parport fuse loop efi_pstore configfs efivarfs ip_tab=
les x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic dm_mod ahci n=
vme libahci xhci_pci nvme_core libata xhci_hcd t10_pi r8169 realtek crc64=
_rocksoft crc64 crc_t10dif mdio_devres usbcore scsi_mod libphy crc32_pclm=
ul crc32c_intel i2c_i801 crct10dif_generic crct10dif_pclmul scsi_common i=
2c_smbus usb_common crct10dif_common fan video wmi pinctrl_alderlake
[  188.933435] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 6.1.0-21-amd64=
 #1  Debian 6.1.90-1
[  188.933446] Hardware name: Micro-Star International Co., Ltd. MS-7D43/=
PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
[  188.933451] RIP: 0010:iommu_dma_unmap_page+0x79/0x90
[  188.933461] Code: 2b 48 3b 28 72 26 48 3b 68 08 73 20 4d 89 f8 44 89 f=
1 4c 89 ea 48 89 ee 48 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 17 a5 a6 ff=
 <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 66 0f 1f 44 00
[  188.933467] RSP: 0000:ffffa579c04c0e30 EFLAGS: 00010246
[  188.933476] RAX: 0000000000000000 RBX: ffff946ac1e580d0 RCX: 000000000=
0000012
[  188.933482] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000003
[  188.933489] RBP: ffff946ae189d9d8 R08: 0000000000000002 R09: fffffffff=
ff80000
[  188.933495] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
[  188.933501] R13: 0000000000000000 R14: 0000000000000001 R15: 000000000=
0000000
[  188.933507] FS:  0000000000000000(0000) GS:ffff94721f5c0000(0000) knlG=
S:0000000000000000
[  188.933515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  188.933522] CR2: 00007ff061775000 CR3: 0000000772010000 CR4: 000000000=
0750ee0
[  188.933529] PKRU: 55555554
[  188.933535] Call Trace:
[  188.933543]  <IRQ>
[  188.933552]  ? __warn+0x7d/0xc0
[  188.933564]  ? iommu_dma_unmap_page+0x79/0x90
[  188.933574]  ? report_bug+0xe2/0x150
[  188.933589]  ? handle_bug+0x41/0x70
[  188.933598]  ? exc_invalid_op+0x13/0x60
[  188.933606]  ? asm_exc_invalid_op+0x16/0x20
[  188.933617]  ? iommu_dma_unmap_page+0x79/0x90
[  188.933625]  rtl8169_unmap_tx_skb+0x3b/0x70 [r8169]
[  188.933647]  rtl8169_poll+0x63/0x4e0 [r8169]
[  188.933667]  __napi_poll+0x28/0x160
[  188.933678]  net_rx_action+0x29e/0x350
[  188.933688]  __do_softirq+0xc3/0x2ab
[  188.933697]  ? handle_edge_irq+0x87/0x220
[  188.933708]  __irq_exit_rcu+0xaa/0xe0
[  188.933719]  common_interrupt+0x82/0xa0
[  188.933728]  </IRQ>
[  188.933731]  <TASK>
[  188.933734]  asm_common_interrupt+0x22/0x40
[  188.933742] RIP: 0010:cpuidle_enter_state+0xde/0x420
[  188.933751] Code: 00 00 31 ff e8 b3 24 97 ff 45 84 ff 74 16 9c 58 0f 1=
f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 88 cf 9d ff fb 0f 1f 44 00 00=
 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  188.933756] RSP: 0000:ffffa579c0203e90 EFLAGS: 00000246
[  188.933764] RAX: ffff94721f5f1a40 RBX: ffffc579bfbf2f00 RCX: 000000000=
0000000
[  188.933769] RDX: 000000000000000f RSI: fffffffdb2461367 RDI: 000000000=
0000000
[  188.933773] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000003=
c9b26c9
[  188.933777] R10: 0000000000000018 R11: 000000000000084b R12: ffffffffa=
3f9ef20
[  188.933781] R13: 0000002bfd4336f6 R14: 0000000000000004 R15: 000000000=
0000000
[  188.933791]  cpuidle_enter+0x29/0x40
[  188.933797]  do_idle+0x202/0x2a0
[  188.933808]  cpu_startup_entry+0x26/0x30
[  188.933817]  start_secondary+0x12a/0x150
[  188.933828]  secondary_startup_64_no_verify+0xe5/0xeb
[  188.933843]  </TASK>
[  188.933848] ---[ end trace 0000000000000000 ]---


After some experimentation, I found the cause:=20

- rtl8169_start_xmit() gets the number of fragments in the skb (nr_frags)=
, then calls rtl8169_tso_csum_v2().

- For some devices, rtl8169_tso_csum_v2() calls __skb_put_padto() to pad =
the buffer up to a minimum of 60 bytes to work around hardware bugs.

- If the skb is fragmented, it seems that __skb_put_padto() may coalesce =
it so that nr_frags is reduced.

- rtl8169_start_xmit() still has the old value of nr_frags, which may cau=
se some TX ring buffer entries to be improperly set up.

It seems that xfreerdp generates lots of small packet fragments (~46 byte=
s) so it is a good candidate for triggering this bug.

To verify this, I tried the following code which produced the dmesg outpu=
t below:


diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c li=
nux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
index 2ce4bff..d663b2a 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -4284,6 +4284,9 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buf=
f *skb,
 	else if (!rtl8169_tso_csum_v2(tp, skb, opts))
 		goto err_dma_0;
=20
+	WARN(frags !=3D skb_shinfo(skb)->nr_frags,
+		"rtl8169_start_xmit: frags changed: %u -> %u",
+		frags, skb_shinfo(skb)->nr_frags);
 	if (unlikely(rtl8169_tx_map(tp, opts, skb_headlen(skb), skb->data,
 				    entry, false)))
 		goto err_dma_0;

[14182.036226] ------------[ cut here ]------------
[14182.036245] rtl8169_start_xmit: frags changed: 1 -> 0
[14182.036278] WARNING: CPU: 15 PID: 0 at /home/ken/work/r8169/linux-sour=
ce-6.1/drivers/net/ethernet/realtek/r8169_main.c:4287 rtl8169_start_xmit+=
0x54d/0x7e0 [r8169]
[14182.036313] Modules linked in: r8169(OE) realtek mdio_devres libphy nf=
t_chain_nat nf_nat bridge stp llc qrtr ip6t_REJECT nf_reject_ipv6 ipt_REJ=
ECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 sunrpc nft_compat nf_tables libcrc32c binfmt_misc nfnetlink j=
oydev hid_generic nls_ascii nls_cp437 vfat fat intel_rapl_msr intel_rapl_=
common x86_pkg_temp_thermal intel_powerclamp coretemp amdgpu kvm_intel kv=
m snd_sof_pci_intel_tgl irqbypass snd_sof_intel_hda_common snd_hda_codec_=
realtek soundwire_intel snd_hda_codec_generic soundwire_generic_allocatio=
n ghash_clmulni_intel ledtrig_audio soundwire_cadence iwlmvm snd_sof_inte=
l_hda sha512_ssse3 snd_sof_pci sha512_generic snd_sof_xtensa_dsp sha256_s=
sse3 snd_sof sha1_ssse3 snd_sof_utils snd_soc_hdac_hda mac80211 snd_hda_e=
xt_core snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_compress s=
nd_hda_codec_hdmi soundwire_bus aesni_intel libarc4 gpu_sched snd_hda_int=
el drm_buddy snd_intel_dspcfg crypto_simd
[14182.036723]  snd_intel_sdw_acpi drm_display_helper cryptd iwlwifi snd_=
hda_codec cec rapl rc_core drm_ttm_helper snd_hda_core mei_hdcp iTCO_wdt =
ttm pmt_telemetry snd_hwdep intel_cstate intel_pmc_bxt pmt_class evdev cf=
g80211 intel_uncore snd_pcm drm_kms_helper wmi_bmof pcspkr mxm_wmi ee1004=
 snd_timer iTCO_vendor_support mei_me watchdog i2c_algo_bit snd mei sound=
core rfkill intel_vsec serial_multi_instantiate intel_pmc_core acpi_tad a=
cpi_pad button usbhid hid nct6683 parport_pc ppdev drm lp parport fuse lo=
op efi_pstore configfs efivarfs ip_tables x_tables autofs4 ext4 crc16 mbc=
ache jbd2 crc32c_generic dm_mod ahci xhci_pci nvme libahci xhci_hcd nvme_=
core libata t10_pi usbcore scsi_mod crc32_pclmul crc64_rocksoft crc32c_in=
tel crc64 i2c_i801 crc_t10dif crct10dif_generic i2c_smbus crct10dif_pclmu=
l usb_common scsi_common crct10dif_common fan video wmi pinctrl_alderlake=
 [last unloaded: r8169(OE)]
[14182.037307] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W  OE   =
   6.1.0-21-amd64 #1  Debian 6.1.90-1
[14182.037318] Hardware name: Micro-Star International Co., Ltd. MS-7D43/=
PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
[14182.037323] RIP: 0010:rtl8169_start_xmit+0x54d/0x7e0 [r8169]
[14182.037347] Code: 48 05 90 00 00 00 f0 80 08 01 b8 10 00 00 00 48 83 8=
5 68 01 00 00 01 e9 0a fd ff ff 89 fe 48 c7 c7 e0 67 32 c0 e8 53 56 d8 c5=
 <0f> 0b e9 85 fb ff ff 4c 8b bb c8 00 00 00 8b 83 c0 00 00 00 8b 54
[14182.037354] RSP: 0018:ffffa68fc04c0b90 EFLAGS: 00010286
[14182.037364] RAX: 0000000000000000 RBX: ffff91b0272a82e8 RCX: 000000000=
000083f
[14182.037370] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000=
000083f
[14182.037376] RBP: ffff91aec4368000 R08: 0000000000000000 R09: ffffa68fc=
04c0a08
[14182.037381] R10: 0000000000000003 R11: ffff91b63f77dc40 R12: 000000000=
0000001
[14182.037385] R13: ffff91aec4368980 R14: 00000000000014a5 R15: 000000000=
0000004
[14182.037390] FS:  0000000000000000(0000) GS:ffff91b61f5c0000(0000) knlG=
S:0000000000000000
[14182.037398] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14182.037404] CR2: 00007ff280669820 CR3: 000000048b410000 CR4: 000000000=
0750ee0
[14182.037411] PKRU: 55555554
[14182.037415] Call Trace:
[14182.037424]  <IRQ>
[14182.037430]  ? __warn+0x7d/0xc0
[14182.037443]  ? rtl8169_start_xmit+0x54d/0x7e0 [r8169]
[14182.037466]  ? report_bug+0xe2/0x150
[14182.037480]  ? handle_bug+0x41/0x70
[14182.037490]  ? exc_invalid_op+0x13/0x60
[14182.037498]  ? asm_exc_invalid_op+0x16/0x20
[14182.037508]  ? rtl8169_start_xmit+0x54d/0x7e0 [r8169]
[14182.037527]  ? csum_block_add_ext+0x20/0x20
[14182.037537]  ? reqsk_fastopen_remove+0x190/0x190
[14182.037546]  ? skb_checksum_help+0xac/0x1d0
[14182.037556]  dev_hard_start_xmit+0x60/0x1d0
[14182.037568]  sch_direct_xmit+0xa0/0x370
[14182.037582]  __dev_queue_xmit+0x94f/0xd70
[14182.037592]  ? nf_hook_slow+0x3e/0xc0
[14182.037602]  ip_finish_output2+0x297/0x560
[14182.037616]  __ip_queue_xmit+0x171/0x460
[14182.037624]  __tcp_transmit_skb+0xaa4/0xc00
[14182.037636]  tcp_write_xmit+0x528/0x1390
[14182.037646]  tcp_tsq_handler+0x7a/0x90
[14182.037655]  tcp_tasklet_func+0xdd/0x120
[14182.037665]  tasklet_action_common.constprop.0+0xb8/0x140
[14182.037679]  __do_softirq+0xc3/0x2ab
[14182.037689]  __irq_exit_rcu+0xaa/0xe0
[14182.037702]  common_interrupt+0x82/0xa0
[14182.037712]  </IRQ>
[14182.037715]  <TASK>
[14182.037719]  asm_common_interrupt+0x22/0x40
[14182.037727] RIP: 0010:cpuidle_enter_state+0xde/0x420
[14182.037737] Code: 00 00 31 ff e8 b3 24 97 ff 45 84 ff 74 16 9c 58 0f 1=
f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 88 cf 9d ff fb 0f 1f 44 00 00=
 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[14182.037744] RSP: 0018:ffffa68fc0203e90 EFLAGS: 00000246
[14182.037752] RAX: ffff91b61f5f1a40 RBX: ffffc68fbfbf2f00 RCX: 000000000=
0000000
[14182.037757] RDX: 000000000000000f RSI: fffffffdb973bbb2 RDI: 000000000=
0000000
[14182.037761] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000003=
c9b26c9
[14182.037766] R10: 0000000000000018 R11: 00000000000005ce R12: ffffffff8=
7b9ef20
[14182.037772] R13: 00000ce6033a7166 R14: 0000000000000004 R15: 000000000=
0000000
[14182.037782]  cpuidle_enter+0x29/0x40
[14182.037789]  do_idle+0x202/0x2a0
[14182.037801]  cpu_startup_entry+0x26/0x30
[14182.037813]  start_secondary+0x12a/0x150
[14182.037825]  secondary_startup_64_no_verify+0xe5/0xeb
[14182.037838]  </TASK>
[14182.037842] ---[ end trace 0000000000000000 ]---
[14182.064321] ------------[ cut here ]------------
[14182.064336] WARNING: CPU: 15 PID: 0 at drivers/iommu/dma-iommu.c:1041 =
iommu_dma_unmap_page+0x79/0x90
[14182.064353] Modules linked in: r8169(OE) realtek mdio_devres libphy nf=
t_chain_nat nf_nat bridge stp llc qrtr ip6t_REJECT nf_reject_ipv6 ipt_REJ=
ECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 sunrpc nft_compat nf_tables libcrc32c binfmt_misc nfnetlink j=
oydev hid_generic nls_ascii nls_cp437 vfat fat intel_rapl_msr intel_rapl_=
common x86_pkg_temp_thermal intel_powerclamp coretemp amdgpu kvm_intel kv=
m snd_sof_pci_intel_tgl irqbypass snd_sof_intel_hda_common snd_hda_codec_=
realtek soundwire_intel snd_hda_codec_generic soundwire_generic_allocatio=
n ghash_clmulni_intel ledtrig_audio soundwire_cadence iwlmvm snd_sof_inte=
l_hda sha512_ssse3 snd_sof_pci sha512_generic snd_sof_xtensa_dsp sha256_s=
sse3 snd_sof sha1_ssse3 snd_sof_utils snd_soc_hdac_hda mac80211 snd_hda_e=
xt_core snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_compress s=
nd_hda_codec_hdmi soundwire_bus aesni_intel libarc4 gpu_sched snd_hda_int=
el drm_buddy snd_intel_dspcfg crypto_simd
[14182.064746]  snd_intel_sdw_acpi drm_display_helper cryptd iwlwifi snd_=
hda_codec cec rapl rc_core drm_ttm_helper snd_hda_core mei_hdcp iTCO_wdt =
ttm pmt_telemetry snd_hwdep intel_cstate intel_pmc_bxt pmt_class evdev cf=
g80211 intel_uncore snd_pcm drm_kms_helper wmi_bmof pcspkr mxm_wmi ee1004=
 snd_timer iTCO_vendor_support mei_me watchdog i2c_algo_bit snd mei sound=
core rfkill intel_vsec serial_multi_instantiate intel_pmc_core acpi_tad a=
cpi_pad button usbhid hid nct6683 parport_pc ppdev drm lp parport fuse lo=
op efi_pstore configfs efivarfs ip_tables x_tables autofs4 ext4 crc16 mbc=
ache jbd2 crc32c_generic dm_mod ahci xhci_pci nvme libahci xhci_hcd nvme_=
core libata t10_pi usbcore scsi_mod crc32_pclmul crc64_rocksoft crc32c_in=
tel crc64 i2c_i801 crc_t10dif crct10dif_generic i2c_smbus crct10dif_pclmu=
l usb_common scsi_common crct10dif_common fan video wmi pinctrl_alderlake=
 [last unloaded: r8169(OE)]
[14182.065329] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W  OE   =
   6.1.0-21-amd64 #1  Debian 6.1.90-1
[14182.065339] Hardware name: Micro-Star International Co., Ltd. MS-7D43/=
PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
[14182.065343] RIP: 0010:iommu_dma_unmap_page+0x79/0x90
[14182.065354] Code: 2b 48 3b 28 72 26 48 3b 68 08 73 20 4d 89 f8 44 89 f=
1 4c 89 ea 48 89 ee 48 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 17 a5 a6 ff=
 <0f> 0b 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 66 0f 1f 44 00
[14182.065361] RSP: 0018:ffffa68fc04c0e30 EFLAGS: 00010246
[14182.065370] RAX: 0000000000000000 RBX: ffff91aec1efc0d0 RCX: 000000000=
0000012
[14182.065377] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000003
[14182.065382] RBP: ffff91aec4369dc8 R08: 0000000000000002 R09: fffffffff=
ff80000
[14182.065387] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
[14182.065393] R13: 0000000000000000 R14: 0000000000000001 R15: 000000000=
0000000
[14182.065397] FS:  0000000000000000(0000) GS:ffff91b61f5c0000(0000) knlG=
S:0000000000000000
[14182.065404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14182.065410] CR2: 00007ff280669820 CR3: 000000048b410000 CR4: 000000000=
0750ee0
[14182.065416] PKRU: 55555554
[14182.065421] Call Trace:
[14182.065427]  <IRQ>
[14182.065434]  ? __warn+0x7d/0xc0
[14182.065446]  ? iommu_dma_unmap_page+0x79/0x90
[14182.065454]  ? report_bug+0xe2/0x150
[14182.065469]  ? handle_bug+0x41/0x70
[14182.065478]  ? exc_invalid_op+0x13/0x60
[14182.065488]  ? asm_exc_invalid_op+0x16/0x20
[14182.065499]  ? iommu_dma_unmap_page+0x79/0x90
[14182.065510]  rtl8169_unmap_tx_skb+0x3b/0x70 [r8169]
[14182.065533]  rtl8169_poll+0x63/0x4e0 [r8169]
[14182.065553]  __napi_poll+0x28/0x160
[14182.065564]  net_rx_action+0x29e/0x350
[14182.065574]  ? note_gp_changes+0x50/0x80
[14182.065586]  __do_softirq+0xc3/0x2ab
[14182.065595]  ? handle_edge_irq+0x87/0x220
[14182.065609]  __irq_exit_rcu+0xaa/0xe0
[14182.065619]  common_interrupt+0x82/0xa0
[14182.065628]  </IRQ>
[14182.065632]  <TASK>
[14182.065636]  asm_common_interrupt+0x22/0x40
[14182.065644] RIP: 0010:cpuidle_enter_state+0xde/0x420
[14182.065652] Code: 00 00 31 ff e8 b3 24 97 ff 45 84 ff 74 16 9c 58 0f 1=
f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 88 cf 9d ff fb 0f 1f 44 00 00=
 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[14182.065659] RSP: 0018:ffffa68fc0203e90 EFLAGS: 00000246
[14182.065666] RAX: ffff91b61f5f1a40 RBX: ffffc68fbfbf2f00 RCX: 000000000=
0000000
[14182.065673] RDX: 000000000000000f RSI: fffffffdb973bbb2 RDI: 000000000=
0000000
[14182.065677] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000003=
c9b26c9
[14182.065681] R10: 0000000000000018 R11: 000000000000077d R12: ffffffff8=
7b9ef20
[14182.065687] R13: 00000ce604e764b0 R14: 0000000000000004 R15: 000000000=
0000000
[14182.065698]  cpuidle_enter+0x29/0x40
[14182.065707]  do_idle+0x202/0x2a0
[14182.065718]  cpu_startup_entry+0x26/0x30
[14182.065728]  start_secondary+0x12a/0x150
[14182.065738]  secondary_startup_64_no_verify+0xe5/0xeb
[14182.065751]  </TASK>
[14182.065755] ---[ end trace 0000000000000000 ]---


The patch below fixes the problem, by simply reading nr_frags a bit later=
, after the checksum stage.


diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c li=
nux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
index 2ce4bff..ee1beda 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -4263,7 +4263,7 @@ static void rtl8169_doorbell(struct rtl8169_private=
 *tp)
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags =3D skb_shinfo(skb)->nr_frags;
+	unsigned int frags;
 	struct rtl8169_private *tp =3D netdev_priv(dev);
 	unsigned int entry =3D tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
@@ -4290,6 +4290,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buf=
f *skb,
=20
 	txd_first =3D tp->TxDescArray + entry;
=20
+	frags =3D skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;


