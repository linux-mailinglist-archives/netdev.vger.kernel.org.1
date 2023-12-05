Return-Path: <netdev+bounces-54031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641A805AED
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8921E1C20AF5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3826929C;
	Tue,  5 Dec 2023 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c+e0rmbF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C51B5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:13:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG63hajSufdRzbZx4WfHi0SsosAWxJFLXJMgpKegFiNUzSxEeHN1EvJJWolkwWhdwjS8yWliLByhD8qsmmUEnLG685LOQnie00I3US0tHNw4ECyPPt89W/sX903L9G+bCc79m1CrOodLjVSKm0KkXrDQUKu0lMyU4KfB5FTCViiSAq3PxuYPY3BAhMwrXdPTz/2/MR5m2ouGBSaKzM1U3Ni2h4HoK8NbTppJrsz3lYwzLmCRUkLHdZrlI4Jf/iEWFkBcQ4ii1IosdUZM82Ni3ylUonYdBF1bwICzC69VfZ+drwPlGAkEUeDaR9JpkFAvWbBc1+x8GcLMw4SgHD22zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc7VAy1CVkWEFZTih9/ac29BPaHr6rCB3hDFtbdyMQw=;
 b=D294ti0Z3liB8mQ7qFh4c+zv9TRvRSUchpT9m2ML6gYvspce3n1FcDJGKI058p69mMAAs5rWwyfF8zcBkUUcx4vcre6yKySk++60DCyrJNo+ztyM6PmXfcylZo0GNkavMRk42QBw50sjSAZS3r5aNqRC1oVysxt3lLeSbsSBbBGptyUjS2W1L1NZRCs0hRSUOFKqbrFj2JlsPj7wNlitXA3mMSlQq46iR35oYHVgf7RojsulNxJoRTHA+ec6EAZ2guIeREn/wrekTqKm/XV1RSmE3GRns/CZt6curfEI381ITdRdhCQShOLAcNE1gvpT5bpGDNDMosWU2eu3NUmuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc7VAy1CVkWEFZTih9/ac29BPaHr6rCB3hDFtbdyMQw=;
 b=c+e0rmbFmvgRhIejiwHdoAq3V1aP4ln27Ht+Bl3j2nDtEvtXYrXvmGp9po8oPOUXvaV5f5cn25me3A3Z/X+Us5ex6OguboTNbiM8o1nAlAAOpdVB1TvaIGSqNhcsHcwJGdGOVp1JE8ke8sayel3GoG2hO5s1a05MF1Dc7KSbSeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7802.eurprd04.prod.outlook.com (2603:10a6:10:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 17:13:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 17:13:35 +0000
Date: Tue, 5 Dec 2023 19:13:30 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/6] net: dsa: mv88e6xxx: Push locking into
 stats snapshotting
Message-ID: <20231205171330.k33b3agrgp5dezx6@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160418.3770042-2-tobias@waldekranz.com>
X-ClientProxiedBy: AS4P189CA0053.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 5034af6d-a8aa-4ee9-86f2-08dbf5b582a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hMqOi41sIsQAxZ4Lc2A/orQKb10yTa+MboKYjCS5rVYA2CUL48FEPoLDQDE3mze4Lydv9Pw9NPH3/DNtzR3x/qpsZQJ6tfzDBPob3hZp8qjEI/pUwcB7krio/8QP5ogC2RfsG7mhV+nqZ9hPZVUB7YUYu7SuPBg2yWbZpqIOhV3kuTytZMYiTAr/icJk3oVx7ddQb87B6Y5KnFIpgGbs7C2HGW8ETz8iIX/PV7iM658J6OI1kILiNlrRs8721KO5fulAg5dXSQ8B+9b84VL4TyAZLCt2WlrlnZiVvvNPiUM6/C0RrqxDRY1Q9m6qVs6GgEcNZvamem1BsVuI+w3IY5hURpVKfczGquvBU4dvyfGXeSUD+HmsU3EcykEiCjJGgj6e84svb1y5a6GUOCvxSdcRqGeh7wr2k/Bx75vv9nVMmhYn+S33U6fu7BP41F0HaDvBPQG4mEzH/v8cm+3hwg/08+ZaD+Dm/4xShGFFj2R14UfVuboA55aBKATVPDELSWZ8SxrY4HrlWCSPmrd9wGlt/oRAjQrUGojGI1XdgrZP2ju0CRM0QsgGWxiMJSX0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(558084003)(6506007)(1076003)(41300700001)(9686003)(6512007)(38100700002)(6666004)(6486002)(33716001)(2906002)(66946007)(86362001)(44832011)(66476007)(6916009)(66556008)(5660300002)(316002)(8936002)(478600001)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WL/s1ZZmKbjZpSZGz9k+l4L5A5sZWAVqv0I1qgwmCYOKBWmbG0/Ct/R00nL?=
 =?us-ascii?Q?+es1reMHVWyJXYs1hRk/lVaTHsNXKw2Prd/uNtuHfmp7MxfUo10RgKQqP/UX?=
 =?us-ascii?Q?zvLdlGvkjMUHEGKJYzwe2uRZTwzCdy8CgTVZqED6vm7bZOk574ufII3ZEpLZ?=
 =?us-ascii?Q?edFM5B/Yb7VGSvS1yAbcKm4xbgeyxuS1lXQ09BxjPDdCFBVH/RoP4Cl5YX8R?=
 =?us-ascii?Q?nw+VnaiVmp+XJlKo9SwLGhS/OelSZ7Oi9X7Jz6lZqRLWwqB9T6MemNYy7pd3?=
 =?us-ascii?Q?el+XdwFic6hoc/b+YRPc45NjK9Qrp9isBR7Jq3pCBKZf0D3pwwTMmg3IeRmT?=
 =?us-ascii?Q?TH/G3ceJFENC/dIk3yl7c50nK/XAb/tfSNKhrMdQ1CqPL0WAunmJ5eYaAmXC?=
 =?us-ascii?Q?1I5fXrBotbM0o4L7ZyuS7ImLi+VEIQJ52KB2fPxUdONWghDkf0bND8rq2psz?=
 =?us-ascii?Q?9phXY9NWPNEDSf1ysrkmpR2ZpEAP4GEY1Wb5ghaPNjpScsv+yX4AFzUaH1FC?=
 =?us-ascii?Q?OtGWwEfZOo1qq2o0ZPD0v4llsG1ouPNA47ORcPfCx4v21H68aa0kF/keiRn2?=
 =?us-ascii?Q?O4hFzph6sbqzNqXy9T5ppI6ONx8SGVwy0yTfZ97ShHasDx9plRC2IGemL/UC?=
 =?us-ascii?Q?hrz7ziW/ag9i+DFczM0xVOZ6Vh2UJ1BoFzZpp41+oEw97OTQ8NDyqUazNJLQ?=
 =?us-ascii?Q?eL6wNp1IM6xCKKaR+hBSgrEzNFTsu8hevlO54ibXSKyk/DgwqH46XY6sTy7+?=
 =?us-ascii?Q?27/P/TGNhqleMNVVtHV3KuSK38J7bPurV6WqTAhZ1Bx1x1Eksf8EE5kufQTw?=
 =?us-ascii?Q?5/KI2I6P3ud2fN2ncDqZSAxzXM/EJJgGaECA1CSUPACmn0OJywXLNuK6Jt2Y?=
 =?us-ascii?Q?XhkRzRT6D+9JKrFCudth4Yg1tvv8tQbFjO2bTirKzDLr3ZZuzcyJ6LaSNIRF?=
 =?us-ascii?Q?YwJf7Ufni8ZWJkH5JM4DEPLaTXOoHc70aP8fpbsx3ep20pCkjvrDAJXmf+It?=
 =?us-ascii?Q?2GbNHT8RWssy2muSe8v23mznCibrMmoGyc0r4hIvrT2g3YCatCr3Yi0QkvaF?=
 =?us-ascii?Q?yv0LkYBeBjahED+62HJDGLb0aGHHag9SvjrTCohdaEZVZnTOv4ye/QtJu/Wt?=
 =?us-ascii?Q?SHxArw+EMl06ECsBnTam54GlLwFB6/nfeEPPJXLfuC9s24rRHgwD3aCM2D0y?=
 =?us-ascii?Q?35yE4Sy9VfoZsJGulf5e1UegPMgyuc+4Mhvt0+8qzMWOGIzmQbMpWEpvSXKW?=
 =?us-ascii?Q?ppT1UELW/OzRvI9LIeMyHL2dX3chvEA+GlmAKvh3xAwXHi0v8C279OW8Xg8t?=
 =?us-ascii?Q?SAUUPY7/jQqpRW5fdivY7jPXRcfTGCefhzZY62YQJLmfG41IeC62O+BMkVOK?=
 =?us-ascii?Q?a3Qbc0Mzak02S//YeTq2yA4S6CKmezhhIrnSkQStM/mfBnfdI7tzKsjdZzL0?=
 =?us-ascii?Q?Dyy4A2KgfSwp+SHFLVMNa75tWKOe2m0ykcJqGAOthoncsF+Xfz+fUuLpCPu4?=
 =?us-ascii?Q?pLoNzr8YOUOVJgEkN7v44yxczUawPjBAsbdVcwgkRsfhccQIWtEX23RIslYt?=
 =?us-ascii?Q?64GT2MHzu8vVQi0lga8xh2KFec3mwP9Fem8jifm3qsAYiKJiC1/E3rEFh8xe?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5034af6d-a8aa-4ee9-86f2-08dbf5b582a3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:13:34.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gobAqVFoDfX6DX7QLAdhVI4caaSR7MrJ4fMGHLeQyU3zhPoPzr8hUeOHif0qsHz6zJNObm1BWnZeM8LTFLt4rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7802

On Tue, Dec 05, 2023 at 05:04:13PM +0100, Tobias Waldekranz wrote:
> This is more consistent with the driver's general structure.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

