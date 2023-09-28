Return-Path: <netdev+bounces-36724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80F7B1770
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9DDE828166F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF480341AD;
	Thu, 28 Sep 2023 09:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE831A83
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 09:35:00 +0000 (UTC)
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 02:34:58 PDT
Received: from smtp1.lauterbach.com (smtp1.lauterbach.com [62.154.241.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A9198
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 02:34:57 -0700 (PDT)
Received: (qmail 24486 invoked by uid 484); 28 Sep 2023 09:28:15 -0000
X-Qmail-Scanner-Diagnostics: from amepc3.intern.lauterbach.com by smtp1.lauterbach.com (envelope-from <alexander.merkle@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.209):. 
 Processed in 0.358522 secs); 28 Sep 2023 09:28:15 -0000
Received: from amepc3.intern.lauterbach.com (HELO [10.2.10.209]) (Authenticated_SSL:amerkle@[10.2.10.209])
          (envelope-sender <alexander.merkle@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <nic_swsd@realtek.com>; 28 Sep 2023 09:28:14 -0000
Message-ID: <56c144a8-6526-80eb-91d7-9b36faa103c7@lauterbach.com>
Date: Thu, 28 Sep 2023 11:28:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Alexander Merkle <alexander.merkle@lauterbach.com>
Subject: Packets get stuck on RTL8111H using R8169 driver
To: nic_swsd@realtek.com, romieu@fr.zoreil.com
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,LOTS_OF_MONEY,
	MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I want to report a problem seen on my quite recent desktop machine using 
an onboard RTL8111H ethernet controller mounted on a ASUS X570-P 
motherboard.
I problem can be reproduced using
   - Debian Bookworm using Kernel `6.1.0-12-amd64` / `6.1.52-1`
   - Fedora Desktop 39 Beta using Kernel `6.5.5`
. In both cases we see that small ethernet packets e.g. ICMP/UDP seem to 
get stuck in the controller and are send out when there is other 
activity on the interface.

The simplest scenario to use is using `ping` in our office environment 
(active network). We used a quite powerful company core switch as ping 
target.
Using the R8169 driver the ping times are 2-3 times as high as using the 
r8168-dkms driver from debian (non-free). In numbers
   r8169: ~800-900us
   r8168: ~200-300us
.

Using our UDP based communication between host and device we see that 
UDP packets (especially small ones) are not send out and reach the 
device only when there is other activity on the ethernet link.
Using the r8169 driver we did a cross-check to evaluate our theory and 
using a `ping -f <powerful company core switch>`  as root running in 
background. With that cross-check applied we see that the delayed 
packets / UDP protocol resends are gone.

I will try to collect as much information as possible for you:
```
$ lspci
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
```
Device is labeled as: REALTEK 8111H L31ZY23GL15
```
# DMESG output using r8168 driver
pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
r8168: loading out-of-tree module taints kernel.
r8168: module verification failed: signature and/or required key missing 
- tainting kernel
r8168 Gigabit Ethernet driver 8.051.02-NAPI loaded
r8168: This product is covered by one or more of the following patents: 
US6,570,884, US6,115,776, and US6,327,625.
r8168  Copyright (C) 2022 Realtek NIC software team <nicfae@realtek.com>
r8168 0000:05:00.0 enp5s0: renamed from eth0
r8168: enp5s0: link up
# DMESG output using r8169 driver - mac address is removed
r8169 0000:05:00.0 eth0: RTL8168h/8111h, <mac address removed>, XID 541, 
IRQ 145
r8169 0000:05:00.0 eth0: jumbo features [frames: 9194 bytes, tx 
checksumming: ko]
r8169 0000:05:00.0 enp5s0: renamed from eth0
r8169 0000:05:00.0: firmware: direct-loading firmware rtl_nic/rtl8168h-2.fw
Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver 
(mii_bus:phy_addr=r8169-0-500:00, irq=MAC)
r8169 0000:05:00.0 enp5s0: Link is Down
r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow control off
```

Regards,

Alex

-- 
Alexander MERKLE
System Engineer
phone +49 8102 9876-147
alexander.merkle@lauterbach.com

Lauterbach Engineering GmbH & Co. KG
Altlaufstrasse 40
85635 Hoehenkirchen-Siegertsbrunn
GERMANY
www.lauterbach.com

Registered Office: Hoehenkirchen-Siegertsbrunn, Germany
Local Court: Munich, HRA 87406
VAT ID: DE246770537,
Managing Directors: Lothar Lauterbach, Stephan Lauterbach, Dr. Thomas Ullmann


