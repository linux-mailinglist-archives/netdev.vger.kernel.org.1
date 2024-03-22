Return-Path: <netdev+bounces-81235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21421886B5E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD3B21121
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F1A3F8F4;
	Fri, 22 Mar 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lagy.org header.i=@lagy.org header.b="0X9XT1Od"
X-Original-To: netdev@vger.kernel.org
Received: from anon.cephalopo.net (anon.cephalopo.net [93.160.30.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF11CAA3
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.160.30.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107441; cv=none; b=kjkYmPF4a3SL2+7z7YYOgVCv4crkyr9L1FXoFVfsp/14caetgbkx84qsl8WDsuXb9PFQ60KNIujoRnfnaMUNngJJmBYKWbSHGX8UtKuvj/t6R54OWch68wYLKrsqPEK0AvpoUdvzxwVx5nkjQOmWv8p5+eWCxWI+a4/tyFaFXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107441; c=relaxed/simple;
	bh=EpV+2auLGiT5DoiJ9WDyccd2f6KqAEBSeNxRIgOv5Bo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=rJEn6wxH+avcvyOph5HrSQyfwkJhFMBAqr5WeBK+shztzYJDZpozLrZFVOfHzerLUV0I1MOh3bvlBEJc+KdGbXLDg5M9nhfJEVVM/2eHSZq14p6SYp76yLWi6K/IH/apRHMn0ZXtLauoJDG/y77MHBjSMWTG93lVVXe4bbdT8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lagy.org; spf=pass smtp.mailfrom=lagy.org; dkim=pass (2048-bit key) header.d=lagy.org header.i=@lagy.org header.b=0X9XT1Od; arc=none smtp.client-ip=93.160.30.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lagy.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 4V1KsN2VtTz1xp2;
	Fri, 22 Mar 2024 11:31:20 +0000 (UTC)
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.mailfrom=me@lagy.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lagy.org; s=def2;
	t=1711107080; x=1711711880;
	bh=hWOd3VtPkjTk4jFbwiVUDrhW8ZQNZwtjnzAMioV96/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:From:To:Reply-To:
	 Cc:Message-ID:Subject:Date;
	b=0X9XT1OdA5aiLJWq9OYQnaszF1Hdp9UXwS28w8tYbp7S6MFtfqFLD6kwKXjk5qsZp
	 9BZMXBYHsHBF6Ybu9UBWFE6cd6y9r9dpffZRwnFNR+oZvimgQjHc1HWpm9X9sboA6r
	 kRfd8mBupz2r6VKtdwk6gtFsUW5I7IQheeSuJUSsCmm3WX0e32P8EVI2NK8zcIEZUq
	 cr2qPfiM5hypEU/mhE7TsmVCD4P1JYVjycXhjZHPMPyrNq/ACljeet9D4WtyaQoRHE
	 KPEtqfOBDoQEJE/QWnF9/SMvqpuUWDupNzMWDpnMqa6gah8LieLC2uLh6UEOHkwRET
	 SGbZJugLpx9FQ==
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87a5taabs9.fsf@mkjws.danelec-net.lan>
 <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
 <87y1guv5p7.fsf@mkjws.danelec-net.lan>
 <e391ca3b-c3e8-478a-a771-2554b8b828c0@gmail.com> <87ttriqmru.fsf@ws.c.lan>
 <b0e2f6fb-2a1b-4452-bf49-739a30925fde@gmail.com>
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 nic_swsd@realtek.com
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Fri, 22 Mar 2024 12:28:54 +0100
In-reply-to: <b0e2f6fb-2a1b-4452-bf49-739a30925fde@gmail.com>
Message-ID: <871q82fqpk.fsf@lagy.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 25.09.2023 17:41, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>
>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>>> On 25.09.2023 13:30, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>>>
>>>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>>
>>>> There are no PCI extension cards.
>>>>
>>>
>>> Your BIOS signature indicates that the system is a Thinkstation P350.
>>> According to the Lenovo website it comes with one Intel-based network p=
ort.
>>> However you have additional 4 Realtek-based network ports on the mainbo=
ard?
>>>
>>
>> Yes. 2 PCIE cards with two Realtek ethernet controllers each.
>>
>>>>> And does the problem occur with all of your NICs?
>>>>
>>>> No, only the Realtek ones.
>>>>
>>>>> The exact NIC type might provide a hint, best provide a full dmesg lo=
g.
>>>> [ 1512.295490] RSP: 0018:ffffbc0240193e88 EFLAGS: 00000246
>>>> [ 1512.295492] RAX: ffff998935680000 RBX: ffffdc023faa8e00 RCX: 000000=
000000001f
>>>> [ 1512.295493] RDX: 0000000000000002 RSI: ffffffffb544f718 RDI: ffffff=
ffb543bc32
>>>> [ 1512.295494] RBP: 0000000000000003 R08: 0000000000000000 R09: 000000=
0000000018
>>>> [ 1512.295495] R10: ffff9989356b1dc4 R11: 00000000000058a8 R12: ffffff=
ffb5d981a0
>>>> [ 1512.295496] R13: 000001601bd198ef R14: 0000000000000003 R15: 000000=
0000000000
>>>> [ 1512.295497]  ? cpuidle_enter_state+0xbd/0x440
>>>> [ 1512.295499]  cpuidle_enter+0x2d/0x40
>>>> [ 1512.295501]  do_idle+0x217/0x270
>>>> [ 1512.295503]  cpu_startup_entry+0x1d/0x20
>>>> [ 1512.295505]  start_secondary+0x11a/0x140
>>>> [ 1512.295508]  secondary_startup_64_no_verify+0x17e/0x18b
>>>> [ 1512.295510]  </TASK>
>>>> [ 1512.295511] ---[ end trace 0000000000000000 ]---
>>>> [ 1512.295526] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have=
 ASPM control
>>>> [ 1531.322039] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1534.138489] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1538.177385] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1566.174660] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1567.839082] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1570.621088] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1576.294267] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have=
 ASPM control
>>>
>>> Regarding the following: Issue occurs after few seconds of link-loss.
>>> Was this an intentional link-down event?
>>
>> Yes, I intentionally unplug the cable at the other end for the link to g=
o down.
>>
>>> And is issue always related to link-up after a link-loss period?
>>>
>>
>> Yes, it happends after cable is plugged in again, so after a link-loss p=
eriod.
>>
> Good to know. I heard this before, under unknown circumstances (Realtek d=
oesn't publish
> errata information) the NIC (unclear whether MAC or PHY) seems to hang up=
 after link-loss
> in rare cases. Vendor driver does a full hw init on each link-up, maybe t=
his is to work
> around the issue we talk about here.
>
>>
>>>> [ 1488.643231] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1506.576941] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1512.295215] ------------[ cut here ]------------
>>>> [ 1512.295219] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed=
 out 5368 ms

I am seeing the behavior again with latest 6.6.21 kernel. Like last time, it
helps to manually shutdown and bring up the interface with 'ip link enp4s0
down/up'


[243277.859725] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow c=
ontrol off
[243283.400061] ------------[ cut here ]------------
[243283.400063] NETDEV WATCHDOG: enp4s0 (r8169): transmit queue 0 timed out=
 5537 ms
[243283.400070] WARNING: CPU: 3 PID: 2909804 at net/sched/sch_generic.c:525=
 dev_watchdog+0x225/0x230
[243283.400073] Modules linked in: tls nfnetlink_queue nfnetlink_log blueto=
oth ecdh_generic ecc xt_nat xt_tcpudp veth xt_conntrack xt_MASQUERADE nf_co=
nntrack_netlink iptable_nat xt_addrtype iptable_filter ip_tables x_tables b=
pfilter br_netfilter overlay authenc echainiv geniv crypto_null esp4 xfrm_i=
nterface xfrm6_tunnel tunnel4 tunnel6 cmac xfrm_user xfrm_algo nls_utf8 cif=
s cifs_arc4 nls_ucs2_utils rdma_cm iw_cm ib_cm ib_core cifs_md4 dns_resolve=
r fscache netfs snd_seq_dummy snd_hrtimer snd_seq af_packet bridge stp llc =
cfg80211 rfkill nft_fib_ipv6 nft_nat nft_fib_ipv4 nft_fib nft_masq nft_chai=
n_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c=
 nls_ascii nls_cp437 vfat fat intel_rapl_msr coretemp intel_rapl_common x86=
_pkg_temp_thermal intel_powerclamp ofpart cmdlinepart snd_usb_audio spi_nor=
 iTCO_wdt intel_pmc_bxt kvm_intel mei_wdt snd_usbmidi_lib iTCO_vendor_suppo=
rt mei_pxp mei_hdcp ee1004 mtd watchdog snd_hwdep r8169 snd_ump kvm snd_raw=
midi realtek uvcvideo snd_seq_device snd_pcm mdio_devres
[243283.400109]  videobuf2_vmalloc irqbypass of_mdio uvc videobuf2_memops f=
ixed_phy snd_timer videobuf2_v4l2 think_lmi intel_cstate rtsx_usb_ms fwnode=
_mdio intel_uncore memstick e1000e rtc_cmos videodev mei_me ftdi_sio firmwa=
re_attributes_class joydev snd videobuf2_common i2c_i801 ptp spi_intel_pci =
libphy intel_wmi_thunderbolt wmi_bmof mei mc tiny_power_button pps_core spi=
_intel i2c_smbus usbserial soundcore mousedev thermal fan input_leds int340=
0_thermal acpi_thermal_rel intel_pmc_core acpi_tad acpi_pad evdev button ma=
c_hid sch_fq_codel msr loop fuse efi_pstore nfnetlink efivarfs dmi_sysfs dm=
_crypt trusted asn1_encoder tee ext4 crc32c_generic crc16 mbcache jbd2 hid_=
logitech_hidpp hid_logitech_dj hid_jabra hid_generic rtsx_usb_sdmmc mmc_cor=
e led_class usbhid hid rtsx_usb crc32_pclmul crc32c_intel polyval_clmulni p=
olyval_generic gf128mul ghash_clmulni_intel i915 sha512_ssse3 sha256_ssse3 =
sha1_ssse3 xhci_pci ahci xhci_pci_renesas nvme libahci xhci_hcd nvme_core l=
ibata nvme_common i2c_algo_bit drm_buddy t10_pi ttm usbcore
[243283.400142]  crc64_rocksoft_generic aesni_intel drm_display_helper scsi=
_mod crc64_rocksoft crc_t10dif crct10dif_generic crct10dif_pclmul cec hwmon=
 crypto_simd crc64 rc_core cryptd crct10dif_common usb_common scsi_common 8=
250 8250_base video serial_mctrl_gpio serial_base wmi backlight dm_mod dax
[243283.400150] CPU: 3 PID: 2909804 Comm: python3.11 Not tainted 6.6.21-gen=
too-desktop-r1 #1
[243283.400152] Hardware name: LENOVO 30E30051UK/1052, BIOS S0AKT3EA 09/22/=
2023
[243283.400153] RIP: 0010:dev_watchdog+0x225/0x230
[243283.400154] Code: ff ff ff 48 89 ef c6 05 08 6c ee 00 01 e8 03 94 fa ff=
 45 89 f8 44 89 f1 48 89 ee 48 89 c2 48 c7 c7 98 c4 37 9a e8 8b 5c 79 ff <0=
f> 0b e9 27 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[243283.400155] RSP: 0000:ffffc9000f3e3df8 EFLAGS: 00010292
[243283.400156] RAX: 0000000000000043 RBX: ffff88810b6f841c RCX: 0000000000=
000027
[243283.400157] RDX: ffff8890356e04c8 RSI: 0000000000000001 RDI: ffff889035=
6e04c0
[243283.400158] RBP: ffff88810b6f8000 R08: 0000000000000000 R09: ffffffff9a=
646ce0
[243283.400158] R10: ffffc9000f3e3cb0 R11: ffffffff9a726d28 R12: ffff88810b=
6f84c8
[243283.400159] R13: ffff88810b6e6800 R14: 0000000000000000 R15: 0000000000=
0015a1
[243283.400159] FS:  00007fb111f89740(0000) GS:ffff8890356c0000(0000) knlGS=
:0000000000000000
[243283.400160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[243283.400161] CR2: 00007fb1041fb030 CR3: 000000044b576002 CR4: 0000000000=
770ee0
[243283.400162] PKRU: 55555554
[243283.400162] Call Trace:
[243283.400163]  <TASK>
[243283.400164]  ? dev_watchdog+0x225/0x230
[243283.400165]  ? __warn+0x7c/0x130
[243283.400168]  ? dev_watchdog+0x225/0x230
[243283.400169]  ? report_bug+0x171/0x1a0
[243283.400172]  ? handle_bug+0x3a/0x70
[243283.400174]  ? exc_invalid_op+0x17/0x70
[243283.400175]  ? asm_exc_invalid_op+0x1a/0x20
[243283.400178]  ? dev_watchdog+0x225/0x230
[243283.400179]  ? dev_watchdog+0x225/0x230
[243283.400180]  ? __pfx_dev_watchdog+0x10/0x10
[243283.400181]  ? __pfx_dev_watchdog+0x10/0x10
[243283.400182]  call_timer_fn+0x1f/0x130
[243283.400184]  __run_timers.part.0+0x1bc/0x250
[243283.400186]  ? ktime_get+0x34/0xa0
[243283.400187]  run_timer_softirq+0x25/0x50
[243283.400188]  __do_softirq+0xbd/0x296
[243283.400190]  irq_exit_rcu+0x65/0x80
[243283.400191]  sysvec_apic_timer_interrupt+0x3e/0x90
[243283.400192]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[243283.400194] RIP: 0033:0x7fb111bd3cd5
[243283.400195] Code: c8 48 8b 56 08 48 83 c6 08 48 85 d2 75 a7 48 85 c0 74=
 05 48 39 c3 75 09 49 8b 47 10 48 89 44 24 10 48 85 ed 0f 85 8e 00 00 00 <4=
9> 8b 40 28 49 8b 4f 18 48 39 48 18 75 5d 49 8b 85 58 01 00 00 49
[243283.400196] RSP: 002b:00007ffd3916a9b0 EFLAGS: 00000246
[243283.400196] RAX: 00007fb111bd73c0 RBX: 000056339f603f78 RCX: 00007fb111=
f66aa8
[243283.400197] RDX: 0000000000000000 RSI: 00007fb111f04360 RDI: 00007fb111=
f66aa8
[243283.400197] RBP: 0000000000000000 R08: 00007fb10410c270 R09: 00007fb111=
f66aa0
[243283.400198] R10: 8d3a98eb5e44a685 R11: 1ffffffffffffffe R12: 00007ffd39=
16a9d4
[243283.400198] R13: 000056339f603eb0 R14: 00000000000000c8 R15: 00007fb111=
e0dcc0
[243283.400199]  </TASK>
[243283.400200] ---[ end trace 0000000000000000 ]---
[243283.400216] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASP=
M control
[243295.067251] r8169 0000:04:00.0 enp4s0: Link is Down
[243297.620960] RTL8226 2.5Gbps PHY r8169-0-400:00: attached PHY driver (mi=
i_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
[243297.752106] r8169 0000:04:00.0 enp4s0: Link is Down
[243300.656125] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow c=
ontrol off

