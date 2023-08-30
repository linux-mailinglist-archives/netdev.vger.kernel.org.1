Return-Path: <netdev+bounces-31438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4F78D7D4
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 19:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116F71C20429
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184E7479;
	Wed, 30 Aug 2023 17:30:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A26AA3
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 17:30:47 +0000 (UTC)
X-Greylist: delayed 1226 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 10:30:45 PDT
Received: from good-out-06.clustermail.de (good-out-06.clustermail.de [IPv6:2a02:708:0:2c::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B103193
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 10:30:45 -0700 (PDT)
Received: from [10.0.0.15] (helo=frontend.clustermail.de)
	by smtpout-02.clustermail.de with esmtp (Exim 4.96)
	(envelope-from <Daniel.Klauer@gin.de>)
	id 1qbOhh-0007iI-23;
	Wed, 30 Aug 2023 19:10:06 +0200
Received: from [217.6.33.237] (helo=Win2012-02.gin-domain.local)
	by frontend.clustermail.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Daniel.Klauer@gin.de>)
	id 1qbOhi-0007kc-0z;
	Wed, 30 Aug 2023 19:10:06 +0200
Received: from [10.176.8.48] (10.176.8.48) by Win2012-02.gin-domain.local
 (10.160.128.12) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 30 Aug
 2023 19:10:05 +0200
Message-ID: <30428046-fe1a-be57-1df6-2830bd33a385@gin.de>
Date: Wed, 30 Aug 2023 19:10:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Daniel Klauer <daniel.klauer@gin.de>
Subject: [bug] dpaa2-eth: "Wrong SWA type" and null deref in
 dpaa2_eth_free_tx_fd()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.176.8.48]
X-ClientProxiedBy: Win2012-02.gin-domain.local (10.160.128.12) To
 Win2012-02.gin-domain.local (10.160.128.12)
X-EsetResult: clean, is OK
X-EsetId: 37303A29342AAB59637C67
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

while doing Ethernet tests with raw packet sockets on our custom LX2160A board with Linux v6.1.50 (plus some patches for board support, but none for dpaa2-eth), I noticed the following crash:

[   26.290737] Wrong SWA type
[   26.290760] WARNING: CPU: 7 PID: 0 at drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:1117 dpaa2_eth_free_tx_fd.isra.0+0x36c/0x380 [fsl_dpaa2_eth]

followed by

[   26.323016] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
[   26.324122] Mem abort info:
[   26.324475]   ESR = 0x0000000096000004
[   26.324948]   EC = 0x25: DABT (current EL), IL = 32 bits
[   26.325618]   SET = 0, FnV = 0
[   26.326004]   EA = 0, S1PTW = 0
[   26.326406]   FSC = 0x04: level 0 translation fault
[   26.327021] Data abort info:
[   26.327385]   ISV = 0, ISS = 0x00000004
[   26.327869]   CM = 0, WnR = 0
[   26.328244] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020861cf000
[   26.329055] [0000000000000028] pgd=0000000000000000, p4d=0000000000000000
[   26.329912] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   26.330702] Modules linked in: tag_dsa marvell mv88e6xxx aes_ce_blk caam_jr aes_ce_cipher caamhash_desc crct10dif_ce ghash_ce fsl_dpaa2_eth caamalg_desc xhci_plat_hcd sha256_generic gf128mul libsha256 libaes xhci_hcd crypto_engine pcs_lynx sha2_ce sha1_ce usbcore libdes sha256_arm64 cfg80211 dp83867 sha1_generic fsl_mc_dpio xgmac_mdio dpaa2_console dwc3 ahci ahci_qoriq udc_core caam libahci_platform roles error libahci usb_common libata at24 lm90 qoriq_thermal nvmem_layerscape_sfp sfp mdio_i2c
[   26.336237] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W          6.1.50-00121-g10168a070f4d #11
[   26.337396] Hardware name: mpxlx2160a (DT)
[   26.337956] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   26.338833] pc : dpaa2_eth_free_tx_fd.isra.0+0xd4/0x380 [fsl_dpaa2_eth]
[   26.339673] lr : dpaa2_eth_free_tx_fd.isra.0+0xb4/0x380 [fsl_dpaa2_eth]
[   26.340512] sp : ffff800008cf3d70
[   26.340931] x29: ffff800008cf3d70 x28: ffff002002900000 x27: 0000000000000000
[   26.341832] x26: 0000000000000001 x25: 0000000000000001 x24: 0000000000000000
[   26.342732] x23: 0000000000002328 x22: ffff002009742728 x21: 00000020884fffc2
[   26.343633] x20: ffff002009740840 x19: ffff0020084fffc2 x18: 0000000000000018
[   26.344534] x17: ffff8026b3a9a000 x16: ffff800008cf0000 x15: fffffffffffed3f8
[   26.345435] x14: 0000000000000000 x13: ffff800008bad028 x12: 0000000000000966
[   26.346335] x11: 0000000000000322 x10: ffff800008c09b58 x9 : ffff800008bad028
[   26.347236] x8 : 0001000000000000 x7 : ffff0020095e6480 x6 : 00000020884fffc2
[   26.348137] x5 : ffff0020095e6480 x4 : 0000000000000000 x3 : 0000000000000000
[   26.349037] x2 : 00000000e7e00000 x1 : 0000000000000001 x0 : 0000000049759e0c
[   26.349938] Call trace:
[   26.350247]  dpaa2_eth_free_tx_fd.isra.0+0xd4/0x380 [fsl_dpaa2_eth]
[   26.351044]  dpaa2_eth_tx_conf+0x84/0xc0 [fsl_dpaa2_eth]
[   26.351720]  dpaa2_eth_poll+0xec/0x3a4 [fsl_dpaa2_eth]
[   26.352375]  __napi_poll+0x34/0x180
[   26.352816]  net_rx_action+0x128/0x2b4
[   26.353290]  _stext+0x124/0x2a0
[   26.353687]  ____do_softirq+0xc/0x14
[   26.354139]  call_on_irq_stack+0x24/0x40
[   26.354635]  do_softirq_own_stack+0x18/0x2c
[   26.355164]  __irq_exit_rcu+0xc4/0xf0
[   26.355628]  irq_exit_rcu+0xc/0x14
[   26.356059]  el1_interrupt+0x34/0x60
[   26.356511]  el1h_64_irq_handler+0x14/0x20
[   26.357028]  el1h_64_irq+0x64/0x68
[   26.357458]  cpuidle_enter_state+0x12c/0x314
[   26.357997]  cpuidle_enter+0x34/0x4c
[   26.358450]  do_idle+0x208/0x270
[   26.358860]  cpu_startup_entry+0x24/0x30
[   26.359356]  secondary_start_kernel+0x128/0x14c
[   26.359928]  __secondary_switched+0x64/0x68
[   26.360460] Code: 7100081f 54000d00 71000c1f 540000c0 (3940a360) 
[   26.361228] ---[ end trace 0000000000000000 ]---

It happens when receiving big Ethernet frames on a AF_PACKET + SOCK_RAW socket, for example MTU 9000. It does not happen with the standard MTU 1500. It does not happen when just sending.

It's 100% reproducible here, however it seems to depend on the data rate/load: Once it happened after receiving the first 80 frames, another time after the first 300 frames, etc., and if I only send 5 frames per second, it does not happen at all.

Please let me know if I should provide more info or do more tests. I can provide a test program if needed.

Kind regards,
Daniel

