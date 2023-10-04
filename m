Return-Path: <netdev+bounces-37996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7587B842B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 19DB12815CD
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D151B28B;
	Wed,  4 Oct 2023 15:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD13FF1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:50:59 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2047.outbound.protection.outlook.com [40.107.14.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D24C9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 08:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjVlJSKWDYtAJMOy8SjN0ZuODZmPbS4ku6hUylyEpUNrqo7k/AzZeQ/w0sfgo5Fh4JQz87BesVZdZtnGwwafO1NsphnX/cEfUAzrfXgPMxcAMhDBuxipMqgmLy0lYLfHXsGZ/Gh41S1Lxf5gY1G1LJOAHJDO3UflCPSINWzv5M8qjQxVQMnLr1g10B47KGdvaQgEDloChKWdV62dIt9oi/idsK3JWA9faWTxlvRaPsDSJwRIpfrL/EbnqYw9Em6cw4//nZYkh4C9dzVvs5Jpmh2kutuHLejToQj1XzWwrUxe7Ga89E3XvW6h7hlNd/bdhPS+DeqvRBsz55KroZ8E7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbhmXoVedzn98pXtnkjlSii0/1WNsXzyfvxgD5L2V1k=;
 b=J4nKWTkASU2JZ7OZigKC3ogdJisVV27W9CbuB054QvZJ+pBSIGBIe8W1/7XccemSOxGGK1oAIRvPa6PuTNxnTr/Ca2etBdNAL3zxmn/+F2DVfio1SNqK3egik0vRgTkIX5XXnv0+4agHIdbVOkATLyWQo+IVZsYoHbBiLSVpfDeFX5mSoH/BE8szta9tHChU/T1q6TwCe9ACUuB8Vipk5+nI/4ZjW2h6b7efBjpPFl6/U/fqBIL+3ZIRMf4HAlO/nI+ok9SxPehO/2MWqNVzRavZCOxxUuVJoTKetnqWSAdZWR8e3ra155afNpB2CRRPyowB/1BR1+k0tTTMWJqrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbhmXoVedzn98pXtnkjlSii0/1WNsXzyfvxgD5L2V1k=;
 b=OgPLaY4I87FoC6x5OhP2zJ+K79byP+rbRq9T9h4ecVpbwY2z6AeEc+OItJZESnPtl6JhBGM5wgJnVcGEwyJV2UBmabP9oIQAY6+q14nvSQ8pw07ymLdyteFFP1mrFM2Mc7KRxYeMF65QIwP8dxyf6iPYTppC0ymLqRkmje6GPeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB7268.eurprd04.prod.outlook.com (2603:10a6:20b:1de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 15:50:52 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::b5bf:66cb:33a6:3345]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::b5bf:66cb:33a6:3345%3]) with mapi id 15.20.6838.029; Wed, 4 Oct 2023
 15:50:52 +0000
Date: Wed, 4 Oct 2023 18:50:48 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Daniel Klauer <daniel.klauer@gin.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [bug] dpaa2-eth: "Wrong SWA type" and null deref in
 dpaa2_eth_free_tx_fd()
Message-ID: <20231004155048.ttllicuerlk5lroc@LXL00007.wbi.nxp.com>
References: <30428046-fe1a-be57-1df6-2830bd33a385@gin.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30428046-fe1a-be57-1df6-2830bd33a385@gin.de>
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: c04a684b-55af-4525-d9b2-08dbc4f1afe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WtHkCctVRGAzAERor3cq1vrFDjxYL5ImuG3JRLd4rkTuNoGPWSwA+DFTwYaXaPIBQqCuXhhZVrTjsQO5TdK3fDdPxqWG6McsPRRBNdpC4w/D3IUlSCspqJgDMrTTLOstG0WRWMggH7ULUAgNWkOpsHUMC45OdP5duQleLkTqqHi4uKD1X1KjeN1ntDMqmyknBTo0up3qJP3qOV4GUUT0vzaBGIa4FyGr8RGFkeFz7HJ8bctrsALEkDZ1YOLbNMfHxYxJFPu476TRLf2wpshfZw3M06eRzBPZa+S8ncE+4j56d/0+Aesdha0KhO5U/tEgbiberqGinpKPQgbfn/cGrH2NbDeSh/trwx/R/Q8l10h1SoMZ1s5yJ7Jus2vRVIbBxzv0n/zkIN3VCypwbYtGlFvN+SlJ+VkjowNtbz2nJyH0Dz1SDy1xEGIKdah7LLolHhPQd1Z8uUQywiAYM5/6cS5/r9sKSgLiJPqvOUZmqPFGfO7/KT+kd7zfNY3jxO4OY+b25D8fW56KT0HXiGJ9MBln/RKP923ckQS2+okcdT2RHkHSCbf6MyYbDIs+rFnG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6666004)(6506007)(6486002)(6512007)(45080400002)(478600001)(38100700002)(86362001)(2906002)(6916009)(83380400001)(26005)(1076003)(66946007)(66556008)(66476007)(8676002)(316002)(8936002)(5660300002)(41300700001)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Oqs3x5NSIGbbVdXvA3uNt00daByVRDhO7ssf3Q5XZMS6a5I7f4E2/SusbPo?=
 =?us-ascii?Q?FnwnGtAI5LoXfvEgnDSfEsympfEQkQxlCXAVASIzAluAtlE6nO1zMx57248T?=
 =?us-ascii?Q?gCfxT3HaiB4gSRS8eciUpcx1NjvnEIrU0HDj19vLZp0Bj6lwM9n0mCmvXfED?=
 =?us-ascii?Q?FNBk5bovX828HzIoSDgqB0PwkcjGwOEGlm4/f6NfXIeccCMJD5JN7oTV8FeQ?=
 =?us-ascii?Q?hgDmy+IWQknN5cv78pAOXLCF1d0C40Of8cMxw8RiGEpOZ4mufh4SNhXA/M4/?=
 =?us-ascii?Q?g+mAVFIpX9S0NrrsSa2XSuEP8fPEAAuyBeKBT1eF7jYxwV5j/aS7vn6DXxWk?=
 =?us-ascii?Q?Udh73+e1RlZTbgl+6lMjFbE5zq3vazW4kWysF4yZ1/KcU3ztPuAqAVlIFON6?=
 =?us-ascii?Q?XsSwLF4eLCA+c7aqe3E0g2opi16KH6UYq19XEQnNkIAO+GCg5/siCACaIrcI?=
 =?us-ascii?Q?vs/1P33B7VcqDmq528EMfXMkAEYhUZjgbWVmBAdyGeudy+LkwGc1v6V6+ySt?=
 =?us-ascii?Q?xKPiYg+B8ZedakteEH+/9tjHt3aZOl+KLmBJdPhu1db5tQYZNjbZucDlFb3L?=
 =?us-ascii?Q?L5Ha/RIDlwoX17JvJb469zJc8FOITaM78q/bjUSzjhT2BYTt7AD5aJUwp6q4?=
 =?us-ascii?Q?MjFqyg1GR4Dq1bnFVjywKkZyiCXWACLAlyvYXXR98/YPgVUiwc2SkkB9tv4+?=
 =?us-ascii?Q?aYtMeSLVO+QnDNcW0A7oyV8rD85sJjcadjg6eJOH4upBIU5sDO1HqdyIFIhs?=
 =?us-ascii?Q?uaWoNgO+nmCghM56KAjkA4Y9ddShF0r/lyZYLySRlonK5CWK6tGAqZPs72QQ?=
 =?us-ascii?Q?JcG4wlWwjh5loM0JlPfgtYtMAi3z9a76KaGCmEteQkbtHdalhEZG11YCcbke?=
 =?us-ascii?Q?h8tZd7w268moAFRsfykeId0lDLV37M3xmyZiS1OkYeHlpQIKFfna7dvxMUey?=
 =?us-ascii?Q?9+ZFIbxS2YuxnA1nhHDxJN6AfTdY5l0MdZaaAObx/K7EQTJBId2x69AF3RHI?=
 =?us-ascii?Q?K/6WsrLg9CHPs+IxxI31jvZMH7IGB7r7T2cUEe6MDFlFAI2eRUgoLBbmSXJt?=
 =?us-ascii?Q?Tc1WkdL53c24KVmjjWzfyxjbraPmKnELPhNki0YLFH6k/pnvlhWljTXQOlB1?=
 =?us-ascii?Q?+9LSe1NVIPY7fgaXa0rq+2fVEuo2IjmUE3VHsi/JDb8GZYkYH5xj3CdDUHsS?=
 =?us-ascii?Q?oREdcg90cOY2K3BXIkIeKAVgcJMnw8bh36rWQzGSd8OF9fqK+Q5cqek//r0+?=
 =?us-ascii?Q?AWSscIiLyaprJggOVwlqz6feqfj9C4r/JwnmUT7YLapKxzJM3EODtmWZrcy3?=
 =?us-ascii?Q?cmhkHMHcgUoYuYHJGQc0WjuOCFGgxu7tL3zDNndlUZIfUtDOKuVcYmabrudw?=
 =?us-ascii?Q?wrLjzQ5Xh1wHKEPbXVPcp88yrSArGsxJJF92OMDjKV/mqvawooPcr19DJOte?=
 =?us-ascii?Q?m6Wcc/Lw5W0FA3Bj3yrHY3jfNhm8LbjpEy8VEa49BQPfMaJt0xbYaFzjQpEW?=
 =?us-ascii?Q?JexmejUoltPJZcfJoqmdKEIuSbiLDomoEuPP4BG4acbmDC20pxg9xZPmeCCg?=
 =?us-ascii?Q?5P4xLgYVUEcV1/NbumgoSl73kMZP7LfeR9HQ4mNE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04a684b-55af-4525-d9b2-08dbc4f1afe7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:50:52.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oou6kSqntHYAI9mbCTA9XG/l9H2i+GS11rwF/cZPM+2wbDo++m+1Yd6/JuA0lkLU7bljK8cRqt+gJ8jvkD8kWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 07:10:05PM +0200, Daniel Klauer wrote:
> Hi,
> 

Hi Daniel,

> while doing Ethernet tests with raw packet sockets on our custom
> LX2160A board with Linux v6.1.50 (plus some patches for board support,
> but none for dpaa2-eth), I noticed the following crash:
> 

Did you happen to test with any other newer kernel?

> [   26.290737] Wrong SWA type
> [   26.290760] WARNING: CPU: 7 PID: 0 at drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:1117 dpaa2_eth_free_tx_fd.isra.0+0x36c/0x380 [fsl_dpaa2_eth]
> 
> followed by
> 
> [   26.323016] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
> [   26.324122] Mem abort info:
> [   26.324475]   ESR = 0x0000000096000004
> [   26.324948]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   26.325618]   SET = 0, FnV = 0
> [   26.326004]   EA = 0, S1PTW = 0
> [   26.326406]   FSC = 0x04: level 0 translation fault
> [   26.327021] Data abort info:
> [   26.327385]   ISV = 0, ISS = 0x00000004
> [   26.327869]   CM = 0, WnR = 0
> [   26.328244] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020861cf000
> [   26.329055] [0000000000000028] pgd=0000000000000000, p4d=0000000000000000
> [   26.329912] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [   26.330702] Modules linked in: tag_dsa marvell mv88e6xxx aes_ce_blk caam_jr aes_ce_cipher caamhash_desc crct10dif_ce ghash_ce fsl_dpaa2_eth caamalg_desc xhci_plat_hcd sha256_generic gf128mul libsha256 libaes xhci_hcd crypto_engine pcs_lynx sha2_ce sha1_ce usbcore libdes sha256_arm64 cfg80211 dp83867 sha1_generic fsl_mc_dpio xgmac_mdio dpaa2_console dwc3 ahci ahci_qoriq udc_core caam libahci_platform roles error libahci usb_common libata at24 lm90 qoriq_thermal nvmem_layerscape_sfp sfp mdio_i2c
> [   26.336237] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W          6.1.50-00121-g10168a070f4d #11
> [   26.337396] Hardware name: mpxlx2160a (DT)
> [   26.337956] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   26.338833] pc : dpaa2_eth_free_tx_fd.isra.0+0xd4/0x380 [fsl_dpaa2_eth]
> [   26.339673] lr : dpaa2_eth_free_tx_fd.isra.0+0xb4/0x380 [fsl_dpaa2_eth]
> [   26.340512] sp : ffff800008cf3d70
> [   26.340931] x29: ffff800008cf3d70 x28: ffff002002900000 x27: 0000000000000000
> [   26.341832] x26: 0000000000000001 x25: 0000000000000001 x24: 0000000000000000
> [   26.342732] x23: 0000000000002328 x22: ffff002009742728 x21: 00000020884fffc2
> [   26.343633] x20: ffff002009740840 x19: ffff0020084fffc2 x18: 0000000000000018
> [   26.344534] x17: ffff8026b3a9a000 x16: ffff800008cf0000 x15: fffffffffffed3f8
> [   26.345435] x14: 0000000000000000 x13: ffff800008bad028 x12: 0000000000000966
> [   26.346335] x11: 0000000000000322 x10: ffff800008c09b58 x9 : ffff800008bad028
> [   26.347236] x8 : 0001000000000000 x7 : ffff0020095e6480 x6 : 00000020884fffc2
> [   26.348137] x5 : ffff0020095e6480 x4 : 0000000000000000 x3 : 0000000000000000
> [   26.349037] x2 : 00000000e7e00000 x1 : 0000000000000001 x0 : 0000000049759e0c
> [   26.349938] Call trace:
> [   26.350247]  dpaa2_eth_free_tx_fd.isra.0+0xd4/0x380 [fsl_dpaa2_eth]
> [   26.351044]  dpaa2_eth_tx_conf+0x84/0xc0 [fsl_dpaa2_eth]
> [   26.351720]  dpaa2_eth_poll+0xec/0x3a4 [fsl_dpaa2_eth]
> [   26.352375]  __napi_poll+0x34/0x180
> [   26.352816]  net_rx_action+0x128/0x2b4
> [   26.353290]  _stext+0x124/0x2a0
> [   26.353687]  ____do_softirq+0xc/0x14
> [   26.354139]  call_on_irq_stack+0x24/0x40
> [   26.354635]  do_softirq_own_stack+0x18/0x2c
> [   26.355164]  __irq_exit_rcu+0xc4/0xf0
> [   26.355628]  irq_exit_rcu+0xc/0x14
> [   26.356059]  el1_interrupt+0x34/0x60
> [   26.356511]  el1h_64_irq_handler+0x14/0x20
> [   26.357028]  el1h_64_irq+0x64/0x68
> [   26.357458]  cpuidle_enter_state+0x12c/0x314
> [   26.357997]  cpuidle_enter+0x34/0x4c
> [   26.358450]  do_idle+0x208/0x270
> [   26.358860]  cpu_startup_entry+0x24/0x30
> [   26.359356]  secondary_start_kernel+0x128/0x14c
> [   26.359928]  __secondary_switched+0x64/0x68
> [   26.360460] Code: 7100081f 54000d00 71000c1f 540000c0 (3940a360) 
> [   26.361228] ---[ end trace 0000000000000000 ]---
>
> It happens when receiving big Ethernet frames on a AF_PACKET +
> SOCK_RAW socket, for example MTU 9000. It does not happen with the
> standard MTU 1500. It does not happen when just sending.
>

Are the transmitted frames also big?

> It's 100% reproducible here, however it seems to depend on the data
> rate/load: Once it happened after receiving the first 80 frames,
> another time after the first 300 frames, etc., and if I only send 5
> frames per second, it does not happen at all.
> 
> Please let me know if I should provide more info or do more tests. I
> can provide a test program if needed.
> 

If you can provide a test program, that would be great. It would help in
reproducing and debugging the issue on my side.

Ioana

