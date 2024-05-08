Return-Path: <netdev+bounces-94722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32C8C061C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 23:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EA7B20B9F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 21:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF81131BC7;
	Wed,  8 May 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlTPmpmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF4131758
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202887; cv=none; b=tAfEZJSgvIQOMsVAdsXom7zN1ug12rszsteLwihg9nLANemXHiZTcANOqLJqcQf+BakuiTpQx8KKEsF8LJ5I6FsgoI3Y7G5C+zbepcD9TSapFJFQEB2oF0ETpLSVOfnOJsHz4OmleP6yDvSfjqNtyK/JkEblmF/dbyxAN/jbhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202887; c=relaxed/simple;
	bh=Lf9g3o9EzpktHFLwDQSctB738MtuHmSNqMhBu+cHiD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYiJTbS4oQ3UKlcfh2efl7esKNc6nEHj9LN1edIrvQdF9FvPFsP43mHD0YnAyCBENNuN0IeZAtSe8RBNOusbz9ZJ3vEotLL9a42QmxAiZCyp9zXXq1N8wXUpUJrCl1kKSPQOZr0aoZgqpk5cyIaU2ZfDXGqnuYYttAsudF5bOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlTPmpmn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a934ad50so40507166b.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715202882; x=1715807682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bmn3LDGEv7yBVyKJ57Vpc85f+djVKRPjl//XxlxliC8=;
        b=MlTPmpmnFz9l0FUrvaaoQFJJCKMLJ2cjrRzHJn2U+84e00tZDxSWl6cKQrkMrkqhI7
         Gtmd90iTz17X9+SU1ecMYxkv7cHkmRY+5+F3Cr4VpDBz9Y3GJ4lIBBwnBdSfVNnPCq8O
         yMO+bceAV4f5f7EOkDKqo3p56m3Mk2Q/4Adfv1RxI2e4GjW+5AG8PedK/zrRL77/tAfZ
         sTZ8W8CdZWA+gFE0fZONtzvyOWNiICRjFUCEhaHi2tl+tyIkUrQ8gOvsuAc0kC6Ho1Cu
         U9eeYsnS8zz9j6g7f5A53hBdWhw34/8EqY3aYK9llPFd8Byu5LjhHtN/ual7tTLMn7NH
         Kq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202882; x=1715807682;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmn3LDGEv7yBVyKJ57Vpc85f+djVKRPjl//XxlxliC8=;
        b=d+mVego+6Myx/Mm8UZ37sUDkBGpKutCXEK/W+Y3DdTisjP1DFUFM2WSsN4idW3fRKb
         cMgfPjMsnOzGknRX28IJU+cHlh07jI+ybJoUm8HzUpTvXhlNW+8Vlyy3FwaSYfprbhXW
         W3ji/EBzqEacyTkec8M/+eo+i/QX0u5Iq/wO1pAnVtcIq0oHHo1VJzod3r43A7Hu1F7p
         Ow5XXfxeFMgHHMjr011qj/2Rv5NwbzzpK7tgwlqn9s5XW8wk6EivwO0c5aUNFsFBPSav
         PyFX08FgemgGTnWlbnOxlY75y5EG476MwFqK5k6Lc2U0hQHTx7N7DE1kdnlm/liC+wfr
         +BiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkd9Nho5tyCf7i9mIPRcUb5Qr5ebJNRKE/q7irZoKt2RmVklvN6aAS5YhHsPbMr7of7x01iYVER+tLlUdMHlZOvGktrr9W
X-Gm-Message-State: AOJu0YwN/BsZpAuYtOvPpHk4s3fw8s/gX7PcPg1mD1TWmvS82fsd4hYa
	4jq1CL8ejvc/zfSz8WmEkzHjNDlLW6y+WWEDQZg/RRmxJMFUx+mM/JoS5g==
X-Google-Smtp-Source: AGHT+IG+ijx3NzvNetRTEO9tmCBiN8kHaQAF3hdpGi43va9QqSvpfuAToJp1d5ApEH1xhlM8OBk8Eg==
X-Received: by 2002:a05:6402:5173:b0:573:1ee9:bf21 with SMTP id 4fb4d7f45d1cf-5731eea2f5dmr2478575a12.36.1715202881686;
        Wed, 08 May 2024 14:14:41 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5ec:1600:b431:d45e:ca48:8fa1? (dynamic-2a01-0c23-c5ec-1600-b431-d45e-ca48-8fa1.c23.pool.telefonica.de. [2a01:c23:c5ec:1600:b431:d45e:ca48:8fa1])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebc318sm2512a12.37.2024.05.08.14.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 14:14:40 -0700 (PDT)
Message-ID: <f4197a6d-d829-4adf-8666-1390f2355540@gmail.com>
Date: Wed, 8 May 2024 23:14:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: transmit queue timeouts and IRQ masking
To: Ken Milmore <ken.milmore@gmail.com>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <ad6a0c52-4dcb-444e-88cd-a6c490a817fe@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ad6a0c52-4dcb-444e-88cd-a6c490a817fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06.05.2024 23:28, Ken Milmore wrote:
> I have a motherboard with an integrated RTL8125B network adapter, and I=
 have found a way to predictably cause TX queue timeouts with the r8169 d=
river.
>=20
> Briefly, if rtl8169_poll() ever gets called with interrupts unmasked on=
 the device, then it seems to be possible to get it stuck in a non-interr=
upting state.
> It appears disaster can be averted in this case by making sure device i=
nterrupts are always masked when inside rtl8169_poll()! For which see bel=
ow...
>=20
> The preconditions I found for causing a timeout are:
> - Set gro_flush_timeout to a NON-ZERO value
> - Set napi_defer_hard_irqs to ZERO
> - Put some heavy bidirectional load on the interface (I find iperf3 to =
another host does the job nicely: 1Gbps is enough).
>=20
> e.g.
> # echo 20000 > /sys/class/net/eth0/gro_flush_timeout
> # echo 0 > /sys/class/net/eth0/napi_defer_hard_irqs
> # iperf3 --bidir -c hostname
>=20

Thanks for the interesting report and the thorough analysis.
I could reproduce the issue on RTL8168h. It didn't even take heavy
bidirectional load, iperf3 -R -c hostname was enough in my case.

> The bitrate falls off to zero almost immediately, whereafter the interf=
ace just stops working:
>=20
> [ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5][TX-C]   0.00-1.00   sec  1010 KBytes  8.26 Mbits/sec    1   1.39 =
KBytes      =20
> [  7][RX-C]   0.00-1.00   sec   421 KBytes  3.45 Mbits/sec             =
    =20
> [  5][TX-C]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    0   1.39 KB=
ytes      =20
> [  7][RX-C]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec               =
  =20
> [  5][TX-C]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.39 KB=
ytes      =20
>=20
> On recent(ish) kernels I see the "ASPM disabled on Tx timeout" message =
as it tries to recover, then after some delay, the familiar "transmit que=
ue 0 timed out" warning usually occurs.
>=20
>=20
> [  149.473134] ------------[ cut here ]------------
> [  149.473155] NETDEV WATCHDOG: eth0 (r8169): transmit queue 0 timed ou=
t 6812 ms
> [  149.473188] WARNING: CPU: 18 PID: 0 at net/sched/sch_generic.c:525 d=
ev_watchdog+0x235/0x240
> [  149.473206] Modules linked in: nft_chain_nat nf_nat bridge stp llc q=
rtr sunrpc binfmt_misc ip6t_REJECT nf_reject_ipv6 joydev ipt_REJECT nf_re=
ject_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ip=
v4 nft_compat nf_tables libcrc32c nfnetlink hid_generic nls_ascii nls_cp4=
37 usbhid vfat hid fat amdgpu intel_rapl_msr snd_sof_pci_intel_tgl intel_=
rapl_common snd_sof_intel_hda_common soundwire_intel soundwire_generic_al=
location intel_uncore_frequency intel_uncore_frequency_common snd_sof_int=
el_hda_mlink soundwire_cadence snd_sof_intel_hda snd_sof_pci x86_pkg_temp=
_thermal intel_powerclamp snd_sof_xtensa_dsp iwlmvm snd_sof coretemp kvm_=
intel snd_sof_utils snd_hda_codec_realtek snd_soc_hdac_hda mac80211 kvm s=
nd_hda_ext_core snd_hda_codec_generic snd_soc_acpi_intel_match snd_soc_ac=
pi ledtrig_audio snd_soc_core irqbypass snd_compress libarc4 drm_exec snd=
_pcm_dmaengine snd_hda_codec_hdmi ghash_clmulni_intel amdxcp soundwire_bu=
s drm_buddy sha512_ssse3 gpu_sched sha256_ssse3 snd_hda_intel sha1_ssse3
> [  149.473574]  drm_suballoc_helper snd_intel_dspcfg iwlwifi snd_intel_=
sdw_acpi drm_display_helper snd_hda_codec cec aesni_intel snd_hda_core cr=
ypto_simd cryptd rc_core snd_hwdep mei_pxp mei_hdcp snd_pcm rapl drm_ttm_=
helper pmt_telemetry iTCO_wdt cfg80211 ttm pmt_class snd_timer intel_pmc_=
bxt evdev intel_cstate drm_kms_helper wmi_bmof mxm_wmi snd iTCO_vendor_su=
pport mei_me intel_uncore i2c_algo_bit ee1004 pcspkr watchdog mei soundco=
re rfkill intel_vsec serial_multi_instantiate intel_pmc_core acpi_pad acp=
i_tad button drm nct6683 parport_pc ppdev lp parport loop efi_pstore conf=
igfs efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_g=
eneric dm_mod nvme ahci nvme_core xhci_pci libahci t10_pi xhci_hcd r8169 =
libata realtek crc64_rocksoft mdio_devres crc64 usbcore scsi_mod crc_t10d=
if i2c_i801 crct10dif_generic libphy crc32_pclmul crct10dif_pclmul crc32c=
_intel i2c_smbus video scsi_common usb_common crct10dif_common fan wmi pi=
nctrl_alderlake
> [  149.474122] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 6.6.13+bpo-a=
md64 #1  Debian 6.6.13-1~bpo12+1
> [  149.474134] Hardware name: Micro-Star International Co., Ltd. MS-7D4=
3/PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
> [  149.474141] RIP: 0010:dev_watchdog+0x235/0x240
> [  149.474154] Code: ff ff ff 48 89 df c6 05 6c 2a 40 01 01 e8 e3 37 fa=
 ff 45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 60 5f f2 9f e8 0b e3 6a =
ff <0f> 0b e9 2a ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
> [  149.474163] RSP: 0018:ffffa4c3c0444e78 EFLAGS: 00010286
> [  149.474176] RAX: 0000000000000000 RBX: ffff93d94b354000 RCX: 0000000=
00000083f
> [  149.474185] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 0000000=
00000083f
> [  149.474192] RBP: ffff93d94b3544c8 R08: 0000000000000000 R09: ffffa4c=
3c0444d00
> [  149.474199] R10: 0000000000000003 R11: ffff93e0bf780228 R12: ffff93d=
94b346a00
> [  149.474207] R13: ffff93d94b35441c R14: 0000000000000000 R15: 0000000=
000001a9c
> [  149.474215] FS:  0000000000000000(0000) GS:ffff93e09f680000(0000) kn=
lGS:0000000000000000
> [  149.474225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  149.474232] CR2: 00007f616800a008 CR3: 0000000136820000 CR4: 0000000=
000f50ee0
> [  149.474240] PKRU: 55555554
> [  149.474247] Call Trace:
> [  149.474254]  <IRQ>
> [  149.474261]  ? dev_watchdog+0x235/0x240
> [  149.474271]  ? __warn+0x81/0x130
> [  149.474289]  ? dev_watchdog+0x235/0x240
> [  149.474298]  ? report_bug+0x171/0x1a0
> [  149.474314]  ? handle_bug+0x41/0x70
> [  149.474326]  ? exc_invalid_op+0x17/0x70
> [  149.474338]  ? asm_exc_invalid_op+0x1a/0x20
> [  149.474353]  ? dev_watchdog+0x235/0x240
> [  149.474363]  ? dev_watchdog+0x235/0x240
> [  149.474372]  ? __pfx_dev_watchdog+0x10/0x10
> [  149.474381]  call_timer_fn+0x24/0x130
> [  149.474396]  ? __pfx_dev_watchdog+0x10/0x10
> [  149.474404]  __run_timers+0x222/0x2c0
> [  149.474420]  run_timer_softirq+0x1d/0x40
> [  149.474433]  __do_softirq+0xc7/0x2ae
> [  149.474444]  __irq_exit_rcu+0x96/0xb0
> [  149.474459]  sysvec_apic_timer_interrupt+0x72/0x90
> [  149.474469]  </IRQ>
> [  149.474473]  <TASK>
> [  149.474479]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  149.474492] RIP: 0010:cpuidle_enter_state+0xcc/0x440
> [  149.474504] Code: fa b6 53 ff e8 35 f4 ff ff 8b 53 04 49 89 c5 0f 1f=
 44 00 00 31 ff e8 43 c4 52 ff 45 84 ff 0f 85 57 02 00 00 fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [  149.474514] RSP: 0018:ffffa4c3c022be90 EFLAGS: 00000246
> [  149.474524] RAX: ffff93e09f6b3440 RBX: ffffc4c3bfcb2140 RCX: 0000000=
00000001f
> [  149.474529] RDX: 0000000000000012 RSI: 000000003c9b26c9 RDI: 0000000=
000000000
> [  149.474536] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000=
000000500
> [  149.474542] R10: 0000000000000007 R11: ffff93e09f6b1fe4 R12: fffffff=
fa079a500
> [  149.474548] R13: 00000022cd4ab97d R14: 0000000000000004 R15: 0000000=
000000000
> [  149.474560]  cpuidle_enter+0x2d/0x40
> [  149.474571]  do_idle+0x20d/0x270
> [  149.474585]  cpu_startup_entry+0x2a/0x30
> [  149.474598]  start_secondary+0x11e/0x140
> [  149.474613]  secondary_startup_64_no_verify+0x18f/0x19b
> [  149.474630]  </TASK>
> [  149.474635] ---[ end trace 0000000000000000 ]---
>=20
>=20
> Here's a dump of the registers (MAC Address redacted).
> It seems to be stuck on TxDescUnavail | RxOverflow | TxOK | RxOk, and i=
nterrupts are unmasked.
>=20
> # ethtool -d eth0
> Unknown RealTek chip (TxConfig: 0x67100f00)
> Offset		Values
> ------		------
> 0x0000:		XXXXXXXXXXXXXXXXX fe 09 40 00 00 00 80 00 01 00=20
> 0x0010:		00 00 57 ff 00 00 00 00 0a 00 00 00 00 00 00 00=20
> 0x0020:		00 10 7d ff 00 00 00 00 19 1e 9f b4 79 a5 3f 3b=20
> 0x0030:		00 00 00 00 00 00 00 0c 3f 00 00 00 95 00 00 00=20
> 0x0040:		00 0f 10 67 0e 0f c2 40 00 00 00 00 00 00 00 00=20
> 0x0050:		11 00 cf bc 60 11 03 01 00 00 00 00 00 00 00 00=20
> 0x0060:		00 00 00 00 00 00 00 00 00 00 02 00 f3 00 80 f0=20
> 0x0070:		00 00 00 00 00 00 00 00 07 00 00 00 00 00 b3 e9=20
> 0x0080:		62 60 02 00 00 02 20 00 00 00 00 00 00 00 00 00=20
> 0x0090:		00 00 00 00 60 00 20 02 62 64 00 00 00 00 00 00=20
> 0x00a0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
> 0x00b0:		1f 00 00 00 80 00 00 00 ec 10 1a d2 01 00 01 00=20
> 0x00c0:		00 00 00 00 00 00 00 00 00 00 00 00 12 00 00 00=20
> 0x00d0:		21 00 04 12 00 00 01 00 00 00 00 40 ff ff ff ff=20
> 0x00e0:		20 20 03 01 00 00 91 fe 00 00 00 00 ff 02 00 00=20
> 0x00f0:		3f 00 00 00 00 00 00 00 ff ff ff ff 00 00 00 00=20
>=20
>=20
> I tried instrumenting the code a bit and found that rtl8169_poll() bein=
g called with interrupts unmasked seems to be a precursor to the problem =
occuring.
> The *only* time this usually happens is when a GRO timer has been set b=
ut napi_defer_hard_irqs is off.
> Now that the defaults are gro_flush_timeout=3D20000, napi_defer_hard_ir=
qs=3D1, this probably doesn't happen very often for most people.
> I guess it will happen with busy polling, but I haven't tested that yet=
=2E
>=20
>=20
> diff --git linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c =
linux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
> index 81fd31f..927786f 100644
> --- linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c
> +++ linux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4601,6 +4601,8 @@ static int rtl8169_poll(struct napi_struct *napi,=
 int budget)
>         struct net_device *dev =3D tp->dev;
>         int work_done;
> =20
> +       WARN_ONCE(RTL_R32(tp, IntrMask_8125) !=3D 0, "rtl8169_poll: IRQ=
s enabled!");
> +
>         rtl_tx(dev, tp, budget);
> =20
>         work_done =3D rtl_rx(dev, tp, budget);
>=20
> [ 5055.978473] ------------[ cut here ]------------
> [ 5055.978503] rtl8169_poll: IRQs enabled!
> [ 5055.978527] WARNING: CPU: 15 PID: 0 at /home/ken/work/r8169/linux-so=
urce-6.6/drivers/net/ethernet/realtek/r8169_main.c:4604 rtl8169_poll+0x4e=
5/0x520 [r8169]
> [ 5055.978568] Modules linked in: r8169(OE) realtek mdio_devres libphy =
nft_chain_nat nf_nat bridge stp llc ip6t_REJECT nf_reject_ipv6 qrtr ipt_R=
EJECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 sunrpc nft_compat nf_tables libcrc32c nfnetlink binfmt_misc=
 joydev nls_ascii nls_cp437 vfat fat hid_generic usbhid hid amdgpu intel_=
rapl_msr intel_rapl_common intel_uncore_frequency snd_sof_pci_intel_tgl i=
ntel_uncore_frequency_common snd_sof_intel_hda_common x86_pkg_temp_therma=
l soundwire_intel intel_powerclamp soundwire_generic_allocation snd_sof_i=
ntel_hda_mlink coretemp iwlmvm soundwire_cadence kvm_intel snd_sof_intel_=
hda snd_sof_pci snd_sof_xtensa_dsp snd_sof kvm mac80211 snd_sof_utils snd=
_soc_hdac_hda snd_hda_ext_core irqbypass snd_soc_acpi_intel_match snd_soc=
_acpi libarc4 snd_hda_codec_realtek ghash_clmulni_intel snd_soc_core sha5=
12_ssse3 snd_hda_codec_generic drm_exec sha256_ssse3 amdxcp sha1_ssse3 le=
dtrig_audio drm_buddy iwlwifi gpu_sched snd_compress snd_hda_codec_hdmi s=
nd_pcm_dmaengine
> [ 5055.979159]  drm_suballoc_helper soundwire_bus drm_display_helper ae=
sni_intel snd_hda_intel cec crypto_simd cryptd snd_intel_dspcfg rc_core s=
nd_intel_sdw_acpi rapl snd_hda_codec mei_hdcp drm_ttm_helper mei_pxp pmt_=
telemetry intel_cstate cfg80211 evdev pmt_class snd_hda_core ttm snd_hwde=
p mei_me snd_pcm drm_kms_helper iTCO_wdt wmi_bmof intel_pmc_bxt snd_timer=
 intel_uncore snd iTCO_vendor_support i2c_algo_bit mei ee1004 mxm_wmi wat=
chdog pcspkr soundcore rfkill intel_vsec serial_multi_instantiate intel_p=
mc_core acpi_tad acpi_pad button drm nct6683 parport_pc ppdev lp parport =
loop configfs efi_pstore efivarfs ip_tables x_tables autofs4 ext4 crc16 m=
bcache jbd2 crc32c_generic dm_mod nvme ahci nvme_core libahci xhci_pci t1=
0_pi libata xhci_hcd crc64_rocksoft crc64 usbcore scsi_mod crc_t10dif i2c=
_i801 crc32_pclmul crct10dif_generic crct10dif_pclmul crc32c_intel i2c_sm=
bus video scsi_common usb_common fan crct10dif_common wmi pinctrl_alderla=
ke [last unloaded: r8169(OE)]
> [ 5055.979787] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W  OE =
     6.6.13+bpo-amd64 #1  Debian 6.6.13-1~bpo12+1
> [ 5055.979797] Hardware name: Micro-Star International Co., Ltd. MS-7D4=
3/PRO B660M-A WIFI DDR4 (MS-7D43), BIOS 1.E0 09/14/2023
> [ 5055.979803] RIP: 0010:rtl8169_poll+0x4e5/0x520 [r8169]
> [ 5055.979829] Code: 19 00 00 76 40 89 50 38 eb 98 80 3d 24 e2 00 00 00=
 0f 85 66 fb ff ff 48 c7 c7 7a d0 8d c0 c6 05 10 e2 00 00 01 e8 ab f6 fe =
f4 <0f> 0b e9 4c fb ff ff ba 40 00 00 00 88 50 38 e9 a5 fc ff ff 31 c0
> [ 5055.979836] RSP: 0018:ffffad4340618e88 EFLAGS: 00010286
> [ 5055.979846] RAX: 0000000000000000 RBX: ffff8f799b16c9e0 RCX: 0000000=
00000083f
> [ 5055.979853] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 0000000=
00000083f
> [ 5055.979859] RBP: ffff8f799b16c9e0 R08: 0000000000000000 R09: ffffad4=
340618d10
> [ 5055.979864] R10: 0000000000000003 R11: ffff8f80ff780228 R12: ffff8f7=
99b16c000
> [ 5055.979871] R13: 0000000000000040 R14: ffff8f799b16c9c0 R15: ffff8f7=
99b16c9e0
> [ 5055.979877] FS:  0000000000000000(0000) GS:ffff8f80df5c0000(0000) kn=
lGS:0000000000000000
> [ 5055.979884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5055.979890] CR2: 00007f0062503000 CR3: 00000004afc20000 CR4: 0000000=
000f50ee0
> [ 5055.979897] PKRU: 55555554
> [ 5055.979903] Call Trace:
> [ 5055.979911]  <IRQ>
> [ 5055.979916]  ? rtl8169_poll+0x4e5/0x520 [r8169]
> [ 5055.979940]  ? __warn+0x81/0x130
> [ 5055.979955]  ? rtl8169_poll+0x4e5/0x520 [r8169]
> [ 5055.979978]  ? report_bug+0x171/0x1a0
> [ 5055.979992]  ? handle_bug+0x41/0x70
> [ 5055.980004]  ? exc_invalid_op+0x17/0x70
> [ 5055.980014]  ? asm_exc_invalid_op+0x1a/0x20
> [ 5055.980026]  ? rtl8169_poll+0x4e5/0x520 [r8169]
> [ 5055.980048]  ? rtl8169_poll+0x4e5/0x520 [r8169]
> [ 5055.980070]  ? ktime_get+0x3c/0xa0
> [ 5055.980079]  ? sched_clock+0x10/0x30
> [ 5055.980090]  __napi_poll+0x28/0x1b0
> [ 5055.980104]  net_rx_action+0x2a4/0x380
> [ 5055.980116]  __do_softirq+0xc7/0x2ae
> [ 5055.980126]  __irq_exit_rcu+0x96/0xb0
> [ 5055.980139]  sysvec_apic_timer_interrupt+0x72/0x90
> [ 5055.980148]  </IRQ>
> [ 5055.980152]  <TASK>
> [ 5055.980156]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 5055.980167] RIP: 0010:cpuidle_enter_state+0xcc/0x440
> [ 5055.980179] Code: fa b6 53 ff e8 35 f4 ff ff 8b 53 04 49 89 c5 0f 1f=
 44 00 00 31 ff e8 43 c4 52 ff 45 84 ff 0f 85 57 02 00 00 fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [ 5055.980187] RSP: 0018:ffffad4340213e90 EFLAGS: 00000246
> [ 5055.980197] RAX: ffff8f80df5f3440 RBX: ffffcd433fbf2140 RCX: 0000000=
00000001f
> [ 5055.980203] RDX: 000000000000000f RSI: 000000003c9b26c9 RDI: 0000000=
000000000
> [ 5055.980208] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000=
000000012
> [ 5055.980214] R10: 0000000000000008 R11: ffff8f80df5f1fe4 R12: fffffff=
fb759a500
> [ 5055.980219] R13: 000004992fcca629 R14: 0000000000000004 R15: 0000000=
000000000
> [ 5055.980229]  cpuidle_enter+0x2d/0x40
> [ 5055.980238]  do_idle+0x20d/0x270
> [ 5055.980253]  cpu_startup_entry+0x2a/0x30
> [ 5055.980265]  start_secondary+0x11e/0x140
> [ 5055.980279]  secondary_startup_64_no_verify+0x18f/0x19b
> [ 5055.980294]  </TASK>
> [ 5055.980298] ---[ end trace 0000000000000000 ]---
>=20
>=20
> So to make the problem go away, I found that putting an unconditional c=
all to rtl_irq_disable() up front in rtl8169_poll() is sufficient.
> This seems a shame, since in almost every case, interrupts are already =
off at this point so it is an unnecessary write to the card.
>=20
> I assume it is rtl8169_interrupt() clearing the interrupt status regist=
er while something inside rtl8169_interrupt() is going on that causes the=
 problem, so this needs to be avoided.
> I tried moving the interrupt masking around inside rtl_tx() and rtl_rx(=
) to see if I could work out which specific place is vulnerable to the ra=
ce, but it was inconclusive.
>=20
In general there's nothing wrong with having interrupts enabled.
Disabling them is just an optimization. Seems like this scenario
triggers some silicon bug.

>=20
> The cheap hack below seems like a more performant solution than masking=
 interrupts unconditionally in the poll function:
> If a hardware interrupt comes in and NAPI_STATE_SCHED is set, we assume=
 we're either in the poll function already or it will be called again soo=
n, so we can safely disable interrupts.
> It has worked perfectly for me so far, although it doesn't prevent the =
poll function from *ever* getting called with interrupts on. I suspect it=
 will come apart with busy polling or the like.
>=20
> No doubt some sort of semaphore between the interrupt handler and poll =
function will be needed to decide who gets to disable interrupts.
> It would be great if NAPI had a "begin polling" upcall or something...
>=20
>=20
> diff --git linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c =
linux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
> index 81fd31f..60cf4f6 100644
> --- linux-source-6.6~/drivers/net/ethernet/realtek/r8169_main.c
> +++ linux-source-6.6/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4521,6 +4521,11 @@ release_descriptor:
>         return count;
>  }
> =20
> +static inline bool napi_is_scheduled(struct napi_struct *n)
> +{
> +       return test_bit(NAPI_STATE_SCHED, &n->state);
> +}
> +
>  static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
>         struct rtl8169_private *tp =3D dev_instance;
> @@ -4546,7 +4551,8 @@ static irqreturn_t rtl8169_interrupt(int irq, voi=
d *dev_instance)
>         if (napi_schedule_prep(&tp->napi)) {
>                 rtl_irq_disable(tp);
>                 __napi_schedule(&tp->napi);
> -       }
> +       } else if (napi_is_scheduled(&tp->napi))
> +               rtl_irq_disable(tp);

Re-reading &tp->napi may be racy, and I think the code delivers
a wrong result if NAPI_STATE_SCHEDand NAPI_STATE_DISABLE
both are set.

>  out:
>         rtl_ack_events(tp, status);

The following uses a modified version of napi_schedule_prep()
to avoid re-reading the napi state.
We would have to see whether this extension to the net core is
acceptable, as r8169 would be the only user for now.
For testing it's one patch, for submitting it would need to be
splitted.

---
 drivers/net/ethernet/realtek/r8169_main.c |  6 ++++--
 include/linux/netdevice.h                 |  7 ++++++-
 net/core/dev.c                            | 12 ++++++------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
index eb329f0ab..94b97a16d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void =
*dev_instance)
 {
 	struct rtl8169_private *tp =3D dev_instance;
 	u32 status =3D rtl_get_events(tp);
+	int ret;
=20
 	if ((status & 0xffff) =3D=3D 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
@@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, voi=
d *dev_instance)
 		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 	}
=20
-	if (napi_schedule_prep(&tp->napi)) {
+	ret =3D __napi_schedule_prep(&tp->napi);
+	if (ret >=3D 0)
 		rtl_irq_disable(tp);
+	if (ret > 0)
 		__napi_schedule(&tp->napi);
-	}
 out:
 	rtl_ack_events(tp, status);
=20
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 42b9e6dc6..3df560264 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -498,7 +498,12 @@ static inline bool napi_is_scheduled(struct napi_str=
uct *n)
 	return test_bit(NAPI_STATE_SCHED, &n->state);
 }
=20
-bool napi_schedule_prep(struct napi_struct *n);
+int __napi_schedule_prep(struct napi_struct *n);
+
+static inline bool napi_schedule_prep(struct napi_struct *n)
+{
+	return __napi_schedule_prep(n) > 0;
+}
=20
 /**
  *	napi_schedule - schedule NAPI poll
diff --git a/net/core/dev.c b/net/core/dev.c
index 4bf081c5a..126eab121 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6102,21 +6102,21 @@ void __napi_schedule(struct napi_struct *n)
 EXPORT_SYMBOL(__napi_schedule);
=20
 /**
- *	napi_schedule_prep - check if napi can be scheduled
+ *	__napi_schedule_prep - check if napi can be scheduled
  *	@n: napi context
  *
  * Test if NAPI routine is already running, and if not mark
  * it as running.  This is used as a condition variable to
- * insure only one NAPI poll instance runs.  We also make
- * sure there is no pending NAPI disable.
+ * insure only one NAPI poll instance runs. Return -1 if
+ * there is a pending NAPI disable.
  */
-bool napi_schedule_prep(struct napi_struct *n)
+int __napi_schedule_prep(struct napi_struct *n)
 {
 	unsigned long new, val =3D READ_ONCE(n->state);
=20
 	do {
 		if (unlikely(val & NAPIF_STATE_DISABLE))
-			return false;
+			return -1;
 		new =3D val | NAPIF_STATE_SCHED;
=20
 		/* Sets STATE_MISSED bit if STATE_SCHED was already set
@@ -6131,7 +6131,7 @@ bool napi_schedule_prep(struct napi_struct *n)
=20
 	return !(val & NAPIF_STATE_SCHED);
 }
-EXPORT_SYMBOL(napi_schedule_prep);
+EXPORT_SYMBOL(__napi_schedule_prep);
=20
 /**
  * __napi_schedule_irqoff - schedule for receive
--=20
2.45.0



