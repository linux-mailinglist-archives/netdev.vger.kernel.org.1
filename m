Return-Path: <netdev+bounces-28302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0DF77EF51
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E748281D5D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6E396;
	Thu, 17 Aug 2023 03:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358A36A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84487C433C7;
	Thu, 17 Aug 2023 03:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692241281;
	bh=7phDnGYx826GvanSoQeZamfWyjDOCTYwDSCr+faWOEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fyev4YU2bXD0gPmBxmqAEUKJk0RZCUHGLx8pLJ0I1GrTwND59H0gWwwOSpqBDoIRC
	 Gtn4PEsjY+Yq9ddrqOl1+B/9aYnkrjSx7ZBKzL4Bz3/YyoYc91x/108EXhxgb+AaM9
	 6E2AX1c6mBk0aByDVqG4/n1KYJZglKDZYU2wrMmVliNNmVMBehskbFSyH9TZmRuYTl
	 +lJQ++8aajG+tSurM5LDq7NobMY+E2tuJ0gRfNZZ402YnGxUTSQevXKczFw0FnTdRI
	 Zf8d8wOoIQ2Ma1BPC+5tvrA7D5Eb467+Hb6O5bEf1MhWAvTqcIJDAzNkNA2z6krmzD
	 rpKwufUR3u17A==
Date: Wed, 16 Aug 2023 20:01:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: netdev <netdev@vger.kernel.org>, Michael Chan
 <michael.chan@broadcom.com>
Subject: Re: [RFC] bnxt_en TX timeout detected, starting reset task,
 flapping link after
Message-ID: <20230816200120.603cc65a@kernel.org>
In-Reply-To: <CAMGffEm-OUf0UqeqCbcWM8j1q1EaSObEUGFPZqFsH4sKGkis8g@mail.gmail.com>
References: <CAMGffEm-OUf0UqeqCbcWM8j1q1EaSObEUGFPZqFsH4sKGkis8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2023 20:51:25 +0200 Jinpu Wang wrote:
> Hi Michael, and folks on the list.

It seems you meant to CC Michael.. adding him now.
I don't recall anything like this. Could be a bad system...

> We hit two case on two server but same kind of configuration with
> following symptom,
> error started with:
> kern.err: Aug 15 12:21:39 ps502b-104 kernel: [325978.631877] bnxt_en
> 0000:45:00.0 eth0: TX timeout detected, starting reset task!
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251006] bnxt_en
> 0000:45:00.0 eth0: [0]: tx{fw_ring: 0 prod: 1e7 cons: 1e4}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251009] bnxt_en
> 0000:45:00.0 eth0: [0]: rx{fw_ring: 1 prod: 135} rx_agg{fw_ring: 9
> agg_prod: 31f sw_agg_prod: 31f}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251010] bnxt_en
> 0000:45:00.0 eth0: [0]: cp{fw_ring: 0 raw_cons: 5a498f}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251012] bnxt_en
> 0000:45:00.0 eth0: [1]: tx{fw_ring: 1 prod: 190 cons: 190}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251013] bnxt_en
> 0000:45:00.0 eth0: [1]: rx{fw_ring: 2 prod: ae} rx_agg{fw_ring: 10
> agg_prod: cb sw_agg_prod: cb}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251014] bnxt_en
> 0000:45:00.0 eth0: [1]: cp{fw_ring: 16 raw_cons: 644dda}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251015] bnxt_en
> 0000:45:00.0 eth0: [2]: tx{fw_ring: 2 prod: af cons: 9b}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251016] bnxt_en
> 0000:45:00.0 eth0: [2]: rx{fw_ring: 3 prod: 1b2} rx_agg{fw_ring: 11
> agg_prod: 41c sw_agg_prod: 41c}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251017] bnxt_en
> 0000:45:00.0 eth0: [2]: cp{fw_ring: 17 raw_cons: 517b28}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251018] bnxt_en
> 0000:45:00.0 eth0: [3]: tx{fw_ring: 3 prod: 5e cons: 5e}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251020] bnxt_en
> 0000:45:00.0 eth0: [3]: rx{fw_ring: 4 prod: f8} rx_agg{fw_ring: 12
> agg_prod: 19d sw_agg_prod: 19d}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251021] bnxt_en
> 0000:45:00.0 eth0: [3]: cp{fw_ring: 18 raw_cons: 5283a5}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251022] bnxt_en
> 0000:45:00.0 eth0: [4]: tx{fw_ring: 4 prod: d4 cons: d2}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251023] bnxt_en
> 0000:45:00.0 eth0: [4]: rx{fw_ring: 5 prod: 185} rx_agg{fw_ring: 13
> agg_prod: 34f sw_agg_prod: 34f}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251024] bnxt_en
> 0000:45:00.0 eth0: [4]: cp{fw_ring: 19 raw_cons: 4dc622}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251024] bnxt_en
> 0000:45:00.0 eth0: [5]: tx{fw_ring: 5 prod: fd cons: fd}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251026] bnxt_en
> 0000:45:00.0 eth0: [5]: rx{fw_ring: 6 prod: 177} rx_agg{fw_ring: 14
> agg_prod: 47 sw_agg_prod: 47}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251026] bnxt_en
> 0000:45:00.0 eth0: [5]: cp{fw_ring: 20 raw_cons: 770efd}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251027] bnxt_en
> 0000:45:00.0 eth0: [6]: tx{fw_ring: 6 prod: 63 cons: 120}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251028] bnxt_en
> 0000:45:00.0 eth0: [6]: rx{fw_ring: 7 prod: 77} rx_agg{fw_ring: 15
> agg_prod: 7aa sw_agg_prod: 7aa}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251029] bnxt_en
> 0000:45:00.0 eth0: [6]: cp{fw_ring: 21 raw_cons: 1a42064}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251030] bnxt_en
> 0000:45:00.0 eth0: [7]: tx{fw_ring: 7 prod: 179 cons: 179}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251031] bnxt_en
> 0000:45:00.0 eth0: [7]: rx{fw_ring: 8 prod: 1f8} rx_agg{fw_ring: 16
> agg_prod: 785 sw_agg_prod: 786}
> kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251032] bnxt_en
> 0000:45:00.0 eth0: [7]: cp{fw_ring: 22 raw_cons: 9fd6e8}
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326018.695007] bnxt_en
> 0000:45:00.0 eth0: TX timeout detected, starting reset task!
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326019.874938] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326019.884991] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326020.749461] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326020.759434] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326021.623141] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326021.633040] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326022.495977] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326022.505635] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326023.368700] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326023.378155] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 2 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326023.423938] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44628
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326023.433163] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44636
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326023.442137] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44634
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326023.450759] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44632
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326023.459092] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44630
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326024.323820] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326024.331783] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 2 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326025.194675] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326025.202706] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 2 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326026.066879] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326026.074397] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 2 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326026.937134] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326026.944341] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 2 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326027.806175] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326027.813006] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 2 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326028.676645] bnxt_en
> 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326028.683506] bnxt_en
> 0000:45:00.0 eth0: hwrm_ring_free type 2 failed. rc:fffffff0 err:0
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326030.595581] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44644
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326030.602540] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44642
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326030.609230] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44650
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326030.615772] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44640
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326030.622094] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44648
> kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326030.628320] bnxt_en
> 0000:45:00.0 eth0: Invalid hwrm seq id 44646
> 
> it repeated for hours, until hard reboot the machine.
> In another cases, even after reboot once there is traffic the error
> occured again. we have to disable offload with ethtool, and then the
> system stabilizes.
> 
> sudo ethtool -K eth0 rx off tx off
> Actual changes:
> tx-checksum-ipv4: off
> tx-checksum-ipv6: off
> tx-tcp-segmentation: off [not requested]
> tx-tcp6-segmentation: off [not requested]
> rx-checksum: off
> rx-gro-hw: off [not requested]
> 
> Our env:
> sudo ethtool -i eth0
> driver: bnxt_en
> version: 5.10.136-pserver
> firmware-version: 218.0.153.0/pkg 218.0.169.0
> expansion-rom-version:
> bus-info: 0000:45:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: no
> 
> sudo lspci  -vvv -s 45:00.0
> 45:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57416
> NetXtreme-E Dual-Media 10G RDMA Ethernet Controller (rev 01)
> DeviceName: Broadcom 10G Ethernet #1
> Subsystem: Super Micro Computer Inc BCM57416 NetXtreme-E Dual-Media
> 10G RDMA Ethernet Controller
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 64
> Region 0: Memory at 380d0110000 (64-bit, prefetchable) [size=64K]
> Region 2: Memory at 380d0000000 (64-bit, prefetchable) [size=1M]
> Region 4: Memory at 380d0122000 (64-bit, prefetchable) [size=8K]
> Expansion ROM at b3b40000 [disabled] [size=256K]
> Capabilities: [48] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
> Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> Address: 0000000000000000  Data: 0000
> Capabilities: [a0] MSI-X: Enable+ Count=255 Masked-
> Vector table: BAR=4 offset=00000000
> PBA: BAR=4 offset=00000ff0
> Capabilities: [ac] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
> ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75.000W
> DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
> RlxdOrd+ ExtTag+ PhantFunc- AuxPwr+ NoSnoop+ FLReset-
> MaxPayload 512 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM not supported
> ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 8GT/s (ok), Width x8 (ok)
> TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS- TPHComp- ExtTPHComp-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
> AtomicOpsCtl: ReqEn-
> LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
> EqualizationPhase1+
> EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
> Retimer- 2Retimers- CrosslinkRes: unsupported
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO+ CmpltAbrt- UnxCmplt+ RxOF+
> MalfTLP+ ECRC+ UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn+ ECRCChkCap+ ECRCChkEn+
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> HeaderLog: 04008001 4000200f 45020000 00000000
> Capabilities: [13c v1] Device Serial Number 3c-ec-ef-ff-fe-91-5c-92
> Capabilities: [150 v1] Power Budgeting <?>
> Capabilities: [160 v1] Virtual Channel
> Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=Fixed
> Status: InProgress-
> VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
> Status: NegoPending- InProgress-
> Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 Len=020 <?>
> Capabilities: [1b0 v1] Latency Tolerance Reporting
> Max snoop latency: 1048576ns
> Max no snoop latency: 1048576ns
> Capabilities: [1b8 v1] Alternative Routing-ID Interpretation (ARI)
> ARICap: MFVC- ACS-, Next Function: 1
> ARICtl: MFVC- ACS-, Function Group: 0
> Capabilities: [230 v1] Transaction Processing Hints
> Interrupt vector mode supported
> Device specific mode supported
> Steering table in MSI-X table
> Capabilities: [300 v1] Secondary PCI Express
> LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> LaneErrStat: 0
> Capabilities: [200 v1] Precision Time Measurement
> PTMCap: Requester:+ Responder:- Root:-
> PTMClockGranularity: Unimplemented
> PTMControl: Enabled:- RootSelected:-
> PTMEffectiveGranularity: Unknown
> Kernel driver in use: bnxt_en
> Kernel modules: bnxt_en
> 
> 
> 
> 
> I checked git history, but can't find any bugfix related to it. The
> internet tells me it could be a
> firmware bug, but I can't find firmware from Broadcom site or supermicro site.
> 
> Can you please give me some suggestions?
> 
> Thx!
> Jinpu Wang @ IONOS Cloud


