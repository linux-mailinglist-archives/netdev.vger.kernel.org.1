Return-Path: <netdev+bounces-84089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D737789584B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642C61F22340
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50E131742;
	Tue,  2 Apr 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b="/VpQanhh";
	dkim=pass (2048-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b="eK6IXJSY"
X-Original-To: netdev@vger.kernel.org
Received: from gagc1.tesaguri.club (gagc1.tesaguri.club [172.93.166.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF284FCD
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.93.166.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072046; cv=none; b=UaTUUV6vkfACASn4Wtp4+3aH4i9fFXmHhDwYntC0ihHLPF+TXeMB+T5faIvfcshVHjL5YRIu6YzFWGcUU9Pbbh9lxepTaSQHET3QJZr9nokjC75iYi0bxyGfAuREjDso1LPU6v2Gna4fWe0lk7avbWiiG0tyO3+DExIO0IOln3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072046; c=relaxed/simple;
	bh=hxjUV//WZTwC5c3i8IlHpU/uffIdeYmbg9xWX4S22dI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rFjq2SU+IpbSGB1f+c0ncew4pM5LdMzlUQt/yh6P3p24xuNVSwJ2bXc1Hl4ULBMVcdiTVVeWnPq6OopGvYGqMuO7QZB9dFsNKqQqGukQIy7w7bUsm3dByVmKF0AJITFqMGuTAGMb+nXNB1GsocGLX7wbA/r9N14OuJQTvZdiyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesaguri.club; spf=pass smtp.mailfrom=tesaguri.club; dkim=permerror (0-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b=/VpQanhh; dkim=pass (2048-bit key) header.d=tesaguri.club header.i=@tesaguri.club header.b=eK6IXJSY; arc=none smtp.client-ip=172.93.166.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesaguri.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesaguri.club
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tesaguri.club;
	s=ed25519; t=1712071728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUyWlBVcCe03nTY4au22mPyG0NDOm6Immc4NwvOcwss=;
	b=/VpQanhhSpVOWTl+9bJfovdPF1BH7cUx78l07U4WlsWNePX853LeZ+LiA2Y6tX9HlArN0L
	/WloY+pj8yrLmsDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesaguri.club;
	s=rsa; t=1712071728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUyWlBVcCe03nTY4au22mPyG0NDOm6Immc4NwvOcwss=;
	b=eK6IXJSYnYm/5geuPvDZbiIO5UAGGWlP8M90hubOYgX/KGBdb4OeFAX9Z9Hbjo9wj0gJT9
	hxa8sG0HCZGwvCaovOhhLcnvDYfMJTMUnUIbmkjcT3emlh0kvLxDamUYQMDvZwfBKLQQe/
	FyqCxvD8nhRbu5RBlD3ZMtdiKPSk5K4ObIzlX+nrc60EXwMi6yyEkGfRqv4dfjMWa/mWnF
	S9ooDxXlif9kkWrkkyGmlow/6KKzD///lEfPSBjO+118oNlEtxCWEwVzeAe11T68lshUHs
	1VEGH1UqwxWoEnkYfS1YuB25ixSoary7GEPzThtN+4GL7XcPo83hgn7wbToqJA==
Date: Tue, 02 Apr 2024 11:28:48 -0400
From: shironeko@tesaguri.club
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell
 <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
In-Reply-To: <20230717152917.751987-1-edumazet@google.com>
References: <20230717152917.751987-1-edumazet@google.com>
Message-ID: <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
X-Sender: shironeko@tesaguri.club
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

These parts seems to be causing a regression for a specific USB NIC, I 
have this on one of home server, and it's network will randomly cut out 
a few times a week.
Seems others have ran into the same issue with this particular NIC as 
well https://bugzilla.kernel.org/show_bug.cgi?id=218536

> +/* inverse of tcp_win_from_space() */
> +static inline int tcp_space_from_win(const struct sock *sk, int win)
> +{
> +	u64 val = (u64)win << TCP_RMEM_TO_WIN_SCALE;
> +
> +	do_div(val, tcp_sk(sk)->scaling_ratio);
> +	return val;
> +}
> +
> +static inline void tcp_scaling_ratio_init(struct sock *sk)
> +{
> +	/* Assume a conservative default of 1200 bytes of payload per 4K 
> page.
> +	 * This may be adjusted later in tcp_measure_rcv_mss().
> +	 */
> +	tcp_sk(sk)->scaling_ratio = (1200 << TCP_RMEM_TO_WIN_SCALE) /
> +				    SKB_TRUESIZE(4096);
>  }
...
> @@ -740,12 +750,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
>  		do_div(grow, tp->rcvq_space.space);
>  		rcvwin += (grow << 1);
> 
> -		rcvmem = SKB_TRUESIZE(tp->advmss + MAX_TCP_HEADER);
> -		while (tcp_win_from_space(sk, rcvmem) < tp->advmss)
> -			rcvmem += 128;
> -
> -		do_div(rcvwin, tp->advmss);
> -		rcvbuf = min_t(u64, rcvwin * rcvmem,
> +		rcvbuf = min_t(u64, tcp_space_from_win(sk, rcvwin),
>  			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
>  		if (rcvbuf > sk->sk_rcvbuf) {
>  			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);

The NIC:
usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
usb 2-2: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 
1.00
usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-2: Product: AX88179
usb 2-2: Manufacturer: ASIX Elec. Corp.
usb 2-2: SerialNumber: 0000000000009D
ax88179_178a 2-2:1.0 eth0: register 'ax88179_178a' at 
usb-0000:00:14.0-2, ASIX AX88179 USB 3.0 Gigabit Ethernet, 
02:5e:c0:4b:a4:f7
ax88179_178a 2-2:1.0 eth0: ax88179 - Link status is: 1

The dmesg error I get:
divide error: 0000 [#1] PREEMPT SMP PTI
CPU: 6 PID: 2737 Comm: bitmagnet Tainted: P           OE      
6.8.0-76060800daily20240311-generic 
#202403110203~1711393930~22.04~331756a
Hardware name: Dell Inc. XPS 15 9560/05FFDN, BIOS 1.31.0 11/10/2022
RIP: 0010:tcp_rcv_space_adjust+0xbe/0x170
Code: f8 41 89 d0 29 d0 31 d2 49 0f af c2 49 f7 f0 45 8b 81 f0 02 00 00 
44 0f b6 8b ae 05 00 00 31 d2 49 8d 04 42 48 98 48 c1 e0 08 <49> f7 f1 
49 63 d0 48 98 48 39 d0 48 0f 47 c2 39 83 18 01 00 00 7c
RSP: 0018:ffffba4b07657ba0 EFLAGS: 00010206
RAX: 0000000001217e00 RBX: ffff948b6e0565c0 RCX: 000000002f2775fe
RDX: 0000000000000000 RSI: 000000007ee9298e RDI: 000000000000414f
RBP: ffffba4b07657ba8 R08: 0000000000600000 R09: 0000000000000000
R10: 000000000000dd1e R11: 0000000000000000 R12: ffff948b6e0565c0
R13: ffff948b6e056698 R14: 0000000000000000 R15: ffff948b6e056b70
FS:  00007a12d929db38(0000) GS:ffff9491de500000(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000078cc12cfd000 CR3: 0000000157d54005 CR4: 00000000003706f0
Call Trace:
  <TASK>
  ? show_regs+0x6d/0x80
  ? die+0x37/0xa0
  ? do_trap+0xd4/0xf0
  ? do_error_trap+0x71/0xb0
  ? tcp_rcv_space_adjust+0xbe/0x170
  ? exc_divide_error+0x3a/0x70
  ? tcp_rcv_space_adjust+0xbe/0x170
  ? asm_exc_divide_error+0x1b/0x20
  ? tcp_rcv_space_adjust+0xbe/0x170
  tcp_recvmsg_locked+0x2d4/0x9c0
  tcp_recvmsg+0x84/0x200
  inet_recvmsg+0x54/0x140
  ? security_socket_recvmsg+0x44/0x80
  sock_recvmsg+0xc6/0xf0
  sock_read_iter+0x8f/0x100
  vfs_read+0x347/0x390
  ksys_read+0xc9/0x100
  __x64_sys_read+0x19/0x30
  do_syscall_64+0x76/0x140
  ? do_syscall_64+0x85/0x140
  ? syscall_exit_to_user_mode+0x8e/0x1e0
  ? do_syscall_64+0x85/0x140
  ? do_syscall_64+0x85/0x140
  ? do_syscall_64+0x85/0x140
  ? do_syscall_64+0x85/0x140
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x4087ee
Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc cc cc cc cc cc 
cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 
f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
RSP: 002b:000000c0023a2560 EFLAGS: 00000212 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000086 RCX: 00000000004087ee
RDX: 00000000000007f4 RSI: 000000c002b9d03c RDI: 0000000000000086
RBP: 000000c0023a25a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 00007a12d929d8e8
R13: 0000000000000001 R14: 000000c0021a2380 R15: 0000000000000007
  </TASK>
Modules linked in: tls xt_mark xt_nat veth nft_chain_nat xt_MASQUERADE 
nf_nat nf_conntrack_netlink xfrm_user xfrm_algo br_netfilter bridge stp 
llc rfcomm snd_seq_dummy snd_hrtimer cmac algif_hash overlay 
algif_skcipher af_alg bnep zstd zram nvidia_uvm(POE) ip6t_REJECT 
nf_reject_ipv6 xt_hl intel_uncore_frequency 
intel_uncore_frequency_common ip6t_rt intel_tcc_cooling ipt_REJECT 
nf_reject_ipv4 snd_hda_codec_hdmi xt_LOG nf_log_syslog xt_comment 
xt_multiport snd_ctl_led nft_limit snd_soc_avs snd_soc_hda_codec 
snd_hda_ext_core snd_soc_core snd_hda_codec_realtek 
snd_hda_codec_generic snd_compress ac97_bus snd_pcm_dmaengine 
x86_pkg_temp_thermal intel_powerclamp xt_limit xt_addrtype xt_tcpudp 
joydev snd_hda_intel nvidia_drm(POE) coretemp nvidia_modeset(POE) 
snd_intel_dspcfg snd_intel_sdw_acpi xt_conntrack snd_hda_codec 
nf_conntrack snd_hda_core nf_defrag_ipv6 nf_defrag_ipv4 nft_compat 
snd_hwdep dell_laptop snd_pcm nf_tables snd_seq_midi snd_seq_midi_event 
nfnetlink binfmt_misc snd_rawmidi ath10k_pci snd_seq
  ath10k_core kvm_intel uvcvideo ath snd_seq_device nls_iso8859_1 
dm_crypt mei_wdt mei_pxp mei_hdcp intel_rapl_msr nvidia(POE) dell_wmi 
dell_smm_hwmon bfq kvm input_leds snd_timer videobuf2_vmalloc irqbypass 
dell_smbios mac80211 uvc videobuf2_memops videobuf2_v4l2 dcdbas btusb 
iTCO_wdt rapl snd btrtl ledtrig_audio videodev hid_multitouch 
intel_pmc_bxt btintel ee1004 iTCO_vendor_support intel_cstate btbcm 
intel_wmi_thunderbolt soundcore serio_raw 
processor_thermal_device_pci_legacy wmi_bmof dell_wmi_descriptor btmtk 
mxm_wmi cfg80211 videobuf2_common bluetooth processor_thermal_device 
processor_thermal_wt_hint processor_thermal_rfim mc libarc4 
processor_thermal_rapl ecdh_generic ecc mei_me intel_rapl_common mei 
processor_thermal_wt_req processor_thermal_power_floor 
processor_thermal_mbox intel_pch_thermal intel_soc_dts_iosf 
intel_pmc_core intel_vsec pmt_telemetry dell_smo8800 intel_hid 
int3400_thermal int3403_thermal pmt_class int340x_thermal_zone 
acpi_thermal_rel acpi_pad mac_hid sparse_keymap tcp_bbr
  sch_cake kyber_iosched msr parport_pc ppdev lp parport efi_pstore 
ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy 
async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 
system76_io(OE) system76_acpi(OE) i915 ax88179_178a crct10dif_pclmul 
crc32_pclmul usbnet drm_buddy polyval_clmulni mii polyval_generic 
i2c_algo_bit ghash_clmulni_intel hid_generic rtsx_pci_sdmmc nvme ttm 
sha256_ssse3 sha1_ssse3 psmouse drm_display_helper i2c_i801 i2c_smbus 
nvme_core intel_lpss_pci cec ahci rtsx_pci intel_lpss nvme_auth xhci_pci 
libahci idma64 i2c_hid_acpi xhci_pci_renesas rc_core i2c_hid hid video 
wmi aesni_intel crypto_simd cryptd
---[ end trace 0000000000000000 ]---
RIP: 0010:tcp_rcv_space_adjust+0xbe/0x170
Code: f8 41 89 d0 29 d0 31 d2 49 0f af c2 49 f7 f0 45 8b 81 f0 02 00 00 
44 0f b6 8b ae 05 00 00 31 d2 49 8d 04 42 48 98 48 c1 e0 08 <49> f7 f1 
49 63 d0 48 98 48 39 d0 48 0f 47 c2 39 83 18 01 00 00 7c
RSP: 0018:ffffba4b07657ba0 EFLAGS: 00010206
RAX: 0000000001217e00 RBX: ffff948b6e0565c0 RCX: 000000002f2775fe
RDX: 0000000000000000 RSI: 000000007ee9298e RDI: 000000000000414f
RBP: ffffba4b07657ba8 R08: 0000000000600000 R09: 0000000000000000
R10: 000000000000dd1e R11: 0000000000000000 R12: ffff948b6e0565c0
R13: ffff948b6e056698 R14: 0000000000000000 R15: ffff948b6e056b70
FS:  00007a12d929db38(0000) GS:ffff9491de500000(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000078cc12cfd000 CR3: 0000000157d54005 CR4: 00000000003706f0

