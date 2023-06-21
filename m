Return-Path: <netdev+bounces-12648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B23273857F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF981C20F3E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E301B18AFC;
	Wed, 21 Jun 2023 13:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEE17747
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:39:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561619AC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNN34BA4UTmg2nFeiEZY16qLCqB0Nddw3Sm6PvKqN5/a/U0x/H5VzQWmyFdKFCoHNo2OczZ2mZGfnpF02BYnFlRKQwNba0sQm+5HMPSDy+3wjI/woXZs3vzUAiHpAyd+JngaE7NWJ75/xeeT+/31Hmf8WDw7yoivrrIQPVbHUbKojgJb/4to0HaOCEpweDO3Z6bG1bHDKZF2RKXgb642cA2PaWH2gSbK5hxq5hm2AIVnsq86aI9NaYVSGMbE6s6XVl9P8T+Jd/TYLeASV/M1BmiYsbqYXrjNFeA3KnZNPjmSOfFZe1Jw9kkDtxedd3jPeH53ykSAYMyZRLfStEw43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyGginseEyld+OIYkx18knGMjNGRafHyf/HaMSQs+b0=;
 b=PbIbvi5zqOgmnm97aixrnFWLmnRnSi9a7QEf05WVY1nbTe+jX827NUt14e5oBy5b2JNPJd7rJuydbk6CN9OlOpLa73AhDOT9ar7W8A7CielIzmGnTGFqfzf//rTI/OewB0BK8xhZhDGYy4dBnkpuW9K0os17UeUvv0rhiKa5hg+M35aJa/xa9ocPJmRcHu7XWuUd5x7cfv2GcY7k4L8YB9XDpnZjQuejwmQbc1iSMSYujS6LQXu84t6DJfK/OMbm3ePqpudupfD5vC81XqAnjWkBtL7jB1ZMLUBPwqsd/gAHDJKAZVZLsoFH9ZTOomgXPj6UBV9VdSjbsx7O+OjMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyGginseEyld+OIYkx18knGMjNGRafHyf/HaMSQs+b0=;
 b=JPiaiSVh2BRJRZOmbQ72zzyHHE1NsXx2vjoVzVOOxtd5idKGc8RoUq1drHk9aw9K5HASWYLeeFXV5c42E/cg1qxDB9iLNUUK+eAIPHw2g3/0OJLIrDKzPkG5/jm27ICRsQhlyH+vR9vgxLUMYvmi/ZIOlNJQZznQo1m5Y5iTuA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN7PR13MB6201.namprd13.prod.outlook.com (2603:10b6:806:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 21 Jun
 2023 13:39:27 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:39:27 +0000
Date: Wed, 21 Jun 2023 15:39:22 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v1 2/3] net: phy: phy_device: Call into the PHY
 driver to set LED offload
Message-ID: <ZJL9impjnKMGFTWf@corigine.com>
References: <20230619215703.4038619-1-andrew@lunn.ch>
 <20230619215703.4038619-3-andrew@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619215703.4038619-3-andrew@lunn.ch>
X-ClientProxiedBy: AM3PR05CA0096.eurprd05.prod.outlook.com
 (2603:10a6:207:1::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN7PR13MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: a3638ffc-cd1a-4753-6579-08db725cef1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iL8F+GCH8RJa6r9+B+xKx4vZFHcLNy6Qp+x18lfFdnBBGOf0EuEgGNNOP6+OSMAGIV8jett/NySVTeP2LIq0HtlduDjYwLhzGfvMHpmuBMAOWann0cAdHwkyq09NpffbNrP7euzbSeEe+nu2DVssJu0VEmi/fOzKycMqfjzeLUsocnt3y1WnshoyYJkaSx1swZg/A/wJ8m+ApkDto3Q+AmfWo1KTddAxm75zv9N/0f/Do+sadqpPmYeJVRuOEEwNjePf77vQMKHz6Yt8Znj41Ok7GfZXtpe8bvHfMh+1eR7NJ2gsECd/6nYD+O0KROGSTrk5/VibqCmOXWVEuuRLwSsqKwgvdpLxLG0Iqlmd6Tekn4pQJ79fBN4maR3dS16GU1XTQuW0G3+mTqyl63CC+U0JTbWJ1AfjiJiw6QwJ/aceaQBW2moSZ1Sd2uO2jUza0DUFtC3blsZdcrTpYMQvVlNltGiNmApU3cfxvlhVUG0siyKeH2mHD0/SwaaUEkwdGX+t1fOcGf0YhSH3ip1nNVweRmpHN6OHH77gWo788Ma3/9YbIseIm1VxCl+nft1ag6NVDUkqd03RkZNuBEV4i7yfLrvWYtwhmW1ZxypXX5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39840400004)(136003)(376002)(451199021)(6666004)(36756003)(6486002)(316002)(5660300002)(4326008)(8676002)(6916009)(66476007)(54906003)(66556008)(8936002)(478600001)(66946007)(41300700001)(186003)(86362001)(38100700002)(6506007)(6512007)(4744005)(2906002)(2616005)(44832011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svEvV3biwFfThrc9UxgfMOlLXHtjes+4ouKKQO9dZCFzW7cuH5hju9XhSwdM?=
 =?us-ascii?Q?h7XRaU4l8VIPJ/WZ7CuWl3Ljj1WjBizAvaFLMGXyOtmIxeaM+04oFRESHnqp?=
 =?us-ascii?Q?/XRE+DTR2N3EYTKcif0orGyo2sWKh8BTvwiexexCbAg6iFz0Ljp2yVlRxOJx?=
 =?us-ascii?Q?zmbY/2nmWRNAdTvOl8YQVIRee0gNMXmpa31HkSWOf9x4b2sH0nY5mKGUZof/?=
 =?us-ascii?Q?NGvmUsja5h1PWS3d32T0/yzelFE8D34Yc/j37c6CGycLzfmaWtIOyXs8e4//?=
 =?us-ascii?Q?vsai9fbIieBizIHwTd2j7/e08hPJoEa6LPcrPQ+NWfkN2nE0ToPS87c60Q+n?=
 =?us-ascii?Q?cqmqLWlTuhaVnH+kkMZWOxQ4sEn8c5lhD9QEZKsEwVrCPlsIlrbvJTODg9h2?=
 =?us-ascii?Q?tg3L4iiVm8cgS0OdsYYeEVmRDorUBE8dLO2NM0/T4I6PhcslFzCNpo7/eOMy?=
 =?us-ascii?Q?W5VQtjnI+Nd1IZRuIc6TEgfeiOeysOASh/3Fa2IGj2CTVH5N62fQyiUyqWB9?=
 =?us-ascii?Q?POPiuLP1m0JME5zcRCC2tjdMF+gadLOlLiIqPDP8x9kTyfNExeKpRk8XrafV?=
 =?us-ascii?Q?nhQ3tsbSJgSgRHvjcn3clImiJ1RBsmeGM3oXTOEyQbRuo86IT26uZUGbZu8W?=
 =?us-ascii?Q?Q+RI/TETM7XCKbMjNc5Vq8H/rsMX4WimcAmtNMeoGo+otgF6MqYz9suqjYTE?=
 =?us-ascii?Q?m9Immy4nUuDTaBaK3AKmthMGFdmwOb0viSN5o1jAgvJhJ5qees2d9hA4hhMA?=
 =?us-ascii?Q?0j3AULcxfO+X2Zv3b7IrUAzwxJQ8WkEeFT8Jwb/WOpuznwyeq8DG5evJt8Yx?=
 =?us-ascii?Q?e+Tn3TUUUvHFmOZp1qi8Q9LO7kHpfInOAODaC07UkhDHa1f2OMuiWxjRuxG6?=
 =?us-ascii?Q?walSlFKaiWC18cq5Z+Wg0YnxXK7uEwH0RjY8kV8zG21saAeKr1cjq4Ca0NnZ?=
 =?us-ascii?Q?8Aj8l6eqG/JGuonqRPo4gN25fYKb4zX7EmZ9SBZsTwoBllJTYmbQ114PGwJI?=
 =?us-ascii?Q?v+MK48ofDaRCb5zOpk+OjoTBsyuon4MGctf6CfbkiJTAwhQujMtJ4/+IwRBW?=
 =?us-ascii?Q?nkkI0v328T4VRA2RRVWNmIl71xvWSsSJuMV4E9KM//G+MgQSfz+SM+ZbRqQV?=
 =?us-ascii?Q?MZfJ0Kq7A6Xx54JrTYFgXLWeX/GVJ5WRFnzMPy6xMAgbDUgFUFLYfGsAzNAY?=
 =?us-ascii?Q?yZtmTouu2Y0RVsi4/TlLX0PnKLFqaCDS9YgTLsKNEznpyv3mR41PW30ugY8y?=
 =?us-ascii?Q?wP9PSDI/ksCyKjgu+0SjT1h8/6HjWtt7zsuR96llYw28g0FDw62++sP+LJxS?=
 =?us-ascii?Q?BQFADKLtGfhhWIR+r9bwdJtwu3I0RoCQmPQKpvv/qIux2Y7yZoJqWEeV+LuX?=
 =?us-ascii?Q?nLyC2w5q/pxokQCDnw2VliFFTY56nhdItqiWUX7vqitLH+GGPWV9mYhMPepM?=
 =?us-ascii?Q?R1q6vhMm3kjhP8L9RPx5o8qe5XMSvxmiZr1ZgB6b+NuXiI8PyPGUb0o7XNpM?=
 =?us-ascii?Q?2ZBXUD+pb2BmCni/dmO3ueIeMcvv/QQMQjzelU0vl6kInEhur8RMN2CIaT7z?=
 =?us-ascii?Q?Nju8dpmD+91taxKjY3q1ZmIHZp9fIliGPMaTayg6XRU98Qbs8TzoJosed5rI?=
 =?us-ascii?Q?qIBY5hkB6QUJ+24xRFoQ41F9VhqxPsZhUR0N2ov5zTZIqagygBysOPipwLeC?=
 =?us-ascii?Q?idFfiQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3638ffc-cd1a-4753-6579-08db725cef1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:39:27.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW6NRrQRiZ/wFXV5dHfsI7RNfrLXwhqU3ZRZhfqCs06wdnHh8X3IiCquuvQOim33iK3PVN2r31GzpdD8mKTik0nVji5YQSF4S/YuNDtOX4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6201
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 11:57:02PM +0200, Andrew Lunn wrote:
> Linux LEDs can be requested to perform hardware accelerated blinking
> to indicate link, RX, TX etc. Pass the rules for blinking to the PHY
> driver, if it implements the ops needed to determine if a given
> pattern can be offloaded, to offload it, and what the current offload
> is. Additionally implement the op needed to get what device the LED is
> for.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


