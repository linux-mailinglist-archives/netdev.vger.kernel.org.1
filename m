Return-Path: <netdev+bounces-31392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C778D5E3
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD84628125B
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B5C5224;
	Wed, 30 Aug 2023 12:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45B63CE
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 12:30:48 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2111.outbound.protection.outlook.com [40.107.249.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE8E107
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 05:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLRalfor65zCXyW1CKQpQizbLMgOIhGfJ3Is2fY9MBpyVLEK9At1JK41SqwQrPrjZDwwNAlX+DVonysS3ds3ughQyeQuDr0/8OQg71A+ixW5WNAQeJSXKGsIfpakomdattGx3zBOpcoqNt+8OcTdOaDDqWBQ3DHXFbce82lgVzqIbfYt4i3sP0CVmPZ6k/lA8Ouud6EgQ6Gc55LhuS7+Njqdr958DV21cDHnjXJePpniv8I+J6j2tjBlnK5g6Bd+2Y0UTDVcJJVht3x1EODSyECICesufbgqyKfv+OimSEmtERi8Kuqqb+MrMOkRLr0UpInz/0erEuLWuWgG/smRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC2opHfESS0dBB7rev7RrV0iGe4HpijAoHARfuSW8yo=;
 b=TPwJizg+xg1Kzs5VHptcuMcA7zIsVXseHN9Ef59CecPvD06i7PMNEp9Fjm2KP9pmBmC4bZMbRvAh/ZfZL95g5WOigUV4ph1uxc1BEzxGBtD7+BLGDYU36ex8B3206HiuiKnB1TpKFlAunqhOg5Hdz0ou70t74QmuW7bkwe61mVBk5p09PcfgjyZcca+NRZfFAHhkLmeuTgHYLUDdq2pusGhjy2XGYw6iqjXW+BZvsYFfUxP0iF9DQiPzcfjTyD2Nc/Oqitg3FUT0a8q/Mg2jrH6q/+2D+/6yR243RfdextHx3A/qodVTv+YkkOJWTnfTh/ZXLp2ZqVeBS4eGV83mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC2opHfESS0dBB7rev7RrV0iGe4HpijAoHARfuSW8yo=;
 b=OST13R+SV+dU8Xe51rfghS6603Nmu8CE/oLBvxtnWfh+oRH9IfsO1E+41GZcXhELI49Lck5sfpeDGMZGCoboRyL1+UxFdUII9cZzqLWy2SawVUeCkyzSGt2SGu2QE2oxVlFB5Mf/PRAlKVrjvOeFSV/3eIzN8HKnAMOfCGOzapeKdM4mEK+DGmg2B63OYQbwv9zaObMJ/5ZlAlcBKfhhBf1zmCxfX4BfGYYtYMs0PrEjzmOVJCOpnYDmOixoYenD6nbDsmnKHup/utchOLllmR/NIzMfo6v6Ty636VwXHIyf5g12D08T0GEXJvdloM6Twh6k2Rl+zQTzRsoiWfG0tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 12:30:44 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 12:30:44 +0000
Message-ID: <172898f6-56a7-6ce3-212c-a468f4ad6262@uclouvain.be>
Date: Wed, 30 Aug 2023 14:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 iproute2-next 1/2] tc: support the netem seed parameter
 for loss and corruption events
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
 <20230823100128.54451-2-francois.michel@uclouvain.be>
 <87y1hurv2f.fsf@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Fran=c3=a7ois_Michel?= <francois.michel@uclouvain.be>
In-Reply-To: <87y1hurv2f.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|AS8PR03MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: e1154b37-e587-466f-6d7c-08dba954ee0e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G7K1oqNUIlaaj07CPG4mre42QDnrYcKpS9XEQ7OPiiwYufsxTyYvDhbrXBpRZJhDTSv7k3ni3TC0KtkKozcKc5Xafx9WDwvmCg9KRTu/iH57Teii84PEVWr5oYOg9sFZ4HYQZ/NpjY0wHbTvOMDo0x9a5gyLD83yxQ4WqPMjzQA02EdYPN46gHawoSag4uDOUYlLukhoH6YAm5MreJAyqj7fQojlh4N/NqvzZf37C5Fyj1abOrda5Zi7uox7gklTXtJ5/q1ISek1nQ5ecJJLGNNj0kcwRDTr7x4GGBOqhrtuvFINYsJ6N0w0VpmhfAFY5QCGcjGGrpKqMSeQZi17Ef7Nfj2Y8DTdHILlSz1MOowUj4DyI2vgb6bAm9Nv/DJKsCRbG2MgTQQ4h9TXeQa/vmEgwhWnG6nR+y9W3GcG+ZbKl0ZeSXXmctvCvYTtn6au7qNqTZ0242KMB+/rIJDbRcq1Oo3TRd2Csw7bofvuBVImlSqmYQtJ7RoIlMUP13+hmkU+ajix4e7GrbEFgR4X+j2KADcmmjmq34ZdYlvaaXX6GsJx14v5Q4p8FnkEjTqnOb8Ge7Vf+PAiJYbsO/1Dbx3Ru/jaigHlS9PxXYWajdX+18ytiFow4Q7sCHDXetd7xy6yWnSvTExfQRTqxoPx+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(478600001)(31686004)(6506007)(66556008)(66946007)(66476007)(6486002)(6916009)(316002)(38100700002)(41300700001)(786003)(6512007)(8676002)(5660300002)(36756003)(83380400001)(2906002)(31696002)(2616005)(4744005)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ZvV1RIbGNDeE03by85S01qT1FYREJxd2FyWlZyQVA3KzdjMEtIRzAySXJw?=
 =?utf-8?B?akJjak1rSXFFcGMraGtNVVh4M205L3VGZWF4SXZJUjhsZzNIRS93aW1zcnVP?=
 =?utf-8?B?Y1dtZ0dyeVNOV3pTamR5aFc3dlFJbWFSVUhYWDZsc2diVHQ0eXlEVHhrOU1z?=
 =?utf-8?B?eWpzRkg3R2plMC9EMzd2b0gvSkl6Rzl5UTJaMVoxS2lDaWZ6T2dWZDFKbzUz?=
 =?utf-8?B?cDU4SlB0d3VqWHlFbFQ2RGRMQ25WWFZBcTJiUWFJdUNRWWx3VnlLZVBKZzRZ?=
 =?utf-8?B?L2xQWFYwa0FFTXdEOCtHTmF0c0p3cGhTVXREYVczcEhNS1NzdzhYYUd5eFpJ?=
 =?utf-8?B?eU1BY0dtSmlDL2JTeGVScGJNaU02UlBTTUdvOUJEUjNQeW1HcnNLUm5Hb1p5?=
 =?utf-8?B?WDN3bngySlNRK01sai9BNXg1eHpKTjNHL1QxbXhQd3c3aTlmTTluekZBb2ZU?=
 =?utf-8?B?eXBXTElOQVRYSWE4bHh5TmYxb09QSE5BTW1QcnlQaEdaNUMvbnZleHd3S012?=
 =?utf-8?B?VzlIWjhlVVBwdHpjY0ZIVGhXQnlHWWUrWmtBbUJZR3Q3dy9UTzI3M21kMlpH?=
 =?utf-8?B?ZEhUTGtNaW5BdkE2cjFNS1BsN20rRDhzWXdaNENWZ0hkUUFuKzlCTmkyLytp?=
 =?utf-8?B?SFJxcnB0M2ZVdWlzT0daQ1YxbnJwYkIzcnVzOVl1UlhqVWpkY1E3eHNMMWhm?=
 =?utf-8?B?YjFwNDdma09tUk1UMDRGTWZPSXRneWdNRFhpdjNRNFFlZWhmQ0dSdUpLTEVQ?=
 =?utf-8?B?U3hlNWtsSlJFa1VUQ011YWI0UE9CMlk4RVpLWHp0YUp6REg3ZmVpUCtDLzdz?=
 =?utf-8?B?d1MwYUUycjZVNkZpN2ZhM2xpa1hjUGRTVlBKYlhZdFdoVk9XYzFlZmJSRzBC?=
 =?utf-8?B?K2prcWlGYkJQV3VFRkJwUE9SVmI2YTVmbFl1dndQbDF3UkQrQzlHVFRPVGpq?=
 =?utf-8?B?c2cvMlFEVGp6azh1U1pZV0phQWtCUmVrcHVoTTJwdlJNTG5jOTRYZFlRMmFx?=
 =?utf-8?B?VTZ0MFNFSDNQNC9VOEVrbHprb25mcmVwbUZGSUlqWWpsZklVNGZxYWU1VG95?=
 =?utf-8?B?UWRsRXdLYlNpallSVU9qY3ptdTgraWM3M3N4QnRmeW8xaHQ0R2pLRHI0Z0sx?=
 =?utf-8?B?MlgyNUcwNUNZVnIrcHVtODNKejFKd3JoaE96Ry9BbGlacjc5TEZvWkJrSUtH?=
 =?utf-8?B?aTZ4N2NOMWlqTW9vSlJvb21ERHp6U1FUS0tpQU9lS2txK09oNmFNWlVqNkxJ?=
 =?utf-8?B?bHRyVGZJL2Iwa0NuR2ZUWldSNlZWRTRmS3Y3cGdxeFBiZ1prd0ozZ3prT01t?=
 =?utf-8?B?K1NrTllKMk9tVUdWdHRJd3Rma3Z4cU5lQ3V5aUx6VHM0dzUvQkRMczVqUnpZ?=
 =?utf-8?B?RUpUMlVuTjRtWUw0MVBxenBLVXNhNmNCYVBRMWlvakdvUm5DWFo4UUxLMGxV?=
 =?utf-8?B?ZnU5amY4STZnU1QxYzREcXJNTFA0TzlsZmp6WmlxTlVXV2NSUEZSMitJa2lS?=
 =?utf-8?B?RE5BVHQ0MXRXYm00cFprWHNEMFNJajF3ellrczFwcjNHTy9FbTJ6RUtQZW5j?=
 =?utf-8?B?b0svWUpTNHoraHdhaDRIejRiNzUzSXBmSTYzSlZKNGd1aXBSWFZWdkFza3Bj?=
 =?utf-8?B?QTl3NWZ1WWNUaTdvVk9PM1NJRUFvb3hiN2Fyb0JibU4wM3czUWJQcWlWb1JW?=
 =?utf-8?B?T3dxUUIxRHcreXIzVXcrNi93Q1FuWmh0UUJTWCszMnVnYVR0enhIRWFpMFlu?=
 =?utf-8?B?ak0yanpkZ2t0SVJha0RpdUlKajAxL3pmaFZlWHUxWGw4dEg0Wm91NkI1akdm?=
 =?utf-8?B?dTRGb25EOUxRTlltQ1N2dmkwYzYzbHFJVFgyeW5XK0Y5Ymx6Nkg0cVM5aTA1?=
 =?utf-8?B?WjczMjBtMEpsK0hqN0p1Qlc4ZkZWbUd1UjUyaTYxaExzRm1UaWJQY0JndkpZ?=
 =?utf-8?B?SU9mSlRqTDFPV0x4bU8xNlpyNmJTNUt3TTJrbFRWUXFUZWNTR1Qzc3ZXbHRS?=
 =?utf-8?B?NGZJSlVBZUtaYmFlbVBicFhobTA1N3lSRjRpZkptMU9zdzBiK2xCcXZzSXla?=
 =?utf-8?B?SmFib0tGODk3VUd2YXM4REhDaW1MVzkyRWgxWmllbnZtNEx2VXVOTHZmdTN5?=
 =?utf-8?B?alFJMUpIdUZlZkpIY1NXcW0rUW1VakhGaDRzelZSbUlDdk9wb1ZSa1o2VXJz?=
 =?utf-8?B?RjJKZmVxSmF6WllQckMyTDlUaGpaR01oSU5FMXFZWnBabTd3VjRYVk1ZR2pv?=
 =?utf-8?B?NkNxU0FvbjlTcE1HRlJwTlFGU1RnPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: e1154b37-e587-466f-6d7c-08dba954ee0e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 12:30:44.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9JIDKN8aAhA+RHGpALgyRd2spL7aEMHs+x+hoAvu4D0PzwQZ6t+59xA62m2lbpv9VdUhEicVBI9a03xKVrG+225qmiKW/ywerpI3/1R7lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7859
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Le 29/08/23 à 12:07, Petr Machata a écrit :
> Took me a while to fight my way through all the unreads to this, and
> it's already merged, but...
> 
> francois.michel@uclouvain.be writes:
> 
>> diff --git a/tc/q_netem.c b/tc/q_netem.c
>> index 8ace2b61..febddd49 100644
>> --- a/tc/q_netem.c
>> +++ b/tc/q_netem.c
>> @@ -31,6 +31,7 @@ static void explain(void)
>>   		"                 [ loss random PERCENT [CORRELATION]]\n"
>>   		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
>>   		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
>> +		"                 [ seed SEED \n]"
> 
> The newline seems misplaced.

Sorry for that, I don't know how I could have missed that.
Should I send a patch to fix this ?

François
> 
>>   		"                 [ ecn ]\n"
>>   		"                 [ reorder PERCENT [CORRELATION] [ gap DISTANCE ]]\n"
>>   		"                 [ rate RATE [PACKETOVERHEAD] [CELLSIZE] [CELLOVERHEAD]]\n"

