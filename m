Return-Path: <netdev+bounces-24422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35073770235
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5FD2826BF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF021C156;
	Fri,  4 Aug 2023 13:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C75AD37
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:50:00 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A16B1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 06:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDXIcLgNO+yyX/9Ddbbmtlqg2cW76/ophsvwv0rR4wXIisf2iRNufSfEcNvWrOdMA4obiDRUQTgy3UjZko1t01aOciNw3czxTCL5gdmToPGu4Nkx4J3EQEuoWkLjyVrMQHr9UfZaQUMViamYLXQiDX+NOs8qZW4opJQKpJG4KY7RQA52i49kwkm9tTHfUfTWmOjjJlWPsOdPriDdCcDDbBQ4Dq8tZmgjkdyXhEZd2H+greOsCyR6aKC4vMC5yL1Bo/h0FXAdwsikjLVX9X4hsTaztAmiezKXsiZdVpQhn3CyOOrARnlLlKjXGLDezKZ0TBJYJyqiQ74v0KlpApikVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFMbS8cPUToWrEW+zWLq0b2eBrdq3EOING88M/vutfI=;
 b=EFgSM0OBLVlPhpV8U2BXYj6rzP7kL9CtlozfG4IH2zm6JM67hHisWjdOKLcQWCgP4/jOSgjFO7GvUUTHwQ0xwcLWxwp49c5p859dXgTnSqJsb0clDIHOSybqVXyGgGRlgVVnFbG6b5m7ZbgndkQrOAlxlEsJHl3vZZbXpJC/Spgqxa0qXhAj4bvl9QH+sJj8xVSAL6FtpqKpZ//RUl1BFLA3UkHC6wFnFF7xNISnAAKTG7wUuxMkmKjMSKd+c/PQBtREg52pHRsHqEG3UTOnZEGpc7rTOg93zJnyM8RCOZcSTlCTmxTYza5f8HWGKFHufY4MJnoS+db8+jORe4hrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFMbS8cPUToWrEW+zWLq0b2eBrdq3EOING88M/vutfI=;
 b=m3jD4u+y6jQCawwc31yyfA+G4snRe7RpeqCq9jCoCclKsozI3worbn9NJCLLLsL5/7CXQu349IKU2mX7xk7Stjn+Q7cn0C5SHUSNk9upFZulfdIf2pMk7lfw9oOoEM6CFUMbsraQpaxwJh/qAykZrPkkSPsV/AzuGfRsHlsQy10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GVXPR04MB9903.eurprd04.prod.outlook.com (2603:10a6:150:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 13:49:56 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 13:49:56 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: omit ndo_hwtstamp_get() call when possible in dev_set_hwtstamp_phylib()
Date: Fri,  4 Aug 2023 16:49:39 +0300
Message-Id: <20230804134939.3109763-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::11) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GVXPR04MB9903:EE_
X-MS-Office365-Filtering-Correlation-Id: 6898e755-a06d-42e6-ebdf-08db94f1afe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ERaFLagDkFP+M1kSkw4THvGgAXAJEMSt6Fkxzf/91rLWQbBjJvlSuie2ZOz5arL6TtQWcGcwNy6PinKoJ8u0Qmw2FQtlUHnHg2LG3nnsupuxEPHUTDkmdEJuxgvmWphNZk0FRgQ7bEyjg3uki+c1WresOq2sYgVD/B3VxPs122Pd70P9H2qPNbFFhCS/BWWmy71TJG+/+R2B+hzHyPytJJLNDJUCbonar23/CNWxNfjrwRHr5HPOPdwWgbWa8H+tWVrKAZV2CJH+WiAwA7JZU2dTvcjpzkueMemvfOjxIsRPGpJeHl9XC0U44ykzxaYehYFxFZemeIZXcMn1TcTjc32SHjIWIdZkT7SrFRrObOC7d5Cd3RuyszQEIOUJFup+girYMjwZG7NoOWn/BxjGqVyuLNa00uPnWEN/v/eUXRmF/rEDEk/NrY0RiZ9BUcdvE32sMTjR6UJ56SHy18QxziGeZGOZJiy2yiXeFuNvh8V9ykzfxFcQbpB6V0pGgy2UEZ5OCgPuxuCX3tkgU7Ol6sx74KARlHgyoatijhYpVmS1WBkLaACyzVL2Z1PbgH7axCPE3gcKhw+jIdv+CRiOn50wfPHb58erE9gCnL7RxhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(2616005)(1076003)(83380400001)(26005)(6506007)(8676002)(316002)(66556008)(2906002)(5660300002)(66946007)(66476007)(6916009)(4326008)(44832011)(41300700001)(8936002)(6486002)(6512007)(6666004)(966005)(54906003)(52116002)(478600001)(38350700002)(38100700002)(86362001)(36756003)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xe2+GNRvZMflQCC+4KGvPevRUC02WcLRFvMUsnmkK4rgkQDD9qF+6NmsOnI9?=
 =?us-ascii?Q?BxPmlmDZl7agnbBsNjD4bQ53Qbo4fBSLn16xpyb7hcbyh+jLi8LJQrmaguxr?=
 =?us-ascii?Q?QGeNXA4mj05LY62BSpd9B5XW/Vnc/wZmtvcGuqfqiObsuj3KATdJ2uHK29ne?=
 =?us-ascii?Q?XX8rPDfdywvueL1sbpQPiA4TghLRh8jHaF5+AtS8hDFpaaznOfHD4kUNdexg?=
 =?us-ascii?Q?O0h5fuvfiyiU7A5WxwpkahBLHtAFXugijWBYaIkLBxUAXiZ8y13OnZ94IeSC?=
 =?us-ascii?Q?8Oreue7LOGH8wCK55rRCapJF/1sU4ADHfFQ+WEULg1F3WTtyCNtajt1QvTRY?=
 =?us-ascii?Q?tSUhgCPkvWJP6KIXlNEjDhbU2I+V0SPSDViz+bn23D3JnWQKeQe8gTjHFDcu?=
 =?us-ascii?Q?llNrY/3rsovdORN5YFLuLQaq2TfIg4uzXIFYRRMUy94kKuNC3BnkvYsyHK2q?=
 =?us-ascii?Q?+q1bPaRc3987MqvuAnMEM+t1CuiuvrKfoLdT2lzvIKzucrumLOW+CzkMXkRL?=
 =?us-ascii?Q?4zOPWtkgFJ46TRRyx04tQBNASPmu3q8PoQCVy5M62ilEmbgr+htUNiKM+hRp?=
 =?us-ascii?Q?cVYxhbTQ0oDt16F0Rkbf1OQsg3y93zjgvuluoMQ+sc785Uo2Gc7DH3bumVHn?=
 =?us-ascii?Q?rY3HmjTlKW6w4KP4pX0bvjdm1gNyxp1xFQ5Nmv5xflgLSHK/vTUuFA5jRKTt?=
 =?us-ascii?Q?pLX2NiVj8fhdmJTah8PsvZUL3+1jMkNqUsdXNrO0fkEp33r56vIpMDYay+dM?=
 =?us-ascii?Q?At11GL7r07TVsGQXSgwOwlDT3Z9hcvs139TZmeu0fnQuCjnSp7RArraRv7FP?=
 =?us-ascii?Q?ph6jkD02jQYrzSVc+014Ns9VOCaCsnN3xU3/PmY/cHL93PrKgiLj+JbIwmWC?=
 =?us-ascii?Q?TbWZ6wrvhrH0Zv75E47GWSub42o6uEY//qSycxLIrQYzrcqJ9BKVlB7kUB7w?=
 =?us-ascii?Q?DTqfg8QUF59cl81P7V/+onPcJB3PhkCvgSnU64SqI5aMEE2ourIc90YE8kYz?=
 =?us-ascii?Q?CSSjrpOlv8t9lLANszOMAXvtLKtl9X17gVJVARk/lXnjKG1eW/OO06gp/VQT?=
 =?us-ascii?Q?cglIXQnqOl6psJmIa6uONgmeqTkM4bcb9sksCo1UpZ/nZQ9JDFiv4BwEJUIN?=
 =?us-ascii?Q?cNFEFNhltM/p28ib8VwW7dN0Y0VkmbzJshYbvfTa9B03I78pjIDE3Zwrxhdv?=
 =?us-ascii?Q?ZaWFVMnaqB6TPMmWqY7qpsR1VhHCO7C0rl4Av5SHxfHE8u9IVxUOdR9PnUwy?=
 =?us-ascii?Q?3Pn0icd7wUrLl2TH63ODyrNHL4zuSASdoAou+kWy+zYJoTsLm7F62/VX0HHH?=
 =?us-ascii?Q?btImL5s3VoxUHGIEFm6c2WdbUGVBS8ril6KNex00TR50X52hQwCF8knbPEzC?=
 =?us-ascii?Q?iLe/jX6FXrqprcL6ZN9kO2oe+CNaPdVORYfVS/KgvgWjMz6GrBIMhq5ufExi?=
 =?us-ascii?Q?oHp/1/dBxXH/FcprXlZRAnOVTPlMzSdAQF6L0n2hev5dJSKMMEO1bS88ZniN?=
 =?us-ascii?Q?dLCM2cdnjuBCHxaq1bKFas9gPc9njEGVH55AWi25wZLemVRQKQx7YZizbg6r?=
 =?us-ascii?Q?4GMnfzPCiQexaX+lRAv2mgDYcl244416FYwsvROlVEVCZ747yfUxXYZt8a8X?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6898e755-a06d-42e6-ebdf-08db94f1afe9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 13:49:56.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9gj4the25UAXch6fpzn4HJyGWcXqaObhWYVplDfksDry1UtsONhVHym1CG2rvOGBXor52cxg+oUHPYdbkYk8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Setting dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS is only legal
for drivers which were converted to ndo_hwtstamp_get() and
ndo_hwtstamp_set(), and it is only there that we call ndo_hwtstamp_set()
for a request that otherwise goes to phylib (for stuff like packet traps,
which need to be undone if phylib failed, hence the old_cfg logic).

The problem is that we end up calling ndo_hwtstamp_get() when we don't
need to (even if the SIOCSHWTSTAMP wasn't intended for phylib, or if it
was, but the driver didn't set IFF_SEE_ALL_HWTSTAMP_REQUESTS). For those
unnecessary conditions, we share a code path with virtual drivers (vlan,
macvlan, bonding) where ndo_hwtstamp_get() is implemented as
generic_hwtstamp_get_lower(), and may be resolved through
generic_hwtstamp_ioctl_lower() if the lower device is unconverted.

I.e. this situation:

$ ip link add link eno0 name eno0.100 type vlan id 100
$ hwstamp_ctl -i eno0.100 -t 1

We are unprepared to deal with this, because if ndo_hwtstamp_get() is
resolved through a legacy ndo_eth_ioctl(SIOCGHWTSTAMP) lower_dev
implementation, that needs a non-NULL old_cfg.ifr pointer, and we don't
have it.

But we don't even need to deal with it either. In the general case,
drivers may not even implement SIOCGHWTSTAMP handling, only SIOCSHWTSTAMP,
so it makes sense to completely avoid a SIOCGHWTSTAMP call if we can.

The solution is to split the single "if" condition into 3 smaller ones,
thus separating the decision to call ndo_hwtstamp_get() from the
decision to call ndo_hwtstamp_set(). The third "if" condition is
identical to the first one, and both are subsets of the second one.
Thus, the "cfg" argument of kernel_hwtstamp_config_changed() is always
valid.

Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89iLOspJsvjPj+y8jikg7erXDomWe8sqHMdfL_2LQSFrPAg@mail.gmail.com/
Fixes: fd770e856e22 ("net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from converted drivers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/core/dev_ioctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 72e077022348..b46aedc36939 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -334,20 +334,23 @@ static int dev_set_hwtstamp_phylib(struct net_device *dev,
 
 	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
 
-	if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
+	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
 		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
 		if (err)
 			return err;
+	}
 
+	if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS)) {
 		err = ops->ndo_hwtstamp_set(dev, cfg, extack);
 		if (err) {
 			if (extack->_msg)
 				netdev_err(dev, "%s\n", extack->_msg);
 			return err;
 		}
+	}
 
+	if (phy_ts && (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS))
 		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
-	}
 
 	if (phy_ts) {
 		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
-- 
2.34.1


