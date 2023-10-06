Return-Path: <netdev+bounces-38612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD47BBAA6
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD41C2099E
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88D1F611;
	Fri,  6 Oct 2023 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD81C285
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:45:42 +0000 (UTC)
X-Greylist: delayed 2533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 07:45:36 PDT
Received: from good-out-12.clustermail.de (good-out-12.clustermail.de [IPv6:2a02:708:0:1ec::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DABDE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 07:45:36 -0700 (PDT)
Received: from [10.0.0.1] (helo=frontend.clustermail.de)
	by smtpout-03.clustermail.de with esmtp (Exim 4.96)
	(envelope-from <Daniel.Klauer@gin.de>)
	id 1qolQG-0002v0-0S;
	Fri, 06 Oct 2023 16:03:20 +0200
Received: from [217.6.33.237] (helo=Win2012-02.gin-domain.local)
	by frontend.clustermail.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Daniel.Klauer@gin.de>)
	id 1qolQF-00052p-22;
	Fri, 06 Oct 2023 16:03:20 +0200
Received: from [10.176.8.48] (10.176.8.48) by Win2012-02.gin-domain.local
 (10.160.128.12) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Oct
 2023 16:03:19 +0200
Content-Type: multipart/mixed;
	boundary="------------sJvfWqvYvB09F01DP1RkdPHo"
Message-ID: <aa784d0c-85eb-4e5d-968b-c8f74fa86be6@gin.de>
Date: Fri, 6 Oct 2023 16:03:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug] dpaa2-eth: "Wrong SWA type" and null deref in
 dpaa2_eth_free_tx_fd()
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <30428046-fe1a-be57-1df6-2830bd33a385@gin.de>
 <20231004155048.ttllicuerlk5lroc@LXL00007.wbi.nxp.com>
Content-Language: en-US
From: Daniel Klauer <daniel.klauer@gin.de>
In-Reply-To: <20231004155048.ttllicuerlk5lroc@LXL00007.wbi.nxp.com>
X-Originating-IP: [10.176.8.48]
X-ClientProxiedBy: Win2012-02.gin-domain.local (10.160.128.12) To
 Win2012-02.gin-domain.local (10.160.128.12)
X-EsetResult: clean, is OK
X-EsetId: 37303A29342AAB58657C6A
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--------------sJvfWqvYvB09F01DP1RkdPHo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On 04.10.23 17:50, Ioana Ciornei wrote:
> On Wed, Aug 30, 2023 at 07:10:05PM +0200, Daniel Klauer wrote:
>> Hi,
>>
> 
> Hi Daniel,
> 
>> while doing Ethernet tests with raw packet sockets on our custom
>> LX2160A board with Linux v6.1.50 (plus some patches for board support,
>> but none for dpaa2-eth), I noticed the following crash:
>>
> 
> Did you happen to test with any other newer kernel?

Today I tested with v6.5.5, it also shows the same crash:

[  160.013619] fsl_dpaa2_eth dpni.0 eth6: entered promiscuous mode
[  163.100294] fsl_dpaa2_eth dpni.0 eth6: Link is Up - 1Gbps/Full - flow control off
[  163.544566] ------------[ cut here ]------------
[  163.545163] Wrong SWA type
[  163.545188] WARNING: CPU: 12 PID: 0 at drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:1148 dpaa2_eth_free_tx_fd+0x3bc/0x3c8 [fsl_dpaa2_eth]
[  163.547145] Modules linked in: marvell tag_dsa xhci_plat_hcd xhci_hcd aes_ce_blk usbcore aes_ce_cipher crct10dif_ce caam_jr ghash_ce gf128mul dwc3 fsl_dpaa2_eth caamhash_desc libaes caamalg_desc sha2_ce crypto_engine sha256_arm64 pcs_lynx mv88e6xxx libdes udc_core sha1_ce ahci_qoriq roles fsl_mc_dpio dp83867 libahci_platform ahci usb_common sha1_generic dpaa2_console sfp xgmac_mdio caam libahci at24 error libata mdio_i2c lm90 qoriq_thermal nvmem_layerscape_sfp
[  163.552482] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G           O       6.5.5-00118-g8e92933b7fa0 #1
[  163.553643] Hardware name: mpxlx2160a (DT)
[  163.554204] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  163.555082] pc : dpaa2_eth_free_tx_fd+0x3bc/0x3c8 [fsl_dpaa2_eth]
[  163.555858] lr : dpaa2_eth_free_tx_fd+0x3bc/0x3c8 [fsl_dpaa2_eth]
[  163.556635] sp : ffff800080d7bd70
[  163.557054] x29: ffff800080d7bd70 x28: 00000020874fbfc2 x27: ffff00200ba1b000
[  163.557958] x26: ffff00200ba60880 x25: 0000000000000001 x24: ffff00200320d800
[  163.558860] x23: ffff00200ba43d70 x22: 0000000000002328 x21: ffff00200ba40880
[  163.559762] x20: 0000000000000000 x19: ffff0020074fbfc2 x18: 0000000000000018
[  163.560665] x17: ffff80263bae3000 x16: ffff800080d78000 x15: fffffffffffee2d0
[  163.561567] x14: ffff800080bfb388 x13: ffff800080bfb3e0 x12: 0000000000000a38
[  163.562469] x11: 0000000000000368 x10: ffff800080c585a0 x9 : ffff800080bfb3e0
[  163.563372] x8 : 00000000ffffefff x7 : ffff800080c533e0 x6 : 00000000000051c0
[  163.564274] x5 : ffff0026bc5b98c8 x4 : 0000000000000000 x3 : 0000000000000027
[  163.565176] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00200080e040
[  163.566078] Call trace:
[  163.566389]  dpaa2_eth_free_tx_fd+0x3bc/0x3c8 [fsl_dpaa2_eth]
[  163.567121]  dpaa2_eth_tx_conf+0x74/0xac [fsl_dpaa2_eth]
[  163.567798]  dpaa2_eth_poll+0xec/0x3e0 [fsl_dpaa2_eth]
[  163.568454]  __napi_poll+0x34/0x184
[  163.568902]  net_rx_action+0x11c/0x258
[  163.569377]  __do_softirq+0x11c/0x284
[  163.569843]  ____do_softirq+0xc/0x14
[  163.570296]  call_on_irq_stack+0x24/0x34
[  163.570793]  do_softirq_own_stack+0x18/0x20
[  163.571322]  irq_exit_rcu+0xd0/0xe8
[  163.571765]  el1_interrupt+0x34/0x60
[  163.572222]  el1h_64_irq_handler+0x14/0x1c
[  163.572742]  el1h_64_irq+0x64/0x68
[  163.573172]  cpuidle_enter_state+0x130/0x2fc
[  163.573712]  cpuidle_enter+0x34/0x48
[  163.574166]  do_idle+0x1c8/0x230
[  163.574578]  cpu_startup_entry+0x20/0x28
[  163.575076]  secondary_start_kernel+0x128/0x148
[  163.575650]  __secondary_switched+0x6c/0x70
[  163.576183] ---[ end trace 0000000000000000 ]---
[  163.576778] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
[  163.577884] Mem abort info:
[  163.578244]   ESR = 0x0000000096000004
[  163.578718]   EC = 0x25: DABT (current EL), IL = 32 bits
[  163.579388]   SET = 0, FnV = 0
[  163.579774]   EA = 0, S1PTW = 0
[  163.580171]   FSC = 0x04: level 0 translation fault
[  163.580787] Data abort info:
[  163.581151]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  163.581842]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  163.582485]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  163.583156] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020874aa000
[  163.583968] [0000000000000028] pgd=0000000000000000, p4d=0000000000000000
[  163.584825] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  163.585616] Modules linked in: marvell tag_dsa xhci_plat_hcd xhci_hcd aes_ce_blk usbcore aes_ce_cipher crct10dif_ce caam_jr ghash_ce gf128mul dwc3 fsl_dpaa2_eth caamhash_desc libaes caamalg_desc sha2_ce crypto_engine sha256_arm64 pcs_lynx mv88e6xxx libdes udc_core sha1_ce ahci_qoriq roles fsl_mc_dpio dp83867 libahci_platform ahci usb_common sha1_generic dpaa2_console sfp xgmac_mdio caam libahci at24 error libata mdio_i2c lm90 qoriq_thermal nvmem_layerscape_sfp
[  163.590941] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G        W  O       6.5.5-00118-g8e92933b7fa0 #1
[  163.592102] Hardware name: mpxlx2160a (DT)
[  163.592662] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  163.593540] pc : dpaa2_eth_free_tx_fd+0xe8/0x3c8 [fsl_dpaa2_eth]
[  163.594305] lr : dpaa2_eth_free_tx_fd+0xc0/0x3c8 [fsl_dpaa2_eth]
[  163.595069] sp : ffff800080d7bd70
[  163.595487] x29: ffff800080d7bd70 x28: 00000020874fbfc2 x27: 0000000000000000
[  163.596390] x26: 0000000000000001 x25: 0000000000000001 x24: ffff00200320d800
[  163.597292] x23: ffff00200ba43d70 x22: 0000000000002328 x21: ffff00200ba40880
[  163.598194] x20: 0000000000000000 x19: ffff0020074fbfc2 x18: 0000000000000018
[  163.599096] x17: ffff80263bae3000 x16: ffff800080d78000 x15: fffffffffffee2d0
[  163.599998] x14: ffff800080bfb388 x13: ffff800080bfb3e0 x12: 0000000000000a38
[  163.600900] x11: 0000000000000368 x10: ffff800080c585a0 x9 : ffff800080bfb3e0
[  163.601803] x8 : 0001000000000000 x7 : ffff002002dae480 x6 : 00000020874fbfc2
[  163.602705] x5 : ffff002002dae480 x4 : 0000000000000000 x3 : 0000000000000000
[  163.603607] x2 : 00000000e7e00000 x1 : 0000000000000001 x0 : 0000000001010101
[  163.604509] Call trace:
[  163.604819]  dpaa2_eth_free_tx_fd+0xe8/0x3c8 [fsl_dpaa2_eth]
[  163.605539]  dpaa2_eth_tx_conf+0x74/0xac [fsl_dpaa2_eth]
[  163.606216]  dpaa2_eth_poll+0xec/0x3e0 [fsl_dpaa2_eth]
[  163.606871]  __napi_poll+0x34/0x184
[  163.607314]  net_rx_action+0x11c/0x258
[  163.607789]  __do_softirq+0x11c/0x284
[  163.608252]  ____do_softirq+0xc/0x14
[  163.608705]  call_on_irq_stack+0x24/0x34
[  163.609201]  do_softirq_own_stack+0x18/0x20
[  163.609730]  irq_exit_rcu+0xd0/0xe8
[  163.610172]  el1_interrupt+0x34/0x60
[  163.610627]  el1h_64_irq_handler+0x14/0x1c
[  163.611147]  el1h_64_irq+0x64/0x68
[  163.611578]  cpuidle_enter_state+0x130/0x2fc
[  163.612117]  cpuidle_enter+0x34/0x48
[  163.612570]  do_idle+0x1c8/0x230
[  163.612981]  cpu_startup_entry+0x20/0x28
[  163.613479]  secondary_start_kernel+0x128/0x148
[  163.614052]  __secondary_switched+0x6c/0x70
[  163.614585] Code: 7100081f 54000de0 7100101f 540000c0 (3940a360) 
[  163.615355] ---[ end trace 0000000000000000 ]---
[  163.615938] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  163.616803] SMP: stopping secondary CPUs
[  163.617309] Kernel Offset: disabled
[  163.617750] CPU features: 0x40000000,12010000,0800420b
[  163.618399] Memory Limit: none
[  163.618787] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

> 
>> [   26.290737] Wrong SWA type
>> [   26.290760] WARNING: CPU: 7 PID: 0 at drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:1117 dpaa2_eth_free_tx_fd.isra.0+0x36c/0x380 [fsl_dpaa2_eth]
>>
>> followed by
>>
>> [   26.323016] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
>> [   26.324122] Mem abort info:
>> [   26.324475]   ESR = 0x0000000096000004
>> [   26.324948]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   26.325618]   SET = 0, FnV = 0
>> [   26.326004]   EA = 0, S1PTW = 0
>> [   26.326406]   FSC = 0x04: level 0 translation fault
>> [   26.327021] Data abort info:
>> [   26.327385]   ISV = 0, ISS = 0x00000004
>> [   26.327869]   CM = 0, WnR = 0
>> [   26.328244] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020861cf000
>> [   26.329055] [0000000000000028] pgd=0000000000000000, p4d=0000000000000000
>> [   26.329912] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>> [   26.330702] Modules linked in: tag_dsa marvell mv88e6xxx aes_ce_blk caam_jr aes_ce_cipher caamhash_desc crct10dif_ce ghash_ce fsl_dpaa2_eth caamalg_desc xhci_plat_hcd sha256_generic gf128mul libsha256 libaes xhci_hcd crypto_engine pcs_lynx sha2_ce sha1_ce usbcore libdes sha256_arm64 cfg80211 dp83867 sha1_generic fsl_mc_dpio xgmac_mdio dpaa2_console dwc3 ahci ahci_qoriq udc_core caam libahci_platform roles error libahci usb_common libata at24 lm90 qoriq_thermal nvmem_layerscape_sfp sfp mdio_i2c
>> [   26.336237] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W          6.1.50-00121-g10168a070f4d #11
>> [   26.337396] Hardware name: mpxlx2160a (DT)
>> [   26.337956] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   26.338833] pc : dpaa2_eth_free_tx_fd.isra.0+0xd4/0x380 [fsl_dpaa2_eth]
>> [   26.339673] lr : dpaa2_eth_free_tx_fd.isra.0+0xb4/0x380 [fsl_dpaa2_eth]
>> [   26.340512] sp : ffff800008cf3d70
>> [   26.340931] x29: ffff800008cf3d70 x28: ffff002002900000 x27: 0000000000000000
>> [   26.341832] x26: 0000000000000001 x25: 0000000000000001 x24: 0000000000000000
>> [   26.342732] x23: 0000000000002328 x22: ffff002009742728 x21: 00000020884fffc2
>> [   26.343633] x20: ffff002009740840 x19: ffff0020084fffc2 x18: 0000000000000018
>> [   26.344534] x17: ffff8026b3a9a000 x16: ffff800008cf0000 x15: fffffffffffed3f8
>> [   26.345435] x14: 0000000000000000 x13: ffff800008bad028 x12: 0000000000000966
>> [   26.346335] x11: 0000000000000322 x10: ffff800008c09b58 x9 : ffff800008bad028
>> [   26.347236] x8 : 0001000000000000 x7 : ffff0020095e6480 x6 : 00000020884fffc2
>> [   26.348137] x5 : ffff0020095e6480 x4 : 0000000000000000 x3 : 0000000000000000
>> [   26.349037] x2 : 00000000e7e00000 x1 : 0000000000000001 x0 : 0000000049759e0c
>> [   26.349938] Call trace:
>> [   26.350247]  dpaa2_eth_free_tx_fd.isra.0+0xd4/0x380 [fsl_dpaa2_eth]
>> [   26.351044]  dpaa2_eth_tx_conf+0x84/0xc0 [fsl_dpaa2_eth]
>> [   26.351720]  dpaa2_eth_poll+0xec/0x3a4 [fsl_dpaa2_eth]
>> [   26.352375]  __napi_poll+0x34/0x180
>> [   26.352816]  net_rx_action+0x128/0x2b4
>> [   26.353290]  _stext+0x124/0x2a0
>> [   26.353687]  ____do_softirq+0xc/0x14
>> [   26.354139]  call_on_irq_stack+0x24/0x40
>> [   26.354635]  do_softirq_own_stack+0x18/0x2c
>> [   26.355164]  __irq_exit_rcu+0xc4/0xf0
>> [   26.355628]  irq_exit_rcu+0xc/0x14
>> [   26.356059]  el1_interrupt+0x34/0x60
>> [   26.356511]  el1h_64_irq_handler+0x14/0x20
>> [   26.357028]  el1h_64_irq+0x64/0x68
>> [   26.357458]  cpuidle_enter_state+0x12c/0x314
>> [   26.357997]  cpuidle_enter+0x34/0x4c
>> [   26.358450]  do_idle+0x208/0x270
>> [   26.358860]  cpu_startup_entry+0x24/0x30
>> [   26.359356]  secondary_start_kernel+0x128/0x14c
>> [   26.359928]  __secondary_switched+0x64/0x68
>> [   26.360460] Code: 7100081f 54000d00 71000c1f 540000c0 (3940a360)
>> [   26.361228] ---[ end trace 0000000000000000 ]---
>>
>> It happens when receiving big Ethernet frames on a AF_PACKET +
>> SOCK_RAW socket, for example MTU 9000. It does not happen with the
>> standard MTU 1500. It does not happen when just sending.
>>
> 
> Are the transmitted frames also big?

Yes, size 9000 for both sendto() and recvfrom().

> 
>> It's 100% reproducible here, however it seems to depend on the data
>> rate/load: Once it happened after receiving the first 80 frames,
>> another time after the first 300 frames, etc., and if I only send 5
>> frames per second, it does not happen at all.
>>
>> Please let me know if I should provide more info or do more tests. I
>> can provide a test program if needed.
>>
> 
> If you can provide a test program, that would be great. It would help in
> reproducing and debugging the issue on my side.

OK, I've attached a test program, send_and_recv.c, reduced as far as I could get it. If I run it:

ip link set up dev eth6
ip link set mtu 9000 dev eth6
./send_and_recv eth6

it triggers the crash, sometimes very quickly, sometimes it takes a few seconds. In my case eth6 is DPAA2 MAC7, configured for MAC_LINK_TYPE_PHY + SGMII. However the same issue happens with MAC17 with MAC_LINK_TYPE_FIXED + RGMII and with MAC3/MAC4 XFI ports. The link must be up for the test; I just connect it to an external switch with nothing else attached.

Other things I've tried: sending only (and receiving on another machine), receiving only (while sending from another machine), and sending and receiving on separate interfaces on the LX2160A machine, but these cases did not seem to trigger the crash. So it looks like it's only in case both sending and receiving happens on the same interface.

Another detail I noticed: While the null pointer crash always happens, the "Wrong SWA type" warning does not always appear. It shows up only if certain byte values are written into the Ethernet frame payload (see comments in the test program). So perhaps that is a separate issue (and maybe my own fault for using a custom/invalid ethertype value).

> 
> Ioana
> 
> 
--------------sJvfWqvYvB09F01DP1RkdPHo
Content-Type: text/x-csrc; charset="UTF-8"; name="send_and_recv.c"
Content-Disposition: attachment; filename="send_and_recv.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfREVGQVVMVF9TT1VSQ0UgMSAvLyBlbnN1cmUgbmV0L2lmLmggZGVmaW5lcyBz
dHJ1Y3QgaWZyZXEKI2luY2x1ZGUgPGFycGEvaW5ldC5oPgojaW5jbHVkZSA8ZXJybm8uaD4K
I2luY2x1ZGUgPGludHR5cGVzLmg+CiNpbmNsdWRlIDxsaW51eC9pZl9ldGhlci5oPgojaW5j
bHVkZSA8bGludXgvaWZfcGFja2V0Lmg+CiNpbmNsdWRlIDxuZXQvZXRoZXJuZXQuaD4KI2lu
Y2x1ZGUgPG5ldC9pZi5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8c3RkaW50
Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxz
dHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8c3lzL3NlbGVjdC5o
PgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNs
dWRlIDx1bmlzdGQuaD4KCiNkZWZpbmUgQlVGRkVSX1NJWkUgOTAwMAojZGVmaW5lIENVU1RP
TV9FVEhFUl9UWVBFIDB4MTIzNAojZGVmaW5lIFNPQ0tFVF9QUk9UT0NPTCBodG9ucyhFVEhf
UF9BTEwpCgpzdGF0aWMgdm9pZCBlbmFibGVfcHJvbWlzYyhpbnQgZmQsIHVuc2lnbmVkIGlu
dCBpbnRlcmZhY2VfaW5kZXgpCnsKCXN0cnVjdCBwYWNrZXRfbXJlcSBtciA9IHt9OwoJbXIu
bXJfaWZpbmRleCA9IGludGVyZmFjZV9pbmRleDsKCW1yLm1yX3R5cGUgPSBQQUNLRVRfTVJf
UFJPTUlTQzsKCWlmIChzZXRzb2Nrb3B0KGZkLCBTT0xfUEFDS0VULCBQQUNLRVRfQUREX01F
TUJFUlNISVAsICZtciwgc2l6ZW9mKG1yKSkgPCAwKSB7CgkJcGVycm9yKCJzZXRzb2Nrb3B0
KFNPTF9QQUNLRVQvUEFDS0VUX0FERF9NRU1CRVJTSElQL1BBQ0tFVF9NUl9QUk9NSVNDKSBm
YWlsZWQiKTsKCQlleGl0KDEpOwoJfQp9CgpzdGF0aWMgdm9pZCBiaW5kX3RvX2ludGVyZmFj
ZShpbnQgZmQsIHVuc2lnbmVkIGludCBpbnRlcmZhY2VfaW5kZXgpCnsKCXN0cnVjdCBzb2Nr
YWRkcl9sbCBhZGRyID0ge307CglhZGRyLnNsbF9mYW1pbHkgPSBBRl9QQUNLRVQ7CglhZGRy
LnNsbF9wcm90b2NvbCA9IFNPQ0tFVF9QUk9UT0NPTDsKCWFkZHIuc2xsX2lmaW5kZXggPSBp
bnRlcmZhY2VfaW5kZXg7CglpZiAoYmluZChmZCwgKGNvbnN0IHN0cnVjdCBzb2NrYWRkciAq
KSZhZGRyLCBzaXplb2YoYWRkcikpIDwgMCkgewoJCXBlcnJvcigiYmluZCgpIGZhaWxlZCIp
OwoJCWV4aXQoMSk7Cgl9Cn0KCnN0YXRpYyB2b2lkIGdldF9pbnRlcmZhY2VfbWFjX2FkZHIo
aW50IGZkLCBjb25zdCBjaGFyICppbnRlcmZhY2UsIHVpbnQ4X3QgKmFkZHIpCnsKCXN0cnVj
dCBpZnJlcSBpZnJlcSA9IHt9OwoJc3RybmNweShpZnJlcS5pZnJfbmFtZSwgaW50ZXJmYWNl
LCBJRk5BTVNJWiAtIDEpOwoJaWYgKGlvY3RsKGZkLCBTSU9DR0lGSFdBRERSLCAmaWZyZXEp
IDwgMCkgewoJCXBlcnJvcigiaW9jdGwoU0lPQ0dJRkhXQUREUikgZmFpbGVkIik7CgkJZXhp
dCgxKTsKCX0KCW1lbWNweShhZGRyLCBpZnJlcS5pZnJfaHdhZGRyLnNhX2RhdGEsIElGSFdB
RERSTEVOKTsKfQoKc3RhdGljIGludCBzZXR1cF9zb2NrZXQoY29uc3QgY2hhciAqaW50ZXJm
YWNlLCB1bnNpZ25lZCBpbnQgKmludGVyZmFjZV9pbmRleCkKewoJKmludGVyZmFjZV9pbmRl
eCA9IGlmX25hbWV0b2luZGV4KGludGVyZmFjZSk7CglpZiAoKmludGVyZmFjZV9pbmRleCA9
PSAwKSB7CgkJcGVycm9yKCJpZl9uYW1ldG9pbmRleCgpIGZhaWxlZCIpOwoJCWV4aXQoMSk7
Cgl9CgoJaW50IGZkID0gc29ja2V0KFBGX1BBQ0tFVCwgU09DS19SQVcsIFNPQ0tFVF9QUk9U
T0NPTCk7CglpZiAoZmQgPCAwKSB7CgkJcGVycm9yKCJzb2NrZXQoKSBmYWlsZWQiKTsKCQll
eGl0KDEpOwoJfQoKCWVuYWJsZV9wcm9taXNjKGZkLCAqaW50ZXJmYWNlX2luZGV4KTsKCWJp
bmRfdG9faW50ZXJmYWNlKGZkLCAqaW50ZXJmYWNlX2luZGV4KTsKCglyZXR1cm4gZmQ7Cn0K
CnN0YXRpYyB2b2lkICpkb19zZW5kKHZvaWQgKmFyZykKewoJY29uc3QgY2hhciAqaW50ZXJm
YWNlID0gYXJnOwoKCXVuc2lnbmVkIGludCBpbnRlcmZhY2VfaW5kZXg7CglpbnQgZmQgPSBz
ZXR1cF9zb2NrZXQoaW50ZXJmYWNlLCAmaW50ZXJmYWNlX2luZGV4KTsKCgl1aW50OF90IHNy
Y2FkZHJbNl0gPSB7fTsKCWdldF9pbnRlcmZhY2VfbWFjX2FkZHIoZmQsIGludGVyZmFjZSwg
c3JjYWRkcik7CgoJLy8gRGVzdGluYXRpb24gYWRkcmVzcyBkb2VzIG5vdCByZWFsbHkgbWF0
dGVyLCB3ZSBhcmUgdXNpbmcgcHJvbWlzYyBtb2RlIGFueXdheXMgZm9yIHJlY2VpdmluZwoJ
Y29uc3QgdWludDhfdCBkc3RhZGRyWzZdID0gezB4MDIsIDB4MWIsIDB4ZmEsIDAsIDAsIDB9
OwoKCS8vIGJ1aWxkIGV0aGVybmV0IGZyYW1lOgoJLy8gMS4gZXRoZXJuZXQgaGVhZGVyCgkv
LyAyLiBmaXJzdCA4IGJ5dGVzIG9mIGV0aGVybmV0IHBheWxvYWQgd2lsbCBiZSB1c2VkIGZv
ciB1NjQgY291bnRlciAoc2VlIGJlbG93KQoJLy8gMy4gZmlsbCByZXN0IG9mIGV0aGVybmV0
IHBheWxvYWQgd2l0aCBjZXJ0YWluIGJ5dGUgdmFsdWVzOgoJLy8gICAgMCBvciAweEZGIGRv
ZXMgbm90IHRyaWdnZXIgdGhlICJXcm9uZyBTV0EgdHlwZSIgbWVzc2FnZSwgYnV0IGZvciBl
eGFtcGxlIDEgb3IgMHhBNSBkb2VzLgoJLy8gICAgKGJ1dCB0aGUgbnVsbCBkZXJlZiBjcmFz
aCBoYXBwZW5zIGVpdGhlciB3YXkpCgl1aW50OF90IGJ1ZmZlcltCVUZGRVJfU0laRV0gPSB7
fTsKCXN0cnVjdCBldGhlcl9oZWFkZXIgaGVhZGVyID0ge307CgltZW1jcHkoaGVhZGVyLmV0
aGVyX2Rob3N0LCBkc3RhZGRyLCBzaXplb2YgaGVhZGVyLmV0aGVyX2Rob3N0KTsKCW1lbWNw
eShoZWFkZXIuZXRoZXJfc2hvc3QsIHNyY2FkZHIsIHNpemVvZiBoZWFkZXIuZXRoZXJfc2hv
c3QpOwoJaGVhZGVyLmV0aGVyX3R5cGUgPSBodG9ucyhDVVNUT01fRVRIRVJfVFlQRSk7Cglt
ZW1jcHkoYnVmZmVyLCAmaGVhZGVyLCBzaXplb2YoaGVhZGVyKSk7CgltZW1zZXQoYnVmZmVy
ICsgc2l6ZW9mKHN0cnVjdCBldGhlcl9oZWFkZXIpICsgc2l6ZW9mKHVpbnQ2NF90KSwgMSwg
QlVGRkVSX1NJWkUgLSBzaXplb2Yoc3RydWN0IGV0aGVyX2hlYWRlcikgLSBzaXplb2YodWlu
dDY0X3QpKTsKCgl1aW50NjRfdCBuX2ZyYW1lcyA9IDA7CgoJd2hpbGUgKDEpIHsKCQlmZF9z
ZXQgZmRzOwoJCUZEX1pFUk8oJmZkcyk7CgkJRkRfU0VUKGZkLCAmZmRzKTsKCgkJY29uc3Qg
aW50IHNlbGVjdGVkID0gc2VsZWN0KGZkICsgMSwgTlVMTCwgJmZkcywgTlVMTCwgTlVMTCk7
CgkJaWYgKHNlbGVjdGVkIDwgMCkgewoJCQlwZXJyb3IoInNlbGVjdCgpIGZhaWxlZCIpOwoJ
CQlyZXR1cm4gTlVMTDsKCQl9CgoJCWlmIChGRF9JU1NFVChmZCwgJmZkcykpIHsKCQkJbl9m
cmFtZXMrKzsKCgkJCS8vIHB1dCBjb3VudGVyIGludG8gZnJhbWUgcGF5bG9hZAoJCQl1aW50
OF90ICpwYXlsb2FkID0gYnVmZmVyICsgc2l6ZW9mKHN0cnVjdCBldGhlcl9oZWFkZXIpOwoJ
CQltZW1jcHkocGF5bG9hZCwgJm5fZnJhbWVzLCBzaXplb2Yobl9mcmFtZXMpKTsKCgkJCXN0
cnVjdCBzb2NrYWRkcl9sbCBkc3QgPSB7fTsKCQkJZHN0LnNsbF9mYW1pbHkgPSBBRl9QQUNL
RVQ7CgkJCWRzdC5zbGxfcHJvdG9jb2wgPSBDVVNUT01fRVRIRVJfVFlQRTsKCQkJZHN0LnNs
bF9pZmluZGV4ID0gaW50ZXJmYWNlX2luZGV4OwoJCQlkc3Quc2xsX2hhbGVuID0gNjsKCQkJ
bWVtY3B5KGRzdC5zbGxfYWRkciwgZHN0YWRkciwgNik7CgoJCQkvKgoJCQlwcmludGYoInNl
bmQgZnJhbWUgJSIgUFJJdTY0ICI6IHNpemU9JWkiCgkJCQkiIGRzdD0lMDJ4OiUwMng6JTAy
eDolMDJ4OiUwMng6JTAyeCIKCQkJCSIgc3JjPSUwMng6JTAyeDolMDJ4OiUwMng6JTAyeDol
MDJ4IgoJCQkJIiBldGhlcnR5cGU9MHglMDRYICIKCQkJCSJwYXlsb2FkPVslMDJ4ICUwMngg
JTAyeCAlMDJ4ICUwMnggJTAyeCAlMDJ4ICUwMnguLi5dXG4iLAoJCQkJbl9mcmFtZXMsCgkJ
CQlCVUZGRVJfU0laRSwKCQkJCWhlYWRlci5ldGhlcl9kaG9zdFswXSwKCQkJCWhlYWRlci5l
dGhlcl9kaG9zdFsxXSwKCQkJCWhlYWRlci5ldGhlcl9kaG9zdFsyXSwKCQkJCWhlYWRlci5l
dGhlcl9kaG9zdFszXSwKCQkJCWhlYWRlci5ldGhlcl9kaG9zdFs0XSwKCQkJCWhlYWRlci5l
dGhlcl9kaG9zdFs1XSwKCQkJCWhlYWRlci5ldGhlcl9zaG9zdFswXSwKCQkJCWhlYWRlci5l
dGhlcl9zaG9zdFsxXSwKCQkJCWhlYWRlci5ldGhlcl9zaG9zdFsyXSwKCQkJCWhlYWRlci5l
dGhlcl9zaG9zdFszXSwKCQkJCWhlYWRlci5ldGhlcl9zaG9zdFs0XSwKCQkJCWhlYWRlci5l
dGhlcl9zaG9zdFs1XSwKCQkJCW50b2hzKGhlYWRlci5ldGhlcl90eXBlKSwKCQkJCXBheWxv
YWRbMF0sCgkJCQlwYXlsb2FkWzFdLAoJCQkJcGF5bG9hZFsyXSwKCQkJCXBheWxvYWRbM10s
CgkJCQlwYXlsb2FkWzRdLAoJCQkJcGF5bG9hZFs1XSwKCQkJCXBheWxvYWRbNl0sCgkJCQlw
YXlsb2FkWzddCgkJCSk7CgkJCSovCgoJCQljb25zdCBzc2l6ZV90IHJlc3VsdCA9IHNlbmR0
byhmZCwgYnVmZmVyLCBCVUZGRVJfU0laRSwgMCwgKGNvbnN0IHN0cnVjdCBzb2NrYWRkciAq
KSZkc3QsIHNpemVvZihkc3QpKTsKCQkJaWYgKHJlc3VsdCA8IDApIHsKCQkJCXBlcnJvcigi
c2VuZHRvKCkgZmFpbGVkIik7CgkJCQlyZXR1cm4gTlVMTDsKCQkJfQoJCQljb25zdCBzaXpl
X3Qgc2l6ZSA9IHJlc3VsdDsKCQkJaWYgKHNpemUgIT0gQlVGRkVSX1NJWkUpIHsKCQkJCWZw
cmludGYoc3RkZXJyLCAic2VuZHRvKCkgc2VudCBvbmx5ICV6dSBvZiAlaSBieXRlcyIsIHNp
emUsIEJVRkZFUl9TSVpFKTsKCQkJCXJldHVybiBOVUxMOwoJCQl9CgkJfQoKCQkvL3VzbGVl
cCgxMDAwMDAwKTsKCX0KCglyZXR1cm4gTlVMTDsKfQoKc3RhdGljIGludCBkb19yZWN2KGNv
bnN0IGNoYXIgKmludGVyZmFjZSkKewoJdW5zaWduZWQgaW50IGludGVyZmFjZV9pbmRleDsK
CWludCBmZCA9IHNldHVwX3NvY2tldChpbnRlcmZhY2UsICZpbnRlcmZhY2VfaW5kZXgpOwoK
CXVpbnQ4X3QgYnVmZmVyW0JVRkZFUl9TSVpFXSA9IHt9OwoJdWludDY0X3Qgbl9mcmFtZXMg
PSAwOwoKCXdoaWxlICgxKSB7CgkJZmRfc2V0IGZkczsKCQlGRF9aRVJPKCZmZHMpOwoJCUZE
X1NFVChmZCwgJmZkcyk7CgoJCWNvbnN0IGludCBzZWxlY3RlZCA9IHNlbGVjdChmZCArIDEs
ICZmZHMsIE5VTEwsIE5VTEwsIE5VTEwpOwoJCWlmIChzZWxlY3RlZCA8IDApIHsKCQkJcGVy
cm9yKCJzZWxlY3QoKSBmYWlsZWQiKTsKCQkJcmV0dXJuIDE7CgkJfQoKCQlpZiAoRkRfSVNT
RVQoZmQsICZmZHMpKSB7CgkJCW5fZnJhbWVzKys7CgoJCQlzdHJ1Y3Qgc29ja2FkZHJfbGwg
c3JjYWRkciA9IHt9OwoJCQlzb2NrbGVuX3Qgc3JjYWRkcmxlbiA9IHNpemVvZihzcmNhZGRy
KTsKCQkJY29uc3Qgc3NpemVfdCByZXN1bHQgPSByZWN2ZnJvbShmZCwgYnVmZmVyLCBCVUZG
RVJfU0laRSwgMCwgKHN0cnVjdCBzb2NrYWRkciAqKSZzcmNhZGRyLCAmc3JjYWRkcmxlbik7
CgkJCWlmIChyZXN1bHQgPCAwKSB7CgkJCQlwZXJyb3IoInJlY3Zmcm9tKCkgZmFpbGVkIik7
CgkJCQlyZXR1cm4gMTsKCQkJfQoKCQkJaWYgKHNyY2FkZHJsZW4gIT0gc2l6ZW9mKHNyY2Fk
ZHIpKSB7CgkJCQlmcHJpbnRmKHN0ZGVyciwgInVuZXhwZWN0ZWQgc3JjIHNvY2thZGRyIGZy
b20gcmVjdmZyb20oKTogZXhwZWN0ZWQgJXp1IGJ5dGVzLCBhY3R1YWwgJXVcbiIsIHNpemVv
ZihzcmNhZGRyKSwgc3JjYWRkcmxlbik7CgkJCQlyZXR1cm4gMTsKCQkJfQoKCQkJY29uc3Qg
c2l6ZV90IHNpemUgPSByZXN1bHQ7CgkJCWlmIChzaXplIDwgc2l6ZW9mKHN0cnVjdCBldGhl
cl9oZWFkZXIpKSB7CgkJCQlmcHJpbnRmKHN0ZGVyciwgInBhY2tldCB0b28gc21hbGwgZm9y
IEV0aGVybmV0IGhlYWRlcjogJXp1IGJ5dGVzIiwgc2l6ZSk7CgkJCQlyZXR1cm4gMTsKCQkJ
fQoJCQlzdHJ1Y3QgZXRoZXJfaGVhZGVyIGhlYWRlcjsKCQkJbWVtY3B5KCZoZWFkZXIsIGJ1
ZmZlciwgc2l6ZW9mKGhlYWRlcikpOwoJCQljb25zdCB1aW50OF90ICpwYXlsb2FkID0gYnVm
ZmVyICsgc2l6ZW9mKHN0cnVjdCBldGhlcl9oZWFkZXIpOwoKCQkJcHJpbnRmKCJyZWN2IGZy
YW1lICUiIFBSSXU2NCAiOiBpZmluZGV4PSVpIHBrdHR5cGU9JWkgc2l6ZT0lenUiCgkJCQki
IGRzdD0lMDJ4OiUwMng6JTAyeDolMDJ4OiUwMng6JTAyeCIKCQkJCSIgc3JjPSUwMng6JTAy
eDolMDJ4OiUwMng6JTAyeDolMDJ4IgoJCQkJIiBldGhlcnR5cGU9MHglMDRYICIKCQkJCSJw
YXlsb2FkPVslMDJ4ICUwMnggJTAyeCAlMDJ4ICUwMnggJTAyeCAlMDJ4ICUwMnguLi5dXG4i
LAoJCQkJbl9mcmFtZXMsCgkJCQlzcmNhZGRyLnNsbF9pZmluZGV4LAoJCQkJc3JjYWRkci5z
bGxfcGt0dHlwZSwKCQkJCXNpemUsCgkJCQloZWFkZXIuZXRoZXJfZGhvc3RbMF0sCgkJCQlo
ZWFkZXIuZXRoZXJfZGhvc3RbMV0sCgkJCQloZWFkZXIuZXRoZXJfZGhvc3RbMl0sCgkJCQlo
ZWFkZXIuZXRoZXJfZGhvc3RbM10sCgkJCQloZWFkZXIuZXRoZXJfZGhvc3RbNF0sCgkJCQlo
ZWFkZXIuZXRoZXJfZGhvc3RbNV0sCgkJCQloZWFkZXIuZXRoZXJfc2hvc3RbMF0sCgkJCQlo
ZWFkZXIuZXRoZXJfc2hvc3RbMV0sCgkJCQloZWFkZXIuZXRoZXJfc2hvc3RbMl0sCgkJCQlo
ZWFkZXIuZXRoZXJfc2hvc3RbM10sCgkJCQloZWFkZXIuZXRoZXJfc2hvc3RbNF0sCgkJCQlo
ZWFkZXIuZXRoZXJfc2hvc3RbNV0sCgkJCQludG9ocyhoZWFkZXIuZXRoZXJfdHlwZSksCgkJ
CQlwYXlsb2FkWzBdLAoJCQkJcGF5bG9hZFsxXSwKCQkJCXBheWxvYWRbMl0sCgkJCQlwYXls
b2FkWzNdLAoJCQkJcGF5bG9hZFs0XSwKCQkJCXBheWxvYWRbNV0sCgkJCQlwYXlsb2FkWzZd
LAoJCQkJcGF5bG9hZFs3XQoJCQkpOwoJCX0KCX0KCglyZXR1cm4gMDsKfQoKaW50IG1haW4o
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7CglpZiAoYXJnYyA8IDIpIHsKCQlmcHJpbnRmKHN0
ZGVyciwgInVzYWdlOiAlcyA8aW50ZXJmYWNlPlxuIiwgYXJndlswXSk7CgkJcmV0dXJuIDE7
Cgl9CgoJY2hhciAqaW50ZXJmYWNlID0gYXJndlsxXTsKCglwdGhyZWFkX3QgdGhyZWFkOwoJ
aW50IGVyciA9IHB0aHJlYWRfY3JlYXRlKCZ0aHJlYWQsIE5VTEwsIGRvX3NlbmQsIGludGVy
ZmFjZSk7CglpZiAoZXJyICE9IDApIHsKCQllcnJubyA9IGVycjsKCQlwZXJyb3IoInB0aHJl
YWRfY3JlYXRlKCkgZmFpbGVkIik7CgkJcmV0dXJuIDE7Cgl9CgoJZG9fcmVjdihpbnRlcmZh
Y2UpOwoJcmV0dXJuIDA7Cn0K

--------------sJvfWqvYvB09F01DP1RkdPHo--

