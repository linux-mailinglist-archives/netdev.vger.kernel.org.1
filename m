Return-Path: <netdev+bounces-51110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E17F9245
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 11:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561BF280DDA
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8037BEC2;
	Sun, 26 Nov 2023 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISD1Jhmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E39C110
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 02:35:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b397793aaso11860895e9.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 02:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700994923; x=1701599723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfMI7DwSf5pfn/E6EqwJCYMvI+RxctmGbv2feElJ1dU=;
        b=ISD1JhmgjxlXW9UVZMuRzd1aarGHbEoo9L/SqT72xi4IBnBV32mAc9Tk6bhxGWUF/F
         +c9Tydt3mYU8va7XnGUh7EElj34idQjNgmC/xlzn6jbt0S3LJGTHmdWg1/p+tEDu8DUi
         dDjio+M+a6NZJ9ChyuLL+C0gpla8p8jXskG5+/WE/Qn0txP+GFjjRvk5iHBE/5HKjsHM
         eqHwbtPYSCXuMvdhNVXngmSuJeqoc753VY9aOzKV2J1RjaZkVE/uuHrJIEAr91LE3AWY
         +89kJhnEPhfWMbHMQ5/VcdjQz8jYYn5hd21Gf++nT7ZVXw3ccydWIXMty92w9NUzjYp2
         IzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700994923; x=1701599723;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfMI7DwSf5pfn/E6EqwJCYMvI+RxctmGbv2feElJ1dU=;
        b=I1gcUe0sp2IKfNb81/Zj+m1IoKnitsciN+fBgzu1TREjl67XV8mLp88ob7uzIcDQAd
         iGtE6J5bij+QfUCcuiZR2reBuFvOcxDLW1vyaR8EJaFFjatg/3cbCJUVjlapBk9P4TeA
         o1nvSw9bauvKNtTRcviBY2nQQZsNkFggFdDQTbPUFUaPnBJQwBustDUQAubE2Rp/dnm4
         7IKZa9XakEV+l24bYcp/QSJWuYLHYM+slW6HNAh4DRZiD113JAYMdd/nLUVSDiEr/yhc
         6fQilR2bUod7QHgvWcTJ5hv7WdW5a+TpBMfMLXsFYjY680lLTHT1skRIEENvBlk1x+YJ
         HsIQ==
X-Gm-Message-State: AOJu0Yy8sgfZzhspen+QbpXfM0wLyooEpcCUuV2NVZAENHnhPZneEHSk
	S31M6yxoZI/0LrIXovDR4TYB9339lPY=
X-Google-Smtp-Source: AGHT+IFXx7w7YbhgMAhZl2Be7c/mzDOXYpiE2EUJ0KiEpPzzbyF+BfBbG4kw56H78U0tNCBnduUMcg==
X-Received: by 2002:a05:600c:1c19:b0:40b:34bb:10ce with SMTP id j25-20020a05600c1c1900b0040b34bb10cemr10209183wms.13.1700994922447;
        Sun, 26 Nov 2023 02:35:22 -0800 (PST)
Received: from ?IPV6:2a01:c23:c42d:f800:9d4a:26da:56c3:eb86? (dynamic-2a01-0c23-c42d-f800-9d4a-26da-56c3-eb86.c23.pool.telefonica.de. [2a01:c23:c42d:f800:9d4a:26da:56c3:eb86])
        by smtp.googlemail.com with ESMTPSA id bg9-20020a05600c3c8900b0040836519dd9sm10012552wmb.25.2023.11.26.02.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:35:21 -0800 (PST)
Message-ID: <aa06a22e-7056-4ac9-8830-fd05c85250e5@gmail.com>
Date: Sun, 26 Nov 2023 11:35:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux kernel 6.6.2: Dragon RTL8125BG network card stopped working
Content-Language: en-US
To: Gregor Mlakar <turok256@gmail.com>
References: <CANy-wRkkBwjGoBhKFDYhw7K_=xH853PTsv-oU0d8jXtmf7PcDQ@mail.gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CANy-wRkkBwjGoBhKFDYhw7K_=xH853PTsv-oU0d8jXtmf7PcDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26.11.2023 02:46, Gregor Mlakar wrote:
> Hello,
> 
> network card (Dragon RTL8125BG) on my motherboard (B650E Steel Legend WiFi) has stopped working on Arch Linux distribution with linux kernel 6.6.2 (both normal and zen kernel). If I revert back to kernel 6.6.1 it works fine. When I try to reboot, the PC gets stuck at line saying "watchdog did not stop!".
> 
> Motherboard:
> https://www.asrock.com/mb/AMD/B650E%20Steel%20Legend%20WiFi/index.asp#Specification <https://www.asrock.com/mb/AMD/B650E%20Steel%20Legend%20WiFi/index.asp#Specification>
> 
> dmesg (the last part with call trace keeps repeating every 122s):
> 
>     [    7.612105] r8169 0000:09:00.0 eth0: RTL8125B, xx:xx:xx:xx:xx:xx, XID 641, IRQ 116
>     [    7.612109] r8169 0000:09:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
>     [    7.659150] r8169 0000:09:00.0 enp9s0: renamed from eth0
>     [    7.708638] cryptd: max_cpu_qlen set to 1000
>     [    7.726830] Bluetooth: Core ver 2.22
>     [    7.726844] NET: Registered PF_BLUETOOTH protocol family
>     [    7.726846] Bluetooth: HCI device and connection manager initialized
>     [    7.726848] Bluetooth: HCI socket layer initialized
>     [    7.726850] Bluetooth: L2CAP socket layer initialized
>     [    7.726853] Bluetooth: SCO socket layer initialized
>     [    7.726939] mc: Linux media interface: v0.10
>     [    7.730916] AVX2 version of gcm_enc/dec engaged.
>     [    7.730959] AES CTR mode by8 optimization enabled
>     [    7.741154] usbcore: registered new interface driver btusb
>     [    7.752863] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: xxxxxxxxxxxxxx
>     [    7.829804] kvm_amd: TSC scaling supported
>     [    7.829806] kvm_amd: Nested Virtualization enabled
>     [    7.829807] kvm_amd: Nested Paging enabled
>     [    7.829813] kvm_amd: Virtual VMLOAD VMSAVE supported
>     [    7.829813] kvm_amd: Virtual GIF supported
>     [    7.829814] kvm_amd: Virtual NMI enabled
>     [    7.829814] kvm_amd: LBR virtualization supported
>     [    7.837383] MCE: In-kernel MCE decoding enabled.
>     [    7.925523] intel_rapl_common: Found RAPL domain package
>     [    7.925525] intel_rapl_common: Found RAPL domain core
>     [    8.164594] usbcore: registered new interface driver snd-usb-audio
>     [    8.274455] cfg80211: Loading compiled-in X.509 certificates for regulatory database
>     [    8.274596] Loaded X.509 cert 'sforshee: xxxxxxxxxxxxxxxxxx'
>     [    8.274694] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
>     [    8.274697] cfg80211: failed to load regulatory.db
>     [    8.310577] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-900:00: attached PHY driver (mii_bus:phy_addr=r8169-0-900:00, irq=MAC)
>     [   29.331343] Bluetooth: hci0: Device setup in 21084167 usecs
>     [   29.331347] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
>     [   29.604845] Bluetooth: hci0: AOSP extensions version v1.00
>     [   29.604847] Bluetooth: hci0: AOSP quality report is supported
>     [  198.084608] firefox[969]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
>     [  245.487028] INFO: task kworker/u66:4:261 blocked for more than 122 seconds.
>     [  245.487033]       Not tainted 6.6.2-arch1-1 #1
>     [  245.487034] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     [  245.487035] task:kworker/u66:4   state:D stack:0     pid:261   ppid:2      flags:0x00004000
>     [  245.487039] Workqueue: events_power_efficient phy_state_machine [libphy]
>     [  245.487051] Call Trace:
>     [  245.487052]  <TASK>
>     [  245.487054]  __schedule+0x3e8/0x1410
>     [  245.487058]  ? sysvec_apic_timer_interrupt+0xe/0x90
>     [  245.487063]  schedule+0x5e/0xd0
>     [  245.487065]  schedule_preempt_disabled+0x15/0x30
>     [  245.487067]  __mutex_lock.constprop.0+0x39a/0x6a0
>     [  245.487071]  phy_start_aneg+0x1d/0x40 [libphy 93248cd1d88abf54f1b4cc64a990177f549a7710]
>     [  245.487081]  rtl_reset_work+0x1bd/0x3b0 [r8169 08653ab60f23923c3943d53f140b2b697e265b93]
>     [  245.487087]  r8169_phylink_handler+0x5b/0x240 [r8169 08653ab60f23923c3943d53f140b2b697e265b93]
>     [  245.487091]  phy_link_change+0x2e/0x60 [libphy 93248cd1d88abf54f1b4cc64a990177f549a7710]
>     [  245.487101]  phy_check_link_status+0xad/0xe0 [libphy 93248cd1d88abf54f1b4cc64a990177f549a7710]
>     [  245.487110]  phy_state_machine+0x80/0x2c0 [libphy 93248cd1d88abf54f1b4cc64a990177f549a7710]
>     [  245.487119]  process_one_work+0x171/0x340
>     [  245.487123]  worker_thread+0x27b/0x3a0
>     [  245.487125]  ? __pfx_worker_thread+0x10/0x10
>     [  245.487126]  kthread+0xe5/0x120
>     [  245.487129]  ? __pfx_kthread+0x10/0x10
>     [  245.487131]  ret_from_fork+0x31/0x50
>     [  245.487134]  ? __pfx_kthread+0x10/0x10
>     [  245.487135]  ret_from_fork_asm+0x1b/0x30
>     [  245.487141]  </TASK>
> 
> 
> lspci:
> 
>     09:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
>     Subsystem: ASRock Incorporation RTL8125 2.5GbE Controller
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 40
>     IOMMU group: 1
>     Region 0: I/O ports at e000 [size=256]
>     Region 2: Memory at fca00000 (64-bit, non-prefetchable) [size=64K]
>     Region 4: Memory at fca10000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [40] Power Management version 3
>     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>     Address: 0000000000000000  Data: 0000
>     Masking: 00000000  Pending: 00000000
>     Capabilities: [70] Express (v2) Endpoint, MSI 01
>     DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>     ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 26W
>     DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>     RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>     MaxPayload 256 bytes, MaxReadReq 4096 bytes
>     DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>     LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
>     ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>     LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>     ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>     LnkSta: Speed 5GT/s, Width x1
>     TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>     DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>     10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
>     EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>     FRS- TPHComp+ ExtTPHComp-
>     AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>     DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled,
>     AtomicOpsCtl: ReqEn-
>     LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
>     LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>     Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>     Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>     LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>     EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>     Retimer- 2Retimers- CrosslinkRes: unsupported
>     Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-
>     Vector table: BAR=4 offset=00000000
>     PBA: BAR=4 offset=00000800
>     Capabilities: [d0] Vital Product Data
>     pcilib: sysfs_read_vpd: read failed: No such device
>     Not readable
>     Capabilities: [100 v2] Advanced Error Reporting
>     UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>     UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>     UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>     CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>     CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>     AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>     MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>     HeaderLog: 00000000 00000000 00000000 00000000
>     Capabilities: [148 v1] Virtual Channel
>     Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
>     Arb: Fixed- WRR32- WRR64- WRR128-
>     Ctrl: ArbSelect=Fixed
>     Status: InProgress-
>     VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>     Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>     Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>     Status: NegoPending- InProgress-
>     Capabilities: [168 v1] Device Serial Number xx-xx-xx-xx-xx-xx-xx-xx
>     Capabilities: [178 v1] Transaction Processing Hints
>     No steering table available
>     Capabilities: [204 v1] Latency Tolerance Reporting
>     Max snoop latency: 0ns
>     Max no snoop latency: 0ns
>     Capabilities: [20c v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>      PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=306176ns
>     L1SubCtl2: T_PwrOn=150us
>     Capabilities: [21c v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
>     Kernel driver in use: r8169
>     Kernel modules: r8169
> 
> 
> Best regards,
> Gregor Mlakar


Thanks for the report. A very similar, or even same, issue has been reported already.
Are you using a jumbo mtu?
Could you please test whether the following fixes the issue for you?

---
 drivers/net/ethernet/realtek/r8169_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0aed99a20..e32cc3279 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -575,6 +575,7 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
@@ -4494,6 +4495,8 @@ static void rtl_task(struct work_struct *work)
 reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
+	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
+		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4527,7 +4530,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	} else {
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_reset_work(tp);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
 		pm_runtime_idle(d);
 	}
 
@@ -4603,7 +4606,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	cancel_work_sync(&tp->wk.work);
+	cancel_work(&tp->wk.work);
 
 	free_irq(tp->irq, tp);
 
-- 
2.43.0




