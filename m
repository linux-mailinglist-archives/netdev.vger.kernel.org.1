Return-Path: <netdev+bounces-24588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8E770B3F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 23:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6B61C20A6D
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410221D33;
	Fri,  4 Aug 2023 21:49:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34A1AA9F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 21:49:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2135.outbound.protection.outlook.com [40.107.94.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74865103
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT1KYmyoKncExh6eYbPoHNuOtJV9qPjyZrKTArXioR8Wrq9CwJmKntVTtVYQ6tESxeMzyBoG2emX9MwpUAHUKcHu/NsvO0kGRbE+jKYGeOddAa+CGABvd2dCq/e01iLEeoAs8d4mvay9XSwQoseXgM72SiaMV28reD6FY4tNOMjt15HP/Y/3Woet5fWFGAvkK7ClhWZrPu+VOKBn/T1EAmYhaE1tQaaEsHXubs8EeSZL/mjTA/QFO+My9Tg9fmbhGVdk+wCEjJAxc1IV+ceAUbN/7KTcumnaFQV0ElcfJ1mKUy3GWT8lz2xmm8Bfodoc3HvuCWjlKomoLj357pi3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WidY1yaUXw4CVwX98l4QrzYNopHyS7RD8ArD/1CLhVU=;
 b=mq9C/KR8E5GUxZXzCfoRXyR7FNt0yuxhukG3WuM3t/1H0YXTqnwPsHtC/7U5Rbo+JdaVqOp/jtcuSHHlRh1zjF1bKWTmX3QU/A36enK8VQY5WLiPugeTulcu6A5aLW1gG1AEvzovh/8l7cCUH9euyXPeLRicWB3D8Ns6/Cr+1WbwhiioYLpSlBlfUzzA4JNRFHrLAEgV6Uqvxypux2/3iy8l4F9GawmuR4liPAgLGPpDoZpGaOKn/E5zE+D2xJCB5xbytH9m/CIg63h+GnqFG7dJ9sdChhyMODTekxdiSGy54KI4Ns/BPTkgQv1H0daGknuuwSiOGAC91oiK80Sw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WidY1yaUXw4CVwX98l4QrzYNopHyS7RD8ArD/1CLhVU=;
 b=O/gWP5/TMGnUtqI3FcfqZ6Qn+33LGjYp6TFuiV4dU2J5LTQsJzRhEvB6qJXkHu0oDuxXM9Tb2fb95syP4/dPkh/S4/Zk3+CwERlfdQ2sPV2CS91+kpTUHjNtkiCNCtBIHj1F2Bap8kb5PbGrtRHX+aPE+aJN9gUoLu9ii7kTCDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH0PR10MB5847.namprd10.prod.outlook.com
 (2603:10b6:510:146::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 4 Aug
 2023 21:49:52 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 21:49:51 +0000
Date: Fri, 4 Aug 2023 14:49:47 -0700
From: Colin Foster <colin.foster@in-advantage.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: dsa: ocelot: call dsa_tag_8021q_unregister()
 under rtnl_lock() on driver remove
Message-ID: <ZM1ye+UYKdW6a/m5@euler>
References: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
 <ZM0hVTA7nHuRCSXa@euler>
 <20230804170958.nru6iafu5jrfxhqh@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804170958.nru6iafu5jrfxhqh@skbuf>
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|PH0PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ee45a9-d8ab-4eea-c6b1-08db9534bb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v2rCIO+O/RIwKhwswwg9gyciHanrk1IZa5KVaCVzrgs1NULS1aX32SL7h0gSrbG9/fqjNqyNQFSRGq7cUy1Y1txUTZFL7G82F/L+tDV+wF4U/Rn259rpWp7zqGYPZ3RN5Erk02MHn1p0GDqPii5GlS0Dq9XiSNOU+11WV77WrzBBYtAtZN7EJvb6QY18aEVMUUgkuRqp6qB3S+lxL7xF0hzXFNisLTpz/cGC7n/Tt+ueSVTE//6bdgkChcn/tkLMfknWezml8NFS/cUU6JKRHeDaC5J6SBhMX2rXJzL7q9qlaxN7n8UleJqnnjXhGnXMlQ//SIU+p4kfQMe2fVdwvRxxhDuMMtFsyDvfJRvAWaZwP3XHiY9X5dIdVC1vJ6eFK7OaTDQFBDZ4pjq8652e30QcD/HuBT4gGPIdrCNYuxjaOceRENKHyQaz5wCclrPo8scKwzZMjebVvIyqAGOX2Up3pLiF/jafvpvw89Ywhtz8dsyJ/zg8KRyOKnphxtl27QKl2ID8BIXJi1AM3MIHkqpGz411gRdS2ST+mkp+6Tw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(376002)(39830400003)(346002)(186006)(451199021)(1800799003)(6486002)(6506007)(26005)(6512007)(966005)(9686003)(83380400001)(30864003)(7416002)(44832011)(54906003)(41300700001)(4326008)(6916009)(5660300002)(66556008)(66946007)(66476007)(8936002)(8676002)(86362001)(316002)(6666004)(33716001)(38100700002)(45080400002)(478600001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vIxUmlJHkQw173bKIjSj0k4QvsPMfUzkUltrkyv4dPCvej3Ph8TFmXDu8ps4?=
 =?us-ascii?Q?zJK3sDb8EGMudEmg3bTpL+ugVnfiFiea6kFP11Lni6RHvxBx04MuZscfLwwo?=
 =?us-ascii?Q?RJrgd1fSMEn2pwWMslEJENqEbDULfkTuP6l3mW/zE23o3rm0Zn86tHLEMzF3?=
 =?us-ascii?Q?YBqzFKVa8sgJoCO03fx4bLVijH2fSPrnqobd9bZeIqSkyeacemRSRWqWvjvv?=
 =?us-ascii?Q?JcRfkAoxj6bkZu5w5m4EL2Kj5pnkbg6FBXPt9ehIvINUau56pVt7e4KGPZHP?=
 =?us-ascii?Q?i9S7I3zstAveIt6IGi4EuFQNrSmjdUfI4H7ElbzgmG8KceW42QHhfQt91MAX?=
 =?us-ascii?Q?bLyR1MGznUxLrQVuKg6I7ZbRFWP9XUTRM8+QuxBokWb3NMIwkS/C6hw/vYMk?=
 =?us-ascii?Q?0zCTuXkoX15qvG55uIqDLVhMSH6t8dPCdQtG89XR/YDFc+Od2hy7n1oI3PZA?=
 =?us-ascii?Q?m57CRl+TGm1kkegRjfLNRuHxttLDvPqxVLtd0btNZVOsgX7HQxShQEfDmwye?=
 =?us-ascii?Q?UUAJXBqBlYmJm+s3NrGdhlfOdt0ISJmjBypPauf9/V1t6/UTNeValuzTKL9Z?=
 =?us-ascii?Q?ngA/D+8QWkwapnZbEapYKfbfsonhE/7SBHlsWISIiTrrqgKT/xK8vgIPaJdZ?=
 =?us-ascii?Q?UwmbKbRITut/GjfeUOqEyN8Kgrs6gHQlIvsDrxG4IMbpV8/gHOTIiVsPbhgN?=
 =?us-ascii?Q?GvxkGXUaqVq0M63O2wAp5bYiVaTTFQGj9RpLyuq02Y8ETaMHRbMtmxGIu/RH?=
 =?us-ascii?Q?TXAPl7zEMMw88Qm4mseLRVBEbaO5GMS3F9cYw1m4+k3dJuo74tirumvp5PbE?=
 =?us-ascii?Q?kJsHRUyYWqvpoKKDy6ie+T1017xGXKf10NpEKAyY3fYTsFOpPZRPzb1caeDj?=
 =?us-ascii?Q?KzwL6MNAjoOc2Big5Lxp/d6O/ozJ5rPMD9dnddISGHAU6z2ChFXTQvTW7aKm?=
 =?us-ascii?Q?6etdh5jyHXlR/teApfXHgJB7bHrMxjtYL56P6y4jzdpL74+pntZ2RgNdzUnH?=
 =?us-ascii?Q?8aFgFUsP+q6GI2ckU55TETEg/ik+b77oV1RgGdsq1eDiP9rRZOA0gbi/QGvF?=
 =?us-ascii?Q?J9Cy1JzafAIdnc/0Bn825X0s5D6VJdVzOreOz1wEsdqBA2EyXB5fJSxM3GLR?=
 =?us-ascii?Q?ksKBp4TcHZeqsqbPo80y8TSyeGUb3mSPq7Xv1Cfyz238LXHutrEVO5mQrXmX?=
 =?us-ascii?Q?CTcmS6DrgqGOcCqQlvLGRWSl1Xt9pVn1IGXduWbJwQ/QHzhsLydnAL3/KPQ7?=
 =?us-ascii?Q?8DZZassz1BEcBcdwc+eYR5QidlQNhvYWRVHbWWHm+iJyw8PNIiVSsvNURxkM?=
 =?us-ascii?Q?EVnFubxlF4VHhHzVcCuwi11B53/gJjB6e5D+s3qIM18a/8B7nSqg7Zf4BnYf?=
 =?us-ascii?Q?DbHyOpxMqSaMlZ/34WDYm663Yiu6ty5Sb2mutWBdWeynaZ7Ilvm+Mt7SQo2t?=
 =?us-ascii?Q?LEKEi/aLk+gs1Pa5R5kSh85JnnJkK+il3EuIPWsk8CjDUvXOVRivI5nsNMma?=
 =?us-ascii?Q?v3CN+INL3/dAESPLO7NnLj7fip9SzCW3Zy/BYUG8E+NcvckbPPOqE4tsAasd?=
 =?us-ascii?Q?U9Re3M3cYgZzbCfHwAP4o31UCxtQ5G+R4BjDFaiKGquhAt0ZKhG+Vfpzk2hT?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ee45a9-d8ab-4eea-c6b1-08db9534bb3c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:49:51.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHRa6e3/74w7U73HPJ63EHZotyEgFeb3iHrDOouz5f+hgWU7juYqNDbWK0gyvn0/Vds1TSpi+3aoE0beZAzYEbKTewqunJ2RbBUPxBRzBn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Vladimir,

On Fri, Aug 04, 2023 at 08:09:58PM +0300, Vladimir Oltean wrote:
> Hi Colin,
> 
> The WARN_ON() in dsa_switch_release_ports() is different, and I tried to fix it here:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230411144955.1604591-1-vladimir.oltean@nxp.com/
> but judging by the fact that that was in April and now we're in August,
> obviously I didn't succeed.
> 
> What's worse is the other one, the "scheduling while atomic" bug in the
> gpiochip removal path from ocelot-pinctrl.c. I'm not sure, at first glance,
> what causes the calling context to be atomic. Presumably some kind of
> spinlock which should be tracked down.
> 
> Unfortunately I'm not very good with kernel debugging the way it should
> be done, so what I would advise you to do is to walk the stack trace
> down, from device_del() or so, and sprinkle a few might_sleep() calls
> until you figure out who's forcing atomic context and why.

I'm not super confident in tracking down these types of bugs either, but
you already knew that ;-)  Thanks for these debugging tips. This is
absolutely a problem I want to understand!

When I was _really_ early in my SGPIO LED bring-up, I saw a scheduling
while atomic warning when I set one of those LEDs to trigger on
heartbeat. I have since tested that many times and never saw it again.

> Otherwise, can't you just unbind the driver from the ethernet-switch
> child of the SPI device, rather than the entire SPI device? That should
> avoid the gpiochip/pinctrl bug. And the other one is ignorable for the
> intents and purposes here (that is, unless you want to take care of it,
> of course).

Ok, I might have it recreated. My method:

(updated to 6.5-rc4)
Set dsa up for ocelot-8021q:

echo ocelot-8021q > /sys/class/net/eth0/dsa/tagging

Bring up the ports in my jumpered bridge configuration. (Bridge
swp1-swp7 and have a bunch of short cables to test RSTP.)

**
Side note, in 8021q mode I can ping through the bridge's swp1 to my
desktop, but RSTP forwards on all ports. I'm adding this to my list.
**

Unbind the ocelot-ext driver:

echo ocelot-ext-switch.5.auto > \
/sys/bus/platform/drivers/ocelot-ext-switch/unbind

br0: port 1(swp1) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp1 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp1 (unregistering): left promiscuous mode
br0: port 1(swp1) entered disabled state
br0: port 2(swp2) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp2 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp2 (unregistering): left promiscuous mode
br0: port 2(swp2) entered disabled state
br0: port 3(swp3) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp3 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp3 (unregistering): left promiscuous mode
br0: port 3(swp3) entered disabled state
br0: port 4(swp4) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp4 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp4 (unregistering): left promiscuous mode
br0: port 4(swp4) entered disabled state
br0: port 5(swp5) entered disabled state
br0: port 5(swp5) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp5 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp5 (unregistering): left promiscuous mode
br0: port 5(swp5) entered disabled state
br0: port 6(swp6) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp6 (unregistering): left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp6 (unregistering): left promiscuous mode
br0: port 6(swp6) entered disabled state
br0: port 7(swp7) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto swp7 (unregistering): left allmulticast mode
cpsw-switch 4a100000.switch eth0: left allmulticast mode
ocelot-ext-switch ocelot-ext-switch.5.auto swp7 (unregistering): left promiscuous mode
cpsw-switch 4a100000.switch eth0: left promiscuous mode
br0: port 7(swp7) entered disabled state
ocelot-ext-switch ocelot-ext-switch.5.auto: Link is Down
------------[ cut here ]------------
WARNING: CPU: 0 PID: 157 at net/dsa/tag_8021q.c:409 dsa_tag_8021q_unregister+0x1a8/0x1ac
RTNL: assertion failed at net/dsa/tag_8021q.c (409)
Modules linked in:
CPU: 0 PID: 157 Comm: bash Not tainted 6.5.0-rc4-00008-gda8b39e58927 #1325
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:00000009 r6:00000000 r5:c18c0c5c r4:00030113
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:00000009 r6:c1197930 r5:00000199 r4:c1a06dfc
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x150/0x1e0
 r8:00000009 r7:00000199 r6:c1a06dfc r5:c1d05590 r4:c1c978a4
 warn_slowpath_fmt from dsa_tag_8021q_unregister+0x1a8/0x1ac
 r10:c2182b90 r9:00000000 r8:c424d844 r7:0100003e r6:c46ec180 r5:c4284a30
 r4:c4298300
 dsa_tag_8021q_unregister from felix_tag_8021q_teardown+0x94/0x140
 r10:c2182b90 r9:00000000 r8:c424d844 r7:0100003e r6:c26db808 r5:c4284a30
 r4:c4298300
 felix_tag_8021q_teardown from felix_teardown+0x30/0xc0
 r7:00000000 r6:c26db808 r5:c4298300 r4:c4298300
 felix_teardown from dsa_tree_teardown_switches+0xa4/0xd4
 r7:00000000 r6:c4284b48 r5:c4282600 r4:c4298300
 dsa_tree_teardown_switches from dsa_unregister_switch+0xe4/0x18c
 r7:c4255c54 r6:c1ec5414 r5:c4284b40 r4:c4298300
 dsa_unregister_switch from ocelot_ext_remove+0x28/0x40
 r9:00000000 r8:c424d844 r7:c4255c54 r6:c1ec5414 r5:c424d800 r4:c26db800
 ocelot_ext_remove from platform_remove+0x50/0x6c
 r5:c424d800 r4:c4255c10
 platform_remove from device_remove+0x50/0x74
 r5:c424d800 r4:c4255c10
 device_remove from device_release_driver_internal+0x190/0x204
 r5:c424d800 r4:c4255c10
 device_release_driver_internal from device_driver_detach+0x20/0x24
 r9:00000000 r8:00000000 r7:c1ec5414 r6:00000019 r5:c4255c10 r4:c1ea59e0
 device_driver_detach from unbind_store+0x64/0xa0
 unbind_store from drv_attr_store+0x34/0x40
 r7:e0c55f08 r6:c2182b80 r5:c471a100 r4:c0a53740
 drv_attr_store from sysfs_kf_write+0x48/0x54
 r5:c471a100 r4:c0a5299c
 sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
 r5:c471a100 r4:00000019
 kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
 r10:00000000 r9:00004004 r8:00000000 r7:00000019 r6:00579a60 r5:e0c55f68
 r4:c4714f00
 vfs_write from ksys_write+0x70/0xf4
 r10:00000004 r9:c42ad8c0 r8:c03002f4 r7:00000000 r6:00000000 r5:c4714f00
 r4:c4714f02
 ksys_write from sys_write+0x18/0x1c
 r7:00000004 r6:b6f86550 r5:00579a60 r4:00000019
 sys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xe0c55fa8 to 0xe0c55ff0)
5fa0:                   00000019 00579a60 00000001 00579a60 00000019 00000000
5fc0: 00000019 00579a60 b6f86550 00000004 00000019 00000001 00000000 bed4ea6c
5fe0: 00000004 bed4e9c8 b6e2f767 b6dbae06
---[ end trace 0000000000000000 ]---
cpsw-switch 4a100000.switch eth0: Link is Down
------------[ cut here ]------------
WARNING: CPU: 0 PID: 157 at net/8021q/vlan_core.c:376 vlan_vid_del+0x14c/0x16c
RTNL: assertion failed at net/8021q/vlan_core.c (376)
Modules linked in:
CPU: 0 PID: 157 Comm: bash Tainted: G        W          6.5.0-rc4-00008-gda8b39e58927 #1325
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:00000009 r6:00000000 r5:c18c0c5c r4:000f0013
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:00000009 r6:c11a5554 r5:00000178 r4:c1a078b4
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x150/0x1e0
 r8:00000009 r7:00000178 r6:c1a078b4 r5:c1d05590 r4:c1c978a4
 warn_slowpath_fmt from vlan_vid_del+0x14c/0x16c
 r10:00000c01 r9:c46ec180 r8:c241f000 r7:c241f000 r6:00000c01 r5:0000a888
 r4:c4298300
 vlan_vid_del from dsa_tag_8021q_unregister+0x164/0x1ac
 r9:c46ec180 r8:c241f000 r7:00000000 r6:c46ec180 r5:00000001 r4:c4298300
 dsa_tag_8021q_unregister from felix_tag_8021q_teardown+0x94/0x140
 r10:c2182b90 r9:00000000 r8:c424d844 r7:0100003e r6:c26db808 r5:c4284a30
 r4:c4298300
 felix_tag_8021q_teardown from felix_teardown+0x30/0xc0
 r7:00000000 r6:c26db808 r5:c4298300 r4:c4298300
 felix_teardown from dsa_tree_teardown_switches+0xa4/0xd4
 r7:00000000 r6:c4284b48 r5:c4282600 r4:c4298300
 dsa_tree_teardown_switches from dsa_unregister_switch+0xe4/0x18c
 r7:c4255c54 r6:c1ec5414 r5:c4284b40 r4:c4298300
 dsa_unregister_switch from ocelot_ext_remove+0x28/0x40
 r9:00000000 r8:c424d844 r7:c4255c54 r6:c1ec5414 r5:c424d800 r4:c26db800
 ocelot_ext_remove from platform_remove+0x50/0x6c
 r5:c424d800 r4:c4255c10
 platform_remove from device_remove+0x50/0x74
 r5:c424d800 r4:c4255c10
 device_remove from device_release_driver_internal+0x190/0x204
 r5:c424d800 r4:c4255c10
 device_release_driver_internal from device_driver_detach+0x20/0x24
 r9:00000000 r8:00000000 r7:c1ec5414 r6:00000019 r5:c4255c10 r4:c1ea59e0
 device_driver_detach from unbind_store+0x64/0xa0
 unbind_store from drv_attr_store+0x34/0x40
 r7:e0c55f08 r6:c2182b80 r5:c471a100 r4:c0a53740
 drv_attr_store from sysfs_kf_write+0x48/0x54
 r5:c471a100 r4:c0a5299c
 sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
 r5:c471a100 r4:00000019
 kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
 r10:00000000 r9:00004004 r8:00000000 r7:00000019 r6:00579a60 r5:e0c55f68
 r4:c4714f00
 vfs_write from ksys_write+0x70/0xf4
 r10:00000004 r9:c42ad8c0 r8:c03002f4 r7:00000000 r6:00000000 r5:c4714f00
 r4:c4714f02
 ksys_write from sys_write+0x18/0x1c
 r7:00000004 r6:b6f86550 r5:00579a60 r4:00000019
 sys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xe0c55fa8 to 0xe0c55ff0)
5fa0:                   00000019 00579a60 00000001 00579a60 00000019 00000000
5fc0: 00000019 00579a60 b6f86550 00000004 00000019 00000001 00000000 bed4ea6c
5fe0: 00000004 bed4e9c8 b6e2f767 b6dbae06
---[ end trace 0000000000000000 ]---
DSA: tree 0 torn down
------------[ cut here ]------------
WARNING: CPU: 0 PID: 157 at net/dsa/dsa.c:1490 dsa_switch_release_ports+0x104/0x12c
Modules linked in:
CPU: 0 PID: 157 Comm: bash Tainted: G        W          6.5.0-rc4-00008-gda8b39e58927 #1325
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:00000009 r6:00000000 r5:c18c0c5c r4:000d0013
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:00000009 r6:c1187600 r5:000005d2 r4:c1a06454
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0xe4/0x1e0
 r8:00000009 r7:000005d2 r6:c1a06454 r5:c1d05590 r4:c1c978a4
 warn_slowpath_fmt from dsa_switch_release_ports+0x104/0x12c
 r10:c2182b90 r9:c4284b68 r8:00000100 r7:c1a06454 r6:c4298300 r5:c4282800
 r4:c4282600
 dsa_switch_release_ports from dsa_unregister_switch+0x38/0x18c
 r9:c4284b68 r8:c424d844 r7:c4255c54 r6:c4284b70 r5:c4284b40 r4:c4298300
 dsa_unregister_switch from ocelot_ext_remove+0x28/0x40
 r9:00000000 r8:c424d844 r7:c4255c54 r6:c1ec5414 r5:c424d800 r4:c26db800
 ocelot_ext_remove from platform_remove+0x50/0x6c
 r5:c424d800 r4:c4255c10
 platform_remove from device_remove+0x50/0x74
 r5:c424d800 r4:c4255c10
 device_remove from device_release_driver_internal+0x190/0x204
 r5:c424d800 r4:c4255c10
 device_release_driver_internal from device_driver_detach+0x20/0x24
 r9:00000000 r8:00000000 r7:c1ec5414 r6:00000019 r5:c4255c10 r4:c1ea59e0
 device_driver_detach from unbind_store+0x64/0xa0
 unbind_store from drv_attr_store+0x34/0x40
 r7:e0c55f08 r6:c2182b80 r5:c471a100 r4:c0a53740
 drv_attr_store from sysfs_kf_write+0x48/0x54
 r5:c471a100 r4:c0a5299c
 sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
 r5:c471a100 r4:00000019
 kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
 r10:00000000 r9:00004004 r8:00000000 r7:00000019 r6:00579a60 r5:e0c55f68
 r4:c4714f00
 vfs_write from ksys_write+0x70/0xf4
 r10:00000004 r9:c42ad8c0 r8:c03002f4 r7:00000000 r6:00000000 r5:c4714f00
 r4:c4714f02
 ksys_write from sys_write+0x18/0x1c
 r7:00000004 r6:b6f86550 r5:00579a60 r4:00000019
 sys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xe0c55fa8 to 0xe0c55ff0)
5fa0:                   00000019 00579a60 00000001 00579a60 00000019 00000000
5fc0: 00000019 00579a60 b6f86550 00000004 00000019 00000001 00000000 bed4ea6c
5fe0: 00000004 bed4e9c8 b6e2f767 b6dbae06
---[ end trace 0000000000000000 ]---
BUG: scheduling while atomic: bash/157/0x00000002
Modules linked in:
Preemption disabled at:
[<c03b8ff0>] __wake_up_klogd.part.0+0x20/0xb4
CPU: 0 PID: 157 Comm: bash Tainted: G        W          6.5.0-rc4-00008-gda8b39e58927 #1325
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:00000002 r6:00000080 r5:c18c0c5c r4:000d0093
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:00000002 r6:c42ad8c0 r5:c03b8ff0 r4:c42ad8c0
 dump_stack from __schedule_bug+0x94/0xa4
 __schedule_bug from __schedule+0x8fc/0xc48
 r5:00000000 r4:df99a400
 __schedule from schedule+0x60/0xf4
 r10:5ac3c35a r9:befffd07 r8:fffffe30 r7:00000002 r6:c03002f4 r5:e0c55fb0
 r4:c42ad8c0
 schedule from do_work_pending+0x84/0x568
 r5:e0c55fb0 r4:c42ad8c0
 do_work_pending from slow_work_pending+0xc/0x20
Exception stack(0xe0c55fb0 to 0xe0c55ff8)
5fa0:                                     00000019 00579a60 00000019 00000000
5fc0: 00000019 00579a60 b6f86550 00000004 00000019 00000001 00000000 bed4ea6c
5fe0: 00000004 bed4e9c8 b6e2f767 b6dbae06 40010030 00000001
 r10:00000004 r9:c42ad8c0 r8:c03002f4 r7:00000004 r6:b6f86550 r5:00579a60
 r4:00000019



I repeat with your patch:

...

ocelot-ext-switch ocelot-ext-switch.5.auto: Link is Down
cpsw-switch 4a100000.switch eth0: Link is Down
DSA: tree 0 torn down
------------[ cut here ]------------
WARNING: CPU: 0 PID: 157 at net/dsa/dsa.c:1490 dsa_switch_release_ports+0x104/0x12c
Modules linked in:
CPU: 0 PID: 157 Comm: bash Not tainted 6.5.0-rc4-00008-gda8b39e58927-dirty #1326
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:00000009 r6:00000000 r5:c18c0c64 r4:00000013
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:00000009 r6:c1187600 r5:000005d2 r4:c1a06470
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0xe4/0x1e0
 r8:00000009 r7:000005d2 r6:c1a06470 r5:c1d05590 r4:c1c978a4
 warn_slowpath_fmt from dsa_switch_release_ports+0x104/0x12c
 r10:c4afc890 r9:c4284b68 r8:00000100 r7:c1a06470 r6:c4298300 r5:c4282800
 r4:c4282600
 dsa_switch_release_ports from dsa_unregister_switch+0x38/0x18c
 r9:c4284b68 r8:c424d844 r7:c4255c54 r6:c4284b70 r5:c4284b40 r4:c4298300
 dsa_unregister_switch from ocelot_ext_remove+0x28/0x40
 r9:00000000 r8:c424d844 r7:c4255c54 r6:c1ec5414 r5:c424d800 r4:c26db800
 ocelot_ext_remove from platform_remove+0x50/0x6c
 r5:c424d800 r4:c4255c10
 platform_remove from device_remove+0x50/0x74
 r5:c424d800 r4:c4255c10
 device_remove from device_release_driver_internal+0x190/0x204
 r5:c424d800 r4:c4255c10
 device_release_driver_internal from device_driver_detach+0x20/0x24
 r9:00000000 r8:00000000 r7:c1ec5414 r6:00000019 r5:c4255c10 r4:c1ea59e0
 device_driver_detach from unbind_store+0x64/0xa0
 unbind_store from drv_attr_store+0x34/0x40
 r7:e0c55f08 r6:c4afc880 r5:c471a600 r4:c0a53740
 drv_attr_store from sysfs_kf_write+0x48/0x54
 r5:c471a600 r4:c0a5299c
 sysfs_kf_write from kernfs_fop_write_iter+0x11c/0x1dc
 r5:c471a600 r4:00000019
 kernfs_fop_write_iter from vfs_write+0x2d0/0x41c
 r10:00000000 r9:00004004 r8:00000000 r7:00000019 r6:005598a8 r5:e0c55f68
 r4:c4a819c0
 vfs_write from ksys_write+0x70/0xf4
 r10:00000004 r9:c47d0000 r8:c03002f4 r7:00000000 r6:00000000 r5:c4a819c0
 r4:c4a819c2
 ksys_write from sys_write+0x18/0x1c
 r7:00000004 r6:b6f1d550 r5:005598a8 r4:00000019
 sys_write from ret_fast_syscall+0x0/0x1c
Exception stack(0xe0c55fa8 to 0xe0c55ff0)
5fa0:                   00000019 005598a8 00000001 005598a8 00000019 00000000
5fc0: 00000019 005598a8 b6f1d550 00000004 00000019 00000001 00000000 be9f8a6c
5fe0: 00000004 be9f89c8 b6dc6767 b6d51e06
---[ end trace 0000000000000000 ]---
BUG: scheduling while atomic: bash/157/0x00000002
Modules linked in:
Preemption disabled at:
[<c03b8ff0>] __wake_up_klogd.part.0+0x20/0xb4
CPU: 0 PID: 157 Comm: bash Tainted: G        W          6.5.0-rc4-00008-gda8b39e58927-dirty #1326
Hardware name: Generic AM33XX (Flattened Device Tree)
Backtrace:
 dump_backtrace from show_stack+0x20/0x24
 r7:00000002 r6:00000080 r5:c18c0c64 r4:00000093
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 r7:00000002 r6:c47d0000 r5:c03b8ff0 r4:c47d0000
 dump_stack from __schedule_bug+0x94/0xa4
 __schedule_bug from __schedule+0x8fc/0xc48
 r5:00000000 r4:df99a400
 __schedule from schedule+0x60/0xf4
 r10:5ac3c35a r9:befffd07 r8:fffffe30 r7:00000002 r6:c03002f4 r5:e0c55fb0
 r4:c47d0000
 schedule from do_work_pending+0x84/0x568
 r5:e0c55fb0 r4:c47d0000
 do_work_pending from slow_work_pending+0xc/0x20
Exception stack(0xe0c55fb0 to 0xe0c55ff8)
5fa0:                                     00000019 005598a8 00000019 00000000
5fc0: 00000019 005598a8 b6f1d550 00000004 00000019 00000001 00000000 be9f8a6c
5fe0: 00000004 be9f89c8 b6dc6767 b6d51e06 40010030 00000001
 r10:00000004 r9:c47d0000 r8:c03002f4 r7:00000004 r6:b6f1d550 r5:005598a8





So if your patch is confirming the existence and removal of the warnings:
WARNING: CPU: 0 PID: 157 at net/dsa/tag_8021q.c:409 dsa_tag_8021q_unregister+0x1a8/0x1ac
WARNING: CPU: 0 PID: 157 at net/8021q/vlan_core.c:376 vlan_vid_del+0x14c/0x16c

... and you think my testing methods are valid, I can add Acked / Tested
if you like.

("scheduling while atomic" and "dsa_switch_release_ports" I see when
unbinding, regardless of ocelot or ocelot-8021q tagging protocols)


Hope this helps, and let me know if there's anything else you want me to
test.

