Return-Path: <netdev+bounces-54334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE39806ABB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E91C20926
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815791A27A;
	Wed,  6 Dec 2023 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="KrHU93Xb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2129.outbound.protection.outlook.com [40.107.100.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16D7D1
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 01:32:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEBAiRWqY/ju/W77k1eD8ONffMyYUo7N+gKKYvp2Yinusv0ltDfoTqnw/tctcvOkvxBjPLVfpBfyyY8UASHNjHXy3DIDMR9Bd7uWYRrYh1/1QC30wz6yrUFXMNh6aaW5vnZ4YNCeks5UmGbqlfUG4ASi0TYC9Nl7szG60JGlhY6MygAv/PgSM68fvpxYGFCfjSigsIDHqwLB5w9Kd58cPESwREBcO3azrhqTrftNfIkzixxP8+lnLc/RrMqRxC94VWU5MKQB/ZJ2Dn69OFIYBpbQeZRcfQ3JipKukqT/EQsN2C+LRDtb9mpdPMcA+IEw+ilxdvaBuXK87RbNbFkH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3c3IDZ9BMQtLXooLbmvrrKlOz728PWq5MxcfdB54n4=;
 b=d1OPF6Fr/hfi3yohFfgVaNJ/WdP+8ZcvSOyUT+RG1q3HJiVnqssdVlG6gawws/h4Ip1hPnsvwxCOqjg+Agy9i/RakACvPeLqO1Ed0inxUzxyZ1//myu0vnco2AwZ4aX6RXQIxKQdIQC42cH6ve1LGrnl9tXfa2nGpFS9TXEq9o6inIhzgshXMijgbbDerVJk6w3/KNn7QbOVKebmI5g1cXyYrpkkW6epsl6Sm3/4I3yX+EjVUkk7kBp08jtNrMcFYGYZ3kP6UBWVNrFqW74wNIklorxoubieXVl3YnTvYMaFDvzSxuR1R2/s/CDxwRxKyMyHOUo9cWUO0ke55ASXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3c3IDZ9BMQtLXooLbmvrrKlOz728PWq5MxcfdB54n4=;
 b=KrHU93Xbnq6fDg5ZQCz4BJ5SiVoL6/y/hxaj48QDEGEp0PPc4w0xc3O4kXyLKE3MzT81SEawYWo1MJbuXoNSRZhu4jJaHdnXm3rLCe9eqF1yqPuDFsSNUuqtwH751VPbU2CUFV1ZzhgRMM4/hhXC64Lr7Iz67VViz6ydHJH1FdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by PH0PR13MB5448.namprd13.prod.outlook.com (2603:10b6:510:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:31:58 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 09:31:58 +0000
Date: Wed, 6 Dec 2023 11:31:47 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	yinjun.zhang@corigine.com, simon.horman@corigine.com,
	jhs@mojatatu.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
	pablo@netfilter.org, Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net] net/sched: act_ct: Take per-cb reference to
 tcf_ct_flow_table
Message-ID: <ZXA/g18ofc9CuxsM@LouisNoVo>
References: <20231205172554.3570602-1-vladbu@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205172554.3570602-1-vladbu@nvidia.com>
X-ClientProxiedBy: JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|PH0PR13MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4d51fa-5ae0-47fb-c4df-08dbf63e317e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iW76sMlTHyqFoHyx4ai78B31wuVONYd5WirkcWlC5wYte8yM9ibvY3Q+VEOeNywH3/30crgeTgQSagxXQ1BsAGf2AF4Dp+eywHaA8NwLKNV8yh6fHEs7LJsS6xxWhVFBKR9FdLIDSvOhxvBCJGrcRz8wC+wdePK0ittd+ZeAZGYdXI/s0TeaME/UDSIZITlYdn5dQXYVWCwYuGvyEQ/pJa6ni3bOPlymIRl7aqgTTLY1ymFZM3W2yfMaytZvcdvJi1DCS2K4dMpxRwjzEtOHW2pKd5ZV7RUyRgIndUzVVjzCGfkZUNy91uDWnR0UHNNQMbP3fWlK3BJqg7MOEYz9otsxQG7b3PL82FGgo0j9hZkBCZtKjL6u/BH8hJtvlLKwPdDs1NQFs2CaGSujrATO4z0nqAhIvNeNhY2G1RRo5FAoSCfH5ogCvdcqRKokgYpNsBtnFSzH7c6CL+x7qEuFkkEjIaqtSYI5MpwlNa2pFk3MHfM7XZk3mBch1mROet/hDEmf4Mm57nOaS9Fq2HBfugmWT1jF59lUIY53pY2eIC/bLUzLy58t1SWeKeafJKtje9PS3vfMSXim0c6ls/N59RIMW3GtFmOYkNmBcAV+WDTGI1breB0a1pc6PSQLcXmGGcp6LjndnaW7+fj3waetK69u/vig7Ggp/tzmic03sNMS6LpabtV64/iAK5XhvyXm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(366004)(39840400004)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(44832011)(2906002)(316002)(6916009)(66556008)(66476007)(66946007)(4326008)(8676002)(86362001)(8936002)(41300700001)(33716001)(5660300002)(38100700002)(6486002)(83380400001)(478600001)(26005)(6666004)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RoKrtBOlf45MDXiqt60qqdh6cccMu9W4Jox07VGAGSWC4IWqAywXfAwYG97C?=
 =?us-ascii?Q?okZRw0XkO/xw4KOr6QfQEuWp6OZFEkwUSKkedLE6x7W00GHokmiRIyAQvqvH?=
 =?us-ascii?Q?9MWSInvW6/eU7aw6O6p0Wra5osgl6oaI5YC34J4DhT0S6A/riKQP6W4UvIUd?=
 =?us-ascii?Q?8ItMfmTxxK/mDiYWMkElfjXxzxDuBSnnu8DkPPfeth1YbJfSN4crDjQ1lQiJ?=
 =?us-ascii?Q?I2NBjE5u2eu2TfwqZvc7x6QDg7KdvACQziIHSbWtZicZcCR3YkdxY/jM387K?=
 =?us-ascii?Q?fL0tjH569qF/SSWzQtQiLcpaspnevByqOYkEpkTyUR2OFMvZXnlW94ZufE5/?=
 =?us-ascii?Q?xG+QkfApa3CopnpMyt5wir0jrHj0ccpKo9wRa766bFCXjQ1Hjx+XsvUErni7?=
 =?us-ascii?Q?eu7Jvk+7wGiu5eX+iPdSS5v3yRltQY9GVl07xNc/3zRRWullDUBK2Rm358nj?=
 =?us-ascii?Q?6d7FivX9M1FdkehCmDzCby3++r+8meujSYkP5l7BrRsFcTG1oex5Lp3gqfRa?=
 =?us-ascii?Q?MxNNRg0oo3fDHrjet5hbuGycmc/EYR3vHsfmVcjDL5U+Yh+ivaOkp4hMwUXf?=
 =?us-ascii?Q?ggKew+Dsp5Q3kCCkfT4j2RGBtvvfgePVJkfTvb12BNsGa+f4x4GB0qSEOvuD?=
 =?us-ascii?Q?tpXnM6g9g8Er8ozrN9A0IERiyNh2h2Ee9NDjvYbInBdhTESN1x+1HYpltt9J?=
 =?us-ascii?Q?wxaI8YM6egLJIK4CKRVEMKfFzeYynRX8in99x78LxQdwWOF1tiM3lOlXl4Rb?=
 =?us-ascii?Q?GofPJfgKNew6vcXG8+c4VeE5OUrTOtnrw+NaK1hErHXSXyPadE8I+oJy6xoR?=
 =?us-ascii?Q?7xywO6PDbJVlkQnh8I+/ZAslgM0SNWDJugxEagRNafahMJZ88IqMDkvz3GoI?=
 =?us-ascii?Q?WRVmgaFVteGfEvAzCwZD3HcbT6AvJ+E1GfQ3CBw9ySpKMh4R5+KSuosugi0B?=
 =?us-ascii?Q?ijVjA5uT7Il4MMhfu91oW+lTLS2nWi+s0tnnoZCx7RAccPUp2FwhEsEtkTNp?=
 =?us-ascii?Q?Z5pYrtDQMTFA2DzVSwIXO/ZLdPsX2dtR2WUPKi09WvVCBs6KcI7T4XHIhbD0?=
 =?us-ascii?Q?yX5dkemF7KOQp1eEAQYeQfEOekcb9jye/K0A0zMwPj3vCJRiZMoI2v6D/7Vi?=
 =?us-ascii?Q?Q2Sap5sM9wf5ZAwCSBfekVTiLT1dNf8x2sgsExbMr2DxMb/Ik9cqmT0/2IpG?=
 =?us-ascii?Q?mvCxEHGc0aSAhp5grAJfKmhHMwXrl9y0SAicGiZEKPbczD8DtEqRtnLja4el?=
 =?us-ascii?Q?nldKT8fv33Ahe+Yd+ykWM7+Kyzadrv7kAs/pO4jJSXPj1rrNx45ocv6dkfZR?=
 =?us-ascii?Q?R5ByxQ7rVNA9+/WpweiUf8HTboaMdWSu0C0oKIYTnCA5U2izTSSGOkQSm394?=
 =?us-ascii?Q?/ZQ8G0mwtWf8TcKd3tNKqKe0SN0uOrXf3QPv/A8FhpWS5z8nKZtf0EfAXzRp?=
 =?us-ascii?Q?smO1K5szhJkJ0oc4Zp0S88atOHAX6ru0iSeVDewlR1KA8CMlp5q8n22LYgAs?=
 =?us-ascii?Q?05ew+szhn9jdqenh2ymUF/hDwEH2ELVM3tbldccyk2trrySZrSP8cf+63SL0?=
 =?us-ascii?Q?zI895fY3aWse6kX96PCyQakqmtTT7fzQmw6J30RUex4WsQ/jNbOeVcGW92pD?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4d51fa-5ae0-47fb-c4df-08dbf63e317e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:31:58.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vor3nTj//6SGLZJVxTpb46Sg6V+7Afms655DJbPM1rtdj5kemN0Cue/HYuCiPPbO/yD3uxdhI9PViTZfL8jfytfxABAfUCw0JLI2s3SXAN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5448

On Tue, Dec 05, 2023 at 06:25:54PM +0100, Vlad Buslov wrote:
> The referenced change added custom cleanup code to act_ct to delete any
> callbacks registered on the parent block when deleting the
> tcf_ct_flow_table instance. However, the underlying issue is that the
> drivers don't obtain the reference to the tcf_ct_flow_table instance when
> registering callbacks which means that not only driver callbacks may still
> be on the table when deleting it but also that the driver can still have
> pointers to its internal nf_flowtable and can use it concurrently which
> results either warning in netfilter[0] or use-after-free.
> 
> Fix the issue by taking a reference to the underlying struct
> tcf_ct_flow_table instance when registering the callback and release the
> reference when unregistering. Expose new API required for such reference
> counting by adding two new callbacks to nf_flowtable_type and implementing
> them for act_ct flowtable_ct type. This fixes the issue by extending the
> lifetime of nf_flowtable until all users have unregistered.

This definitely looks like a much better fix to me, thanks Vlad. We
will do some checking our side just to confirm that it doesn't break
anything with the nfp driver, but I don't expect that it should.

