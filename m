Return-Path: <netdev+bounces-21914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A959A765448
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3CD1C215E6
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9B15AE2;
	Thu, 27 Jul 2023 12:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB12C8E0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:45:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2130.outbound.protection.outlook.com [40.107.237.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107771AD
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGmldXd0O3F5g3lGr6eblyiCvDsUitq/70CTdj+jj7X6xA37Xb4apLGKjjJub/YMg+pK56kxZSWB0H0trzCdGGMTpunAqTzCCMWNnPUn6Tqa5fSfVeghGpIWaaURD8SaazY/GKBY6StOb7uV6j3Dik6469jCfbL7ABGkboxbJMYGXMzc25tZni6z8zeVYgxqMZptsq/ymfiL5s4nCCZplBu5MbHBLOWm5y0XWrju8YFAYwYlcNRjwBeJhjvNeEocjdyGyp3FUFFjXAqf1XwMM0wTVGUhM6FoCho++kVeKID/BqVBN86QtW8eBR2AW9LaZiirpv0A1KnIRnd0gsB2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh8gYCtiHXOjLto4DrgMhQbmf0D+e96vz/wjsPWOwhQ=;
 b=gQ5xL9nH5W8qzkEieg/OMguVF3RvSNmSPii5UffUrB5rGWPdMiOsMayIdM4mYwPmLIjDumILdMRe9CDe5PoLzao5WUYnFchogDzBaluaFiPDgAdoriMWKggs7k2mU+0mfBeCzj9fo1bOsUTglWAXnxfqQOwRlgwoK+NrFFOCNqdPBbl09AGEtjmKt+6Fi1XKOjl33OpNoEfzitJrCCTCeOoKufcuT+FxkBt9/3EmH860RqGXVhMLmg6vWW75/gRzcISqX/xLJbxXIgjy65/4qLKGbt8QPbdAbxWFyFROeK2iutBZhaiAdHJQfjf7kvaLiK8GUvyuXLR2y2PRD/ETSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh8gYCtiHXOjLto4DrgMhQbmf0D+e96vz/wjsPWOwhQ=;
 b=ejky/MVweaTFvqEMDAbneLTZXuMQR0t7DPG8SrSGWTRezowFx3uEC4yIHsDm7a9KA/VhnskmMigrL1TLFbDjPabR5DvH1aIkycVriNGYIwGq3u+N5qwl0CNvtqkyvvuy9oGLbi6AaRZXxnhHgA1a9GVGb3EcrA+tRkFRMb+7QAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL3PR13MB5092.namprd13.prod.outlook.com (2603:10b6:208:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 12:45:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:45:08 +0000
Date: Thu, 27 Jul 2023 14:45:02 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Patrick Rohr <prohr@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Lorenzo Colitti <lorenzo@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [net-next v2] net: change accept_ra_min_rtr_lft to affect all RA
 lifetimes
Message-ID: <ZMJmziEZy+9baINH@corigine.com>
References: <20230726230701.919212-1-prohr@google.com>
 <ZMJh1RS+EaGsmgZJ@corigine.com>
 <CANP3RGdeT5MGaxEyYA6LP2kiEGQmA-VdSVf8bme2KR+4mLa79w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGdeT5MGaxEyYA6LP2kiEGQmA-VdSVf8bme2KR+4mLa79w@mail.gmail.com>
X-ClientProxiedBy: AM0PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:208:1::31) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL3PR13MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 750d57c5-5292-4648-57e5-08db8e9f4f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+dW31SEuBTn/RdC7fJ6ayS4+uQWH56jyZvSYlqn5OW21uF+JoCThssYdvtGBJFn69WzCMDtI0Y1Ek+rJ2AhIi6m3GzfmDk26WjbaIPm8LPHaXQ/pRv+GlHANA7OvOXE8TasjdU51CTkbbWG1BIR2/ddgkEbqOuxz9yWu6ho5prbF1ClHCQxmzvqEVNw/qSoYZZrD9fRncIY6PyBu037Rl3nN7G4rdFUqrZn2yhxjDZG8aejmzTFs8T/epaOrabhjlQAQChFNvIGL1Twjf//gT6o8vRGVRCBdIQqqV9kzer8Qx8gdUrfi62kYEd49uUEwE3FOYIexXLvvx7w/Zds87a9Hdm0HBlJZCRglT3BC7fxPmkao7TdwMYMebXN/actK1oSje3goX0fnVnyGP5+Vjno4nNRH2jzZlV53og73l+6a9q5eyO9q95XgwQybII+41NeHXaOJP4ElU/b76KepeP64X51ROIJCGpUWlZ8LZnlnen5p7bEQcHzOYghNr4cuy9fkFsTTBgpKuVHJHy0QBOo8KbOa1/PvBZbJZK1Y7XbqLWzPdl05sXd/grDLDYmc+0XIXy5mDk8ALbViyT7JMe6dsI0+U4L36/AUj3Rzq7Tp4j2jEeK/q6TCmleHs37n9SxJpgEvwqlT7Ixt7rTOVFRDMav9WOABbci5o78XSuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(136003)(366004)(346002)(396003)(451199021)(6666004)(6486002)(478600001)(83380400001)(53546011)(6506007)(6512007)(66946007)(54906003)(66476007)(6916009)(66556008)(4326008)(186003)(66574015)(2616005)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(41300700001)(316002)(86362001)(36756003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllRSHdSQmZRek5GT3dTdmFmeGRpdGFlYU5leVVndHFkYmdmNmtCb3Q3Mnl0?=
 =?utf-8?B?NThuaTZncUxyVHV6ODFPSHhiSTJEK3N2SzFqUFhDZDR1cWpBQkZCY3FmbGdk?=
 =?utf-8?B?NkNRZzBjUkZnRC84OVYyaXdETGszellGZHE3L1FtV0E4eSt3Q0ZLaGlhY0ZF?=
 =?utf-8?B?ZENTUXBYSUR1c1pBZFFOMWVEUjdxbnBhaUNMeGI0bDZidE5Oa0NGM29Na2ht?=
 =?utf-8?B?T2VhaWZTRFFhek1VZjZiTExJN0R4U1hOdWNIWEJlRCszRjBXUVlEUTVIMWpw?=
 =?utf-8?B?b0xDb3MwZ2lzdmF5NDMzUHRGYUlmNDZmRXIwbUZ6MWxFbW16YWtpcTNzMzd5?=
 =?utf-8?B?NUZNcmhoM3RmVVVaeGZQTzlMNm9hSlBRZi90R0RjSGY4OGpLTkk2MUVSWFlO?=
 =?utf-8?B?T2ZGUXFmL0NDMUV4TjJBWDBDdGJmZWhKdXB1MTBlcXBWK09JTjZRcEw3dFhh?=
 =?utf-8?B?c1NaZ3VmckhQRDdHN2tSbCszUnhGYnNMN0pvZ2xvUTBuMVRxdS9VZWM4eVF4?=
 =?utf-8?B?bCtadFFpczl2eXBmMHJrL0J6TzVWV2o4OTFCdTZuaCtCVVBZSEw1aGlGdGNZ?=
 =?utf-8?B?dm9XYlNINEdjT00xeHR5U0szUEd4Tm5QTitZWjIwMkd5TlM4MjBPTm5FRjQ2?=
 =?utf-8?B?YlNER0x4a3FscnhNdDBkQ05KZHI3MHNLMHpFMS90OVRBbkk0YjA5Vm5aU042?=
 =?utf-8?B?TFEvRGNIMWFrYW1aU21uNkRtQmNIR08xNU5HVkl2SEpuU3dhNENXQ3cyK3po?=
 =?utf-8?B?Q2hSRzlTTkNhYW1RSmpkRXNZQWNBdGMrbmZsRTBncTAzSTVWS1lLcXdaMTd5?=
 =?utf-8?B?T21Ec05tRC94cGExYWpRYzQyaExsa1dJNU82bXI2L1Y3WmxVV2ViK0ZBcHlt?=
 =?utf-8?B?djlMR2FiejltVVl6c3I0UHJRY0REdko1bkQ2bEZFaVJ3UEQraDVHWlNxMHhz?=
 =?utf-8?B?ZmowVWN3MlBidjUzalkxSkRTRGxPdnFMeXlRdS9pRjlCTktiaGhHcnQyS1dj?=
 =?utf-8?B?TSt5RzVHaGx0UTJLMi9zRE9zNVNtNFYyQnR5R0krRjNreGZaQ2tvYi9vcHVs?=
 =?utf-8?B?WFlwdSsvUkU0NW5IQ1Y2dm8zQk40bUhrYjFrWmZtZ3ZRbVZXdE45WncyemE3?=
 =?utf-8?B?TlcxOEhLRlF3UUttSDIxTVB4alJHMXdNbHlFZXVFQ3FaRGVxUGxEOU9aTTVO?=
 =?utf-8?B?bERDQS9GMWRKYmoxY3JKTkg5cStmajdPM1hTbFZ4Q0U2TnhVNzNJNGpUR0pQ?=
 =?utf-8?B?YVpjNzRoeVMrMWNITU5rRDA0bUp5VHZ0QXl3QWR1ZjMzdkhNQ0M2YlNzUllv?=
 =?utf-8?B?bGVSUGlOcnlWRUc2RVJYSU1XbTR6Y2U2elRWOWNaQUN2NGNJQVdRRXVLTENl?=
 =?utf-8?B?cytWUERNWCtYOWVEcVVWKzUrbzlXUFlNeUg2S1BCa1lIeVhpc1IxcnFVR0Zj?=
 =?utf-8?B?a3JhWjc1cWVGcUNEOUMrbmUyYlVzdEQ0ZlhucERFZXcyK05vYU1Yck1xRkpU?=
 =?utf-8?B?dHQ2akNtbWdKTUFsODFiWEFXWkhRZm5sTW40SVJKR01qc1hreHBJQmh0dno4?=
 =?utf-8?B?S3R3SjlLV2ducWtveVBBSTJYc3dNY0RLQ0M0TTBnM1NyM084SnQ2KysrcE9q?=
 =?utf-8?B?YUx3RDFPWWI3NEpHcG9GOG16Y2EvVzB6RUVMR1Y2Ny9obzJxSXM2bW5paHdv?=
 =?utf-8?B?YmZnZFB4dUFkTzE3OTRhQXdvRUhoNmxqYlNLak1lSE1Xb090NFNpKy9KdWQ0?=
 =?utf-8?B?VHBIcldscXo1TG1KNEd1L0JNT1Y0ZTgrK1lzbFFBQlpuWGRpOXN1bUpDRzJE?=
 =?utf-8?B?RXMwWFpvZEpJV3VNRjY2bzJUOUNVMG5UMHJRR2l5TlJBZFFJY0RXcEdlV1pB?=
 =?utf-8?B?YU1aSmx5YUJNY3RlNXlVdy9WaDQ3dFBDRFl0WDR3R3orU2FPUC9JTEVSakJo?=
 =?utf-8?B?d3NELzRUazZNNEh4c0U3T0E2amVOVHNjY3NPQm5KdXAvQTZPWnNqS2UzbkNL?=
 =?utf-8?B?Q0RVMWlCSHhGbEYwS0JVNURtazVGNmZmRUNMd29aY2dvcDR0b1QrcnpCSmJE?=
 =?utf-8?B?aDdaand2a1lpL00wR005U25OL0Q4cmtOdHFaOUdBVVVsckptYUZhRVFQOGp2?=
 =?utf-8?B?ZG9hbE9PLzBtYWZhVFYvaXNqYnZQRTQvUEZwcC9MZjl2RDJjVitRQkkvUW5q?=
 =?utf-8?B?cC9JZEZndWxSTTY3TERpRXZyUE5UM081ZHJyNGVKVDFmZGFadTRZS3NJc3cv?=
 =?utf-8?B?bkh5dk54dkhYZGZOb1ZQOGYyNm9nPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750d57c5-5292-4648-57e5-08db8e9f4f02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 12:45:08.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQFLLbfiT05F9j/vImV+ca/DOSLjPELUXh7u/GKny0IcA4UxJtHuD+UI6+dgO0uWSIqOIRH259x9iQ/xg4VCGHQnQC+SKIEsjy7iGE1/XJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 02:38:24PM +0200, Maciej Żenczykowski wrote:
> On Thu, Jul 27, 2023 at 2:24 PM Simon Horman <simon.horman@corigine.com> wrote:
> >
> > On Wed, Jul 26, 2023 at 04:07:01PM -0700, Patrick Rohr wrote:
> > > accept_ra_min_rtr_lft only considered the lifetime of the default route
> > > and discarded entire RAs accordingly.
> > >
> > > This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
> > > applies the value to individual RA sections; in particular, router
> > > lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> > > lifetimes are lower than the configured value, the specific RA section
> > > is ignored.
> > >
> > > In order for the sysctl to be useful to Android, it should really apply
> > > to all lifetimes in the RA, since that is what determines the minimum
> > > frequency at which RAs must be processed by the kernel. Android uses
> > > hardware offloads to drop RAs for a fraction of the minimum of all
> > > lifetimes present in the RA (some networks have very frequent RAs (5s)
> > > with high lifetimes (2h)). Despite this, we have encountered networks
> > > that set the router lifetime to 30s which results in very frequent CPU
> > > wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
> > > WiFi firmware) entirely on such networks, it seems better to ignore the
> > > misconfigured routers while still processing RAs from other IPv6 routers
> > > on the same network (i.e. to support IoT applications).
> > >
> > > The previous implementation dropped the entire RA based on router
> > > lifetime. This turned out to be hard to expand to the other lifetimes
> > > present in the RA in a consistent manner; dropping the entire RA based
> > > on RIO/PIO lifetimes would essentially require parsing the whole thing
> > > twice.
> > >
> > > Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> > > Cc: Maciej Żenczykowski <maze@google.com>
> > > Cc: Lorenzo Colitti <lorenzo@google.com>
> > > Cc: David Ahern <dsahern@kernel.org>
> > > Signed-off-by: Patrick Rohr <prohr@google.com>
> > > ---
> > >  Documentation/networking/ip-sysctl.rst |  8 ++++----
> > >  include/linux/ipv6.h                   |  2 +-
> > >  include/uapi/linux/ipv6.h              |  2 +-
> > >  net/ipv6/addrconf.c                    | 14 ++++++++-----
> > >  net/ipv6/ndisc.c                       | 27 +++++++++++---------------
> > >  5 files changed, 26 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> > > index 37603ad6126b..a66054d0763a 100644
> > > --- a/Documentation/networking/ip-sysctl.rst
> > > +++ b/Documentation/networking/ip-sysctl.rst
> > > @@ -2288,11 +2288,11 @@ accept_ra_min_hop_limit - INTEGER
> > >
> > >       Default: 1
> > >
> > > -accept_ra_min_rtr_lft - INTEGER
> > > -     Minimum acceptable router lifetime in Router Advertisement.
> > > +accept_ra_min_lft - INTEGER
> > > +     Minimum acceptable lifetime value in Router Advertisement.
> >
> > Hi Patrick, all,
> >
> > I am concerned about UAPI-breakage aspects of changing the name of a sysctl.
> > Can we discuss that?
> 
> This isn't uapi yet as it (the old name) was only merged a few days ago.

Ack, then I have no UAPI concern.

