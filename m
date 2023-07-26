Return-Path: <netdev+bounces-21375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061127636E1
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C75C281B1F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35536BA51;
	Wed, 26 Jul 2023 12:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37ECA71
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:56:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2135.outbound.protection.outlook.com [40.107.94.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B3DB;
	Wed, 26 Jul 2023 05:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDLpVFKzGZzZGQjCoR7qW4j8zYCV9cYfACxOANuc5hENK7sFixaarmhndAnReOH/KU0Ct31N20rfEvpVWt9zBrYJpL02yqpnA1FdMPooRbq/vi6sAu5MYPMSPVJ/FJe9nfUZCRodSsFTf1v81Ak+lvBimG5a5uPzqJjCztetZfl9nO6npLREm4nMQuAqGW5uEH8UXrNoSHi7+f85vPD1UxGd7U5hh/ziqsT/S3RP+BGXmD/lmyoUOamU/0yG/GQ3tJlCt2WzKxNFaPiw9rnph/WjHc6GpZVFZhsPYssA1wfXpjyUoSJN8XIJVH3ihViQOJitR7Q//uFGEWBsM8IYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qSNkdD970CPVl4w9gsVDOBW7bam6QIOQCQzYNZVte8=;
 b=nmA5TQ0gp0UcYloutXwn/xXpx2+TFYpZtKxTRwxCWEyyJzyedSAl4g5tVqw5OBq5S43VUeHeNurOu8rQFQ4Sg6II2AzaRyFlTe/gTSh5y1Lqh4fXWiin0SYpoJUxIgflq75QTLG7812HoIn+m69N5KVHwdIFSaI/BFHkXJeKPZ+BvoKEpaQy5CA7Q7HwJ9QY/vA+7RtJ98Vx4i1OuwCxicGJz429cLDNNRMpr9XglrLme/W1blXm/8bPZitLyAj4WbvtV65c6GkTX56M6/AJINybSRHfYl2ygM2PWxKLYK8/qLsiYM/nO/GcKg5mrCTD+XvSLo3B3jxQ8H1NyxTjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qSNkdD970CPVl4w9gsVDOBW7bam6QIOQCQzYNZVte8=;
 b=FVhhLP4MJUBVT/eB4JBXDh3W48HqGESIukKRqWMg9LYJdHT/3OhaVXKqUSQVkugCuYuT/ShLi2CCOOcvtWsARWd4qfg6B13zU4IP7KKpb8Ds4KuGDAVlXbwWeFpqXgwhniSy3WEjYvqYfle7//C/hYXEKRFxCi7rIaqoC1riHMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4633.namprd13.prod.outlook.com (2603:10b6:610:ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 12:56:07 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:56:07 +0000
Date: Wed, 26 Jul 2023 14:56:01 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	dccp@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dccp: Allocate enough data in
 ccid_get_builtin_ccids()
Message-ID: <ZMEX4VOYzz8IvRUQ@corigine.com>
References: <35ed2523-49ee-4e2b-b50d-38508f74f93f@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ed2523-49ee-4e2b-b50d-38508f74f93f@moroto.mountain>
X-ClientProxiedBy: AS4PR09CA0004.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 489db9e3-dc0e-44f6-7f1b-08db8dd7adc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lt1R473Dw9FpnDSOOOw2/FpDFO98AcAmNeHrOViRUqjq0HHcIRhgy11Z398PTxn1F7e0dFKIdT5durCJib0TmHYgNG0JBjZy+AKqsJCOeYRLsNxPanPTYuGNCiVdnKNU+DCyiRD9EfwXA3n78scoc9ryTM46Xd7a7p65uzgoix1V5kNIxLIRwr/kJ9ta56xQOapf48djea63Ni0CZ2gewdEQh659F7hCcY7LJ/e+HAEJStZFqfTlk6727OwPbNIOg/s7WJNIQGe9yQ/gs/mKGJZvB8uRo8jBV9xocs092iC/ayzrP3RZ2p+d9ZW7NIvkOrkw3guw5dtfjZkHZUrEhTKsXYyM2IBUwGz0MQlBWH1hiMtv+UDXMD+/nmhQGHcesYnh/bD5n0iynqhM0hxnZqzAbTAd1IqarxlLV0x5IjRnYq9RvHYNqaHyg7f5Yh2rzMr+E85weD+veYT4n71+XhypeiYOoSCBQlQYIwWo8gB4e49mqopgPJBFzLxUcjPUwIYjX6M4fKI/SQ7yIMXPWPzRAA1VKHOzy31hgg+qeiq2pWNhv3LxWrJcNdtHVEQjxa1B14SN0mJJlQQM8H+omzb3nWvhOhIRGaodT7yetgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39850400004)(451199021)(4744005)(2906002)(41300700001)(316002)(44832011)(5660300002)(8676002)(8936002)(36756003)(86362001)(6512007)(6506007)(478600001)(6666004)(6486002)(83380400001)(186003)(2616005)(66946007)(6916009)(66476007)(66556008)(4326008)(38100700002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VNHuYfoHjpgxxVChnEWUNDq9sHq6ajHTz2yO2bzwSbJ9E3+AAv55pwYABPcg?=
 =?us-ascii?Q?T0kHu30YA9xEwvS3N1Eh8yeUXy1ZBgo3cnJVlngpeU5PPQYDUVitiis4kQPX?=
 =?us-ascii?Q?5erS4xYNJ7AbX2wih1inzfkOdWTQJ4Fss86Zw7yX5kQgZYS5SYnazDPqGdKE?=
 =?us-ascii?Q?p+0xMNZWd3x912RU+63zTK6KZoerqJMp8UucSqihrQm+tshZ2/MCxlwmpueL?=
 =?us-ascii?Q?O8jwJYU3UKogDjuZk7np2bYyxmbYE3eQxkRG74XQVKT/gK4VdK+ZBpRCCSCH?=
 =?us-ascii?Q?SJ6X5bJ+o50BwfUEKNRIklis6KqtmpMLTmOqB+VgyV6gBiX0swikfsQw+Ru2?=
 =?us-ascii?Q?W2uwJ42ufmOIjg7pg6lhGt/TZW/XJUsU5MfjRwZ8XFlXuogCDo12irKpZIN8?=
 =?us-ascii?Q?pQs07J7/8nXdLfxDqlvhCCr03aYIuHGQ4YFw1i9Le0n3/Hntht0Pl2upKQ7Q?=
 =?us-ascii?Q?BW634iuaqpskBWKjBcAkcokLfrS4u4gnri2Vbc7R+/UGmuCfwBs6K1ockQAU?=
 =?us-ascii?Q?2bcegiAmNTxHK60D9fSwUsZ8M/vNxyxfqK2rfJ47sALRV7iIpj8Ih62TJ3+G?=
 =?us-ascii?Q?ggzEHkJlryFfZRNXdtgeXSekZs53TJieW/d8Pnt08rgWT243co7DOCZXAUDo?=
 =?us-ascii?Q?ni10yBqjfbwXpYnGDyQ87WXtw3RtAq+syQhtWwAxNj56R+1NLQDcwfifijCl?=
 =?us-ascii?Q?i8wJSINSE4SVciqwUAWD6H+sCggGZ7CP/9fN1dYULqdt8vGvr9phs4mbIxAn?=
 =?us-ascii?Q?KtT4bQD53ewzlAqTOvdZqgIMkh8nim0AyATNm2mBPeqPbq7E6fFTXrla9LAd?=
 =?us-ascii?Q?lMlI4FLC9bU95+ewtI3QUAGM5Ky05SLhf/yaIsyTYX7jAwFD/rOjmkaPqptP?=
 =?us-ascii?Q?1OWA0Q83wrrbEM3pwXMiJi2Q2fi3otYi1tmZq+BJs8VtNWK4ERbkAAV8Fyri?=
 =?us-ascii?Q?+IX89y/9PtJbHyqfJYIP/mNKnVbPHHSYgJsEMHamm5XyAh91fKsO7v52fpsR?=
 =?us-ascii?Q?vOVYscs1acB+glTBMIhfpuNyapIY9bcVjN5pfmBK3GZMl8rEw3Jtson/xUKg?=
 =?us-ascii?Q?rKh8XwhkfZnAIDORYimsFa8sB5aTstYRNVkwyS/3FnJ31XBEBmHAmJZAGMp3?=
 =?us-ascii?Q?2lDBPmA5++VGwI6Vapp8AIMyyRMl+ZbnLKuYB95j6gaz09BJ1ov7dK27MD/A?=
 =?us-ascii?Q?YH2WZhjunaf8eSS7TuI8w4630oCr7W723lK2GMnkSL3AlDS9pYsgcMXqUHX2?=
 =?us-ascii?Q?hG2KMXlJt5H0nS9sneLhTWfplWMn6eNMOsocXPL7XPrCGGdr3VOWrParrIGZ?=
 =?us-ascii?Q?3ozJ8/wFLoQ6J3FpbDv3ES9VSXFSVNR0BuNliTCWFrC7NAAvopQiLeCNu4Vh?=
 =?us-ascii?Q?LYEP5fAOJCtdyp6yvW6qMZCZoXeUI4nQEndAwGPEZQvmapacir+wlwTvU5lh?=
 =?us-ascii?Q?Sf0cdTvS7TcHpmsiX7J0bsm4ENNBh0difQ4z3j/h+EwIrLZyS88hTkUd8VqD?=
 =?us-ascii?Q?K1kCzj0RIe9Ekrl1DwZzHJbycVotYJIwFhhTWidibCOTCAM8Ce4q1vPgVdLE?=
 =?us-ascii?Q?cdJ5w7INGXyxIPlvRAnZR7eHhMf7XIEwVq6PwAPOTxPmMyyAziPk6vbf9lg2?=
 =?us-ascii?Q?ZYJ12zv9k3ynfNOU2CGMK9RqmtWPV82Pgg7up9BCAPrMWRPUTpSTpz/LbLy5?=
 =?us-ascii?Q?VcdGXQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489db9e3-dc0e-44f6-7f1b-08db8dd7adc7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:56:07.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEUzmeOCtLAQdG3nFsv9ZmtsrF1nWBy325dWSTEN8TnvoOHv5XLPSbhjBJmmia7j0LIIWtaQPWmtmYxMmrFhzHJu6ACXW/h4TF4Yv+i+UQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4633
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 01:47:02PM +0300, Dan Carpenter wrote:
> This is allocating the ARRAY_SIZE() instead of the number of bytes.  The
> array size is 1 or 2 depending on the .config and it should allocate
> 8 or 16 bytes instead.
> 
> Fixes: ddebc973c56b ("dccp: Lockless integration of CCID congestion-control plugins")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


