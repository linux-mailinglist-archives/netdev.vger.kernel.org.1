Return-Path: <netdev+bounces-52178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267387FDBBF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C32EB20D1C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B738FBB;
	Wed, 29 Nov 2023 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T6buNzm4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93E0D48
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:43:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDLdPaYLJ0jN6wi+96WZhX9Ivj8TihDiIuzxIc+AzrZYfGZrR5rKPuv3GpS8RoIHOkvJ2nMOnFuo78HarZCToeClOwmMr5mZUWyDVunmuqh8878HwHcIe/BhvmE6c4OTdvqTlX+oep1mnthbLNlYsXmbTrpVGBJDc5dNz4t9UNyphjOONy+AvFB512p/af5kF0YxeL1uSI78VJwe+eW1CjXZz7NUcQHF/FBbD5sK986A+v/CG7ha/dEz7WzdyakxgEvh1E3mhAYTzqnVVMh4mJzAvGVkAs//yuZdwrhXvbEJFcpD/scHdeMme6gXd5QXDOvlMiOzCDFySFQ3RsoOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDOp4ECtEixxrXRSGBWIcS85t0xOBVUzUjfDruGr/iU=;
 b=cgJcolahgkiJOYU2L8BIr874hAeiOQVJsiHFOcXZ52UGiy5gl12P2Y38toLXbtH4r37InYXONb0ciX1OAznFPVRBxQ9s/HaXY3TfsgJzYEuD1ee0QmaGDhgW3ueLCNTirs5P9VI/HUKDm/Jf3Fd+4/leHiGnhS6lUtWRFEOw33mCxZKs8o+SSDdOJgX6P83iPjZBZCA0/dmNZN0ca1bSO3/bgMOrWDIb3i+gRSvXMo3MhGQ7jiu1WY3uzVHRZNziJB5ZyBRbVEJcaybguELJWJRxj2ndhxZrLWIiSrSgvRkVlUSNOnklY9l/rWQbuNQAMpRsVV5hM2exy8lKKSN72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDOp4ECtEixxrXRSGBWIcS85t0xOBVUzUjfDruGr/iU=;
 b=T6buNzm4gYxr2tKRXwl2iIKWJ10h9sgl2GFy/hIPZekNgyJ1Xlxcvpb/8xuCurBu0Nt6Km3BMqlHAqUYEou8ftzhADlNpnx5cDW/LRtiu3HfPbAEQMLQBfa/nCb332fvGGJTcyEJgNPCyiBXXD+ZnnyEfItsOFPL1zPY+2sE2t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB8PR04MB6826.eurprd04.prod.outlook.com (2603:10a6:10:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 15:43:39 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 15:43:39 +0000
Date: Wed, 29 Nov 2023 17:43:36 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and
 QCA8K
Message-ID: <20231129154336.bm4nx2pwycufbejj@skbuf>
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231129123819.zrm25eieeuxndr2r@skbuf>
 <a0f8aad6-badc-49dc-a6c2-32a7a3cee863@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f8aad6-badc-49dc-a6c2-32a7a3cee863@lunn.ch>
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB8PR04MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: f949ad1c-4f45-48d5-dc5d-08dbf0f1f4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aSplyot6iTr1TxZAiXS3RJy6gSqQOfegbvRDjUIm1EgFcFZ73xGolNEDPrMPYWp6AQYppWMqLfP304G59c2l9Ntafu+pfaYH1CJGXaYQXcdvUuMV1B6Niri5mc9l94483xiVLooBtJCwJNHP+m1qCaLMje6Zwx9ATKcvyu3giP/jCgdQsm4N5SMaT6RmkPigJSuuAY4VULFqCnNhMHQvyJf1p03IkUvnLfYYnPJYpyq3COijYMrY+pjsGdCG//Y3LvUeIVI1q75AhzEG6t+9n/P9uWyVXYBfZyShqR7/8SAah4E+cI7SRCoZ1/Xk25jPaKStwvvS3+hvoPj+9rB9et5dWisxagWmJp4uqQDL5G00qRLRvW4529lDXWFfHdUjWPjoC+cqTD7H4s14oRXSJX8G88Cq3aTciZrMFP6olEvkwKk2sCWJnVLjQOqQoiBzzPAUC4kKj7Q+EMo1ogk7nBybaCFNhRZ6dqR75O4s+JmWSgUVPUyRahMRuLggKsKDE/JUKk4sjr/0hBav0MmuVJBNdfhA61XsmwA02CC+0+dhsE2mo/Mfnq4hGdAh5u9eVmdfOGKaCRl/zn7q2sjLusM9t2ZU0in43DgOY9Vq62g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6506007)(6666004)(6512007)(9686003)(44832011)(5660300002)(4326008)(8676002)(478600001)(6486002)(8936002)(41300700001)(6916009)(66946007)(54906003)(66476007)(66556008)(1076003)(33716001)(38100700002)(26005)(4744005)(86362001)(316002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I83N3AW/K7Vub8hiHR/1Gg+KSGZN5CCssf4hOHeoBJTWdYWfx9mS72fiPoXh?=
 =?us-ascii?Q?DcCCQF2nbA35TLf5tvWlOZ/yxUWaIuvWekwP60MVuKGMa51gq5l4bLlMcdWP?=
 =?us-ascii?Q?XzDfvg4dxyh4WDKcHSVK+IFIDopZwzlmbG109rrWys962bmFXjI1al70or7X?=
 =?us-ascii?Q?El+TG7Cw6Zepcs0G884e4KYfVAr5363GeSpOMUrvE0IBuAp+rhagwSUdxDs+?=
 =?us-ascii?Q?4raFB/mqzVP0V+AypmMxbWIpdhlnkkLo4PbSnlczLFNviCZRp9UJX52pany9?=
 =?us-ascii?Q?Uf997RmW1y6Wb72bC0cZh2+pflPbhqEmzKZaOQHU23n3A4Tyq56v87hlwJNY?=
 =?us-ascii?Q?FDed+af+qOVJ3IvFkaw+t+SMVGmscv3DfoDTbfGHa7SQgOIPTuWTpA9PReED?=
 =?us-ascii?Q?t7iXv6ZaLmZCIitXdOUYBtytyVoVwnGPqxOK7sXmZJmMts6KmpWW+JS3JZwg?=
 =?us-ascii?Q?W1qwiTbEKwPL+kUumZlgiRAsjeIK04gu8Plt9FUQtQ/SFNjnZeSGyeq0Ka/U?=
 =?us-ascii?Q?rTsj2PPsd2cazI0BzQUbiLJdJzEJgbaZlLeRhTLvntt71Vif/mOh+dXrkPD5?=
 =?us-ascii?Q?xsqrZaC/RnFbhi8E6FqyRlPWy6W+X6viud9ohy+JomdVC0FQGovnoEqAb6dB?=
 =?us-ascii?Q?f3viMqYc4uAfYTscAFoMnSzAX28CdsPQceV+AYxJgxoFKiS9MaNUiOPizQ/8?=
 =?us-ascii?Q?p82td+qQDU86ENtCWg/mGbGVKi3rzOMAaY2JrfZKFhu74dRcom96wtZZVKRH?=
 =?us-ascii?Q?nfARQi4EX4IyckQ4zTIT6sbkjoGKsbaEq3N0IBy4mNxh+BnysxmSSSAtvlc3?=
 =?us-ascii?Q?4hWPs9oXvVeS26BEwcWsqORIddd7hF6tPZZVL+0YUwByQ4qqD+mXhA27LFyu?=
 =?us-ascii?Q?W94FqTZRALtnT4lGF+xwtBd6NntHnRZ6DuV1FpUjpV5gT/w0fOBAbsFEN4k4?=
 =?us-ascii?Q?/1Ywq0yYdlL4LPsxGhfPgGNhKA9ihgpLhVZUAJpchQaEGObD9M3c6yuJg3jI?=
 =?us-ascii?Q?UqCw+G4b19rHdJRyomihx3/eeoUpkNxJ11M0W/gpM4DCEmuPjnsm6+6t6Eeu?=
 =?us-ascii?Q?ORdPORmeAKvda2rhwyqtbP99ukCws1Xeczl3TIhuErL6Mtf4l9/oLEbvmeJ8?=
 =?us-ascii?Q?1i7R1tcAPLp45zvsg25wvXltxjH0xlBciIXh3XQZUO46pwruVscmfIGLfVMs?=
 =?us-ascii?Q?mes9MeOBAwWLh1q4HzXa9ObkNlErd9+1qCjlJoilGU1cuQfXDp02JAq/XBeI?=
 =?us-ascii?Q?9pFO4UCT1B1pWn8evIMpQ/Y6/oJVv0Vp8WUl5UfoGRzVM4UWyluMQr3KESC8?=
 =?us-ascii?Q?MPxcwwagt/FO/3jKOaQeoqrqFZCwUBdLSOPHchojlFcqrV84iUVMhVDe7hu4?=
 =?us-ascii?Q?mNf8BCJbfkAQ7Ebtq93h5EuSzN0oHtbvcxytBxUelIXxBcvpwIF6AtxGL5s+?=
 =?us-ascii?Q?WwRh3zJ3VGPIgjBO4LMIGz2TymLiON1Qg/CWgAlUBQdgyUyPw8TpOX6kk84d?=
 =?us-ascii?Q?JJBLT5xfiyS5H/J61BZAW1FQkvRppAHeQXUdaRGI/uD5KPjyfmOI/C2LwM+O?=
 =?us-ascii?Q?chw2NpAahrqMSZ6gwy5b9D/ctPanLeE0UnH2vlH9nd3le4I1xjnIB9ZE+GsS?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f949ad1c-4f45-48d5-dc5d-08dbf0f1f4f4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 15:43:39.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ajV9BDtPPJfXpEOR9f/dNN+98z3UKjp0yZt/CFWayz046EUmV9L7FB09xmNSAjSmu97MvTl9j9QyHgZqvHFtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6826

On Wed, Nov 29, 2023 at 04:13:00PM +0100, Andrew Lunn wrote:
> O.K, i need to think about this.
> 
> What is not obvious to me at the moment is how we glue the bits
> together. I don't want each DSA driver having to parse the DSA part of
> the DT representation. So the DSA core needs to call into this library
> while parsing the DT to create the LEDs. We also need an ops structure
> in the DSA driver which this library can use. We then need to
> associate the ops structure the driver has with the LEDs the DSA core
> creates in the library. Maybe we can use ds->dev as a cookie.
> 
> Before i get too deep into code, i will post the basic API idea for a
> quick review.

What is the DSA portion of the DT representation? I see "leds" goes
under the generic ethernet-controller.yaml.

