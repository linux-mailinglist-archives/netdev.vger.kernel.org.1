Return-Path: <netdev+bounces-43316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0467D2588
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 20:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB11C20895
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821111CAA;
	Sun, 22 Oct 2023 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NLcw0Phf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDD613C
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 18:55:30 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Oct 2023 11:55:28 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998A112
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 11:55:28 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EA8302CDD51
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 18:48:19 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3BFE3340068
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 18:48:18 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.115.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A96FD13C2B0
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 11:48:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A96FD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1698000497;
	bh=hO7wcIl6kn8IxGtbcSWGpPLRJkwhuX/t88PZ7hmqPrg=;
	h=To:From:Subject:Date:From;
	b=NLcw0Phfmt566FHhVVYMb+9KklCEqrY41mEn3ybll061mhvCeMjLaLrog5mX6C+CO
	 c9HAWZHUIM5O8EAU1Q6upZbU3u+dHk7RX+QQXJOvXLiKIw8rfyZxSx6/HFoI7O/e1R
	 wPdXdbMZzd5CfP+5e7zTMbJGhcMDvO66qIFbvvKY=
To: netdev <netdev@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: swiotlb dyn alloc WARNING splat in wireless-next.
Organization: Candela Technologies
Message-ID: <4f173dd2-324a-0240-ff8d-abf5c191be18@candelatech.com>
Date: Sun, 22 Oct 2023 11:48:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1698000498-1C2Kh2qKRmPH
X-MDID-O:
 us5;ut7;1698000498;1C2Kh2qKRmPH;<greearb@candelatech.com>;0590461a9946a11a9d6965a08c2b2857

Hello,

I saw this in a system with 16GB of RAM running a lot of wifi traffic
on 16 radios.  System appears to mostly be working OK, so not sure if it is
a real problem or not.

[76171.488627] WARNING: CPU: 2 PID: 30169 at mm/page_alloc.c:4402 __alloc_pages+0x19c/0x200
[76171.488634] Modules linked in: tls nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 bpfilter vrf 8021q garp mrp stp llc macvlan 
pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 iTCO_vendor_support snd_hda_codec_hdmi 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common iwlmvm intel_tcc_cooling x86_pkg_temp_thermal mt7921e intel_powerclamp 
mt7921_common mt792x_lib mt76_connac_lib kvm_intel snd_hda_intel mt76 snd_intel_dspcfg snd_hda_codec snd_hda_core mac80211 kvm snd_hwdep iwlwifi snd_seq 
irqbypass snd_seq_device pcspkr cfg80211 snd_pcm intel_wmi_thunderbolt i2c_i801 i2c_smbus snd_timer bfq tpm_crb snd soundcore mei_hdcp mei_pxp tpm_tis 
tpm_tis_core intel_pch_thermal tpm acpi_pad nfsd auth_rpcgss nfs_acl lockd grace sch_fq_codel sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov 
async_memcpy async_pq async_xor xor async_tx raid6_pq i915 igb i2c_algo_bit drm_buddy intel_gtt drm_display_helper
[76171.488690]  drm_kms_helper cec rc_core ttm drm agpgart ixgbe mdio dca xhci_pci hwmon mei_wdt xhci_pci_renesas i2c_core video wmi [last unloaded: nfnetlink]
[76171.488701] CPU: 2 PID: 30169 Comm: kworker/2:2 Not tainted 6.6.0-rc5+ #13
[76171.488704] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[76171.488705] Workqueue: events swiotlb_dyn_alloc
[76171.488708] RIP: 0010:__alloc_pages+0x19c/0x200
[76171.488711] Code: ff ff 00 0f 84 56 ff ff ff 80 ce 01 e9 4e ff ff ff 83 fe 0a 0f 86 db fe ff ff 80 3d ba c9 4a 01 00 75 09 c6 05 b1 c9 4a 01 01 <0f> 0b 45 31 
e4 e9 4f ff ff ff a9 00 00 08 00 75 43 89 d9 80 e1 7f
[76171.488713] RSP: 0018:ffffc9000babfd78 EFLAGS: 00010246
[76171.488714] RAX: 0000000000000000 RBX: 0000000000000cc4 RCX: 0000000000000000
[76171.488716] RDX: 0000000000000000 RSI: 000000000000000e RDI: 0000000000000cc4
[76171.488717] RBP: 000000000000000e R08: 0000000000000000 R09: 0000000000000000
[76171.488718] R10: ffff88811ff99000 R11: 0000000000000000 R12: ffff888110070400
[76171.488719] R13: 0000000000000000 R14: 0000000003ffffff R15: ffff8881100586b0
[76171.488720] FS:  0000000000000000(0000) GS:ffff88845dc80000(0000) knlGS:0000000000000000
[76171.488722] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[76171.488723] CR2: 0000000003519000 CR3: 0000000002634004 CR4: 00000000003706e0
[76171.488725] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[76171.488726] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[76171.488727] Call Trace:
[76171.488729]  <TASK>
[76171.488730]  ? __alloc_pages+0x19c/0x200
[76171.488732]  ? __warn+0x78/0x130
[76171.488736]  ? __alloc_pages+0x19c/0x200
[76171.488738]  ? report_bug+0x169/0x1a0
[76171.488742]  ? handle_bug+0x41/0x70
[76171.488744]  ? exc_invalid_op+0x13/0x60
[76171.488747]  ? asm_exc_invalid_op+0x16/0x20
[76171.488751]  ? __alloc_pages+0x19c/0x200
[76171.488753]  swiotlb_alloc_pool+0x102/0x280
[76171.488756]  swiotlb_dyn_alloc+0x2a/0xa0
[76171.488757]  process_one_work+0x15d/0x330
[76171.488759]  worker_thread+0x2e8/0x400
[76171.488762]  ? drain_workqueue+0x120/0x120
[76171.488763]  kthread+0xdc/0x110
[76171.488766]  ? kthread_complete_and_exit+0x20/0x20
[76171.488769]  ret_from_fork+0x28/0x40
[76171.488771]  ? kthread_complete_and_exit+0x20/0x20
[76171.488774]  ret_from_fork_asm+0x11/0x20
[76171.488778]  </TASK>
[76171.488778] ---[ end trace 0000000000000000 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

