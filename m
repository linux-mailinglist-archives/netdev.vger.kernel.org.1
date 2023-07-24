Return-Path: <netdev+bounces-20409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B78F75F56D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D990F28121A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091E6130;
	Mon, 24 Jul 2023 11:48:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CE568D
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:48:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2119.outbound.protection.outlook.com [40.107.94.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD44E54
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 04:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxh/5MEsNRCxLs8aakilGI3qAKW0qBWEspeqRFp4Z9/t0C0zLSg0KBuL6M6LZ1POYpnv6SkP+ewgGFvALjVLK6TBU2gzPeIFx2t/8Ulq77W2CjLEouV1kxwiYA8FGgOTVxXHU+RAwneOEUejV/hBZ+H7Sli/z4Adp22QzkcX+N3QEv3m7aJu0hhOiATrDZMsRjn/2l0IR1tG657ObZIVGu9i/44jS6kvm72l6iI2uCflInoF/paUmYwnmmJZS9CmZCaS3l+AlWSNBai/4Kqn//ZmX5T3SnwsqUimLKZnZ2qIdoQmjbGwBBZIiMCCtS+/QxTWczBmHcTVpwW/zxWapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1+VYoEV+KLGjG/U1Ag6F8+CVcHzRGrO3yygVRlazec=;
 b=buaEK4dqZ57FY2bHpK/+0ESQqVxbgOhM0jiODCU1CAhiR3U/fcwaZ26a+Icz/3mM66d1vmIWG+U1K6nl1xU7X0bD3evuHBjxc05ce6AWzEj0YK/yJhtHLQdY+jREAFBJgiMrCvtaI6ADMjMi0mtLVnDpxz9NHWaeIY6WJd9SbYY8ttvMUSu+pqHliwrUfvV4yIaDjeMK0wsOSxsmLm71GAchsCUfTuXQ5dwf2RNTYCWShIE6RjnDdHI53/GtjTbjmyIwnE866R92tBLEX2NIUEQ017ukAHQca6LsyctgUukjS/60624rUka6ibBLwuy6EyOSBiE8nvZLXA8y1KZC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1+VYoEV+KLGjG/U1Ag6F8+CVcHzRGrO3yygVRlazec=;
 b=ip9bb7opGJY+xxT1IHarrGIupD+AKGg0C3N751adjA+8hm7Fi9SUqBN0NzNujf0nSASX3RsOtU7E7NWPuRBs6GYZ6xqKnumE3FUe1HBRrr17t2NGT/qO+lGsQeotTDYHOPEUp4W34FN6AbN2mlDoRLdjRD17+DevWviASd8Zsss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4041.namprd13.prod.outlook.com (2603:10b6:303:5e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:48:33 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 11:48:32 +0000
Date: Mon, 24 Jul 2023 13:48:14 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: kuba@kernel.org, aelior@marvell.com, davem@davemloft.net,
	edumazet@google.com, manishc@marvell.com, netdev@vger.kernel.org,
	pabeni@redhat.com, skalluru@marvell.com, drc@linux.vnet.ibm.com,
	abdhalee@in.ibm.com
Subject: Re: [Patch v3] bnx2x: Fix error recovering in switch configuration
Message-ID: <ZL5k/kTC6dNKjFo4@corigine.com>
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
 <20230719220200.2485377-1-thinhtr@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719220200.2485377-1-thinhtr@linux.vnet.ibm.com>
X-ClientProxiedBy: AS4P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 751a023a-e095-4b9e-9cc3-08db8c3be7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Euc0y1BjY3h5RloXUbxjRC9NoiUjFN5vC2IeiABTK4dG7V8FbcOhg+8ra+lVReVteg7Pw47hHw3nJmVKpBac+SudMUMH0/KEFojTmSm57ok4YOP9ugpNqGP3U7ckRrhbvnKGJRKs9EMQ8ktXmDe01FuNmnYBiqzZTjzIpX1Iaz0N+4HqR2l5Mu6EDksi6I6A0lbFvYFeAePW6/KzcbNZGe5m8J0hj7HEMKMbMdxzWrS3WlqXX7nXUz3GRLqo57b5JK+jF9V7C1mXjQ3q0yC4WVvxjJ9nccgCsyBAehCs6w27tJn18rCd1woS+8rdsy5PNN2zZkcEjC75LGxCk12H2m4ZWq7vKJTLPygauzY+en+tKnX2ZfIUTHLr0J0l/3nAbGrKKncDZ0h7U6yNKACCUGUu0DKOnqyS5+rTxsjr2pg4YQM4KY7lvqQ0Gx2BEskqNBNswgJMmq+bLrouM2/VlW55OknnRqsj71G/lnNEVd5r1/dzflAg+p3xeyxIoa7aAkHsoWTka3+cJmiAkJZ5LqNoXVR9ZmMbIhiWUnjDmJxl/rxpjAbgCSa21FlOH1r0uRn4xdElmk6UsREOqrM2NrjXsDge3THea+PHVU+7l8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39840400004)(136003)(376002)(451199021)(6666004)(8676002)(8936002)(6486002)(86362001)(316002)(36756003)(38100700002)(186003)(6506007)(7416002)(5660300002)(6512007)(44832011)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(2906002)(2616005)(83380400001)(478600001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2QSMVYubbGQIpybrsehPs8blSrVJzqBSlRbKkUGRlWfFq+wouE+o9e0K5WR?=
 =?us-ascii?Q?ruyEHsK8hhvAe1aiiCScyBc+kmmrk63CWOWISwZJP5wVHqas03J49vSnLxoJ?=
 =?us-ascii?Q?wx3o7lSyiLDrF9qMIxxf89PLwSpgLr03NsDpTk82opb+kUspCcdWEznovyGQ?=
 =?us-ascii?Q?+AV+G6Nx6A57bD/q/gt+WJ6YJujHkH2sTIi11VzPLWpC7P4qrX4kmvJrsVs7?=
 =?us-ascii?Q?DnV7+iwMHYuq3scSwBp/jDJ5/aE0tI8IWsYWA570Egnrel1dEyuN9RbR6M7I?=
 =?us-ascii?Q?I7Dc7Bq7onhjskV4Ds/K+DUrhu8whIRqfRtrIOfVz7kQMKacNnOREMxVbiaU?=
 =?us-ascii?Q?/SUfw0suyfiqmBHVaJjXzR6iXPA+igFnacb86HLFddRvPD1sz65j6mzYEIPe?=
 =?us-ascii?Q?VZFM9+A2w/cLXjcIOJBBbNlz7cAnYuU0JBZw65ik2tizo3CAd/NSp65CgeDd?=
 =?us-ascii?Q?DwAwg9veWe4girSQvErhfjZ9vIu//aGhwOCl8Yl8L1TgRxXRXDYlZfFZOZVU?=
 =?us-ascii?Q?QZzGPpfPaMxSFXNAxXQZ3oyV5UbfLsuQPjikVEY/W18uqaI6uBBQmAIsE+At?=
 =?us-ascii?Q?v1MiOZFBUQlmjbzsjfZK6mDUnNpfm0FmfOqSSkVTPIjZ8n4FUKNMBzUTmByk?=
 =?us-ascii?Q?YTJsDN54I7UVUfRLbPL7unVpBlJbnurrMVfgKPDsz0ZzlQGMSF9EAv/26cDy?=
 =?us-ascii?Q?YIzjdE8tS/uBOTQLeNsbbv0qVLKM0QCy08oY4IOmw6QmT5JkGcQ3DZglYwg2?=
 =?us-ascii?Q?jSXJDp+Ynl3ZOtm9J1X4LFswbFvqxRGqdti/bmgEmnpeo6ASkovjODysGb1R?=
 =?us-ascii?Q?zrFFEK8hHYAzPyVEMKUixs6LX4a+nuctnfSKAz+sbLvPKXlwTmiayKS7XRAz?=
 =?us-ascii?Q?69wN2xau2ilW3qo3i2CsOMlovRXkjwJb2s78OI85rJedY7LuECYzF/4Df0NN?=
 =?us-ascii?Q?Z7xf0p8Ng2oT/ViuIfy0BgwXD5fqUqL/hLshXiLjFoIyo3q218b8s+Mv8/aA?=
 =?us-ascii?Q?66K/6Rr2kRrHF6mB71cIH+CzPdxch1xOkgE+gRHhG8jvYtCgCHGJBuK5gz4S?=
 =?us-ascii?Q?NiElrjE16BP+OxdP6d3zb5syB6DTA/o2SAEGVc0fOeURlCf3hCc4w5guO9uE?=
 =?us-ascii?Q?FjBUANsuhlyO6uE4kVkUTqKnR0qKL+vn9oTGQ4+zjNPcm1pawSX4dQBW49i9?=
 =?us-ascii?Q?MEtiTO+3SSSqosAO9NYSQ7xnvVR6d+o1fVrct2D0nloLO/siosubHbRzMtXV?=
 =?us-ascii?Q?uRTbTCCibLNN0COHEt+nhBklAPEe3i5/fnVq6GadsyGyioaIQGHwCAZEi0OW?=
 =?us-ascii?Q?aVQF5Iuv+v0mABL/G+D9koIAkprYsxSNfGBSywgZLDGItcC+josRSV4Xv6QG?=
 =?us-ascii?Q?Yuf2Sv0IRLaVNbl6rfgdeWzrtLrsfTtAFDt0mEJ3GbbRDRfRavP2MMBan7US?=
 =?us-ascii?Q?XbHC9b1kjBJWqpBq3EbeppnxsQInYYprkMUW3KaJIun+yGoJoPVvO0ibFs7k?=
 =?us-ascii?Q?jkzLOzDOlFaMYCEyGIOYKKI1GI0ekYg0rNo+L8ZFUAHfH+oAIxZZOCDuUo/D?=
 =?us-ascii?Q?57Y4o8yvtTS+OGIWO3kpFHTDjT+H+Srgdy2MoDYX6yR94/oXEsNzPBIXWDqv?=
 =?us-ascii?Q?6bmkPqhKv8HDf0rGSFg8jNzBa1EXOwio2QNF6+D/ekTF1Hr/QEG3CQbi+kbs?=
 =?us-ascii?Q?rQXLtg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751a023a-e095-4b9e-9cc3-08db8c3be7af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 11:48:32.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X3Er1agm4EQU8pmJ0zYAzhq7THC/csKvPjw8cmJfkl6H5ASYPC8xuuEC7YBa4dpR1xlGqD75aSnmr8iaL1ngA/oLphmME97IYoBJFGZd78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4041
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:02:01PM +0000, Thinh Tran wrote:
> 
> As the BCM57810 and other I/O adapters are connected
> through a PCIe switch, the bnx2x driver causes unexpected
> system hang/crash while handling PCIe switch errors, if
> its error handler is called after other drivers' handlers.
> 
> In this case, after numbers of bnx2x_tx_timout(), the
> bnx2x_nic_unload() is  called, frees up resources and
> calls bnx2x_napi_disable(). Then when EEH calls its
> error handler, the bnx2x_io_error_detected() and
> bnx2x_io_slot_reset() also calling bnx2x_napi_disable()
> and freeing the resources.
> 
> 
> Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
> Reviewed-by: Manish Chopra <manishc@marvell.com>
> Tested-by: Abdul Haleem <abdhalee@in.ibm.com>
> Tested-by: David Christensen <drc@linux.vnet.ibm.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


