Return-Path: <netdev+bounces-52188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F67FDD80
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95772B20E5D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7A21DFCC;
	Wed, 29 Nov 2023 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qI/SBheH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43C590
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:44:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4JEYHyzZL9zqK0lloDgQ9v47v7LGKe4dS6Qk/s52OiSthAteLJ7ritJe6CPnTu+2a55dhBcJ6D9ujSj1I0FCPGRdxnILhf2l6QEMfGRpx3LYPJleSbjkNiqBs2KbZJbpwWoqZCO9u8F5G1XNW9edNcuQCIUGVytmw2W4TNkd2p1QpurYj0QPf8H/Lr/dfjth83Y0zRu6lS+SnVemV3zdWHiHRIChwqyWlWPI/YvwkHLt+nTNRktduaX+RWlLV+d/BKspT2vg3S0qX2s6Fpd6icJHehFP85puAuR+Awk93nR8w81SBG5aFRZgnGqNTzJiiwVC2CCbAOUKjb23xW7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoJqGgurGU61JsQMkiuGBTpD79btX8RYC6lJKlgI+QE=;
 b=iTdk26BMdMCgi5pHo+Hc/muTqefHFzwiumcztgVxj0fNZi+FxrOW4tRX7p1RbCrmOtALi+hF48yYfSc7plcl0RvxFTQKEmoQTn214Q4/am1Ip/F//lsvfQjWfgALGOymfSSM2VTtttIvCheRpbpc3BVfq1CBMjcIKWNVOSofCO4YvPZYCYm19jpamSpbZkzXgWWnWjvppVuxk5+c7GhW893hFQpcqAtjxUtCzXogls6KYEV5pCmFWwu8WHdBGe/b45Pb0KUqX83EGYOCunJAHyuG4u7eRhC2pEZv2tZ3CLjtNXFzagbsxF0XF6t2dgRQWducmoaW4pkCqkimf1/Sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoJqGgurGU61JsQMkiuGBTpD79btX8RYC6lJKlgI+QE=;
 b=qI/SBheHPcF346LtZffAoK4rTQECyPpOYecgv0a9YvUV6PVqIrg0XFgnsIgL/j+d8Udj01PtLN20y70oiyKEYjhSLDE1FGLIO+if6qedynbw2ZLIn0HtOrJu6blJpKd2ZceLsufy7PgDGLDNUzXh0yRaRueJ3seasr6XPG7yAms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8149.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 16:44:55 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 16:44:55 +0000
Date: Wed, 29 Nov 2023 18:44:52 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and
 QCA8K
Message-ID: <20231129164452.5k7hlqjczivyzq43@skbuf>
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231129123819.zrm25eieeuxndr2r@skbuf>
 <a0f8aad6-badc-49dc-a6c2-32a7a3cee863@lunn.ch>
 <20231129154336.bm4nx2pwycufbejj@skbuf>
 <d8dc6d95-df81-4a8c-b5dd-9f6589e7c555@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8dc6d95-df81-4a8c-b5dd-9f6589e7c555@lunn.ch>
X-ClientProxiedBy: VI1PR09CA0158.eurprd09.prod.outlook.com
 (2603:10a6:800:120::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: cd76fc72-e3f6-4818-6c79-08dbf0fa8419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yNX/o6jrM+XMNaYavOZ1Xwh/vkWaFnR3j6m9gvPDLnuxYLpPMAU8VAGtSC2aXiCgSbQVJa+vjAEeAhjHFa9bFt44CixvkgeU8X9UrL+WKNZbU++V9dNWHIfctfsOHeIIvTtcS+CRMZqhwBXUUUncJfoGdqnmw3EMSgJjxGQRaEHcRDjwVIIj5Yz5QYP7T2RKdp+qmQLi4S+1qH2+G4Xwlz5rTqSVeiN3sllmCw+7h4ZuyGjZREFMKQ/26gbPmSQqW1axETDzfddzRt9xzaIf9CG/Nuslnf0fBxgxCOZXRpARGc7I8yrgyjvNtRn76a8b7gzo5J3+0zVmOWEvmAzVn2sCJ5baqGQZOLENWI77qdssXYwIgH/7ymidtufQpuVgSuw1bilm9UnGnmgnOVuA+2PL12KR4G3k0EI3gAcj3zzkEIQjr8tvV0SkJvn6ASCTMkhOQBa4DOFr6AY2LrWa1SM+iBPdnWNjQC+WyqO5w51VliEdz0gRoZYOrb8Zv8VoshwIoN1U3UDYC0j2avJ312YbbWuq4HIAgpZ6Z7e9EWwEaW59gpy/3tLTVqH3QJEgmOSXGVznbtYlQ6IggmJ4TXz4mJ6krXSknQz4qZkdgnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6512007)(9686003)(26005)(1076003)(86362001)(38100700002)(5660300002)(44832011)(478600001)(33716001)(4744005)(2906002)(6666004)(6506007)(66556008)(66476007)(4326008)(8936002)(8676002)(54906003)(316002)(6916009)(41300700001)(66946007)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTM7b5/pmZXXpB10bIkWee7772+EgrW+tHIBGrVwi85wpD4RIXR/AoYFWHvy?=
 =?us-ascii?Q?pjPxsBxe3C+TMjar4LhrSMqPEVrjXrZJoksrvNgjQBi5GPE9WNYZx4EHO/NQ?=
 =?us-ascii?Q?2rloxVLXGBsXcwXKQHnbgmVy/C3FKDRmz0YZJrqv5yTofOqEsw2VxdWaXAQR?=
 =?us-ascii?Q?qhWY6FPiN9bbraCpY4V/Lwn5ReTDLdTr9ipkO8r43wnf3uhlJ1JTSQeY0bqv?=
 =?us-ascii?Q?jEvV2FT7LbiK8U5aoZiLaU4roz8gAjz7Pvff5+7WGDdevEGdwsd9UUB3FCuP?=
 =?us-ascii?Q?MhCu7vqJyFMCAjSV/idmo7OOHqBthNoDK+GXG+/hhQTQhb1h+vgV3Hnb0myj?=
 =?us-ascii?Q?UtrQQe2ZEXhq4JW+dJVq5U0ZLLdfQmTUJVD0Q178Uv7/x36QvzbtMK+l4CzH?=
 =?us-ascii?Q?vZwJDXtm6SC7wso0+NMiviui32aUaDpduASZl6D/dKflPbg7XBQrP2JKYFN9?=
 =?us-ascii?Q?jIghKy/G/XIDvJQQhUQwQLuYnTTpdKUb3cNDCTLj0RoJMJ+W5Mifs06kujtO?=
 =?us-ascii?Q?7yra58ntH6/Y/UQiWwswyPlXGOJRnQIwKtA/s4UcHj0QyDPJlHwHfm2cmKFd?=
 =?us-ascii?Q?rMtxHbpMP2huLHnmkuwGpybx3mc6dg39luD1k3YUfag7AHWKpQmCjZfIz/Yl?=
 =?us-ascii?Q?Tr08iQhJ30LXtpywy881btH/2Wr/J4zYiPFwk5lj3aVaSH3OmU+6h3kWTyLv?=
 =?us-ascii?Q?hCUmH/HKg6Nya2o14rmekPyFEG6sUTcu8HAJtXI/lR54ta7NcPRGyJ0KW9FW?=
 =?us-ascii?Q?kHkbWB2S0L7U9HqTFG3CXUYPAAje7reUHIm/nfRzjDnGxKwJbu5JXx5rNm78?=
 =?us-ascii?Q?3Dmths5dZdi1GrM1nFxiCwfR3gSUJ+K+Qc5kKfreuXUZH4R0GXs1oQwq5V5P?=
 =?us-ascii?Q?pTd/qvgKKJtuUJ4GqHiCwdHDbL82MFD9HAHvDcgeaO85KeaU5xx8fwnUfE97?=
 =?us-ascii?Q?2y2DI/wK1RLYGbJ6/n5nU5VyCR6hbWdjk4SUyjuH8+A8tfJeVMa/x57akR22?=
 =?us-ascii?Q?MWjrABtuOU0N6TUjk4StRfwkCdoBQT9zryEqNs6YU6x5C5Df0tgaldMwqYLC?=
 =?us-ascii?Q?erw3NUB7RoH/3BO6b9ogOHV4xzSS2u3T/254kpkEpCxyquUH+0stVuLDYV3n?=
 =?us-ascii?Q?hOrpo84I41VLmnPdAyqzhXp6hmV0sHQbrdpKxuBckyRxtL3ZBdm6DhMxnoUr?=
 =?us-ascii?Q?pbI2tJvz2u0ZHX+5a0zxW9GEcWQQ2cAQq277P1Pj/Vd0YFcKA05+FFE+O9Fv?=
 =?us-ascii?Q?SzpnLWgjAWq3mRxyqo7yPrJ7rHJscrdFNt0dovmfdnC5rkJFOQ97ChnQeaWR?=
 =?us-ascii?Q?CIlzpPyu1EI/CdnTnPQxf/JdnmPuWHKtGetG2zsN6H2ExKczv86A+YXg6C7/?=
 =?us-ascii?Q?Rfr/xDp13pgeQYOCiOwvIocEzGHLSkVY9C6stEvpvc5aiELCAtHGSkzyZBQY?=
 =?us-ascii?Q?hMcwTn5fEY0X+4cNm5JOgGS1pdF90ccCFEVp/OVfsmwPitz+RQw/0+mitjt8?=
 =?us-ascii?Q?GQKlN7gDEkavcRFQyal7FIKKwsWbfv8ZUIw5wUDNBL2/tIdfZQQxxafQv0u9?=
 =?us-ascii?Q?4kxDG0NMu/dMsTPdSGF7iVMH81hyY3d8k5rtKugh3feGfarIZTfBML+GFZoZ?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd76fc72-e3f6-4818-6c79-08dbf0fa8419
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 16:44:55.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4aQiD+mVt44QpPI8Q1n4rvpI2BdwSZ0sv2Pd48b1OFTUJZeRlD1o3jrwjO1vvByQulgCE+PXChzf/QYU07htA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8149

On Wed, Nov 29, 2023 at 05:27:00PM +0100, Andrew Lunn wrote:
> I don't want each DSA driver having to walk this tree to find the leds
> node to pass it to a library to create the LEDs. We already have code
> do to this walk in the DSA core. So one option would be the DSA core
> does the call to the library as it performs the walk.
> 
> Now that i've looked at the code, the core does set dp->dn to point to
> the port node. So setup_port() could do the call into the library to
> create the LEDs, and pass it the ops structure. That seems clean, and
> should avoid DSA core changes you don't like.
> 
>        Andrew

Yeah, there's nothing to find, they're already found, and available in
of_fwnode_handle(dp->dn) during any ds->ops method you wish. The library
code for netdev LEDs can take a reference on this fwnode for as long as
it wants. Absolutely not a reason to call back into the DSA framework.

