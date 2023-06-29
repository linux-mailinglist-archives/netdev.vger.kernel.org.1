Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B19742E1A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 22:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjF2UDW (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Thu, 29 Jun 2023 16:03:22 -0400
Received: from mail-dm6nam10on2118.outbound.protection.outlook.com ([40.107.93.118]:26976
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232598AbjF2UC2 (ORCPT <rfc822;netdev@vger.kernel.org>);
        Thu, 29 Jun 2023 16:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nInHeFCh1Djgtk/jHw2PW1Mf+kSbv3BL2mbzSN0Hjem+toV5ID3amZ+ufkp4gw2g+vEDbBsG6TuGZTYCS84tAKcaQfBs1OAhWJRoufBE5Uz+K9thNkZmg8S4LgKC6u0mvpxAWk4RPETfYFhIioCLVHyI5Muh9nDe4Qx2ROClri3WEoR88JGTuFTNeCz8j8Po0jQ2hHb107tIKj3UvWs1x3h9pQj32NXiTuEwz3e9fBrArypMoffo6/geBYfJdszUMH17xR1dXocczz85kGjgFSctm/v9O8IBO6CJB0pYrHb9O48+kB7s1le8/JdA6SKribQa6T3WEiv9J5fGc3Wmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoeqDa8z7pYQft36pC9VjnS2MlTeRKA7/nP3fn6Gfv4=;
 b=R67+jsIpwft3/w3jw2KRgQ5blnmmu0ZwmluRde2NK/MNiG1C4FCIoOFDO4t4jiHA+L5iwMHBzigDoVUXeJI3SYztQcqNjyDjHHciGQIsuVDQl4MISr2MZETla4xNt//0wZXIB7f2O7ea/hXpQmKaSLC8Y7UVgRvaku7uuyuLd+t5OvvlDgp6Vyxtk6oD/DwXAr6H9ni3a3J8nT0h+3c8fpOOuqvGAg0aVZsCcWCDv0QzyEkxfbGJ736FMT1ysXQbQYqFc4YsMzhx67JqXmUWzWG5hJXZoGMntL5HfZ4vqKjq2c3CDfGTKUG+rEVtMLSB2NDMAo+FIUWQLuOAN7y5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoeqDa8z7pYQft36pC9VjnS2MlTeRKA7/nP3fn6Gfv4=;
 b=MSLpw8Gd11jmX1kZ/KVgxj9UcfmbGzFjEi40YxbduS0fvFYBY4WKWomoec+P5GWmysLYdykspr7in4+7J39biGvm57VhwuBrXfGt8ZKMdo35X6u6ynfERcgUmGtmHB3sdB0yNQRMn4dTRX6aI7/hGmWXieYmlTjg/wGyymzilHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5453.namprd13.prod.outlook.com (2603:10b6:510:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 20:02:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 20:02:24 +0000
Date:   Thu, 29 Jun 2023 22:02:17 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, tgraf@suug.ch
Subject: Re: [PATCH v1] net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
Message-ID: <ZJ3jSTQFww87vLYn@corigine.com>
References: <20230627055255.1233458-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627055255.1233458-1-linma@zju.edu.cn>
X-ClientProxiedBy: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fdab43-81df-4c84-c654-08db78dbc14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3E/KgLyFDjmvPKKtrD4nfeMEgriTVHNiWyTGpXGzcSUwJqRIU8inxH0W7On0it1W+XBRDQul+hubwm6pKCw30leFupiGkcv2cyuEn+3y9dMo+vSDKjIWy04x3dxCOeYekGra+9hrxW+JkQIM7h2q3O0hIaCm0mYpK4/QXaSUaCrU4SQkBuOyasObtr5dLhK/6kc8xOV5DNJ/2KcQGxzInGnVdS8/cQlwCTTz5NNk+KrGDX1M3oKaUTJlmB82AhG303GjVyXMiI0/HAcSpG9RmhgJmFh7XOwRrHTQYwKuvTjKlFPYlW4mOLaieGThLcB/xEoUhJ+St9yyBT7cLU1ovbIiBzBqW1JbO9uHcyzE81xgekzs1KhCAr2qMqWVJwq1WG6HxPDMpa9Bk+G04OLEZvbO5zMeHndWnF17ad7Rh+Tr0LO07UjTTH9Os9WR48au+FnmFIrIXprsVGcmoIQ8S4c3VAPbsZUbqxtFfjuuPPfhv9iDTi9aLl/pVdtB4nMIOLwEF++G4zm84Zv1LaGkMXbIOh8OxpytbRKv19/qszhQcUNmlo5I7cmK6fdtjRUErDbrxBKz7qvlcA9M7E3hVzJjR2CIpLxgIq3WjJ4w28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39840400004)(451199021)(6512007)(36756003)(5660300002)(86362001)(44832011)(41300700001)(66946007)(6916009)(8936002)(66476007)(8676002)(316002)(4326008)(66556008)(38100700002)(478600001)(6486002)(2906002)(4744005)(6506007)(186003)(2616005)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XsRY8WKIA7YiSE/uC2iHFTJi8uttzc4ZS4P3ktp1CvBNJl/aJwo/iPhuBShZ?=
 =?us-ascii?Q?qGdBdFwdW7FUE9mkrKA8xN3+XBNuUVbpSi1ZxtKa3NQp26MPD9BrrnI/m2z1?=
 =?us-ascii?Q?A5qfGSxaMRFMuDXoxEJK0dNNW3PnEmhn6ofSG5oiuOnhyQKNPpvvPXNUrV9H?=
 =?us-ascii?Q?Q8ltN5+ely9xRSp5ahX6mimF1i5+lVeQBcjjUCE7WUX/YHhsTW2MuSiqxkx3?=
 =?us-ascii?Q?6opyJZpto0NU2SROguQPPkNZkcue7qM9aduFhxdvWSWheHXFIqZiz/tzPljM?=
 =?us-ascii?Q?/V0zZlVntmk6TH3eEJafZyaWTUNSQVJlOIKKgO5y588W2/A6eLpcvAGmZbup?=
 =?us-ascii?Q?szA+BO7w3CePeBL+7UjuO7Kfl6SSl77mamRW8gGKNBmcNBNNtHq8mQcvjAOg?=
 =?us-ascii?Q?lB+A65B/xzJ3gLvi3d92avph/+4MdqqIXNb5q36RLL2iZHr96h84epDjFZYH?=
 =?us-ascii?Q?VGDqe/tp+/Xm75M7DvaqKGofDdeoTlkTD3MDvaJ9GzvGeyno0ST1sDbhbnqs?=
 =?us-ascii?Q?2pWxMQfG5xibAiDkm4nM3AEucVN3f1bD2rpmGBzPCMyDedeVPfqN7Nyf6bRs?=
 =?us-ascii?Q?2fNGgwyRjsDmHe2wfIU5FNgyr4UPggqM9xBxZonPceBs8cG77uZoY6lR3aI6?=
 =?us-ascii?Q?y9UXHt3LHI/33xTvUp2ebwJjgKiM0QB4xy8zpVHaElugHPx39I2P3ajFuNY2?=
 =?us-ascii?Q?7LYyNaXG2haeYUWidiigtoJTRruMNWNNsDr2cNdTJtiN9Z02M4Rbedns6ra7?=
 =?us-ascii?Q?uviEJlHq5HsLkLw9SWhJsqOJWpiZf5KwtJ+DIJGfR6ZIjMSCRRjNYJxEFRoU?=
 =?us-ascii?Q?CdNDG94aj5nfy9Dz7Levw34ARdv/aIGc7DEcbLOdvQh00M3CwwN8Lxd3JbOk?=
 =?us-ascii?Q?QYn7XVHyFC/KS1xEdoDhqmnR11rZnpxsqIeYXWT4GbOrVD+9X58ZPE4vr8vN?=
 =?us-ascii?Q?lWikCtRrZWRC19KVQF09HXHTBouWdmiUWeun2LFbc0g4VzHoJtJQJvcNhEn9?=
 =?us-ascii?Q?iKwRsQDdqqiBYMPnLBVaB5rQv6ujgkPnbDjRSZrV78bfK7MZRbXF9eYU2DQ6?=
 =?us-ascii?Q?4Fc5XNf3hX9R7JZXx0Mc3K0nP34L6Ypf2kTW/BBP+YrhYOQBd1UB6BpjvKlV?=
 =?us-ascii?Q?R9b/FNhhQdUmRxUDptEcg2wnshbZKz0wnOiPmKe/ilSJgNz+5Ker4MGSQEym?=
 =?us-ascii?Q?CqZ314JgexXOsRdUoc17UaWhjuDszxYnWzcVpz4rVRPzWupNagCub5iDUto8?=
 =?us-ascii?Q?b6VvylUnfRQed/TNhdTssmSbjON8cHFGs/RQgryVQCYKPp6qWnoBbWR8lqSQ?=
 =?us-ascii?Q?O4Ta4ebPT8u3FEeCejd6BJGi7dDv72/Ojfz+VfDZCdQkiTtAWFfzibN2sbJQ?=
 =?us-ascii?Q?rfGSQJQvLmC5DRWv5a1pcGLXbQiLrbUCdeDi29cYbWpMZvqefMMmx1AyCqaj?=
 =?us-ascii?Q?YvGFmKGAJ6Xylg40NRJ0M+WGmRCyVqlhf60nfRkgkENkVikANkFnyZ4Otlf+?=
 =?us-ascii?Q?KzdzceCoAf2hhh0Ky5Ck+M/IoI1XHgkHxoXUdmrl2oKmG6X+tMD2QYefmAGO?=
 =?us-ascii?Q?G8VuvCX+ycUC9STzc0rWoRC5HnA7pfJeNJrHSpabMF8S6+fANcM0BEQvNDBF?=
 =?us-ascii?Q?zVRpknNpAzw5n9yOtk4E6jfMkQMFlA/f9hYDZhQCx+k5iErN7iewKYHZMMeR?=
 =?us-ascii?Q?praejQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fdab43-81df-4c84-c654-08db78dbc14e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 20:02:24.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUPKg2//7Yl/tlpGDbC/S2AMrZpMu2D7TJDTl5cWnm7D38W4cVlUDxpTt7SWXDCzoxLrZn1z8xysIYJ8uCCd6xRBtuaH07FpHa9wGendofY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5453
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Tue, Jun 27, 2023 at 01:52:55PM +0800, Lin Ma wrote:
> According to all consumers code of attrs[XFRMA_SEC_CTX], like
> 
> * verify_sec_ctx_len(), convert to xfrm_user_sec_ctx*
> * xfrm_state_construct(), call security_xfrm_state_alloc whose prototype
> is int security_xfrm_state_alloc(.., struct xfrm_user_sec_ctx *sec_ctx);
> * copy_from_user_sec_ctx(), convert to xfrm_user_sec_ctx *
> ...
> 
> It seems that the exptected parsing result for XFRMA_SEC_CTX should be

Hi Lin Ma,

a minor nit via checkpatch.pl --codespell: exptected -> expected

...
