Return-Path: <netdev+bounces-141304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274A9BA69E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CA6B20D16
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07099183CBE;
	Sun,  3 Nov 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=falix.de header.i=@falix.de header.b="H8lb6lno"
X-Original-To: netdev@vger.kernel.org
Received: from mail.falix.de (mail.falix.de [37.120.163.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7317BEA4
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.163.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650694; cv=none; b=e8J5W7xD2Kx0ciC7q3eslpWOlxIknfA3/uZQZ401I2sdaZRUI6VxzA2Hrtz885VsCtBKLExi4L9+9nq8vxxFq7dEV6T6O2iur+4/02ND6tuCq3sa/BC4OTYySLgrq0OgI/ZTMzMWINj/YGa4ZZBF6NypihU9IutzsUzwmopVpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650694; c=relaxed/simple;
	bh=nQYn6gFGl9woROxHe/Gi2jSjHjIlAquR2tgY5Nvt2ZY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pu8TSTrXKIgdS27fLGNKmQD/WN5sEIFcoDN441RvgX0daBuKCdWe4EdxCCvOh5USAa/Lkr6edgEDLQILdRr5pqOkE0zrIB/GJSNEp+mN4COJckJOKeU4uMHLRMo1aFhN19swCAcroiXvW7wsdN+VtPE6MFUjc36P3ll1Y8W+9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=falix.de; spf=pass smtp.mailfrom=falix.de; dkim=pass (2048-bit key) header.d=falix.de header.i=@falix.de header.b=H8lb6lno; arc=none smtp.client-ip=37.120.163.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=falix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=falix.de
Received: from [192.168.221.20] (ppp-82-135-68-177.dynamic.mnet-online.de [82.135.68.177])
	by mail.falix.de (Postfix) with ESMTPSA id 238DF6123A;
	Sun, 03 Nov 2024 17:08:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=falix.de;
	s=trustedmail; t=1730650103;
	bh=nQYn6gFGl9woROxHe/Gi2jSjHjIlAquR2tgY5Nvt2ZY=;
	h=Subject:From:To:Cc:Date;
	b=H8lb6lnoOby4fu+9cIVktlR7mflljQqvE6w5e2OKSXl6GhlKp/0sj9+2OdMPi9Dvu
	 9+xc9z4gP8h68EarqEXb0A23UbNJ8FvgiftEPq6HRPHzD/CEnCoTRZcC+mTEWDeS6g
	 3gvFsiJSA4HYkLbmFhPRENYLIFRXFFuYuC/2KUn/slae8EI9wocFL0sDWZR3H00p+s
	 LoE8naXNlGVgIUY3ywXswzm8mtcYgReDUtKTYbfnB1XIawZI9Rl2+XlFDNKuUJcQwm
	 oJLWNx58uS3JK6ORLkxxVXAfbX700lXWkidMNKoBBpxWIi0t1rqRQHvvIl0i72DSlG
	 Sw5jkWNTsY6zA==
Message-ID: <ff6d9c69c2a09de5baf2f01f25e3faf487278dbb.camel@falix.de>
Subject: r8169: regression in connection speed with kernels 6.2+ (interrupt
 coalescing)
From: Felix Braun <f.braun@falix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Date: Sun, 03 Nov 2024 17:08:22 +0100
Organization: Vectrix -- Legal Dept.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi there,

commit 42f66a44d83715bef810a543dfd66008b883a7a5 to Linus' kernel tree ("r81=
69: enable GRO software interrupt coalescing per default") introduces a spe=
ed regression on my hardware. With that commit applied I get net throughput=
 of 10.5 MB/s, without that commit I get around 100 MB/s on my setup.

I've verified that just commenting out the one line in r8169_main.c

```
--- a/drivers/net/ethernet/realtek/r8169_main.c =20
+++ b/drivers/net/ethernet/realtek/r8169_main.c =20
@@ -5505,6 +5505,8 @@ static int rtl_init_one(struct pci_dev *pdev, const s=
truct pci_device_id *ent) =20
dev->hw_features |=3D NETIF_F_RXALL; =20
dev->hw_features |=3D NETIF_F_RXFCS;

dev->pcpu_stat_type =3D NETDEV_PCPU_STAT_TSTATS;

- netdev_sw_irq_coalesce_default_on(dev); =20
+ //netdev_sq_irq_coalesc_default_on(dev);

/* configure chip for default features */ =20
rtl8169_set_features(dev, dev->features);
```

restores the speed with kernel 6.11.6. Is there perhaps a more elegant way =
to fix this regression for other people too?

Regards =20
Felix

This is my lspci -vvxx output:

```
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
DeviceName: Onboard - RTK Ethernet
Subsystem: ASRock Incorporation Motherboard (one of many)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppin=
g- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <=
MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 20
IOMMU group: 11
Region 0: I/O ports at e000 [size=3D256]
Region 2: Memory at a1204000 (64-bit, non-prefetchable) [size=3D4K]
Region 4: Memory at a1200000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [70] Express (v2) Endpoint, IntMsgNum 1
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W TEE-IO-
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unl=
imited, L1 <64us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS- TPHComp- ExtTPHComp-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
AtomicOpsCtl: ReqEn-
IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS=
-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Complianc=
eSOS-
Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- Equalizatio=
nPhase1-
EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
Retimer- 2Retimers- CrosslinkRes: unsupported
Capabilities: [b0] MSI-X: Enable+ Count=3D4 Masked-
Vector table: BAR=3D4 offset=3D00000000
PBA: BAR=3D4 offset=3D00000800
Capabilities: [100 v2] Advanced Error Reporting
UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBloc=
kedErr-
PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatB=
locked-
UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq+ ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBloc=
kedErr-
PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatB=
locked-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBloc=
kedErr-
PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatB=
locked-
CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntE=
rr- HeaderOF-
CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntE=
rr+ HeaderOF-
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChk=
En-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [140 v1] Virtual Channel
Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
Arb:    Fixed- WRR32- WRR64- WRR128-
Ctrl:   ArbSelect=3DFixed
Status: InProgress-
VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
Status: NegoPending- InProgress-
Capabilities: [160 v1] Device Serial Number 39-79-71-c2-85-70-00-00
Capabilities: [170 v1] Latency Tolerance Reporting
Max snoop latency: 3145728ns
Max no snoop latency: 3145728ns
Capabilities: [178 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
PortCommonModeRestoreTime=3D150us PortTPowerOnTime=3D150us
L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
T_CommonMode=3D0us LTR1.2_Threshold=3D163840ns
L1SubCtl2: T_PwrOn=3D150us
Kernel driver in use: r8169
Kernel modules: r8169
00: ec 10 68 81 07 04 10 00 15 00 00 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 40 20 a1 00 00 00 00
20: 04 00 20 a1 00 00 00 00 00 00 00 00 49 18 68 81
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
```

