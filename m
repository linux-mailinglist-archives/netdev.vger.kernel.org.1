Return-Path: <netdev+bounces-32939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84FB79AB3F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91C81C20928
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B382F44;
	Mon, 11 Sep 2023 20:38:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99423D9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:38:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BAF1A7
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2BQ6mPics2gGWNd+TgdceshfA+QagnVVd04MsxCtgHZR1jHc/1IZMR8K6VxmgW2fnqONMmWt4myrazV/b4CkqdGpjy4mslW+uoZLlEkoXXoShy8k4J0S3a4/pYvrB/LONwgIJQkoD5+/2xSYcCVWy32JZe6EwCs2xY5x7U19HmeTf+2RbG3BmZ3h9mFlRPAiUEWI0XteX2fd05oVOVUjOy8vHhWTMzZ7Yrq3ZKZNvWU2A5bPiTn5/16xMQA81g7U/KNZEMUqXjzlbFEWXft+BKnvoTCA3iqbJESpL4wznHW2IpyPb8DO0Noih5ZuEnBpRq4z/kcUAH+VoZzL4bhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iqauZXULQoMqYZlpL/ux2THZxr0YFOHB6S4LIKIkJE=;
 b=QcObVXggdZWAytSuIQjlYLSZDKpPvAlWykW8X+SA6sjJ5wNddkrN1U9ZtwxpntzsWZoPPCYwRLMR8mueuDP2l1Dz5pzXXAVB4w8jV7TLXyQ07vBbsCGiSJ3hxMVS0qhAv9/SxQt8VDToA0IEUEx+2gpHMRJrW2eOO4qpTbsGdUvQQ1bP8C6z7Q59EaYy2vK3b0CJ1/2uX1ehffjI3JGV8zxvVQ/t7hl36HsnksdZMn6vCM04AfRpMs1n/Wd2Jg8xxwiui1OIWb9z7Fx8nLhJjCJEfGEwAHl0rHM4mXCtcVfU/aUhJypW3x4y3ZmenHfeCjLu1roAgEjnGZqCb85qvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iqauZXULQoMqYZlpL/ux2THZxr0YFOHB6S4LIKIkJE=;
 b=XdP/BDXf2Bn1w9CL3b1fZP5kuJY6jf6eJyfhx7HWOdEpg7s1JwS/4WySZ15+QRRd3s+l/cpxIeSxsc6wL+F1wJREJadjCffwvXxke0tUv5SNgoR2raMOozuQbtJFjYIGL4/5kapd1GNGyT0zFmSUt9XEXD20n1c+VqSkkiL4R8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 20:38:05 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.034; Mon, 11 Sep 2023
 20:38:05 +0000
Message-ID: <1781241b-cdf0-4389-a49e-53da456160e7@amd.com>
Date: Mon, 11 Sep 2023 13:38:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <71ddaadcbcca1dcf3cb38b3e29ba5b0b1027c281.camel@redhat.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <71ddaadcbcca1dcf3cb38b3e29ba5b0b1027c281.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::29) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8147091b-4594-4374-8a71-08dbb3070036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+AyzjAgP/qT9cIzm+YCAtyk9TNbpnUzgBlzbmvGRcNxLiAW8cYpJXpGb08rcS4SI4F2Qu/CrxJgX/Zb/RSKPASqMtXqNEPJGIhIfwB4ldvwdYarMXFnmFcvURZOvIo7PNckit0NR5SXZ1vJoR1TIvcFQ1XLBpOEnddS8Lccn+qsoA9v4LCVzytg6InueIb+SozmVw2HyUzmmU+lSlOfwhQ4DYupNBr03i1/wgXIMON6gIt7gCdeDmwfvrA46SXyg1h0lrh+X1OPxtEer3RD/iGJmHci6c0Olov4T0dcKPXN93j39Mq5oAFSohB7GD4tTSn1f73m2uIot2r6NfY9OgJYLZMaLxmFovvbuWYbOadgZN0EVsfeIgqsI0R0BwoQ32CwYuLE7Xgnq57N5hOrzAAwxY1uwkGSgugXn6Eu4/1NW/PToh6gliawc63k0c3iQfMoxnKjdn4CndCslX1BA510LQY1kUxQiLxwal5TF2p8wrYRzrF2wWm4VC6JlKDT6VmwPx6Br4nXroswKsvHxSCSQ3DNftYaSPncruTf7MkCBslLY7TezsSHTKHMQ9ccf3nNbjxAQLxnE0122zNVldQSdr+74z9dPqNRA8cyUhI395pZuFgzvHxlC3CR7rux3BPn+Nb5r3PQQWSG2dzRkxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(186009)(1800799009)(451199024)(6666004)(53546011)(6506007)(6486002)(478600001)(26005)(2906002)(966005)(4744005)(41300700001)(316002)(66556008)(66946007)(66476007)(8676002)(5660300002)(8936002)(36756003)(2616005)(6512007)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVhOSEhXa0NBeHZTMisvdStqZnY0WGdndUNtckpDRjF5UGVrZWFNb0szY2Fl?=
 =?utf-8?B?TUFsYnpFMk5Qbk1xQ1Jzd3daVURFUGhvblZHTFhKMW03VjhOYlhCZUJGZ3Jv?=
 =?utf-8?B?ZnUrckZjRUdjaE0vRHVEVUsreG1kekUvYXVQL2l6TTJYNVRYVGlyQnNzaWRD?=
 =?utf-8?B?SkwxOC9vL3BudFNSWTBmenNZMDZUandFYVJXdXRSS2RERG1TNUIyTEVuWUZ5?=
 =?utf-8?B?Rkl2UHJnWFVFMXptaVFLSmNxWUNKWUdFNSs0dGtGN0c0YXBpbS9FOUxTMXRk?=
 =?utf-8?B?ZzhPb1B6TzBQMFN0Y3Y5bmMvVXgzV3FqYllqMmMyMmZkVDMxaUNmeCtGTS81?=
 =?utf-8?B?Rndmc1BCR2lNbEw3SWdrR0VJU0R5VlFUOXhieEI3MkpZb1VGaHpXa3p3MGJJ?=
 =?utf-8?B?b3RCbTRsR1lPY085bll5bXVTMWc5bWg3VDJjbk5RWVd1bXAzMERHZE8vMC9J?=
 =?utf-8?B?d2hlMWFlSVhlU25ib1djQ3RRQ3d4Y0ovcVoxcXlPWnh1MnNHQW03eFBmelR3?=
 =?utf-8?B?cDJRekhoSHlhbWE0bXBCZmJlcGdNM3piandjbWlSNzIxeUk1VFE3b2RNUXgz?=
 =?utf-8?B?U3lQbUR5UXFNa1UrMUV3OC9zTmtwYTdITnExYWdNcm9NU1NpVnBCWHlUQWc3?=
 =?utf-8?B?Y3JlUUViRTAzSjlHdElPeEh4MWRjT0NZUFdyTlRuMk0zWk5TVVl4TTl0cnNT?=
 =?utf-8?B?SnhrcndEemZidkFDK1JXR1ZzY2h2cnc1VjhJYmNrU2FGWjdMQ3pPMG1MLzZD?=
 =?utf-8?B?cFdJR0w2UjcwSnpsM3ozS29KOEVKRHNOY2RMeHFTY3FQTHFaVk5kVHlwTVdx?=
 =?utf-8?B?Wm14bS80RHhaeG1sRXFVNXlOSzA4eUZtaENYS053bDN5MTBrYlpWSm5FcE5s?=
 =?utf-8?B?K2MrKzBibDYvc1RJanlxdm5IVldMT01ITnpheUdSdHpDSXVubmQrQ0FYSmx4?=
 =?utf-8?B?dCtCS1lXeEU4SVhIZkh4aUMxNGhVTjlXZGkrOWxXWElYbW1uY01paWIvUHRM?=
 =?utf-8?B?M3FudTZQbFplOXRtcjRkWXVQVitKUTNMM1FSUEowWW9lRGdhWE16RkVNSlJ2?=
 =?utf-8?B?VDg2dFF5cVFLUm10TkN1OVhaZHZmMUh0UTI5UHdxa3Y0Z3lVWkx5SU9UZjF0?=
 =?utf-8?B?WFg2TExYam5lRjNIOUdEcExpd20wN2JFTVBxeDJHQmgyLzYxRDF0bVoxQ3Zh?=
 =?utf-8?B?eGJyZG1FaE0wYVhhRmNpYm9qSGg0aS9TVVI3c0VoQ0ZjanJwcHBHWTA4a2VU?=
 =?utf-8?B?L2V3SDZTNXdwOEVpK2JYTWlSL25TNndONXZPeFJ1VXhKVk14QVFySEFWVURl?=
 =?utf-8?B?Z2o0SWpmVGRXZDhoTnM3Mm5pcm0wdGpLWXFDa1VqV1dLdDB0bmpJYWRNL3JJ?=
 =?utf-8?B?M2N5cU5YenhLVjZIVE9OWTU0SENwN1ZvUDEzeHNYM2tabytUbmZHN2w5aXRR?=
 =?utf-8?B?MkFIZiswQTc5WFk4T29oY0w4WExDSWdtVFBaM3grNjZ1MzJ0Q09OOTFCVWcw?=
 =?utf-8?B?MnpsejdRM1JwSzBDeHpqUjV3OVd0WVFSQ1VQY3ZXV01tNzlDVlRsRGlFSTlD?=
 =?utf-8?B?N25NRTRSUnpJVTVLQ0hkQ0tVOFljYWduazFXMmxiMFdkUTlqMllGMXpBamh0?=
 =?utf-8?B?RkNaSDB1S3dxUlNRSERmejRjV29iRjk5alQrTVNQaUswZlF2N0dwWWg4QkFH?=
 =?utf-8?B?bFNoeXhOWkpxUDhueHlocXBJTFppSG1QemF3NXJmZElJMm9JU0kzTkRVODEr?=
 =?utf-8?B?dWttS2t6dTF4ZW1sUUJJano0Z0RIRitRNXBackRIQVhRekxoeWFrTytoSGVl?=
 =?utf-8?B?aWZtUVVrR0V5THhrK00rMm9UZkYwazh4NXhWOVVrTWg2d0VLb2ptd0t6dlpL?=
 =?utf-8?B?VEt0MGlzQzFjbWxDZ0tWTmx1eTB6MHBIc3NxWjl5R0dET1MwSm4ycjhxaUZ4?=
 =?utf-8?B?NGlsVkhtSjV5cW1MVDhqaVhXYlBCc0pWcWdrWXB3cE9wVENXM2FmVmluVE1M?=
 =?utf-8?B?RVdaZUVnQm56NEVPbkoyOS84dzRUdmdERFRyN2dWa01zTWE0ejdqMFovc0xS?=
 =?utf-8?B?cThvb1krOTZXOWlUR0M0TjlIbm1MY3NlenUyNDdjZzltQkZnNFRlNVAxUjNt?=
 =?utf-8?Q?fpdKmO98LA6XJqG+sWjC9ROj0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8147091b-4594-4374-8a71-08dbb3070036
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:38:05.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UP0x0EjRrSin898MN5lE48uEyuiWMH0RZFzUm7uInts1scthOZYt/LgjamCr10xaHcw2UfqBtUfbOJWBjVHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/11/2023 1:17 PM, Paolo Abeni wrote:
> 
> Hi,
> 
> net-next is open again, and accepting changes for v6.7.
> 
> Please note that the location of the "status" page is:
> https://patchwork.hopto.org/net-next.html
> 
> 

Thanks!

Also, https://netdev.bots.linux.dev/net-next.html works much better for 
us with strict corporate filters.

sln

