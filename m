Return-Path: <netdev+bounces-17095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087EF750523
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FAF1C20FC0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AE9200C1;
	Wed, 12 Jul 2023 10:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCD1F95A
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:51:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2136.outbound.protection.outlook.com [40.107.220.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F645E77
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkLjwgWspxeeYRlnOVZLCeOBUontQo7OO6tizmywUkoEDuw69gF9fLuFpb8+oxdceark0YtxTdi0LbElompoSsSB18ee7uxnosSqHp1e+PZw4vM++sqcxLBLY68WI7awIsO5kEAb0JsITXcGjYodKeILk092+GX+XcsdOwjfFKCvlEHx1Kk49mhqgY8ZYpPqfDI0VdJUTkQj0Hm1UNwb2/ZjZdeNxiaqB/ipedRNFT+3Idu+0hBDcrv6uxuz5ZPuuNhIX/DOXqDUMvhAVHvugauCxKjk7ahXiyK0938+QnhS0GV980PZDVy0Ij/yuSV/DTvpVApe6BuvmX+T8g1FTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOt2dan/IRVSxmoK5y0KQLZaF44IGqw3JG6aiAJeV9Y=;
 b=ip3abGuBePxg12cIrL2KhpEhsLcK17LK9/MHD7UzHc9WwBAvAir1QbAeCmKkB9THKkOdewO9YKjw3OuCspqIMQQWjr+3c9pdvqhxtIfimQGFPMHVXv+vIZKOZbvnV/q78yIlru16zhR/24+RooVFqeUw/9qcgjs3AXIjaT2CdsSF9fja69Ed1Cdhhi25bpaKmj8iYTl0D/pdcBDxDipkyUlsNcLH7JXw+LMpufhl4zPDSAGE/qPdc+6zXa8IKttpLsoek1/7e50APAI9v+2aXGs5dJn2m4zvTwxUNfkDt1qD8Bj8RmK9WjDHW2bKumJ+CRhCP/GP/nVXpxnhG254dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOt2dan/IRVSxmoK5y0KQLZaF44IGqw3JG6aiAJeV9Y=;
 b=LJxliqR1xAMC1U87VcBTmx4+ixRIGv9KvLMe0L19JHbMIZrGSos+5+ZZuMio30GpOMjksGEqX9vYNUVY90Ky5X8boaBTkZUo+gxJC0KGYJH12afmC5dlJ8PV50OLeld9RC3yvA+E1zebbDFu1uqk3LB6TYFG+UKXubo1EU3ydZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4761.namprd13.prod.outlook.com (2603:10b6:610:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 10:51:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 10:51:48 +0000
Date: Wed, 12 Jul 2023 11:51:38 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>, sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net-next] e1000e: Use PME poll to circumvent unreliable
 ACPI wake
Message-ID: <ZK6Fuu/26apf1DGq@corigine.com>
References: <20230710164213.2821481-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710164213.2821481-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: LNXP123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::29) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 38902077-9beb-48cd-1db5-08db82c5fe1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UaslAiX5DhklGNbvtG2XswBm+xHKo+E4Vb8lIF+6LkAgM2MQ6QVYD6w4hJww4YP2fC3+8hGy5GAXrBihhYXnemDspv/M5HKkQRQZ8uYdzlnOMDMYrzF4BEebZQ9k/WfsYct2+KY9l6fnW9Qcx4W/fkkyzqTnvTooJIRZfakVcwcN7n5w0T0U+ImGH+/YCNIKD8aNRZredbk8gtPCLtzDKD63/WIUGfciMjumu+DxA/MBTg5/wJMU3MHSCQNiD8MV0hue6ObdHDOEowx/KZ7N/GUw/fNTfxJ0RPIegAGtK0zitPEViRefNM+VCf01nzoNVUoxk5jUy5BUtRVi9c37maymvyfCmh0wWU5j3orC995Rzv606VndyY+P9veTWHyHf6relZDDy9viZc5TVgKlBoBFTPVQzxx+RHirYSW3mW2k3AigROxD4BpUWhNYmgTqa8gxxKsp9K+VI5UmIzpOIdzvuAsm53d7884wBWx+M/rC8a370AgEL2E0TtSa2fGaVXTAzbG4b1+A4uYNU8WGQ3AObs++f8uAPTZY0YWehN6t4SJ6DPE7jo8P5gXId+9cwjQFXEEfISJse6JmDaInoHterMc+6xzozqcHhm1Y9Z8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39840400004)(376002)(451199021)(6916009)(6486002)(83380400001)(4326008)(66476007)(66946007)(66556008)(478600001)(6666004)(6506007)(26005)(54906003)(38100700002)(41300700001)(6512007)(316002)(8936002)(8676002)(86362001)(5660300002)(44832011)(186003)(2906002)(2616005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZkyAniRWHtexV3144X56R0My7esMMvI2XwOyfBja7CFq9184oeDQTJj7tz5u?=
 =?us-ascii?Q?MHe+RP/kiK6H6kLDgJgU7yZVkV9bM8f7CVqt8v8qRqksx2C/9nihyyNmVruy?=
 =?us-ascii?Q?RAXkUYIEUC94LOCPSvtkGjp2XoZUq6LyLaqcrmP6ibcku/78tbA7Ax5vtZdM?=
 =?us-ascii?Q?dXHFKOpNVIWJ84PZ3TCAVi6KQBui8tIRoRQzdI3ZhztP6e0B7fWBoAiUrSdM?=
 =?us-ascii?Q?ZIHZFWJfr5vPfxI2u7meshl6Mr+0o2kGCPpBohnQl+Ie7BXqK0kTQqL2Ryke?=
 =?us-ascii?Q?3Rt9VGN8IXGN42KkmVDRMVgJtMK9PuBFz1in47BtucrdTtJ5PgvPI9rxAhfG?=
 =?us-ascii?Q?Nw8vdyA0CvP69kG835yqZ3u+kyrc2JmuxVyo0YLlXEzF8VvTEfvQWdeYLUR0?=
 =?us-ascii?Q?ZuQEhXuQFjIDwRrnsxzk03JJ5AG4JfSx24JKUUPSxrKvw3rY+zv3dZjy4OvF?=
 =?us-ascii?Q?oSUGqHn0k49rj2AtiJduhWgTTz53Ol2OISeBDbZQUjyq0yL5eDF7QvacKi19?=
 =?us-ascii?Q?+4JG0WhLYsGzwUJl4OGCEqkL3JSh6gE13Po7YpF7nGaROz0tu3Sp+zvediyR?=
 =?us-ascii?Q?zVIZwMRM3DFT+b6gY1yzttiAascVpApJJT2TIbAQV96mYmqJZ0xfB/V42QvG?=
 =?us-ascii?Q?wsTt+YhdkcoHko8w0ycv2X6Am/RI3Wp9Fg2yA+8mTk++p4/StVk28hyp6D44?=
 =?us-ascii?Q?Yf1xmtq4uPXpsvgCStp/4ISoCG81yElXS395QWYd90p+0Yc79OKgTzMopPOb?=
 =?us-ascii?Q?X2WOdQQrfLp74HAnuqP3DWD5B/n8P/wC85A6AYecrap9OIGEeTXlssp6lt1R?=
 =?us-ascii?Q?608MPZHVC8W1kz2zkGjDsruOirBj7LLJBhNf8qkFsRVwpvjrvP/EqZk2nh03?=
 =?us-ascii?Q?UrsjZwyKXa9XG311GkCn+LiaUYplubruBtjf8/0VNKNnS9QhucigsGSgeRhy?=
 =?us-ascii?Q?/gWIG+qCITIrzwaSuTV5fk9h8s47Wv955IDZ99vNw2ExnqAa+DvxuLvdoBAX?=
 =?us-ascii?Q?yGwUYnWpsM3qKVXuBG/QwwiiauJY5cQiIw7QiE4T71RKp5WsKj/WaBZrat2s?=
 =?us-ascii?Q?IA+DXV9EVGyXwLIQz3ChZc6VOmU90Gq+s+Js7KlgyJeiGYB2H2rMrkA4jFBb?=
 =?us-ascii?Q?DMPM7RiAEB7V1+ZkqEvFjtnBMZFXvvOnevlMr9iaIG/tLDx3nMAYA/heM0VI?=
 =?us-ascii?Q?WW1ucEWnN38VFJf3/6jkiVvfvSLL3wVq/U5R2nGxu0iVgtaJKpYGaWNdUyrA?=
 =?us-ascii?Q?bOW7CErmiZ5lNljhpa+R7FiA5tUgn7v3ELEagd4D2kJ3mB7u/bNl0bNHO98c?=
 =?us-ascii?Q?EXHObqSH03M/pgdqhrYRwPuIsQnqhMI3Hw8xrs6nocEMlo4hvzLP92xondkA?=
 =?us-ascii?Q?1CehG28x3ZBL7zCSvjaDeJi8FBiXwDz75kZr7EB3KhgP9R4NQPWgsYBN3+nA?=
 =?us-ascii?Q?dRoEgf2NabOSnYlIhfflDWMgIW3A5eqiVapJhzohIxtqpmopXntziuKlWeOZ?=
 =?us-ascii?Q?PuNxvKwFtHvF3a1I1uKyy9n3NFNY7BxehbamcLU8JC2HeZgMOttVjvw7GFWL?=
 =?us-ascii?Q?/6yaUkhS+SOPHCrD2L+VmNMsqzSOppVVx9F5t8C6fPx4PeGysHqTytnimUSe?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38902077-9beb-48cd-1db5-08db82c5fe1a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 10:51:48.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSKGFtTXVeshbrwQEcmFKnELkCJViB0REFcb8vb086/VWGDnn+MpYnloTlhQIoULcjp6Au3XM10Hx+ljtB5EBYN9JFv8t72Y3NDLv2eTO14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4761
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 09:42:13AM -0700, Tony Nguyen wrote:
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> On some I219 devices, ethernet cable plugging detection only works once
> from PCI D3 state. Subsequent cable plugging does set PME bit correctly,
> but device still doesn't get woken up.
> 
> Since I219 connects to the root complex directly, it relies on platform
> firmware (ACPI) to wake it up. In this case, the GPE from _PRW only
> works for first cable plugging but fails to notify the driver for
> subsequent plugging events.
> 
> The issue was originally found on CNP, but the same issue can be found
> on ADL too. So workaround the issue by continuing use PME poll after
> first ACPI wake. As PME poll is always used, the runtime suspend
> restriction for CNP can also be removed.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

