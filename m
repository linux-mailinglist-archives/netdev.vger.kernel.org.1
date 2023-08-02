Return-Path: <netdev+bounces-23664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6276D0B5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE8E281DCC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5779F7;
	Wed,  2 Aug 2023 14:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54DB33E5
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 14:57:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3BE43
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRmbEYWcqooiZD9czvb8iHPdndA72Jr61RaQNsoKVK+NedqADfLSAZps22NHY1mu6PUI3slTGtNweJ5r2PAiZZ6x4cOpD4XKYhj/eukdzmVFNsW3XA6KLIYd6h5imiIAifveki4RwHNwdBRX38BKgWIM4UOfgoJFkURi22Zn4cwZaGju/CIg4DERdnVArz8q32IZH4Oh0oM2t/eAQ4j8ojxdElbp9FR8z04yl/T0tjdgO49oPQhNPfyZnQQbJwPh+h4IMxw7wg1It8yC3VzBOimFTQRBCxcUCI8uNFKiTBOUfIQKOnWrzMJourCFa+AEoGiusyfK4YqVm+oLmYuyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8t3bXBgVLyJgDRarkxx5NCKO/hu+1a2ocIhdH0zD+c=;
 b=dLJ9Xk0S4hASELYRDg58PLMlADfhNW1g1IiOBdBJDr0/yV0oMXSt3d13HuzDLLhDDWiAevDvc7lrPx/Db75Rk5pF6aL+FYV2bMtvZQCIIuK0alnP1Bj8zCMIZshsE5iGjy3PDZkqEcmcWVXJnDLW5ikXz8nJ7cv4ONgYqGjCYEHRlh/Mf2o0ocU1ZeZUe1ZXVrLTo4ZZe5lIjfFq2mrGiLbpEPsrSP8nsFL0i5zyF+pyFoeAR4p0+jnvcaxxsiqJvoW+okK90nTgD22143YgKJwf2aR+//dfg+L5EyceWcMJlmOEYyY4A86rEIa+pClchJjyu/7KcF23pL3aquyK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8t3bXBgVLyJgDRarkxx5NCKO/hu+1a2ocIhdH0zD+c=;
 b=ZlTFvhHSrIRnO+8nnnbYpI7PudYiXA68FTwtg4vpCan6+qMrVBa5LWKMxEFz/T325CTzwRUnAnokJRco0zRqLosbxXoASmTxOxl8BPyMlVlOHJCmyZIPlixT4yUPElojOlOE/FZdUmsRiPq+AjNXCJLPOZAomcWiBMvbGPGX6mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB6799.eurprd04.prod.outlook.com (2603:10a6:803:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 14:57:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:57:39 +0000
Date: Wed, 2 Aug 2023 17:57:36 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Antoine Tenart <atenart@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org
Subject: netif_set_xps_queue() before register_netdev(): correct from an API
 perspective?
Message-ID: <20230802145736.gp4bbudizpk7elk3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: AS4P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: fe16c9c3-335c-43c4-a9f5-08db9368d0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CzS8Hx3oSkmDBflEP0Bjeqf2SCLS8X5DiqNg/Iz8bXWcdr0g8eJbZSZTt6eaMZZNlr4kLpEImPeyurCOFUP7BLQRSrMX4BZVoISeNoTUGRW9ypTq6DGEdRmIt0cBzJXs9Q3396Ob45CpdWTG+877g7lmEsNrkGFXO2kHMpFzro/jIIgT2ZNBZ4L2T/B5nevZpyL6HgkK8e5rgIR+w8SQNPNk+5ke1YG6yuK0QTWP8iNSiELaMeRu9s6SyHI6A9M75KBAMdH5NR1zSBHZGPWgSBA4pxM7gPHYc6FGtaGqqq+Kzp6p18fLQOwMKMkHkmris7f+jXTYJ8d1eeuUYilGHHKTHrXor8jkWwQitWEM4cEvGicHHI3U/CYjFZWX+Mf170d2MvX71kbMJR0e6vIb4njAGQGt89RwOvz6pcFrJePrDM0KHsuDkCzPGhDS/vcVO+c2VQEEdI9WjAUK5ps02uJDXJMsbROoeoZCEk1vHVxr1eMkKHPep7y4YE8LSrNEkXUnczVUAH3qivwz6mMK5i+d3QlJQdBCSNx3ITRZaE4USHxPtR+Shh7Nw9/Fh0IdCT5b8JFfoo7UbyxFKV/UeJpJsytTQk7QQQcJQBqWPNATvFlO3x+Bb7mKwH3UUaOO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(6512007)(9686003)(6666004)(5660300002)(186003)(44832011)(66946007)(66556008)(66476007)(4326008)(316002)(478600001)(110136005)(6486002)(41300700001)(8936002)(8676002)(6506007)(33716001)(26005)(38100700002)(86362001)(2906002)(83380400001)(1076003)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjYt9DywTatCYLmuYO/KuMPhi2EzvTLLEPn5sUNqrHk1+KXN2SbJacFc7oUX?=
 =?us-ascii?Q?aXJ5XjmxKQuMl/aGpHyzBcaWmKQhBj51S9PuYApP/MKyRxkEFM9segLPNx98?=
 =?us-ascii?Q?seOewtVmDPNSktzsEicwuJMG2EICib3080Gdycg5r2mxA0lCEXvqLdeBie3O?=
 =?us-ascii?Q?0oHwRXQGEuJxCyZWoVFkedC1Lz0OD2WanCAqeSdvv+7IxC+fEXdsTNaiJHiK?=
 =?us-ascii?Q?miG6nESIWaER4tDAGHpIPo2/OsVGIFEpmJ1pTGKPkdo02RcRjH2kfo+RrbBv?=
 =?us-ascii?Q?pxKWewtf5S+22LUK3t02485RZOdcf35IZ2cdYSCXaqLd8yicRjdl5AQ9C0xt?=
 =?us-ascii?Q?OjsKZ9I8GjhkTl+p9WbMR/X2/hnme7uU/iFyKT202SHBOCU/A4X0jX1XuI09?=
 =?us-ascii?Q?QQkqtcXH68EeJ1dNOiW+4uHXEnIx9AOpbH6UE1iWI70hbiRzhdYLhWFei0Do?=
 =?us-ascii?Q?xS0pvuxv72f7OCnXEnzvi3e3kFbRRQJRD1oJgH4D74RCRWdFmjI0sV7I1uhM?=
 =?us-ascii?Q?s9P6qctkFWIkzBNMmEu/FXaYE5ViYotOHQthNY+xwFMgk21s8zWBIFS+rCNE?=
 =?us-ascii?Q?Am2TkiHle5iH7kIGMLQ7Ed2T/UfdEk2XkJei7L7heVXxBwxq6XuiDnQBRTh5?=
 =?us-ascii?Q?diF7bWykUsSZMN+C19qAh91DXeOobf13Pstjsfz9WFR1jHrlc/ogP+/ClB/E?=
 =?us-ascii?Q?5DLRRL24NyN+vpfSuIGaNF3o6cAxnulkWYof19u1svriBzovXp+arfTi0QuO?=
 =?us-ascii?Q?dZ4EoCwFBckSPRnoTrOb6fgiFJdXk+XESmD9krtj2U/Zg7dDDSqLP4SSH64E?=
 =?us-ascii?Q?E+WwvbmbEukS9ZKell+Be6oK1HTNusR4F/y9r3EFb0LR0RMzP8e5Ao2JL/RK?=
 =?us-ascii?Q?m8B31KcdqS4wLRk5ih6TojLc0FMBFtiTAtWs5uCDvPRD3qG6Fg35ISeq9QZd?=
 =?us-ascii?Q?RMWNosF0pd5DlyHVHsgOAowUg6g3SvECjwyuKq5vgCpUJ6HaeXKbSBI0SzPF?=
 =?us-ascii?Q?d526Eqak4GIXmnDYAP7kudvp90BrnQgXOsgpHo+3PUnz6XRpDD7CKwQBXJiN?=
 =?us-ascii?Q?kIioRsHxWooI7sC97CSwn0feTADXksG1lFUlj0vlQON5PBo5WiVsVJ7l9jEp?=
 =?us-ascii?Q?6y9oCCckp/fn/4YlFsnftE85kQx8jNqfnRSawTk0q80DtJBCqRcwJY3P8uFP?=
 =?us-ascii?Q?WO4hAKxfZ+ZZpHjUmwHUmMBjZgz1pfq+AQBGM5h5PlA8OrRci0Tvr0u1z0Mg?=
 =?us-ascii?Q?Oo3XdG7IZw0H5WBcWPif7qlznBaZn6m7yxAAKg+4ITclP6kJg+FVXK/1+DMR?=
 =?us-ascii?Q?TYKAEIp/8uV7EPO74pFyXpephXtVc86XByNSFsRBEB8fYk4bgYFDcrDVyI2C?=
 =?us-ascii?Q?H1i52Ay0ixPQniJ5X8csUJi/E9uGF+GqihOv3IrQrkaGU6Uuyg1cnVxE73Ep?=
 =?us-ascii?Q?YpWga/Gwqyp5xv7zrmJlJfge8CkCiP7a3sQwXlRMlxQc5xr3TBXMv8xDgzdI?=
 =?us-ascii?Q?UU/aWkqGyFxOpIaL7ryC6SfI7y/SwQrbDsrWkSjnMygP0j8Aa5Ha++4f7Ogq?=
 =?us-ascii?Q?Le4YCWMDdgDVWBBVqcv29lWMtlBCSWZokSSL2uNEacffaGkqHg/Db/eBKQps?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe16c9c3-335c-43c4-a9f5-08db9368d0b3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:57:39.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpmnPvoNXJ0ZLbwcSLWBmCMlwcl5w0LX7b3hLIHwLWLU04lDkPq3nY08NcZfRHEAor4Jxtk55eoDERHNX6Wgcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

When drivers/net/ethernet/freescale/dpaa2/ fails to probe (including -EPROBE_DEFER),
I see lots of these:

$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff042845fbdac0 (size 64):
  comm "kworker/u16:1", pid 56, jiffies 4294893690 (age 859.844s)
  hex dump (first 32 bytes):
    01 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffc754095a7dfc>] slab_post_alloc_hook+0xa4/0x330
    [<ffffc754095a654c>] __kmem_cache_alloc_node+0x23c/0x308
    [<ffffc7540952fec0>] __kmalloc_node+0xc0/0x240
    [<ffffc7540a976934>] __netif_set_xps_queue+0x32c/0xa78
    [<ffffc7540a9771e4>] netif_set_xps_queue+0x44/0x70
    [<ffffc7540a1c3540>] update_xps+0xb0/0x158
    [<ffffc7540a1c0290>] dpaa2_eth_probe+0xd10/0x1368
    [<ffffc75409b1677c>] fsl_mc_driver_probe+0x2c/0x80
    [<ffffc75409eb764c>] really_probe+0x13c/0x2f8
    [<ffffc75409eb666c>] __driver_probe_device+0xac/0x140
    [<ffffc75409eb7340>] driver_probe_device+0x48/0x218
    [<ffffc75409eb71d8>] __device_attach_driver+0x128/0x158
    [<ffffc75409eb33e4>] bus_for_each_drv+0x12c/0x160
    [<ffffc75409eb63f4>] __device_attach+0xcc/0x1a0
    [<ffffc75409eb64e8>] device_initial_probe+0x20/0x38
    [<ffffc75409eb3620>] bus_probe_device+0xa0/0x118

I see that netif_set_xps_queue() allocates dev->xps_maps[], which is
eventually freed by reset_xps_maps() <- ... <- netif_reset_xps_queues_gt()
from a number of call sites, including from unregister_netdevice_many_notify().

This is nice, but dpaa2 (above) and emulex/benet/be_main.c call
netif_set_xps_queue() prior to registering the net device. So no
deregistration event will take place.

How is the memory supposed to be freed in this case?

