Return-Path: <netdev+bounces-54639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681F807AF5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3272E1C20AD6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E794B15F;
	Wed,  6 Dec 2023 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iByl7w8r"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC612F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 14:02:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPzWQBdwrqeuJ5rkUVY4ALGZeJx4/zemJLTzpcLNP32FUN5iphv5yfCwhq3OvZ9E41NizZh148E1fsZcG6KgpZs+YM8XD1snVCokpd98YpPVjI6Gl94+JPrQs4lGWhE7GDn0F3fCSLdaUciFdIA0XJKcja1eI5MXQFhq3+vaWbaaLEJjfelNw8ckjRE1B8pqnxaZS3/LBSvwgAyPB7dl5ldPeW6BaLNnxGzFKP5m1L7vXbMtmGgBG1XmSJTLR0fl5liOZ1meUl+4VSjh2BbHJ73HnXCtdVH/2SwZ+o/cDu9pfr52JuCRzVWByzdfX2b4L4b56gMqnXPmskwMHWs/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTZpOdohPBJm3LXSfdmLziYzwEj2dv9CszjLrnZZDms=;
 b=MCd/24A9SRdj3bDRl1OtVU1MBp0KOKXRyYfvZ9b+QEh4z3AWavwrSBgv0ZL1cvjT8IAIee5KAPHH9uOcAsCz9ceZUgwgjN+P0BztIdbXGqDXXI81Tzd0AwbazrFpNDGPxxf7REldS3NIiT1uH7wEkPakEE6+iN0vKC0VMEIDqdeGo2ehpfidEvav1vecLZm0VuJ4r052M3mWvRiQLdRn0OLjqnMeeF3N9o1gofBAZxCtl3o08belrts+Z8AA2K8oXiBawoleG4zR/JmDQTonkedi0biW6SpRMYtUbk1weJXCp8Tiqwn54addDwgOrgbQHqfCD2kvoTvsPvmDGwaGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTZpOdohPBJm3LXSfdmLziYzwEj2dv9CszjLrnZZDms=;
 b=iByl7w8rY1BV9MLwmCfv0fsNgxrR8Vlq7JgT9x6fB0NVeKH/DuZo8CixOw+xBPJZTxkh8/CXzClTLn7vv7JqVWuVWa00q/JtG4kUab3UtVve2GIAPpBleAYLJBrtq9sCn689OH7aCnP0O/KWfRGWV4XakfcRa2UIfOLNsJaCdfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB7613.eurprd04.prod.outlook.com (2603:10a6:102:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Wed, 6 Dec
 2023 22:02:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Wed, 6 Dec 2023
 22:02:32 +0000
Date: Thu, 7 Dec 2023 00:02:28 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, linux@armlinux.org.uk,
	michal.smulski@ooma.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for
 6393X
Message-ID: <20231206220228.lbbrm72ubd4l4s5c@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205221359.3926018-1-tobias@waldekranz.com>
X-ClientProxiedBy: AS4P189CA0067.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::25) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: ba628b57-0beb-4233-a26f-08dbf6a70bb9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 JTz58kP2Ycnbuq8FDgNo6wbHHPKX0k9O9rCRYOSy1ffzFJKTsPUokDvyZzGdSI+jt3UYytK7hxPtlzcvcJOgAPmdnBDDcB/yH1FQNPtTlE24RJwj6hmN5GVSOTsO5aoo6oJhGk4jJ6NGi3KJoWSH5FSvggUBbaKJxUd5tkWWEnLQ9uYYpW7d97ZXbLwnUGvVRJbYDndrrBSFri2D/m8msMr/n64zg0EPW1jkfGbjZ9eG/S3ynhUgEUBvnw994pHmX5ArHXp703gcmpNxnXPOFre5rksx9tuq+TLJtLxQ8hHmH0hWgPqeDfBysA10fb9iepA+MNlDYQHFMbLXtl2IqQRgxdUZKrm1Wad7BAbRqn5NZEEDUte1XbSg5YGBgKSJPwDte490kRKBnXfns9UEp/vwT2zPCom+H2CkAOYBs2gWtyh0rGQ7H8teuP6QDMOA5jhcO/u+/4Jin2eeEaje7XARlhx9BCfDQK1naTe+Y4XguGS0gbCKSeZ72VChDC5wbHPf28Dc1qYtpvsEVXj7LG/1/CktnswJucRwDGs0ApWC1BQwwReJgow4KyF7JgEZ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4744005)(44832011)(5660300002)(8676002)(4326008)(8936002)(2906002)(66556008)(316002)(66946007)(66476007)(6916009)(6486002)(1076003)(478600001)(6506007)(6512007)(9686003)(6666004)(41300700001)(83380400001)(26005)(38100700002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?O/kcpUKeNNHOYNg5kJXq/VXVuiXI9DhShMuCau9jtTxVRnXZjmcn0ux6PEMF?=
 =?us-ascii?Q?zegd/bQ+4vC/0K1Bop3iLlpO2hSO8WVmU9kgX08NRkbThHopDCHokUgG4MMc?=
 =?us-ascii?Q?VoMNl+5DeW65E/+SYAAlk2DSczBq478ckwBiy/5Wje4jYxcmyrGzW7bkhx/1?=
 =?us-ascii?Q?bFM5aglTEm605lpz3L2XcwKdpqH2Nnk9rIZpBKQt/hw2ax1ztD4tXctoz0l/?=
 =?us-ascii?Q?lMB/0eDgBacfPuC7RvBv38UPk0Q7aPb/Gh1hr+ZYYODjvV7OE0oxexzkvtp4?=
 =?us-ascii?Q?nssefcig+cHOt5L02Mnpw4nSKuWfu+1JvSUjzw15bBUizcDn7yfMSQyZ4bhR?=
 =?us-ascii?Q?NGE1wL35d+JbOg4V30odXTX6OyUuPLCHKdZoEJ52lMUX1hCQ0A7He7Ltokoy?=
 =?us-ascii?Q?4mWDb64iVXDsYaZwKyEqdMxv6uq96tiSsw7q42HNA7Rv253UL5ER+jh48IAN?=
 =?us-ascii?Q?NAD/sLHc2zdiPF/mU08V0YX4Z83wYgoKMtMW11ePS9jC2ZVtxr1VGq+7DgKj?=
 =?us-ascii?Q?Jdlz8zbBcUCITaFRaP7DQepadqZ+UpMhyHUWH/0cQcIft0bGhU9V1f6A1Iai?=
 =?us-ascii?Q?Aa23z2wcA5irIAG1WXoRZx2Y+sVmg68WU1aJpeBWTtokYAM3+HvdWdzrep4Z?=
 =?us-ascii?Q?9FyG9S5BMG8W3RY2u1iUdRTPR4LPyDHaiMpm972WBqnjS6+LAruSz8qhpzgT?=
 =?us-ascii?Q?Fxajl2FEickhbLrVoLecnqfVAJXNzT8JyTMcSLSUgNEZfGPo+jBa3UYa5i1I?=
 =?us-ascii?Q?FvzEdX901OinG+bptN4gW+9B5zMLGTKB3ztSV8BV+aJquvgs0Iy/j9rJZcr4?=
 =?us-ascii?Q?AVodfU0hzdJ22YW3jHkKFSblmwf/sfvsdxFrKAXDmZOSmlyPkzd8RY3JEbki?=
 =?us-ascii?Q?/GgaxSt5g1NY3sd9h+oBUuFojj+xbbWf4s7yHh+ckRiCEzBZDfo6ojwfj9XU?=
 =?us-ascii?Q?9gGqzud7wjkndfJPDuYUsRqXPNnMWFMlrXtM7AkgCmpuxagF9yxe01iJ0Jd1?=
 =?us-ascii?Q?nDmBTFAb8ygBEj8PffchJUgGs2I228q7Gz+Iz54g9usZsR03DhlOdtMz4Ssy?=
 =?us-ascii?Q?0LxbJGWwoPR3SOO11YwdnlnsmqiAMysPkXOV9tHaUcsmqq275woK3znrtaeN?=
 =?us-ascii?Q?R76Qy0AsWIeNtp/halKRTHWlqPdvKTfTD5hplFBsi9Rnq6dP9HccbwSthKEV?=
 =?us-ascii?Q?K4CVMKeGoPw3jzrREmvWMlSWh3+HxVktyVl3AZ6YLQcEoSP7cDSWSWIDIhce?=
 =?us-ascii?Q?Dyv0tg911ie20RlZ1PrJP3jO0iWRfEsbziI7RSSpigeNNXSE5g4BYRpspjOn?=
 =?us-ascii?Q?/IglrlOiaRlsKj63CaQEGss4IhYkj4xIcejDpnWwHLVu2r9FYt/IyyjNqV21?=
 =?us-ascii?Q?/Sd9kSwM0eBhizhODN7BUCcK+Tn2P4P5+v7jGZq37p04h5ctxhjuCkihCDtS?=
 =?us-ascii?Q?XqEXpnXnENTdoKAmF/qf4JYbTUVieXuBT8tQaCc99yy/+CQNK8uElduegEdU?=
 =?us-ascii?Q?yGEwCS2X1cJ/o0r/0b+0hxzcVTYKFmbYvo/Dye2ALKL8BC7zZdXLkqBHlAr4?=
 =?us-ascii?Q?iJfS95EpA+pEN6nXG4T8Wmbs45f9p6gk1K7NlZ1FVc9hNHY9OZpUlFENZI/X?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba628b57-0beb-4233-a26f-08dbf6a70bb9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 22:02:32.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWAeZ/aleM0dPo4sZ35lZvzcmUInEhIRQNJC3bFnc/f4pQZowhyBfeyFUISrUh2g4ahzZdFclttceJBZbOWYnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7613

On Tue, Dec 05, 2023 at 11:13:59PM +0100, Tobias Waldekranz wrote:
> In 4a56212774ac, USXGMII support was added for 6393X, but this was
> lost in the PCS conversion (the blamed commit), most likely because
> these efforts where more or less done in parallel.
> 
> Restore this feature by porting Michal's patch to fit the new
> implementation.
> 
> Fixes: e5b732a275f5 ("net: dsa: mv88e6xxx: convert 88e639x to phylink_pcs")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

