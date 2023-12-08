Return-Path: <netdev+bounces-55190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A8809C2D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 07:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A809EB20A2B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378847475;
	Fri,  8 Dec 2023 06:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 22:10:27 PST
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E110FC
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 22:10:27 -0800 (PST)
Received: (qmail 31727 invoked by uid 5089); 8 Dec 2023 06:03:44 -0000
Received: by simscan 1.2.0 ppid: 31626, pid: 31627, t: 0.4375s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 8 Dec 2023 06:03:43 -0000
Message-ID: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
Date: Fri, 8 Dec 2023 14:03:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Richard Tresidder <rtresidd@electromag.com.au>
Subject: STMMAC Ethernet Driver support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi
    I'm having a problem when checksum offloading in transmit is enabled.
The Mac is in an Altera Cyclone V SOC.
compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";

Previous working revision was a 6.3.3 based kernel.
Current testing version is a 6.6.3 LongTerm branch.
None of our patches touch anything in network, just a few custom drivers 
for HDL built in the FPGA.

The 6.3.3 iteration of the STMMAC worked fine out of the box.
And appears to be using Checksum Offload in TX according to the dma_cap 
dump from debugfs.

For the 6.6.3 based driver I was seeing bad CRC's on any tcp data 
transmitted from the MAC, icmp was fine.

I manually disabled the tx_coe cap by setting:
dma_cap->tx_coe = 0;
in dwmac1000_dma.c at about line 258 in lieu of (hw_cap & 
DMA_HW_FEAT_TXCOESEL) >> 16;

This got the interface working.

I've looked through the diffset 6.3.3 >>> 6.6.3 on the driver
drivers\net\ethernet\stmicro\stmmac
But nothing is jumping out at me.

I could use a pointer as to where to look to start tracing this.

Cheers
    Richard Tresidder

