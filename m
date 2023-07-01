Return-Path: <netdev+bounces-14949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F574485B
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215F8281215
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CADF5689;
	Sat,  1 Jul 2023 10:03:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCAF5666
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 10:03:56 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E816E1FCB
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 03:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqsFphKwbRu8oX0hC4RB9wnMoIHpIixTzfulo+w4AdTAvb7+bMkt0C0HHtI13Z7LpasvQdF8hP5XYPl8tDFIz3CsHZ321Z777cBrSHKLi9EbDOrqVZySQynrL49Q0ZasyhDfbhR19QD+5pVy1d9r2BnnUpgNSFVYrtpzx8wPo/MOSdBa3g3OUp+J6pAYUfocUZb+lbqHGLmlRaddRIXt1uZj10TI/krIRQ7DiTp1MW4V33NibagvJd3A5mxosGMku/ryt6ime6pGNRMDX8deVkSB0KK4ue5hrvPWbASFQXqa6Aa+/RRpcu7Bf3Aio4f46W9K1wZa4EXnRznDzd6qHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZqbq/l+ti79TWKB2Vuvl1r22Ri4BcKb018wjXpdmCk=;
 b=S+tYTlzvQt1A2l2j62h7q92pxis5SpLNFOcKd5INTkWQJNl7L3MEYYZtTKCtr4tWHFF5lkUnSYDB0fZJM4+BeFc+gkVctrAUMJN7qwQLTzfRbVLJlDCkn/dx6OGlwoD5/96NVvgJ9knLnG41hmJ5T9Quw6gYFMhvkgQLRfqomiAjhm16kh4Hu7hsaHbzQzWj+p9Knb+6aXRX5yP03UP8CEz5MCyajF0/ltCx4kxlzZhMfsOElsAyEQmj1BIfWUSjmmdirDA3VFxcjFL8/ospmrViRiLGLHq8Ls4bsAjBM1K4qw66nz7D2S75wyucDj+2QOvHUvzrwL6M3nkqBMRXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZqbq/l+ti79TWKB2Vuvl1r22Ri4BcKb018wjXpdmCk=;
 b=icGPJLnNLk2nxml8IOSqYZUEcLFX/9Rba/83ArX+jzk/60aCTkVTZEHwL3tVXYG4oUxdBeeU1deSYqYo4zZ94zIDG2zn9Da953RpUoN5XHtOCql/on4M+gPnLz7sULrSfcgc9Xz5dXvoUmXl3uyspYxsszTZ9oSduVJtvWsJ64k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 10:03:51 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:03:51 +0000
Date: Sat, 1 Jul 2023 13:03:47 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Maxim Georgiev <glipus@gmail.com>
Cc: kory.maincent@bootlin.com, netdev@vger.kernel.org,
	maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, gerhard@engleder-embedded.com,
	liuhangbin@gmail.com
Subject: Re: [RFC PATCH net-next v6 0/5] New NDO methods ndo_hwtstamp_get/set
Message-ID: <20230701100347.eqijafwdsc6mc6lb@skbuf>
References: <20230502043150.17097-1-glipus@gmail.com>
 <20230620192313.02df5db3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620192313.02df5db3@kernel.org>
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 863ac9bf-4bf8-4f4c-23c7-08db7a1a784b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xeEG3zbg0zUvtmtvP934iTnVJEqCCuiHULvHlsa4Hst/X5tzGW5tIFU3TcIOQrXBFj+DA3SP8/P7ZOiMFjNw3z0cZw4XbIucoIIfpjFG8D4WAVwrVoS8+pKZ6sRhbDg8rY2J1UTW2zLBr7sNCvu2NQ6GZXry83x2KyEB0HLBX9T+3Mp8Y8lYEvz4TFQU9lkQRJBK9d6b5XzyEcj3ZXMLJD0wh3AVW+l/o3cg2s0GOeawaqF5vEr8wy588VF0dZ8Ftw73emAXRaPcYQvr7TZYcFqFKsHHG2vn/iZSyyGcICYmt7y0WyqbeP2jYzjUFySFlaEpgRb6SccP4L9nvkZStFMX71EkSjahYMF/do8FRU04pj2H898bTpClFmWi5RJtGoTP1+SapbeyIT2v3SIWNdcm7cNxMvEK0yrdg3LzUgYroQP8NNrSpFlmXTjyLUWXv9PawRTynPJvstGHiVpEq3TQAwk38u1JG1YsYp7QFl6/nHxzgM3v5sRUbkfsSYXRZHdO6JsivR84yeXJEkm5cUtYWn/FkEC8DIX5H1EDoMuoAcS3tr53fgCvubmdhWhz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(8936002)(8676002)(4744005)(5660300002)(186003)(478600001)(38100700002)(33716001)(41300700001)(6512007)(2906002)(86362001)(6486002)(316002)(66476007)(66556008)(26005)(110136005)(6506007)(4326008)(1076003)(9686003)(6666004)(44832011)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cD2s213WNSmDscJdTVAXF22W4DAoy7whjexB4w5Kek6KO8UIhicxsQKkRKgF?=
 =?us-ascii?Q?1qNl/+/anA+8zvq+xfZ/YMNzbo3i6WhaV/ro0HlbdyHZuFoMXgjsNAvSA8mm?=
 =?us-ascii?Q?rXjXtCNExC6y98+Tc2n0iuIvEzpo+EDm72Hg2yLugXL9LoXnCGVymcUdc5ut?=
 =?us-ascii?Q?sblD3nvpfWMYaYSorthhaI5u/WAL80fYItem2noKkWyPXMNc757wh1C6uesi?=
 =?us-ascii?Q?EPDk0YRuU1LVK57sd3zaU1rppAdJ00WKz1nkfwQ4HN1eKmCNVTkOJsqhWTJw?=
 =?us-ascii?Q?iCWOq42lMAdDgdeUowLpnVlCzaD4nX3bgsHjbRsIEh9J8FxGqQme3Apr4TyU?=
 =?us-ascii?Q?CR/YzP2ydOvBweuO2R72xo6cpapqWSMKn32cCAUQWeeBuj8te1rBJHC20dtU?=
 =?us-ascii?Q?YDEziFz9/Euf1no3OGyJaWk1QJzbqXxWSYRvpmPRsV6fxj3OA8scSMTtOnDF?=
 =?us-ascii?Q?+tj3l+Hiu6Ckkq6tEb4pfK9Ylwfldlfr3rx9OD7StGwzC31BE4MsU0kvUbnR?=
 =?us-ascii?Q?gW+vhTMkgenpLYo394Uc66dqt7cVwFany5g209/96I0PtDr1P+nV4fcOEEh8?=
 =?us-ascii?Q?nN3VJTUcxhgWkyWYhRYRWtfTK2ayAeWk4/5LVFIfRLJXsDm7Qm9OK7DFTYAZ?=
 =?us-ascii?Q?cl9wPWdtVqb/aMvGPLRKI0xDUyo0X/lSrhdtwyeGfYBEJYzea7PiipxYI4i7?=
 =?us-ascii?Q?2SqGXTpHyHNon2ztnm5rC/sCBYp8lmU3JCxBfc5IwembzTz475iI+n2N0UXS?=
 =?us-ascii?Q?JHbUDwjXDDGZu0SqxJcvA/chmt0yGrExOW5iB1YSAMmyHp5JpxuZhzynfN18?=
 =?us-ascii?Q?RILwvmeUdAJmvQZi7kSa9xqHnw2NyUPNTd68YO24Z5Uv2an0xlPxgOrDdeyB?=
 =?us-ascii?Q?8dyFm9NBNJiLUWzTTfY4lGvz7JCGLhgM5baaFgpgcYYa5ZNJG2EQPidCxU9E?=
 =?us-ascii?Q?74YsNIzS9NMy95Afy/MIDI+WIMM7y4lHesJtmieA+V3kVjk8QmlC3Xq5j1pa?=
 =?us-ascii?Q?LKRL3fgun/+2eRV08cHXJV4yFBEnYgT9t+6PmuDKYdSWm7EEqduyZv1o8kow?=
 =?us-ascii?Q?b2AhTp31HkKMoS5NqSithhR5l3l4MafTChpivKbhTE4U8ejhtCS8weEI9Keo?=
 =?us-ascii?Q?T65UeffyhB3kTLQ3aEQRMg1h7vNezZKF0uVGRMSsFmQ+CL8BJ11jGMc6xbXL?=
 =?us-ascii?Q?vSmqWoZgNSBsSIs+jKttJDrGqyRluI37eeKkcr+KPh2mCg2cBMn+inFEtqJ7?=
 =?us-ascii?Q?Awns2HSb4i4Led0SXH5T/s1lTXo3Tv00f5EY13TD2jiSJOZFRWFXSSp62G8b?=
 =?us-ascii?Q?ebO+t1CktBLCKlXTkus4Sd0i19HaXDlVwmDgc3rJAtGOdT/a5vYFg0Q8hLHo?=
 =?us-ascii?Q?pkhpruvKBWKa95Q9L7mlNGH7xp7rkvJ5hxE0HmR6JBFSvBoaEfxR+pIOUymv?=
 =?us-ascii?Q?2HcKtqBsH7zeOudaXHgBmRlE1ZkT0zW6UUsmcfZvg7IQyttb2TBCk0Oh1vr1?=
 =?us-ascii?Q?Hxce1QY/aKz5j8zPETPZGxrFTl1Q5Vni+AIGnjp8lXI9UTmUxtWGnMJ/tUOQ?=
 =?us-ascii?Q?c9mauO8Rz7HCzHjik7bXvj93gIqF5U6tm7GLExToLnflIC9NYUSyFYCaCNHp?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863ac9bf-4bf8-4f4c-23c7-08db7a1a784b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:03:51.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NPyRek7Gq/c9OWwz0Tber61yz9nTtltyK4AlVSp+zBA9/Wmjezb0RuAYRGExZkbekLv5/VbFzQ2GnR8XV1m/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 07:23:13PM -0700, Jakub Kicinski wrote:
> On Mon,  1 May 2023 22:31:45 -0600 Maxim Georgiev wrote:
> > This stack of patches introduces a couple of new NDO methods,
> > ndo_hwtstamp_get and ndo_hwtstamp_set. These new methods can be
> > implemented by NIC drivers to allow setting and querying HW
> > timestamp settings. Drivers implementing these methods will
> > not need to handle SIOCGHWTSTAMP/SIOCSHWTSTAMP IOCTLs.
> > The new NDO methods will handle copying request parameters
> > between user address space and kernel space.
> 
> Maxim, any ETA on the next version? Should we let someone take over?
> It's been over a month since v6 posting.

Assuming Maxim does not respond, can I try to take over? I may have some
time this weekend to play with some PTP related stuff.

